import unittest, sys, os, time
from PyCool import cool, coral
import traceback

connectString = None

class TestIObject( unittest.TestCase ):
    """
    The purpose of this test class is to test the completeness of the wrapper
    class, *not* the functionality of the class itself. Every method of the
    COOL API class is called to make sure that it is wrapped.
    """

    spec = None
    unittest.TestCase.shared_db = None

    def dummyPayload( self, index ):
        """Creates a dummy payload Record for a given index"""
        payload = cool.Record( self.spec )
        payload["I"] = index
        payload["S"] = 'Object %d' % index
        payload["X"] = index / 1000.
        return payload


    def setUp(self):
        try:
            if self.spec is None:
                self.spec = cool.RecordSpecification()
                self.spec.extend( "I", cool.StorageType.Int32 )
                self.spec.extend( "S", cool.StorageType.String4k )
                self.spec.extend( "X", cool.StorageType.Float )
            if unittest.TestCase.shared_db is None:
                dbSvc = cool.DatabaseSvcFactory.databaseService()
                dbSvc.dropDatabase(connectString)
                unittest.TestCase.shared_db = dbSvc.createDatabase(connectString)
            else:
                unittest.TestCase.shared_db.refreshDatabase()
            self.db = unittest.TestCase.shared_db
            self.folder = self.db.createFolder( '/a', self.spec )
            self.folder.storeObject( 0, 2, self.dummyPayload(0), 1 )
            self.obj = self.folder.findObject( 1, 1 )
        except Exception, e:
            print e
            print "could not set up the test"
            print "check your seal.opts and authentication.xml"
            sys.exit(-1)
        except:
            print "Unexpected error:", sys.exc_info()[0]
            print traceback.print_tb(sys.exc_info()[2])
            sys.exit(-1)

    def tearDown(self):
        del self.obj
        del self.folder

    def test_channelId(self):
        self.assertEquals( self.obj.channelId(), 1 )

    def test_since(self):
        self.assertEquals( self.obj.since(), 0 )

    def test_until(self):
        self.assertEquals( self.obj.until(), 2 )

    def test_payload(self):
        self.assertEquals( self.obj.payload(), self.dummyPayload(0) )

    def test_payloadValue(self):
        self.assertEquals( self.obj.payloadValue( 'I' ), '0' )

    def test_isStored(self):
        self.assert_( self.obj.isStored() )

    def test_objectId(self):
        self.assertEquals( self.obj.objectId(), 1 )

    def test_insertionTime(self):
        self.assert_( len( str( self.obj.insertionTime() ) ) )

    def test_channelId_above_maxint(self):
        """
        Tests that the channelId accessors works correctly for
        channel ids above sys.maxint.
        """
        channel = 2**31
        self.folder.storeObject( 0, 2, self.dummyPayload(0), channel )
        obj = self.folder.findObject( 1, channel )
        self.assertEquals( obj.channelId(), channel )


#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIObject' ) ):
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

    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

