##
## ZSH profile
##

if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 7 ]]; then
  ## Start Sway on tty7 with journal logging
  exec ~/.scripts/sway/initrc 2> >(logger -t sway -p err) 1> >(logger -t sway)
fi
