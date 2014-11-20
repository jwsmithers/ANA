#!/bin/bash
pathtofiles=$TopDir/../fileChanges/*/*
for i in $pathtofiles
do 
	echo "Applying file changes..."
	source $i
done
