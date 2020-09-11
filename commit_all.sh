#!/bin/bash
# @author Manuel Gieseking

# import the coloring functions for the texts
source ./echoColoredTexts.sh

IFS=',' read -r -a dep_folders <<< "$1"

printColored "> Commit all changes..."
if [[ -z ${msg} ]]; then
	printError 'You have to give a commit message with msg="<message>".'
else 
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    printColored "%%%%%%%%%%%%%%%% DEPENDENCY: $dep" $blue
		    if [ ! -f "$dep/.git" ]; then
                printError "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep                
                git commit -a -m "$msg"
                cd ..
            fi
    done
    printColored "%%%%%%%%%%%%%%%% MAIN-REPO: adam" $blue
	git commit -a -m "$msg" # main repo
fi

