# Claude Context

## What This Repo Is
Personal dotfiles/configuration repository for setting up new machines. Contains:
- `bashrc.d/` - drop-in shell fragments (aliases, functions, prompt, etc.)
- `rc/` - full reference bashrc and vimrc configs
- `scripts/setup.sh` - deployment script with `--dry-run` and `--force` flags
- `mac/MAC.md` - List of Mac programs to install with links
- `windows/WINDOWS.md` - List of Windows programs to install with links

## bashrc.d/ Approach
Shell config uses a drop-in directory pattern instead of whole-file replacement:
- `scripts/setup.sh` copies `bashrc.d/*.sh` to `~/.bashrc.d/` and injects a sourcing block into `~/.bashrc`
- The existing `~/.bashrc` (e.g. Fedora defaults) is preserved, not replaced
- Each drop-in file is independent and can be added/removed without touching `~/.bashrc`
- `rc/bashrc` is kept as a full reference config

## File Format for Program Lists
The MAC.md and WINDOWS.md files use this format:
```markdown
- [Program Name](https://official-url.com/) - Brief description of what it does
```

## Git Commit Messages
Always use 1-3 words, all lowercase. No co-authored-by lines or lengthy descriptions.
