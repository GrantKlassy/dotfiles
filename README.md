# dotfiles

Personal configuration files for setting up new machines quickly. Covers shell, editor, and OS-specific tooling across Linux, macOS, and Windows.

## What's Here

```
bashrc.d/    drop-in shell fragments (aliases, functions, prompt, etc.)
rc/          full reference configs (bashrc, vimrc)
scripts/     setup script for deploying to a new machine
mac/         curated Mac program list
windows/     curated Windows program list
```

### Shell (bashrc.d/)

Drop-in shell fragments that get sourced from `~/.bashrc` without replacing it. Each file is independent:

- `aliases.sh` — color output, kubectl, misc shortcuts
- `functions.sh` — `lines`, `targz`, `epoch`
- `prompt.sh` — PS1 with git branch, `set_title`
- `shell.sh` — history, PATH, completions
- `macos.sh` — macOS-specific setup (no-op on Linux)

The original `rc/bashrc` is kept as a full reference config.

### Setup

```bash
git clone git@github.com-gk:GrantKlassy/dotfiles.git
cd dotfiles

# Preview what would change
./scripts/setup.sh --dry-run

# Deploy (backs up ~/.bashrc before modifying)
./scripts/setup.sh

# Overwrite existing drop-in files
./scripts/setup.sh --force
```

The setup script:
1. Copies `bashrc.d/*.sh` into `~/.bashrc.d/`
2. Appends a sourcing block to `~/.bashrc` (idempotent, backs up first)
3. Copies `rc/vimrc` to `~/.vimrc`

### Editor (vimrc)

- Filetype detection for Terraform, YAML, Markdown, cfengine
- Plugin manager (vim-plug) scaffolded with curated plugin list
- Explicit indent control — no auto-indent surprises

### Program Lists

Curated lists of essential tools for [Mac](mac/MAC.md) and [Windows](windows/WINDOWS.md) workstations, each with a link and short description.
