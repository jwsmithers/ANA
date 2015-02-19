#!/bin/bash

while read line
do
	cd $TopDir/$line/$line-$VERSION
	source BuildSetup.sh
	cd $TopDir/$line/$line-$VERSION/${line}Release/cmt
	cmt config
	source setup.sh
	cmt broadcast cmt config
	cmt broadcast make -i -j4	
	cmt broadcast make -i -j4
	
done < WhatToBuild.txt
