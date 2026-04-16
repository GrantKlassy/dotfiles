# dotfiles

On July 31st 2018, I made the [initial commit](https://github.com/GrantKlassy/dotfiles/commit/40716567f4ba9581121cddefa0df5dbc53ef6ac8) to this repo which I called "linux-configs". Since then, the tooling around dotfiles and configs has improved significantly, and I have renamed this repo and kept storing my configs here while also updating with modern tooling.

Personal configuration files for setting up new machines quickly. Covers shell, editor, and OS-specific tooling across Linux, macOS, and Windows.

Managed with [GNU Stow](https://www.gnu.org/software/stow/) — each top-level directory is a "stow package" whose contents mirror `$HOME`. Running `stow bash` symlinks every file under `bash/` to the matching path in `~/`.

## What's Here

```
bash/                stow package for shell (~/.bashrc.d/*.sh)
vim/                 stow package for editor (~/.vimrc)
rc/                  reference full-file configs (not deployed)
scripts/setup.sh     bootstrap wrapper around stow
mac/MAC.md           curated Mac program list
windows/WINDOWS.md   curated Windows program list
```

### Shell (`bash/`)

Drop-in shell fragments that get sourced from `~/.bashrc` without replacing it. Each file is independent:

- `aliases.sh` — color output, kubectl, misc shortcuts
- `functions.sh` — `lines`, `targz`, `epoch`
- `prompt.sh` — PS1 with git branch, `set_title`
- `shell.sh` — history, PATH, completions
- `macos.sh` — macOS-specific setup (no-op on Linux)

### Editor (`vim/.vimrc`)

- Filetype detection for Terraform, YAML, Markdown, cfengine
- `vim-plug` scaffolded with curated plugin list
- Explicit indent control — no auto-indent surprises

### Program Lists

Curated lists of essential tools for [Mac](mac/MAC.md) and [Windows](windows/WINDOWS.md) workstations.

## Setup

Install Stow (once per machine):

```bash
# Fedora/RHEL
sudo dnf install stow
# Debian/Ubuntu
sudo apt install stow
# macOS
brew install stow
# Arch
sudo pacman -S stow
```

Then deploy:

```bash
git clone git@github.com-gk:GrantKlassy/dotfiles.git
cd dotfiles

# Preview what would change
./scripts/setup.sh --dry-run

# Deploy all packages
./scripts/setup.sh

# Replace existing regular files (backs them up with timestamp)
./scripts/setup.sh --force

# Install a single package
./scripts/setup.sh bash

# Uninstall (remove symlinks)
./scripts/setup.sh --uninstall
```

### What `setup.sh` does

1. Verifies GNU Stow is installed
2. For each package, replaces any pre-existing regular files at target paths (backing them up) so `stow` can symlink cleanly
3. Runs `stow -R` to create/refresh symlinks from the package into `$HOME`
4. Injects a `~/.bashrc.d/*.sh` sourcing block into `~/.bashrc` — but only if one isn't already there (Fedora's default `~/.bashrc` has this natively; we skip on those systems)

### Using Stow directly

If you prefer, skip `setup.sh` and call stow yourself:

```bash
stow -v -R -t "$HOME" bash vim   # install/refresh
stow -v -D -t "$HOME" bash vim   # uninstall
```

`setup.sh` just adds the collision-handling and `.bashrc` injection on top.

## Adding a new package

1. Create a top-level directory named after the tool (e.g. `tmux/`)
2. Place files inside it exactly as they'd live under `$HOME`, e.g. `tmux/.tmux.conf`
3. Add the directory name to the `PACKAGES=(...)` array in `scripts/setup.sh`
