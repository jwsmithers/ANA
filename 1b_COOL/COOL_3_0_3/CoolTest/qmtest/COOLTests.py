########################################################################
# File:   CoolTestExtensions.py
# Author: Marco Clemencic CERN/PH-LBC
# Date:   16/11/2005   
#
# Contents:
#   TemporaryEnvironment: class to change the environment and revert to
#                         the original one
#
#   DBPreparer: handle the details for temporary test databases
#
#   StandardTest: extension to ShellCommandTest that finds Python
#                 scripts in the PATH ad run them through the
#                 interpreter
#
#   DatabaseTest: run a test that needs a database
#
#   SourceTargetTest: run a test that needs 2 databases
#                     (source and target)
#
# Copyright (c) 2003 by CodeSourcery, LLC.  All rights reserved.
#
########################################################################
__author__  = 'Marco Clemencic CERN/PH-LBC' 
__version__ = "$Revision: 1.153 $" 
__tag__     = "$Name: not supported by cvs2svn $" 

########################################################################
# Imports
########################################################################

#import dircache
import os
import qm
import sys
import re
import tempfile
import shutil
import string
from subprocess import Popen, PIPE, STDOUT
from qm.test.classes.command import ExecTestBase, ShellCommandTest
from time import ctime, time, sleep

########################################################################
# Classes
########################################################################
class TemporaryEnvironment:
    """
    Class to changes the environment temporarily.
    """
    def __init__(self, orig = os.environ):
        """
        Create a temporary environment on top of the one specified
        (it can be another TemporaryEnvironment instance).
        """
        #print "New environment"
        self.changes = {}
        self.env = orig
        
    def __setitem__(self,key,value):
        """
        Set an environment variable recording the previous value.
        """
        if key not in self.changes :
            if key in self.env :
                self.changes[key] = self.env[key]
            else:
                self.changes[key] = None
        self.env[key] = value
        
    def __getitem__(self,key):
        """
        Get an environment variable.
        Needed to provide the same interface as os.environ.
        """
        return self.env[key]
    
    def __delitem__(self,key):
        """
        Unset an environment variable.
        Needed to provide the same interface as os.environ.
        """
        if key not in self.env :
            raise KeyError(key)
        self.changes[key] = self.env[key]
        del self.env[key]

    def keys(self):
        """
        Return the list of defined environment variables.
        Needed to provide the same interface as os.environ.
        """
        return self.env.keys()
        
    def items(self):
        """
        Return the list of (name,value) pairs for the defined environment variables.
        Needed to provide the same interface as os.environ.
        """
        return self.env.items()
    
    def __contains__(self,key):
        """
        Operator 'in'.
        Needed to provide the same interface as os.environ.
        """
        return key in self.env
    
    def restore(self):
        """
        Revert all the changes done to the orignal environment.
        """
        for key,value in self.changes.items():
            if value is None:
                del self.env[key]
            else:
                self.env[key] = value
        self.changes = {}
        
    def __del__(self):
        """
        Revert the changes on destruction.
        """
        #print "Restoring the enviroment"
        self.restore()

    def gen_script(self,shell_type):
        """
        Generate a shell script to reproduce the changes in the environment.
        """
        shells = [ 'csh', 'sh', 'bat' ]
        if shell_type not in shells:
            raise RuntimeError("Shell type '%s' unknown. Available: %s"%(shell_type,shells))
        out = ""
        for key,value in self.changes.items():
            if key not in self.env:
                # unset variable
                if shell_type == 'csh':
                    out += 'unsetenv %s\n'%key
                elif shell_type == 'sh':
                    out += 'unset %s\n'%key
                elif shell_type == 'bat':
                    out += 'set %s=\n'%key
            else:
                # set variable
                if shell_type == 'csh':
                    out += 'setenv %s "%s"\n'%(key,self.env[key])
                elif shell_type == 'sh':
                    out += 'export %s="%s"\n'%(key,self.env[key])
                elif shell_type == 'bat':
                    out += 'set %s=%s\n'%(key,self.env[key])
        return out

class CoolTestError(RuntimeError):
    _message = ""
    def __init__(self,msg=None):
        _msg = self._message
        if msg is not None:
            _msg += " (%s)"%msg
        RuntimeError.__init__(self,_msg)
    
class DropDBError(CoolTestError):
    _message = "Errors while dropping the DB"
    def __init__(self,msg=None):
        CoolTestError.__init__(self,msg)
        
class DropDBTimeOutError(CoolTestError):
    _message = "Time-out exceeded when dropping the DB"
    def __init__(self,msg=None):
        CoolTestError.__init__(self,msg)
        
class PrepareEnvError(CoolTestError):
    _message = "Cannot prepare the environment"
    def __init__(self,msg=None):
        CoolTestError.__init__(self,msg)

