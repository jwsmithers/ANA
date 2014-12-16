#!/usr/bin/python
import sys
from os import path
My_List = [line.split() for line in open("YumPackages.txt")]
for i in My_List:
        j=i[0].split("/")
        for k in j:
		if ".x86_64" in k:
			L=k.replace(".x86_64"," ")
			print str(L),
		else: 
			print k,
