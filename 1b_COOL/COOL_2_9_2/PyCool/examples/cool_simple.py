#!/bin/env python

from PyCool import cool, coral
dbSvc = cool.DatabaseSvcFactory.databaseService()
print 'using software release', dbSvc.serviceVersion()

connectString = 'sqlite://;schema=COOLTEST.db;dbname=COOLTEST'

print 'recreating database'
dbSvc.dropDatabase( connectString )
db = dbSvc.createDatabase( connectString )

print 'setting up spec'
spec = cool.RecordSpecification()
spec.extend( 'i', cool.StorageType.Int32 )

data = cool.Record( spec )
data['i'] = 3

f = db.createFolder( "/folder", spec )
f.storeObject( 0, 5, data, 0 )
obj = f.findObject( 3, 0 )

ch = f.listChannels()
print len(ch)

print obj
print repr(obj)
