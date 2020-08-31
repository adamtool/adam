#!/bin/bash
# @author Manuel Gieseking

IFS=',' read -r -a dep_folders <<< "$1"

if [[ -z ${msg} ]]; then
	echo 'You have to give a commit message with msg="<message>".'
else 
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    echo "%%%%%%%%%%%%%%%% DEPENDENCY: $dep"
		    if [ ! -f "$dep/.git" ]; then
                echo "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep                
                git commit -a -m "$msg"
                cd ..
            fi
    done
    echo "%%%%%%%%%%%%%%%% MAIN-REPO: adam"
	git commit -a -m "$msg" # main repo
fi

