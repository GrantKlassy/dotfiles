# Claude Context

## What This Repo Is
Personal dotfiles/configuration repository for setting up new machines. Managed with [GNU Stow](https://www.gnu.org/software/stow/) --- each top-level directory is a stow package that mirrors `$HOME`.

Contents:
- `bash/` --- stow package: `bash/.bashrc.d/*.sh` → `~/.bashrc.d/*.sh`
- `vim/` --- stow package: `vim/.vimrc` → `~/.vimrc`
- `rc/` --- reference full-file configs (not deployed)
- `scripts/setup.sh` --- wrapper around stow with dry-run, force, uninstall flags
- `mac/MAC.md` / `windows/WINDOWS.md` --- program install lists

## Stow Convention
Each stow package mirrors the user's home directory. To add a new config:
1. Create a top-level dir named after the tool (e.g. `tmux/`)
2. Place files exactly as they'd live under `$HOME` (e.g. `tmux/.tmux.conf`)
3. Add the dir name to `PACKAGES=(...)` in `scripts/setup.sh`

Stow refuses to overwrite existing regular files. `setup.sh` handles this: `--force` backs up any colliding regular file with a timestamped `.bak` and then lets stow create the symlink.

## bashrc.d/ Approach
Shell config uses a drop-in directory pattern. `bash/.bashrc.d/*.sh` gets stowed to `~/.bashrc.d/*.sh`, which is then sourced by `~/.bashrc`. Fedora's default `~/.bashrc` sources `~/.bashrc.d/*` natively --- `setup.sh` detects any existing reference to `~/.bashrc.d` and skips injecting its own sourcing block to avoid double-sourcing.

Each drop-in file is independent. `rc/bashrc` is kept as a standalone reference only; it is not deployed.

## File Format for Program Lists
The MAC.md and WINDOWS.md files use this format:
```markdown
- [Program Name](https://official-url.com/) - Brief description of what it does
```

## Git Commit Messages
Always use 1-3 words, all lowercase. No co-authored-by lines or lengthy descriptions.
