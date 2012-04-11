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
echo "git commit "
git commit

# Attempt to update commandT
pushd . > /dev/null
ctdir=$HOME/.vim/bundle/commandT/ruby/command-t
ctfile=$ctdir/extconf.rb
if [[ -f $ctfile ]] ; then
  cd $ctdir
  echo "## -- Command-T: generate Makefile -- ##"
  ruby $ctfile
  echo "make ($PWD)"
  make
  echo "    * exit: $?"
else
  echo "CommandT not was not able to rebuild"
fi
popd > /dev/null

