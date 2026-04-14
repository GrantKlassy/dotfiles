#!/bin/bash
set -euo pipefail

PROG=$(basename "$0")
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DRY_RUN=false
FORCE=false

usage() {
  cat <<EOF
Usage: $PROG [OPTIONS]

Deploy dotfiles from this repo to the home directory.

Options:
  -h, --help      Show this help
  -n, --dry-run   Show what would be done without doing it
  -f, --force     Overwrite existing drop-in files

What it does:
  1. Creates ~/.bashrc.d/ and copies drop-in shell fragments into it
  2. Adds a sourcing block to ~/.bashrc (backs up first, skips if already present)
  3. Copies rc/vimrc to ~/.vimrc (skips if exists, --force to overwrite)
EOF
  exit 0
}

ARGS=$(getopt -o hnf --long help,dry-run,force -n "$PROG" -- "$@")
eval set -- "$ARGS"

while true; do
  case "$1" in
    -h|--help) usage ;;
    -n|--dry-run) DRY_RUN=true; shift ;;
    -f|--force) FORCE=true; shift ;;
    --) shift; break ;;
    *) usage ;;
  esac
done

info()   { printf '  %s\n' "$*"; }
skip()   { printf '  SKIP  %s\n' "$*"; }
action() { printf '  ->    %s\n' "$*"; }

SOURCING_BLOCK='# Source drop-in configs
if [ -d ~/.bashrc.d ]; then
  for f in ~/.bashrc.d/*.sh; do
    [ -r "$f" ] && source "$f"
  done
fi'
MARKER='# Source drop-in configs'

# ------------------------------------------------------------------
# 1. Deploy bashrc.d/
# ------------------------------------------------------------------
echo "bashrc.d/"

if $DRY_RUN; then
  action "would create ~/.bashrc.d/"
else
  mkdir -p ~/.bashrc.d
  action "ensured ~/.bashrc.d/ exists"
fi

for src in "$REPO_DIR"/bashrc.d/*.sh; do
  name=$(basename "$src")
  dest="$HOME/.bashrc.d/$name"

  if [ -f "$dest" ] && ! $FORCE; then
    skip "$name already exists (use --force to overwrite)"
  else
    if $DRY_RUN; then
      action "would copy $name -> $dest"
    else
      cp "$src" "$dest"
      action "copied $name -> $dest"
    fi
  fi
done

# ------------------------------------------------------------------
# 2. Inject sourcing block into ~/.bashrc
# ------------------------------------------------------------------
echo ""
echo ".bashrc"

if [ ! -f ~/.bashrc ]; then
  if $DRY_RUN; then
    action "would create ~/.bashrc with sourcing block"
  else
    printf '%s\n' "$SOURCING_BLOCK" > ~/.bashrc
    action "created ~/.bashrc with sourcing block"
  fi
elif grep -qF "$MARKER" ~/.bashrc; then
  skip "sourcing block already present"
else
  if $DRY_RUN; then
    action "would back up ~/.bashrc and append sourcing block"
  else
    backup="$HOME/.bashrc.bak.$(date +%s)"
    cp ~/.bashrc "$backup"
    action "backed up ~/.bashrc -> $backup"
    printf '\n%s\n' "$SOURCING_BLOCK" >> ~/.bashrc
    action "appended sourcing block to ~/.bashrc"
  fi
fi

# ------------------------------------------------------------------
# 3. Deploy vimrc
# ------------------------------------------------------------------
echo ""
echo "vimrc"

vimrc_src="$REPO_DIR/rc/vimrc"
if [ ! -f "$vimrc_src" ]; then
  skip "rc/vimrc not found in repo"
elif [ -f ~/.vimrc ] && ! $FORCE; then
  skip "~/.vimrc already exists (use --force to overwrite)"
else
  if $DRY_RUN; then
    action "would copy rc/vimrc -> ~/.vimrc"
  else
    cp "$vimrc_src" ~/.vimrc
    action "copied rc/vimrc -> ~/.vimrc"
  fi
fi

echo ""
echo "done."
