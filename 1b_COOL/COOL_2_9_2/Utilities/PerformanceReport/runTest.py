#!/usr/bin/env python

from PyCool import cool
from time import time
import os, sys

myTagName = "myheadtag"
myUserTagName = "myusertag"
useCase=os.environ["useCase"]
clob=False
vectorPayload=False
# NB Exec plans for channels table may differ and still be good (bug #103740)!
chSel=cool.ChannelSelection.all() # select all 10 channels (no selection)
###chSel=cool.ChannelSelection(0,9) # select "only" 10 channels out of 10
#chSel=cool.ChannelSelection(3,6) # select only 4 channels out of 10
###chSel=cool.ChannelSelection(4,5) # select only 2 channels out of 10
###chSel=cool.ChannelSelection(5) # select only 1 channel out of 10
if useCase=="MVTR":
    print 'Use case:',useCase,'(MV tag retrieval)'
    w_userTagName=""
    r_tagName=myTagName
    payloadTable=False
elif useCase=="MVHR":
    print 'Use case:',useCase,'(MV HEAD retrieval)'
    w_userTagName=""
    r_tagName="HEAD"
    payloadTable=False
elif useCase=="MVUR":
    print 'Use case:',useCase,'(MV user tag retrieval)'
    w_userTagName=myUserTagName
    r_tagName=myUserTagName
    payloadTable=False
elif useCase=="SV_R":
    print 'Use case:',useCase,'(SV retrieval)'
    w_userTagName=""
    r_tagName=""
    payloadTable=False
elif useCase=="MPTR":
    print 'Use case:',useCase,'(MV tag retrieval with payload table)'
    w_userTagName=""
    r_tagName=myTagName
    payloadTable=True
elif useCase=="MPHR":
    print 'Use case:',useCase,'(MV HEAD retrieval with payload table)'
    w_userTagName=""
    r_tagName="HEAD"
    payloadTable=True
elif useCase=="MPUR":
    print 'Use case:',useCase,'(MV user tag retrieval with payload table)'
    w_userTagName=myUserTagName
    r_tagName=myUserTagName
    payloadTable=True
elif useCase=="SP_R":
    print 'Use case:',useCase,'(SV retrieval with payload table)'
    w_userTagName=""
    r_tagName=""
    payloadTable=True
elif useCase=="SC_R":
    print 'Use case:',useCase,'(SV retrieval with CLOB)'
    w_userTagName=""
    r_tagName=""
    payloadTable=False
    clob=True
elif useCase=="SW_R":
    print 'Use case:',useCase,'(SV retrieval with vector payload)'
    w_userTagName=""
    r_tagName=""
    payloadTable=False
    vectorPayload=True
#elif useCase=="SR_R":
#    print 'Use case:',useCase,'(SV retrieval with range partitioning)'
#    w_userTagName=""
#    r_tagName=""
#    payloadTable=False
else:
    print 'ERROR! Unknown use case:', useCase
    sys.exit(-1)

connectString=""

app = cool.Application()
dbSvc = app.databaseService()
svcVersion = dbSvc.serviceVersion()

