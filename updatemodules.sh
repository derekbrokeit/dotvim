#!/bin/bash

pushd . > /dev/null

git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule update

popd > /dev/null
