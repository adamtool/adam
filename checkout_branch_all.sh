#!/bin/bash
# @author Manuel Gieseking
if [ -z ${branch} ]; then
	branch=master
fi
git submodule foreach --recursive git checkout ${branch}
git checkout ${branch}
