import unittest, sys, os, time
from PyCool import cool, coral
import traceback

connectString = None

class TestIFolder( unittest.TestCase ):
    """
    The purpose of this test class is to test the completeness of the wrapper
    class, *not* the functionality of the class itself. Every method of the
    COOL API class is called to make sure that it is wrapped.
    """

    rspec = None
    unittest.TestCase.shared_db = None

    def dummyPayload( self, index ):
        """Creates a dummy payload Record for a given index"""
        payload = cool.Record( self.rspec )
        payload["I"] = index
        payload["S"] = 'Object %d' % index
        payload["X"] = index / 1000.
        return payload


    def dummyPayloadNull( self ):
        """Creates a dummy payload Record with null fields"""
        payload = cool.Record( self.rspec )
        payload.field("I").setNull() # EQUIVALENT TO: payload["I"] = None
        payload["S"] = "NULL" # Avoid ""/NULL issues for this simple test!...
        payload.field("X").setNull() # EQUIVALENT TO: payload["X"] = None
        return payload


    def setUp(self):
        try:
            if self.rspec is None:
                self.rspec = cool.RecordSpecification()
                self.rspec.extend( "I", cool.StorageType.Int32 )
                self.rspec.extend( "S", cool.StorageType.String4k )
                self.rspec.extend( "X", cool.StorageType.Float )
                self.fspecSV = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.rspec )
                self.fspecMV = cool.FolderSpecification( cool.FolderVersioning.MULTI_VERSION, self.rspec )
            if unittest.TestCase.shared_db is None:
                dbSvc = cool.DatabaseSvcFactory.databaseService()
                dbSvc.dropDatabase(connectString)
                unittest.TestCase.shared_db = dbSvc.createDatabase(connectString)
            else:
                unittest.TestCase.shared_db.refreshDatabase()
            self.db = unittest.TestCase.shared_db
        except Exception, e:
            print e
            print "could not recreate the database"
            print "check your seal.opts and authentication.xml"
            sys.exit(-1)
        except:
            print "Unexpected error:", sys.exc_info()[0]
            print traceback.print_tb(sys.exc_info()[2])
            sys.exit(-1)


    def tearDown(self):
        #del self.db
        pass


    def test_payloadSpecification(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        spec = f.payloadSpecification()
        self.assertEquals( 3, spec.size() )


    def test_versioningMode(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assertEquals( cool.FolderVersioning.SINGLE_VERSION,
                           f.versioningMode() )


    def test_folderAttributes(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        attr = f.folderAttributes()
        self.assert_( 'FOLDER_IOVTABLENAME' in attr.keys() )


    def test_storeObject_findObject(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.setupStorageBuffer()
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.flushStorageBuffer()
        obj = f.findObject( 1, 0 )
        self.assertEquals( self.dummyPayload( 0 ), obj.payload() )


    def test_browseObjects(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.setupStorageBuffer()
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.storeObject( 2, 4, self.dummyPayload( 0 ), 0 )
        f.flushStorageBuffer()
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 2, objs.size() )


    def test_listChannels(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 1 )
        f.storeObject( 0, 2, self.dummyPayload( 1 ), 2 )
        channels = f.listChannels()
        self.assertEquals( 2, len(channels) )


    def test_listChannelsWithNames(self):
        if not sys.platform.startswith("win"):
            f = self.db.createFolder( '/a', self.fspecSV )
            f.storeObject( 0, 2, self.dummyPayload( 0 ), 1 )
            f.storeObject( 0, 2, self.dummyPayload( 1 ), 2 )
            channels = f.listChannelsWithNames()
            self.assertEquals( 2, len(channels) )
        else:
            print '\nWARNING! Test disabled (bug #43416)'


    def test_tagCurrentHead(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a' )
        self.assert_( self.db.existsTag( 'tag a' ) )


    def test_tagHeadAsOfTag(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        obj = f.findObject( 1, 0 )
        time = obj.insertionTime()
        f.tagHeadAsOfDate( time, 'tag a' )
        self.assert_( self.db.existsTag( 'tag a' ) )


    def test_tag(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a' )
        self.assert_( self.db.existsTag( 'tag a' ) )


    def test_insertionTimeOfLastObjectInTag(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        obj = f.findObject( 1, 0 )
        objTime = str( obj.insertionTime() )
        f.tagCurrentHead( 'tag a' )
        tagTime = str( f.insertionTimeOfLastObjectInTag( 'tag a' ) )
        self.assertEquals( objTime, tagTime )


    def test_deleteTag(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a' )
        f.deleteTag( 'tag a' )
        self.assert_( not self.db.existsTag( 'tag a' ) )


    def test_fullPath(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assertEquals( '/a', f.fullPath() )


    def test_description(self):
        f = self.db.createFolder( '/a', self.fspecSV, 'desc' )
        self.assertEquals( 'desc', f.description() )


    def test_setDescription(self):
        f = self.db.createFolder( '/a', self.fspecSV, 'desc' )
        f.setDescription( 'new desc' )
        self.assertEquals( 'new desc', f.description() )


    def test_isLeaf(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assert_( f.isLeaf() )


    def test_isStored(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assert_( f.isStored() )


    def test_insertionTime(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assert_( len(str( f.insertionTime() )) > 0 )


    def test_id(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assertEquals( 1, f.id() )


    def test_parentId(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        self.assertEquals( 0, f.parentId() )


    def test_listTags(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a' )
        f.tagCurrentHead( 'tag b' )
        tags = f.listTags()
        self.assertEquals( 2, tags.size() )


    def test_tagInsertionTime(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a' )
        time = f.tagInsertionTime( 'tag a' )
        self.assert_( len( str( time ) ) > 0 )


    def test_tagDescription(self):
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.tagCurrentHead( 'tag a', 'desc' )
        self.assertEquals( 'desc', f.tagDescription( 'tag a' ) )


    def test_isHeadTag(self):
        self.assert_( cool.IFolder.isHeadTag( 'HEAD' ) )


    def test_headTag(self):
        """
        Tests that the headTag method is forward correctly.
        """
        self.assertEquals( 'HEAD', cool.IFolder.headTag() )


    def test_channel_above_maxint(self):
        """
        Tests that all IFolder methods accept channel ids above sys.maxint
        (the threshold, where python passes a long from literals instead
        of an int).
        """
        f = self.db.createFolder( '/a', self.fspecSV )
        channel = 2**31
        f.storeObject( 0, 2, self.dummyPayload( 0 ), channel )
        obj = f.findObject( 1, channel )
        self.assertEquals( obj.payload(), self.dummyPayload( 0 ) )
        objs = f.browseObjects( 0, 2, cool.ChannelSelection(channel) )
        self.assertEquals( 1, objs.size() )
        objs.goToNext()
        self.assertEquals( objs.currentRef().payload(), self.dummyPayload( 0 ) )


    def test_browseObjects_signatures(self):
        """
        IFolder.browseObjects has a lot of possible combinations of
        arguments due to overloading and default arguments. This test
        makes sure that all combinations are covered in the wrapper.
        """
        f = self.db.createFolder( '/a', self.fspecMV, 'desc' )
        channel = 0
        f.storeObject( 0, 2, self.dummyPayload( 0 ), channel )
        channel = 2**31
        f.storeObject( 0, 2, self.dummyPayload( 0 ), channel )
        f.tagCurrentHead( "A" )
        # signature 1)
        # findObjects [RENAMED AFTER COOL133!]
        # ( const ValidityKey& pointInTime,
        #   const ChannelSelection& channels,
        #   const std::string& tagName = "" )
        objs = f.findObjects( 1, cool.ChannelSelection.all() )
        self.assertEquals( 2, objs.size() )
        objs = f.findObjects( 1, cool.ChannelSelection.all(), "A" )
        self.assertEquals( 2, objs.size() )
        # signature 2)
        # browseObjects
        # ( const ValidityKey& since,
        #   const ValidityKey& until,
        #   const ChannelSelection& channels,
        #   const std::string& tagName = "" )
        objs = f.browseObjects( 0, 2, cool.ChannelSelection(0) )
        self.assertEquals( 1, objs.size() )
        objs = f.browseObjects( 0, 2, cool.ChannelSelection.all() )
        self.assertEquals( 2, objs.size() )
        objs = f.browseObjects( 0, 2, cool.ChannelSelection.all(), "A" )
        self.assertEquals( 2, objs.size() )
        # signature 2) with auto conversion from ChannelId
        objs = f.browseObjects( 0, 2, cool.ChannelSelection(2**31) )
        self.assertEquals( 1, objs.size() )
        objs = f.browseObjects( 0, 2, cool.ChannelSelection(2**31), "A" )
        self.assertEquals( 1, objs.size() )


    def test_listChannels_above_maxint(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.storeObject( 0, 2, self.dummyPayload( 1 ), 2**31 )
        f.storeObject( 0, 2, self.dummyPayload( 2 ), 2**31+1 )
        f.storeObject( 0, 2, self.dummyPayload( 3 ), 1 )
        channels = f.listChannels()
        self.assertEquals( 4, len(channels) )
        self.assertEquals( 0, channels[0] )
        self.assertEquals( 1, channels[1] )
        self.assertEquals( 2**31, channels[2] )
        self.assertEquals( 2**31+1, channels[3] )


    def test_bug28189(self):
        rspec = cool.RecordSpecification()
        rspec.extend( 'i', cool.StorageType.Int32 )
        data = cool.Record( rspec )
        fspecSV = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, rspec )
        f = self.db.createFolder( "/folder", fspecSV )
        data['i'] = 1
        f.storeObject( 0, 5, data, 0 )
        data['i'] = 2
        f.storeObject( 5, 10, data, 0 )
        f.setPrefetchAll( False )
        i1 = f.browseObjects( 0, 10, cool.ChannelSelection.all() )
        self.assertEquals( 2, i1.size() )
        # New bug #28787: segfault if the iterator is not closed
        i1.close()


    # DISABLED: this test fails with a segfault in COOL220...
    def test_bug28787(self):
        rspec = cool.RecordSpecification()
        # Use 'ii' instead of 'i' so that this is ok on COOL220
        rspec.extend( 'ii', cool.StorageType.Int32 )
        data = cool.Record( rspec )
        fspecSV = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, rspec )
        f = self.db.createFolder( "/folder", fspecSV )
        data['ii'] = 1
        f.storeObject( 0, 5, data, 0 )
        data['ii'] = 2
        f.storeObject( 5, 10, data, 0 )
        f.setPrefetchAll( False )
        i1 = f.browseObjects( 0, 10, cool.ChannelSelection.all() )
        self.assertEquals( 2, i1.size() )
        # New bug #28787: segfault if the iterator is not closed
        ###i1.close()


    # test payload queries (move to different test?)
    def test_fieldSelection_reference(self):
        if "COOL_PYCOOLTEST_SKIP_EXCEPTIONS" in os.environ: return # ROOT6
        # instantiate FieldSelections for all supported types
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Bool,
                                 cool.FieldSelection.EQ,
                                 True)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UChar,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int16,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt16,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int32,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt32,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt63,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int64,
                                 cool.FieldSelection.EQ,
                                 10)
        #fs = cool.FieldSelection("i",
        #                         cool.StorageType.UInt64,
        #                         cool.FieldSelection.EQ,
        #                         10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Float,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Double,
                                 cool.FieldSelection.EQ,
                                 10)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.String255,
                                 cool.FieldSelection.EQ,
                                 "test")
        fs = cool.FieldSelection("i",
                                 cool.StorageType.String4k,
                                 cool.FieldSelection.EQ,
                                 "test")
        fs = cool.FieldSelection("i",
                                 cool.StorageType.String64k,
                                 cool.FieldSelection.EQ,
                                 "test")
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Blob64k,
                                 cool.FieldSelection.EQ,
                                 cool.Blob64k(10))
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Blob16M,
                                 cool.FieldSelection.EQ,
                                 cool.Blob16M(10))

    # test payload queries (move to different test?)
    def test_fieldSelection_nullness(self):
        # instantiate FieldSelections for all supported types
        # using check for nullness constructor
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Bool,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UChar,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int16,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt16,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int32,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt32,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.UInt63,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Int64,
                                 cool.FieldSelection.IS_NULL)
        #fs = cool.FieldSelection("i",
        #                         cool.StorageType.UInt64,
        #                         cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Float,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Double,
                                 cool.FieldSelection.IS_NULL)
        # Strings are never NULL, only empty
        #fs = cool.FieldSelection("i",
        #                         cool.StorageType.String255,
        #                         cool.FieldSelection.IS_NULL)
        #fs = cool.FieldSelection("i",
        #                         cool.StorageType.String4k,
        #                         cool.FieldSelection.IS_NULL)
        #fs = cool.FieldSelection("i",
        #                         cool.StorageType.String64k,
        #                         cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Blob64k,
                                 cool.FieldSelection.IS_NULL)
        fs = cool.FieldSelection("i",
                                 cool.StorageType.Blob16M,
                                 cool.FieldSelection.IS_NULL)


    # instantiate CompositeSelections
    def test_compositeSelection(self):
        if "COOL_PYCOOLTEST_SKIP_EXCEPTIONS" in os.environ: return # ROOT6
        fs1 = cool.FieldSelection("i",
                                  cool.StorageType.Int32,
                                  cool.FieldSelection.EQ,
                                  10)
        fs2 = cool.FieldSelection("i",
                                  cool.StorageType.Int32,
                                  cool.FieldSelection.EQ,
                                  100)
        cs = cool.CompositeSelection(fs1,
                                     cool.CompositeSelection.OR,
                                     fs2)
        fs3 = cool.FieldSelection("i",
                                  cool.StorageType.Int32,
                                  cool.FieldSelection.EQ,
                                  1000)
        cs.connect( cool.CompositeSelection.AND, fs3 )


    # test browseObjects with RecordSelection for reference values
    def test_browseObjectsRecordSelection_reference(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.setupStorageBuffer()
        f.storeObject( 0, 2, self.dummyPayload( 0 ), 0 )
        f.storeObject( 2, 4, self.dummyPayload( 2 ), 0 )
        f.storeObject( 4, 6, self.dummyPayload( 4 ), 0 )
        f.flushStorageBuffer()
        if "COOL_PYCOOLTEST_SKIP_EXCEPTIONS" in os.environ: return # ROOT6
        # Attempt workaround for ROOT6 bug #103304 - use explicit template type
        #fs = cool.FieldSelection(int)("I",
        #                              cool.StorageType.Int32,
        #                              cool.FieldSelection.EQ,
        #                              2)
        fs = cool.FieldSelection("I",
                                 cool.StorageType.Int32,
                                 cool.FieldSelection.EQ,
                                 2) # fails for ROOT6 (bug #103304)
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0),
                                "",
                                fs )
        self.assertEquals( 1, objs.size() )
        objs.goToNext()
        self.assertEquals( objs.currentRef().payload(), self.dummyPayload( 2 ) )
        self.assertEquals( objs.currentRef().since(), 2 )
        self.assertEquals( objs.currentRef().until(), 4 )


    # test browseObjects with RecordSelection for nullness
    def test_browseObjectsRecordSelection_nullness(self):
        f = self.db.createFolder( '/a', self.fspecSV )
        f.setupStorageBuffer()
        nulPld = self.dummyPayloadNull()
        self.assert_( nulPld.field("I").isNull() )
        self.assert_( nulPld.field("X").isNull() )
        self.assert_( nulPld["I"] == None )
        self.assert_( nulPld["S"] == "NULL" )
        self.assert_( nulPld["X"] == None )
        dumPld = self.dummyPayload( 0 )
        self.assert_( not dumPld.field("I").isNull() )
        self.assert_( not dumPld.field("X").isNull() )
        self.assert_( dumPld["I"] != None )
        self.assert_( dumPld["X"] != None )
        f.storeObject( 0, 2, dumPld, 0 )
        f.storeObject( 2, 4, nulPld, 0 )
        f.flushStorageBuffer()
        fs = cool.FieldSelection("I",
                                 cool.StorageType.Int32,
                                 cool.FieldSelection.IS_NULL)
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0),
                                "",
                                fs )
        self.assertEquals( 1, objs.size() )
        objs.goToNext()
        self.assertEquals( objs.currentRef().payload(), self.dummyPayloadNull() )
        self.assertEquals( objs.currentRef().since(), 2 )
        self.assertEquals( objs.currentRef().until(), 4 )


#######################################################################


envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestIFolder' ) ):
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
    #print 'connect string', connectString
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

