# The Bash personal login script, executed for bash login shells
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

# shellcheck shell=bash

# ------------------------------------------------------------------------------
# Source shell functions
# ------------------------------------------------------------------------------

if [[ -r "${HOME}/.bash_functions" ]]; then
    . "${HOME}/.bash_functions"
fi

# ------------------------------------------------------------------------------
# source Bourne compatible .profile first
# ------------------------------------------------------------------------------

if [[ -r "${HOME}/.profile" ]]; then
    . "${HOME}/.profile"
fi

# ------------------------------------------------------------------------------
# source .bashrc if this is an interactive shell
# ------------------------------------------------------------------------------

# https://www.gnu.org/software/bash/manual/html_node/Is-this-Shell-Interactive_003f.html
case "$-" in
    *i*)
        # This shell is interactive
        . "${HOME}/.bashrc"
        ;;
    *)
        # This shell is not interactive
        ;;
esac
