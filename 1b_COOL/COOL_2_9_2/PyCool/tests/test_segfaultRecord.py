import unittest, sys, os
import traceback
from PyCool import cool, coral

envKey = "COOLTESTDB"
connectString = os.environ[envKey]

spec = cool.RecordSpecification()
spec.extend( "I", cool.StorageType.Int32 )
spec.extend( "S", cool.StorageType.String4k )
spec.extend( "X", cool.StorageType.Float )

def dummyPayload( index ):
    record = cool.Record( spec )
    payload = record.attributeList() # segfault!
    #payload = coral.AttributeList( record.attributeList() ) # OK!
    payload["I"] = index
    payload["S"] = 'Object %d' % index
    payload["X"] = index / 1000.
    print payload
    return payload

dbSvc = cool.DatabaseSvcFactory.databaseService()
dbSvc.dropDatabase(connectString)
db = dbSvc.createDatabase(connectString)
folder = db.createFolder( '/a', spec )
folder.storeObject( 0, 2, dummyPayload(0) )
