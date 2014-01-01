# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------

# source git-prompt.sh to enable __git_ps1
if [ -r /opt/local/share/git-core/git-prompt.sh ]; then
  . /opt/local/share/git-core/git-prompt.sh
fi

# __git_ps1 options
export GIT_PS1_SHOWDIRTYSTATE=true #... untagged(*) and staged(+) changes
export GIT_PS1_SHOWSTASHSTATE=true #... if something is stashed($)
export GIT_PS1_SHOWUNTRACKEDFILES=true #... untracked files(%)
export GIT_PS1_SHOWUPSTREAM="auto verbose name git"
export GIT_PS1_DESCRIBE_STYLE="branch"
# export GIT_PS1_SHOWCOLORHINTS=true

PS1_GIT_FORMAT_STRING="\n${COLOR_LIGHT_BLACK}git: ${COLOR_BLUE}%s${COLOR_RESET}"

# From /opt/local/etc/bash_completion.d/git
# export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# This works because Bash lets you "glue" together quoted strings into a
# single command as long as there are no spaces between the end of one quoted
# string and the start of the next quoted string. Therefore, all the
# PS1_XXXXX variables are expanded immediately because they are double
# quoted, whereas the __git_ps1 command is evaluated for each prompt because
# it is single quoted.
export PS1="${PS1}"'$(__git_ps1 "'"${PS1_GIT_FORMAT_STRING}"'")'
