# The Bash personal interactive initialization file
# (only read by a Bash shell that's both interactive and non-login)

# shamelessly stolen from the following:
# https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
# and many others I can't remember...

# References:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# ----------------------------------------------------------------------
# Environment Configuration
# ----------------------------------------------------------------------

# detect interactive shell
case "$-" in
    *i*)
        INTERACTIVE=yes
        ;;
    *)
        return
        ;;
esac

# detect login shell
case "$0" in
    -*)
        LOGIN=yes
        ;;
    *)
        unset LOGIN
        ;;
esac

if [ -r /etc/bashrc ]; then
    . /etc/bashrc
fi

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# filename completion ignores
export FIGNORE="~:CVS:#:.pyc"

# history options
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
export HISTSIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# ----------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------

# disk usage with human sizes and minimal depth
alias du1='du -h --max-depth=1'
alias fn='find . -name'
alias hi='history | tail -20'
alias la="ls -a" # list all, includes dot files
alias ll="ls -l" # long list, excludes dot files
alias lla="ls -la" # long list all, includes dot files
alias ppath="echo \$PATH | tr ':' '\n'"

# ----------------------------------------------------------------------
# Colors
# ----------------------------------------------------------------------

export COLOR_RESET="\[\033[0m\]"
export COLOR_BLACK="\[\033[0;30m\]"
export COLOR_LIGHT_BLACK="\[\033[1;30m\]"
export COLOR_RED="\[\033[0;31m\]"
export COLOR_LIGHT_RED="\[\033[1;31m\]"
export COLOR_GREEN="\[\033[0;32m\]"
export COLOR_LIGHT_GREEN="\[\033[1;32m\]"
export COLOR_YELLOW="\[\033[0;33m\]"
export COLOR_LIGHT_YELLOW="\[\033[1;33m\]"
export COLOR_BLUE="\[\033[0;34m\]"
export COLOR_LIGHT_BLUE="\[\033[1;34m\]"
export COLOR_MAGENTA="\[\033[0;35m\]"
export COLOR_LIGHT_MAGENTA="\[\033[1;35m\]"
export COLOR_CYAN="\[\033[0;36m\]"
export COLOR_LIGHT_CYAN="\[\033[1;36m\]"
export COLOR_WHITE="\[\033[0;37m\]"
export COLOR_LIGHT_WHITE="\[\033[1;37m\]"

# http://unix.stackexchange.com/questions/2897/clicolor-and-ls-colors-in-bash
export CLICOLOR=yes
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='--color=auto'
# http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
# export LSCOLORS=ExFxCxDxBxegedabagacad

# ----------------------------------------------------------------------
# Editor
# ----------------------------------------------------------------------

export EDITOR="/usr/local/bin/mate -w"

# ----------------------------------------------------------------------
# Prompt prefix
# ----------------------------------------------------------------------

# Lion default prompt
# export PS1="\h:\W \u\$ "

PS1_USER="${COLOR_RED}\u${COLOR_RESET}"
PS1_AT="${COLOR_CYAN}@${COLOR_RESET}"
PS1_HOST="${COLOR_GREEN}\h${COLOR_RESET}"
PS1_CURDIR="${COLOR_YELLOW}\w${COLOR_RESET}"

# export PS1="${PS1_USER}${PS1_AT}${PS1_HOST} ${PS1_CURDIR}"
export PS1="${PS1_HOST} ${PS1_USER} ${PS1_CURDIR}"

# ----------------------------------------------------------------------
# .bashrc.d
# ----------------------------------------------------------------------

# source any extra interactive shell files in .bashrc.d
if [ -d $HOME/.bashrc.d ]; then
    for file in $HOME/.bashrc.d/*.bash; do
        if [ -r $file ]; then
            . $file
        fi
    done
    unset file
fi

# ----------------------------------------------------------------------
# Prompt suffix
# ----------------------------------------------------------------------

# add newline and '$' to the end of the prompt after any customizations
# have been added by the files in .bashrc.d
export PS1="${PS1}\n$ "

# ----------------------------------------------------------------------
# Bash Completion
# ----------------------------------------------------------------------

# See http://trac.macports.org/wiki/howto/bash-completion

# The port bash-completion at version 2.0 requires at least bash at version
# 4.1; the older bash 3.2 provided by Apple with Mac OS X is not compatible
# anymore with this version. Please make sure you are using /opt/local/bin/bash
# by changing the preferences of your terminal accordingly. If your version of
# bash is too old, the script above will not modify your shell environment and
# no extended completion will be available.

if [[ `echo $BASH_VERSION` < 4.1 ]]; then
    echo
    echo "WARNING: bash completion requires bash >= 4.1"
    echo
    echo "\$BASH_VERSION=$BASH_VERSION"
    echo
    cat <<EOF
The port bash-completion at version 2.0 requires at least bash at
version 4.1; the older bash 3.2 provided by Apple with Mac OS X is not
compatible anymore with this version. Please make sure you are using
/opt/local/bin/bash by changing the preferences of your terminal accordingly.
If your version of bash is too old, the script above will not modify your
shell environment and no extended completion will be available.
EOF
fi

# Make sure you add this after any PATH manipulation as otherwise the
# bash-completion will not work correctly.
if [ -r /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi
