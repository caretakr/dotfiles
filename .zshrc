##
## ZSH startup
##

_HTTP_PROXY="$HTTP_PROXY"
_SOCKS_PROXY="$SOCKS_PROXY"

_SOCKS_VERSION="$SOCKS_VERSION"

_NO_PROXY="$NO_PROXY"

load() {
  local file="$1"

  [ -r "$file" ] \
    && source "$file" \
    || return 1
}

mkdirp() {
  local dir="$1"

  [ ! -d "$dir" ] \
    && mkdir -p "$dir"
}

proxy_off() {
  unset HTTP_PROXY
  unset SOCKS_PROXY

  unset SOCKS_VERSION

  unset http_proxy
  unset HTTPS_PROXY
  unset https_proxy
  unset FTP_PROXY
  unset ftp_proxy
  unset RSYNC_PROXY
  unset rsync_proxy

  unset NO_PROXY
  unset no_proxy
}

proxy_on() {
  export HTTP_PROXY="$_HTTP_PROXY"
  export SOCKS_PROXY="$_SOCKS_PROXY"

  export SOCKS_VERSION="$_SOCKS_VERSION"

  export http_proxy="$HTTP_PROXY"
  export HTTPS_PROXY="$HTTP_PROXY"
  export https_proxy="$HTTPS_PROXY"
  export FTP_PROXY="$HTTP_PROXY"
  export ftp_proxy="$FTP_PROXY"
  export RSYNC_PROXY="$HTTP_PROXY"
  export rsync_proxy="$rsync_proxy"

  export NO_PROXY="$_NO_PROXY"
  export no_proxy="$NO_PROXY"
}

## Load Powerlevel10k instant prompt early
load "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

## Load the ZSH completion
autoload -Uz compinit \
  && compinit -d "$ZSH_COMPDUMP"

## Create cache directory if not exists
mkdirp "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

## Create data directory if not exists
mkdirp "${XDG_DATA_HOME:-$HOME/.local/share}/zsh"

## Remove extra space
ZLE_RPROMPT_INDENT=0

##
## History
##

## Set history file and size
HISTFILE="$XDG_DATA_HOME/zsh/histfile"
HISTSIZE="999999999"
SAVEHIST="$HISTSIZE"

## ISO 8601 timestamp history format
HIST_STAMPS="%Y-%m-%dT%H:%M:%S.%f%z"

## Append into history as soon as possible
setopt INC_APPEND_HISTORY

## Expand history with timestamp
setopt EXTENDED_HISTORY

## Ignore dups on history
setopt HIST_IGNORE_DUPS

##
## Aliases
##

## Set v(i(m)) aliases
alias vim="nvim"
alias vi="vim"
alias v="vi"

## Set trash alias
alias rm="trash"

##
## Plugins
##

## Load z(oxide) plugin
zoxide="/usr/bin/zoxide" \
  && command -v "$zoxide" > /dev/null 2>&1 \
  && eval "$("$zoxide" init zsh)"

## Load Powerlevel10k theme
load /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme \
  && load "$HOME/.p10k.zsh"

## Load NVM plugin
load /usr/share/nvm/init-nvm.sh

## Load autosuggestions plugin
load /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load syntax highlight plugin (MUST be at end of everything)
load /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Load history substring search plugin (MUST be after syntax highlight)
load /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh \
  && bindkey '^[[A' history-substring-search-up \
  && bindkey '^[[B' history-substring-search-down
