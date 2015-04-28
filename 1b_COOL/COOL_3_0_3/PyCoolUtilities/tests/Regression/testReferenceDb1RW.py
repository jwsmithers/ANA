#!/usr/bin/env python

###print 'DEBUG: Import os, sys'
import os, sys

###print 'DEBUG: Import TestReferenceDb1RO'
###from PyCoolReferenceDb import TestReferenceDb1RO

print 'DEBUG: Import TestReferenceDb1RW'
from PyCoolReferenceDb import TestReferenceDb1RW

###print 'DEBUG: Import TestReferenceDb2RO'
###from PyCoolReferenceDb import TestReferenceDb2RO

execfile( os.path.dirname(os.path.realpath(sys.argv[0])) + "/testReferenceDb_driver.py" )