class DBPreparer:
    package_names  =[ "RelationalCool", "PyCool", "PyCoolUtilities",
                      "CoolKernel", "CoolApplication" ]
    backend_names = [ "Oracle", "SQLite", "MySQL", "Frontier", "FrontierCache", "CoralServer-Oracle", "CoralServer-MySQL" ]
    _DropDBTimeOut = 1200 # max. number of seconds a coolDropDb can run
    def __init__(self, package, backend, name, env, variable_name):
        #print "__init__",package, backend, name, env, variable_name
        
        self._initialized = False 
        self.name = name
        self.tempdir = None
        self.env = env
        self.variable_name = variable_name

        #print package, self.package_names
        if package in self.package_names:
            self.package = package
        else:
            raise RuntimeError("Package '%s' unknown"%package)
        
        #print backend, self.backend_names
        if backend in self.backend_names:
            self.backend = backend
        else:
            raise RuntimeError("Backend type '%s' unknown"%backend)

        self._initialized = True
        
        self.env[variable_name] = self.ConnectionString()
        ## Not needed any more (task #3442)
        ##if self.backend == "Frontier":
        ##    self.env[variable_name+"_R"] = self.ConnectionString().replace(self.backend,self.backend + "R")
        
        ###self.DropDB() # MOVED TO Database/SourceTarget/EvolutionTest.Run()

    def SQLiteFilename(self):
        if self.tempdir is None:
            self.tempdir = tempfile.mkdtemp()
        return os.path.join(self.tempdir,"sqliteTest-%s.db"%(self.name))

    def ConnectionString(self):
        """Generate the connection string to use to connect to the DB"""
        if self.backend == "SQLite":
            return "sqlite://;schema=%s;dbname=%s"%(self.SQLiteFilename(),self.name)
            # With COOL >= 2.0.0 we can use the following
            #return "sqlite_file:%s/%s"%(self.SQLiteFilename(),self.name)
        else:
            
            # AV Fix for bug #28349 (use USERNAME instead of USER on Windows)
            if "USER" in self.env: user=self.env["USER"]
            else: user=self.env["USERNAME"]
            # Temporarily keep lcgnight in parallel to sftnight (bug #100746)
            # The dblookup.xml file will only contain entries for sftnight
            if user == "lcgnight": user="sftnight"
            return "COOL-%s-%s/%s"%(self.backend,user,self.name)
        
    def DropDB(self):
        
        def doKill(proc):
            """Function for a platform independent kill of a process.
            The argument must be a Popen object.
            """
            if sys.platform.startswith("win"):
                from win32api import TerminateProcess
                TerminateProcess(proc._handle,-9)
            else:
                from signal import SIGKILL
                os.kill(proc.pid, SIGKILL)
                
        message = ""
        if self._initialized:
            # remove pending databases
            if self.backend == "SQLite":
                filename = self.SQLiteFilename()
                message = "DropDB (remove file %s)"%filename
                if os.path.exists(filename): os.remove(filename)
            else:
                # MCl: This does not work if the output is too much and I do
                # not read it; unfortunately it is difficult to have a 
                # non-blocking read to make the check of the timeout possible.
                # @TODO: (MCl) find a better solution of coolDropDB timeout
                #dropDB = Popen(["coolDropDB",self.ConnectionString()],
                #               stdout=PIPE,stderr=PIPE)
                devnull = "/dev/null"
                if sys.platform.startswith("win"):
                    devnull = "nul"
                message = "DropDB (coolDropDB %s)"%self.ConnectionString()
                ###sys.stdout.write("-> DROPDB...\n")
                ###dropDB = Popen("coolDropDB %s > %s"%(self.ConnectionString(),devnull), stdout=PIPE, stderr=PIPE, shell=True)
                dropDB = Popen("coolDropDB %s"%(self.ConnectionString()), stdout=PIPE, stderr=STDOUT, shell=True) # AV dump output if it fails (bug #91006)
                start_time = time()
                while dropDB.poll() is None:
                    if (time()-start_time) > self._DropDBTimeOut:
                        doKill(dropDB)
                        dropDB.wait()
                        raise DropDBTimeOutError("%ds, %s"%(self._DropDBTimeOut,
                                                           self.ConnectionString()))
                    sleep(1)
                if dropDB.wait() != 0:
                    raise DropDBError( "ERROR! coolDropDB returned an error code\n" + dropDB.stdout.read() )
                ###sys.stdout.write("-> DROPDB... DONE\n")
        return "\n"+message+"\n"
        
    def __del__(self):
        ###try:
        ###    if "COOL_QMTEST_SKIPEVOLVE" not in env :
        ###        self.DropDB()
        ###except Exception,x:
        ###    # ignore failures of drop DB on exit: it is less important
        ###    pass
        if self.tempdir is not None:
            try:
                ###print "WARNING: Remove temp dir '%s'"%self.tempdir
                shutil.rmtree(self.tempdir)
                pass
            except:
                print "WARNING: Could not remove temp dir '%s'"%self.tempdir
                pass
            self.tempdir = None

