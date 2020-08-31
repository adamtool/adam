#!/bin/bash
# @author Manuel Gieseking

IFS=',' read -r -a dep_folders <<< "$1"

if [[ -z ${branch} ]]; then
	echo 'You have to give a branch which should be merged with branch=<branch>.'
else 
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    echo "%%%%%%%%%%%%%%%% DEPENDENCY: $dep"
		    if [ ! -f "$dep/.git" ]; then
                echo "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep                
                git merge ${branch}
                cd ..
            fi
    done
    echo "%%%%%%%%%%%%%%%% MAIN-REPO: adam"
	git merge ${branch} # main repo
fi

