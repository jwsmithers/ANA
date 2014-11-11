#!/bin/bash

while read line
do
	cd $TopDir/$line/$line-$VERSION
	source BuildSetup.sh
	cd ${line}Release/${line}Release-v*/cmt
	cmt config
	source setup.sh
	cmt broacast cmt config
	cmt broadcast make install_headers
	cmt broadcast make -i -j4		
	
done < Projects.txt
