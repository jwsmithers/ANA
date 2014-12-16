#!/bin/bash
while read line
do
	sudo yum install $line
done < YumInstall.txt
