if ! command -v brew >/dev/null 2>&1; then
  case "$OSTYPE" in
    darwin*)
      if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
      fi
      ;;
    linux*)
      if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      fi
      ;;
  esac
fi

path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  /opt/nvim
  $path
)

export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-$EDITOR}"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'
else
  export FZF_DEFAULT_COMMAND='find . -type f'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} \
  --height=70% \
  --layout=reverse \
  --border=rounded \
  --info=inline \
  --prompt='❯ ' \
  --pointer='›' \
  --marker='◆' \
  --color=bg+:#1F2335,bg:#111318,spinner:#E6C384,hl:#7E9CD8,fg:#DCD7BA,header:#7FB4CA,info:#727169,pointer:#E6C384,marker:#98BB6C,fg+:#DCD7BA,prompt:#957FB8,hl+:#7E9CD8,border:#54546D"
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --color=always {} | head -200'"
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind '?:toggle-preview'
"

if command -v fzf >/dev/null 2>&1 && [ -t 0 ]; then
  source <(fzf --zsh)
fi

# Initialize Atuin after fzf so Ctrl-r remains the history-search binding.
if command -v atuin >/dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi
