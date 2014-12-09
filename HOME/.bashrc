# The Bash personal interactive initialization file
# (only read by a Bash shell that's both interactive and non-login)

# shamelessly stolen from the following:
# https://github.com/rtomayko/dotfiles/blob/rtomayko/.bashrc
# https://github.com/mathiasbynens/dotfiles/blob/master/.bash_profile
# and many others I can't remember...

# References:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# ----------------------------------------------------------------------------
# Environment Configuration
# ----------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------

# disk usage with human sizes and minimal depth
alias du1='du -h -d 1'
alias fn='find . -name'
alias hi='history | tail -20'
alias la="ls -a" # list all, includes dot files
alias ll="ls -l" # long list, excludes dot files
alias lla="ls -la" # long list all, includes dot files
alias ppath="echo \$PATH | tr ':' '\n'"

# ----------------------------------------------------------------------------
# Colors
# ----------------------------------------------------------------------------

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

# ----------------------------------------------------------------------------
# Editor
# ----------------------------------------------------------------------------

# TextMate
# export EDITOR="/usr/local/bin/mate -w"

# Sublime
export EDITOR='subl -w'

alias e='subl'

# ----------------------------------------------------------------------------
# python virtualenv
# ----------------------------------------------------------------------------

export VIRTUAL_ENV_DISABLE_PROMPT=true

# ----------------------------------------------------------------------------
# anyenv initialization
# ----------------------------------------------------------------------------

eval "$(anyenv init -)"

# ----------------------------------------------------------------------------
# pyenv initialization
# ----------------------------------------------------------------------------

# eval "$(pyenv init -)"

# ----------------------------------------------------------------------------
# rbenv initialization
# ----------------------------------------------------------------------------

# eval "$(rbenv init -)"

# ----------------------------------------------------------------------------
# rvm
# ----------------------------------------------------------------------------

# Load RVM into a shell session *as a function*
# if [ -r "$HOME/.rvm/scripts/rvm" ]; then
#   . "$HOME/.rvm/scripts/rvm"
# fi

# ----------------------------------------------------------------------------
# Begin Prompt
# ----------------------------------------------------------------------------

# http://www.gnu.org/software/bash/manual/bashref.html#Printing-a-Prompt
# \[: Begin a sequence of non-printing characters. This could be used to embed
#     a terminal control sequence into the prompt.
# \]: End a sequence of non-printing characters.

# Reset Color
export PROMPT_RESET="\[${ANSI_CSI}${SGR_FG_RESET}m\]"

# Normal Colors
export PROMPT_BLACK="\[${ANSI_CSI}${SGR_FG_BLACK}m\]"
export PROMPT_RED="\[${ANSI_CSI}${SGR_FG_RED}m\]"
export PROMPT_GREEN="\[${ANSI_CSI}${SGR_FG_GREEN}m\]"
export PROMPT_YELLOW="\[${ANSI_CSI}${SGR_FG_YELLOW}m\]"
export PROMPT_BLUE="\[${ANSI_CSI}${SGR_FG_BLUE}m\]"
export PROMPT_MAGENTA="\[${ANSI_CSI}${SGR_FG_MAGENTA}m\]"
export PROMPT_CYAN="\[${ANSI_CSI}${SGR_FG_CYAN}m\]"
export PROMPT_WHITE="\[${ANSI_CSI}${SGR_FG_WHITE}m\]"

# Bold Colors
export PROMPT_BOLD_BLACK="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_BLACK}m\]"
export PROMPT_BOLD_RED="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_RED}m\]"
export PROMPT_BOLD_GREEN="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_GREEN}m\]"
export PROMPT_BOLD_YELLOW="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_YELLOW}m\]"
export PROMPT_BOLD_BLUE="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_BLUE}m\]"
export PROMPT_BOLD_MAGENTA="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_MAGENTA}m\]"
export PROMPT_BOLD_CYAN="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_CYAN}m\]"
export PROMPT_BOLD_WHITE="\[${ANSI_CSI}${SGR_BOLD};${SGR_FG_WHITE}m\]"

PROMPT_USER="${PROMPT_RED}\u${PROMPT_RESET}"
PROMPT_HOST="${PROMPT_GREEN}\h${PROMPT_RESET}"
PROMPT_CURDIR="${PROMPT_YELLOW}\w${PROMPT_RESET}"

export PS1_PREFIX="${PROMPT_HOST} ${PROMPT_USER} ${PROMPT_CURDIR}\n"
export PS1_SUFFIX="${PROMPT_BLUE}[${PROMPT_RESET}${PROMPT_MAGENTA}\!${PROMPT_RESET}${PROMPT_BLUE}]\$${PROMPT_RESET} "
export PROMPT_COMMAND='PS1_PC="";'

# ----------------------------------------------------------------------------
# Git prompt
# ----------------------------------------------------------------------------

# source git-prompt.sh to enable __git_ps1
if [ -r /opt/local/share/git/git-prompt.sh ]; then
  . /opt/local/share/git/git-prompt.sh
fi

# Enable git status in the prompt
export PROMPT_COMMAND="${PROMPT_COMMAND}"'__git_ps1 "" "" "${PROMPT_BLUE}git:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

