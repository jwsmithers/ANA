#!/bin/bash
PatchDir=$TopDir/../patches/*/*.sh
for i in $PatchDir
do 
	source $i
done
