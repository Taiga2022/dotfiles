#!/bin/sh
set -eu

repo="${DOTFILES_REPO:-git@github.com:Taiga2022/dotfiles.git}"

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

install_homebrew
load_homebrew

brew install chezmoi
chezmoi init --apply "$repo"
