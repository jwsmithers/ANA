#!/bin/bash
pathtofiles=$TopDir/../fileChanges/*/*
for i in $pathtofiles
do 
	source $i
done
