#!/bin/bash
# @author Manuel Gieseking

FOLDERS=("framework" "logics" "synthesizer" "modelchecker" "high-level" "synthesisDistrEnv" "boundedSynthesis" "server-command-line-protocol" "server-command-line" "ui" "adammc" "adamsynt" "adam" "webinterface-backend")

for folder in "${FOLDERS[@]}"
do
	echo "%%%%%%%%%%%%%%" $folder
	echo "classes: "$(find $folder -type f -name '*.java' | wc -l)
	lines=$(find $folder -type f -name '*.java' | xargs wc -l) 
	nbLines=0
	for file in $(find $folder -type f -name '*.java')
	do
		# sed deletes empty lines
		curLines=$(cat $file  | sed '/^\s*$/d' | wc -l | awk '{print $1}')
		nbLines=$(($nbLines+$curLines))
#		echo $nbLines
	done
	echo "lines: "$nbLines
done
 
