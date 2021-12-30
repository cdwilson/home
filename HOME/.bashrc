# The Bash personal interactive initialization file
# (only read by a Bash shell that's both interactive and non-login)

# References:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# ------------------------------------------------------------------------------
# Environment Configuration
# ------------------------------------------------------------------------------

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
export FIGNORE="~:CVS:#:.pyc:.bak"

# history options
export HISTCONTROL=ignoreboth
export HISTFILESIZE=10000
export HISTSIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

#  immediately add commands to history (don't wait for the end of each session)
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# ------------------------------------------------------------------------------
# Editor
# ------------------------------------------------------------------------------

# TextMate
# export EDITOR='/usr/local/bin/mate -w'

# Sublime
# export EDITOR='subl -w'

# Atom
# export EDITOR='atom --wait'

# Visual Studio Code
export EDITOR='code --wait'

# ------------------------------------------------------------------------------
# Colors
# ------------------------------------------------------------------------------

# From http://en.wikipedia.org/wiki/ANSI_escape_code
# Escape sequences start with the character ESC (ASCII decimal 27/hex 0x1B/octal
# 033). For two character sequences, the second character is in the range ASCII
# 64 to 95 (@ to _). However, most of the sequences are more than two
# characters, and start with the characters ESC and [ (left bracket). This
# sequence is called CSI for Control Sequence Introducer (or Control Sequence
# Initiator). The final character of these sequences is in the range ASCII 64 to
# 126 (@ to ~).

# ANSI Escape
export ANSI_ESC="\033"

# ANSI Control Sequence Introducer
export ANSI_CSI="${ANSI_ESC}["

# SGR (Select Graphic Rendition) parameters
export SGR_RESET="0"
export SGR_BOLD="1"
export SGR_FAINT="2"
export SGR_ITALIC="3"
export SGR_UNDERLINE="4"
export SGR_BLINK_SLOW="5"
export SGR_BLINK_RAPID="6"
export SGR_IMAGE_NEGATIVE="7"
export SGR_CONCEAL="8"
export SGR_CROSSED_OUT="9"
export SGR_FG_BLACK="30"
export SGR_FG_RED="31"
export SGR_FG_GREEN="32"
export SGR_FG_YELLOW="33"
export SGR_FG_BLUE="34"
export SGR_FG_MAGENTA="35"
export SGR_FG_CYAN="36"
export SGR_FG_WHITE="37"
export SGR_BG_BLACK="40"
export SGR_BG_RED="41"
export SGR_BG_GREEN="42"
export SGR_BG_YELLOW="43"
export SGR_BG_BLUE="44"
export SGR_BG_MAGENTA="45"
export SGR_BG_CYAN="46"
export SGR_BG_WHITE="47"

# Reset Color
export COLOR_RESET="${ANSI_CSI}${SGR_FG_RESET}m"

# Normal Colors
export COLOR_BLACK="${ANSI_CSI}${SGR_FG_BLACK}m"
export COLOR_RED="${ANSI_CSI}${SGR_FG_RED}m"
export COLOR_GREEN="${ANSI_CSI}${SGR_FG_GREEN}m"
export COLOR_YELLOW="${ANSI_CSI}${SGR_FG_YELLOW}m"
export COLOR_BLUE="${ANSI_CSI}${SGR_FG_BLUE}m"
export COLOR_MAGENTA="${ANSI_CSI}${SGR_FG_MAGENTA}m"
export COLOR_CYAN="${ANSI_CSI}${SGR_FG_CYAN}m"
export COLOR_WHITE="${ANSI_CSI}${SGR_FG_WHITE}m"

# Bold Colors
export COLOR_BOLD_BLACK="${ANSI_CSI}${SGR_BOLD};${SGR_FG_BLACK}m"
export COLOR_BOLD_RED="${ANSI_CSI}${SGR_BOLD};${SGR_FG_RED}m"
export COLOR_BOLD_GREEN="${ANSI_CSI}${SGR_BOLD};${SGR_FG_GREEN}m"
export COLOR_BOLD_YELLOW="${ANSI_CSI}${SGR_BOLD};${SGR_FG_YELLOW}m"
export COLOR_BOLD_BLUE="${ANSI_CSI}${SGR_BOLD};${SGR_FG_BLUE}m"
export COLOR_BOLD_MAGENTA="${ANSI_CSI}${SGR_BOLD};${SGR_FG_MAGENTA}m"
export COLOR_BOLD_CYAN="${ANSI_CSI}${SGR_BOLD};${SGR_FG_CYAN}m"
export COLOR_BOLD_WHITE="${ANSI_CSI}${SGR_BOLD};${SGR_FG_WHITE}m"

# http://unix.stackexchange.com/questions/2897/clicolor-and-ls-colors-in-bash
export CLICOLOR=yes
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='--color=auto'
# http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
# export LSCOLORS=ExFxCxDxBxegedabagacad

# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# https://stackoverflow.com/questions/30499795/how-can-i-make-homebrews-python-and-pyenv-live-together
pyenv-brew-relink ()
{
    rm -f "$(pyenv root)"/versions/*-brew
    for i in $(brew --cellar)/python*/* ; do
        ln -s -f "$i" "$(pyenv root)"/versions/${i##/*/}-brew
    done
    pyenv rehash
}

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------

# disk usage with human sizes and minimal depth
alias du1='du -h -d 1'
alias fn='find . -name'
alias hi='history | tail -20'
alias la="ls -a" # list all, includes dot files
alias ll="ls -l" # long list, excludes dot files
alias lla="ls -la" # long list all, includes dot files
alias ppath="echo \$PATH | tr ':' '\n'"

# https://support.typora.io/Use-Typora-From-Shell-or-cmd/
alias typora="open -a typora"

# https://jira.atlassian.com/browse/SRCTREE-7794
# https://jira.atlassian.com/browse/SRCTREE-3172
alias stree='/Applications/SourceTree.app/Contents/Resources/stree'

# ------------------------------------------------------------------------------
# python virtualenv
# ------------------------------------------------------------------------------

# export VIRTUAL_ENV_DISABLE_PROMPT=true

# ------------------------------------------------------------------------------
# Homebrew Bash Completion
# ------------------------------------------------------------------------------
if [[ `echo $BASH_VERSION` < 4.1 ]]; then
    echo
    echo "WARNING: bash-completion@2 requires bash >= 4.1"
    echo
    echo "\$BASH_VERSION=$BASH_VERSION"
    echo
else
    # Make sure you add this after any PATH manipulation as otherwise the
    # bash-completion will not work correctly.
    if exists brew; then
        if [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]]
        then
            . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "$(brew --prefix)/etc/bash_completion.d/"*
            do
            [[ -r "${COMPLETION}" ]] && . "${COMPLETION}"
            done
        fi
    fi
fi

# ------------------------------------------------------------------------------
# pip Bash completion
# ------------------------------------------------------------------------------

if exists pip; then
    eval "$(pip completion --bash)"
fi

# ------------------------------------------------------------------------------
# rustup Bash completion
# ------------------------------------------------------------------------------

# https://rust-lang.github.io/rustup/installation/index.html
if exists rustup; then
    eval "$(rustup completions bash)"
fi

# ------------------------------------------------------------------------------
# Starship (https://starship.rs/)
# ------------------------------------------------------------------------------

eval "$(starship init bash)"
