# Login script for Bourne-compatible shells

# shellcheck shell=sh

# ------------------------------------------------------------------------------
# Set ENV if bash is invoked as sh
# ------------------------------------------------------------------------------

# When invoked as an interactive shell with the name sh, Bash looks for the
# variable ENV, expands its value if it is defined, and uses the expanded value
# as the name of a file to read and execute. For more details, see
# https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html

if [ -r "${HOME}/.shrc" ]; then
    export ENV="${HOME}/.shrc"
fi

# ------------------------------------------------------------------------------
# Source shell functions
# ------------------------------------------------------------------------------

if [ -r "${HOME}/.sh_functions" ]; then
    . "${HOME}/.sh_functions"
fi

# ------------------------------------------------------------------------------
# Homebrew
# ------------------------------------------------------------------------------

case $(os_type) in
    linux*)
        if executable_exists "${HOME}/.linuxbrew/bin/brew"; then
            HOMEBREW_BIN="${HOME}/.linuxbrew/bin/brew"
        elif executable_exists "/home/linuxbrew/.linuxbrew/bin/brew"; then
            HOMEBREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
        fi
        ;;
    darwin*)
        if cpu_is_apple_silicon && shell_is_native ; then
            if executable_exists "/opt/homebrew/bin/brew"; then
                HOMEBREW_BIN="/opt/homebrew/bin/brew"
            fi
        else
            if executable_exists "/usr/local/bin/brew"; then
                HOMEBREW_BIN="/usr/local/bin/brew"
            fi
        fi
        ;;
    *)
        ;;
esac

if [ -n "${HOMEBREW_BIN}" ]; then
    brew_shellenv=$("${HOMEBREW_BIN}" shellenv)
    eval "${brew_shellenv}"
fi

# ------------------------------------------------------------------------------
# Shell
# ------------------------------------------------------------------------------

# On macOS, the default login shell is zsh (i.e. $SHELL = /bin/zsh).  If the
# terminal is configured to run a different shell (e.g. bash installed by
# homebrew), the value of the environment variable $SHELL won't match the shell
# started by the terminal. Some tools (like bash completion, tmux, screen, etc)
# rely on the login shell ($SHELL) so it needs to match the shell started by the
# terminal.  If the login shell is not changed in the macOS system preferences
# to match the shell started by the terminal, make sure to uncomment the code
# below to ensure $SHELL is set correctly.
#
# Also, remember to add your login shell to the file /etc/shells, otherwise it
# will be impossible to use AppleScript to tell Terminal to execute scripts
# (like 'osascript -e "tell application \"Terminal\" to do script \"echo
# hello\""').
# See https://trac.macports.org/wiki/howto/bash-completion

# case $(os_type) in
#     darwin*)
#         # Homebrew Bash
#         if executable_exists brew; then
#             export SHELL="${HOMEBREW_PREFIX}/bin/bash"
#         fi
#         ;;
#     *)
#         ;;
# esac

# ------------------------------------------------------------------------------
# pkg-config
# ------------------------------------------------------------------------------

# Homebrew pkg-config
if executable_exists brew; then
    PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig"
    export PKG_CONFIG_PATH
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
if executable_exists brew; then
    PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:$(brew --prefix libffi)/lib/pkgconfig"
    export PKG_CONFIG_PATH
fi

# ------------------------------------------------------------------------------
# rbenv
# ------------------------------------------------------------------------------

# Manually set RBENV_ROOT for rbenv installed manually via Basic GitHub Checkout
# https://github.com/rbenv/rbenv#basic-github-checkout
export RBENV_ROOT="${HOME}/.rbenv"

if [ -d "${RBENV_ROOT}" ]; then
    export PATH="${RBENV_ROOT}/bin:${PATH}"
    # Don't use `rbenv init -` directly because it doesn't support --path like
    # pyenv does. Instead, remove any lines that don't set the PATH and then
    # eval. Then, do the rest of the shell initialization in the interactive
    # initialization file (e.g. ~/.bashrc).
    rbenv_init_path=$(rbenv init - | sed '/export PATH/!d')
    eval "${rbenv_init_path}"
fi

# ------------------------------------------------------------------------------
# pyenv
# ------------------------------------------------------------------------------

# Manually set PYENV_ROOT for pyenv installed manually via Basic GitHub Checkout
# https://github.com/pyenv/pyenv#basic-github-checkout
export PYENV_ROOT="${HOME}/.pyenv"

if [ -d "${PYENV_ROOT}" ]; then
    export PATH="${PYENV_ROOT}/bin:${PATH}"
    pyenv_init_path=$(pyenv init --path)
    eval "${pyenv_init_path}"
fi

# ------------------------------------------------------------------------------
# pyenv-virtualenv
# ------------------------------------------------------------------------------

if [ -n "${PYENV_ROOT}" ] && [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
    # Don't use `pyenv virtualenv-init -` directly because it doesn't support
    # --path like pyenv does. Instead, remove any lines that don't set the PATH
    # and then eval. Then, do the rest of the shell initialization in the
    # interactive initialization file (e.g. ~/.bashrc).
    pyenv_virtualenv_init_path=$(pyenv virtualenv-init - | sed '/export PATH/!d')
    eval "${pyenv_virtualenv_init_path}"
fi

# ------------------------------------------------------------------------------
# Rust/Cargo
# ------------------------------------------------------------------------------

if [ -r "${HOME}/.cargo/env" ]; then
    # shellcheck source=/dev/null
    . "${HOME}/.cargo/env"
fi

# ------------------------------------------------------------------------------
# Vagrant
# ------------------------------------------------------------------------------

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="${HOME}/Virtual Machines"

# ------------------------------------------------------------------------------
# User paths
# ------------------------------------------------------------------------------

# pipx exposes binaries in this directory
if [ -d "${HOME}/.local/bin" ] ; then
    export PATH="${HOME}/.local/bin:${PATH}"
fi

# copied from Ubuntu .profile
if [ -d "${HOME}/bin" ] ; then
    export PATH="${HOME}/bin:${PATH}"
fi
