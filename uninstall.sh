#!/usr/bin/env bash

BASEDIR="$HOME/.bash"
REPODIR="$BASEDIR/context-aware-prompt"
PROFILE="$HOME/.bash_profile"

if [[ ! -f $PROFILE ]]; then
  exit 1
fi

sed -i '/^##Start Context/,/^##End Context/{/^##Start Context/!{/^##End Context/!d}}' $PROFILE
sed -i '/^##Start Context/d' $PROFILE
sed -i '/^##End Context/d' $PROFILE

