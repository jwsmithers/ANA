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

channel = 0

db.createFolderSet( '/A' )
f1 = db.createFolder( '/A/f1', spec, '', cool.FolderVersioning.MULTI_VERSION )
f1.storeObject( 0, 10, data(1), channel )
f1.tagCurrentHead( 'F1' )
f1.storeObject( 5, 15, data(2), channel )

f2 = db.createFolder( '/A/f2', spec, '', cool.FolderVersioning.MULTI_VERSION )
f2.storeObject( 0, 20, data(3), channel )
f2.tagCurrentHead( 'F2' )
f2.storeObject( 15, 25, data(4), channel )

print 'content f1 HEAD'
objs = f1.browseObjects( cool.ValidityKeyMin,
                         cool.ValidityKeyMax,
                         cool.ChannelSelection.all() )
while objs.hasNext(): print objs.next()

print 'content f2 HEAD'
objs = f2.browseObjects( cool.ValidityKeyMin,
                         cool.ValidityKeyMax,
                         cool.ChannelSelection.all() )
while objs.hasNext(): print objs.next()

f1.createTagRelation( 'A', 'F1' )
f2.createTagRelation( 'A', 'F2' )

print 'content f1 A'
objs = f1.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                         cool.ChannelSelection.all(),
                         f1.resolveTag( 'A' ) )
while objs.hasNext(): print objs.next()

print 'content f2 A'
objs = f2.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                         cool.ChannelSelection.all(),
                         f2.resolveTag( 'A' ) )
while objs.hasNext(): print objs.next()
