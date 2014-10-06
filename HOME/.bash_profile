# The Bash personal initialization file, executed for bash login shells

# source Bourne compatible .profile first
if [ -r $HOME/.profile ]; then
    . $HOME/.profile
fi

# https://news.ycombinator.com/item?id=4369840
# if this is an interactive shell include .bashrc
[[ $- == *i* ]] && . $HOME/.bashrc
