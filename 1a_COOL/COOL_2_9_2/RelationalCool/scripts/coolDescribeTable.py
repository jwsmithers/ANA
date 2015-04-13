#!/usr/bin/env python
import os, sys
from CoolDescribeTable import *

def myTest1():
    print 'Test myLPartition and myRPartition'
    txt = 'abc( def )ghi'
    print 'Partition "' + txt + '"'
    print '"' + myLPartition(txt,'(') + '"'
    print '"' + myLPartition(txt,'z') + '"'
    print '"' + myRPartition(txt,')') + '"'
    print '"' + myRPartition(txt,'z') + '"'
    txt = 'abc(( def ))ghi'
    print 'Partition "' + txt + '"'
    print '"' + myLPartition(txt,'(') + '"'
    print '"' + myLPartition(txt,'z') + '"'
    print '"' + myRPartition(txt,')') + '"'
    print '"' + myRPartition(txt,'z') + '"'
    txt = 'z'
    print 'Partition "' + txt + '"'
    print '"' + myLPartition(txt,'(') + '"'
    print '"' + myLPartition(txt,'z') + '"'
    print '"' + myRPartition(txt,')') + '"'
    print '"' + myRPartition(txt,'z') + '"'
    sys.exit(0)

def usage() :
    if os.environ["OS"] != "Windows_NT" :
        cmd = os.path.split(sys.argv[0])[1]
        print "Usage: " + cmd + " [-debug] dbId table"
    else :
        cmd = "wineWrap.sh python " + sys.argv[0]
        print "Usage: " + cmd + " [-debug] dbId table"
        # Example: wineWrap.sh python ../../RelationalCool/scripts/coolDescribeTable.py -debug \"$COOLTESTDB\" COOLTEST_F0006_IOVS
        print "Example: " + cmd + " -debug \\\"$COOLTESTDB\\\" COOLTEST_F0006_IOVS"
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    ###myTest1()
    if len(sys.argv)<3 : usage()
    if sys.argv[1]=="-debug" :
        if len(sys.argv)<4 : usage()
        debug=True
        dbId = sys.argv[2]
        table = sys.argv[3]
    else:
        debug=False
        dbId = sys.argv[1]
        table = sys.argv[2]
    columns = describeTable( dbId, table, debug )
    for column in columns : print column
