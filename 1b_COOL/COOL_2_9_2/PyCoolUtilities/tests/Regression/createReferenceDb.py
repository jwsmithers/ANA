#!/usr/bin/env python

#print 'DEBUG: Import os, sys'
import os, sys

print 'DEBUG: Import ReferenceDbMgr'
from PyCoolReferenceDb import ReferenceDbMgr

#print 'DEBUG: Import cool'
from PyCool import cool
serviceVersion290 = True
try: cool.PayloadMode()
except: serviceVersion290 = False

##############################################################################

if __name__ == '__main__':

    envKey = "COOLTESTDB"

    if len(sys.argv) > 3 or \
           ( len(sys.argv) == 3 and \
             sys.argv[2] not in [ "1.3.0", "2.0.0", "2.2.0", "2.8.0", "2.9.0" ] ) :
        print 'Usage: ' + os.path.basename(sys.argv[0]) + \
              ' [dbId [1.3.0|2.0.0|2.2.0|2.8.0|2.9.0]]'
        sys.exit(-1)
    elif len(sys.argv) == 3:
        connectString = sys.argv[1]
        schemaVersion = sys.argv[2]
        del sys.argv[1]
        del sys.argv[1]
    elif len(sys.argv) == 2:
        connectString = sys.argv[1]
        if serviceVersion290: schemaVersion = "2.9.0"
        else: schemaVersion = "2.8.0"
        del sys.argv[1]
    elif len(sys.argv) == 1 and envKey in os.environ:
        connectString = os.environ[envKey]
        if serviceVersion290: schemaVersion = "2.9.0"
        else: schemaVersion = "2.8.0"
    else:
        print 'Usage: ' + os.path.basename(sys.argv[0]) + \
              ' [dbId [1.3.0|2.0.0|2.2.0|2.8.0|2.9.0]]'
        print 'ERROR! You must pass dbId as the first argument'\
              ' or set the environment variable %s'%(envKey)
        sys.exit(-1)

    # Debug printout for bug #32362 (schema evolution test on Win nightlies)
    print 'DEBUG: PYTHONPATH =', os.environ["PYTHONPATH"]

    # Debug printout for bug #45732 (schema evolution tests use wrong C++?)
    ###if "LD_LIBRARY_PATH" in os.environ:
    ###    print 'DEBUG: LD_LIBRARY_PATH =', os.environ["LD_LIBRARY_PATH"]

    ###print 'Instantiate a', schemaVersion, 'reference database manager'
    mgr = ReferenceDbMgr( schemaVersion )
    ###print 'Drop database', connectString
    mgr.dropReferenceDb( connectString )
    ###print 'Create', schemaVersion, 'reference database', connectString
    mgr.createReferenceDb( connectString )
