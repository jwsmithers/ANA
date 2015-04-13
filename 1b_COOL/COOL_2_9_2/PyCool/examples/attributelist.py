#!/bin/env python

# Demonstrates how to use the coral.AttributeList.

from PyCool import coral

print 'setting up attrList'
attrList = coral.AttributeList()
attrList.extend("f","float")
attrList.extend("i","int")
attrList.extend("d","double")

print 'fields:', attrList.keys()
print 'types:', attrList.typeNames()

for f in attrList:
    print '\tfield:', f, 'type:', attrList.typeName(f), 'value:', repr(attrList[f])

print ""
print attrList

