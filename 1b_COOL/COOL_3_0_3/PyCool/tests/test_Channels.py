import unittest, sys, os
from PyCool import cool, coral
import traceback

connectString = None

class TestChannels( unittest.TestCase ):
    """
    Quick tests of the channels functionality.
    There may be significant overlaps with the C++ tests.
    """

    rspec = None
    unittest.TestCase.shared_db = None

    def dummyPayload( self, index ):
        """Creates a dummy payload AttributeList for a given index"""
        payload = cool.Record( self.rspec )
        payload["I"] = index
        payload["S"] = 'Object %d' % index
        payload["X"] = index / 1000.
        return payload

    def timeToString( self, time ):
        local = False # Use UTC-GMT times
        year = time.year( local )
        month = time.month( local ) + 1 # Months are in [0-11]
        day = time.day( local )
        hour = time.hour( local )
        min = time.minute( local )
        sec = time.second( local )
        nsec = time.nsecond()
        s = "%4.4d-%2.2d-%2.2d_%2.2d:%2.2d:%2.2d.%9.9ld GMT" % (
                                  year, month, day, hour, min, sec, nsec )
        return s;


    def setUp(self):
        try:
            if self.rspec is None:
                self.rspec = cool.RecordSpecification()
                self.rspec.extend( "I", cool.StorageType.Int32 )
                self.rspec.extend( "S", cool.StorageType.String4k )
                self.rspec.extend( "X", cool.StorageType.Float )
                self.fspec = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.rspec )
            if unittest.TestCase.shared_db is None:
                self.app = cool.Application()
                self.outLvl = self.app.outputLevel()
                dbSvc = self.app.databaseService()
                dbSvc.dropDatabase(connectString)
                unittest.TestCase.shared_db = dbSvc.createDatabase(connectString)
            else:
                unittest.TestCase.shared_db.refreshDatabase()
            self.db = unittest.TestCase.shared_db
        except Exception, e:
            print e
            print "could not recreate the database"
            print "check your seal.opts and authentication.xml"
            sys.exit(-1)
        except:
            print "Unexpected error:", sys.exc_info()[0]
            print traceback.print_tb(sys.exc_info()[2])
            sys.exit(-1)

    def tearDown(self):
        #del self.db
        pass

    def test_all(self):
        # Create folder
        f = self.db.createFolder( '/a', self.fspec, 'desc' )
        # Test full path
        self.assertEquals( '/a', f.fullPath() )
        # Test description
        self.assertEquals( 'desc', f.description() )
        # Test setDescription
        f.setDescription( 'new desc' )
        self.assertEquals( 'new desc', f.description() )
        f.setDescription( 'desc' )
        self.assertEquals( 'desc', f.description() )
        # Test isLeaf
        self.assert_( f.isLeaf() )
        # Test id
        self.assertEquals( 1, f.id() )
        # Test parent id
        self.assertEquals( 0, f.parentId() )
        # Test payload specification
        spec = f.payloadSpecification()
        self.assertEquals( 3, spec.size() )
        # Test versioning mode
        mode = f.versioningMode()
        self.assertEquals( cool.FolderVersioning.SINGLE_VERSION, mode )
        # Test folder attributes
        attr = f.folderAttributes()
        self.assert_( 'FOLDER_CHANNELTABLENAME' in attr.keys() )
        # Store sample data
        f.setupStorageBuffer()
        f.storeObject( 0, 2, self.dummyPayload(  1 ), 0 )
        f.storeObject( 2, 4, self.dummyPayload(  3 ), 0 )
        f.storeObject( 0, 2, self.dummyPayload( 11 ), 1 )
        f.storeObject( 2, 4, self.dummyPayload( 13 ), 1 )
        f.storeObject( 0, 2, self.dummyPayload( 21 ), 2 )
        f.storeObject( 2, 4, self.dummyPayload( 23 ), 2 )
        f.flushStorageBuffer()
        # Test findObject
        obj = f.findObject( 1, 0 )
        self.assertEquals( self.dummyPayload( 1 ), obj.payload() )
        # Test browseObject
        self.app.setOutputLevel( cool.MSG.VERBOSE )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        self.app.setOutputLevel( self.outLvl )
        self.assertEquals( 2, objs.size() )
        # Test listChannels
        channels = f.listChannels()
        self.assertEquals( 3, len(channels) )

#######################################################################

envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIFolder' ) ):
        connectString = sys.argv[1]
    elif envKey in os.environ:
        connectString = os.environ[envKey]
    else:
        print 'usage:', sys.argv[0], '<connect string>'
        print '<connect string>: a COOL (RAL) compatible connect string, e.g.'
        print ( '    "oracle://devdb10;schema=atlas_cool_sas;'
                'user=atlas_cool_sas;dbname=COOLTEST"' )
        print 'or set the environment variable %s'%(envKey)
        sys.exit(-1)

    #print 'connect string', connectString

    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

