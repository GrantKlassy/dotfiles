# shellcheck shell=bash

# Color
alias ls='ls -b --color'
alias la='ls -lah --color'
alias grep='grep --color=yes'

# Misc
alias src='cd ~/src'
alias h='history'
alias m='mount | column -t | less -S'
alias k='kubectl'
alias reload='source ~/.bashrc'
alias perms='stat -c "%a %A %G:%U %n" ./* | column -t'
