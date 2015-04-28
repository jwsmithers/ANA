#!/bin/bash
files1=`find . -name '*.h'`
files2=`find . -name '*.cpp'`
files3=`find . -name '*.py'`
files4=`find . -name '*.*sh'`
wc -l `echo $files1 $files2 $files3 $files4 | sort`