class StandardTest(ShellCommandTest):
    """Extend standard QMTest shell command test to run python tests as well as
    normal tests. Modify ValidateOutput to avoid the stdout check."""
    # extra arguments
    arguments = [
        qm.fields.TextField( name = "unsupported_platforms",
                             title = "Unsupported Platforms",
                             description = """Comma-separated list of regular expression matching the platforms on which the test cannot be executed.""" ),
                ]
    def SupportedPlatform(self, context, result):
        platform = self.GetPlatform()
        unsupported = [ re.compile(x.strip()) for x in str(self.unsupported_platforms).split(',') if x.strip() ]
        for p_re in unsupported:
            if p_re.search(platform):
                result.SetOutcome(result.UNTESTED)
                result[result.CAUSE] = 'Platform not supported.'
                return False
        return True
    
    def GetPlatform(self):
        """
        Return the platform Id defined in CMTCONFIG or SCRAM_ARCH.
        """
        arch = "None"
        # check architecture name
        if "CMTCONFIG" in os.environ:
            arch = os.environ["CMTCONFIG"]
        elif "SCRAM_ARCH" in os.environ:
            arch = os.environ["SCRAM_ARCH"]
        return arch
        
    def Run(self, context, result):
        """Check if we want to run a python test."""
        
        # check if the test can be run on the current platform
        if not self.SupportedPlatform(context, result):
            return
        
        original_command = self.command
        is_python_script = False
        if self.command.endswith(".py"):
            is_python_script = True
            # We need to run a python test and not a standard executable
            for d in os.environ["PATH"].split(os.path.pathsep):
                if os.path.isdir(d) and self.command in os.listdir(d):
                    # we found the script in the path
                    self.command = 'python "%s"'%os.path.join(d,self.command)
                    break

        #print self.command
        # Test in valgrind if CORAL_TESTSUITE_VALGRIND is set (task #12670)
        if 'CORAL_TESTSUITE_VALGRIND' in os.environ:
            # Add the valgrind suppression file from CORAL
            valgrindSupp = ''
            if 'CORAL_TESTSUITE_VALGRIND_SUPP' in os.environ:
                valgrindSupp = ' --suppressions=' + os.path.abspath( os.environ['CORAL_TESTSUITE_VALGRIND_SUPP'] )
            # Add as additional valgrind suppression file from ROOT
            ###valgrindSupp += ' --suppressions=' + os.path.abspath( os.environ['ROOTSYS'] + '/etc/valgrind-root.supp' )
            # Define the path for the output valgrind log
            valgrindLog = '../../logs/qmtest/valgrind/'
            # Option 1 - allow a single platform for valgrind tests
            ###if os.environ['CMTCONFIG'] != 'x86_64-slc5-gcc43-dbg':
            ###    result.SetOutcome(result.UNTESTED)
            ###    result[result.CAUSE] = 'Use another platform for valgrind.'
            ###    return
            # Option 2 - use a different log directory per platform
            valgrindLog = valgrindLog+os.environ['CMTCONFIG']
            valgrindLog = os.path.abspath( valgrindLog )
            try: os.mkdir( valgrindLog )
            except OSError: pass
            valgrindLog = valgrindLog+'/valgrind.'+context[context.ID_CONTEXT_PROPERTY]+'.txt'
            # Redefine the valgrind command
            self.command = 'valgrind -v --leak-check=full --show-reachable=yes --error-limit=no --log-file='+valgrindLog+valgrindSupp+' --gen-suppressions=all --num-callers=50 --track-origins=yes '+self.command

        # Else debug through gdb if COOL_DEBUG is set
        elif 'COOL_DEBUG' in os.environ \
                 and os.environ['COOL_DEBUG'].upper() in ['1','Y','YES','ON','GDB'] \
                 and not sys.platform.startswith("darwin"):
            
            if sys.platform.startswith("win"):
                dbg_window = "cmd "
            else:
                dbg_window = "xterm -e "
            
            if is_python_script:
                if os.environ['COOL_DEBUG'].upper() != 'GDB':
                    self.command = self.command.replace("python", "python -m pdb")
                else:
                    print "Command to execute: %s"%self.command
                    self.command = 'gdb python'
            elif sys.platform.startswith("linux"):
                self.command = 'gdb %s'%self.command
            elif sys.platform.startswith("win"):
                # On vc7: 'devenv /debug %s'
                # On vc9: 'vcexpress /debug %s'
                self.command = 'devenv /debug %s'%self.command
            self.command = dbg_window + self.command
            self.timeout = -1
        
        # We can use the environment variable COOL_IGNORE_TIMEOUT
        # to ignore all the time-outs for manual tests.
        # See discussion in bug #28400.
        # (Note: the time-out on coolDropDB is always active)
        if 'COOL_IGNORE_TIMEOUT' in os.environ:
            self.timeout = -1
        
        # sometimes (nightlies) the env variable "OS" is not set
        if "OS" not in os.environ:
            if sys.platform.startswith("win"):
                os.environ["OS"] = 'Windows_NT'
            elif sys.platform.startswith("linux"):
                os.environ["OS"] = 'Linux'
            elif sys.platform.startswith("darwin"):
                os.environ["OS"] = 'Darwin'
            else:
                # assume linux for unknows platform IDs
                os.environ["OS"] = 'Linux'
        
        # @todo: This is a work-around for bug #27650
        # module resource is available only on Unix 
        if not sys.platform.startswith("win"):
            from resource import setrlimit,RLIMIT_NOFILE
            setrlimit(RLIMIT_NOFILE,(1024,1024))

        # unset special DEBUG environment variables
        for v in [ 'COOL_TIMINGREPORT',
                   'COOL_COOLCHRONO_PROCMEMORY',
                   'COOL_210ITERATOR',
                   'COOL_PDBSTRESSTEST_NBYTES',
                   'CORAL_TESTSUITE_SLEEPFOR01466',
                   'CORAL_TESTSUITE_SLEEPFOR01466_PREFIX']:
            if v in os.environ : del os.environ[v]
        
        # unset COOLTESTDB_R environment variable (task #3442)
        for v in [ 'COOLTESTDB_R' ]:
            if v in os.environ : del os.environ[v]
        
        # unset special Oracle environment variables: this should
        # prevent errors like 'SP2-0310 unable to access glogin.sql'
        for v in [ 'ORACLE_HOME' ]:
            if v in os.environ : del os.environ[v]

        # Workaround for ORA-01466 on Oracle 11g (bug #89735)
        if isinstance( self, SourceTargetTest ):
            os.environ[ 'CORAL_TESTSUITE_SLEEPFOR01466' ] = '1'
            os.environ[ 'CORAL_TESTSUITE_SLEEPFOR01466_PREFIX' ] = self.DBName(DatabaseTest.TARGET_DB)
        elif isinstance( self, DatabaseTest ):
            os.environ[ 'CORAL_TESTSUITE_SLEEPFOR01466' ] = '1'
            os.environ[ 'CORAL_TESTSUITE_SLEEPFOR01466_PREFIX' ] = self.DBName(DatabaseTest.DEFAULT_DB)
        else: pass # no need to set CORAL_TESTSUITE_SLEEPFOR01466xxx
        
        # Workaround for ORA-04031 on Oracle 11g (bug #94270)
        os.environ[ 'CORAL_ORA_DISABLE_OPT_DYN_SAMP' ] = '1'

        # Bypass tests that are expected to fail with ROOT6 (CORALCOOL-2741)
        # [These are now set in config/cmt/requirements]
        ###os.environ[ 'COOL_PYCOOLTEST_SKIP_EXCEPTIONS' ] = '1'
        ###os.environ[ 'COOL_PYCOOLTEST_SKIP_ROOT6927' ] = '1'

        # dump software versions on a test by test basis
        # [NB CORALSYS and COOLSYS _only_ exist for this reason!]
        for vname in "COOLSYS", "CORALSYS", "ROOTSYS" :
            if vname in os.environ:
                result['CoolTest.%s'%vname] = os.path.abspath(os.environ[vname])

        ###sys.stdout.write("-> RUN: "+self.command+"\n")
        result['CoolTest.command'] = self.command
        ShellCommandTest.Run(self,context,result)
        # In some cases on win the test succeed, but the exit code is not 0
        if sys.platform.startswith("win"):
            if result['ExecTest.exit_code'] != '0':
                # check for the oval
                m = re.search('\[OVAL\] Cppunit-result =([0-9])',result['ExecTest.stdout'])
                if m:
                    if m.group(1) == '0':
                        result['ExecTest.original_exit_code'] = result['ExecTest.exit_code']
                        result['ExecTest.exit_code'] = '0'
                        result.SetOutcome(result.PASS)
                else:
                    # check for an OK alone on a line (python unittest)
                    m = re.search('\r\nOK\r\n',result['ExecTest.stdout'])
                    if m:
                        result['ExecTest.original_exit_code'] = result['ExecTest.exit_code']
                        result['ExecTest.exit_code'] = '0'
                        result.SetOutcome(result.PASS)
        self.command = original_command
        if result.GetOutcome() not in [ result.PASS ]:
            self.DumpEnvironment(result)
        
    def DumpEnvironment(self,result):
        vars = os.environ.keys()
        vars.sort()
        result['COOLTest.environment'] = \
            result.Quote('\n'.join(["%s=%s"%(v,os.environ[v]) for v in vars]))
        
    # Convert binary characters on stdout to utf8 (fix bug #54882)
    # http://www.pyzine.com/Issue008/Section_Articles/article_Encodings.html
    # Do not attempt to encode all chars: just try to avoid UnicodeEncodeError!
    def utf8OrSkip(self,text):
        utf8 = ""
        for i in text:
            try:
                utf8 += i.encode('utf8')
            except:
                utf8 += "X"
        return utf8
        
    # Remove lines matching a given pattern
    def grepNoMatch(self,text,pattern):
        outcome = ""
        for line in text.split('\n'): # Fix bug #77517 ('\n' instead of '\r\n')
            ###sys.stdout.write("-> GREP.LINE: '"+line+"'\n")
            if line != "":
                m = re.search(pattern,line)
                if not m: outcome = outcome + line + '\n'
        return outcome
        
    def RunProgram(self, program, arguments, context, result):
        """Run the 'program'.

        'program' -- The path to the program to run.

        'arguments' -- A list of the arguments to the program.  This
        list must contain a first argument corresponding to 'argv[0]'.

        'context' -- A 'Context' giving run-time parameters to the
        test.

        'result' -- A 'Result' object.  The outcome will be
        'Result.PASS' when this method is called.  The 'result' may be
        modified by this method to indicate outcomes other than
        'Result.PASS' or to add annotations.
        
        @attention: This method has been copied from command.ExecTestBase
                    (QMTest 2.3.0) and modified to keep stdout and stderr
                    for tests that have been terminated by a signal.
                    (Fundamental for debugging in the Application Area)
        """

        # Initialise result['ExecTest.stdout'] so that we can append to it
        try: dummy = result['ExecTest.stdout']
        except: result['ExecTest.stdout'] = ""
        # Construct the environment.
        environment = self.MakeEnvironment(context)
        # Create the executable.
        if self.timeout >= 0:
            # Hardcode a minimum timeout of 10 minutes
            timeout = max(600,self.timeout)
        else:
            # If no timeout was specified, we sill run this process in a
            # separate process group and kill the entire process group
            # when the child is done executing.  That means that
            # orphaned child processes created by the test will be
            # cleaned up.
            timeout = -2
        e = qm.executable.Filter(self.stdin, timeout)
        # Run it.
        exit_status = e.Run(arguments, environment, path = program)

        # If the process terminated normally, check the outputs.
        if sys.platform.startswith("win") or os.WIFEXITED(exit_status):
            # There are no causes of failure yet.
            causes = []
            # The target program terminated normally.  Extract the
            # exit code, if this test checks it.
            if self.exit_code is None:
                exit_code = None
            elif sys.platform.startswith("win"):
                exit_code = exit_status
            else:
                exit_code = os.WEXITSTATUS(exit_status)
            # Get the output generated by the program.
            stdout = e.stdout
            stderr = e.stderr
            ###sys.stdout.write("-> RUN.STDERR (1): '"+stderr+"'\n")
            # Remove expected lines from stdout
            ###stdout = self.grepNoMatch(stdout,pattern)
            # Remove expected lines from stderr
            # -> Ignore warnings from the ROOT signal handler (see task #6919)
            pattern = "from LD_PRELOAD cannot be preloaded: ignored."
            stderr = self.grepNoMatch(stderr,pattern)
            ###sys.stdout.write("-> RUN.STDERR (2): '"+stderr+"'\n")
            # Record the results.
            result["ExecTest.exit_code"] = str(exit_code)
            result["ExecTest.stdout"] += self.utf8OrSkip(result.Quote(stdout))
            result["ExecTest.stderr"] = result.Quote(stderr)
            # Check to see if the exit code matches.
            if exit_code != self.exit_code:
                causes.append("exit_code")
                result["ExecTest.expected_exit_code"] = str(self.exit_code)
            # Validate the output.
            causes += self.ValidateOutput(stdout, stderr, result)
            # If anything went wrong, the test failed.
            if causes:
                result.Fail("Unexpected %s." % string.join(causes, ", ")) 
        elif os.WIFSIGNALED(exit_status):
            # The target program terminated with a signal.  Construe
            # that as a test failure.
            signal_number = str(os.WTERMSIG(exit_status))
            result.Fail("Program terminated by signal.")
            result["ExecTest.signal_number"] = signal_number
            result["ExecTest.stdout"] += result.Quote(e.stdout)
            result["ExecTest.stderr"] = result.Quote(e.stderr)
        elif os.WIFSTOPPED(exit_status):
            # The target program was stopped.  Construe that as a
            # test failure.
            signal_number = str(os.WSTOPSIG(exit_status))
            result.Fail("Program stopped by signal.")
            result["ExecTest.signal_number"] = signal_number
            result["ExecTest.stdout"] += result.Quote(e.stdout)
            result["ExecTest.stderr"] = result.Quote(e.stderr)
        else:
            # The target program terminated abnormally in some other
            # manner.  (This shouldn't normally happen...)
            result.Fail("Program did not terminate normally.")

    def ValidateOutput(self, stdout, stderr, result):
        """Overload ExectTestBase.ValidateOutput to skip the stdout check.
        This was previously achieved by modifying the ExecTestBase class in
        the qmtest installation: this patch allows the use of the default
        qmtest (fixing bug #70804). It is enough to overload the method for
        this class StandardTest because it is the only class in COOL that
        inherits from ExecTestBase or from one of its three derived classes 
        ExecTest, ShellCommandTest and ShellScriptTest."""
        causes = ExecTestBase.ValidateOutput(self, stdout, stderr, result)
        if "standard output" in causes: causes.remove("standard output")
        return causes

