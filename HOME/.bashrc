# The individual per-interactive-shell startup file
# (only read by a shell that's both interactive and non-login)

# shamelessly stolen from the following:
# https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
# and many others I can't remember...

# References:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# ----------------------------------------------------------------------
# Environment Configuration
# ----------------------------------------------------------------------

if [ -r /etc/bashrc ]; then
    . /etc/bashrc
fi

# detect interactive shell
case "$-" in
    *i*) INTERACTIVE=yes ;;
    *) unset INTERACTIVE ;;
esac

# detect login shell
case "$0" in
    -*) LOGIN=yes ;;
    *) unset LOGIN ;;
esac

# enable en_US locale w/ utf-8 encodings if not already configured
: ${LANG:="en_US.UTF-8"}
: ${LANGUAGE:="en"}
: ${LC_CTYPE:="en_US.UTF-8"}
: ${LC_ALL:="en_US.UTF-8"}
export LANG LANGUAGE LC_CTYPE LC_ALL

# filename completion ignores
FIGNORE="~:CVS:#:.pyc"

# history options
HISTCONTROL=ignoreboth
HISTFILESIZE=10000
HISTSIZE=10000

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
export COLOR_BRIGHT_BLACK="\[\033[1;30m\]"
export COLOR_RED="\[\033[0;31m\]"
export COLOR_BRIGHT_RED="\[\033[1;31m\]"
export COLOR_GREEN="\[\033[0;32m\]"
export COLOR_BRIGHT_GREEN="\[\033[1;32m\]"
export COLOR_YELLOW="\[\033[0;33m\]"
export COLOR_BRIGHT_YELLOW="\[\033[1;33m\]"
export COLOR_BLUE="\[\033[0;34m\]"
export COLOR_BRIGHT_BLUE="\[\033[1;34m\]"
export COLOR_MAGENTA="\[\033[0;35m\]"
export COLOR_BRIGHT_MAGENTA="\[\033[1;35m\]"
export COLOR_CYAN="\[\033[0;36m\]"
export COLOR_BRIGHT_CYAN="\[\033[1;36m\]"
export COLOR_WHITE="\[\033[0;37m\]"
export COLOR_BRIGHT_WHITE="\[\033[1;37m\]"

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
# Prompt
# ----------------------------------------------------------------------

# Lion default prompt
# export PS1="\h:\W \u\$ "

PS1_USER="${COLOR_GREEN}\u${COLOR_RESET}"
PS1_AT="${COLOR_GREEN}@${COLOR_RESET}"
PS1_HOST="${COLOR_GREEN}\h${COLOR_RESET}"
PS1_CURDIR="${COLOR_YELLOW}\w${COLOR_RESET}"

PS1="${PS1_USER}${PS1_AT}${PS1_HOST} ${PS1_CURDIR}\n$ "

# ----------------------------------------------------------------------
# Bash Completion
# ----------------------------------------------------------------------

# note: must come after any PATH manipulation
if [ -r /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

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
