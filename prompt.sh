context_caller() {
  find_git_branch
  find_git_dirty
  find_kube_config
}

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local status
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    status=$(git status -sb 2> /dev/null | cut -d' ' -f3-4 | head -n1)
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    context_git_branch="($branch$status)"
  else
    context_git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    context_git_dirty='*'
  else
    context_git_dirty=''
  fi
}

execute_python() {
  local python=$(command -v python3 || command -v python)
  local workdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  if [[ "$python" == "" ]]; then
    return
  fi

  $python $workdir/$1 $2 2> /dev/null
}


find_kube_config() {
  context_k8s=$(execute_python parse_kubeconfig.py)
}

PROMPT_COMMAND="context_caller; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
