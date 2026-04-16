# shellcheck shell=bash

# History
shopt -s histappend
HISTFILESIZE=1000
HISTSIZE=1000

# PATH
PATH=$PATH:/usr/local/sbin:/usr/sbin

# Completions
[ -f /etc/bash_completion ] && source /etc/bash_completion
[ -f ~/.bash_functions ] && source ~/.bash_functions
# shellcheck disable=SC2154
[ -f ~/.git-completion.bash ] && . "$_"