svcVersion12x = False
svcVersion13x = False
svcVersion20x = False
svcVersion280 = False
svcVersion290 = False
if   ( svcVersion == "1.2.3" ): svcVersion12x = True
elif ( svcVersion == "1.2.4" ): svcVersion12x = True
elif ( svcVersion == "1.2.5" ): svcVersion12x = True
elif ( svcVersion == "1.2.6" ): svcVersion12x = True
elif ( svcVersion == "1.2.7" ): svcVersion12x = True
elif ( svcVersion == "1.2.8" ): svcVersion12x = True
elif ( svcVersion == "1.2.9" ): svcVersion12x = True
elif ( svcVersion == "1.3.0" ): svcVersion13x = True
elif ( svcVersion == "1.3.1" ): svcVersion13x = True
elif ( svcVersion == "1.3.2" ): svcVersion13x = True
elif ( svcVersion == "1.3.3" ): svcVersion13x = True
elif ( svcVersion == "1.3.4" ): svcVersion13x = True
elif ( svcVersion == "2.0.0" ): svcVersion20x = True
elif ( svcVersion == "2.1.0" ): svcVersion20x = True
elif ( svcVersion == "2.1.1" ): svcVersion20x = True
elif ( svcVersion == "2.2.0" ): svcVersion20x = True
elif ( svcVersion == "2.2.1" ): svcVersion20x = True
elif ( svcVersion == "2.2.2" ): svcVersion20x = True
elif ( svcVersion == "2.3.0" ): svcVersion20x = True
elif ( svcVersion == "2.3.1" ): svcVersion20x = True
elif ( svcVersion == "2.4.0" ): svcVersion20x = True
elif ( svcVersion == "2.5.0" ): svcVersion20x = True
elif ( svcVersion == "2.6.0" ): svcVersion20x = True
elif ( svcVersion == "2.7.0" ): svcVersion20x = True
elif ( svcVersion == "2.8.0" ): svcVersion280 = True
elif ( svcVersion == "2.8.1" ): svcVersion280 = True
elif ( svcVersion == "2.8.2" ): svcVersion280 = True
elif ( svcVersion == "2.8.3" ): svcVersion280 = True
elif ( svcVersion == "2.8.4" ): svcVersion280 = True
elif ( svcVersion == "2.8.5" ): svcVersion280 = True
elif ( svcVersion == "2.8.6" ): svcVersion280 = True
elif ( svcVersion == "2.8.7" ): svcVersion280 = True
elif ( svcVersion == "2.8.8" ): svcVersion280 = True
elif ( svcVersion == "2.8.9" ): svcVersion280 = True
elif ( svcVersion == "2.8.10" ): svcVersion280 = True
elif ( svcVersion == "2.8.11" ): svcVersion280 = True
elif ( svcVersion == "2.8.12" ): svcVersion280 = True
elif ( svcVersion == "2.8.13" ): svcVersion280 = True
elif ( svcVersion == "2.8.14" ): svcVersion280 = True
elif ( svcVersion == "2.8.15" ): svcVersion280 = True
elif ( svcVersion == "2.8.16" ): svcVersion280 = True
elif ( svcVersion == "2.8.17" ): svcVersion280 = True
elif ( svcVersion == "2.8.18" ): svcVersion280 = True
elif ( svcVersion == "2.8.19" ): svcVersion280 = True
elif ( svcVersion == "2.9.0" ): svcVersion290 = True
elif ( svcVersion == "2.9.1" ): svcVersion290 = True
elif ( svcVersion == "2.9.2" ): svcVersion290 = True
elif ( svcVersion == "3.0.0" ): svcVersion290 = True
if ( vectorPayload and not svcVersion290 ):
    print 'ERROR! Vector payload performance test not supported for service version:', svcVersion
    sys.exit(-1)
elif ( svcVersion20x or svcVersion280 or svcVersion290 ):
    from PyCool import coral
    rSpec = cool.RecordSpecification()
    rSpec.extend( "I", cool.StorageType.Int32 )
    if ( clob ) : rSpec.extend( "S64k", cool.StorageType.String64k )
    else : rSpec.extend( "S4k", cool.StorageType.String4k )
    emptyPayload = cool.Record( rSpec )
elif ( clob ):
    print 'ERROR! CLOB performance test not supported for service version:', svcVersion
    sys.exit(-1)
elif ( svcVersion13x ):
    from PyCool import coral
    xSpec = cool.ExtendedAttributeListSpecification()
    xSpec.push_back( "I", "int" )
    rSpec = xSpec.attributeListSpecification()
    emptyPayload = coral.AttributeList( rSpec )
