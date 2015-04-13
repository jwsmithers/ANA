#!/usr/bin/env python

###print 'DEBUG: Import os, sys'
import os, sys

print 'DEBUG: Import TestReferenceDb1RO'
from PyCoolReferenceDb import TestReferenceDb1RO

print 'DEBUG: Import TestReferenceDb1RW'
from PyCoolReferenceDb import TestReferenceDb1RW

print 'DEBUG: Import TestReferenceDb2RO'
from PyCoolReferenceDb import TestReferenceDb2RO

#print 'DEBUG: Import cool'
from PyCool import cool
serviceVersion290 = True
try: cool.PayloadMode()
except: serviceVersion290 = False

envKey = "COOLTESTDB"

##############################################################################

def usage() :
    print 'Usage: ' + os.path.basename(sys.argv[0]) + \
          ' [-noRefresh] [dbId [1.3.0|2.0.0|2.2.0|2.8.0|2.9.0]]'
    print 'ERROR! You must pass dbId as argument'\
          ' or set the environment variable %s'%(envKey)
    sys.exit(-1)

##############################################################################

if __name__ == '__main__':

    noRefresh = False
    if len(sys.argv) > 1 and sys.argv[1] == "-noRefresh" :
        noRefresh = True
        del sys.argv[1]

    if len(sys.argv) > 3 or \
           ( len(sys.argv) == 3 and \
             sys.argv[2] not in [ "1.3.0", "2.0.0", "2.2.0", "2.8.0", "2.9.0" ] ) :
        usage()
    elif len(sys.argv) == 3:
        connectString = sys.argv[1]
        refSchemaVersion = sys.argv[2]
        del sys.argv[1]
        del sys.argv[1]
    elif len(sys.argv) == 2:
        connectString = sys.argv[1]
        if serviceVersion290: refSchemaVersion = "2.9.0"
        else: refSchemaVersion = "2.8.0"
        del sys.argv[1]
    elif len(sys.argv) == 1 and envKey in os.environ:
        connectString = os.environ[envKey]
        if serviceVersion290: refSchemaVersion = "2.9.0"
        else: refSchemaVersion = "2.8.0"
    else:
        usage()

    twoReplicas = False
    import CoolAuthentication
    propAny = CoolAuthentication.getDbIdProperties( connectString, False )
    propRW  = CoolAuthentication.getDbIdProperties( connectString, True )
    replAny = CoolAuthentication.coralReplica( propAny )
    replRW  = CoolAuthentication.coralReplica( propRW )
    print 'DEBUG: Lookup 1st replica (R/O test) and 1st RW replica (R/W test)'
    print 'DEBUG: 1st replica:', replAny
    print 'DEBUG: 1st R/W replica:', replRW
    if replRW != replAny :
        print 'DEBUG: 1st replica is not R/W:',\
              'the R/O and R/W tests will use different replicas'
        twoReplicas = True
        if 'TestReferenceDb1RO' in dir() or 'TestReferenceDb2RO' in dir():
            # Build the URL required by IWebCacheControl::refreshSchemaInfo
            # - Determine the explicit frontier replica, and then either of:
            # - Strip off the trailing schema
            # - 1. 'frontier://(serverurl=)()/schema' => '(serverurl=)()'
            # - 2. 'frontier://h:p/servlet/schema' => 'http://h:p/servlet'
            webCacheUrl=replAny
            if webCacheUrl.find('frontier') == 0 and \
                   webCacheUrl.find(':8000/') < 0:
                print 'DEBUG: Frontier server replica: no cache to refresh'
            elif webCacheUrl.find('frontier') == 0:
                print 'DEBUG: Frontier cache replica: configure refresh'
                # Strip off schema
                if webCacheUrl.rfind('/') < 0:
                    print 'ERROR! Cannot strip schema off', webCacheUrl
                    sys.exit(-1)
                webCacheUrl=webCacheUrl[:webCacheUrl.rfind('/')]
                # 1: 'frontier://(serverurl=http://h:p/servlet)()/schema'
                if webCacheUrl.find('frontier://(') == 0:
                    webCacheUrl=webCacheUrl[webCacheUrl.find('('):]
                # 2: 'frontier://host:port/servlet/schema'
                else:
                    webCacheUrl=webCacheUrl.replace('frontier','http',1)
                if not noRefresh:
                    print 'DEBUG: Will refresh Frontier cache for', webCacheUrl
                    if 'TestReferenceDb1RO' in dir():
                        TestReferenceDb1RO.invalidateCacheUrl=webCacheUrl
                    if 'TestReferenceDb2RO' in dir():
                        TestReferenceDb2RO.invalidateCacheUrl=webCacheUrl
                else:
                    print 'DEBUG: SKIP refresh Frontier cache for', webCacheUrl
            else:
                print 'DEBUG: Not a Frontier replica: no cache to refresh'
        else :
            print 'DEBUG: R/W replica is the 1st replica:',\
                  'the R/O and R/W tests will use the same replica'

    if twoReplicas:
        print 'DEBUG: Grant READER privileges to public (needed by Frontier R/O tests)'
        cmd = 'coolPrivileges "' # You may need to add .exe on Windows...
        cmd = cmd + connectString + '" GRANT READER public'
        print 'DEBUG: Execute:', cmd
        f = os.popen( cmd )
        line = f.readline()
        while line :
            if line.find("ERROR") == 0: print line.strip()
            line = f.readline()
        status = f.close()
        if status : # Check coolPrivileges status (fix bug #83515)
            print "ERROR! Command '" + cmd + "' failed! Status:", status
            sys.exit(-1)
        if 'TestReferenceDb1RW' in dir():
            TestReferenceDb1RW.grantPublicReader=True

    if 'TestReferenceDb1RO' in dir():
        TestReferenceDb1RO.connectString = connectString
        TestReferenceDb1RO.refSchemaVersion = refSchemaVersion

    if 'TestReferenceDb1RW' in dir():
        TestReferenceDb1RW.connectString = connectString
        TestReferenceDb1RW.refSchemaVersion = refSchemaVersion

    if 'TestReferenceDb2RO' in dir():
        TestReferenceDb2RO.connectString = connectString
        TestReferenceDb2RO.refSchemaVersion = refSchemaVersion

    #print 'DEBUG: Import unittest'
    import unittest

    #print 'DEBUG: Run the unit tests'
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )
