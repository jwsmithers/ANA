#!/usr/bin/env python

###print 'DEBUG: Import os, sys'
import os, sys

print 'DEBUG: Import ReferenceDbMgr'
from PyCoolReferenceDb import ReferenceDbMgr

print 'DEBUG: Import TestReferenceDb1RO'
from PyCoolReferenceDb import TestReferenceDb1RO

print 'DEBUG: Import TestReferenceDb1RW'
from PyCoolReferenceDb import TestReferenceDb1RW

print 'DEBUG: Import TestReferenceDb2RO'
from PyCoolReferenceDb import TestReferenceDb2RO

##############################################################################

if __name__ == '__main__':

    envKey  = "COOLTESTDB"
    envKeyR = "COOLTESTDB_R"
    twoReplicas = False
    if envKey in os.environ:
        connectString = os.environ[envKey]
        if envKeyR in os.environ:
            connectStringR = os.environ[envKeyR]
            if connectString != connectStringR:
                ##print 'DEBUG: Environment variables',envKey,'and',envKeyR,\
                ##      'have different values: execute only the R/O test'
                print 'DEBUG: Environment variables', envKey, 'and', envKeyR,\
                      'have different values: assume that',\
                      'the R/O and R/W tests will use different replicas'
                twoReplicas = True
            else:
                print 'DEBUG: Environment variables', envKey, 'and', envKeyR,\
                      'have the same value: check replicas for', connectString
        else:
            connectStringR = connectString
            print 'DEBUG: Environment variable', envKeyR,\
                  'is not defined: check replicas for', connectString
    else:
        print 'ERROR! You must set the environment variable %s'%(envKey)
        print 'ERROR! Optionally you can set also %s'%(envKeyR)
        sys.exit(-1)

    if connectString == connectStringR:
        import CoolAuthentication
        propAny = CoolAuthentication.getDbIdProperties( connectString, False )
        propRW  = CoolAuthentication.getDbIdProperties( connectString, True )
        ###print 'DEBUG: Properties of first replica:', propAny
        ###print 'DEBUG: Properties of first R/W replica:', propRW
        replAny = CoolAuthentication.coralReplica( propAny )
        replRW  = CoolAuthentication.coralReplica( propRW )
        connAny = CoolAuthentication.middleTier( propAny ) + CoolAuthentication.technology( propAny ) + '://' + CoolAuthentication.server( propAny ) + ";schema=" + CoolAuthentication.schema( propAny ) + ";dbname=" + CoolAuthentication.dbName( propAny )
        connRW = CoolAuthentication.middleTier( propRW ) + CoolAuthentication.technology( propRW ) + '://' + CoolAuthentication.server( propRW ) + ";schema=" + CoolAuthentication.schema( propRW ) + ";dbname=" + CoolAuthentication.dbName( propRW )
        print 'DEBUG: Lookup first replica (R/O test)',\
              'and first RW replica (R/W test)'
        print 'DEBUG: First replica:', replAny
        print 'DEBUG: First R/W replica:', replRW
        print 'DEBUG: Connection string for first replica:', connAny
        print 'DEBUG: Connection string for first R/W replica:', connRW
        if replRW != replAny :
            ##print 'DEBUG: First replica is not R/W:',\
            ##      'execute only the R/O test'
            print 'DEBUG: First replica is not R/W:',\
                  'the R/O and R/W tests will use different replicas'
            twoReplicas = True
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
                print 'DEBUG: Will refresh Frontier cache for', webCacheUrl
                TestReferenceDb1RO.invalidateCacheUrl=webCacheUrl
                if 'TestReferenceDb2RO' in dir():
                    TestReferenceDb2RO.invalidateCacheUrl=webCacheUrl
            else:
                print 'DEBUG: Not a Frontier replica: no cache to refresh'
        else :
            ##print 'DEBUG: First replica is R/W:',\
            ##      'execute both the R/O and R/W tests'
            ##print 'DEBUG: Import TestReferenceDb1RW'
            ##from PyCoolReferenceDb import TestReferenceDb1RW
            ##print 'DEBUG: Import TestReferenceDb2RO'
            ##from PyCoolReferenceDb import TestReferenceDb2RO
            print 'DEBUG: R/W replica is the first replica:',\
                  'the R/O and R/W tests will use the same replica'

    #print 'DEBUG: Drop and recreate reference database'
    #print 'DEBUG: -> db ID:', connectString
    mgr = ReferenceDbMgr()
    mgr.dropReferenceDb( connectString )   # COMMENT OUT TO SKIP DB RECREATE
    mgr.createReferenceDb( connectString ) # COMMENT OUT TO SKIP DB RECREATE

    #print 'DEBUG: Import unittest'
    import unittest

    if twoReplicas:
        print 'DEBUG: Grant READER privs to public',\
              '(for Frontier and CoralServer R/O tests)'
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
        print 'DEBUG: Execute 1RO tests against reference database'
        print 'DEBUG: -> db ID:', connectStringR
        TestReferenceDb1RO.connectString = connAny

    if 'TestReferenceDb1RW' in dir():
        print 'DEBUG: Execute 1RW tests against reference database'
        print 'DEBUG: -> db ID:', connRW
        TestReferenceDb1RW.connectString = connRW
        print 'DEBUG: Execute 2RO tests against reference database'
        print 'DEBUG: -> db ID:', connAny
        TestReferenceDb2RO.connectString = connAny
    else :
        import PyCoolReferenceDb
        del PyCoolReferenceDb.TestReferenceDb1RW
        del PyCoolReferenceDb.TestReferenceDb2RO

    unittest.main( module = 'PyCoolReferenceDb',
                   testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )



