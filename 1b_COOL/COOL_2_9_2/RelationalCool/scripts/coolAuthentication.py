#!/usr/bin/env python
import os, sys
from CoolAuthentication import *

def usage() :
    print "Usage: " + os.path.split(sys.argv[0])[1] + " [-RW] dbId"
    print "[Option -RW: display only the first R/W replica]"
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':
    if len(sys.argv) == 2 :
        rwOnly = False
        dbId = sys.argv[1]
    elif len(sys.argv) == 3 and sys.argv[1] == "-RW" :
        rwOnly = True
        dbId = sys.argv[2]
    else:
        usage()
    print "COOL dbId:", dbId
    dbIdProp = getDbIdProperties( dbId, rwOnly )
    print "CoralAlias: '" + coralAlias( dbIdProp ) + "'"
    print "CoralReplica: '" + coralReplica( dbIdProp ) + "'"
    print "CoralMode: '" + coralMode( dbIdProp ) + "'"
    print "Technology: '" + technology( dbIdProp ) + "'"
    print "Server: '" + server( dbIdProp ) + "'"
    print "Schema: '" + schema( dbIdProp ) + "'"
    print "User: '" + user( dbIdProp ) + "'"
    print "Password: '" + password( dbIdProp ) + "'"
    print "DbName: '" + dbName( dbIdProp ) + "'"
