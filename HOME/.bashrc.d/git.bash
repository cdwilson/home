# ----------------------------------------------------------------------
# Git
# ----------------------------------------------------------------------

# source git-prompt.sh to enable __git_ps1
if [ -r /opt/local/share/git/git-prompt.sh ]; then
  . /opt/local/share/git/git-prompt.sh
fi

# Enable git status in the prompt
export PROMPT_COMMAND="${PROMPT_COMMAND}"'__git_ps1 "" "" "${PROMPT_BLUE}git:${PROMPT_RESET} %s\n";PS1_PC="${PS1_PC}${PS1}";'

# __git_ps1 options
export GIT_PS1_SHOWDIRTYSTATE=true #... untagged(*) and staged(+) changes
export GIT_PS1_SHOWSTASHSTATE=true #... if something is stashed($)
export GIT_PS1_SHOWUNTRACKEDFILES=true #... untracked files(%)
export GIT_PS1_SHOWUPSTREAM="auto verbose name git"
export GIT_PS1_DESCRIBE_STYLE="branch"
export GIT_PS1_SHOWCOLORHINTS=true
