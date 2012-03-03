#!/bin/bash

pushd . > /dev/null

git submodule foreach git pull origin master

popd > /dev/null
