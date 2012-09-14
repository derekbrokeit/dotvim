#!/bin/sh

# Attempt to update commandT
pushd . > /dev/null
ctdir=$HOME/.vim/bundle/commandT/ruby/command-t
ctfile=$ctdir/extconf.rb
if [[ -f $ctfile ]] ; then
  cd $ctdir
  echo "## -- Command-T: generate Makefile -- ##"
  ruby $ctfile
  echo "make ($PWD)"
  make clean
  make
  echo "    * exit: $?"
else
  echo "CommandT not was not able to rebuild"
fi
popd > /dev/null

