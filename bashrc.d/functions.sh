# shellcheck shell=bash

# Usage: lines 2  -> prints two blank lines
#        lines 5  -> prints five blank lines
lines() {
  local n="${1:-1}"
  [[ "$n" =~ ^[0-9]+$ ]] || { printf 'usage: lines <nonnegative integer>\n' >&2; return 2; }
  for ((i = 0; i < n; i++)); do
    printf '\n'
  done
}

# Create .tar.gz of a directory
targz() {
  local cmd="tar cvzf ${1%%/}.tar.gz ${1%%/}/"
  echo "$cmd"
  eval "$cmd"
}

# Print/convert epoch timestamps
# No args: print current epoch
# With args: convert each from epoch to human-readable
epoch() {
  if [[ $# -eq 0 ]]; then
    date +%s
  else
    for arg in "$@"; do
      date -d "@${arg}"
    done
  fi
}
