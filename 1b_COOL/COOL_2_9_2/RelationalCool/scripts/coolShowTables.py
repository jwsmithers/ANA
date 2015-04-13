#!/usr/bin/env python
import os, sys
from CoolShowTables import *

def usage() :
    cmd = os.path.split(sys.argv[0])[1]
    print "Usage: " + cmd + " [-debug] dbId"
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    if len(sys.argv)<2 : usage()
    if sys.argv[1]=="-debug" :
        if len(sys.argv)<3 : usage()
        debug=True
        dbId = sys.argv[2]
    else:
        debug=False
        dbId = sys.argv[1]
    tables = showTables( dbId, debug )
    for table in tables : print table
