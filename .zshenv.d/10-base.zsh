##
## Base environment
##

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

[[ -n "$DISPLAY" ]] \
  && export BROWSER="librewolf" \
  || export BROWSER="links"
