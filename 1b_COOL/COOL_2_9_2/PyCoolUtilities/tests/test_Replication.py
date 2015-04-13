import unittest, sys, os, time, calendar
from subprocess import Popen, PIPE, STDOUT

from PyCool import cool

# simplify usage of these a bit...
SINGLE_VERSION = cool.FolderVersioning.SINGLE_VERSION
MULTI_VERSION  = cool.FolderVersioning.MULTI_VERSION

# more expressive shortcuts for openDatabase calls
RW = False # i.e. readOnly = False
RO = True  # i.e. readOnly = True

TEST_VECTOR = True
# find out if this cool version has been compiled with vector folder
# support
try:
    spec = defaultSpec()
    folderSpec = cool.FolderSpecification( MULTI_VERSION,
                                           spec,
                                           cool.PayloadMode.VECTORPAYLOAD )
except:
    TEST_VECTOR = False

# shortcuts for payload mode
if TEST_VECTOR:
    SEPARATE = cool.PayloadMode.SEPARATEPAYLOAD
    VECTOR = cool.PayloadMode.VECTORPAYLOAD
    INLINE = cool.PayloadMode.INLINEPAYLOAD
else:
    SEPARATE = 1 # maps to separate payload=true
    VECTOR = 2 # maps to separate payload = true
    INLINE = 0 # maps to inline payload folder


# debug?
VERBOSE = True

def payloadTableDescription( payloadTable ):
    if ( payloadTable == SEPARATE ):
        return "withPayloadTable"
    elif ( payloadTable == VECTOR ):
        return "withVectorPayload"
    else:
        return "withoutPayloadTable"

def topFolderSet( payloadTable ):
    return "/top_" + payloadTableDescription( payloadTable )

def tagSuffix( payloadTable ):
    return " " + payloadTableDescription( payloadTable )

def getNext( objs ):
    objs.goToNext()
    return objs.currentRef()

def defaultSpec():
    spec = cool.RecordSpecification()
    spec.extend( "A_IOBJ", cool.StorageType.UInt32 )
    spec.extend( "A_STRING", cool.StorageType.String4k )
    return spec

def dropDatabase( url, text ):
    startTime = time.gmtime()
    devnull = "/dev/null"
    if sys.platform.startswith("win"): devnull = "nul"
    dropDB = Popen( "coolDropDB \"%s\" > %s"%(url,devnull), shell=True )
    dropDB.wait()
    endTime = time.gmtime()
    if VERBOSE: print text, 'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

def refreshDatabase( url, text ):
    startTime = time.gmtime()
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    dbSvc.refreshDatabase( url )
    endTime = time.gmtime()
    if VERBOSE: print text, 'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

def recreateDatabase( url ):
    dropDatabase( url, '\nDEBUG: drop sourceDb' )
    startTime = time.gmtime()
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    db = dbSvc.createDatabase( url )
    if targetConnectString.lower().find("oracle") >= 0 :
        if VERBOSE: print 'DEBUG: sleep 1s'
        time.sleep(1) # Sleep for ORA-01466
    endTime = time.gmtime()
    if VERBOSE: print 'DEBUG: create sourceDb completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

