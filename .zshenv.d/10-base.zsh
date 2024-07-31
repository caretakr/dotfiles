##
## Base environment
##

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

if [[ -n "$DISPLAY" ]]; then
  export BROWSER="librewolf"
else
  export BROWSER="links"
fi
