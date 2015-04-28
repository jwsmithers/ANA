#!/usr/bin/env python
import os, sys

def setNewValueFromTag( oldValue, line, tag ):
    if line.startswith( tag ) :
        return line[len(tag):len(line)-1].strip(' ').strip('=').strip(' ')
    else :
        return oldValue

def getDbIdProperties( dbId, rwOnly=False, debug=False ) :
    if rwOnly:
        cmd = 'coolAuthentication -1RW "' + dbId + '"'
    else:
        cmd = 'coolAuthentication -1 "' + dbId + '"'
    f = os.popen(cmd)
    theCorA = ""
    theCorR = ""
    theCorM = ""
    theMidT = ""
    theTech = ""
    theSrvr = ""
    theSchm = ""
    theUser = ""
    thePswd = ""
    theDbNm = ""
    line = f.readline()
    while line :
        ###print line
        theCorA = setNewValueFromTag( theCorA, line, "==> coralAlias" )
        theCorR = setNewValueFromTag( theCorR, line, "==> coralReplica" )
        theCorM = setNewValueFromTag( theCorM, line, "==> coralMode" )
        theMidT = setNewValueFromTag( theMidT, line, "==> middleTier" )
        theTech = setNewValueFromTag( theTech, line, "==> technology" )
        theSrvr = setNewValueFromTag( theSrvr, line, "==> server" )
        theSchm = setNewValueFromTag( theSchm, line, "==> schema" )
        theUser = setNewValueFromTag( theUser, line, "==> user" )
        thePswd = setNewValueFromTag( thePswd, line, "==> password" )
        theDbNm = setNewValueFromTag( theDbNm, line, "==> dbname" ) #COOL13x
        theDbNm = setNewValueFromTag( theDbNm, line, "==> dbName" ) #COOL20x
        line = f.readline()
    status = f.close()
    if status :
        # Fix bug #24248: do not fail for sqlite/frontier if there are no
        # username/password in authentication.xml (they are dummy anyway!).
        # NB: this bug has been fixed in coolAuthentication in COOL200, but
        # the schema evolution test uses coolAuthentication from COOL133c.
        if theTech == "sqlite" :
            ###print "WARNING! Command '" + cmd + "' failed! Status:", status
            if theUser == "" : theUser = "DUMMY"
            if thePswd == "" : thePswd = "DUMMY"
        elif theTech == "frontier" :
            ###print "WARNING! Command '" + cmd + "' failed! Status:", status
            if theUser == "" :
                if theSchm != "" : theUser = theSchm
                else : theUser = "DUMMY"
            if thePswd == "" : thePswd = "DUMMY"
        else :
            print "ERROR! Command '" + cmd + "' failed! Status:", status
            ###sys.exit(status) # Bug #53850 ('Status: 256' is returned as 0)
            sys.exit(-1)
    if debug :
        print "CoralAlias: '" + theCorA + "'"
        print "CoralReplica: '" + theCorR + "'"
        print "CoralMode: '" + theCorM + "'"
        print "MiddleTier: '" + theMidT + "'"
        print "Technology: '" + theTech + "'"
        print "Server: '" + theSrvr + "'"
        print "Schema: '" + theSchm + "'"
        print "User: '" + theUser + "'"
        print "Password: '" + thePswd + "'"
        print "DbName: '" + theDbNm + "'"
    return [ theTech, theSrvr, theSchm, theUser, thePswd, theDbNm, theCorA, theCorR, theCorM, theMidT ]

def technology( dbIdProperties ) : return dbIdProperties[0]

def server( dbIdProperties ) : return dbIdProperties[1]

def schema( dbIdProperties ) : return dbIdProperties[2]

def user( dbIdProperties ) : return dbIdProperties[3]

def password( dbIdProperties ) : return dbIdProperties[4]

def dbName( dbIdProperties ) : return dbIdProperties[5]

def coralAlias( dbIdProperties ) : return dbIdProperties[6]

def coralReplica( dbIdProperties ) : return dbIdProperties[7]

def coralMode( dbIdProperties ) : return dbIdProperties[8]

def middleTier( dbIdProperties ) : return dbIdProperties[9]

