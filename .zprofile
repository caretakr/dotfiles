#!/bin/zsh

##
## ZSH profile
##

if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 7 ]]; then
  ## Start Hyprland on tty7 with journal logging
  exec ~/.scripts/hypr/initrc 2> >(logger -t hypr -p err) 1> >(logger -t hypr)
fi