elif ( svcVersion12x ):
    from PyCool import pool
    rSpec = pool.AttributeListSpecification()
    rSpec.push_back( "I", "int" )
    emptyPayload = pool.AttributeList( rSpec )
else:
    print 'ERROR! Unknown COOL database service version:', svcVersion
    sys.exit(-1)

fName = "/f1"

# ---- Parameters to write data ----
### [NB each IOV has hardcoded size 1 (iov_until=iov_since+1)]
### Number of channels in the folder (w_nChan): 10
w_nChan = 10
### Number of IOVs written out per channel (w_nBulks*w_bulkSize): 100k
### Number of IOVs written out in total: (w_nBulks*w_bulkSize*w_nChan): 1M
w_nBulks = 100
if useCase=="SW_R" : w_nBulks = 10 # same #payloads with fewer IOVs
w_bulkSize = 1000 # Default: 1000; Quick tests: 100
if useCase=="MVTR" or useCase=="MPTR": w_bulkSize = 100 # bad_alloc bug #89867
### DERIVED VALUE: total number of IOVs per channel
w_nIovsPerChan=w_nBulks*w_bulkSize

# ---- Parameters to read data ----
### Number of 'queries' (x values on the plots): 100
### [This is the number of browseObjects calls (one query is one such call)]
r_nBrowseCalls = 100
### DERIVED VALUE: IOV spacing between successive browseObjects calls: 1000
### [Spacing of iov_since: (k0,k0+N), (k0+1000,k0+1000+N)...]
r_brSpacing = int(w_nIovsPerChan/r_nBrowseCalls)
if r_nBrowseCalls*r_brSpacing != w_nIovsPerChan:
    print 'ERROR! #IOVS per channel not a multiple of #browse calls'
    sys.exit(-1)
### Range of IOVs read per channel with each call: 10 (MUST BE <= spacing)
### [Call (k0,k0+10),(k0+1000,k0+1010), not (k0,k0+1000),(k0+1000,k0+2000)]
### [Retrieve few IOVs otherwise exec plan effect << data volume effect!]
r_brSize = 10
if r_brSize > r_brSpacing:
    print 'ERROR! browse size > browse spacing'
    sys.exit(-1)

#-------------------------------------------------------------------------

def dummyPayload( index ):
    payload = emptyPayload
    payload["I"] = index
    if ( clob ): payload["S64k"] = "Object %93d" % (index)
    else: payload["S4k"] = "Object %93d" % (index)
    return payload

#-------------------------------------------------------------------------

def dropDb():
    print "Drop the test database"
    dbSvc.dropDatabase( connectString )

#-------------------------------------------------------------------------

def createDb():
    print "Create the test database"
    db = dbSvc.createDatabase( connectString )
    if vectorPayload:
        if not svcVersion290:
            print 'ERROR! Vector payload requires at least COOL 2.9.0'
            sys.exit(-1)
        if useCase=="SW_R":
            fDesc = "SV folder with vector payload"
            fMode = cool.FolderVersioning.SINGLE_VERSION
        else:
            fDesc = "MV folder with vector payload"
            fMode = cool.FolderVersioning.MULTI_VERSION
        pMode = cool.PayloadMode.VECTORPAYLOAD
        fSpec = cool.FolderSpecification( fMode, rSpec, pMode )
        f = db.createFolder( fName, fSpec, fDesc )
    elif payloadTable :
        if not svcVersion280 and not svcVersion290:
            print 'ERROR! Payload table requires at least COOL 2.8.0'
            sys.exit(-1)
        if useCase=="SP_R":
            fDesc = "SV folder with payload table"
            fMode = cool.FolderVersioning.SINGLE_VERSION
        else:
            fDesc = "MV folder with payload table"
            fMode = cool.FolderVersioning.MULTI_VERSION
        fSpec = cool.FolderSpecification( fMode, rSpec, True )
        f = db.createFolder( fName, fSpec, fDesc )
    else:
        if useCase=="SV_R" or \
           useCase=="SR_R" or useCase=="SC_R" :
            f = db.createFolder( fName, rSpec, "SV folder", \
                                 cool.FolderVersioning.SINGLE_VERSION )
        else:
            f = db.createFolder( fName, rSpec, "MV folder", \
                                 cool.FolderVersioning.MULTI_VERSION )

#-------------------------------------------------------------------------

def populateDb():
    print "Populate the test database"
    db = dbSvc.openDatabase( connectString, False )
    f = db.getFolder( fName )
    f.setupStorageBuffer()
    if not vectorPayload:
        payload = dummyPayload( 0 );
    else:
        payload = cool.IRecordVector()
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(0) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(1) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(2) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(3) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(4) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(5) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(6) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(7) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(8) ) )
        payload.push_back( cool.PyCool.Helpers.IRecordPtr( dummyPayload(9) ) )
    print ( "#%18s %20s" %( "IOV_since range", "bulk insertion time" ) )
    tot_time = time()
    for chanId in range( 1, w_nChan+1 ):
        print "Channel",chanId
        for iBulk in range( 0, w_nBulks ):
        ###for iBulk in range( 0, w_nBulks+1 ): # test coalesce in last MV bulk
            t = time()
            for iIov in range( 0, w_bulkSize ):
                key = iBulk * w_bulkSize + iIov
                ### --- SINGLE VERSION insert ---
                if useCase == "SV_R" or useCase == "SP_R" or \
                   useCase == "SR_R" or useCase == "SC_R" or \
                   useCase == "SW_R" :
                    # UNTIL=+inf (SV open intervals)
                    keyMax = cool.ValidityKeyMax # UNTIL=+inf
                    # UNTIL=SINCE+1 (SV closed intervals)
                    ###keyMax = key+1 # UNTIL=SINCE+1
                ### --- MULTI VERSION insert ---
                else:
                    # UNTIL=max (MV overlaps)
                    keyMax = w_nBulks * w_bulkSize
                    # Different UNTIL - test coalesce in last MV bulk
                    ###if iBulk >= w_nBulks:
                    ###    key = iBulk * w_bulkSize + iIov*10
                    ###    keyMax = key + 5
                f.storeObject( key, keyMax, payload, chanId, w_userTagName )
            f.flushStorageBuffer()
            t = time() - t
            print ( "%8d - %8d %20.3f"\
              %( iBulk*w_bulkSize, (iBulk+1)*w_bulkSize-1, t ) )
    # Insert 100 more user tags times 10 stacks
    # This leads to more realistic loads and plans for the MVUR case
    # See https://savannah.cern.ch/task/?44885#comment15
    if w_userTagName != "" :
        ### --- MULTI VERSION insert ---
        # UNTIL=max (MV overlaps)
        keyMin = 0
        keyMax = w_nBulks * w_bulkSize
        for iUTag in range( 0, 100 ):
            t = time()
            w_userTagName2 = w_userTagName + str(iUTag)
            for chanId in range( 1, w_nChan+1 ):
                for iNewHead in range( 0, 10 ):
                    f.storeObject( key, keyMax, payload, chanId, w_userTagName2, True ) # userTagOnly==True (task #6153)
            f.flushStorageBuffer()
            t = time() - t
            print ( "%16s %2d %20.3f"\
                    %( "Extra user tag #", iUTag, t ) )
    tot_time = time() - tot_time
    print ( "#%18s %20.3f" %( "TOTAL", tot_time ) )

#-------------------------------------------------------------------------

def tagDb():
    print "Tag the test database (if required)"
    db = dbSvc.openDatabase( connectString, False )
    f = db.getFolder( fName )
    if useCase == "MVTR" or useCase== "MPTR" :
        print "Tag the current HEAD"
        tag_time = time()
        f.tagCurrentHead( myTagName )
        tag_time = time() - tag_time
        print ( "#%18s %20.3f" %( "+ TAG", tag_time ) )
    else:
        print "Nothing to tag for use case", useCase

