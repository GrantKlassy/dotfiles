# shellcheck shell=bash

parse_branch() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local branch
    branch=$(git symbolic-ref --short -q HEAD)
    printf " {git: %s}" "$branch"
  fi
}

# Colored prompt with git branch
export PS1="★★★ \[\033[01;31m\]\u@\h\[\033[00m\] ★★★ \[\033[01;34m\]\W\[\033[00m\]\$(parse_branch) ★★★ \$ "

# Terminal window title
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'

# Save original so set_title can revert
if [[ -z "${_ORIGINAL_PROMPT_COMMAND_SAVED}" ]]; then
  _ORIGINAL_PROMPT_COMMAND_SAVED=1
  ORIGINAL_PROMPT_COMMAND="$PROMPT_COMMAND"
fi

# Usage: set_title "TITLE"  -> sets static title
#        set_title           -> reverts to default
set_title() {
  if [[ -z "$1" ]]; then
    if [[ -n "$ORIGINAL_PROMPT_COMMAND" ]]; then
      PROMPT_COMMAND="$ORIGINAL_PROMPT_COMMAND"
    else
      unset PROMPT_COMMAND
    fi
  else
    PROMPT_COMMAND="echo -ne '\033]0;$*\007'"
  fi
}
