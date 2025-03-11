##
## ZSH startup
##

autoload -U add-zsh-hook

load() {
  [[ -r "$1" ]] && {
    source "$1"
  }
}

load_nvmrc() {
  local nvmrc_path

  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version

    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install >/dev/null 2>&1
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use >/dev/null 2>&1
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use system >/dev/null 2>&1
  fi
}

mkdirp() {
  [[ -d "$1" ]] || {
    mkdir -p "$1"
  }
}

## Load Powerlevel10k instant prompt early
load "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

## Create cache directory if not exists
mkdirp "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

## Load the ZSH completion
autoload -Uz compinit \
  && compinit -d "$ZSH_COMPDUMP"

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
alias vi="vim"
alias v="vi"

## Set trash alias
alias rm="trash"

##
## Exports
##

export GPG_TTY=$(tty)

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
load /usr/share/nvm/init-nvm.sh --no-use

## Add hook to load .nvmrc when changind directories
add-zsh-hook chpwd load_nvmrc \
  ; load_nvmrc

## Load autosuggestions plugin
load /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

## Load syntax highlight plugin (MUST be at end of everything)
load /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## Load history substring search plugin (MUST be after syntax highlight)
load /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh \
  && bindkey '^[[A' history-substring-search-up \
  && bindkey '^[[B' history-substring-search-down
