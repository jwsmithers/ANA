
import unittest, sys, os

from PyCool import cool, coral
import traceback


connectString = None

class TestSkeleton( unittest.TestCase ):

    def setUp(self):
        pass


    def tearDown(self):
        pass


    def test_method(self):
        self.assertEquals( 2, 1+1 )


#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestSkeleton' ) ):
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

