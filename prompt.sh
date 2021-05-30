find_git_branch() {
  # Ref: http://stackoverflow.com/a/13003854/170413
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
  # if branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="$branch"
  else
    git_branch=""
  fi
}

find_git_remote() {
  # Ref: https://www.atlassian.com/git/tutorials/git-forks-and-upstreams
  git_upstream=$(git config branch.$(git rev-parse --abbrev-ref HEAD 2> /dev/null).remote 2> /dev/null)
}

get_GAP() {
  if [[ "$git_dirty" == "*" ]]; then
    if [[ -z "$git_upstream" ]] && [[ -z "$git_branch" ]] ; then
      # Remote and branch does not exist
      GAP="";
    elif [[ -z "$git_upstream" ]]; then
      # Remote does not exist
      GAP="$txtcyn[$txtred$git_branch$txtcyn]$txtred$txtrst";
    else
      # Remote exists
      GAP="$txtcyn[$git_upstream$txtwht -> $txtred$git_branch$txtcyn]$txtrst";
    fi
  else
    if [[ -z "$git_upstream" ]] && [[ -z "$git_branch" ]] ; then
      # Remote and branch does not exist
      GAP="";
    elif [[ -z "$git_upstream" ]]; then
      # Remote does not exist
      GAP="$txtcyn[$git_branch]$txtred$git_dirty$txtrst";
    else
      # Remote exists
      GAP="$txtcyn[$git_upstream$txtwht -> $txtgrn$git_branch$txtcyn]$txtred$git_dirty$txtrst";
    fi
  fi

}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_remote; find_git_dirty; get_GAP; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "

# Using GAP function
# export PS1="\w \$GAP\$ "
# export PS1="\[$bldgrn\]\w\[$txtrst\] \$GAP\$ "
