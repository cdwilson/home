alias la="ls -a" # list all, includes dot files
alias ll="ls -l" # long list, excludes dot files
alias lla="ls -la" # long list all, includes dot files

# Setup some colors to use later in interactive shell or scripts
export COLOR_RESET="\[\033[0m\]"
export COLOR_BLACK="\[\033[0;30m\]"
export COLOR_BRIGHT_BLACK="\[\033[1;30m\]"
export COLOR_RED="\[\033[0;31m\]"
export COLOR_BRIGHT_RED="\[\033[1;31m\]"
export COLOR_GREEN="\[\033[0;32m\]"
export COLOR_BRIGHT_GREEN="\[\033[1;32m\]"
export COLOR_YELLOW="\[\033[0;33m\]"
export COLOR_BRIGHT_YELLOW="\[\033[1;33m\]"
export COLOR_BLUE="\[\033[0;34m\]"
export COLOR_BRIGHT_BLUE="\[\033[1;34m\]"
export COLOR_MAGENTA="\[\033[0;35m\]"
export COLOR_BRIGHT_MAGENTA="\[\033[1;35m\]"
export COLOR_CYAN="\[\033[0;36m\]"
export COLOR_BRIGHT_CYAN="\[\033[1;36m\]"
export COLOR_WHITE="\[\033[0;37m\]"
export COLOR_BRIGHT_WHITE="\[\033[1;37m\]"

export EDITOR='/usr/bin/mate -w'
export LC_CTYPE=en_US.UTF-8
export RUBYOPT='rubygems'
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='--color=auto'
# http://www.geekology.co.za/blog/2009/04/enabling-bash-terminal-directory-file-color-highlighting-mac-os-x/
# export LSCOLORS=ExFxCxDxBxegedabagacad

# Erase history duplicates
export HISTCONTROL=erasedups
# resize history size
export HISTSIZE=5000
# append to bash_history if Terminal.app quits
shopt -s histappend

# git-completion.bash
source /opt/local/share/doc/git-core/contrib/completion/git-prompt.sh
export GIT_PS1_SHOWDIRTYSTATE=true #... untagged(*) and staged(+) changes
export GIT_PS1_SHOWSTASHSTATE=true #... if something is stashed($)
export GIT_PS1_SHOWUNTRACKEDFILES=true #... untracked files(%)
export GIT_PS1_SHOWUPSTREAM="auto verbose"

# Lion default
# export PS1="\h:\W \u\$ "

# From /opt/local/etc/bash_completion.d/git
# export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

PS1_USER="${COLOR_GREEN}\u${COLOR_RESET}"
PS1_AT="${COLOR_GREEN}@${COLOR_RESET}"
PS1_HOST="${COLOR_GREEN}\h${COLOR_RESET}"
PS1_CURDIR="${COLOR_YELLOW}\w${COLOR_RESET}"
PS1_GIT_FORMAT_STRING=" [${COLOR_BLUE}%s${COLOR_RESET}]"

# This works because Bash lets you "glue" together quoted strings into a
# single command as long as there are no spaces between the end of one quoted
# string and the start of the next quoted string.	Therefore, all the
# COLOR_XXXXX variables are expanded immediately because they are double
# quoted, whereas the __git_ps1 command is evaluated for each prompt because
# it is single quoted.
export PS1="${PS1_USER}${PS1_AT}${PS1_HOST} ${PS1_CURDIR}"'$(__git_ps1 "'"${PS1_GIT_FORMAT_STRING}"'")\n$ '

# coreutils
# If you want to use the GNU tools by default
# export PATH=/opt/local/libexec/gnubin/:$PATH

# MacPorts Installer addition on 2011-09-25_at_16:19:49: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# MacTEX http://www.tug.org/mactex/multipletexdistributions.html
export PATH=/usr/texbin:$PATH

# rvm
[[ -s "/Users/cwilson/.rvm/scripts/rvm" ]] && source "/Users/cwilson/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Stow
export PATH=$HOME/stow/bin:$HOME/stow/sbin:/stow/bin:/stow/sbin:$PATH

# user paths
export PATH=$HOME/bin:$PATH
export MANPATH=$HOME/share/man:$MANPATH

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_REQUIRE_VIRTUALENV=true

[[ -s "/usr/local/bin/virtualenvwrapper.sh" ]] && source "/usr/local/bin/virtualenvwrapper.sh"
alias v=workon
alias v.deactivate=deactivate
alias v.mk='mkvirtualenv --distribute'
alias v.mk_withsetuptools='mkvirtualenv'
alias v.mk_withsitepackages='mkvirtualenv --system-site-packages'
alias v.rm=rmvirtualenv
alias v.switch=workon
alias v.add2virtualenv=add2virtualenv
alias v.cdsitepackages=cdsitepackages
alias v.cd=cdvirtualenv
alias v.lssitepackages=lssitepackages

# Bash Completion
# note: must come after any PATH manipulation
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi