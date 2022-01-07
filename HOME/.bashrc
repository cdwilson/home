# The Bash shell personal interactive initialization script file.
# (only read by a Bash shell that's both interactive and non-login)
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

# shellcheck shell=bash

# ------------------------------------------------------------------------------
# Source shell functions
# ------------------------------------------------------------------------------

if [[ -r "${HOME}/.bash_functions" ]]; then
    . "${HOME}/.bash_functions"
fi

# ------------------------------------------------------------------------------
# Silence /bin/bash deprecation warning on macOS
# ------------------------------------------------------------------------------

export BASH_SILENCE_DEPRECATION_WARNING=1

# ------------------------------------------------------------------------------
# Environment Configuration
# ------------------------------------------------------------------------------

# enable en_US locale w/ utf-8 encodings if not already configured
: "${LANG:="en_US.UTF-8"}"
: "${LANGUAGE:="en"}"
: "${LC_CTYPE:="en_US.UTF-8"}"
: "${LC_ALL:="en_US.UTF-8"}"
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
export PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

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
export COLOR_RESET="${ANSI_CSI}${SGR_RESET}m"

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
# Homebrew Bash Completion
# ------------------------------------------------------------------------------

if [[ -n "${HOMEBREW_PREFIX}" ]] && [[ -d "${HOMEBREW_PREFIX}" ]]; then
    # bash version check code copied from `starship init bash`
    major="${BASH_VERSINFO[0]}"
    minor="${BASH_VERSINFO[1]}"
    if ((major > 4)) || { ((major == 4)) && ((minor >= 2)); }; then
        # Make sure you add this after any PATH manipulation as otherwise the
        # bash-completion will not work correctly.
        if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
        then
            # shellcheck source=/dev/null
            . "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
            do
            # shellcheck source=/dev/null
            [[ -r "${COMPLETION}" ]] && . "${COMPLETION}"
            done
        fi
    else
        echo
        echo "WARNING: Bash completion is unavailable."
        echo
        echo "Homebrew bash-completion@2 requires bash >= 4.2"
        echo
        echo "\$BASH_VERSION=${BASH_VERSION}"
        echo
    fi
fi

# ------------------------------------------------------------------------------
# pipx
# ------------------------------------------------------------------------------
if executable_exists pipx; then
    if executable_exists register-python-argcomplete; then
        pipx_completions=$(register-python-argcomplete pipx)
    elif executable_exists register-python-argcomplete3; then
        pipx_completions=$(register-python-argcomplete3 pipx)
    fi
    if [[ -n "${pipx_completions}" ]]; then
        eval "${pipx_completions}"
    fi
fi

# ------------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------------
if [[ -n "${RBENV_ROOT}" ]] && [[ -d "${RBENV_ROOT}" ]]; then
    # Don't use `rbenv init -` directly because it sets the PATH. Instead,
    # remove any lines that set the PATH and then eval.
    rbenv_init=$(rbenv init -)
    rbenv_init_no_path=$(sed '/export PATH/d' <<< "${rbenv_init}")
    eval "${rbenv_init_no_path}"
fi

# ------------------------------------------------------------------------------
# pyenv
# ------------------------------------------------------------------------------

if [[ -n "${PYENV_ROOT}" ]] && [[ -d "${PYENV_ROOT}" ]]; then
    pyenv_init=$(pyenv init -)
    eval "${pyenv_init}"
fi

# ------------------------------------------------------------------------------
# pyenv-virtualenv
# ------------------------------------------------------------------------------

if [[ -n "${PYENV_ROOT}" ]] && [[ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]]; then
    # https://github.com/pyenv/pyenv-virtualenv#special-environment-variables
    # export PYENV_VIRTUALENV_VERBOSE_ACTIVATE=1

    # Don't use `pyenv virtualenv-init -` directly because it sets the PATH.
    # Instead, remove any lines that set the PATH and then eval.
    pyenv_virtualenv_init=$(pyenv virtualenv-init -)
    pyenv_virtualenv_init_no_path=$(sed '/export PATH/d' <<< "${pyenv_virtualenv_init}")
    eval "${pyenv_virtualenv_init_no_path}"
fi

# ------------------------------------------------------------------------------
# pip Bash completion
# ------------------------------------------------------------------------------

# https://pip.pypa.io/en/stable/user_guide/#command-completion
if executable_exists pip; then
    pip_completion_bash=$(pip completion --bash)
    eval "${pip_completion_bash}"
fi

# ------------------------------------------------------------------------------
# rustup Bash completion
# ------------------------------------------------------------------------------

# https://rust-lang.github.io/rustup/installation/index.html
if executable_exists rustup; then
    rustup_completions_bash=$(rustup completions bash)
    eval "${rustup_completions_bash}"
fi

# ------------------------------------------------------------------------------
# Initialize Starship prompt
# ------------------------------------------------------------------------------

# https://starship.rs/guide/#%F0%9F%9A%80-installation
if executable_exists starship; then
    starship_init_bash=$(starship init bash)
    eval "${starship_init_bash}"
fi

# ------------------------------------------------------------------------------
# direnv
# ------------------------------------------------------------------------------

if executable_exists direnv; then
    direnv_hook_bash=$(direnv hook bash)
    eval "${direnv_hook_bash}"
fi
