# shellcheck shell=bash
# macOS-specific setup -- no-op on Linux

[[ "$(uname -s)" != "Darwin" ]] && return 0

export RUNNING_ON_MAC=true

bind '"\e[200~": paste-from-clipboard'
bind '"\e[201~": end-paste-from-clipboard'

MOUSEACCEL=$(defaults read .GlobalPreferences com.apple.mouse.scaling)
if [[ "$MOUSEACCEL" != -1 ]]; then
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
fi

eval "$(/opt/homebrew/bin/brew shellenv)"
export BASH_SILENCE_DEPRECATION_WARNING=1