def fillDatabase( url, payloadTable ):
    startTime = time.gmtime()
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    db = dbSvc.openDatabase( url, False )
    spec = defaultSpec()
    data = cool.Record( spec )
    data['A_STRING'] = 'TestData'
    # -- Folder sets
    top = topFolderSet( payloadTable )
    suf = tagSuffix( payloadTable )

    payloadTable_sav = payloadTable
    if not TEST_VECTOR and payloadTable == VECTOR:
        # configured without vector table support
        payloadTable = SEPARATE

    db.createFolderSet( top )
    db.createFolderSet( top + '/SV' )
    db.createFolderSet( top + '/MV' )
    # -- SV1
    ch = 0
    folderSpec = cool.FolderSpecification( SINGLE_VERSION, spec )
    f = db.createFolder( top + '/SV/sv1', folderSpec, '' )
    data['A_IOBJ'] = 1
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 2
    f.storeObject( 10, 15, data, ch )
    data['A_IOBJ'] = 3
    f.storeObject( 15, 20, data, ch )
    data['A_IOBJ'] = 4
    f.storeObject( 20, cool.ValidityKeyMax, data, ch )
    # -- MV1
    ch = 0
    folderSpec = cool.FolderSpecification( MULTI_VERSION, spec, payloadTable )
    f = db.createFolder( top + '/MV/mv1', folderSpec, '' )
    data['A_IOBJ'] = 11
    f.storeObject( 0, 10, data, ch )
    data['A_IOBJ'] = 12
    f.storeObject( 0, 5, data, ch )
    data['A_IOBJ'] = 13
    f.storeObject( 15, 20, data, ch )
    f.tagCurrentHead( 'Tag A1'+suf, "My tag" )
    data['A_IOBJ'] = 14
    f.storeObject( 5, 15, data, ch )
    f.tagCurrentHead( 'Tag B1'+suf, "My tag" )
    f.createTagRelation( 'Test'+suf, 'Tag A1'+suf )
    f.createTagRelation( 'Prod'+suf, 'Tag B1'+suf )
    # -- MV2
    ch = 0
    folderSpec = cool.FolderSpecification( MULTI_VERSION, spec, payloadTable )
    f = db.createFolder( top + '/MV/mv2', folderSpec, '')
    data['A_IOBJ'] = 21
    f.storeObject( 0, 10, data, ch )
    data['A_IOBJ'] = 22
    f.storeObject( 0, 5, data, ch )
    data['A_IOBJ'] = 23
    f.storeObject( 15, 20, data, ch )
    f.tagCurrentHead( 'Tag A2'+suf, "My tag" )
    data['A_IOBJ'] = 24
    f.storeObject( 5, 15, data, ch )
    f.tagCurrentHead( 'Tag B2'+suf, "My tag" )
    f.createTagRelation( 'Test'+suf, 'Tag A2'+suf )
    f.createTagRelation( 'Prod'+suf, 'Tag B2'+suf )
    # -- MV3
    folderSpec = cool.FolderSpecification( MULTI_VERSION, spec, payloadTable )
    f = db.createFolder( top + '/MV/mv3', folderSpec, '' )
    ch = 0
    data['A_IOBJ'] = 31
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 32
    f.storeObject( 10, 20, data, ch, 'Tag C'+suf )
    data['A_IOBJ'] = 33
    f.storeObject( 20, 30, data, ch, 'Tag C'+suf )
    # -- MV4 -- only for vector tests
    if TEST_VECTOR and payloadTable_sav == VECTOR :
        folderSpec = cool.FolderSpecification( MULTI_VERSION, spec, payloadTable )
        f = db.createFolder( top + '/MV/mv4', folderSpec, '' )
        ch = 0
        v = cool.IRecordVector()
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3101
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3102
        v.push_back( dataPtr )
        f.storeObject( 0, cool.ValidityKeyMax, v, ch )

        v = cool.IRecordVector()
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3201
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3202
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3203
        v.push_back( dataPtr )
        data['A_IOBJ'] = 32
        f.storeObject( 10, 20, v, ch, 'Tag D'+suf )

        v = cool.IRecordVector()
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3301
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3302
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3303
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3304
        v.push_back( dataPtr )
        f.storeObject( 20, 30, v, ch, 'Tag D'+suf )
    # -- SV2
    folderSpec = cool.FolderSpecification( SINGLE_VERSION, spec )
    f = db.createFolder( top + '/SV/sv2', folderSpec, '' )
    ch = 0
    f.createChannel( 0, "ch 0", "desc 0" )
    data['A_IOBJ'] = 41
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 42
    f.storeObject( 5, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 43
    f.storeObject( 10, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 44
    f.storeObject( 15, cool.ValidityKeyMax, data, ch )
    ch = 1
    f.createChannel( 1, "ch 1", "desc 1" )
    data['A_IOBJ'] = 51
    f.storeObject( 0, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 52
    f.storeObject( 5, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 53
    f.storeObject( 10, cool.ValidityKeyMax, data, ch )
    data['A_IOBJ'] = 54
    f.storeObject( 15, cool.ValidityKeyMax, data, ch )
    # Cleanup
    del db
    endTime = time.gmtime()
    if VERBOSE: print 'DEBUG: fill sourceDb',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

class TestReplication( unittest.TestCase ):

    # first execution (drop and recreate db, or simply refresh it?)
    FIRST = True

    def shortDescription(self):
        return str(self)

    def initDatabases(self):
        if TestReplication.FIRST :
            TestReplication.FIRST = False
            recreateDatabase( sourceConnectString )
            fillDatabase( sourceConnectString, INLINE )
            fillDatabase( sourceConnectString, SEPARATE )
            fillDatabase( sourceConnectString, VECTOR )
            dropDatabase( targetConnectString, 'DEBUG: drop targetDb' )
        else:
            refreshDatabase( sourceConnectString, '\nDEBUG: refresh sourceDb' )
            fillDatabase( sourceConnectString, INLINE )
            fillDatabase( sourceConnectString, SEPARATE )
            fillDatabase( sourceConnectString, VECTOR )
            refreshDatabase( targetConnectString, 'DEBUG: refresh targetDb' )

    def runReplication(self):
        self.__runReplication()
        ###try:
        ###    self.__runReplication()
        ###except:
        ###    print "WARNING! Exception caught, will sleep 1s and retry"
        ###    time.sleep(1) # workaround for ORA-01466 (bug #87935)
        ###    self.__runReplication()
        
    def __runReplication(self):
        startTime = time.gmtime()
        ###if VERBOSE: print 'DEBUG: Enter runReplication at', time.strftime("%Y-%m-%d %H:%M:%S UTC",startTime)
        if targetConnectString.lower().find("mysql") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep BEFORE replicating (mysql - see bug #23662)
	if targetConnectString.lower().find("oracle") >= 0 :
	    if VERBOSE: print 'DEBUG: sleep 1s'
	    time.sleep(1) # Sleep for ORA-01466 (bug #87935)
        cmd = 'coolReplicateDB "%s" "%s"' % ( sourceConnectString,
                                              targetConnectString )
        #print '\n=========================================================='
        #print 'Running', cmd
        cmdPipe = os.popen( cmd )
        #for line in cmdPipe:
        #    print line.rstrip()
        output = cmdPipe.readlines()
        if cmdPipe.close() is not None:
            for line in output: print line.rstrip()
            raise Exception('Error running replication')
        #else:                                       # VERBOSE!!!
        #    print '\n=============================' # VERBOSE!!!
        #    print 'coolReplicateDB...'              # VERBOSE!!!
        #    for line in output: print line.rstrip() # VERBOSE!!!
        #    print 'coolReplicateDB... DONE'         # VERBOSE!!!
        #    print '-----------------------------\n' # VERBOSE!!!
        if targetConnectString.lower().find("mysql") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep AFTER replicating (mysql - see bug #23662)
        elif targetConnectString.lower().find("oracle") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep AFTER replicating (ORA-01466)
        endTime = time.gmtime()
        ###if VERBOSE: print 'DEBUG: Exit runReplication at', time.strftime("%Y-%m-%d %H:%M:%S UTC",endTime)
        if VERBOSE: print 'DEBUG: runReplication completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def setUp(self):
        self.app = cool.Application()
        self.dbSvc = self.app.databaseService()
        self.outLvl = self.app.outputLevel()
        self.initDatabases()
        self.runReplication()

    def tearDown(self):
        pass

    #------------------------------------------------------------------------

    def test_group1(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- RO tests --
        self.subtest_01_nodes(SEPARATE)
        self.subtest_01_nodes(INLINE)
        self.subtest_01_nodes(VECTOR)
        self.subtest_02_sv1(SEPARATE)
        self.subtest_02_sv1(INLINE)
        self.subtest_02_sv1(VECTOR)
        self.subtest_03_mv1(SEPARATE)
        self.subtest_03_mv1(INLINE)
        self.subtest_03_mv1(VECTOR)
        self.subtest_04_mv2(SEPARATE)
        self.subtest_04_mv2(INLINE)
        self.subtest_04_mv2(VECTOR)
        self.subtest_04a_mv4(VECTOR)
        self.subtest_05_tagRelations(SEPARATE)
        self.subtest_05_tagRelations(INLINE)
        self.subtest_05_tagRelations(VECTOR)
        self.subtest_06_userTag(SEPARATE)
        self.subtest_06_userTag(INLINE)
        self.subtest_06_userTag(VECTOR)
        self.subtest_07_channels(SEPARATE)
        self.subtest_07_channels(INLINE)
        self.subtest_07_channels(VECTOR)
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_08_additional_nodes_PREPARE(SEPARATE)
        self.subtest_08_additional_nodes_PREPARE(INLINE)
        self.subtest_08_additional_nodes_PREPARE(VECTOR)
        self.subtest_09_additional_objects_sv_PREPARE(SEPARATE)
        self.subtest_09_additional_objects_sv_PREPARE(INLINE)
        self.subtest_09_additional_objects_sv_PREPARE(VECTOR)
        self.subtest_10_additional_objects_mv_PREPARE(SEPARATE)
        self.subtest_10_additional_objects_mv_PREPARE(INLINE)
        self.subtest_10_additional_objects_mv_PREPARE(VECTOR)
        self.subtest_11_additional_channels_PREPARE(SEPARATE)
        self.subtest_11_additional_channels_PREPARE(INLINE)
        self.subtest_11_additional_channels_PREPARE(VECTOR)
        self.subtest_13_node_description_change_PREPARE(SEPARATE)
        self.subtest_13_node_description_change_PREPARE(INLINE)
        self.subtest_13_node_description_change_PREPARE(VECTOR)
        self.subtest_17_deleted_user_tag_PREPARE(SEPARATE)
        self.subtest_17_deleted_user_tag_PREPARE(INLINE)
        self.subtest_17_deleted_user_tag_PREPARE(VECTOR)
        last_rep1 = self.subtest_25_lastUpdate_PREPARE(SEPARATE)
        last_rep2 = self.subtest_25_lastUpdate_PREPARE(INLINE)
        last_rep3 = self.subtest_25_lastUpdate_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_08_additional_nodes_RUN(SEPARATE)
        self.subtest_08_additional_nodes_RUN(INLINE)
        self.subtest_08_additional_nodes_RUN(VECTOR)
        self.subtest_09_additional_objects_sv_RUN(SEPARATE)
        self.subtest_09_additional_objects_sv_RUN(INLINE)
        self.subtest_09_additional_objects_sv_RUN(VECTOR)
        self.subtest_10_additional_objects_mv_RUN(SEPARATE)
        self.subtest_10_additional_objects_mv_RUN(INLINE)
        self.subtest_10_additional_objects_mv_RUN(VECTOR)
        self.subtest_11_additional_channels_RUN(SEPARATE)
        self.subtest_11_additional_channels_RUN(INLINE)
        self.subtest_11_additional_channels_RUN(VECTOR)
        self.subtest_13_node_description_change_RUN(SEPARATE)
        self.subtest_13_node_description_change_RUN(INLINE)
        self.subtest_13_node_description_change_RUN(VECTOR)
        self.subtest_17_deleted_user_tag_RUN(SEPARATE)
        self.subtest_17_deleted_user_tag_RUN(INLINE)
        self.subtest_17_deleted_user_tag_RUN(VECTOR)
        self.subtest_25_lastUpdate_RUN(SEPARATE,last_rep1)
        self.subtest_25_lastUpdate_RUN(INLINE,last_rep2)
        self.subtest_25_lastUpdate_RUN(VECTOR,last_rep3)

    def test_group2(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_10a_additional_objects_mv_PREPARE(VECTOR) # mv4
        self.subtest_12_additional_tags_PREPARE(SEPARATE) # mv1
        self.subtest_12_additional_tags_PREPARE(INLINE) # mv1
        self.subtest_12_additional_tags_PREPARE(VECTOR) # mv1
        self.subtest_18_deleted_folder_PREPARE(SEPARATE) # mv3
        self.subtest_18_deleted_folder_PREPARE(INLINE) # mv3
        self.subtest_18_deleted_folder_PREPARE(VECTOR) # mv3
        self.subtest_33_renameAndExtendPayloadSpec_PREPARE(SEPARATE) # sv1
        self.subtest_33_renameAndExtendPayloadSpec_PREPARE(INLINE) # sv1
        self.subtest_33_renameAndExtendPayloadSpec_PREPARE(VECTOR) # sv1
        fDescNew1,fsDescNew1=self.subtest_35_setTagDesc_PREPARE(SEPARATE) # mv2
        fDescNew2,fsDescNew2=self.subtest_35_setTagDesc_PREPARE(INLINE) # mv2
        fDescNew3,fsDescNew3=self.subtest_35_setTagDesc_PREPARE(VECTOR) # mv2
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_10a_additional_objects_mv_RUN(VECTOR) # mv4
        self.subtest_12_additional_tags_RUN(SEPARATE) # mv1
        self.subtest_12_additional_tags_RUN(INLINE) # mv1
        self.subtest_12_additional_tags_RUN(VECTOR) # mv1
        self.subtest_18_deleted_folder_RUN(SEPARATE) # mv3
        self.subtest_18_deleted_folder_RUN(INLINE) # mv3
        self.subtest_18_deleted_folder_RUN(VECTOR) # mv3
        self.subtest_33_renameAndExtendPayloadSpec_RUN(SEPARATE) # sv1
        self.subtest_33_renameAndExtendPayloadSpec_RUN(INLINE) # sv1
        self.subtest_33_renameAndExtendPayloadSpec_RUN(VECTOR) # sv1
        self.subtest_35_setTagDesc_RUN(SEPARATE,fDescNew1,fsDescNew1) # mv2
        self.subtest_35_setTagDesc_RUN(INLINE,fDescNew2,fsDescNew2) # mv2
        self.subtest_35_setTagDesc_RUN(VECTOR,fDescNew3,fsDescNew3) # mv2

    def test_group3(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_14_node_description_change_update_bug_PREPARE(SEPARATE)
        self.subtest_14_node_description_change_update_bug_PREPARE(INLINE)
        self.subtest_14_node_description_change_update_bug_PREPARE(VECTOR)
        self.subtest_15_deleted_tag_PREPARE(SEPARATE)
        self.subtest_15_deleted_tag_PREPARE(INLINE)
        self.subtest_15_deleted_tag_PREPARE(VECTOR)
        self.subtest_16_deleted_tag_relation_PREPARE(SEPARATE)
        self.subtest_16_deleted_tag_relation_PREPARE(INLINE)
        self.subtest_16_deleted_tag_relation_PREPARE(VECTOR)
        self.subtest_29_renamePayload_PREPARE(SEPARATE)
        self.subtest_29_renamePayload_PREPARE(INLINE)
        self.subtest_29_renamePayload_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_14_node_description_change_update_bug_RUN(SEPARATE)
        self.subtest_14_node_description_change_update_bug_RUN(INLINE)
        self.subtest_14_node_description_change_update_bug_RUN(VECTOR)
        self.subtest_15_deleted_tag_RUN(SEPARATE)
        self.subtest_15_deleted_tag_RUN(INLINE)
        self.subtest_15_deleted_tag_RUN(VECTOR)
        self.subtest_16_deleted_tag_relation_RUN(SEPARATE)
        self.subtest_16_deleted_tag_relation_RUN(INLINE)
        self.subtest_16_deleted_tag_relation_RUN(VECTOR)
        self.subtest_29_renamePayload_RUN(SEPARATE)
        self.subtest_29_renamePayload_RUN(INLINE)
        self.subtest_29_renamePayload_RUN(VECTOR)

    def test_group4(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_19_deleted_folderset_PREPARE(SEPARATE)
        self.subtest_19_deleted_folderset_PREPARE(INLINE)
        self.subtest_19_deleted_folderset_PREPARE(VECTOR)
        self.subtest_20_deleted_and_recreated_folder_PREPARE(SEPARATE)
        self.subtest_20_deleted_and_recreated_folder_PREPARE(INLINE)
        self.subtest_20_deleted_and_recreated_folder_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_19_deleted_folderset_RUN(SEPARATE)
        self.subtest_19_deleted_folderset_RUN(INLINE)
        self.subtest_19_deleted_folderset_RUN(VECTOR)
        self.subtest_20_deleted_and_recreated_folder_RUN(SEPARATE)
        self.subtest_20_deleted_and_recreated_folder_RUN(INLINE)
        self.subtest_20_deleted_and_recreated_folder_RUN(VECTOR)

    def test_group5(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_21_deleted_and_recreated_folderset_PREPARE(SEPARATE)
        self.subtest_21_deleted_and_recreated_folderset_PREPARE(INLINE)
        self.subtest_21_deleted_and_recreated_folderset_PREPARE(VECTOR)
        self.subtest_30_renamePayload_withNewIov_PREPARE(SEPARATE)
        self.subtest_30_renamePayload_withNewIov_PREPARE(INLINE)
        self.subtest_30_renamePayload_withNewIov_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_21_deleted_and_recreated_folderset_RUN(SEPARATE)
        self.subtest_21_deleted_and_recreated_folderset_RUN(INLINE)
        self.subtest_21_deleted_and_recreated_folderset_RUN(VECTOR)
        self.subtest_30_renamePayload_withNewIov_RUN(SEPARATE)
        self.subtest_30_renamePayload_withNewIov_RUN(INLINE)
        self.subtest_30_renamePayload_withNewIov_RUN(VECTOR)

    def test_group6(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_22_deleted_and_recreated_tag_PREPARE(SEPARATE)
        self.subtest_22_deleted_and_recreated_tag_PREPARE(INLINE)
        self.subtest_22_deleted_and_recreated_tag_PREPARE(VECTOR)
        self.subtest_24_deleted_and_recreated_user_tag_PREPARE(SEPARATE)
        self.subtest_24_deleted_and_recreated_user_tag_PREPARE(INLINE)
        self.subtest_24_deleted_and_recreated_user_tag_PREPARE(VECTOR)
        data1 = self.subtest_26_bug_24999_PREPARE(SEPARATE)
        data2 = self.subtest_26_bug_24999_PREPARE(INLINE)
        data3 = self.subtest_26_bug_24999_PREPARE(VECTOR)
        self.subtest_31_extendPayloadSpecification_PREPARE(SEPARATE)
        self.subtest_31_extendPayloadSpecification_PREPARE(INLINE)
        self.subtest_31_extendPayloadSpecification_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_22_deleted_and_recreated_tag_RUN(SEPARATE)
        self.subtest_22_deleted_and_recreated_tag_RUN(INLINE)
        self.subtest_22_deleted_and_recreated_tag_RUN(VECTOR)
        self.subtest_24_deleted_and_recreated_user_tag_RUN(SEPARATE)
        self.subtest_24_deleted_and_recreated_user_tag_RUN(INLINE)
        self.subtest_24_deleted_and_recreated_user_tag_RUN(VECTOR)
        self.subtest_26_bug_24999_RUN_RW(SEPARATE,data1)
        self.subtest_26_bug_24999_RUN_RW(INLINE,data2) # (here was bug 54767)
        self.subtest_26_bug_24999_RUN_RW(VECTOR,data3) # (here was bug 54767)
        self.subtest_31_extendPayloadSpecification_RUN(SEPARATE)
        self.subtest_31_extendPayloadSpecification_RUN(INLINE)
        self.subtest_31_extendPayloadSpecification_RUN(VECTOR)
        # -- Run self contained RW tests (these recreate db from scratch) --
        self.subtest_27_bug_30578(SEPARATE)
        self.subtest_27_bug_30578(INLINE)
        self.subtest_27_bug_30578(VECTOR)
        self.subtest_28_bug_30578(SEPARATE)
        self.subtest_28_bug_30578(INLINE)
        self.subtest_28_bug_30578(VECTOR)

    def test_group7(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        self.subtest_23_deleted_and_recreated_tag_relation_PREPARE(SEPARATE)
        self.subtest_23_deleted_and_recreated_tag_relation_PREPARE(INLINE)
        self.subtest_23_deleted_and_recreated_tag_relation_PREPARE(VECTOR)
        self.subtest_32_extendPayloadSpecification_withNewIov_PREPARE(SEPARATE)
        self.subtest_32_extendPayloadSpecification_withNewIov_PREPARE(INLINE)
        self.subtest_32_extendPayloadSpecification_withNewIov_PREPARE(VECTOR)
        self.subtest_34_bug_32976_additional_nodes_and_tags_PREPARE(SEPARATE)
        self.subtest_34_bug_32976_additional_nodes_and_tags_PREPARE(INLINE)
        self.subtest_34_bug_32976_additional_nodes_and_tags_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_23_deleted_and_recreated_tag_relation_RUN(SEPARATE)
        self.subtest_23_deleted_and_recreated_tag_relation_RUN(INLINE)
        self.subtest_23_deleted_and_recreated_tag_relation_RUN(VECTOR)
        self.subtest_32_extendPayloadSpecification_withNewIov_RUN(SEPARATE)
        self.subtest_32_extendPayloadSpecification_withNewIov_RUN(INLINE)
        self.subtest_32_extendPayloadSpecification_withNewIov_RUN(VECTOR)
        self.subtest_34_bug_32976_additional_nodes_and_tags_RUN(SEPARATE)
        self.subtest_34_bug_32976_additional_nodes_and_tags_RUN(INLINE)
        self.subtest_34_bug_32976_additional_nodes_and_tags_RUN(VECTOR)

    def _testBug54767(self):
        # Performance optimization (task #10875)
        # Group tests to reduce number of recreate source and replicate target
        # -- Preparation for RW tests with no conflicts to each other --
        data1 = self.subtest_26_bug_24999_PREPARE(SEPARATE)
        data2 = self.subtest_26_bug_24999_PREPARE(INLINE)
        data3 = self.subtest_26_bug_24999_PREPARE(VECTOR)
        # -- Do a single additional replication here
        self.runReplication()
        # -- Run RO part of RW tests --
        self.subtest_26_bug_24999_RUN_RW(SEPARATE,data1)
        self.subtest_26_bug_24999_RUN_RW(INLINE,data2) # FAILS! bug 54767
        self.subtest_26_bug_24999_RUN_RW(VECTOR,data3) # FAILS! bug 54767

    #------------------------------------------------------------------------

    def subtest_01_nodes(self,payloadTable,main=True):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.assert_( target.existsFolderSet( '/' ) )
        self.assert_( target.existsFolderSet( top ) )
        self.assert_( target.existsFolderSet( top + '/SV' ) )
        self.assert_( target.existsFolderSet( top + '/MV' ) )
        self.assert_( target.existsFolder( top + '/SV/sv1' ) )
        self.assert_( target.existsFolder( top + '/SV/sv2' ) )
        self.assert_( target.existsFolder( top + '/MV/mv1' ) )
        self.assert_( target.existsFolder( top + '/MV/mv2' ) )
        self.assert_( target.existsFolder( top + '/MV/mv3' ) )
        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_01',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_02_sv1(self,payloadTable,main=True):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['A_IOBJ'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_02',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_03_mv1(self,payloadTable,main=True):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        # check HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 14, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check A1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A1'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 11, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check B1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag B1'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 14, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_03',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_04_mv2(self,payloadTable,main=True):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv2' )
        # check HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 22, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 24, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 23, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check A2
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A2'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 22, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 21, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 23, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check B2
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag B2'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 22, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 24, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 23, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_04',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_04a_mv4(self,payloadTable,main=True):
        if not TEST_VECTOR:
            return
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv4' )
        # check HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3101, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3102, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 20, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3201, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3202, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3203, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 20, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 30, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3301, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3302, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3303, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3304, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 30, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 30, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3101, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3102, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 30, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )

        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_04a',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_05_tagRelations(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f1 = target.getFolder( top + '/MV/mv1' )
        objs = f1.browseObjects( cool.ValidityKeyMin,
                                 cool.ValidityKeyMax,
                                 cool.ChannelSelection.all(),
                                 f1.resolveTag( 'Test'+suf ) )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 11, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        f2 = target.getFolder( top + '/MV/mv2' )
        objs = f2.browseObjects( cool.ValidityKeyMin,
                                 cool.ValidityKeyMax,
                                 cool.ChannelSelection.all(),
                                 f2.resolveTag( 'Test'+suf ) )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 22, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 21, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 23, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        objs = f1.browseObjects( cool.ValidityKeyMin,
                                 cool.ValidityKeyMax,
                                 cool.ChannelSelection.all(),
                                 f1.resolveTag( 'Prod'+suf ) )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 14, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        objs = f2.browseObjects( cool.ValidityKeyMin,
                                 cool.ValidityKeyMax,
                                 cool.ChannelSelection.all(),
                                 f2.resolveTag( 'Prod'+suf ) )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 22, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 24, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 23, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_05',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_06_userTag(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv3' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag C'+suf )
        self.assertEqual( 2, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 32, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 33, obj.payload()['A_IOBJ'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 30, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_06',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_07_channels(self,payloadTable,main=True):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv2' )
        self.assertEqual( "ch 0", f.channelName( 0 ) )
        self.assertEqual( "desc 0", f.channelDescription( 0 ) )
        self.assertEqual( "ch 1", f.channelName( 1 ) )
        self.assertEqual( "desc 1", f.channelDescription( 1 ) )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection( f.channelId("ch 0") ) )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 41, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 42, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 43, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 44, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection( f.channelId("ch 1") ) )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 51, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 52, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 53, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 54, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE and main: print 'DEBUG: subtest_07',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_08_additional_nodes_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        self.subtest_01_nodes(payloadTable,False)
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        self.assert_( not source.existsFolder( top + '/SV/NEW/new_sv' ) )
        # add nodes and objects
        source.createFolderSet( top + '/SV/NEW' )
        spec = defaultSpec()
        folderSpec = cool.FolderSpecification( SINGLE_VERSION, spec )
        f = source.createFolder( top + '/SV/NEW/new_sv', folderSpec, '' )
        if payloadTable == SEPARATE :
            if TEST_VECTOR:
                self.assertEqual( 27, f.id() )
            else:
                self.assertEqual( 26, f.id() )
        elif payloadTable == VECTOR:
            if TEST_VECTOR:
                self.assertEqual( 31, f.id() )
            else:
                self.assertEqual( 30, f.id() )
        else:
            if TEST_VECTOR:
                self.assertEqual( 29, f.id() )
            else:
                self.assertEqual( 28, f.id() )
        ch = 0
        data = cool.Record( spec )
        data['A_IOBJ'] = 101
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        data['A_IOBJ'] = 102
        f.storeObject( 10, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_08_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_08_additional_nodes_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        self.subtest_01_nodes(payloadTable,False)
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.assert_( target.existsFolderSet( top + '/SV/NEW' ) )
        self.assert_( target.existsFolder( top + '/SV/NEW/new_sv' ) )
        f = target.getFolder( top + '/SV/NEW/new_sv' )
        if payloadTable == SEPARATE:
            if TEST_VECTOR:
                self.assertEqual( 27, f.id() )
            else:
                self.assertEqual( 26, f.id() )
        elif payloadTable == VECTOR:
            if TEST_VECTOR:
                self.assertEqual( 31, f.id() )
            else:
                self.assertEqual( 30, f.id() )
        else:
            if TEST_VECTOR:
                self.assertEqual( 29, f.id() )
            else:
                self.assertEqual( 28, f.id() )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 2, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 101, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 102, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_08',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_09_additional_objects_sv_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        self.subtest_02_sv1(payloadTable,False)
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 201
        ch = 0
        f.storeObject( 25, cool.ValidityKeyMax, data, ch )
        data['A_IOBJ'] = 202
        f.storeObject( 30, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_09_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_09_additional_objects_sv_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 6, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['A_IOBJ'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 25, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 201, obj.payload()['A_IOBJ'] )
        self.assertEqual( 25, obj.since() )
        self.assertEqual( 30, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 202, obj.payload()['A_IOBJ'] )
        self.assertEqual( 30, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_09',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_10_additional_objects_mv_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        self.subtest_03_mv1(payloadTable,False)
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv1' )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 301
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_10_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_10a_additional_objects_mv_PREPARE(self,payloadTable):
        if not TEST_VECTOR:
            return
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        self.subtest_03_mv1(payloadTable,False)
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv4' )
        spec = defaultSpec()
        v = cool.IRecordVector()
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3401
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3402
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3403
        v.push_back( dataPtr )
        dataPtr = cool.PyCool.Helpers.IRecordPtr( spec )
        dataPtr.get()['A_IOBJ'] = 3404
        v.push_back( dataPtr )
        ch = 0
        f.storeObject( 30, 40, v, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_10_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_10_additional_objects_mv_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN

        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 301, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_10',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_10a_additional_objects_mv_RUN(self,payloadTable):
        if not TEST_VECTOR:
            return
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN

        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv4' )
        # check HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 5, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3101, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3102, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 20, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3201, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3202, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3203, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 20, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 30, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3301, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3302, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3303, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3304, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 30, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 30, obj.since() )
        self.assertEqual( 40, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3401, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3402, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3403, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3404, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 30, obj.since() )
        self.assertEqual( 40, obj.until() )

        obj = getNext( objs )
        self.assertEqual( 40, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        pld = obj.payloadIterator()
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3101, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( True, pld.goToNext() )
        self.assertEqual( 3102, pld.currentRef()['A_IOBJ'] )
        self.assertEqual( False, pld.goToNext() )
        self.assertEqual( 40, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )

        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_10',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_11_additional_channels_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv2' )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 401
        f.createChannel( 2, "ch 2", "desc 2" )
        f.storeObject( 0, cool.ValidityKeyMax, data, 2 )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_11_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_11_additional_channels_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        self.subtest_07_channels(payloadTable,False)
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection( f.channelId( "ch 2" ) ) )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 401, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_11',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_12_additional_tags_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv1' )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 501
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        f.tagCurrentHead( 'Tag C1'+suf, "new tag" )
        data['A_IOBJ'] = 502
        f.storeObject( 10, cool.ValidityKeyMax, data, 0, 'User tag C'+suf )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_12_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_12_additional_tags_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        # check HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 2, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 501, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 502, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        # check A1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A1'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 11, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check B1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag B1'+suf )
        self.assertEqual( 3, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 12, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 5, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 14, obj.payload()['A_IOBJ'] )
        self.assertEqual( 5, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 13, obj.payload()['A_IOBJ'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        # check C1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag C1'+suf )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 501, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        # check User tag C
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'User tag C'+suf )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 502, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_12',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_13_node_description_change_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolderSet( top + '/SV' )
        f.setDescription( 'new SV desc' )
        f = source.getFolder( top + '/MV/mv1' )
        f.setDescription( 'new mv1 desc' )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_13_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_13_node_description_change_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolderSet( top + '/SV' )
        self.assertEqual( 'new SV desc', f.description() )
        f = target.getFolder( top + '/MV/mv1' )
        self.assertEqual( 'new mv1 desc', f.description() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_13',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_14_node_description_change_update_bug_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests that the description update does not update the (wrong)
        # source table names.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolderSet( top + '/SV' )
        f.setDescription( 'new SV desc' )
        f = source.getFolder( top + '/MV/mv1' )
        f.setDescription( 'new mv1 desc' )
        # add on object to the folder -- this forces an update to the folder
        # and fails if the wrong folder name has been replicated
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 501
        f.storeObject( 0, cool.ValidityKeyMax, data, 0 )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_14_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_14_node_description_change_update_bug_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolderSet( top + '/SV' )
        self.assertEqual( 'new SV desc', f.description() )
        f = target.getFolder( top + '/MV/mv1' )
        self.assertEqual( 'new mv1 desc', f.description() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_14',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_15_deleted_tag_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assert_( objs.size() > 0 )
        f.deleteTag( 'Tag A1'+suf )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assertEqual( 0, objs.size() )
        ###source.closeDatabase()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assert_( objs.size() > 0 )
        ###target.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_15_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_15_deleted_tag_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assertEqual( 0, objs.size() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_15',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_16_deleted_tag_relation_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv1' )
        self.assertEqual( 'Tag B1'+suf, f.resolveTag( 'Prod'+suf ) )
        f.deleteTagRelation( 'Prod'+suf )
        try:
            self.assertEqual( 'Tag B1'+suf, f.resolveTag( 'Prod'+suf ) )
            exceptionRaised = False
        except:
            exceptionRaised = True
        self.assert_( exceptionRaised )
        ###source.closeDatabase()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        self.assertEqual( 'Tag B1'+suf, f.resolveTag( 'Prod'+suf ) )
        ###target.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_16_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_16_deleted_tag_relation_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        try:
            self.assertEqual( 'Tag B1'+suf, f.resolveTag( 'Prod'+suf ) )
            exceptionRaised = False
        except:
            exceptionRaised = True
        self.assert_( exceptionRaised )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_16',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_17_deleted_user_tag_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv3' )
        if payloadTable == SEPARATE:
            self.assertEqual( 15, f.id() )
        elif payloadTable == VECTOR:
            self.assertEqual( 23, f.id() )
        else:
            self.assertEqual( 7, f.id() )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag C'+suf )
        self.assert_( objs.size() > 0 )
        f.deleteTag( 'Tag C'+suf )
        try:
            objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                    cool.ChannelSelection.all(), 'Tag C'+suf )
        except RuntimeError, e:
            expectedE = '(file "", line 0) Tag \'Tag C'+suf+'\' not found '+\
                        'in node #'+str(f.id())+' (C++ exception)'
            formattedE = str(e)[0:len(expectedE)]
            self.assertEqual( expectedE, formattedE )
        ###source.closeDatabase()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv3' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag C'+suf )
        self.assert_( objs.size() > 0 )
        ###target.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_17_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_17_deleted_user_tag_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv3' )
        try:
            objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                    cool.ChannelSelection.all(), 'Tag C'+suf )
        except RuntimeError, e:
            expectedE = '(file "", line 0) Tag \'Tag C'+suf+'\' not found '+\
                        'in node #'+str(f.id())+' (C++ exception)'
            formattedE = str(e)[0:len(expectedE)]
            self.assertEqual( expectedE, formattedE )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_17',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_18_deleted_folder_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.dropNode( top + '/MV/mv3' )
        self.assert_( not source.existsFolder( top + '/MV/mv3' ) )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_18_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_18_deleted_folder_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.assert_( not target.existsFolder( top + '/MV/mv3' ) )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_18',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_19_deleted_folderset_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.dropNode( top + '/MV/mv1' )
        f = source.dropNode( top + '/MV/mv2' )
        f = source.dropNode( top + '/MV/mv3' )
        if payloadTable == VECTOR :
            f = source.dropNode( top + '/MV/mv4' )
        f = source.dropNode( top + '/MV' )
        self.assert_( not source.existsFolderSet( top + '/MV' ) )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_19_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_19_deleted_folderset_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.assert_( not target.existsFolderSet( top + '/MV' ) )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_19',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_20_deleted_and_recreated_folder_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.dropNode( top + '/SV/sv1' )
        self.assert_( not source.existsFolder( top + '/SV/sv1' ) )
        spec = defaultSpec()
        folderSpec = cool.FolderSpecification( SINGLE_VERSION, spec )
        f = source.createFolder( top + '/SV/sv1', folderSpec )
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 601
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_20_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_20_deleted_and_recreated_folder_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 601, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_20',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_21_deleted_and_recreated_folderset_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.dropNode( top + '/MV/mv1' )
        f = source.dropNode( top + '/MV/mv2' )
        f = source.dropNode( top + '/MV/mv3' )
        if payloadTable == VECTOR:
            f = source.dropNode( top + '/MV/mv4' )
        f = source.dropNode( top + '/MV' )
        self.assert_( not source.existsFolderSet( top + '/MV' ) )
        f = source.createFolderSet( top + '/MV' )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_21_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_21_deleted_and_recreated_folderset_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.assert_( target.existsFolderSet( top + '/MV' ) )
        self.assert_( not target.existsFolder( top + '/MV/mv1' ) )
        self.assert_( not target.existsFolder( top + '/MV/mv2' ) )
        self.assert_( not target.existsFolder( top + '/MV/mv3' ) )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_21',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_22_deleted_and_recreated_tag_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv1' )
        f.deleteTag( 'Tag A1'+suf )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assertEqual( 0, objs.size() )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 701
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        f.tagCurrentHead( 'Tag A1'+suf, "My tag" )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_22_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_22_deleted_and_recreated_tag_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag A1'+suf )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 701, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_22',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_23_deleted_and_recreated_tag_relation_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        fs = source.getFolderSet( top + '/MV' )
        f = source.getFolder( top + '/MV/mv1' )
        f.deleteTagRelation( 'Prod'+suf )
        try:
            f.resolveTag( 'Prod'+suf )
            exceptionRaised = False
        except RuntimeError, e:
            exceptionRaised = True
        self.assert_( exceptionRaised )
        expectedE = '(file "", line 0) No child tag can be found ' + \
                    'in node #'+ str(f.id())+ \
                    ' related to tag #2 in parent node #'+str(fs.id())+' ' + \
                    '(C++ exception)'
        formattedE = str(e)[0:len(expectedE)]
        self.assertEqual( expectedE, formattedE )
        f.createTagRelation( 'Prod'+suf, 'Tag A1'+suf )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_23_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_23_deleted_and_recreated_tag_relation_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv1' )
        self.assertEqual( 'Tag A1'+suf, f.resolveTag( 'Prod'+suf ) )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_23',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_24_deleted_and_recreated_user_tag_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv3' )
        f.deleteTag( 'Tag C'+suf )
        try:
            objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                    cool.ChannelSelection.all(), 'Tag C'+suf )
        except RuntimeError, e:
            expectedE = '(file "", line 0) Tag \'Tag C'+suf+'\' not found ' + \
                        'in node #'+str(f.id())+' (C++ exception)'
            formattedE = str(e)[0:len(expectedE)]
            self.assertEqual( expectedE, formattedE )
        spec = defaultSpec()
        data = cool.Record( spec )
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 801
        f.storeObject( 0, cool.ValidityKeyMax, data, 0, 'Tag C'+suf )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_24_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_24_deleted_and_recreated_user_tag_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv3' )
        objs = f.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                cool.ChannelSelection.all(), 'Tag C'+suf )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 801, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_24',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_25_lastUpdate_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        last_rep = target.databaseAttributes()['LAST_REPLICATION']
        self.assertEqual( 33, len(last_rep) )
        ###target.closeDatabase()
        return last_rep
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_25_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_25_lastUpdate_RUN(self,payloadTable,last_rep):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        new_last_rep = target.databaseAttributes()['LAST_REPLICATION']
        self.assert_( new_last_rep > last_rep )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_25',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_26_bug_24999_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        folderSpec = cool.FolderSpecification( MULTI_VERSION, defaultSpec() )
        f = source.createFolder( top + '/MV/mv5', folderSpec, '' )
        data = cool.Record( defaultSpec() )
        data['A_IOBJ'] = 1
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_26_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'
        return data

    def subtest_26_bug_24999_RUN_RW(self,payloadTable, data):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/MV/mv5' )
        data['A_IOBJ'] = 2
        ch = 0
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        self.runReplication()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/MV/mv5' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 1, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        ###target.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_26',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_27_bug_30578(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Bug #30578 is about folder deleting before a db is ever replicated.
        # This leads to the problem of different node_id values on source and
        # target db, which breaks tags.
        # We immediately replicate in setUp which masks the bug we're trying
        # to expose here, therefore we have to start from scratch, 'overriding'
        # the setUp step by recreating the database.
        self.initDatabases()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        source.dropNode( top + '/MV/mv1' )
        source.closeDatabase()
        self.runReplication()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        # Simply reuse the test for /MV/mv2 (which has a higher node_id than
        # the folder /MV/mv1 we deleted) to check the tags. If the node_ids are
        # of sync, this test will fail with the error:
        # RuntimeError: (file "", line 0) Tag 'Tag A2' not found
        # in node #4 (C++ exception)
        # Since /MV/mv2 has node_id 4 in the target but node_id 5 in the
        # source, tag 'Tag A2' now refers to the wrong folder, namely
        # '/MV/mv3' (node_id 5 on the target) instead of '/MV/mv2'
        self.subtest_04_mv2(payloadTable,False)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_27',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_28_bug_30578(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Same as subtest_27_bug_30578 except we delete more nodes
        self.initDatabases()
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        source.dropNode( top + '/SV/sv1' )
        source.dropNode( top + '/SV/sv2' )
        source.dropNode( top + '/SV' )
        source.dropNode( top + '/MV/mv1' )
        source.closeDatabase()
        self.runReplication()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        self.subtest_04_mv2(payloadTable)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_28',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_29_renamePayload_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests replication of a renamed payload, task #6111.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )
        f.renamePayload( 'A_IOBJ', 'renamed' )
        if targetConnectString.lower().find("oracle") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep after changing schema (ORA-01466)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_29_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_29_renamePayload_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['renamed'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['renamed'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['renamed'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_29',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_30_renamePayload_withNewIov_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests replication of a renamed payload, task #6111.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )
        f.renamePayload( 'A_IOBJ', 'renamed' )
        # add an IOV
        data = cool.Record( f.payloadSpecification() )
        data['renamed'] = 5
        f.storeObject( 25, cool.ValidityKeyMax, data, 0 )
        if targetConnectString.lower().find("oracle") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep after changing schema (ORA-01466)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_30_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_30_renamePayload_withNewIov_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 5, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['renamed'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['renamed'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['renamed'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 25, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 5, obj.payload()['renamed'] )
        self.assertEqual( 25, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_30',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_31_extendPayloadSpecification_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests replication of an extended payload, task #6111.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )

        spec = cool.RecordSpecification()
        spec.extend( 'newcol', cool.StorageType.Int32 )
        rec = cool.Record( spec )
        f.extendPayloadSpecification(rec)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_31_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_31_extendPayloadSpecification_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 4, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_31',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_32_extendPayloadSpecification_withNewIov_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests replication of an extended payload, task #6111.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )
        spec = cool.RecordSpecification()
        spec.extend( 'newcol', cool.StorageType.Int32 )
        rec = cool.Record( spec )
        f.extendPayloadSpecification(rec)
        # add an IOV
        data = cool.Record( f.payloadSpecification() )
        data['A_IOBJ'] = 5
        data['newcol'] = 6
        f.storeObject( 25, cool.ValidityKeyMax, data, 0 )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_32_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_32_extendPayloadSpecification_withNewIov_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 5, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 25, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 5, obj.payload()['A_IOBJ'] )
        self.assertEqual( 6, obj.payload()['newcol'] )
        self.assertEqual( 25, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_32',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_33_renameAndExtendPayloadSpec_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        # Tests replication of a renamed and extended payload, task #6111.
        # This test combines renaming and extending of a payload spec and
        # in addition adds a new IOV.
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        f = source.getFolder( top + '/SV/sv1' )
        # rename payload field
        f.renamePayload( 'A_IOBJ', 'renamed' )
        # extend payload spec
        spec = cool.RecordSpecification()
        spec.extend( 'newcol', cool.StorageType.Int32 )
        rec = cool.Record( spec )
        f.extendPayloadSpecification(rec)
        # add an IOV
        data = cool.Record( f.payloadSpecification() )
        data['renamed'] = 5
        data['newcol'] = 6
        f.storeObject( 25, cool.ValidityKeyMax, data, 0 )
        if targetConnectString.lower().find("oracle") >= 0 :
            if VERBOSE: print 'DEBUG: sleep 1s'
            time.sleep(1) # Sleep after changing schema (ORA-01466)
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_33_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_33_renameAndExtendPayloadSpec_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        f = target.getFolder( top + '/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEqual( 5, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 1, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 2, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( 15, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 3, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 15, obj.since() )
        self.assertEqual( 20, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 4, obj.payload()['renamed'] )
        self.assertEqual( 0, obj.payload()['newcol'] )
        self.assertEqual( 20, obj.since() )
        self.assertEqual( 25, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 5, obj.payload()['renamed'] )
        self.assertEqual( 6, obj.payload()['newcol'] )
        self.assertEqual( 25, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_33',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    # AV 2008--2-11 KEEP THIS TEST DISABLED!!!
    def _no_test_rollback_on_failure(self,payloadTable):
        # sas 2006-06-16: This test fails at the moment:
        #
        # Traceback (most recent call last):
        #   File "_test_Replication.py", line 914, in _test_rollback_on_failure
        #     self.assert_( not self.target.existsFolderSet( top + '/A' ) )
        # AssertionError
        #
        # but I'm not sure if it should pass or even *can* pass all the way.
        # For some reason the updated node table rows are committed even though
        # the transaction should have been rolled back (to be determined
        # if this is a problem with the transaction or the rollback).
        # However, even if we manage to roll back the update, if inside the
        # transaction we create new tables (as in __createNode, triggered by
        # certain replication actions) as far as I know these *cannot* be
        # rolled back by the transaction.
        # Therefore it might be better to admit defeat and try to make
        # rerunning of partial updates safe (which it is at the moment).
        # add changes to the source
        folderSpec = cool.FolderSpecification( SINGLE_VERSION, defaultSpec() )
        self.source.createFolderSet( top + '/A' )
        self.source.createFolder( top + '/A/a', folderSpec )
        self.source.createFolderSet( top + '/Z' )
        self.source.createFolder( top + '/Z/z', folderSpec )
        f = self.source.getFolder( top + '/SV/sv1' )
        spec = defaultSpec()
        data = spec.createAttributeList()
        data['A_STRING'] = 'TestData'
        data['A_IOBJ'] = 901
        f.storeObject( 25, cool.ValidityKeyMax, data )
        # create a conflict by dropping /SV/sv1 on the target,
        # making replication to this folder impossible
        self.target.dropNode( top + '/SV/sv1' )
        try:
            self.runReplication()
        except:
            pass
        # make sure the extra objects are not replicated (rollback)
        self.assert_( not self.target.existsFolderSet( top + '/A' ) )
        self.assert_( not self.target.existsFolder( top + '/A/a' ) )
        self.assert_( not self.target.existsFolderSet( top + '/z' ) )
        self.assert_( not self.target.existsFolder( top + '/Z/z' ) )

    #------------------------------------------------------------------------

    def subtest_34_bug_32976_additional_nodes_and_tags_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        # When a new MV folder is added to the source database, the replica
        # gets wrong values in the sequence table for node ids. This leads
        # to the wrong node id for the new table, which then breaks the fk
        # constraint between tag and node id..
        self.subtest_01_nodes(payloadTable,False)
        folderset_name = top + '/MV/NEW'
        folder_name = folderset_name+'/new_mv'
        tag_name = "ANewTag"
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        self.assert_( not source.existsFolder( folder_name ) )
        # add nodes and objects
        source.createFolderSet( folderset_name )
        spec = defaultSpec()
        folderSpec = cool.FolderSpecification( MULTI_VERSION, spec )
        f = source.createFolder( folder_name, folderSpec, '' )
        ch = 0
        data = cool.Record( spec )
        data['A_IOBJ'] = 101
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        data['A_IOBJ'] = 102
        f.storeObject( 10, cool.ValidityKeyMax, data, ch )
        f.tagCurrentHead(tag_name+suf)
        data['A_IOBJ'] = 103
        f.storeObject( 0, cool.ValidityKeyMax, data, ch )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_34_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    def subtest_34_bug_32976_additional_nodes_and_tags_RUN(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        self.subtest_01_nodes(payloadTable,False)
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        folderset_name = top + '/MV/NEW'
        folder_name = folderset_name+'/new_mv'
        tag_name = "ANewTag"
        self.assert_( target.existsFolderSet( folderset_name ) )
        self.assert_( target.existsFolder( folder_name ) )
        f = target.getFolder( folder_name )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                tag_name+suf )
        self.assertEqual( 2, objs.size() )
        obj = getNext( objs )
        self.assertEqual( 101, obj.payload()['A_IOBJ'] )
        self.assertEqual( 0, obj.since() )
        self.assertEqual( 10, obj.until() )
        obj = getNext( objs )
        self.assertEqual( 102, obj.payload()['A_IOBJ'] )
        self.assertEqual( 10, obj.since() )
        self.assertEqual( cool.ValidityKeyMax, obj.until() )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_34',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'

    #------------------------------------------------------------------------

    def subtest_35_setTagDesc_PREPARE(self,payloadTable):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        # Tests replication after changing a tag description (task #6394)
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        fSrc = source.getFolder( top + '/MV/mv2' )
        fDescOld = "My tag"
        self.assertEqual( fDescOld, fSrc.tagDescription( 'Tag B2'+suf ) )
        fsSrc = source.getFolderSet( top + '/MV' )
        fsDescOld = ""
        self.assertEqual( fsDescOld, fsSrc.tagDescription( 'Prod'+suf ) )
        ###source.closeDatabase()
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        fTgt = target.getFolder( top + '/MV/mv2' )
        self.assertEqual( fDescOld, fTgt.tagDescription( 'Tag B2'+suf ) )
        fsTgt = target.getFolderSet( top + '/MV' )
        self.assertEqual( fsDescOld, fsTgt.tagDescription( 'Prod'+suf ) )
        ###target.closeDatabase()
        fDescNew = "My tag with a new description"
        fsDescNew = "My parent tag with a new description"
        source = self.dbSvc.openDatabase( sourceConnectString, RW )
        fSrc = source.getFolder( top + '/MV/mv2' )
        fSrc.setTagDescription( 'Tag B2'+suf, fDescNew )
        self.assertEqual( fDescNew, fSrc.tagDescription( 'Tag B2'+suf ) )
        fsSrc = source.getFolderSet( top + '/MV' )
        fsSrc.setTagDescription( 'Prod'+suf, fsDescNew )
        self.assertEqual( fsDescNew, fsSrc.tagDescription( 'Prod'+suf ) )
        ###source.closeDatabase()
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_35_PREPARE',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'
        return fDescNew, fsDescNew

    def subtest_35_setTagDesc_RUN(self,payloadTable,fDescNew,fsDescNew):
        top = topFolderSet( payloadTable )
        suf = tagSuffix( payloadTable )
        startTime = time.gmtime()
        ###self.runReplication()
        # First PREPARE; then runReplication; then RUN
        target = self.dbSvc.openDatabase( targetConnectString, RO )
        fTgt = target.getFolder( top + '/MV/mv2' )
        self.assertEqual( fDescNew, fTgt.tagDescription( 'Tag B2'+suf ) )
        fsTgt = target.getFolderSet( top + '/MV' )
        self.assertEqual( fsDescNew, fsTgt.tagDescription( 'Prod'+suf ) )
        endTime = time.gmtime()
        if VERBOSE: print 'DEBUG: subtest_35',payloadTableDescription(payloadTable),'completed in', calendar.timegm(endTime) - calendar.timegm(startTime),'seconds'


#######################################################################
#######################################################################


sourceKey = "COOLTESTDB_SOURCE"
targetKey = "COOLTESTDB_TARGET"

if __name__ == '__main__':
    if sourceKey in os.environ and targetKey in os.environ:
        sourceConnectString = os.environ[sourceKey]
        targetConnectString = os.environ[targetKey]
    else:
        #print 'usage: %s %s' % (
        #           sys.argv[0],
        #           '<source connect string> <target connect string>' )
        #print '<connect string>: a COOL (RAL) compatible connect string, e.g.'
        #print ( '    "oracle://devdb10;schema=atlas_cool_sas;'
        #        'user=atlas_cool_sas;dbname=COOLTEST"' )
        #print 'or set env variables %s and %s'%( sourceKey, targetKey )
        print 'Usage: %s' % ( sys.argv[0] )
        print 'You must set env variables %s and %s'%( sourceKey, targetKey )
        sys.exit(-1)

    # Set VERBOSE mode only for specific backends
    ###if targetConnectString.lower().find("oracle") >= 0 : VERBOSE = True

    if len(sys.argv) == 2:
        unittest.main( testRunner =
                       unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )
    else:
        failures=False;
        suite = unittest.TestLoader().loadTestsFromTestCase(TestReplication)
        result = unittest.TextTestRunner(stream=sys.stdout,verbosity=2).run(suite)
        #if not result.wasSuccessful():
        #        failures=True;
        #PAYLOADTABLE = True
        #suite = unittest.TestLoader().loadTestsFromTestCase(TestReplication)
        #result = unittest.TextTestRunner(stream=sys.stdout,verbosity=2).run(suite)

        if not result.wasSuccessful() or failures:
            sys.exit(1)
