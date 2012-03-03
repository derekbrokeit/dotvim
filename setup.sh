#!/bin/bash

if [[ -f $HOME/.vimrc ]] ; then
  echo "backing up old ~/.vimrc --> ~/.vimrc.backup"
  mv ~/.vimrc ~/.vimrc.backup
fi

ln -s $HOME/.vim/vimrc $HOME/.vimrc
