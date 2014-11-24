#!/bin/bash
PatchDir=$TopDir/../patches/*/*.sh
for i in $PatchDir
do 
	echo "patching for source file $i"
	source $i
done
