# dotfiles

macOS / Ubuntu で同じ開発環境を再現するための dotfiles です。設定の適用は
[chezmoi](https://www.chezmoi.io/) に任せ、パッケージ管理は Homebrew、シェル環境は
Zsh + Antidote + Starship、言語ランタイムは mise を使います。

## できること

- Homebrew が未導入ならインストールする
- `Brewfile` にある CLI ツールと WezTerm をまとめて入れる
- `.zshrc`、`.zprofile`、`.gitconfig`、Neovim、WezTerm、Starship、mise などの設定を配置する
- 初回セットアップ時に Git の `user.name` / `user.email` を入力して、環境ごとの値として保存する

## 対象環境

- macOS
  - Apple Silicon: `/opt/homebrew`
  - Intel Mac: `/usr/local`
- Ubuntu / Linux
  - Linuxbrew: `/home/linuxbrew/.linuxbrew`

上記の Homebrew パスは自動検出します。

## 初回セットアップ

初回取得には HTTPS を使うため、GitHub の SSH 設定前でも実行できます。適用後、
GitHub CLI がブラウザ認証と SSH 鍵の設定を対話形式で案内します。

```sh
curl -fsSL https://raw.githubusercontent.com/Taiga2022/dotfiles/main/install.sh | sh
```

このスクリプトは次の順で実行します。

1. C コンパイラーなど、Homebrew に必要なビルドツールを準備
2. Homebrew がなければインストール
3. `brew install chezmoi`
4. HTTPS で `chezmoi init --apply` を実行
5. `git.name` と `git.email` を入力
6. chezmoi の hooks で `brew bundle --file Brewfile` を実行
7. GitHub CLI が未認証なら、ブラウザ認証と SSH 鍵の作成・登録を案内
8. chezmoi のソースリポジトリの `origin` を SSH URL に変更

取得元を変えたい場合は `DOTFILES_REPO` を指定します。この場合、`origin` は指定した
URL のままです。取得後に別の SSH URL へ切り替える場合は、併せて
`DOTFILES_SSH_REPO` を指定します。

```sh
DOTFILES_REPO=https://github.com/your-name/dotfiles.git \
DOTFILES_SSH_REPO=git@github.com:your-name/dotfiles.git \
sh install.sh
```

手動で進める場合は次の通りです。

```sh
brew install chezmoi
chezmoi init --apply https://github.com/Taiga2022/dotfiles.git
gh auth login --hostname github.com --git-protocol ssh --web
git -C "$(chezmoi source-path)" remote set-url origin git@github.com:Taiga2022/dotfiles.git
```

## 日常の使い方

dotfiles を変更するときは、chezmoi のソースディレクトリで編集します。

```sh
chezmoi cd
```

適用前に差分を確認します。

```sh
chezmoi diff
```

問題なければホームディレクトリへ反映します。

```sh
chezmoi apply
```

現在の適用状況を確認します。

```sh
chezmoi status
```

ホームディレクトリ側のファイルから編集したい場合は、chezmoi 経由で開きます。

```sh
chezmoi edit ~/.zshrc
chezmoi apply
```

## 管理している主な設定

```text
.
├── Brewfile
├── install.sh
├── .chezmoi.toml.tmpl
├── .chezmoiignore
├── dot_zprofile.tmpl
├── dot_zshrc
├── dot_zsh_plugins.txt
├── dot_gitconfig.tmpl
├── dot_config/
│   ├── git/
│   ├── mise/
│   ├── nvim/
│   ├── starship.toml
│   ├── wezterm/
│   └── zsh/
├── private_dot_codex/
├── private_dot_ssh/
├── run_once_before_01-install-homebrew.sh.tmpl
├── run_onchange_before_02-install-packages.sh.tmpl
├── run_onchange_after_03-install-codex-tools.sh.tmpl
└── run_onchange_after_04-install-agent-skills.sh.tmpl
```

`README.md`、`install.sh`、`Brewfile`、`.git/`、`.serena/` は `.chezmoiignore`
で除外しているため、ホームディレクトリには配置しません。

## Homebrew

`Brewfile` で dotfiles の土台になるツールを管理します。

- chezmoi
- mise
- antidote
- starship
- zoxide
- atuin
- ripgrep / fd / bat / eza
- git-delta / lazygit
- jq / gh / fzf
- uv
- neovim / tree-sitter-cli
- WezTerm

`nvim-treesitter` がパーサーをインストール・更新するには、`tree-sitter` CLI と
PATH 上の C コンパイラーが必要です。セットアップ時に、macOS では Xcode Command
Line Tools、Ubuntu では `build-essential` を自動的に準備します。必要に応じて、
インストールの確認や `sudo` のパスワード入力が発生します。

パッケージを追加したら `Brewfile` を更新してから適用します。

```sh
brew bundle --file Brewfile
chezmoi apply
```

現在の Homebrew 状態から `Brewfile` を作り直す場合は次を使います。

```sh
brew bundle dump --force --file Brewfile
```

## Codex

`~/.codex/config.toml` を chezmoi テンプレートとして管理し、プロジェクトの trust 設定、
機能フラグ、MCP サーバー設定を複数環境で再現します。ホームディレクトリの絶対パスは
`{{ .chezmoi.homeDir }}` へ置き換えています。

`auth.json`、セッション、履歴、ログ、キャッシュ、SQLite データベース、および Codex が
提供する `skills/.system/` は管理しません。自作スキルを追加した場合だけ、個別に
dotfiles へ追加します。

Context7 は `mise x node@lts` 経由で実行し、グローバルの Node.js を固定しません。
Serena は Homebrew の `uv` と `uv tool install -p 3.13 serena-agent` で復元します。

外部スキルは本体をコピーせず、Skills CLI でインストール元から復元します。Node.js は
`mise x node@lts` で一時的に用意するため、グローバルランタイムとして固定しません。

- `vercel-labs/skills`: `find-skills`
- `mattpocock/skills`: `grill-me`、`grilling`

## Zsh

`.zshrc` は薄い入口にして、実際の設定は `~/.config/zsh/` に分けています。

- `history.zsh`: 履歴設定
- `completion.zsh`: 補完設定
- `tools.zsh`: 外部ツールの初期化
- `aliases.zsh`: alias
- `functions.zsh`: 関数

Starship と Antidote は存在する場合だけ初期化します。Antidote のプラグイン一覧は
`dot_zsh_plugins.txt` で管理します。

```text
zsh-users/zsh-autosuggestions
zsh-users/zsh-completions
Aloxaf/fzf-tab
zsh-users/zsh-syntax-highlighting
```

プラグインを変更した後は、新しい zsh を起動するか次を実行します。

```sh
antidote bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.txt.zsh
source ~/.zshrc
```

## Git

`.gitconfig` はテンプレートです。初回 `chezmoi init --apply` のときに入力した
`git.name` と `git.email` を使って生成します。

主な設定は次の通りです。

- デフォルトブランチは `main`
- エディタは `nvim`
- pager / diff 表示は `delta`
- global ignore は `~/.config/git/ignore`
- merge conflict style は `zdiff3`
- `git push` は upstream を自動設定

Git の名前とメールアドレスを変更したい場合は、chezmoi の設定を編集してから再適用します。

```sh
chezmoi edit-config
chezmoi apply
```

## mise

この dotfiles ではグローバルの言語ランタイムを固定しません。Node.js、Go、Python、
Rust などはプロジェクトごとの `mise.toml` で指定します。

```sh
mise use node@lts
mise use go@latest
mise use python@latest
mise use rust@latest
```

個人用の上書きは `mise.local.toml` を使い、リポジトリには含めません。

## Neovim

`dot_config/nvim/` で LazyVim ベースの設定を管理します。`lazy-lock.json` も含めて
chezmoi で同期します。

## WezTerm

`dot_config/wezterm/` で端末設定を管理します。`wezterm.lua` から keybind 設定を読み込みます。

## ロールバック

適用前なら差分確認だけで止められます。

```sh
chezmoi diff
```

chezmoi ソース側の変更を Git の直前状態へ戻す場合は、変更内容を確認してから戻します。

```sh
chezmoi cd
git status
git restore <file>
```

すでに適用した変更を戻す場合は、chezmoi ソースの Git 履歴を戻してから再適用します。

```sh
chezmoi cd
git log --oneline
git revert <commit>
chezmoi apply
```
