
import sys
import code
import readline
import atexit
import os
import re
import logging

log = logging.getLogger( __name__ )
log.setLevel( logging.INFO )

handler = logging.StreamHandler()
format = "%(levelname)s:%(name)s: %(message)s"
handler.setFormatter( logging.Formatter( format ) )
log.addHandler( handler )


historyFile = '.coolconsole_hist'

class HistoryConsole(code.InteractiveConsole):
    """
    This class extends InteractiveConsole with command line history. The
    history can be accessed with the usual CURSOR UP keystroke. It is also
    stored to a file '%s' in the user's home directory.
    """ % historyFile

    def __init__( self,
                  locals = None,
                  filename = "<console>",
                  histfile = os.path.join( os.environ["HOME"], historyFile) ):
        code.InteractiveConsole.__init__( self )
        self.init_history( histfile )

    def init_history( self, histfile ):
        readline.parse_and_bind( "tab: complete" )
        readline.set_history_length( 100 )
        if hasattr( readline, "read_history_file" ):
            try:
                readline.read_history_file( histfile )
            except IOError:
                pass
            atexit.register( self.save_history, histfile )

    def save_history( self, histfile ):
        readline.write_history_file( histfile )



class PyCoolConsole( HistoryConsole ):

    commands = { 'help' : 'help overview',
                 'less' : 'list contents of folders, e.g. less "/a"',
                 'ls' : 'list contents of foldersets, e.g. ls "/"',
                 'exit' : 'quit the interpreter session',
                 'quit' : 'alias for exit',
                 'open' : "open the specified database, "
                          "e.g. open 'sqlite://...'"
                 }

    banner = "Welcome to CoolConsole. Type 'help' for instructions."

    def __init__( self, connectString = None ):
        HistoryConsole.__init__( self )
        self.connectString = connectString


    def interact( self ):
        self.push( 'from PyCoolTool import PyCoolTool' )
        if connectString is not None:
            self.push( 'this = PyCoolTool("%s")' % self.connectString )
            self.push( 'print this' )
        else:
            print ( "Not connected. Use the 'open' command to connect to "
                    "a database." )
        HistoryConsole.interact( self, self.banner )


    def parseLine( self, line ):
        for command in self.commands.keys():
            res = re.search( '^' + command + '\s*(?P<remainder>.*)', line )
            if res is not None:
                return command, res.group('remainder')
        return None, line


    def createInterpreterCommand( self, command, argumentString ):
        if command == 'less':
            return self.command_less( argumentString )
        elif command == 'ls':
            return self.command_ls( argumentString )
        elif command == 'help':
            return self.command_help( argumentString )
        elif command == 'exit':
            return self.command_exit()
        elif command == 'quit':
            return self.command_exit()
        elif command == 'open':
            return self.command_open( argumentString )
        else:
            return None


    def command_less( self, argumentString ):
        if argumentString is None:
            raise TypeError( "usage: less <folder>" )
        argumentString.strip()
        nodes = argumentString.split()
        cmds = []
        for node in nodes:
            if not node.startswith( '/' ): node = '/' + node
            cmds.append( 'this.less("%s", header=True)' % node )
        return ';'.join( cmds )


    def command_ls( self, argumentString ):
        if argumentString is None: argumentString = '/'
        argumentString.strip()
        if argumentString == '': argumentString = '/'
        nodes = argumentString.split()
        cmds = []
        for node in nodes:
            if not node.startswith( '/' ): node = '/' + node
            cmds.append( 'this.ls("%s", header=True)' % node )
        return ';'.join( cmds )


    def command_help( self, argumentString ):
        if argumentString is not None and argumentString != '':
            # we have a python "help(...)" command most likely
            # we only want to intercept "help", therefore return the original
            return 'help ' + argumentString
        print 'Available commands:'
        keys = self.commands.keys()
        keys.sort()
        for key in keys:
            print '  %(key)-8s : %(value)s' % { 'key' : key,
                                                'value' : self.commands[key] }
        print "These commands are shortcuts that are forwarded to a CoolTool"
        print "instance 'this', referring to the currently connected database."
        print "Since this environment is a fully functional python shell,"
        print "'this' can be used like any python object, e.g.:"
        print "  this.ls( '/' )"
        return ''


    def command_exit( self ):
        return 'import sys ; sys.exit(0)'


    def command_open( self, argumentString ):
        log.debug( 'argumentString: ' + argumentString )
        if ( not argumentString.startswith('"') and
             not argumentString.startswith("'") ):
            argumentString = "'" + argumentString + "'"
            log.debug( 'argumentString: ' + argumentString )
        return 'this = PyCoolTool(%s)' % argumentString


    def push(self, line):
        command, remainder = self.parseLine( line )
        log.debug( 'command:   %s' % command )
        log.debug( 'remainder: %s' % remainder )

        res = self.createInterpreterCommand( command, remainder )
        if res is not None:
            log.debug( 'command: "%s"' % res )
            interpreterCommand = res
        else:
            interpreterCommand = line

        #HistoryConsole.push( self, 'print "cmd: %s"' % interpreterCommand )
        return HistoryConsole.push( self, interpreterCommand )




if __name__ == '__main__':


    usage = ( 'Usage: %s <connect string>\n'
              '\t<connect string>: a RAL connect string\n'
              ) % sys.argv[0]


    if len( sys.argv ) == 2:
        connectString = sys.argv[1]
    else:
        connectString = None

    tool = PyCoolConsole( connectString )
    tool.interact()


