# dotfiles

Code last updated @ [2026-04-20](https://github.com/GrantKlassy/dotfiles/commits/main)

Originally committed [July 31st 2018](https://github.com/GrantKlassy/dotfiles/commit/40716567f4ba9581121cddefa0df5dbc53ef6ac8) as "linux-configs". This repo contains my personal configs for shell, editor, and OS tooling across Linux, macOS, and Windows.

Managed with [GNU Stow](https://www.gnu.org/software/stow/) --- each top-level directory is a stow package whose contents mirror `$HOME`.

## Layout

```
bash/                stow package (~/.bashrc.d/*.sh)
vim/                 stow package (~/.vimrc)
rc/                  reference configs (not deployed)
scripts/setup.sh     bootstrap wrapper around stow
mac/MAC.md           Mac program list
windows/WINDOWS.md   Windows program list
```

## Setup

```bash
# Install stow (dnf/apt/brew/pacman)
sudo dnf install stow

git clone git@github.com-gk:GrantKlassy/dotfiles.git
cd dotfiles
./scripts/setup.sh
```

Flags: `--dry-run`, `--force` (backs up colliding files), `--uninstall`, or pass a single package name.

## Adding a package

1. Create a top-level dir named after the tool (e.g. `tmux/`)
2. Place files as they'd live under `$HOME` (e.g. `tmux/.tmux.conf`)
3. Add the dir to `PACKAGES=(...)` in `scripts/setup.sh`
