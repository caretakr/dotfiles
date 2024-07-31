##
## ZSH environment
##

export ZSH_COMPDUMP="${HOME}/.cache/zsh/compdump"

zshenv_directory="${HOME}/.zshenv.d"

if [[ -d "$zshenv_directory" ]]; then
	for file in "$zshenv_directory"/?*.zsh; do
		[[ -f "$file" && -r "$file" ]] \
      && source "$file"
	done

	unset file
fi

## Ensure that a non-login, non-interactive shell has a environment
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s ".zprofile" ]]; then
  source ".zprofile"
fi
