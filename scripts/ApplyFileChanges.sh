#!/bin/bash
pathtofiles=$TopDir/../fileChanges/fileChanges-ARM-$VERSION/*/*
for i in $pathtofiles
do 
	echo "Applying file changes..."
	source $i
done
