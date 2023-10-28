##
## ZSH environment
##

export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/compdump"

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_VIDEOS_DIR="$HOME/Videos"

export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="$XDG_DATA_HOME:$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

export HTTP_PROXY="http://127.0.0.1:3128"
export SOCKS_PROXY="socks5://127.0.0.1:1080"

export SOCKS_VERSION="5"

export http_proxy="$HTTP_PROXY"
export HTTPS_PROXY="$HTTP_PROXY"
export https_proxy="$HTTPS_PROXY"
export FTP_PROXY="$HTTP_PROXY"
export ftp_proxy="$FTP_PROXY"
export RSYNC_PROXY="$HTTP_PROXY"
export rsync_proxy="$rsync_proxy"

export NO_PROXY="localhost,127.0.0.1,10.96.0.0/12,192.168.59.0/24,192.168.49.0/24,192.168.39.0/24"
export no_proxy="$NO_PROXY"

export ANDROID_HOME="$HOME/.android/sdk"
export CARGO_HOME="$HOME/.cargo"

export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$CARGO_HOME/bin"

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

if [[ -n "$DISPLAY" ]]; then
  export BROWSER="librewolf"
else
  export BROWSER="links"
fi

# Ensure that a non-login, non-interactive shell has a environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s ".zprofile" ]]; then
  source ".zprofile"
fi
