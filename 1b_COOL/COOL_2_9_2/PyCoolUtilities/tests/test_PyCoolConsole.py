
import unittest, sys, os

from PyCoolConsole import PyCoolConsole
from PyCoolPayloader import PyCoolPayloader


class TestPyCoolConsole( unittest.TestCase ):

    dbCreated = False

    def setUp(self):
#        if not self.dbCreated:
#            self.payloader = CoolPayloader( connectString, recreateDb = True )
#            self.payloader.writeFolder( '/a' )
#            self.payloader.writeFolder( '/b' )
#            self.payloader.writeFolder( '/c' )
#            self.dbCreated = True
        self.console = PyCoolConsole( connectString )


    def test_parseLine_ls(self):
        cmd, remainder = self.console.parseLine( "ls" )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '' )
        cmd, remainder = self.console.parseLine( "ls " )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '' )
        cmd, remainder = self.console.parseLine( "ls /" )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '/' )
        cmd, remainder = self.console.parseLine( "ls /a" )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '/a' )
        cmd, remainder = self.console.parseLine( "ls /a " )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '/a ' )
        cmd, remainder = self.console.parseLine( "ls /a /b" )
        self.assertEquals( cmd, 'ls' )
        self.assertEquals( remainder, '/a /b' )
        cmd, remainder = self.console.parseLine( "this.ls()" )
        self.assertEquals( cmd, None )
        self.assertEquals( remainder, 'this.ls()' )


    def test_parseLine_exit(self):
        cmd, remainder = self.console.parseLine( "exit" )
        self.assertEquals( cmd, 'exit' )
        cmd, remainder = self.console.parseLine( "exit " )
        self.assertEquals( cmd, 'exit' )


    def test_parseLine_quit(self):
        cmd, remainder = self.console.parseLine( "quit" )
        self.assertEquals( cmd, 'quit' )
        cmd, remainder = self.console.parseLine( "quit " )
        self.assertEquals( cmd, 'quit' )


    def test_createInterpreterCommand_ls(self):
        cmd = self.console.createInterpreterCommand( 'ls', None )
        self.assertEquals( cmd, 'this.ls("/", header=True)' )
        cmd = self.console.createInterpreterCommand( 'ls', '' )
        self.assertEquals( cmd, 'this.ls("/", header=True)' )
        cmd = self.console.createInterpreterCommand( 'ls', '/a' )
        self.assertEquals( cmd, 'this.ls("/a", header=True)' )
        cmd = self.console.createInterpreterCommand( 'ls', '/a /b' )
        self.assertEquals( cmd,
                    'this.ls("/a", header=True);this.ls("/b", header=True)' )


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