class DatabaseTest(StandardTest):
    """ This class adds to the standard QMTest shell command test the
        possibility of setting the environment needed to run COOL tests.
    """
    # extra arguments
    arguments = [
        qm.fields.EnumerationField( name = "db_type",
                                    title = "Database type",
                                    default_value = "SQLite",
                                    enumerals = DBPreparer.backend_names,
                                    description = """The type of database the test will access""" ),
        qm.fields.EnumerationField( name = "package_name",
                                    title = "Name of the package being tested",
                                    enumerals = DBPreparer.package_names,
                                    default_value = "RelationalCool",
                                    description = """Wether the test needs 2 databases,
                                    one as source and one as target.""" )
        ]

    # database type of names
    DEFAULT_DB = 0
    SOURCE_DB  = 1
    TARGET_DB  = 2
    
    def DBName(self, type = 0):
        """Generate the conventional db name for tests."""
        # Special naming conventions for nightlies: hash of (path+config)
        # - tests use different names for different slots
        #   (slot is in path, eg /build/nightlies/dev2/Thu/COOL/COOL-preview)
        # - tests use different names for different platforms
        id = os.getcwd() + self.GetPlatform()
        # The first letter is because a DBNAME cannot start with a number
        if type == DatabaseTest.SOURCE_DB:
            name = 'S'
        elif type == DatabaseTest.TARGET_DB:
            name = 'T' 
        else:
            name = 'C'
        name += hex(abs((id).__hash__()))[-7:].upper()
        return name


    def PrepareEnv(self,env):

        # Environment for the nightlies (user lcgnight/sftnight) - START
        # Keep both old user lcgnight and new user sftnight (see bug #100746)
        if sys.platform.startswith("win") :
            raise RuntimeError("Windows is no longer supported!")
        elif sys.platform.startswith("darwin") and "USER" in env and \
                 ( env["USER"] == "lcgnight" or \
                   env["USER"] == "sftnight" ) :
            # Use credentials from $HOME/private on MacOSX (AFS not available)
            env["CORAL_AUTH_PATH"] = os.path.join(env["HOME"],"private")
            env["CORAL_DBLOOKUP_PATH"] = env["CORAL_AUTH_PATH"]
        elif sys.platform.startswith("linux") and "USER" in env and \
                 ( env["USER"] == "lcgnight" or
                   env["USER"] == "sftnight" ) :
            # Use credentials from POOL AFS area on Linux
            env["CORAL_AUTH_PATH"] = "/afs/cern.ch/sw/lcg/app/pool/db"
            env["CORAL_DBLOOKUP_PATH"] = env["CORAL_AUTH_PATH"]
        # Environment for the nightlies (user lcgnight/sftnight) - END
        
        # Path to authentication.xml (CORAL_AUTH_PATH)
        if "CORAL_AUTH_PATH" not in env:
            # On Win32, variable HOME is not set, so we set AFSHOME ourselves.
            possible_home_vars = ["AFSHOME", "HOME"]
            for n in possible_home_vars:
                if n in env:
                    env["CORAL_AUTH_PATH"] = os.path.join(env[n],"private")
                    break
            # We didn't manage to set CORAL_AUTH_PATH: do we really need it?
            if "CORAL_AUTH_PATH" not in env:
                if self.db_type not in [ "SQLite", "Frontier", "FrontierCache" ]:
                    # All back-ends different from SQLite and Frontier need it
                    raise PrepareEnvError("Cannot set CORAL_AUTH_PATH")
                
        # Path to dblookup.xml (CORAL_DBLOOKUP_PATH)
        if "CORAL_DBLOOKUP_PATH" not in env:
            env["CORAL_DBLOOKUP_PATH"] = env["CORAL_AUTH_PATH"]
        
        # Path to tnsnames.ora - this should not be needed? (CORALCOOL-2756)
        if self.db_type in [ "Oracle", "Frontier", "FrontierCache" ] :
            if "TNS_ADMIN" not in env:
                env["TNS_ADMIN"] = "/afs/cern.ch/sw/lcg/app/releases/CORAL/internal/oracle/admin"

        # Test Oracle threads on slc5
        #if self.GetPlatform().find("i686-slc5-gcc34") >= 0 :
        #    env["CORAL_ORA_NO_OCI_THREADED"] = "1"
        #elif self.GetPlatform().find("i686-slc5-gcc43") >= 0 :
        #    env["CORAL_ORA_OCI_NO_MUTEX"] = "1"

        # Signal handler (either COOL or ROOT - not both!)
        useRootSignalHandler = False
        if sys.platform.startswith("linux") or \
               sys.platform.startswith("darwin") :
            useRootSignalHandler = True # ROOT signal handle on linux/darwin
        if not useRootSignalHandler:
            env["COOL_ENABLE_COOLSIGNALHANDLER"] = "1"
            if "LD_PRELOAD" in env:
                del env["LD_PRELOAD"]
        else:
            if "COOL_ENABLE_COOLSIGNALHANDLER" in env:
                del env["COOL_ENABLE_COOLSIGNALHANDLER"]
            env["LD_PRELOAD"] = "libCore.so:libdl.so"

    def Run(self, context, result):
        """Prepare the environment for the test and run it."""
        
        # check if the test can be run on the current platform
        if not self.SupportedPlatform(context, result):
            return
        
        env = TemporaryEnvironment()

        try:
            self.PrepareEnv(env)
            db = DBPreparer(self.package_name,self.db_type,self.DBName(),env,"COOLTESTDB")
            result['COOLTest.connection_string'] = db.ConnectionString()
            ###sys.stdout.write(str(ctime())+" DROPDB...\n")
            result['ExecTest.stdout'] = db.DropDB()
            ###sys.stdout.write(str(ctime())+" DROPDB... DONE\n")
            ###sys.stdout.write(str(ctime())+" RUN...\n")
            StandardTest.Run(self,context,result)
            ###sys.stdout.write(str(ctime())+" RUN... DONE\n")
            ###sys.stdout.write(str(ctime())+" DROPDB...\n")
            result['ExecTest.stdout'] += db.DropDB()
            ###sys.stdout.write(str(ctime())+" DROPDB... DONE\n")
        except CoolTestError,x:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = str(x)
            self.DumpEnvironment(result)
        
        
            
