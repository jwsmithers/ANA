#!/usr/bin/env python

#
# Martin's test for missing tables in coolValidateSchema (task #7691)
#

from PyCool import cool
import os, sys, re

# connect string for the schema owner
connectString = 'Oracle-avalassi/COOLTEST'
# connect string for a writer 
connectStringWriter = 'Oracle-avalassi(writer)/COOLTEST'

# user name to whom writer privileges will be granted
# (should be the one used in connectStringWriter)
writerUser = 'lcg_cool_w'

app = cool.Application()
dbSvc = app.databaseService()
svcVersion = dbSvc.serviceVersion()
outLvl = app.outputLevel()

spec = cool.RecordSpecification()
spec.extend( "I", cool.StorageType.Int32 )

def checkValidateOutput(line) :
        p = re.compile('.*Corrupt or missing table for folder \'([^\']*)\'.*');
        m=p.match(line)
        if ( m ) :
                print "Found corrupt folder " , m.group(1)
                return m.group(1)
        return ""

if (1):
        # recreate the database
        print "Drop the test database"
        dbSvc.dropDatabase( connectString )
        print "Create the test database as the owner"
        db = dbSvc.createDatabase( connectString )
        db.closeDatabase()

        # grant writer privileges to writerUser
        print "Grant WRITER privileges"
        err = os.system( "coolPrivileges %s GRANT WRITER %s" % \
                         ( connectString, writerUser ) );
        if ( err != 0 ) :
                print "Error: could not grant writer privileges to '%s'" % \
                      writerUser
                sys.exit(err);
       
        # try to create folders with the writer user
        # (this fails and is expected to corrupt the database)
        print "Reopen the database as a writer\n"
        ok=1; 
        db = dbSvc.openDatabase( connectStringWriter, False )
        app.setOutputLevel( 1 )

       # try to create /f1
        print "Try to create /f1"
        try:
                db.createFolderSet('/f1',"test folder set");
                print "Error: 'createFolderSet()' did not throw... \n";
                ok=0;
        except RuntimeError:
                print "Failed as expected\n";

        # try to create /f2
        print "Try to create /f2"
        try:
                db.createFolder( '/f2', spec, "MV folder", \
                                 cool.FolderVersioning.MULTI_VERSION )
                print "Error: creating multi version folder",\
                      "with 'createFolder()' did not throw... \n";
                ok=0;
        #except RuntimeError:
        #        print "Failed as expected\n";
        except TypeError:
                print "Failed as expected\n";

        # try to create /f3
        print "Try to create /f3"
        try:
                db.createFolder( '/f3', spec, "SV folder", \
                                 cool.FolderVersioning.SINGLE_VERSION )
                print "Error: creating single verstion folder",\
                      "with 'createFolder()' did not throw... \n";
                ok=0;
        #except RuntimeError:
        #        print "Failed as expected\n";
        except TypeError:
                print "Failed as expected\n";

        # check that all failed
        app.setOutputLevel( outLvl )
        if ( ok == 0 ) :
                print "Error: Some or all folder creation calls"\
                      "did not fail as expected."
                print "Error: Could not set up test database."
                sys.exit(255);

        # run coolValidateSchema on test database
        print "Validate the schema using:\n",\
              "coolValidateSchema %s" % connectString;
        f = os.popen("coolValidateSchema %s" % connectString);
        corruptFolders=[];
        for line in f:
               ret = checkValidateOutput(line);
               if (ret != "") :
                        corruptFolders.append(ret);

        # check that coolValidateSchema reported the errors
        expectedCorruptFolders =['/f1','/f2','/f3'] 
        if (corruptFolders != expectedCorruptFolders) :
                print "Error: expected ", expectedCorruptFolders,\
                      " but found: ", corruptFolders
                sys.exit(255)                
        print "Passed test." 
        sys.exit(0);
