#!/bin/bash
# @author Manuel Gieseking

# import the coloring functions for the texts
source ./echoColoredTexts.sh

IFS=',' read -r -a dep_folders <<< "$1"

printColored "> Getting status of repositories..."
for dep in "${dep_folders[@]}"	# all dependencies
    do	
	    printColored "%%%%%%%%%%%%%%%% DEPENDENCY: $dep" $blue
	    if [ ! -f "$dep/.git" ]; then
            printError "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
        else
            cd $dep                
            git status
            cd ..
        fi
done

printColore "%%%%%%%%%%%%%%%% MAIN-REPO: adam" $blue
git status
