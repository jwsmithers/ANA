#!/bin/env python

import sys
import traceback

from PyCool import cool, coral

if len(sys.argv) != 2:
    print 'usage:', sys.argv[0], '<connect string>'
    print '<connect string>: a COOL (RAL) compatible connect string, e.g.'
    print ( '    "oracle://devdb10;schema=atlas_cool_sas;'
            'user=atlas_cool_sas;dbname=COOLTEST"' )
    sys.exit(-1)
connect = sys.argv[1]

dbSvc = cool.DatabaseSvcFactory.databaseService()

print 'recreating database'
try:
    dbSvc.dropDatabase(connect)
    db = dbSvc.createDatabase(connect)
except Exception, e:
    print e
    print "could not recreate the database"
    print "check your seal.opts and authentication.xml"
    sys.exit(-1)
except:
    print "Unexpected error:", sys.exc_info()[0]
    print traceback.print_tb(sys.exc_info()[2])
    sys.exit(-1)

print 'setting up spec'
spec = cool.RecordSpecification()
spec.extend("f",cool.StorageType.Float)
spec.extend("i",cool.StorageType.Int32)

print 'creating folders'
f = db.createFolder( "/f1",
                     spec,
                     "description",
                     cool.FolderVersioning.SINGLE_VERSION )

data = cool.Record( spec )
data['f'] = 2.5
data['i'] = 5
for k in data.keys():
    print '\tdata["' + k + '"]:', data[k]


print 'all nodes:'
for f in db.listAllNodes():
    print '\t' + f

root = db.getFolderSet( "/" )

print 'folders in "/"'
for f in root.listFolders():
    print '\t' + f

folder = db.getFolder( "/f1" )

since = 0
until = 1000
channel = 0
print 'Storing object with iov [%s,%s[, channel %s' % ( since, until, channel )
folder.storeObject( since, until, data, channel )

since = 0
until = pow( 2, 50 )
channel = 1
print 'Storing object with iov [%s,%s[, channel %s' % ( since, until, channel )
folder.storeObject( since, until, data, channel )

since = until
until = cool.ValidityKeyMax
channel = 1
print 'Storing object with iov [%s,%s[, channel %s' % ( since, until, channel )
folder.storeObject( since, until, data, channel )

pointInTime = 10
print 'Reading back object at', pointInTime
obj = folder.findObject( pointInTime, channel )
print 'data:', obj.payload()
print 'iov:', obj.since(), obj.until()

print 'object count:', folder.countObjects( cool.ValidityKeyMin,
                                            cool.ValidityKeyMax,
                                            cool.ChannelSelection.all() )
