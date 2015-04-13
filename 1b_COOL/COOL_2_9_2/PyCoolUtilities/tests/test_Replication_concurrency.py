import unittest, sys, os, time
import threading

from PyCool import cool

# simplify usage of these a bit...
SINGLE_VERSION = cool.FolderVersioning.SINGLE_VERSION
MULTI_VERSION  = cool.FolderVersioning.MULTI_VERSION

# more expressive shortcuts for openDatabase calls
RW = False # i.e. readOnly = False
RO = True  # i.e. readOnly = True

def getNext( objs ):
    objs.goToNext()
    return objs.currentRef()

class IovWriter( threading.Thread ):

    def __init__( self, name, connectString, folderName, **kw ):
        threading.Thread.__init__( self, **kw )
        self.setName( name )
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        db = dbSvc.openDatabase( connectString, RW )
        self.folder = db.getFolder( folderName )
        self.data = cool.Record( defaultSpec() )
        self.iterations = 5
        self.count = 0

    def run( self ):
        while self.count < self.iterations:
            self.count += 1
            print 'thread', self.getName(), self.count
            self.data['A_IOBJ'] = self.count
            self.folder.storeObject( self.count, cool.ValidityKeyMax,
                                     self.data, 0 )
            time.sleep(1)


class FolderWriter( threading.Thread ):

    def __init__( self, name, connectString, **kw ):
        threading.Thread.__init__( self, **kw )
        self.setName( name )
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        self.db = dbSvc.openDatabase( connectString, RW )
        self.data = cool.Record( defaultSpec() )
        self.iterations = 5
        self.count = 0
        self.folderNames = []

    def run( self ):
        while self.count < self.iterations:
            self.count += 1
            print 'thread', self.getName(), self.count
            folderName = '/SV/folderwriter_%02d' % self.count
            self.folderNames.append( folderName )
            folder = self.db.createFolder( folderName,
                                           defaultSpec(),
                                           '',
                                           SINGLE_VERSION )
            self.data['A_IOBJ'] = self.count
            folder.storeObject( self.count, cool.ValidityKeyMax,
                                self.data, 0 )
            time.sleep(1)


class Replicator( threading.Thread ):

    def run( self ):
        cmd = 'coolReplicateDB "%s" "%s"' % ( sourceConnectString,
                                              targetConnectString )
        print 'Running', cmd
        time.sleep(1) # Sleep BEFORE replicating (mysql - see bug #23662)
        cmdPipe = os.popen( cmd )
        #for line in cmdPipe:
        #    print line.rstrip()
        output = cmdPipe.readlines()
        if cmdPipe.close() is not None:
            for line in output: print line.rstrip()
            raise 'Error running replication'
        time.sleep(1) # Sleep AFTER replicating (mysql - see bug #23662)
        print 'Replication finished'


def defaultSpec():
    spec = cool.RecordSpecification()
    spec.extend( "A_IOBJ", cool.StorageType.UInt32 )
    spec.extend( "A_STRING", cool.StorageType.String4k )
    return spec


