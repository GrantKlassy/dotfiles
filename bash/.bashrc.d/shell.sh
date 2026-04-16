# shellcheck shell=bash

# History
shopt -s histappend
HISTFILESIZE=1000
HISTSIZE=1000

# PATH
PATH=$PATH:/usr/local/sbin:/usr/sbin

# Completions
# shellcheck source=/dev/null
[ -f /etc/bash_completion ] && source /etc/bash_completion
# shellcheck source=/dev/null
[ -f ~/.bash_functions ] && source ~/.bash_functions
# shellcheck disable=SC2154,SC1090
[ -f ~/.git-completion.bash ] && . "$_"
