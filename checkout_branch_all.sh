#!/bin/bash
# @author Manuel Gieseking
if [ -z ${branch} ]; then
	branch=master
fi
if [ -z ${new} ]; then # it is not set, just check out the existing branches
    git submodule foreach --recursive git checkout ${branch}
    git checkout ${branch}
else # new is set, hence, create new branches
    git submodule foreach --recursive git checkout -b ${new}
    git checkout -b ${new}
fi
