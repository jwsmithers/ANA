
import unittest, sys, os, time

from PyCool import cool, coral
import traceback

connectString = None

class TestIObjectIterator( unittest.TestCase ):
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
            folder = self.db.createFolder( '/a', self.spec )
            folder.storeObject( 0, 2, self.dummyPayload(0), 0 )
            folder.storeObject( 2, 4, self.dummyPayload(1), 0 )
            self.objs = folder.browseObjects( 0, 4, cool.ChannelSelection(0) )
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
        del self.objs

    def test_isEmpty(self):
        self.assert_( not self.objs.isEmpty() )

    def test_goToNext(self):
        self.assert_( self.objs.goToNext() )

    def test_goToNext_currentRef(self):
        self.objs.goToNext()
        obj = self.objs.currentRef()
        self.assertEquals( obj.payload(), self.dummyPayload(0) )

    def test_size(self):
        self.assertEquals( self.objs.size(), 2 )

    def test_bug43621(self):
        nobjs = 0
        for obj in self.objs:
            nobjs = nobjs + 1
        self.assertEquals( self.objs.size(), nobjs )

#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIObjectIterator' ) ):
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

