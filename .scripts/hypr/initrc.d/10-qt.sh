#!/bin/sh

##
## Qt startup
##

export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1

export QT_QPA_PLATFORM="wayland;xcb"
export QT_QPA_PLATFORMTHEME="qt5ct:qt6ct"

export QT_STYLE_OVERRIDE="Adwaita-dark"
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
