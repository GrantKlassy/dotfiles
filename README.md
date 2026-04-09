# dotfiles

Personal configuration files for setting up new machines quickly. Covers shell, editor, and OS-specific tooling across Linux, macOS, and Windows.

## What's Here

```
rc/          bashrc, vimrc
mac/         curated Mac program list
windows/     curated Windows program list
```

### Shell (bashrc)

- Cross-platform — detects macOS and adapts (Homebrew, bracketed paste, mouse accel fix)
- Custom PS1 with git branch display
- Utility functions: `epoch`, `targz`, `lines`, `set_title`
- Aliases for color output, kubectl, history tweaks

### Editor (vimrc)

- Filetype detection for Terraform, YAML, Markdown, cfengine
- Plugin manager (vim-plug) scaffolded with curated plugin list
- Explicit indent control — no auto-indent surprises

### Program Lists

Curated lists of essential tools for [Mac](mac/MAC.md) and [Windows](windows/WINDOWS.md) workstations, each with a link and short description.
