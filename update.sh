#!/bin/sh

# Split into two steps for the case where HOME contains a copy of an existing
# file in $HOME and stow will not --restow because of conflicts

# First, adopt any real files that match the files in HOME
# since we've already committed our changes, if the adopted file differs git
# status will show that it's been modified
while true; do
    read -p \
        "Do you wish to move (adopt) any files in \$HOME matching those in \
HOME/* (recommended)? " yn
    case $yn in
        [Yy]* )
            echo "Stowing HOME with --adopt option"
            stow "$@" --adopt HOME
            break
            ;;
        [Nn]* )
            break
            ;;
        * )
            echo "Please answer yes or no."
            ;;
    esac
done

# Second, restow to prune any stale symlinks
echo "Stowing HOME with --restow option (to prune any stale symlinks)"
stow "$@" --restow HOME
