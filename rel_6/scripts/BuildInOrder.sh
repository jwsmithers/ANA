#!/bin/bash

while read line
do
	cd $TopDir/$line/$VERSION
	source BuildSetup.sh
	cd $TopDir/$line/$VERSION/${line}Release/cmt
	cmt config
	source setup.sh
	cmt broadcast cmt config
	cmt broadcast make -i -j10 CMTEXTRATAGS=no-separate-debug	
#	cmt broadcast make QUICK=1 -i -j4
#        cmt broadcast make clean
	
done < .WhatToBuild.txt
