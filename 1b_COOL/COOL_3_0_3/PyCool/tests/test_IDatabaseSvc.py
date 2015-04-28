import unittest, sys, os
from PyCool import cool
connectString = None

class TestIDatabaseSvc( unittest.TestCase ):
    """
    The purpose of this test class is to test the completeness of the wrapper
    class, *not* the functionality of the class itself. Every method of the
    COOL API class is called to make sure that it is wrapped.
    """

    def setUp(self):
        pass


    def test_01_dropDatabase_createDatabase(self):
        """Drop and create database"""
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase(connectString)
        db = dbSvc.createDatabase(connectString)
        self.assert_( db.existsFolderSet( "/" ) )


    def test_02_openDatabase(self):
        """Open database"""
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase(connectString)
        dbSvc.createDatabase(connectString)
        db = dbSvc.openDatabase(connectString)
        self.assert_( db.existsFolderSet( "/" ) )


    def test_03_openDatabaseException(self):
        """Open database with exceptions"""
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase(connectString)
        ###if "COOL_PYCOOLTEST_SKIP_EXCEPTIONS" in os.environ: return # NO LONGER NEEDED FOR ROOT6! (CORALCOOL-2743)
        self.assertRaises( Exception, dbSvc.openDatabase, connectString ) # test CORALCOOL-2743
        dbSvc.createDatabase(connectString)
        self.assertRaises( Exception, dbSvc.createDatabase, connectString ) # test CORALCOOL-2743
        db = dbSvc.openDatabase(connectString)
        self.assert_( db.existsFolderSet( "/" ) )


#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIDatabaseSvc' ) ):
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

