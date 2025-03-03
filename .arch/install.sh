#!/bin/sh

##
## Install
##

set -e

if [ "$EUID" -eq 0 ]; then
  echo "Please run as user: exiting..."; exit
fi

if [ "$(uname)" != 'Linux' ]; then
  echo 'Only supported on Linux: exiting...'; exit 1
fi

_log() {
  printf "\n\033[1m# %s\033[0m\n\n" "$1"
}

_error() {
  printf "\n\033[31m# %s \033[0m\n\n" "$1"
}

_main() {
  for script in $(dirname "$0")/install.d/?*.sh; do
    if [ -f "$script" ]; then
      source "$script"

      _main "$@"

      unset -f _main
    fi
  done

  unset script
}

_main "@$"

