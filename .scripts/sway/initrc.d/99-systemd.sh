#!/bin/sh

##
## Systemd script
##

if command -v /usr/bin/dbus-update-activation-environment >/dev/null 2>&1; then
  /usr/bin/dbus-update-activation-environment --systemd \
    ELECTRON_TRASH \
    EMAIL \
    FTP_PROXY ftp_proxy \
    GDK_BACKEND \
    GPG_TTY \
    HTTP_PROXY http_proxy \
    HTTPS_PROXY https_proxy \
   _JAVA_AWT_WM_NONREPARENTING \
   _JAVA_OPTIONS \
    LANG \
    MOZ_ENABLE_WAYLAND \
    MOZ_USE_XINPUT2 \
    NO_PROXY no_proxy \
    QT_AUTO_SCREEN_SCALE_FACTOR \
    QT_ENABLE_HIGHDPI_SCALING \
    QT_QPA_PLATFORM \
    QT_WAYLAND_DISABLE_WINDOWDECORATION \
    QT_STYLE_OVERRIDE \
    RSYNC_PROXY rsync_proxy \
    SSH_AUTH_SOCK \
    TZ \
    WOBSOCK \
    XDG_CACHE_HOME \
    XDG_CONFIG_HOME \
    XDG_CONFIG_DIRS \
    XDG_CURRENT_DESKTOP \
    XDG_DATA_HOME \
    XDG_DESKTOP_DIR \
    XDG_DOCUMENTS_DIR \
    XDG_DOWNLOAD_DIR \
    XDG_MUSIC_DIR \
    XDG_PICTURES_DIR \
    XDG_PUBLICSHARE_DIR \
    XDG_SEAT \
    XDG_SESSION_CLASS \
    XDG_SESSION_DESKTOP \
    XDG_SESSION_ID \
    XDG_SESSION_TYPE \
    XDG_STATE_HOME \
    XDG_TEMPLATES_DIR \
    XDG_VIDEOS_DIR \
    XDG_VTNR
fi
