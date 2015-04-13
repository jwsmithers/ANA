#!/bin/env python

def usage() :
    print "Usage: " + os.path.split(sys.argv[0])[1] + " [dbId]"
    sys.exit(-1)

##############################################################################

#
# Turn on client-side debugging using 'setenv FRONTIER_LOG_LEVEL debug'
# See http://frontier.cern.ch/dist/FrontierClientUsage.html
#

import os, sys
import CoolAuthentication
from PyCool import cool, coral

if len(sys.argv) > 2 :
    usage()
elif len(sys.argv) == 2 :
    connectString = sys.argv[1]
else:
    ###connectString="Oracle-avalassi/COOLFRON"
    ###connectString="Frontier-avalassi/COOLFRON"
    connectString="FrontierCache-avalassi/COOLFRON"

app = cool.Application()
outLvl = app.outputLevel()
dbSvc = app.databaseService()
connSvc = app.connectionSvc()
webCacheCtl = connSvc.webCacheControl()

print 'Lookup R/W replica'
dbPropRW = CoolAuthentication.getDbIdProperties ( connectString, True ) # R/W
dbReplicaRW = CoolAuthentication.coralReplica( dbPropRW )
print 'DEBUG: -> db replica (R/W):', dbReplicaRW
print 'Lookup R/O replica'
dbPropRO = CoolAuthentication.getDbIdProperties ( connectString, False ) # R/O
dbReplicaRO = CoolAuthentication.coralReplica( dbPropRO )
print 'DEBUG: -> db replica (R/O):', dbReplicaRO

print '*** 00 ***************************************************************'
print 'Recreate R/W database'
dbSvc.dropDatabase( connectString )
db = dbSvc.createDatabase( connectString )
print 'Create MV folder'
spec = cool.RecordSpecification()
spec.extend( 'i', cool.StorageType.Int32 )
data = cool.Record( spec )
f = db.createFolder( "/folder", spec, "", cool.FolderVersioning.MULTI_VERSION )
print 'Store data'
channel = 0
data['i'] = 1
f.storeObject( 0,  100, data, channel )
print 'Close R/W database'
db.closeDatabase()

print 'Grant public READER privileges'
cmd = 'coolPrivileges "' # You may need to add .exe on Windows...
cmd = cmd + connectString + '" GRANT READER public > /dev/null'
os.system( cmd )

print '*** 01 ***************************************************************'
print 'Open R/O database'
db = dbSvc.openDatabase( connectString, True )
f = db.getFolder( "/folder" )
print 'Retrieve data'
obj = f.findObject( 50, channel, "" )
print obj
print repr(obj)
print 'Close R/W database'
db.closeDatabase()

print '*** 02 ***************************************************************'
print 'Open R/W database'
db = dbSvc.openDatabase( connectString, False )
f = db.getFolder( "/folder" )
print 'Store new data'
channel = 0
data['i'] = 2
f.storeObject( 10, 90, data, channel )
print 'Retrieve new data'
obj = f.findObject( 50, channel, "" )
print obj
print repr(obj)
print 'Close R/W database'
db.closeDatabase()

print '*** 03 ***************************************************************'
print 'Open R/O database'
db = dbSvc.openDatabase( connectString, True )
f = db.getFolder( "/folder" )
print 'Retrieve new data'
###app.setOutputLevel( 1 )
obj = f.findObject( 50, channel, "" )
###app.setOutputLevel( outLvl )
print obj
print repr(obj)
print 'Close R/O database'
db.closeDatabase()

print '*** 04 ***************************************************************'
print 'Refresh web cache schema info'
app.setOutputLevel( 1 )
# Build the URL required by the IWebCacheControl::refreshSchemaInfo method
# - Determine the explicit frontier replica, and then either of:
# - Strip off the trailing schema
# - 1. 'frontier://(serverurl=...)()/schema' => '(serverurl=...)()'
# - 2. 'frontier://host:port/servlet/schema' => 'http://host:port/servlet'
webCacheUrl=dbReplicaRO
if webCacheUrl.find('frontier') == 0:
    # Strip off schema
    if webCacheUrl.rfind('/') < 0:
        print 'ERROR! Cannot strip schema off R/O replica', webCacheUrl
        sys.exit(-1)
    webCacheUrl=webCacheUrl[:webCacheUrl.rfind('/')]
    # Format 1: 'frontier://(serverurl=http://host:port/servlet)(...)/schema'
    if webCacheUrl.find('frontier://(') == 0:
        webCacheUrl=webCacheUrl[webCacheUrl.find('('):]
    # Format 2: 'frontier://host:port/servlet/schema'
    else:
        webCacheUrl=webCacheUrl.replace('frontier','http',1)
    print 'Refresh cache for', webCacheUrl
    webCacheCtl.refreshSchemaInfo( webCacheUrl )
    webCacheInfo=webCacheCtl.webCacheInfo( webCacheUrl )
else:
    print 'Not a Frontier replica: do nothing'
app.setOutputLevel( outLvl )

print '*** 05 ***************************************************************'
print 'Open R/O database'
db = dbSvc.openDatabase( connectString, True )
f = db.getFolder( "/folder" )
print 'Retrieve new data'
###app.setOutputLevel( 1 )
obj = f.findObject( 50, channel, "" )
###app.setOutputLevel( outLvl )
print obj
print repr(obj)
print 'Close R/W database'
db.closeDatabase()

