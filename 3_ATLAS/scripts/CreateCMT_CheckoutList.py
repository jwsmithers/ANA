# A script that creates the list in CMT format for easy checkout
from os import path
import sys
My_List = [line.split() for line in open(sys.argv[1])]
for i in My_List:
        j=i[1].split("/")
        if len(j)==2:
                print j[1], i[0], j[0]
        if len(j)==3:
                print j[2], i[0], path.join(j[0],j[1])
        if len(j)==1:
                print j[0],i[0]
