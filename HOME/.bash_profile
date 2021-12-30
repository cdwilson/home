# The Bash personal initialization file, executed for bash login shells

# ------------------------------------------------------------------------------
# Helper Functions
# ------------------------------------------------------------------------------

exists ()
{
    builtin type "$1" &>/dev/null
}

os_type ()
{
    uname | tr '[:upper:]' '[:lower:]'
}

cpu_is_apple_silicon ()
{
    [[ $(sysctl -n machdep.cpu.brand_string) =~ "Apple" ]]
}

process_is_translated ()
{
    [[ $(sysctl -n sysctl.proc_translated) ]]
}

process_is_native ()
{
    ! [[ $(sysctl -n sysctl.proc_translated) ]]
}

# ------------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------------

case $(os_type) in
    linux*)
        exists "$HOME/.linuxbrew/bin/brew" && eval "$($HOME/.linuxbrew/bin/brew shellenv)"
        exists "/home/linuxbrew/.linuxbrew/bin/brew" && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        ;;
    darwin*)
        if [[ cpu_is_apple_silicon && process_is_native ]]; then
            exists "/opt/homebrew/bin/brew" && eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            exists "/usr/local/bin/brew" && eval "$(/usr/local/bin/brew shellenv)"
        fi
        ;;
    *)
        ;;
esac

# ------------------------------------------------------------------------------
# Shell
# ------------------------------------------------------------------------------

# On macOS, the default login shell is zsh (i.e. $SHELL = /bin/zsh).  If the
# terminal is configured to run a different shell (e.g. bash installed by
# homebrew), the value of the environment variable $SHELL won't match the shell
# started by the terminal. Some tools (like bash completion) use $SHELL so it
# needs to match the shell started by the terminal.  If the login shell is not
# changed in the system preferences to match the shell started by the terminal,
# make sure to uncomment the code below to ensure $SHELL is set correctly.
# 
# Also, make sure to add the shell to /etc/shells (see
# https://trac.macports.org/wiki/howto/bash-completion)

# if exists brew; then
#     case $(os_type) in
#         darwin*)
#             export SHELL="$(brew --prefix)/bin/bash"
#             ;;
#         *)
#             ;;
#     esac
# fi

# ------------------------------------------------------------------------------
# pkg-config
# ------------------------------------------------------------------------------

# Homebrew pkg-config
if exists brew; then
    export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig"
fi

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
if exists brew; then
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$(brew --prefix libffi)/lib/pkgconfig"
fi

# ------------------------------------------------------------------------------
# anyenv
# ------------------------------------------------------------------------------

if exists "$HOME/.anyenv/bin/anyenv"; then
    export PATH="$HOME/.anyenv/bin:$PATH"
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
# Rust/Cargo
# ------------------------------------------------------------------------------

. "$HOME/.cargo/env"

# ------------------------------------------------------------------------------
# Vagrant
# ------------------------------------------------------------------------------

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Virtual Machines"

# ------------------------------------------------------------------------------
# User paths
# ------------------------------------------------------------------------------

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# ------------------------------------------------------------------------------
# iTerm2 Shell Integration
# ------------------------------------------------------------------------------

test -e ~/.iterm2_shell_integration.bash && . ~/.iterm2_shell_integration.bash || true

# ------------------------------------------------------------------------------
# If this is an interactive shell include .bashrc
# ------------------------------------------------------------------------------

# https://news.ycombinator.com/item?id=4369840
[[ $- == *i* ]] && . $HOME/.bashrc
