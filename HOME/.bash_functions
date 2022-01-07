# Shell functions for Bash shells

# shellcheck shell=bash

# ------------------------------------------------------------------------------
# Source shell functions
# ------------------------------------------------------------------------------

if [[ -r "${HOME}/.sh_functions" ]]; then
    . "${HOME}/.sh_functions"
fi

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Is this shell a login shell?
is_login_shell ()
{
    shopt -q login_shell
}

# Is this shell an interactive shell?
# https://www.gnu.org/software/bash/manual/html_node/Is-this-Shell-Interactive_003f.html
is_interactive_shell ()
{
    [[ $- == *i* ]]
}

# Is this command a specific type? e.g. if is_type ll alias; then ... fi
# https://stackoverflow.com/a/85903
is_type ()
(
    arg_type=$(type -t "${1}")
    [[ -n "${arg_type}" ]] && [[ "${arg_type}" == "${2}" ]]
)

# Does this function exist?
# This is faster than using is_type
# https://stackoverflow.com/a/85932
function_exists ()
{
    declare -F "$1" > /dev/null
}

# https://stackoverflow.com/questions/30499795/how-can-i-make-homebrews-python-and-pyenv-live-together
pyenv_brew_relink ()
{
    pyenv_root=$(pyenv root)
    rm -f "${pyenv_root}"/versions/*-brew
    # https://github.com/koalaman/shellcheck/wiki/SC2154
    for i in "${HOMEBREW_CELLAR:?}"/python*/* ; do
        ln -s -f "${i}" "${pyenv_root}/versions/${i##/*/}-brew"
    done
    pyenv rehash
}
