#!/bin/bash
set -euo pipefail

PROG=$(basename "$0")
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
DRY_RUN=false
FORCE=false
UNSTOW=false

# Top-level stow packages. Each mirrors $HOME.
PACKAGES=(bash vim)

usage() {
  cat <<EOF
Usage: $PROG [OPTIONS] [PACKAGE...]

Deploy dotfiles via GNU Stow. Each stow package is a top-level directory
whose contents mirror \$HOME (e.g. bash/.bashrc.d/ -> ~/.bashrc.d/).

Options:
  -h, --help      Show this help
  -n, --dry-run   Show what would happen without changing anything
  -f, --force     Replace existing regular files at target paths (backs up first)
  -u, --uninstall Remove the symlinks stow created (stow -D)

Packages (default: all): ${PACKAGES[*]}

Examples:
  $PROG                 # install every package
  $PROG bash            # install just bash
  $PROG -n -f           # dry-run, including forced replacements
  $PROG -u              # uninstall everything
EOF
  exit 0
}

ARGS=$(getopt -o hnfu --long help,dry-run,force,uninstall -n "$PROG" -- "$@")
eval set -- "$ARGS"

while true; do
  case "$1" in
    -h|--help)      usage ;;
    -n|--dry-run)   DRY_RUN=true; shift ;;
    -f|--force)     FORCE=true; shift ;;
    -u|--uninstall) UNSTOW=true; shift ;;
    --)             shift; break ;;
    *)              usage ;;
  esac
done

if [ $# -gt 0 ]; then
  PACKAGES=("$@")
fi

info()   { printf '  %s\n' "$*"; }
skip()   { printf '  SKIP  %s\n' "$*"; }
action() { printf '  ->    %s\n' "$*"; }

if ! command -v stow >/dev/null 2>&1; then
  cat >&2 <<EOF
ERROR: GNU Stow is not installed.

Install it:
  Fedora/RHEL:   sudo dnf install stow
  Debian/Ubuntu: sudo apt install stow
  macOS:         brew install stow
  Arch:          sudo pacman -S stow
EOF
  exit 1
fi

for pkg in "${PACKAGES[@]}"; do
  echo "== $pkg =="

  if [ ! -d "$REPO_DIR/$pkg" ]; then
    skip "package $pkg/ does not exist"
    continue
  fi

  if $UNSTOW; then
    if $DRY_RUN; then
      action "would run: stow -n -D -d $REPO_DIR -t $HOME $pkg"
      stow -v -n -D -d "$REPO_DIR" -t "$HOME" "$pkg" 2>&1 | sed 's/^/        /'
    else
      stow -v -D -d "$REPO_DIR" -t "$HOME" "$pkg"
      action "unstowed $pkg"
    fi
    continue
  fi

  # stow refuses to overwrite existing regular files. Handle them up-front.
  while IFS= read -r -d '' src; do
    rel="${src#"$REPO_DIR/$pkg/"}"
    dest="$HOME/$rel"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      if $FORCE; then
        backup="$dest.bak.$(date +%s)"
        if $DRY_RUN; then
          action "would back up $dest -> $backup"
          action "would remove $dest so stow can symlink"
        else
          cp "$dest" "$backup"
          rm "$dest"
          action "backed up $dest -> $backup"
        fi
      else
        skip "regular file at $dest (use --force to replace)"
      fi
    fi
  done < <(find "$REPO_DIR/$pkg" -type f -print0)

  if $DRY_RUN; then
    action "would run: stow -n -R -d $REPO_DIR -t $HOME $pkg"
    stow -v -n -R -d "$REPO_DIR" -t "$HOME" "$pkg" 2>&1 | sed 's/^/        /' || true
  else
    stow -v -R -d "$REPO_DIR" -t "$HOME" "$pkg"
    action "stowed $pkg"
  fi
done

# ------------------------------------------------------------------
# Ensure ~/.bashrc sources ~/.bashrc.d/*.sh
# Skip if any existing ~/.bashrc.d/ reference is already present
# (Fedora's default .bashrc does this natively).
# ------------------------------------------------------------------
if [[ " ${PACKAGES[*]} " == *" bash "* ]] && ! $UNSTOW; then
  echo "== .bashrc sourcing =="

  # shellcheck disable=SC2016
  SOURCING_BLOCK='# Source drop-in configs
if [ -d ~/.bashrc.d ]; then
  for f in ~/.bashrc.d/*.sh; do
    [ -r "$f" ] && source "$f"
  done
fi'

  # shellcheck disable=SC2016
  if [ ! -f ~/.bashrc ]; then
    if $DRY_RUN; then
      action "would create ~/.bashrc with sourcing block"
    else
      printf '%s\n' "$SOURCING_BLOCK" > ~/.bashrc
      action "created ~/.bashrc with sourcing block"
    fi
  elif grep -qE '(~|\$HOME)/\.bashrc\.d' ~/.bashrc; then
    skip "$HOME/.bashrc already sources $HOME/.bashrc.d/"
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
fi

echo ""
echo "done."
