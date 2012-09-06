#!/bin/bash

# make sure that the script is being called from the right directory
pushd . > /dev/null
cd ${0%/*}

# check if the vimrc is a symbolic link
if [[ ! -h $HOME/.vimrc ]] ; then
  echo "## -- linking to vimrc -- #"
  rm $HOME/.vimrc &> /dev/null
  ln -s $PWD/vimrc $HOME/.vimrc
fi
if [[ ! -h $HOME/.gvimrc ]] ; then
  rm $HOME/.gvimrc &> /dev/null
  ln -s $PWD/gvimrc $HOME/.gvimrc
fi
if [[ ! -h $HOME/.NERDTreeBookmarks ]] ; then
  rm $HOME/.gvimrc &> /dev/null
  ln -s $PWD/NERDTreeBookmarks $HOME/.NERDTreeBookmarks
fi

# make sure that vim-tmp directory exists ... if not, make it
EDITOR_TMP="${HOME}/.${EDITOR}-tmp"
if [[ "x$EDITOR_TMP" != "x" && ( ! -d $EDITOR_TMP || ! -d $EDITOR_TMP/backup ) ]] ; then
  echo "## -- making editor-tmp: $EDITOR_TMP -- ##"
  mkdir -p $EDITOR_TMP/backup
fi

# return to the original directory
popd > /dev/null

# make sure that the tmp folder and backup folder are present
mkdir -p ~/.vim-tmp/backup