class SourceTargetTest(DatabaseTest):
    """ This class extends COOLTest to use two databases instead of one.
    """   
 
    def Run(self, context, result):
        """Prepare the environment for the test and run it."""
        
        # check if the test can be run on the current platform
        if not self.SupportedPlatform(context, result):
            return
        
        env = TemporaryEnvironment()

        # This tries to have a different dbname for different
        # versions of COOL, so that we can test 2 versions in parallel
        # (mainly for the nightlies)
        version_hash = hex(abs(__tag__.__hash__()))[-2:].upper()

        try:
            self.PrepareEnv(env)
            
            db_src = DBPreparer(self.package_name,self.db_type,
                                self.DBName(DatabaseTest.SOURCE_DB),
                                env,"COOLTESTDB_SOURCE")
            db_tgt = DBPreparer(self.package_name,self.db_type,
                                self.DBName(DatabaseTest.TARGET_DB),
                                env,"COOLTESTDB_TARGET")
            result['ExecTest.stdout'] = db_src.DropDB()
            result['ExecTest.stdout'] += db_tgt.DropDB()
            
            result['COOLTest.src_connection_string'] = db_src.ConnectionString()
            result['COOLTest.tgt_connection_string'] = db_tgt.ConnectionString()
            StandardTest.Run(self,context,result)
            result['ExecTest.stdout'] += db_src.DropDB()
            result['ExecTest.stdout'] += db_tgt.DropDB()
        except CoolTestError,x:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = str(x)
            self.DumpEnvironment(result)

