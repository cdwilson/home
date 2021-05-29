# The Bourne (sh) personal initialization file, executed for login shells

# ----------------------------------------------------------------------------
# Shell
# ----------------------------------------------------------------------------

# use bash from MacPorts (required for bash-completion)
# export SHELL="/opt/local/bin/bash"

# use bash from Homebrew (required for bash-completion)
export SHELL="/usr/local/bin/bash"

# ----------------------------------------------------------------------------
# Java
# ----------------------------------------------------------------------------

# export JAVA_HOME="$(/usr/libexec/java_home)"
# export JAVA_HOME=/Library/Java/Home
# export PATH="$JAVA_HOME/bin:$PATH"

# ----------------------------------------------------------------------------
# MacPorts paths
# ----------------------------------------------------------------------------

# export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# export MANPATH="/opt/local/share/man:$MANPATH"

# ----------------------------------------------------------------------------
# GNU coreutils
# ----------------------------------------------------------------------------

# The tools provided by GNU coreutils are prefixed with the character 'g' by
# default to distinguish them from the BSD commands. For example, cp becomes
# gcp and ls becomes gls.

# If you want  to use the GNU tools by default, add  this directory to the
# front of your PATH environment variable:
#     /opt/local/libexec/gnubin/

# ----------------------------------------------------------------------------
# pkg-config
# ----------------------------------------------------------------------------

# MacPorts
# export PKG_CONFIG_PATH="/opt/local/lib/pkgconfig"

# Homebrew
export PKG_CONFIG_PATH="$(brew --prefix)/lib/pkgconfig"

# libffi is keg-only, which means it was not symlinked into /usr/local,
# because some formulae require a newer version of libffi.
#
# For compilers to find libffi you may need to set:
#   export LDFLAGS="-L/usr/local/opt/libffi/lib"
#
# For pkg-config to find libffi you may need to set:
#   export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$(brew --prefix libffi)/lib/pkgconfig"

# ----------------------------------------------------------------------------
# MacTEX
# ----------------------------------------------------------------------------

# http://www.tug.org/mactex/multipletexdistributions.html
# export PATH="/usr/texbin:$PATH"

# ----------------------------------------------------------------------------
# anyenv
# ----------------------------------------------------------------------------

export PATH="$HOME/.anyenv/bin:$PATH"

# ----------------------------------------------------------------------------
# pyenv
# ----------------------------------------------------------------------------

# export PYENV_ROOT="$HOME/.pyenv"
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# ----------------------------------------------------------------------------
# pipenv
# ----------------------------------------------------------------------------

export PIPENV_SHELL_FANCY=true

# ----------------------------------------------------------------------------
# pipx
# ----------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.7/bin:$PATH"

# ----------------------------------------------------------------------------
# poetry
# ----------------------------------------------------------------------------

export PATH="$HOME/.poetry/bin:$PATH"

# ----------------------------------------------------------------------------
# rvm
# ----------------------------------------------------------------------------

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# ----------------------------------------------------------------------------
# rbenv
# ----------------------------------------------------------------------------

# export RBENV_ROOT="$HOME/.rbenv"
# export PATH="$RBENV_ROOT/bin:$PATH"

# ----------------------------------------------------------------------------
# TinyOS
# ----------------------------------------------------------------------------

# export TOSROOT=$HOME/FCD/Projects/tinyos-main
# export TOSDIR=$TOSROOT/tos
# export CLASSPATH=$TOSROOT/support/sdk/java/tinyos.jar:.
# export MAKERULES=$TOSROOT/support/make/Makerules

# ----------------------------------------------------------------------------
# Vagrant
# ----------------------------------------------------------------------------

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Virtual Machines"

# ----------------------------------------------------------------------------
# Rust/Cargo
# ----------------------------------------------------------------------------

export PATH="$HOME/.cargo/bin:$PATH"

# ----------------------------------------------------------------------------
# rshell (MicroPython)
# ----------------------------------------------------------------------------

export RSHELL_BAUD="115200"
export RSHELL_PORT="/dev/tty.usbmodem3189367630342"

# ----------------------------------------------------------------------------
# User paths
# ----------------------------------------------------------------------------

# ~/bin
export PATH="$HOME/bin:$PATH"

# ~/share/man
export MANPATH="$HOME/share/man:$MANPATH"
