import unittest, sys, os, time
from PyCool import cool

# simplify usage of these a bit...
SINGLE_VERSION = cool.FolderVersioning.SINGLE_VERSION
MULTI_VERSION  = cool.FolderVersioning.MULTI_VERSION

from PyCoolPayloader import PyCoolPayloader

class TestPyCoolPayloader( unittest.TestCase ):

    def setUp(self):
        self.payloader = PyCoolPayloader( connectString, recreateDb = True )

    def tearDown(self):
        self.payloader = None

    def test_validateFolder_SV_success(self):
        """
        Tests that validateFolder correctly validates a folder written
        by 'writeFolder' with a SINGLE_VERSION mode argument and default
        values for channel and objectsPerChannel counts.
        """
        self.payloader.writeFolder( '/a', mode = SINGLE_VERSION )
        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( res, 'Failed with message: %s' % msg )


    def test_validateFolder_SV_failure_no_folder(self):
        """
        Tests that validateFolder detects a missing folder.
        """
        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, "Folder '/a' does not exist" )


    def test_validateFolder_SV_failure_wrong_obj_count(self):
        """
        Tests that validateFolder detects a wrong object count.
        """
        # too few objects
        self.payloader.writeFolder( '/a',
                                    objectIds = range(9),
                                    channels = range(10),
                                    mode = SINGLE_VERSION )
        res, msg = self.payloader.validateFolder( '/a',
                                                  objectIds = range(10),
                                                  channels = range(10),
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, ( "Wrong object count in channel 0, "
                                  "was 9, expected >= 10" ) )

        # too many objects is OK
        self.payloader.writeFolder( '/b',
                                    objectIds = range(11),
                                    channels = range(10),
                                    mode = SINGLE_VERSION )
        res, msg = self.payloader.validateFolder( '/b',
                                                  objectIds = range(10),
                                                  channels = range(10),
                                                  mode = SINGLE_VERSION )
        #self.assert_( not res, 'Failure expected, received success: ' + msg )
        #self.assertEquals( msg, ( "Wrong object count in channel 0, "
        #                          "was 11, expected 10" ) )
        self.assert_( res, 'Failed with message: %s' % msg )


    def test_validateFolder_SV_failure_wrong_channel_count(self):
        """
        Tests that validateFolder detects a wrong channel count.
        """
        # too few channels
        self.payloader.writeFolder( '/a',
                                    objectIds = range(10),
                                    channels = range(9),
                                    mode = SINGLE_VERSION )
        res, msg = self.payloader.validateFolder( '/a',
                                                  objectIds = range(10),
                                                  channels = range(10),
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, "Channel id 9 does not exist" )

        # too many channels is OK
        self.payloader.writeFolder( '/b',
                                    objectIds = range(10),
                                    channels = range(11),
                                    mode = SINGLE_VERSION )
        res, msg = self.payloader.validateFolder( '/b',
                                                  objectIds = range(10),
                                                  channels = range(10),
                                                  mode = SINGLE_VERSION )
        #self.assertEquals( msg, "Wrong channel count, was 11, expected 10" )
        self.assert_( res, 'Failed with message: %s' % msg )


    def test_validateFolder_SV_failure_wrong_since(self):
        """
        Tests that validateFolder detects a wrong value for 'since'.
        """
        db = self.payloader.db
        nObjsPerChannel = 10
        nChannels = 10
        fspec = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.payloader.rspec )
        f = db.createFolder( '/a', fspec, '' )
        f.setupStorageBuffer()
        objIndex = 0
        for ch in range( nChannels ):
            for i in range( nObjsPerChannel ):
                f.storeObject( i+1, cool.ValidityKeyMax,
                               self.payloader.createPayload( i, ch ), ch )
                objIndex += 1
        f.flushStorageBuffer()

        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, 'Object (0,0) since was 1, expected 0' )



    def test_validateFolder_SV_failure_wrong_until(self):
        """
        Tests that validateFolder detects a wrong value for 'until'.
        """
        db = self.payloader.db
        nObjsPerChannel = 10
        nChannels = 10
        fspec = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.payloader.rspec )
        f = db.createFolder( '/a', fspec, '' )
        f.setupStorageBuffer()
        for ch in range( nChannels ):
            for i in range( nObjsPerChannel ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.payloader.createPayload( i, ch ), ch )
        f.flushStorageBuffer()

        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, 'Object (9,0) until was 9223372036854775807, expected 10' )



    def test_validateFolder_SV_failure_wrong_payload(self):
        """
        Tests that validateFolder detects a wrong payload.
        """
        db = self.payloader.db
        nObjsPerChannel = 10
        nChannels = 10
        fspec = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.payloader.rspec )
        f = db.createFolder( '/a', fspec, '' )
        f.setupStorageBuffer()
        for ch in range( nChannels ):
            for i in range( nObjsPerChannel ):
                payload = self.payloader.createPayload( i, ch )
                # modify payload at i == 4
                if i == 4: payload["I"] = 0
                f.storeObject( i, i+1,
                               payload, ch )
        f.flushStorageBuffer()

        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, ( 'Object (4,0) not equal, was '
                                  #'[I (Int32) : 0], [D (Double) : 4.0], '
                                  '[I (Int32) : 0], [D (Double) : 4], '
                                  '[S (String4k) : Object 00004, channel 00000], '
                                  'expected '
                                  #'[I (Int32) : 4000], [D (Double) : 4.0], '
                                  '[I (Int32) : 4000], [D (Double) : 4], '
                                  '[S (String4k) : Object 00004, channel 00000]' ) )

    def test_validateFolder_SV_wrong_description(self):
        """
        Tests that validateFolder detects a wrong folder description.
        """
        db = self.payloader.db
        fspec = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.payloader.rspec )
        f = db.createFolder( '/a', fspec, '' )
        res, msg = self.payloader.validateFolder( '/a',
                                                  description = 'expected desc',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, ( "Folder description was '', "
                                  "expected 'expected desc'" ) )



    def test_validateFolder_wrong_mode(self):
        """
        Tests that validateFolder detects a wrong versioning mode.
        """
        self.payloader.writeFolder( '/a', mode = MULTI_VERSION )

        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, ( "Folder versioning mode was '1', "
                                  "expected '0'" ) )



    def test_writeFolder_SV(self):
        """
        Tests that validateFolder correctly validates a folder written
        by 'writeFolder' with a SINGLE_VERSION mode argument and default
        values for channel and objectsPerChannel counts.
        """
        db = self.payloader.db
        self.assert_( not db.existsFolder( '/a' ) )

        self.payloader.writeFolder( '/a', mode = SINGLE_VERSION )

        res, msg = self.payloader.validateFolder( '/a',
                                                  mode = SINGLE_VERSION )
        self.assert_( res, 'Failed with message: %s' % msg )



    def test_writeFolder_SV_append(self):
        """
        Tests append mode for writeFolder (SV).
        """
        self.payloader.writeFolder( '/a' )
        self.payloader.writeFolder( '/a', append = True,
                                    objectIds = range(10,20) )



    def test_writeFolder_MV_append(self):
        """
        Tests append mode for writeFolder (MV).
        """
        self.payloader.writeFolder( '/a', mode = MULTI_VERSION )
        self.payloader.writeFolder( '/a', mode = MULTI_VERSION, append = True )



    def test_validateFolder_tag(self):
        """
        Tests validateFolder for a tag.
        """
        f = self.payloader.writeFolder( '/mv',
                                        mode = MULTI_VERSION,
                                        objectIds = range(5),
                                        channels = range(4) )
        f.tagCurrentHead( 'A', 'A desc' )

        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.payloader.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()

        res, msg = self.payloader.validateFolder( folderName = '/mv',
                                                  objectIds = range(5),
                                                  channels = range(4),
                                                  mode = MULTI_VERSION,
                                                  tag = 'A',
                                                  tagDescription = 'A desc' )
        self.assert_( res, 'failed with message: ' + msg )



    def test_validateFolder_tag_nonexisting(self):
        """
        Tests validateFolder for a nonexisting tag.
        """
        f = self.payloader.writeFolder( '/mv',
                                        mode = MULTI_VERSION,
                                        objectIds = range(5),
                                        channels = range(4) )

        res, msg = self.payloader.validateFolder( folderName = '/mv',
                                                  objectIds = range(5),
                                                  channels = range(4),
                                                  mode = MULTI_VERSION,
                                                  tag = 'A',
                                                  tagDescription = 'A desc' )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg, "Tag 'A' does not exist" )



    def test_validateFolder_tag_wrong_desc(self):
        """
        Tests validateFolder for a tag with the wrong description.
        """
        f = self.payloader.writeFolder( '/mv',
                                        mode = MULTI_VERSION,
                                        objectIds = range(5),
                                        channels = range(4) )
        f.tagCurrentHead( 'A', '' )

        res, msg = self.payloader.validateFolder( folderName = '/mv',
                                                  objectIds = range(5),
                                                  channels = range(4),
                                                  mode = MULTI_VERSION,
                                                  tag = 'A',
                                                  tagDescription = 'A desc' )
        self.assert_( not res, 'Failure expected, received success: ' + msg )
        self.assertEquals( msg,
                           "Wrong tag description, was '', expected 'A desc'" )



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



