# The personal initialization file, executed for bash login shells

# source Bourne compatible .profile first 
if [ -r $HOME/.profile ]; then
    . $HOME/.profile
fi

# source any extra bash login files in .bash_profile.d
if [ -d $HOME/.bash_profile.d ]; then
    for file in $HOME/.bash_profile.d/*.bash; do
        if [ -r $file ]; then
            . $file
        fi
    done
    unset file
fi

# https://news.ycombinator.com/item?id=4369840
# if this is an interactive shell include .bashrc
[[ $- == *i* ]] && . $HOME/.bashrc
