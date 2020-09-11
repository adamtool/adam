#!/bin/bash
# @author Manuel Gieseking

# import the coloring functions for the texts
source ./echoColoredTexts.sh

if [ -z ${branch} ]; then
	branch=master
fi
if [ -z ${new} ]; then # it is not set, just check out the existing branches
    printColored "> Checking out branch '${branch}' for all submodules..."
    git submodule foreach --recursive git checkout ${branch}
    printColored "> Checking out branch '${branch}' for the main repository..."
    git checkout ${branch}
else # new is set, hence, create new branches
    printColored "> Create branch '${branch}' new for all submodules..."
    git submodule foreach --recursive git checkout -b ${new}
    printColored "> Create branch '${branch}' new for the main repository..."
    git checkout -b ${new}
fi
