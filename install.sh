#!/usr/bin/env bash

BASEDIR="$HOME/.bash"
REPODIR="$BASEDIR/git-aware-prompt"
PROFILE="$HOME/.bash_profile"

mkdir -p "$BASEDIR"
echo Repository on $REPODIR
echo
if [ ! -d "$REPODIR" ]
then
    cd "$BASEDIR"
    git clone https://github.com/byjg/git-aware-prompt.git
else
    cd "$REPODIR"
    echo "Updating local copy."
    git pull
fi

touch "$PROFILE"
if grep -q GITAWAREPROMPT "$PROFILE"
then
    echo
    echo Already installed on $PROFILE.
else
    echo
    echo Installing to $PROFILE
    echo ''  >> $PROFILE
    echo '##Start Context Aware Prompt'  >> $PROFILE
    echo "alias ls='ls --color=always'" >> $PROFILE
    echo "export GITAWAREPROMPT=$REPODIR" >> $PROFILE
    echo 'source $GITAWAREPROMPT/main.sh' >> $PROFILE
    echo 'export PS1_RESET="$PS1"' >> $PROFILE
    echo 'export PS1_GIT="\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]"' >> $PROFILE
    echo 'export PS1_K8S="\[$txtylw\]\$k8s_config\[$txtrst\]"' >> $PROFILE
    echo 'export PS1_ALL="$PS1_K8S$PS1_GIT"' >> $PROFILE
    if [[ "$1" == "git" ]]; then
      echo 'export PS1="\u@\h \w $PS1_GIT\$ "' >> $PROFILE
    elif [[ "$1" == "k8s" ]]; then
      echo 'export PS1="\u@\h \w $PS1_K8S\$ "' >> $PROFILE
    else
      echo 'export PS1="\u@\h \w $PS1_ALL\$ "' >> $PROFILE
    fi
    echo '##End Context Aware Prompt' >> $PROFILE
    echo ''  >> $PROFILE
fi
echo
echo "Done. Please open a new terminal to see the prompt."
echo
