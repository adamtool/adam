#!/bin/bash
# @author Manuel Gieseking

# import the coloring functions for the texts
source ./echoColoredTexts.sh

IFS=',' read -r -a dep_folders <<< "$1"

currentBranch=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')

printColored "> Merge '${branch}' into '$currentBranch'..."
if [[ -z ${branch} ]]; then
	printError 'You have to give a branch which should be merged with branch=<branch>.'
else 
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    printColored "%%%%%%%%%%%%%%%% DEPENDENCY: $dep" $blue
		    if [ ! -f "$dep/.git" ]; then
                printError "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep                
                git merge ${branch}
                cd ..
            fi
    done
    printColored "%%%%%%%%%%%%%%%% MAIN-REPO: adam" $blue
	git merge ${branch} # main repo
fi

