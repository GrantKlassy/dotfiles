# dotfiles

Code last updated @ [2026-04-24](https://github.com/GrantKlassy/dotfiles/commits/main)

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

## Prerequisites: install Task

Every repo in this directory drives its workflows through [Task](https://taskfile.dev). Install it once, then use the `task local:*` commands below.

On any POSIX system (Linux, macOS, BSD) the official installer drops a static binary into a directory of your choice:

```bash
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin
```

Make sure `~/.local/bin` is on your `$PATH`. Distro packages also work:

- Fedora/RHEL: `sudo dnf install go-task`
- Debian/Ubuntu: `sudo apt install task` (recent releases) or use the install script
- macOS: `brew install go-task`
- Arch: `sudo pacman -S go-task`

Verify with `task --version`.

## Setup

```bash
git clone git@github.com-gk:GrantKlassy/dotfiles.git
cd dotfiles
task local:install
```

## Tasks

| Command | What it does |
| --- | --- |
| `task local:install` | `sudo dnf install stow` (if missing) and deploy every package |
| `task local:dryrun` | Preview what install would do --- no changes |
| `task local:force` | Deploy, replacing colliding regular files (timestamped `.bak`) |
| `task local:delete` | Back up `~/.bashrc` and `~/.vimrc` to `/tmp/dotfiles-backup-<ts>/`, unstow everything, then remove the originals |

For finer-grained control --- single package, custom flags --- call `./scripts/setup.sh` directly. See `./scripts/setup.sh --help`.

## Adding a package

1. Create a top-level dir named after the tool (e.g. `tmux/`)
2. Place files as they'd live under `$HOME` (e.g. `tmux/.tmux.conf`)
3. Add the dir to `PACKAGES=(...)` in `scripts/setup.sh`
