#!/bin/sh

# Split into two steps for the case where HOME contains a copy of an existing
# file in $HOME and stow will not --restow because of conflicts

# First, adopt any real files that match the files in HOME
# since we've already committed our changes, if the adopted file differs git
# status will show that it's been modified
while true; do
    read -p \
        "Do you wish to adopt any files in \$HOME matching those in HOME/*? " yn
    case $yn in
        [Yy]* ) stow "$1" --adopt HOME; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Second, restow to prune any stale symlinks
echo "Restowing HOME (to prune any stale symlinks)"
stow "$1" --restow HOME
