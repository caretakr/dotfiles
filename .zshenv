##
## ZSH environment
##

export ZSH_COMPDUMP="${HOME}/.cache/zsh/compdump"

##
## Base variables
##

export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"

[[ -n "$DISPLAY" ]] \
  && export BROWSER="librewolf" \
  || export BROWSER="links"

##
## XDG variables
##

export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_SCRIPT_HOME="${HOME}/.script"

export XDG_DESKTOP_DIR="${HOME}/Desktop"
export XDG_DOCUMENTS_DIR="${HOME}/Documents"
export XDG_DOWNLOAD_DIR="${HOME}/Downloads"
export XDG_MUSIC_DIR="${HOME}/Music"
export XDG_PICTURES_DIR="${HOME}/Pictures"
export XDG_PUBLICSHARE_DIR="${HOME}/Public"
export XDG_TEMPLATES_DIR="${HOME}/Templates"
export XDG_VIDEOS_DIR="${HOME}/Videos"

export XDG_CONFIG_DIRS="/etc/xdg"
export XDG_DATA_DIRS="${XDG_DATA_HOME}:${XDG_DATA_HOME}/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share"

##
## GPG variables
##

export GPG_TTY=$(tty)

##
## Path variables
##

export ANDROID_HOME="${HOME}/.android"
export CARGO_HOME="${HOME}/.cargo"

export GOPATH="$HOME/.go"

export LUAROCKS_HOME="${HOME}/.luarocks"
export NPM_HOME="${HOME}/.npm"
export PNPM_HOME="${HOME}/.pnpm"

export npm_config_prefix="$NPM_HOME"

export LUA_PATH="/usr/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?.lua;/usr/local/share/lua/5.4/?/init.lua;/usr/share/lua/5.4/?/init.lua;/usr/local/lib/lua/5.4/?.lua;/usr/local/lib/lua/5.4/?/init.lua;/usr/lib/lua/5.4/?.lua;/usr/lib/lua/5.4/?/init.lua;./?.lua;./?/init.lua;${LUAROCKS_HOME}/share/lua/5.4/?.lua;${LUAROCKS_HOME}/share/lua/5.4/?/init.lua"
export LUA_CPATH="/usr/local/lib/lua/5.4/?.so;/usr/lib/lua/5.4/?.so;/usr/local/lib/lua/5.4/loadall.so;/usr/lib/lua/5.4/loadall.so;./?.so;${LUAROCKS_HOME}/lib/lua/5.4/?.so"

export PATH="${PATH}:/home/caretakr/.local/bin"

export PATH="${PATH}:${ANDROID_HOME}/tools"
export PATH="${PATH}:${ANDROID_HOME}/tools/bin"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"

export PATH="${PATH}:${CARGO_HOME}/bin"
export PATH="${PATH}:${GOPATH}/bin"
export PATH="${PATH}:${LUAROCKS_HOME}/bin"
export PATH="${PATH}:${NPM_HOME}/bin"
export PATH="${PATH}:${PNPM_HOME}/bin"

##
## Proxy variables
##

export HTTP_PROXY="http://127.0.0.1:8118"
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

##
## SSH variables
##

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"

## Ensure that a non-login, non-interactive shell has a environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s ".zprofile" ]]; then
  source ".zprofile"
fi
