#!/bin/sh

# Errorの場合に停止
set -e

# Homebrewのインストールチェックとインストール
if [ ! -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
# ディストリビューションの確認
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
else
    OS=$(uname -a)
fi

case "$OS" in
    "Ubuntu" | "Debian GNU/Linux")
        echo "Setting up for Ubuntu/Debian..."
        sudo apt update
        sudo apt install -y build-essential
        ;;

    *)
        echo "OS not supported. You might need to manually install the required packages."
        ;;
esac

# ~/.zshrc にHomebrewの設定を追加
CURRENT_SHELL=$(echo "$SHELL")
if [ "$CURRENT_SHELL" = "/bin/bash" ]; then
    CONFIG_FILE="$HOME/.bashrc"
elif [ "$CURRENT_SHELL" = "/bin/zsh" ]; then
    CONFIG_FILE="$HOME/.zshrc"
else
    CONFIG_FILE="$HOME/.profile"
fi

if ! grep -q 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' "$CONFIG_FILE"; then
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "$CONFIG_FILE"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# 現在のシェルがBashやshの場合、Zshをインストールしシェルを変更
if [ "$CURRENT_SHELL" = "/bin/bash" ] || [ "$CURRENT_SHELL" = "/bin/sh" ]; then
    echo "Changing shell to zsh..."
    brew install zsh
    chsh -s $(which zsh)
fi

# GitHubへのSSH認証チェック
if ! ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
    echo "[Error] SSH authentication to GitHub failed. Installing GitHub CLI..."
    brew install gh
    echo "Please authenticate with GitHub CLI using 'gh auth login' and then re-run the script."
    gh auth login || { echo "Authentication failed. Exiting..."; exit 1; }
fi

if [ ! -d ~/dotfiles ]; then
    cd ~
    git clone git@github.com:Taiga2022/dotfiles.git
fi

brew bundle -v --file ~/dotfiles/Brewfile

if [ ! -d ~/.config ]; then
    mkdir ~/.config/
fi

stow -v -d ~/dotfiles/packages -t $HOME zsh config

echo "Setup completed successfully!"
