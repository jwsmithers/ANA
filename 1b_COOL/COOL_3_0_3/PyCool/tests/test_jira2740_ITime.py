from PyCool import cool
svc = cool.DatabaseSvcFactory.databaseService()
dbId="sqlite://;schema=/tmp/sqliteTest-avalassi-COOLTEST.db;dbname=COOLTEST"
svc.dropDatabase(dbId)
db = svc.createDatabase(dbId)
rspec=cool.RecordSpecification()
rspec.extend( "I", cool.StorageType.Int32 )
fspec=cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, rspec )
f=db.createFolder( '/a', fspec )
it=f.insertionTime()
t=cool.Time(it)
print it
print t

