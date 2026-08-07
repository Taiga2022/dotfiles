autoload -Uz compinit

zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
zcompdump_check="${zcompdump}.last-check"
mkdir -p "${zcompdump:h}"

# Rebuild completion metadata daily; use the cached fast path otherwise.
if [ -r "$zcompdump" ] &&
   [ -r "$zcompdump_check" ] &&
   [ -n "$(find "$zcompdump_check" -mtime -1 -print -quit 2>/dev/null)" ]; then
  compinit -C -d "$zcompdump"
else
  if compinit -d "$zcompdump"; then
    : >| "$zcompdump_check"
  fi
fi
unset zcompdump_check

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
if [ -n "${LS_COLORS:-}" ]; then
  zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
else
  zstyle ':completion:*' list-colors \
    'di=38;5;110' \
    'ln=38;5;116' \
    'ex=38;5;114' \
    'pi=38;5;173' \
    'so=38;5;176' \
    'bd=38;5;173' \
    'cd=38;5;173'
fi
