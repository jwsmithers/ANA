#!/usr/bin/env python

###print 'DEBUG: Import os, sys'
import os, sys

###print 'DEBUG: From PyCool import cool'
from PyCool import cool

###print 'DEBUG: Import CoolAuthentication'
import CoolAuthentication

##############################################################################

def addIovIntoNewChannel( svcVersion, db, fullPath ):

    # Get the specified folder
    f = db.getFolder( path )

    # Determine the database technology
    dbId = db.databaseId()
    if dbId.startswith( "sqlite" ):
        tech = "sqlite"
    elif dbId.startswith( "frontier" ):
        tech = "frontier"
    else:
        dbIdProp = CoolAuthentication.getDbIdProperties( dbId )
        tech = CoolAuthentication.technology( dbIdProp )
    ###print 'Database technology is', tech

    # Determine the folder schema version
    schema = f.folderAttributes()["NODE_SCHEMA_VERSION"]
    ###print 'Folder schema version is', schema

    # Determine the folder versioning mode
    mode = f.versioningMode()
    if mode == cool.FolderVersioning.SINGLE_VERSION : mode = "SV"
    else : mode = "MV"
    ###print 'Folder versioning mode is', mode

    # Determine the largest channel# in the folder
    chMax = 0
    channels = f.listChannels()
    for ch in channels:
        if ch>chMax: chMax=ch
    ###print 'Largest channel in', path, 'is', chMax

    # Attempt to store an IOV into a new channel
    caught = False
    try:
        spec = f.payloadSpecification()
        payload = cool.Record( spec )
        print 'Store an IOV into new channel', chMax+1, 'in folder', path
        f.storeObject( 0, 10, payload, chMax+1 )
    except Exception, inst:
        caught = True

    # Analyse the results: supported software versions are 2.0.0 and above;
    # expect an exception ONLY when writing with old software (2.0.0-2.1.1)
    # into a MV folder with the new 2.0.1 schema (where FKs are defined)
    # for the oracle and mysql technology (where FKs are enforced).
    expected = False
    if svcVersion == "2.0.0" \
           or svcVersion == "2.1.0" \
           or svcVersion == "2.1.1" :
        if schema == "2.0.1" :
            if mode == "MV" :
                if tech == "oracle" or tech == "mysql" :
                    expected = True

    # An exception was caught and expected: OK
    if caught and expected :
        msg = "An exception was expected and caught \n(release=" + svcVersion + ", folder schema=" + schema + ", mode=" + mode + ", technology=" + tech + ")"
        print msg
    # An exception was caught but not expected: ERROR!
    elif caught and not expected :
        msg = "ERROR! An exception was caught but not expected \n(release=" + svcVersion + ", folder schema=" + schema + ", mode=" + mode + ", technology=" + tech + ") : \n" + inst.__str__()
        raise Exception( msg )
    # An exception was not caught but it was expected: ERROR!
    elif not caught and expected :
        msg = "ERROR! An exception was expected but not caught \n(release=" + svcVersion + ", folder schema=" + schema + ", mode=" + mode + ", technology=" + tech + ")"
        raise Exception( msg )
    # An exception was not caught and not expected: OK
    elif not caught and not expected :
        msg = "An exception was not expected and not caught \n(release=" + svcVersion + ", folder schema=" + schema + ", mode=" + mode + ", technology=" + tech + ")"
        print msg

##############################################################################

if __name__ == '__main__':

    envKey = "COOLTESTDB"

    if len(sys.argv) == 2:
        connectString = sys.argv[1]
        del sys.argv[1]
    elif len(sys.argv) == 1 and envKey in os.environ:
        connectString = os.environ[envKey]
    else:
        print 'Usage: ' + os.path.basename(sys.argv[0]) + ' [dbId]'
        print 'ERROR! You must pass dbId as the first argument'\
              ' or set the environment variable %s'%(envKey)
        sys.exit(-1)

    # Store an IOV into a new channel
    app = cool.Application()
    app.setOutputLevel( 6 )
    dbSvc = app.databaseService()
    readOnly = False
    svcVersion = dbSvc.serviceVersion()
    ###print 'Software version is', svcVersion
    db = dbSvc.openDatabase( connectString, readOnly )

    try:
        # Single version folder
        path = '/SimpleSpec/SV/sv1'
        addIovIntoNewChannel( svcVersion, db, path )
        # Multi version folder
        path = '/SimpleSpec/MV/mv1'
        addIovIntoNewChannel( svcVersion, db, path )
        print "\nOK"
    except Exception, inst :
        print inst
        print "\nFAILED (errors=1)"

