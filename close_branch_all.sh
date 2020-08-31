#!/bin/bash
# @author Manuel Gieseking

IFS=',' read -r -a dep_folders <<< "$1"

if [[ -z ${branch} ]]; then
	echo 'You have to give a branch which should be closed with branch=<branch>.'
else 
    if [[ -z ${tag} ]]; then
        tag_name="branch-${branch}"
    else
        tag_name=${tag}
    fi    
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    echo "%%%%%%%%%%%%%%%% DEPENDENCY: $dep"
		    if [ ! -f "$dep/.git" ]; then
                echo "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep            
                git tag -a "${tag_name}" -m "Closed branch: ${branch}"
                git push --tags
                git branch -d ${branch}
                git push
                cd ..
            fi
    done
    echo "%%%%%%%%%%%%%%%% MAIN-REPO: adam"
    git tag -a "${tag_name}" -m "Closed branch: ${branch}"
    git push --tags
    git branch -d ${branch}
    git push
fi