# __git_ps1 options
export GIT_PS1_SHOWDIRTYSTATE=true #... untagged(*) and staged(+) changes
export GIT_PS1_SHOWSTASHSTATE=true #... if something is stashed($)
export GIT_PS1_SHOWUNTRACKEDFILES=true #... untracked files(%)
export GIT_PS1_SHOWUPSTREAM="auto verbose name git"
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWCOLORHINTS=true

# ----------------------------------------------------------------------------
# pyenv prompt
# ----------------------------------------------------------------------------

# check whether printf supports -v
# __pyenv_printf_supports_v=
# printf -v __pyenv_printf_supports_v -- '%s' yes >/dev/null 2>&1

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
# __pyenv_ps1 ()
# {
#     local pcmode=no
#     local detached=no
#     local ps1pc_start='\u@\h:\w '
#     local ps1pc_end='\$ '
#     local printf_format=' (%s)'
#     local pyenv_version=$(pyenv version-name)

#     case "$#" in
#         2|3)
#             pcmode=yes
#             ps1pc_start="$1"
#             ps1pc_end="$2"
#             printf_format="${3:-${printf_format}}"
#         ;;
#         0|1)
#             printf_format="${1:-${printf_format}}"
#         ;;
#         *)
#             return
#         ;;
#     esac

#     if [ "${pyenv_version}" != "system" ]; then
#         if [ ${pcmode} = yes ]; then
#             if [ "${__pyenv_printf_supports_v-}" != yes ]; then
#                 pyenv_version=$(printf -- "${printf_format}" "${pyenv_version}")
#             else
#                 printf -v pyenv_version -- "${printf_format}" "${pyenv_version}"
#             fi
#             PS1="${ps1pc_start}${pyenv_version}${ps1pc_end}"
#         else
#             printf -- "${printf_format}" "${pyenv_version}"
#         fi
#     else
#         if [ ${pcmode} = yes ]; then
#             # in PC mode PS1 always needs to be set
#             PS1="${ps1pc_start}${ps1pc_end}"
#         fi
#         return
#     fi
# }

# Enable pyenv version in the prompt
# export PROMPT_COMMAND="${PROMPT_COMMAND}"'__pyenv_ps1 "" "" "${PROMPT_BLUE}pyenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

# ----------------------------------------------------------------------------
# rbenv prompt
# ----------------------------------------------------------------------------

# check whether printf supports -v
# __rbenv_printf_supports_v=
# printf -v __rbenv_printf_supports_v -- '%s' yes >/dev/null 2>&1

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
# __rbenv_ps1 ()
# {
#     local pcmode=no
#     local detached=no
#     local ps1pc_start='\u@\h:\w '
#     local ps1pc_end='\$ '
#     local printf_format=' (%s)'
#     local rbenv_version=$(rbenv version-name)

#     case "$#" in
#         2|3)
#             pcmode=yes
#             ps1pc_start="$1"
#             ps1pc_end="$2"
#             printf_format="${3:-${printf_format}}"
#         ;;
#         0|1)
#             printf_format="${1:-${printf_format}}"
#         ;;
#         *)
#             return
#         ;;
#     esac

#     if [ "${rbenv_version}" != "system" ]; then
#         if [ ${pcmode} = yes ]; then
#             if [ "${__rbenv_printf_supports_v-}" != yes ]; then
#                 rbenv_version=$(printf -- "${printf_format}" "${rbenv_version}")
#             else
#                 printf -v rbenv_version -- "${printf_format}" "${rbenv_version}"
#             fi
#             PS1="${ps1pc_start}${rbenv_version}${ps1pc_end}"
#         else
#             printf -- "${printf_format}" "${rbenv_version}"
#         fi
#     else
#         if [ ${pcmode} = yes ]; then
#             # in PC mode PS1 always needs to be set
#             PS1="${ps1pc_start}${ps1pc_end}"
#         fi
#         return
#     fi
# }

# Enable rbenv version in the prompt
# export PROMPT_COMMAND="${PROMPT_COMMAND}"'__rbenv_ps1 "" "" "${PROMPT_BLUE}rbenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

# ----------------------------------------------------------------------------
# End Prompt
# ----------------------------------------------------------------------------

export PROMPT_COMMAND="${PROMPT_COMMAND}"'PS1="${PS1_PREFIX}${PS1_PC}${PS1_SUFFIX}";'
export PS1="${PS1_PREFIX}${PS1_SUFFIX}"

# ----------------------------------------------------------------------------
# Bash Completion
# ----------------------------------------------------------------------------

# See http://trac.macports.org/wiki/howto/bash-completion

if [[ `echo $BASH_VERSION` < 4.1 ]]; then
    echo
    echo "WARNING: bash completion requires bash >= 4.1"
    echo
    echo "\$BASH_VERSION=$BASH_VERSION"
    echo
    cat <<EOF
The port bash-completion >=2.0 requires bash >=4.1; please make sure
you are using /opt/local/bin/bash by changing the preferences of your
terminal accordingly. If your version of bash is too old, the script
will not modify your shell environment and no extended completion
will be available.
EOF
else
    # ----------------------------------------------------------------------------
    # pip Bash completion
    # ----------------------------------------------------------------------------

    if command -v pip >/dev/null 2>&1; then
        eval "$(pip completion --bash)"
    fi

    # Make sure you add this after any PATH manipulation as otherwise the
    # bash-completion will not work correctly.
    if [ -r /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion
    fi
fi