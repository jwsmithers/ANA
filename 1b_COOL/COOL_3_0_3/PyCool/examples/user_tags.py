#!/bin/env python

from PyCool import cool, coral

connectString = 'sqlite://;schema=COOLTEST.db;dbname=COOLTEST'

dbSvc = cool.DatabaseSvcFactory.databaseService()

print 'recreating database'
dbSvc.dropDatabase( connectString )
db = dbSvc.createDatabase( connectString )

print 'setting up spec'
spec = cool.RecordSpecification()
spec.extend( 'i', cool.StorageType.Int32 )

def data( index ):
    al = cool.Record( spec )
    al['i'] = index
    return al

f1 = db.createFolder( '/f1', spec, '', cool.FolderVersioning.MULTI_VERSION )
channel = 0
f1.storeObject( 0, 10, data(1), channel )
f1.storeObject( 1, 5, data(2), channel, 'user tag A' )
f1.storeObject( 3, 8, data(3), channel, 'user tag B' )
f1.storeObject( 2, 4, data(4), channel, 'user tag A' )
f1.storeObject( 3, 7, data(5), channel, 'user tag B' )

print 'content f1 HEAD'
objs = f1.browseObjects( cool.ValidityKeyMin,
                         cool.ValidityKeyMax,
                         cool.ChannelSelection.all() )
while objs.hasNext(): print objs.next()

print 'content f1 user tag A'
objs = f1.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                         cool.ChannelSelection.all(),
                         'user tag A' )
while objs.hasNext(): print objs.next()

print 'content f1 user tag B'
objs = f1.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                         cool.ChannelSelection.all(),
                         'user tag B' )
while objs.hasNext(): print objs.next()
