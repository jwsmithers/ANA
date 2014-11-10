#!/bin/bash
boxes WelcomeMSG.txt

echo "Setting up your directory structure..."
source Environment.sh
echo "You've identified your system as $CMTCONFIG"

alias goHome="cd $TopDir"

while read line 
do
        cmt create $TopDir/$line $line-$VERSION
	#alias $line="cd $TopDir/$line $line-$VERSION"
	cd $TopDir/$line/$line-$VERSION/cmt
	rm ./*
	echo "$line" >> project.cmt
done < Projects.txt


python <<END_OF_PYTHON
#!/usr/bin/env python

import sys

print ("xyzzy")

sys.exit(0)
END_OF_PYTHON

echo "goodbye!";
