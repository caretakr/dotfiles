##
## Path environment
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
