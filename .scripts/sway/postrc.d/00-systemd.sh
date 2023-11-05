#!/bin/sh

##
## Systemd script
##

while
  [ -z "$WAYLAND_DISPLAY" ] \
    || [ -z "$DISPLAY" ] \
    || [ -z "$SWAYSOCK" ] \
    || [ ! -S "$SWAYSOCK" ]
do
  sleep 1
done

if command -v /usr/bin/dbus-update-activation-environment >/dev/null 2>&1; then
  /usr/bin/dbus-update-activation-environment --systemd \
    DISPLAY \
    SWAYSOCK \
    WAYLAND_DISPLAY
fi
