# The Bash personal interactive initialization file
# (only read by a Bash shell that's both interactive and non-login)

# References:
# http://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html

# ------------------------------------------------------------------------------
# Environment Configuration
# ------------------------------------------------------------------------------

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

exists ()
{
    builtin type "$1" &>/dev/null
}

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

# ------------------------------------------------------------------------------
# Shell
# ------------------------------------------------------------------------------

# Some tools (like bash completion) rely on the login shell instead of what the
# terminal started. On macOS, the default login shell is zsh (i.e. $SHELL =
# /bin/zsh), but my terminal is configured to use bash installed from homebrew
# instead. Since the homebrew bash may get uninstalled or corrupted, I don't
# want to change the login shell to use the homebrew bash. Instead of changing
# the login shell for my user account, I just set $SHELL here instead. Also,
# make sure to add this shell to /etc/shells.
# https://trac.macports.org/wiki/howto/bash-completion

# use bash from Homebrew
# export SHELL="/usr/local/bin/bash"

# use bash from Homebrew (Apple Silicon)
export SHELL="/opt/homebrew/bin/bash"

# ------------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------------

# Shell Environment (Apple Silicon)
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew pkg-config
export PKG_CONFIG_PATH="${HOMEBREW_PREFIX}/lib/pkgconfig"

# ------------------------------------------------------------------------------
# libffi
# ------------------------------------------------------------------------------

# libffi is keg-only, which means it was not symlinked into /usr/local,
# because some formulae require a newer version of libffi.
#
# For compilers to find libffi you may need to set:
#   export LDFLAGS="-L/usr/local/opt/libffi/lib"
#
# For pkg-config to find libffi you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$(brew --prefix libffi)/lib/pkgconfig"

# ------------------------------------------------------------------------------
# anyenv
# ------------------------------------------------------------------------------

export PATH="$HOME/.anyenv/bin:$PATH"

if exists anyenv; then
    eval "$(anyenv init -)"
fi

# ------------------------------------------------------------------------------
# pyenv-virtualenv
# ------------------------------------------------------------------------------

# pyenv-virtualenv plugin
if exists pyenv; then
    eval "$(pyenv virtualenv-init -)"
fi

# ------------------------------------------------------------------------------
# python virtualenv
# ------------------------------------------------------------------------------

# export VIRTUAL_ENV_DISABLE_PROMPT=true

# ------------------------------------------------------------------------------
# Vagrant
# ------------------------------------------------------------------------------

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Virtual Machines"

