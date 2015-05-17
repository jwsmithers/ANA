#!/bin/sh

#temp script... just lists all the patch contents
PatchDir=$TopDir/patches/tdaq-common-01-32-00-patches/*/*.patch
for i in $PatchDir
do
	echo -e "\x1B[31m XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX \x1B[0m"
        echo -e "\x1B[32m Looking at $i. \x1B[0m"
        cat ${i}
done
