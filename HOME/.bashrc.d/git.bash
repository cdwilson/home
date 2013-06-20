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
export GIT_PS1_SHOWUPSTREAM="auto verbose"

PS1_USER="${COLOR_GREEN}\u${COLOR_RESET}"
PS1_AT="${COLOR_GREEN}@${COLOR_RESET}"
PS1_HOST="${COLOR_GREEN}\h${COLOR_RESET}"
PS1_CURDIR="${COLOR_YELLOW}\w${COLOR_RESET}"
PS1_GIT_FORMAT_STRING=" [${COLOR_BLUE}%s${COLOR_RESET}]"

# From /opt/local/etc/bash_completion.d/git
# export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '

# This works because Bash lets you "glue" together quoted strings into a
# single command as long as there are no spaces between the end of one quoted
# string and the start of the next quoted string. Therefore, all the
# PS1_XXXXX variables are expanded immediately because they are double
# quoted, whereas the __git_ps1 command is evaluated for each prompt because
# it is single quoted.
PS1="${PS1_USER}${PS1_AT}${PS1_HOST} ${PS1_CURDIR}"'$(__git_ps1 "'"${PS1_GIT_FORMAT_STRING}"'")\n$ '
