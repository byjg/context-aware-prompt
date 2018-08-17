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
    git clone git://github.com/byjg/git-aware-prompt.git
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
    echo '# /-- Bash Git: Start'  >> $PROFILE
    echo "alias ls='ls --color=always'" >> $PROFILE
    echo "export GITAWAREPROMPT=$REPODIR" >> $PROFILE
    echo 'source $GITAWAREPROMPT/main.sh' >> $PROFILE
    echo 'export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "' >> $PROFILE
    echo '# \-- Bash Git: End'  >> $PROFILE
fi
echo
echo "Done. Please open a new terminal to see the prompt."
echo
