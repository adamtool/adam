#!/bin/bash
# @author Manuel Gieseking

# import the coloring functions for the texts
source ./echoColoredTexts.sh

IFS=',' read -r -a dep_folders <<< "$1"

printColored "> Closing branch '${branch}'..."
if [[ -z ${branch} ]]; then
	printError "You have to give a branch which should be closed with branch=<branch>."
else 
    if [[ -z ${tag} ]]; then
        tag_name="branch-${branch}"
    else
        tag_name=${tag}
    fi    
    for dep in "${dep_folders[@]}"	# all dependencies
	    do	
		    printColored "%%%%%%%%%%%%%%%% DEPENDENCY: $dep" $blue
		    if [ ! -f "$dep/.git" ]; then
                printError "The dependency is missing. Please execute 'git submodule update --init "$dep"' first."
            else
                cd $dep            
                printColored "> Adding and pushing a tag to remember branch '${branch}'..."
                git tag -a "${tag_name}" -m "Closed branch: ${branch}"
                git push --tags
                printColored "> Deleting branch '${branch}'..."
                git branch -d ${branch}
                printColored "> Pushing the changes..."
                git push origin :${branch}
                cd ..
            fi
    done
    printColored "%%%%%%%%%%%%%%%% MAIN-REPO: adam" $blue
    printColored "> Adding and pushing a tag to remember branch '${branch}'..."
    git tag -a "${tag_name}" -m "Closed branch: ${branch}"
    git push --tags
    printColored "> Deleting branch '${branch}'..."
    git branch -d ${branch}
    printColored "> Pushing the changes..."
    git push origin :${branch}
fi

