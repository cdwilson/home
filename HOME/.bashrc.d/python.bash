# ----------------------------------------------------------------------
# pyenv
# ----------------------------------------------------------------------

eval "$(pyenv init -)"

__pyenv_ps1 ()
{
    local printf_format=' (%s)'
    local pyenv_version=$(pyenv version-name)
    
	case "$#" in
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return
		;;
	esac
    
    if [ $pyenv_version != "system" ]; then
        printf -- "$printf_format" $pyenv_version
    else
        return
    fi
}

PS1_PYENV_FORMAT_STRING="\n${COLOR_LIGHT_BLACK}pyenv: ${COLOR_BLUE}%s${COLOR_RESET}"

# This works because Bash lets you "glue" together quoted strings into a
# single command as long as there are no spaces between the end of one quoted
# string and the start of the next quoted string. Therefore, all the
# PS1_XXXXX variables are expanded immediately because they are double
# quoted, whereas the __pyenv_ps1 command is evaluated for each prompt
# because it is single quoted.
export PS1="${PS1}"'$(__pyenv_ps1 "'"${PS1_PYENV_FORMAT_STRING}"'")'

# ----------------------------------------------------------------------
# pip
# ----------------------------------------------------------------------

if ! command -v pip >/dev/null 2>&1; then
    eval "$(pip completion --bash)"
fi
