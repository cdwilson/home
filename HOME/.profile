# The Bourne (sh) personal initialization file, executed for login shells

# ----------------------------------------------------------------------------
# Java
# ----------------------------------------------------------------------------

# export JAVA_HOME="$(/usr/libexec/java_home)"
# export JAVA_HOME=/Library/Java/Home
# export PATH="$JAVA_HOME/bin:$PATH"

# ----------------------------------------------------------------------------
# MacPorts paths
# ----------------------------------------------------------------------------

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export MANPATH="/opt/local/share/man:$MANPATH"

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
# MacPorts editor
# ----------------------------------------------------------------------------

# export MP_EDITOR="/usr/local/bin/mate -w"

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
# export PATH="$PYENV_ROOT/bin:$PATH"

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

export TOSROOT=$HOME/FCD/Projects/tinyos-main
export TOSDIR=$TOSROOT/tos
export CLASSPATH=$TOSROOT/support/sdk/java/tinyos.jar:.
export MAKERULES=$TOSROOT/support/make/Makerules

# ----------------------------------------------------------------------------
# Vagrant
# ----------------------------------------------------------------------------

export VAGRANT_DEFAULT_PROVIDER="vmware_fusion"
export VAGRANT_VMWARE_CLONE_DIRECTORY="~/Virtual Machines"

# ----------------------------------------------------------------------------
# User paths
# ----------------------------------------------------------------------------

# ~/bin
export PATH="$HOME/bin:$PATH"

# ~/share/man
export MANPATH="$HOME/share/man:$MANPATH"
