# shellcheck shell=bash

# barnacle (~/git/grantklassy/reimagined-barnacle) is the executive-function
# CLI. The binary lives in ~/.cargo/bin/ once `cargo install --path .` has
# been run from the repo. The CLI auto-discovers the project root from any
# subdirectory of the repo, but BARNACLE_HOME makes it work from anywhere.
# Only export when the repo is actually checked out --- avoids dangling env
# vars on machines that don't have it.

_barnacle_dir="$HOME/git/grantklassy/reimagined-barnacle"
if [ -d "$_barnacle_dir" ]; then
    export BARNACLE_HOME="$_barnacle_dir"
fi
unset _barnacle_dir
