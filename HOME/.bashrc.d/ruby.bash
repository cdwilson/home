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

# check whether printf supports -v
__rbenv_printf_supports_v=
printf -v __rbenv_printf_supports_v -- '%s' yes >/dev/null 2>&1

# __rbenv_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt
#
# __rbenv_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the rbenv_version string.
__rbenv_ps1 ()
{
    local pcmode=no
    local detached=no
    local ps1pc_start='\u@\h:\w '
    local ps1pc_end='\$ '
    local printf_format=' (%s)'
    local rbenv_version=$(rbenv version-name)

    case "$#" in
        2|3)
            pcmode=yes
            ps1pc_start="$1"
            ps1pc_end="$2"
            printf_format="${3:-${printf_format}}"
        ;;
        0|1)
            printf_format="${1:-${printf_format}}"
        ;;
        *)
            return
        ;;
    esac

    if [ "${rbenv_version}" != "system" ]; then
        if [ ${pcmode} = yes ]; then
            if [ "${__rbenv_printf_supports_v-}" != yes ]; then
                rbenv_version=$(printf -- "${printf_format}" "${rbenv_version}")
            else
                printf -v rbenv_version -- "${printf_format}" "${rbenv_version}"
            fi
            PS1="${ps1pc_start}${rbenv_version}${ps1pc_end}"
        else
            printf -- "${printf_format}" "${rbenv_version}"
        fi
    else
        if [ ${pcmode} = yes ]; then
            # in PC mode PS1 always needs to be set
            PS1="${ps1pc_start}${ps1pc_end}"
        fi
        return
    fi
}

# Enable rbenv version in the prompt
export PROMPT_COMMAND="${PROMPT_COMMAND}"'__rbenv_ps1 "" "" "${PROMPT_BLUE}rbenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'
