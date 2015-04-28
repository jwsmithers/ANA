#!/usr/bin/env python

#
# Martin's test for missing tables in coolValidateSchema (task #7691)
# With Andrea's modifications - drop a table by brute force instead...
#

from PyCool import cool
import os, sys, re

# connect string for the schema owner
connectString = 'Oracle-avalassi/COOLTEST'

app = cool.Application()
dbSvc = app.databaseService()
svcVersion = dbSvc.serviceVersion()

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
        # recreate the database and create folders
        print "Drop the test database"
        dbSvc.dropDatabase( connectString )
        print "Create the test database as the owner"
        db = dbSvc.createDatabase( connectString )
        db.createFolderSet('/f1',"test folder set");
        db.createFolder( '/f2', spec, "MV folder", \
                         cool.FolderVersioning.MULTI_VERSION )
        db.createFolder( '/f3', spec, "SV folder", \
                         cool.FolderVersioning.SINGLE_VERSION )
        db.closeDatabase()

        # drop table in /f1 by brute force
        err = os.system( "coolExecuteSql.csh %s -e 'DROP TABLE %s;'" % \
                         ( connectString, "COOLTEST_F0001_TAGS_SEQ" ) );
        if ( err != 0 ) :
                print "Error: could not drop table COOLTEST_F0001_TAGS_SEQ"
                sys.exit(err);

        # drop table in /f2 by brute force
        err = os.system( "coolExecuteSql.csh %s -e 'DROP TABLE %s;'" % \
                         ( connectString, "COOLTEST_F0002_TAGS_SEQ" ) );
        if ( err != 0 ) :
                print "Error: could not drop table COOLTEST_F0002_TAGS_SEQ"
                sys.exit(err);

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
        expectedCorruptFolders =['/f1','/f2'] 
        if (corruptFolders != expectedCorruptFolders) :
                print "Error: expected ", expectedCorruptFolders,\
                      " but found: ", corruptFolders
                sys.exit(255)                
        print "Test OK" 
        sys.exit(0);