class EvolutionTest(DatabaseTest):
    """ This class extends COOLTest to use two databases instead of one.
    """   
    # extra arguments
    arguments = [
        qm.fields.EnumerationField( name = "original",
                                    title = "Original version",
                                    default_value = "1.3.0",
                                    enumerals = ["1.3.0"],
                                    description = """The version of the schema to start from""" )
                ]
    _versions = { "1.3.0" : ("COOL_1_3_4","LCGCMT_49"),
                  "2.0.0" : ("COOL_2_1_1","LCGCMT_52a"),
                }
    
    def PrepareTmpPackage(self,destdir,env):
        import stat
        # copy relevant python modules to the temporary directory
        cool_current_dir = env["COOLSYS"]
        for f in ["CoolAuthentication","CoolDescribeTable","PyCoolReferenceDb","CoolQueryManager"]:
                if os.path.isdir(os.path.join(cool_current_dir,'python',f)):
                    shutil.copytree(os.path.join(cool_current_dir,'python',f),os.path.join(destdir,f))
                else:
                    shutil.copyfile(os.path.join(cool_current_dir,'python',f),os.path.join(destdir,f))
                # produce more sensible error messages for bug #32362
                if os.path.exists(os.path.join(destdir,f,"__init__.pyc")):
                    os.remove(os.path.join(destdir,f,"__init__.pyc"))
        
        # prepare the requirements file
        open(os.path.join(destdir,"requirements"),"w").write("""
# This is us
use COOL  v* LCG_Interfaces
apply_tag NEEDS_COOL_FACTORY
apply_tag NEEDS_PYCOOL

# runtime-only dependencies
use Reflex v* LCG_Interfaces
use oracle v* LCG_Interfaces
use mysql  v* LCG_Interfaces
use sqlite v* LCG_Interfaces
use Frontier_Client v* LCG_Interfaces

# special runtime dependencies
use Python v* LCG_Interfaces
use XercesC v* LCG_Interfaces
use CppUnit v* LCG_Interfaces

# remove the current version from the environment
path_remove PATH '%(COOLSYS)s'
path_remove LD_LIBRARY_PATH '%(COOLSYS)s' WIN32 ''
path_remove PYTHONPATH '%(COOLSYS)s'

# SEAL quiet assert (needed for COOL134 and COOL211)
set QUIET_ASSERT yes

# SEAL configuration file (needed for COOL134 and COOL211)
set SEAL_CONFIGURATION_FILE $(COOL_base)/src/RelationalCool/tests/seal.opts.error

# add the stand-alone package to pythonpath
path_prepend PYTHONPATH '.'
"""%env)
        
        create_script = os.path.join(env["COOLSYS"],'tests','bin',
                                     'Regression','createReferenceDb.py')

        # prepare the wrapper script(s)
        # [NB disable rmtree(tempdir) if you want to look at the files!] 
        if sys.platform.startswith("win"):
            open(os.path.join(destdir,"create.bat"),"w").write("""
@echo off
cd
set CMTSITE=CERN
echo CMTSITE = %%CMTSITE%%
set SITEROOT=%%AFS%%\cern.ch
echo SITEROOT = %%SITEROOT%%
echo CMTPROJECTPATH = %%CMTPROJECTPATH%%
echo CMTPATH = %%CMTPATH%%
echo CMTCONFIG = %%CMTCONFIG%%
echo CMTROOT = %%CMTROOT%%
cmt show tags
cmt show set PYTHONPATH
cmt show macro COOL_home
cmt show macro_value COOL_home
cmt show macro ROOT_home
cmt show macro_value ROOT_home
cmt show macro COOL_base
cmt show macro_value COOL_base
cmt show macro ROOT_base
cmt show macro_value ROOT_base
cmt show macro LCG_releases
cmt show macro_value LCG_releases
cmt show macro LCG_external
cmt show macro_value LCG_external
cmt show macro LCG_home
cmt show macro_value LCG_home
cmt show macro LCG_platform
cmt show macro_value LCG_platform
cmt show macro LCG_system
cmt show macro_value LCG_system
cmt -tag_add=debug show macro LCG_platform
cmt -tag_add=debug show macro_value LCG_platform
cmt -tag_add=debug show macro LCG_system
cmt -tag_add=debug show macro_value LCG_system
cmt -tag_add=debug run set
set
cmt -tag_add=debug run python %s %%COOLTESTDB%% %%SCHEMA_VERSION%%
"""%create_script)
            open(os.path.join(destdir,"evolve.bat"),"w").write("""
@echo off
echo CMTPATH = %CMTPATH%
echo CMTCONFIG = %CMTCONFIG%
cmt run coolEvolveSchema %COOLTESTDB%
""")
        else:
            open(os.path.join(destdir,"create.sh"),"w").write("""
pwd
echo CMTPROJECTPATH = $CMTPROJECTPATH
echo CMTPATH = $CMTPATH
echo CMTCONFIG = $CMTCONFIG
echo CMTUSERCONTEXT = $CMTUSERCONTEXT
cmt show tags
cmt show set PYTHONPATH
cmt show macro COOL_home
cmt show macro_value COOL_home
cmt show macro ROOT_home
cmt show macro_value ROOT_home
cmt show macro COOL_base
cmt show macro_value COOL_base
cmt show macro ROOT_base
cmt show macro_value ROOT_base
cmt show macro LCG_releases
cmt show macro_value LCG_releases
cmt show macro LCG_external
cmt show macro_value LCG_external
cmt show macro LCG_home
cmt show macro_value LCG_home
cmt show macro LCG_platform
cmt show macro_value LCG_platform
cmt show macro LCG_system
cmt show macro_value LCG_system
echo SITEROOT = $SITEROOT
cmt run "python %s '${COOLTESTDB}' '${SCHEMA_VERSION}'"
"""%create_script)
            open(os.path.join(destdir,"evolve.sh"),"w").write("""
echo CMTPATH = $CMTPATH
echo CMTCONFIG = $CMTCONFIG
cmt run "coolEvolveSchema '${COOLTESTDB}'"
""")
            os.chmod(os.path.join(destdir,"create.sh"),stat.S_IRWXU)
            os.chmod(os.path.join(destdir,"evolve.sh"),stat.S_IRWXU)

    def PrepareCOOLEnvironment(self,schema_version,env):
        # copy the environment in a new dictionary
        newEnv = {}
        for k,v in env.items(): 
            if type(v) is str:
                # avoid the copy of the value if it is a string 
                newEnv[k] = v
            else:
                # sometimes, on win32, the environment variables are unicode
                # and Popen does not like them. 
                newEnv[k] = str(v)

        # [TODO: set LCGRELEASES $(LCG_releases) if you enable evolution tests?]
        # in the nightlies, the LCGRELEASES env variable is pointing to the
        # nightly directory, so we cannot find the old version of COOL
        pos = newEnv["LCGRELEASES"].find("nightlies")
        if pos >= 0 :
            # If we are in the nightlies, use the "official" releases
            newEnv["LCGRELEASES"] = newEnv["LCGRELEASES"][0:pos] + "releases"

        # get COOL reference version and LCGCMT version for a given
        # schema version
        cool_version, lcgcmt_version = self._versions[schema_version]
        
        lcgcmt_dir = os.path.join(env["LCGRELEASES"],"LCGCMT",lcgcmt_version)
        if not os.path.isdir(lcgcmt_dir):
            # Non-portable work-around, needed to test schema evolution in the
            # nightlies, where LCGRELEASES points to the build directory.
            if not sys.platform.startswith("win"):
                lcgcmt_dir = "/afs/cern.ch/sw/lcg/app/releases/LCGCMT/"+lcgcmt_version
            else:
                # Fix for bug #32362 - will this work even without backslashes?
                lcgcmt_dir = str(newEnv["AFS"])+"cern.ch/sw/lcg/app/releases/LCGCMT/"+lcgcmt_version
        
        # modify the environment
        newEnv["CMTPATH"] = str(lcgcmt_dir)
        newEnv["SCHEMA_VERSION"] = str(schema_version)
        newEnv["CMTCONFIG"] = str(self.GetPlatform())
        
        # the script to generate the reference DB cannot be run with
        # old COOL on AMD64
        # @todo: The check on the version should be more "precise"
        if schema_version < "2.0.0" and "amd64" in newEnv["CMTCONFIG"]:
            newEnv["CMTCONFIG"] = newEnv["CMTCONFIG"].replace("amd64","ia32")
        
        if "CMTPROJECTPATH" in newEnv: del newEnv["CMTPROJECTPATH"]
        
        # Ignore PYTHONPATH to avoid version mismatches (bug #32406)
        if "PYTHONPATH" in newEnv:
            del newEnv["PYTHONPATH"]
        
        # Ignore CMTUSERCONTEXT if set (bug #28554)
        if "CMTUSERCONTEXT" in newEnv:
            del newEnv["CMTUSERCONTEXT"]
        
        # Disable the ROOT signal handler during evolution tests (bug #54926)
        if "LD_PRELOAD" in newEnv:
            del newEnv["LD_PRELOAD"]
        
        # Fix SITEROOT for the nightlies on Windows (bug #32362)
        # NO! (1) - Only do this inside the create.bat script
        # NO! (2) - Inside create.bat, use "E:/cern.ch"
        # (but be careful that it works outside the nightlies too!)
        #siteroot = newEnv["SITEROOT"]
        #if siteroot.startswith("C:") or siteroot.startswith("c:"):
        #    siteroot = "E:/cern.ch/sw"
        #    newEnv["SITEROOT"] = str(siteroot)
            
        return newEnv
    
    def CreateReferenceDB(self,env):
        if sys.platform.startswith("win"):
            create_cmd = ["create.bat"]
            evolve_cmd = ["evolve.bat"]
        else:
            create_cmd = ["./create.sh"]
            evolve_cmd = ["./evolve.sh"]
            
        tempdir = tempfile.mkdtemp()
        output = ""
        try:
            self.PrepareTmpPackage(tempdir,env)
            
            # create original DB
            output += ('*** POPEN START ' + create_cmd[0] + ' ***\n')
            localEnv = self.PrepareCOOLEnvironment(self.original,env)
            p = Popen(create_cmd,env=localEnv,cwd=tempdir,shell=True,
                      stdout=PIPE,stderr=STDOUT)
            output += p.stdout.read()
            retcode = p.wait()
            output += ('*** POPEN DONE: ' + create_cmd[0] + ' ***\n')
            
            doEvolve = True
            if "COOL_QMTEST_SKIPEVOLVE" in env :
                output += ('*** POPEN SKIP coolEvolveSchema ***\n')
                doEvolve = False

            if doEvolve :

                # @todo: intermediate evolution steps
                #output += ('*** POPEN START ' + evolve_cmd + ' ***\n')
                 #p = Popen(evolve_cmd,env=localEnv,stdout=PIPE,stderr=STDOUT)
                #output += p.stdout.read()
                #retcode = p.wait()
                #output += ('*** POPEN DONE: ' + evolve_cmd + ' ***\n')
            
                output += ('*** POPEN START coolEvolveSchema ***\n')
                p = Popen(["coolEvolveSchema",env["COOLTESTDB"]],
                          stdout=PIPE,stderr=STDOUT)
                output += p.stdout.read()
                retcode = p.wait()
                output += ('*** POPEN DONE: coolEvolveSchema ***\n')
            
        finally:
            # clean up the temporary working directory
            shutil.rmtree(tempdir,ignore_errors=True)
            pass # Strictly needed only if you comment out rmtree...

        return output
        
    def Run(self, context, result):
        """Prepare the environment for the test and run it."""
        
        # check if the test can be run on the current platform
        if not self.SupportedPlatform(context, result):
            return
        
        env = TemporaryEnvironment()

        try:
            self.PrepareEnv(env)
            db = DBPreparer(self.package_name,self.db_type,self.DBName(),env,"COOLTESTDB")
            result['ExecTest.stdout'] = db.DropDB()
        except CoolTestError,x:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = str(x)
            self.DumpEnvironment(result)
            return
        
        result['COOLTest.initial_version'] = self.original
        try:
            creation_output = self.CreateReferenceDB(env)
        except Exception,x:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = str(x)
            self.DumpEnvironment(result)
            return
        result['COOLTest.reference_stdout'] = '<pre>' + creation_output + '\n</pre>\n'
        result['COOLTest.connection_string'] = db.ConnectionString()
        
        if "COOL_QMTEST_SKIPEVOLVE" in env :
            return

        # check that the database is created with the right version of COOL
        m = re.search('Database service loaded from software release ([0-9]*\.[0-9]*\.[0-9])',
                      creation_output)
        
        if m :
            if ( 'COOL_' + m.group(1).replace('.','_') ) != self._versions[self.original][0] :
                result.SetOutcome(result.ERROR)
                result[result.CAUSE] = 'Bad reference DB.'
                self.DumpEnvironment(result)
                return
        else:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = 'Bad reference DB.'
            self.DumpEnvironment(result)
            return

        # check that the evolution was successful
        if creation_output.find("ERROR") >= 0:
            result.SetOutcome(result.ERROR)
            result[result.CAUSE] = 'Evolution step failed.'
            self.DumpEnvironment(result)
            return

        # Ignore the command, which is not meaningful
        orig_cmd = self.command

        script = os.path.join(env["COOLSYS"],'tests','bin',
                              'Regression','testReferenceDbAll.py')
        
        cmd_variable = "${COOLTESTDB}"
        
        if sys.platform.startswith("win"):
            cmd_variable = "%COOLTESTDB%"
            
        ## Not needed any more (task #3442)
        ##if self.db_type == "Frontier":
        ##    cmd_variable = cmd_variable.replace("COOLTESTDB","COOLTESTDB_R")
            
        self.command = 'python %s %s %s' % ( script, cmd_variable, self.original )
        
        StandardTest.Run(self,context,result)        
        self.command = orig_cmd
        result['ExecTest.stdout'] += db.DropDB()
        
