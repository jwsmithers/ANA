#!/usr/bin/env python
import os, sys
from CoolLockSchemaStats import *

def usage() :
    cmd = os.path.split(sys.argv[0])[1]
    #print "Usage: " + cmd + " [-debug] dbId"
    print "Usage: " + cmd + " dbId"
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    if len(sys.argv)==2:
        debug=False
        dbId = sys.argv[1]
        lockSchemaStats( dbId, debug )
    #elif len(sys.argv)==3:
    #    if sys.argv[1]!="-debug": usage()
    #    debug=True
    #    dbId = sys.argv[2]
    #    lockSchemaStats( dbId, debug )
    else:
        usage()
