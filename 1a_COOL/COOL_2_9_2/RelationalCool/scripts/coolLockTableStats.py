#!/usr/bin/env python
import os, sys
from CoolLockTableStats import *

def usage() :
    cmd = os.path.split(sys.argv[0])[1]
    #print "Usage: " + cmd + " [-debug] dbId [tableName]"
    print "Usage: " + cmd + " dbId [tableName]"
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    if len(sys.argv)==2:
        debug=False
        dbId = sys.argv[1]
        tableName = ""
        lockTableStats( dbId, tableName, debug )
    elif len(sys.argv)==3:
        debug=False
        dbId = sys.argv[1]
        tableName = sys.argv[2]
        lockTableStats( dbId, tableName, debug )
    #elif len(sys.argv)==4:
    #    if sys.argv[1]!="-debug": usage()
    #    debug=True
    #    dbId = sys.argv[2]
    #    tableName = sys.argv[3]
    #    lockTableStats( dbId, tableName, debug )
    else:
        usage()
