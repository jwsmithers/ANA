#!/bin/env python

import sys

if len(sys.argv)<2 :
    write=False
elif len(sys.argv)==2 :
    if sys.argv[1]=="write" : write=True

from PyCool import cool, coral
dbSvc = cool.DatabaseSvcFactory.databaseService()
print 'using software release', dbSvc.serviceVersion()

connectStringO = 'oracle://devdb10;schema=lcg_cool;dbname=COOLTEST'
###connectStringO = 'oracle://lcg_cool_nightly;schema=lcg_cool;dbname=COOLTEST'

#connectStringCSP = 'coral_cspST://localhost:50007|'+connectStringO
connectStringCSP = 'coral_cspMTSLAC://localhost:60017|'+connectStringO
#connectStringCSP = 'coral_cspMTSLAC://localhost:160017|'+connectStringO

# WRITE

if write:
    connectString = connectStringO
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

# READ

###connectString = connectStringO
connectString = connectStringCSP
db = dbSvc.openDatabase( connectString )
nodes = db.listAllNodes()
for node in nodes:
    print node
f = db.getFolder( "/folder" )
obj = f.findObject( 3, 0 )
ch = f.listChannels()
print len(ch)
print obj
print repr(obj)
