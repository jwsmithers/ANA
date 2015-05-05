#!/bin/bash
PatchDir=$TopDir/patches/patches-ARM-$VERSION/*/*.sh
for i in $PatchDir
do 
	echo "patching for source file $i"
	source $i
done
