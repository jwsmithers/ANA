## Create a requirement file from the SVN*.txt list.
## The format is "use <folder> <version> <path to folder>
#!/usr/bin/python
import sys
from os import path
My_List = [line.split() for line in open(sys.argv[1])]
for i in My_List:
	j=i[0].split("/")
	if len(j)==2:
		print "use", j[1], i[1], j[0]
	if len(j)==3:
		print "use", j[2], i[1], path.join(j[0],j[1]) 
	if len(j)==1:
		print "use", j[0],i[1]
	
