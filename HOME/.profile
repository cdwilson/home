# The Bourne (sh) personal initialization file, executed for login shells

# ----------------------------------------------------------------------
# .profile.d
# ----------------------------------------------------------------------

# source any extra login files in .profile.d
if [ -d $HOME/.profile.d ]; then
  for file in $HOME/.profile.d/*.sh; do
    if [ -r $file ]; then
      . $file
    fi
  done
  unset file
fi

# ----------------------------------------------------------------------
# User paths
# ----------------------------------------------------------------------

# ~/bin
export PATH="$HOME/bin:$PATH"

# ~/share/man
export MANPATH="$HOME/share/man:$MANPATH"