#-------------------------------------------------------------------------

def stressTest( peekHigh = False, dumpQuery=True ) :
    print "Run the stress test against the test database"
    db = dbSvc.openDatabase( connectString )
    f = db.getFolder( fName )
    outfile = open( "test.dat", "w" )
    print        ( "#%18s %20s"  %("IOV query range","bulk retrieval time") )
    outfile.write( "#%18s %20s\n"%("IOV query range","bulk retrieval time") )
    for iQuery in range( 0, r_nBrowseCalls+1 ): # peek (0), browse (1-N)
        if iQuery == 0: # peek high or low (0)
            if peekHigh: key = (r_nBrowseCalls-1)*r_brSpacing
            else: key = 0
        else: # browse and plot (1-N)
            key = (iQuery-1)*r_brSpacing # (0,1,...N-1)*spacing
        t = time()
        f.browseObjects( key, key+r_brSize, chSel, r_tagName )
        ###for iOffset in range( 0, r_brSize ):
        ###    key1 = key + iOffset
        ###    f.findObject( key1, 0, r_tagName )
        ###    f.browseObjects( key1, key1, chSel, r_tagName )
        t = time() - t
        if iQuery == 0:
            print        ( "%8d - %8d %20.3f"  % ( key, key+r_brSize, t ) ), \
                         ( "%s"%"(PEEK HIGH)" if peekHigh else "(PEEK LOW)" )

            tot_time = time()
        else:
            print        ( "%8d - %8d %20.3f"  % ( key, key+r_brSize, t ) )
            outfile.write( "%8d - %8d %20.3f\n"% ( key, key+r_brSize, t ) )
    tot_time = time() - tot_time
    print        ( "#%18s %20.3f"   %( "TOTAL (no PEEK)", tot_time ) )
    outfile.write( "#%18s %20.3f\n" %( "TOTAL (no PEEK)", tot_time ) )
    if dumpQuery: dumpQuery()

#-------------------------------------------------------------------------

def dumpQuery() :
    print "Dump a typical query against the test database"
    db = dbSvc.openDatabase( connectString )
    f = db.getFolder( fName )
    key = (r_nBrowseCalls-1)*r_brSpacing
    oldLevel = app.outputLevel()
    app.setOutputLevel( 1 )
    t = time()
    f.browseObjects( key, key+r_brSize, chSel, r_tagName )
    ###f.findObject( key, 0, r_tagName )
    ###f.browseObjects( key, key, chSel, r_tagName )
    t = time() - t
    app.setOutputLevel( oldLevel )
    print ( "#%18s %20s"\
      %( "IOV query range", "bulk retrieval time" ) )
    print ( "%8d - %8d %20.3f"\
      %( key, key+r_brSize, t ) )

##############################################################################

if __name__ == "__main__":

    if connectString == "":
        envKey = "COOLTESTDB"
        if envKey in os.environ:
            connectString = os.environ[envKey]
        else:
            print 'ERROR! You must set the environment variable %s'%(envKey)
            sys.exit(-1)
    print "Database URL:", connectString

    for arg in sys.argv[1:] :
        if arg == "dropDb" :
            dropDb()
        if arg == "createDb" :
            createDb()
        if arg == "populateDb" :
            populateDb()
            tagDb()
        if arg == "tagDb" :
            tagDb()
        if arg == "stressTest" :
            stressTest()
        if arg == "stressTestPeekLow" :
            stressTest( False )
        if arg == "stressTestPeekHigh" :
            stressTest( True )
        if arg == "stressTestPeekLowNoDump" :
            stressTest( False, False )
        if arg == "stressTestPeekHighNoDump" :
            stressTest( True, False )
        if arg == "dumpQuery" :
            dumpQuery()
