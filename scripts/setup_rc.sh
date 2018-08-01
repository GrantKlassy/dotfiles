#!/bin/bash

PROG=$(basename "$0")
FORCE=false

# Get arguments
ARGS=$(getopt -o hvqn --long help,force -n "$PROG" -- "$@")

# Print the usage if getopt didnt like the args
[ $? == 0 ] || usage
eval set -- "$ARGS"

function usage() {
	cat <<USAGE
TODO Usage here
USAGE
	exit 255
}

# Process arguments
while true; do
	case "$1" in
		-h|--help)
			usage
			;;
		-f|--force)
			FORCE=true
			shift
			;;
		--)
			shift
			break
			;;
		*)
			usage
			;;
	esac
done

# Check dependencies
if ! dpkg -l wget 1>/dev/null 2>&1 ; then
	echo 'wget not installed. Run `sudo apt-get install wget`'
	exit 1
fi

# Download bashrc
if [ -f ~/.bashrc ] && [ $FORCE == false ]; then
	echo '~/.bashrc already exists'
else
	wget https://raw.githubusercontent.com/GrantKlassy/linux-configs/master/rc/bashrc -O ~/.bashrc
fi

# Download vimrc
if [ -f ~/.vimrc ] && [ $FORCE == false ]; then
	echo '~/.vimrc already exists'
else
	wget https://raw.githubusercontent.com/GrantKlassy/linux-configs/master/rc/vimrc -O ~/.vimrc
fi
