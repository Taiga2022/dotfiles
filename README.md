# dotfiles

macOS / Ubuntu に、いつもの開発環境を再現するための dotfiles。
[chezmoi](https://www.chezmoi.io/) で設定を同期し、Homebrew でツールを導入します。

## Features

- ワンコマンドで Homebrew、CLI、GUI アプリ、設定ファイルをセットアップ
- macOS（Apple Silicon / Intel）と Ubuntu / Linux に対応
- Zsh + Antidote + Starship、Neovim（LazyVim）、WezTerm を構成
- mise でプロジェクトごとの言語ランタイムを管理
- HackGen Nerd Font をOSに応じた方法で導入
- Git、Codex、外部Agent Skillsを環境ごとに復元

## Requirements

- macOS または Ubuntu / Linux
- インターネット接続
- 対話入力できるターミナル
- Ubuntuでは、必要に応じて `sudo` を実行できること

Homebrewに必要なビルドツールは、セットアップ中に自動で準備します。

## Quick start

```sh
curl -fsSL https://raw.githubusercontent.com/Taiga2022/dotfiles/main/install.sh | sh
```

セットアップでは、Homebrewとchezmoiの導入、設定の適用、`Brewfile`の同期を順に行います。
初回はGitの名前とメールアドレスを尋ねます。GitHub CLIが未認証の場合は、ブラウザ認証と
SSH鍵の作成・登録も案内します。

> 適用前に内容を確認したい場合は、リポジトリをcloneして `install.sh` とchezmoiの
> run scriptを確認してください。

### 別のリポジトリから導入する

```sh
DOTFILES_REPO=https://github.com/your-name/dotfiles.git \
DOTFILES_SSH_REPO=git@github.com:your-name/dotfiles.git \
sh install.sh
```

- `DOTFILES_REPO`: chezmoiが最初に取得するURL
- `DOTFILES_SSH_REPO`: 適用後に設定するGitのremote URL

### 手動セットアップ

```sh
brew install chezmoi
chezmoi init --apply https://github.com/Taiga2022/dotfiles.git
gh auth login --hostname github.com --git-protocol ssh --web
git -C "$(chezmoi source-path)" remote set-url origin git@github.com:Taiga2022/dotfiles.git
```

## What is included

| Category | Tools / settings |
| --- | --- |
| Shell | Zsh, Antidote, Starship, zoxide, atuin, fzf |
| Editor | Neovim, LazyVim, tree-sitter-cli |
| Terminal | WezTerm, HackGen Nerd Font |
| CLI | ripgrep, fd, bat, eza, delta, lazygit, jq, gh |
| Runtime | mise, uv |
| Configuration | Git, Codex, SSH, Starship, WezTerm |
| Agent tools | Serena, Context7, external Agent Skills |

パッケージの正確な一覧は [`Brewfile`](./Brewfile) を参照してください。

### OS-specific behavior

- macOS: WezTermとHackGen Nerd FontをHomebrew Caskで導入
- Linux: WezTermは既存の環境を利用し、HackGen Nerd Font v2.10.0を
  `~/.local/share/fonts/` へ導入
- Homebrewの場所は `/opt/homebrew`、`/usr/local`、
  `/home/linuxbrew/.linuxbrew` から自動検出

## Daily workflow

| Task | Command |
| --- | --- |
| ソースディレクトリへ移動 | `chezmoi cd` |
| 差分を確認 | `chezmoi diff` |
| 設定を適用 | `chezmoi apply` |
| 状態を確認 | `chezmoi status` |
| 管理対象を編集 | `chezmoi edit ~/.zshrc` |
| chezmoiの設定を編集 | `chezmoi edit-config` |

基本的な更新フローは次のとおりです。

```sh
chezmoi cd
git pull --rebase
chezmoi diff
chezmoi apply
```

パッケージを追加・変更した場合は、`Brewfile`を更新してから適用します。

```sh
brew bundle --file Brewfile
chezmoi apply
```

## Configuration notes

### Zsh

`.zshrc`は入口だけにし、履歴、補完、ツール初期化、alias、関数を
`~/.config/zsh/`以下へ分割しています。プラグイン一覧は
`.zsh_plugins.txt`で管理します。

### Git

`.gitconfig`はchezmoiテンプレートです。初回入力した`user.name`と`user.email`を使い、
Neovim、delta、global ignore、`zdiff3`などを設定します。

### mise

グローバルの言語ランタイムは固定しません。プロジェクトごとの`mise.toml`で指定します。

```sh
mise use node@lts
mise use python@latest
```

個人用の上書きには、Git管理されない`mise.local.toml`を使います。

### Nerd Font

WezTermの表示フォントは`HackGen Console NF`です。macOSでは`Brewfile`、Linuxでは
`run_onchange_after_03-install-hackgen-font.sh.tmpl`が同じフォントを管理します。
Linux側のバージョンを更新するときは、スクリプト内の`version`を変更して
`chezmoi apply`を実行してください。

### Codex and Agent Skills

`~/.codex/config.toml`はテンプレートとして同期します。Context7はmiseのNode.js、Serenaは
uvを使って復元します。外部Skillsはリポジトリへコピーせず、インストール元から再取得します。

認証情報、セッション、履歴、ログ、キャッシュ、SQLiteデータベース、Codex組み込みの
`skills/.system/`は管理しません。

## Repository layout

```text
.
├── Brewfile                         # Homebrew packages
├── install.sh                       # bootstrap script
├── dot_config/                      # ~/.config/
│   ├── nvim/
│   ├── wezterm/
│   └── zsh/
├── private_dot_codex/               # ~/.codex/
├── private_dot_ssh/                 # ~/.ssh/
├── run_once_before_01-*.sh.tmpl     # Homebrew bootstrap
├── run_onchange_before_02-*.sh.tmpl # package sync
└── run_onchange_after_*.sh.tmpl     # fonts and tools
```

`README.md`、`install.sh`、`Brewfile`、`.git/`など、ホームディレクトリへ配置しないものは
`.chezmoiignore`で除外しています。

## Rollback

適用前は`chezmoi diff`で変更を確認できます。適用後に戻す場合は、chezmoiの
ソースリポジトリで対象コミットをrevertして再適用します。

```sh
chezmoi cd
git revert <commit>
chezmoi apply
```