# ------------------------------------------------------------------------------
# Rust/Cargo
# ------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# ------------------------------------------------------------------------------
# User paths
# ------------------------------------------------------------------------------

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

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
        if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
        then
            source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
        else
            for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
            do
            [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
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
# Begin Prompt
# ------------------------------------------------------------------------------

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

# check whether printf supports -v
__printf_supports_v=
printf -v __printf_supports_v -- '%s' yes >/dev/null 2>&1

# ------------------------------------------------------------------------------
# Git prompt
# ------------------------------------------------------------------------------

if exists __git_ps1; then
    export PROMPT_COMMAND="${PROMPT_COMMAND}"'__git_ps1 "" "" "${PROMPT_BLUE}git:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

    # __git_ps1 options
    export GIT_PS1_SHOWDIRTYSTATE=true #... untagged(*) and staged(+) changes
    export GIT_PS1_SHOWSTASHSTATE=true #... if something is stashed($)
    export GIT_PS1_SHOWUNTRACKEDFILES=true #... untracked files(%)
    export GIT_PS1_SHOWUPSTREAM="auto verbose name git"
    export GIT_PS1_DESCRIBE_STYLE="branch"
    export GIT_PS1_SHOWCOLORHINTS=true
fi

# ------------------------------------------------------------------------------
# pyenv prompt
# ------------------------------------------------------------------------------

# if exists pyenv; then
#     # __pyenv_ps1 accepts 0 or 1 arguments (i.e., format string) when called
#     # from PS1 using command substitution in this mode it prints text to add to
#     # bash PS1 prompt
#     # 
#     # __pyenv_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
#     # in that case it _sets_ PS1. The arguments are parts of a PS1 string. when
#     # two arguments are given, the first is prepended and the second appended to
#     # the state string when assigned to PS1. The optional third parameter will
#     # be used as printf format string to further customize the output of the
#     # pyenv_version string.
#     __pyenv_ps1 ()
#     {
#         local pcmode=no
#         local detached=no
#         local ps1pc_start='\u@\h:\w '
#         local ps1pc_end='\$ '
#         local printf_format=' (%s)'
#         local pyenv_version=$(pyenv version-name)

#         case "$#" in
#             2|3)
#                 pcmode=yes
#                 ps1pc_start="$1"
#                 ps1pc_end="$2"
#                 printf_format="${3:-${printf_format}}"
#             ;;
#             0|1)
#                 printf_format="${1:-${printf_format}}"
#             ;;
#             *)
#                 return
#             ;;
#         esac

#         # if [ "${pyenv_version}" != "system" ]; then
#         if (pyenv local >/dev/null 2>&1); then
#             if [ ${pcmode} = yes ]; then
#                 if [ "${__printf_supports_v-}" != yes ]; then
#                     pyenv_version=$(printf -- "${printf_format}" "${pyenv_version}")
#                 else
#                     printf -v pyenv_version -- "${printf_format}" "${pyenv_version}"
#                 fi
#                 PS1="${ps1pc_start}${pyenv_version}${ps1pc_end}"
#             else
#                 printf -- "${printf_format}" "${pyenv_version}"
#             fi
#         else
#             if [ ${pcmode} = yes ]; then
#                 # in PC mode PS1 always needs to be set
#                 PS1="${ps1pc_start}${ps1pc_end}"
#             fi
#             return
#         fi
#     }

#     export PROMPT_COMMAND="${PROMPT_COMMAND}"'__pyenv_ps1 "" "" "${PROMPT_BLUE}pyenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'
# fi

# ------------------------------------------------------------------------------
# python virtualenv prompt
# ------------------------------------------------------------------------------

# if exists pyenv; then
#     # __virtualenv_ps1 accepts 0 or 1 arguments (i.e., format string) when
#     # called from PS1 using command substitution in this mode it prints text to
#     # add to bash PS1 prompt
#     # 
#     # __virtualenv_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND
#     # (pc) in that case it _sets_ PS1. The arguments are parts of a PS1 string.
#     # when two arguments are given, the first is prepended and the second
#     # appended to the state string when assigned to PS1. The optional third
#     # parameter will be used as printf format string to further customize the
#     # output of the virtualenv_name string.
#     __virtualenv_ps1 ()
#     {
#         local pcmode=no
#         local detached=no
#         local ps1pc_start='\u@\h:\w '
#         local ps1pc_end='\$ '
#         local printf_format=' (%s)'
#         local virtualenv_name="\$(basename '$VIRTUAL_ENV')"

#         case "$#" in
#             2|3)
#                 pcmode=yes
#                 ps1pc_start="$1"
#                 ps1pc_end="$2"
#                 printf_format="${3:-${printf_format}}"
#             ;;
#             0|1)
#                 printf_format="${1:-${printf_format}}"
#             ;;
#             *)
#                 return
#             ;;
#         esac

#         if [ -n "${VIRTUAL_ENV}" ] && [ -z "${VIRTUAL_ENV_DISABLE_PROMPT}" ]; then
#             if [ ${pcmode} = yes ]; then
#                 if [ "${__printf_supports_v-}" != yes ]; then
#                     virtualenv_name=$(printf -- "${printf_format}" "${virtualenv_name}")
#                 else
#                     printf -v virtualenv_name -- "${printf_format}" "${virtualenv_name}"
#                 fi
#                 PS1="${ps1pc_start}${virtualenv_name}${ps1pc_end}"
#             else
#                 printf -- "${printf_format}" "${virtualenv_name}"
#             fi
#         else
#             if [ ${pcmode} = yes ]; then
#                 # in PC mode PS1 always needs to be set
#                 PS1="${ps1pc_start}${ps1pc_end}"
#             fi
#             return
#         fi
#     }

#     export PROMPT_COMMAND="${PROMPT_COMMAND}"'__virtualenv_ps1 "" "" "${PROMPT_BLUE}virtualenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'
# fi

# ------------------------------------------------------------------------------
# rbenv prompt
# ------------------------------------------------------------------------------

# if exists rbenv; then
#     # __rbenv_ps1 accepts 0 or 1 arguments (i.e., format string) when called
#     # from PS1 using command substitution in this mode it prints text to add to
#     # bash PS1 prompt
#     # 
#     # __rbenv_ps1 requires 2 or 3 arguments when called from PROMPT_COMMAND (pc)
#     # in that case it _sets_ PS1. The arguments are parts of a PS1 string. when
#     # two arguments are given, the first is prepended and the second appended to
#     # the state string when assigned to PS1. The optional third parameter will
#     # be used as printf format string to further customize the output of the
#     # rbenv_version string.
#     __rbenv_ps1 ()
#     {
#         local pcmode=no
#         local detached=no
#         local ps1pc_start='\u@\h:\w '
#         local ps1pc_end='\$ '
#         local printf_format=' (%s)'
#         local rbenv_version=$(rbenv version-name)

#         case "$#" in
#             2|3)
#                 pcmode=yes
#                 ps1pc_start="$1"
#                 ps1pc_end="$2"
#                 printf_format="${3:-${printf_format}}"
#             ;;
#             0|1)
#                 printf_format="${1:-${printf_format}}"
#             ;;
#             *)
#                 return
#             ;;
#         esac

#         if [ "${rbenv_version}" != "system" ]; then
#             if [ ${pcmode} = yes ]; then
#                 if [ "${__printf_supports_v-}" != yes ]; then
#                     rbenv_version=$(printf -- "${printf_format}" "${rbenv_version}")
#                 else
#                     printf -v rbenv_version -- "${printf_format}" "${rbenv_version}"
#                 fi
#                 PS1="${ps1pc_start}${rbenv_version}${ps1pc_end}"
#             else
#                 printf -- "${printf_format}" "${rbenv_version}"
#             fi
#         else
#             if [ ${pcmode} = yes ]; then
#                 # in PC mode PS1 always needs to be set
#                 PS1="${ps1pc_start}${ps1pc_end}"
#             fi
#             return
#         fi
#     }

#     export PROMPT_COMMAND="${PROMPT_COMMAND}"'__rbenv_ps1 "" "" "${PROMPT_BLUE}rbenv:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'
# fi

# ------------------------------------------------------------------------------
# End Prompt
# ------------------------------------------------------------------------------

export PROMPT_COMMAND="${PROMPT_COMMAND}"'PS1="${PS1_PREFIX}${PS1_PC}${PS1_SUFFIX}";'
export PS1="${PS1_PREFIX}${PS1_SUFFIX}"
