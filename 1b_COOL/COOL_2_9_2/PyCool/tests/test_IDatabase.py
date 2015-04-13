
import unittest, sys, os

from PyCool import cool

import traceback

connectString = None

class TestIDatabase( unittest.TestCase ):
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

    def test_010_databaseId(self):
        """IDatabase.databaseId"""
        s = self.db.databaseId()
        self.assert_( s.find( '://' ) != -1 # technology://server;schema...
                      or len(s.split('/')) == 2 ) # alias/DBNAME


    def test_020_databaseAttributes(self):
        """IDatabase.databaseAttributes"""
        attr = self.db.databaseAttributes()
        self.assert_( 'DEFAULT_TABLE_PREFIX' in attr.keys() )


    def test_030_createFolderSet(self):
        createParents = True
        f = self.db.createFolderSet( '/a/b', 'desc', createParents )
        self.assert_( isinstance( f, cool.IFolderSetPtr ) )
        self.assert_( self.db.existsFolderSet( '/a/b' ) )
        self.assertEquals( f.description(), 'desc' )


    def test_040_existsFolderSet(self):
        self.assert_( self.db.existsFolderSet( '/' ) )


    def test_050_getFolderSet(self):
        self.db.createFolderSet( '/a', 'desc' )
        f = self.db.getFolderSet( '/a' )
        self.assert_( isinstance( f, cool.IFolderSetPtr ) )
        self.assertEquals( f.description(), 'desc' )


    def test_060_createFolder_existsFolder(self):
        folder = self.db.createFolder( '/a', self.spec, 'desc',
                                       cool.FolderVersioning.SINGLE_VERSION )
        self.assert_( isinstance( folder, cool.IFolderPtr ) )
        self.assert_( self.db.existsFolder( '/a' ) )


    def test_070_existsTag(self):
        self.assert_( self.db.existsTag( 'HEAD' ) )


    def test_080_getFolder(self):
        self.db.createFolder( '/a', self.spec, 'desc' )
        f = self.db.getFolder( '/a' )
        self.assert_( isinstance( f, cool.IFolderPtr ) )
        self.assertEquals( f.description(), 'desc' )


    def test_090_dropNode(self):
        self.db.createFolder( '/a', self.spec, 'desc' )
        self.db.dropNode( '/a' )
        self.assert_( not self.db.existsFolder( '/a' ) )


    def test_100_listAllNodes(self):
        self.db.createFolder( '/a', self.spec )
        self.db.createFolder( '/b', self.spec )
        nodes = self.db.listAllNodes()
        self.assertEquals( len(nodes), 3 )
        self.assert_( '/' in nodes )
        self.assert_( '/a' in nodes )
        self.assert_( '/b' in nodes )


    def test_110_isOpen(self):
        self.assert_( self.db.isOpen() )

#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIDatabase' ) ):
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

