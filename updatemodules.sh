#!/bin/sh

if [[ ! -f ~/.vim/.submoduleinit ]] ; then
  # make sure we initialize the submodules
  echo "## -- initializing submodules -- ##"
  git submodule update --init
  touch ~/.vim/.submoduleinit
fi

# now, update all those submodules
echo "## -- pull all submodules -- ##"
git submodule foreach git pull origin master
git status | grep "new commits" | cut -d ' ' -f 4 | xargs git add
echo ""
echo "git commit -a"
git commit -a

