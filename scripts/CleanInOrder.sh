#!/bin/bash

while read line
do
	cd $TopDir/$line/$line-$VERSION
	source BuildSetup.sh
	cd $TopDir/$line/$line-$VERSION/${line}Release/cmt
	cmt broadcast make clean	
	
done < Projects.txt
