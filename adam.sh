#!/bin/bash

BASEDIR="$(dirname $0)"

if [ ! -f "$BASEDIR/adam.jar" ] ; then
	echo "adam.jar not found! Run 'ant jar' first!" >&2
	exit 127
fi

java -jar "$BASEDIR/adam.jar" $@
