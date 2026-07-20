mkcd() {
  mkdir -p -- "$1" && cd -- "$1"
}

take() {
  mkcd "$@"
}
