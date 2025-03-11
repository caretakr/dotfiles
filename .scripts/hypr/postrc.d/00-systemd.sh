#!/bin/sh

##
## Systemd startup
##

while
	[ -z $HYPRLAND_INSTANCE_SIGNATURE ] ||
		[ ! -S "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket.sock" ] ||
		[ ! -S "$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" ]
do
	sleep 1
done

if command -v /usr/bin/dbus-update-activation-environment >/dev/null 2>&1; then
	/usr/bin/dbus-update-activation-environment --systemd \
		DISPLAY \
		HYPRLAND_INSTANCE_SIGNATURE \
		WAYLAND_DISPLAY
fi
