#!/bin/env python

from PyCool import cool, coral

connectString="oracle://pdbr3;schema=lcg_cool;dbname=COOLTEST"
#connectString="oracle://lcg_cool_nightly;schema=lcg_cool;dbname=COOLTEST"
#connectString = 'sqlite://;schema=COOLTEST.db;dbname=COOLTEST'

app = cool.Application()
dbSvc = app.databaseService()

channel = 0
if False:
    print 'Recreating database'
    dbSvc.dropDatabase( connectString )
    db = dbSvc.createDatabase( connectString )

    print 'Setting up record spec'
    rspec = cool.RecordSpecification()
    rspec.extend( 'i', cool.StorageType.Int32 )
    data = cool.Record( rspec )

    print 'Setting up folder spec'
    ###hasPayloadTable = True
    hasPayloadTable = False
    fspec = cool.FolderSpecification( cool.FolderVersioning.MULTI_VERSION, rspec, hasPayloadTable )

    print 'Storing new data'
    f = db.createFolder( "/folder", fspec, "" )
    data['i'] = 1
    f.storeObject( 0,  20, data, channel )
    data['i'] = 2
    f.storeObject( 0,   5, data, channel )
    data['i'] = 3
    f.storeObject( 15, 20, data, channel )
    f.tagCurrentHead( "MyTag", "My tag" )
    data['i'] = 4
    f.storeObject(  5, 15, data, channel )

    print 'Storing new bulk data'
    f.setupStorageBuffer()
    data['i'] = 11
    f.storeObject( 0,  20, data, 1 )
    data['i'] = 12
    f.storeObject( 0,   5, data, 1 )
    data['i'] = 21
    f.storeObject( 0,  20, data, 2 )
    data['i'] = 22
    f.storeObject( 0,   5, data, 2 )
    f.flushStorageBuffer()

print 'Retrieving data'
db = dbSvc.openDatabase( connectString )
f = db.getFolder( "/folder" )
obj = f.findObject( 10, channel, "MyTag" )
outLvl = app.outputLevel()
app.setOutputLevel( 1 )
obj = f.findObject( 10, channel, "MyTag" )
app.setOutputLevel( outLvl )
print obj
print repr(obj)
