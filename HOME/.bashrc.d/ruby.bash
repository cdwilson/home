# ----------------------------------------------------------------------
# rvm
# ----------------------------------------------------------------------

# Load RVM into a shell session *as a function*
# if [ -r "$HOME/.rvm/scripts/rvm" ]; then
#   . "$HOME/.rvm/scripts/rvm"
# fi

# ----------------------------------------------------------------------
# rbenv
# ----------------------------------------------------------------------

eval "$(rbenv init -)"

__rbenv_ps1 ()
{
    local printf_format=' (%s)'
    local rbenv_version=$(rbenv version-name)
    
	case "$#" in
		0|1)	printf_format="${1:-$printf_format}"
		;;
		*)	return
		;;
	esac
    
    if [ $rbenv_version != "system" ]; then
        printf -- "$printf_format" $rbenv_version
    else
        return
    fi
}

PS1_RBENV_FORMAT_STRING="\n${COLOR_LIGHT_BLACK}rbenv: ${COLOR_BLUE}%s${COLOR_RESET}"

# This works because Bash lets you "glue" together quoted strings into a
# single command as long as there are no spaces between the end of one quoted
# string and the start of the next quoted string. Therefore, all the
# PS1_XXXXX variables are expanded immediately because they are double
# quoted, whereas the __rbenv_ps1 command is evaluated for each prompt
# because it is single quoted.
export PS1="${PS1}"'$(__rbenv_ps1 "'"${PS1_RBENV_FORMAT_STRING}"'")'