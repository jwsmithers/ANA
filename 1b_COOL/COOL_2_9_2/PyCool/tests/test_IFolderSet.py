import unittest, sys, os

from PyCool import cool
import traceback

connectString = None

class TestIFolderSet( unittest.TestCase ):
    """
    The purpose of this test class is to test the completeness of the wrapper
    class, *not* the functionality of the class itself. Every method of the
    COOL API class is called to make sure that it is wrapped.
    """

    spec = None
    unittest.TestCase.shared_db = None

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

    def test_listFolders(self):
        self.db.createFolder( '/a', self.spec )
        self.db.createFolder( '/b', self.spec )
        root = self.db.getFolderSet( '/' )
        nodes = root.listFolders()
        self.assertEquals( 2, nodes.size() )


    def test_listFolderSets(self):
        self.db.createFolderSet( '/a' )
        self.db.createFolderSet( '/b' )
        root = self.db.getFolderSet( '/' )
        nodes = root.listFolderSets()
        self.assertEquals( 2, nodes.size() )


    def test_fullPath(self):
        f = self.db.createFolderSet( '/a' )
        self.assertEquals( '/a', f.fullPath() )


    def test_description(self):
        f = self.db.createFolderSet( '/a', 'desc' )
        self.assertEquals( 'desc', f.description() )


    def test_setDescription(self):
        f = self.db.createFolderSet( '/a', 'desc' )
        f.setDescription( 'new desc' )
        self.assertEquals( 'new desc', f.description() )


    def test_isLeaf(self):
        f = self.db.createFolderSet( '/a' )
        self.assert_( not f.isLeaf() )


    def test_isStored(self):
        f = self.db.createFolderSet( '/a' )
        self.assert_( f.isStored() )


    def test_insertionTime(self):
        f = self.db.createFolderSet( '/a' )
        self.assert_( len(str( f.insertionTime() )) > 0 )


    def test_id(self):
        f = self.db.createFolderSet( '/a' )
        self.assertEquals( 1, f.id() )


    def test_parentId(self):
        f = self.db.createFolderSet( '/a' )
        self.assertEquals( 0, f.parentId() )


    def test_isHeadTag(self):
        self.assert_( cool.IFolder.isHeadTag( 'HEAD' ) )


    def test_headTag(self):
        self.assertEquals( 'HEAD', cool.IFolder.headTag() )



#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIFolderSet' ) ):
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

