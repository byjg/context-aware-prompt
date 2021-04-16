#!/usr/bin/env bash

BASEDIR="$HOME/.bash"
REPODIR="$BASEDIR/context-aware-prompt"
PROFILE="$HOME/.bash_profile"

mkdir -p "$BASEDIR"
echo Repository on $REPODIR
echo
if [ ! -d "$REPODIR" ]
then
    cd "$BASEDIR"
    git clone https://github.com/byjg/context-aware-prompt.git
else
    cd "$REPODIR"
    echo "Updating local copy."
    git pull
fi

touch "$PROFILE"
if grep -q CONTEXT_AWARE_PROMPT "$PROFILE"
then
    echo
    echo Already installed on $PROFILE.
else
    echo
    echo Installing to $PROFILE
    echo "" >> $PROFILE
    echo '##Start Context Aware Prompt'  >> $PROFILE
    echo "alias ls='ls --color=always'" >> $PROFILE
    echo "export CONTEXT_AWARE_PROMPT=$REPODIR" >> $PROFILE
    echo "source \$CONTEXT_AWARE_PROMPT/main.sh" >> $PROFILE
    echo 'export PS1="\[$txtylw\]\$context_k8s\[$txtrst\]\n\u@\h \w \[$txtcyn\]\$context_git_branch\[$txtred\]\$context_git_dirty\[$txtrst\]\$ "' >> $PROFILE
    echo '##End Context Aware Prompt' >> $PROFILE
    echo ''  >> $PROFILE
fi
echo
echo "Done. Please open a new terminal to see the prompt."
echo
