#!/usr/bin/env python
import os, sys
from CoolQueryManager import *

def usage() :
    if os.environ["OS"] != "Windows_NT" :
        cmd = os.path.split(sys.argv[0])[1]
        print "Usage: " + cmd + " [-debug] dbId \"select... from... where x='y';\""
    else :
        cmd = "wineWrap.sh python " + sys.argv[0]
        print "Usage: " + cmd + " [-debug] dbId \"select... from... where x='y';\""
        # Example: wineWrap.sh python ../../RelationalCool/scripts/coolQueryManager.py -debug \"$COOLTESTDB\" \""select OBJECT_ID from COOLTEST_F0006_IOVS;"\"
        print "Example: " + cmd + " -debug \\\"$COOLTESTDB\\\" \\\"\"select OBJECT_ID from COOLTEST_F0006_IOVS;\"\\\""
        # Example: wineWrap.sh python ../../RelationalCool/scripts/coolQueryManager.py -debug \"$COOLTESTDB\" \""select \* from COOLTEST_DB_ATTRIBUTES;"\"
        print "Example: " + cmd + " -debug \\\"$COOLTESTDB\\\" \\\"\"select \\* from COOLTEST_DB_ATTRIBUTES;\"\\\""
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    ###myTest1()
    if len(sys.argv)<3 : usage()
    if sys.argv[1]=="-debug" :
        if len(sys.argv)<4 : usage()
        debug=True
        dbId = sys.argv[2]
        sql = sys.argv[3]
    else:
        debug=False
        dbId = sys.argv[1]
        sql = sys.argv[2]
    columns = executeSqlSelect( dbId, sql, debug )
    for column in columns : print column
