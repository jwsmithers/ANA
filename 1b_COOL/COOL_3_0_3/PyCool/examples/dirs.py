#!/bin/env python

# This script simply lists the namespaces of cool, seal, pool, and std
# to show which classes/methods have been generated from the headers

from PyCoral import PyCintex
classes = PyCintex.getAllClasses()
for c in classes:
    if ( c.find('coral::') >= 0 ) \
           or ( c.find('boost::') >= 0 ) \
           or ( c.find('seal::')  >= 0 ) :
        # show only interesing classes
        print c
