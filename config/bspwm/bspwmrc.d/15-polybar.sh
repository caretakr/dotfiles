#!/bin/sh

#
# Polybar startup
#

if pgrep -x polybar >/dev/null; then
    killall polybar >/dev/null

    while pgrep -x polybar >/dev/null; do sleep 1; done
fi

for m in "$(xrandr --query | grep " connected")"; do
  if [ \
    "$(echo "$m" | grep "1920x1200" | grep "288mm x 180mm")" ||
    "$(echo "$m" | grep "1920x1080" | grep "532mm x 304mm")" \
  ]; then
    HEIGHT="40px"

    FONT0="FiraMono Nerd Font:size=12;3"
    FONT1="FiraMono Nerd Font Mono:size=16;4"
    FONT2="FiraMono Nerd Font Mono:size=20;4"
    FONT3="FiraMono Nerd Font Mono:size=24;6"
  elif [ \
    "$(echo "$m" | grep "1920x800" | grep "290mm x 180mm")" \
  ]; then
    HEIGHT="32px"

    FONT0="FiraMono Nerd Font:size=10;3"
    FONT1="FiraMono Nerd Font Mono:size=14;4"
    FONT2="FiraMono Nerd Font Mono:size=28;4"
    FONT3="FiraMono Nerd Font Mono:size=22;6"
  fi

  MONITOR="$(echo "$m" | cut -d" " -f1)" \
    HEIGHT="$HEIGHT" \
    FONT0="$FONT0" \
    FONT1="$FONT1" \
    FONT2="$FONT2" \
    FONT3="$FONT3" \
    polybar --reload top >$XDG_DATA_HOME/polybar/polybar.log 2>&1 & disown
done