def recreateDatabase( url ):
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    dbSvc.dropDatabase( url )
    db = dbSvc.createDatabase( url )
    time.sleep(1) # Sleep for ORA-01466 (create db, sleep, then create folders)

    spec = defaultSpec()
    data = cool.Record( spec )
    data['A_STRING'] = "Test"

    db.createFolderSet( '/SV' )
    db.createFolderSet( '/MV' )

    # SV1

    ch = 0
    f = db.createFolder( '/SV/sv1', spec, '', SINGLE_VERSION )
    data['A_IOBJ'] = 1
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 2
    f.storeObject( 10, 15, data, ch )
    data['A_IOBJ'] = 3
    f.storeObject( 15, 20, data, ch )
    data['A_IOBJ'] = 4
    f.storeObject( 20, cool.ValidityKeyMax, data, ch )

    # MV1

    ch = 0
    f = db.createFolder( '/MV/mv1', spec, '', MULTI_VERSION )
    data['A_IOBJ'] = 11
    f.storeObject( 0, 10, data, ch )
    data['A_IOBJ'] = 12
    f.storeObject( 0, 5, data, ch )
    data['A_IOBJ'] = 13
    f.storeObject( 15, 20, data, ch )
    f.tagCurrentHead( "Tag A1", "My tag" )
    data['A_IOBJ'] = 14
    f.storeObject( 5, 15, data, ch )
    f.tagCurrentHead( "Tag B1", "My tag" )

    # tag relation
    f.createTagRelation( "Test", "Tag A1" )
    f.createTagRelation( "Prod", "Tag B1" )

    # MV2

    ch = 0
    f = db.createFolder( '/MV/mv2', spec, '', MULTI_VERSION )
    data['A_IOBJ'] = 21
    f.storeObject( 0, 10, data, ch )
    data['A_IOBJ'] = 22
    f.storeObject( 0, 5, data, ch )
    data['A_IOBJ'] = 23
    f.storeObject( 15, 20, data, ch )
    f.tagCurrentHead( "Tag A2", "My tag" )
    data['A_IOBJ'] = 24
    f.storeObject( 5, 15, data, ch )
    f.tagCurrentHead( "Tag B2", "My tag" )

    # tag relation
    f.createTagRelation( "Test", "Tag A2" )
    f.createTagRelation( "Prod", "Tag B2" )

    # MV3

    f = db.createFolder( '/MV/mv3', spec, '', MULTI_VERSION )
    ch = 0
    data['A_IOBJ'] = 31
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 32
    f.storeObject( 10, 20, data, ch, "Tag C" )
    data['A_IOBJ'] = 33
    f.storeObject( 20, 30, data, ch, "Tag C" )

    # SV2

    f = db.createFolder( '/SV/sv2', spec, '', SINGLE_VERSION )
    ch = 0
    f.createChannel( 0, "ch 0", "desc 0" )
    data['A_IOBJ'] = 41
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 42
    f.storeObject( 5, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 43
    f.storeObject( 10, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 44
    f.storeObject( 15, cool.ValidityKeyMax, data, ch )
    ch = 1
    f.createChannel( 1, "ch 1", "desc 1" )
    data['A_IOBJ'] = 51
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 52
    f.storeObject( 5, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 53
    f.storeObject( 10, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 54
    f.storeObject( 15, cool.ValidityKeyMax, data, ch )


    f = db.createFolder( '/SV/sv3', spec, '', SINGLE_VERSION )

    del db

class TestReplication( unittest.TestCase ):

    def initDatabases(self):
        recreateDatabase( sourceConnectString )
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase( targetConnectString )


    def runReplication(self):
        time.sleep(1) # Sleep BEFORE replicating (mysql - see bug #23662)
        cmd = 'coolReplicateDB "%s" "%s"' % ( sourceConnectString,
                                              targetConnectString )
        #print 'Running', cmd
        cmdPipe = os.popen( cmd )
        #for line in cmdPipe:
        #    print line.rstrip()
        output = cmdPipe.readlines()
        if cmdPipe.close() is not None:
            for line in output: print line.rstrip()
            raise 'Error running replication'
        time.sleep(1) # Sleep AFTER replicating (mysql - see bug #23662)

    def setUp(self):
        self.initDatabases()
        self.runReplication()
        self.dbSvc = cool.DatabaseSvcFactory.databaseService()


    def tearDown(self):
        pass


    def test_01_concurrent_iovs( self ):

        os.putenv( 'COOLREPLICATION_TIMEOUT', '15' )
        replicator = Replicator()
        replicator.start()

        time.sleep( 5 )

        writer = IovWriter( 'IovWriter', sourceConnectString, '/SV/sv3' )
        writer.start()

        time.sleep( 30 )

        source = self.dbSvc.openDatabase( sourceConnectString, RO )
        f = source.getFolder( '/SV/sv3' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 5, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['A_IOBJ'] )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['A_IOBJ'] )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['A_IOBJ'] )
        obj = getNext( objs )
        self.assertEqual( 5, obj.payload()['A_IOBJ'] )
        source.closeDatabase()

        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( '/SV/sv3' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 0, objs.size() )
        target.closeDatabase()


    def test_02_concurrent_folders( self ):

        os.putenv( 'COOLREPLICATION_TIMEOUT', '15' )
        replicator = Replicator()
        replicator.start()

        time.sleep( 5 )

        writer = FolderWriter( 'FolderWriter', sourceConnectString )
        writer.start()

        time.sleep( 30 )

        source = self.dbSvc.openDatabase( sourceConnectString, RO )
        for folderName in writer.folderNames:
            self.assert_( source.existsFolder( folderName ) )
        source.closeDatabase()

        target = self.dbSvc.openDatabase( targetConnectString, RO )
        for folderName in writer.folderNames:
            self.assert_( not target.existsFolder( folderName ) )
        target.closeDatabase()


#######################################################################
#######################################################################


sourceKey = "COOLTESTDB_SOURCE"
targetKey = "COOLTESTDB_TARGET"

if __name__ == '__main__':
    if sourceKey in os.environ and targetKey in os.environ:
        sourceConnectString = os.environ[sourceKey]
        targetConnectString = os.environ[targetKey]
    else:
        print 'usage: %s %s' % (
                   sys.argv[0],
                   '<source connect string> <target connect string>' )
        print '<connect string>: a COOL (RAL) compatible connect string, e.g.'
        print ( '    "oracle://devdb10;schema=atlas_cool_sas;'
                'user=atlas_cool_sas;dbname=COOLTEST"' )
        print 'or set the environment variables %s and %s'%( sourceKey,
                                                             targetKey )
        sys.exit(-1)

    if len(sys.argv) == 2:
        unittest.main( testRunner =
                       unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )
    else:
        suite = unittest.TestLoader().loadTestsFromTestCase(TestReplication)
        result = unittest.TextTestRunner(stream=sys.stdout,verbosity=2).run(suite)
        if not result.wasSuccessful(): sys.exit(1)
