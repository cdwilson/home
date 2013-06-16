# MacPorts Installer addition on 2011-09-25_at_16:19:49: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Make sure that the correct pip command is used for the currently selected python
# see http://stackoverflow.com/questions/12557114/macports-and-the-bash-path
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:$PATH

# coreutils
# If you want to use the GNU tools by default
# export PATH=/opt/local/libexec/gnubin/:$PATH

# MacTEX http://www.tug.org/mactex/multipletexdistributions.html
# export PATH=/usr/texbin:$PATH

# rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# Stow
export PATH=$HOME/stow/bin:$HOME/stow/sbin:/stow/bin:/stow/sbin:$PATH

# user paths
export PATH=$HOME/bin:$PATH
export MANPATH=$HOME/share/man:$MANPATH

# tinyos
export TOSROOT=$HOME/FCD/Projects/tinyos-main
export TOSDIR=$TOSROOT/tos
export CLASSPATH=$TOSROOT/support/sdk/java/tinyos.jar:.
export MAKERULES=$TOSROOT/support/make/Makerules
