# dotfiles

chezmoi, Homebrew, mise, Antidote, Starship を軸にした macOS / Ubuntu 共通の dotfiles です。

## 構成

```text
.
├── Brewfile
├── install.sh
├── .chezmoi.toml.tmpl
├── .chezmoiignore
├── dot_zshrc
├── dot_zprofile.tmpl
├── dot_gitconfig.tmpl
├── dot_zsh_plugins.txt
├── dot_config/
│   ├── nvim/
│   ├── wezterm/
│   ├── starship.toml
│   ├── git/
│   ├── mise/
│   └── zsh/
├── private_dot_ssh/
├── run_once_before_01-install-homebrew.sh.tmpl
├── run_once_before_02-install-packages.sh.tmpl
└── scripts/
```

## 初回セットアップ

```sh
curl -fsSL https://raw.githubusercontent.com/Taiga2022/dotfiles/main/install.sh | sh
```

手動で進める場合:

```sh
brew install chezmoi
chezmoi init --apply git@github.com:Taiga2022/dotfiles.git
```

Apple Silicon は `/opt/homebrew`、Intel Mac は `/usr/local`、Ubuntu は Linuxbrew の `/home/linuxbrew/.linuxbrew` を自動検出します。

## Brewfile

Homebrew は CLI/GUI と dotfiles の土台だけを管理します。Node.js、Go、Python、Rust は Homebrew では管理しません。

```sh
brew bundle --file Brewfile
brew bundle dump --force --file Brewfile
```

## chezmoi

```sh
chezmoi diff
chezmoi apply
chezmoi edit ~/.zshrc
chezmoi status
```

設定値は初回 `chezmoi init --apply` 時に `git.name` と `git.email` を入力します。再設定する場合は `~/.config/chezmoi/chezmoi.toml` を編集してください。

## mise

グローバルのランタイム固定はしません。各プロジェクトで `mise.toml` を置きます。

```sh
mise use node@lts
mise use go@latest
mise use python@latest
mise use rust@latest
```

個人用の上書きは `mise.local.toml` を使い、リポジトリには入れません。

## Antidote

プラグインは `dot_zsh_plugins.txt` に追加します。

```text
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
Aloxaf/fzf-tab
zsh-users/zsh-syntax-highlighting
```

変更後は新しい zsh を起動するか、以下を実行します。

```sh
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.txt.zsh
source ~/.zshrc
```

## Zsh

`.zshrc` は読み込み専用の薄い入口です。

- `~/.config/zsh/aliases.zsh`
- `~/.config/zsh/completion.zsh`
- `~/.config/zsh/functions.zsh`
- `~/.config/zsh/history.zsh`
- `~/.config/zsh/tools.zsh`

Starship, zoxide, atuin, fzf, mise は存在する場合だけ初期化します。

## WezTerm

`dot_config/wezterm/` で管理します。既存の GruvboxDarkHard、leader key、pane、tab、copy/search keybind を維持しています。フォントは修正前と同じく WezTerm のデフォルトに任せています。

## LazyVim

`dot_config/nvim/` で管理します。LazyVim の bootstrap と lockfile を含め、既存の Neovim 設定を chezmoi 配下へ移動しています。

## ロールバック

適用前に差分を確認します。

```sh
chezmoi diff
```

直前の Git 状態へ戻す場合:

```sh
git restore .
```

ホームディレクトリ側を戻す場合は、chezmoi の Git 履歴で戻した後に再適用します。

```sh
chezmoi cd
git log --oneline
git revert <commit>
chezmoi apply
```
