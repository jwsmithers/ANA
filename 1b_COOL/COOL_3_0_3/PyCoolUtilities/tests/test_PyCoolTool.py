
import unittest, sys, os

from PyCoolTool import PyCoolTool
from PyCoolPayloader import PyCoolPayloader
from StringIO import StringIO

class TestPyCoolTool( unittest.TestCase ):

    dbCreated = False

    def setUp(self):
        ###if not self.dbCreated: # leads to MySQL hang (bug #103684)
        if not TestPyCoolTool.dbCreated: # fix bug #103684
            payloader = PyCoolPayloader( connectString, recreateDb = True )
            payloader.db.createFolderSet( '/f1', 'first folderset' )
            payloader.db.createFolderSet( '/f2', 'a description' )
            payloader.writeFolder( '/f1/a',
                                   description = 'a folder',
                                   objectIds = range(4),
                                   channels = range(2) )
            payloader.writeFolder( '/f1/b',
                                   objectIds = range(4),
                                   channels = range(2) )
            payloader.writeFolder( '/f2/c',
                                   objectIds = range(4),
                                   channels = range(2) )
            ###self.dbCreated = True # leads to MySQL hang (bug #103684)
            TestPyCoolTool.dbCreated = True # fix bug #103684
        self.tool = PyCoolTool( connectString )


    def test_less(self):
        res = self.tool.less( '/f1/a' )

        self.assert_( res[0]['str'].startswith( "[0,1[ (0) [I (Int32) : 0" ) )
        self.assert_( res[1]['str'].startswith( "[1,2[ (0) [I (Int32) : 1000" ) )
        self.assert_( res[2]['str'].startswith( "[2,3[ (0) [I (Int32) : 2000" ) )
        self.assert_( res[3]['str'].startswith( "[3,4[ (0) [I (Int32) : 3000" ) )
        self.assert_( res[4]['str'].startswith( "[0,1[ (1) [I (Int32) : 1" ) )
        self.assert_( res[5]['str'].startswith( "[1,2[ (1) [I (Int32) : 1001" ) )
        self.assert_( res[6]['str'].startswith( "[2,3[ (1) [I (Int32) : 2001" ) )
        self.assert_( res[7]['str'].startswith( "[3,4[ (1) [I (Int32) : 3001" ) )


    def test_ls(self):
        res = self.tool.ls( '/' )
        self.assertEquals( res[0]['name'], '/f1' )
        self.assertEquals( res[0]['description'], 'first folderset' )
        self.assertEquals( res[1]['name'], '/f2' )
        self.assertEquals( res[1]['description'], 'a description' )


    def test_str(self):
        ###if "COOL_PYCOOLTEST_SKIP_EXCEPTIONS" in os.environ: return # NO LONGER NEEDED FOR ROOT6! (ATCONDDB-13)
        envKey = 'COOLTESTDB_BOGUS'
        if envKey in os.environ:
            self.assertEquals
            ( str(self.tool), "Connected to '%s'" % self.tool.connectString() )
            tool = PyCoolTool( os.environ[envKey] )
            self.assertEquals( str(tool), 'Not connected' )
        else:
            self.fail( 'Missing environment variable: %s' % envKey )


    def test_folderInfo(self):
        res = self.tool.folderInfo( '/f1/a' )
        self.assertEquals( res['name'], '/f1/a' )
        self.assertEquals( res['cardinality'], 8 )
        self.assertEquals( res['description'], 'a folder' )
        self.assertEquals( res['size'], 8*(4+4000+8) )


    def test_folderSetInfo(self):
        res = self.tool.folderSetInfo( '/f1' )
        self.assertEquals( res['name'], '/f1' )
        self.assertEquals( res['description'], 'first folderset' )



#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'Test' ) ):
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

