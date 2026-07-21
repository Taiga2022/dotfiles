#!/bin/sh
set -eu

if [ "${DOTFILES_REPO+x}" = x ]; then
  repo="$DOTFILES_REPO"
  ssh_repo="${DOTFILES_SSH_REPO:-}"
else
  repo="https://github.com/Taiga2022/dotfiles.git"
  ssh_repo="${DOTFILES_SSH_REPO:-git@github.com:Taiga2022/dotfiles.git}"
fi

install_build_tools() {
  case "$(uname -s)" in
    Darwin)
      if ! xcrun --find clang >/dev/null 2>&1; then
        xcode-select --install || true
        echo "Xcode Command Line Toolsのインストール完了後、再実行してください。" >&2
        exit 1
      fi
      ;;
    Linux)
      if ! command -v apt-get >/dev/null 2>&1; then
        echo "Unsupported Linux package manager: apt-get is required" >&2
        exit 1
      fi

      if ! command -v cc >/dev/null 2>&1 ||
         ! command -v ps >/dev/null 2>&1 ||
         ! command -v curl >/dev/null 2>&1 ||
         ! command -v file >/dev/null 2>&1 ||
         ! command -v git >/dev/null 2>&1; then
        if [ "$(id -u)" -eq 0 ]; then
          apt-get update
          apt-get install -y build-essential procps curl file git
        elif command -v sudo >/dev/null 2>&1; then
          sudo apt-get update
          sudo apt-get install -y build-essential procps curl file git
        else
          echo "sudo is required to install Linux build tools" >&2
          exit 1
        fi
      fi
      ;;
  esac
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  case "$(uname -s)" in
    Darwin|Linux)
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ;;
    *)
      echo "Unsupported OS: $(uname -s)" >&2
      exit 1
      ;;
  esac
}

load_homebrew() {
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

install_build_tools
install_homebrew
load_homebrew

brew install chezmoi
chezmoi init --apply "$repo"

case "$ssh_repo" in
  git@github.com:*|ssh://git@github.com/*)
    if ! gh auth status --hostname github.com >/dev/null 2>&1; then
      if [ ! -r /dev/tty ]; then
        echo "GitHub authentication requires an interactive terminal" >&2
        exit 1
      fi
      gh auth login --hostname github.com --git-protocol ssh --web </dev/tty
    else
      gh config set git_protocol ssh --host github.com
    fi
    ;;
esac

if [ -n "$ssh_repo" ]; then
  git -C "$(chezmoi source-path)" remote set-url origin "$ssh_repo"
fi
