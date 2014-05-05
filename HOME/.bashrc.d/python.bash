# ----------------------------------------------------------------------
# pyenv
# ----------------------------------------------------------------------

eval "$(pyenv init -)"

# check whether printf supports -v
__pyenv_printf_supports_v=
printf -v __pyenv_printf_supports_v -- '%s' yes >/dev/null 2>&1

# __pyenv_ps1 accepts 0 or 1 arguments (i.e., format string)
# when called from PS1 using command substitution
# in this mode it prints text to add to bash PS1 prompt
#
# __pyenv_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
# in that case it _sets_ PS1. The arguments are parts of a PS1 string.
# when two arguments are given, the first is prepended and the second appended
# to the state string when assigned to PS1.
# The optional third parameter will be used as printf format string to further
# customize the output of the pyenv_version string.
__pyenv_ps1 ()
{
    local pcmode=no
    local detached=no
    local ps1pc_start='\u@\h:\w '
    local ps1pc_end='\$ '
    local printf_format=' (%s)'
    local pyenv_version=$(pyenv version-name)

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

    if [ "${pyenv_version}" != "system" ]; then
        if [ ${pcmode} = yes ]; then
            if [ "${__pyenv_printf_supports_v-}" != yes ]; then
                pyenv_version=$(printf -- "${printf_format}" "${pyenv_version}")
            else
                printf -v pyenv_version -- "${printf_format}" "${pyenv_version}"
            fi
            PS1="${ps1pc_start}${pyenv_version}${ps1pc_end}"
        else
            printf -- "${printf_format}" "${pyenv_version}"
        fi
    else
        if [ ${pcmode} = yes ]; then
            # in PC mode PS1 always needs to be set
            PS1="${ps1pc_start}${ps1pc_end}"
        fi
        return
    fi
}

# Enable pyenv version in the prompt
export PROMPT_COMMAND="${PROMPT_COMMAND}"'__pyenv_ps1 "" "" "${PROMPT_BLUE}pyenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

# ----------------------------------------------------------------------
# virtualenv
# ----------------------------------------------------------------------

export VIRTUAL_ENV_DISABLE_PROMPT=true

# ----------------------------------------------------------------------
# pip
# ----------------------------------------------------------------------

if ! command -v pip >/dev/null 2>&1; then
    eval "$(pip completion --bash)"
fi
