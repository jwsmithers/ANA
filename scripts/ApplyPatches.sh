#!/bin/bash

Patch=$TopDir/../patches/*/*.patch
DirLocation=`cat $TopDir/../patches/*/*.txt`


for i in $Patch
do 
	echo "Applying patch: ${i}"
	cd $DirLocation
	patch -b < ${i}

done
