alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --icons'
  alias ll='eza -lah --icons --git'
  alias la='eza -a --icons'
  alias tree='eza --tree --icons'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
elif command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
fi

if command -v fd >/dev/null 2>&1; then
  alias fdfind='fd'
elif command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

alias accy='acc submit -s -- -y'

if [ -x "$HOME/francinette/tester.sh" ]; then
  alias francinette="$HOME/francinette/tester.sh"
  alias paco="$HOME/francinette/tester.sh"
fi
