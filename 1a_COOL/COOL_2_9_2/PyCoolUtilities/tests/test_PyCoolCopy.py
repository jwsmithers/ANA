import unittest, sys, os, time
from PyCool import cool
from PyCoolCopy import PyCoolCopy, CopyError, Selection, dbExists
from PyCoolCopy import silent, verbose, debug, validateSelections
from PyCoolPayloader import PyCoolPayloader

# simplify usage of these a bit...
SINGLE_VERSION = cool.FolderVersioning.SINGLE_VERSION
MULTI_VERSION  = cool.FolderVersioning.MULTI_VERSION

silent()

#######################################################################

class TestPyCoolCopy( unittest.TestCase ):


    def setUp(self):
        self.source = PyCoolPayloader( sourceConnectString, recreateDb = True )
        self.target = PyCoolPayloader( targetConnectString, recreateDb = True )


    def tearDown(self):
        del self.source.db
        del self.target.db


    def test_copy_folder_SV(self):
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, Selection( '/a' ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folder_MV(self):
        """
        Tests copying of a MV folder. The HEAD is copied to a SV folder on the
        target in basic copy mode. Therefore the validation is done against a
        SINGLE_VERSION folder.
        """
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = MULTI_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, Selection( '/a' ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = MULTI_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folderset_root(self):
        self.source.writeFolder( folderName = '/sv',
                                 objectIds = range(9),
                                 channels = range(9),
                                 description = 'sv folder',
                                 mode = SINGLE_VERSION )
        self.source.writeFolder( folderName = '/mv',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'mv folder',
                                 mode = MULTI_VERSION )
        self.assert_( not self.target.db.existsFolder( '/sv' ) )
        self.assert_( not self.target.db.existsFolder( '/mv' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, Selection( '/' ) )
        res, msg = self.target.validateFolder( folderName = '/sv',
                                               objectIds = range(9),
                                               channels = range(9),
                                               description = 'sv folder',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/mv',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'mv folder',
                                               mode = MULTI_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_tree(self):
        self.source.db.createFolderSet( '/sv' )
        self.source.db.createFolderSet( '/mv' )
        self.source.writeFolder( folderName = '/sv/a1' )
        self.source.writeFolder( folderName = '/sv/a2' )
        self.source.writeFolder( folderName = '/mv/a3', mode = MULTI_VERSION )
        self.source.writeFolder( folderName = '/mv/a4', mode = MULTI_VERSION )
        self.assert_( not self.target.db.existsFolder( '/sv/a1' ) )
        self.assert_( not self.target.db.existsFolder( '/sv/a2' ) )
        self.assert_( not self.target.db.existsFolder( '/mv/a3' ) )
        self.assert_( not self.target.db.existsFolder( '/mv/a4' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, Selection( '/' ) )
        self.assert_( self.target.db.existsFolderSet( '/sv' ) )
        self.assert_( self.target.db.existsFolderSet( '/mv' ) )
        res, msg = self.target.validateFolder( folderName = '/sv/a1' )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/sv/a2' )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/mv/a3',
                                               mode = MULTI_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/mv/a4',
                                               mode = MULTI_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folder_middle_of_hierarchy(self):
        self.source.db.createFolderSet( '/a' )
        self.source.db.createFolderSet( '/a/b' )
        self.source.writeFolder( folderName = '/a/b/c' )
        self.assert_( not self.target.db.existsFolder( '/a/b/c' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a/b/c' ) )
        self.assert_( self.target.db.existsFolderSet( '/a' ) )
        self.assert_( self.target.db.existsFolderSet( '/a/b' ) )
        res, msg = self.target.validateFolder( folderName = '/a/b/c' )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folderset_middle_of_hierarchy(self):
        self.source.db.createFolderSet( '/top' )
        self.source.db.createFolderSet( '/top/a' )
        self.source.db.createFolderSet( '/top/a/b' )
        self.source.writeFolder( folderName = '/top/a/b/c' )
        self.assert_( not self.target.db.existsFolder( '/top/a/b/c' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/top/a/b/c' ) )
        self.assert_( self.target.db.existsFolderSet( '/top/a' ) )
        self.assert_( self.target.db.existsFolderSet( '/top/a/b' ) )
        res, msg = self.target.validateFolder( folderName = '/top/a/b/c' )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_tag(self):
        f = self.source.writeFolder( '/mv',
                                     mode = MULTI_VERSION,
                                     objectIds = range(5),
                                     channels = range(4) )
        f.tagCurrentHead( 'A', 'desc A' )
        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.source.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/mv', tags = ['A'] ) )
        res, msg = self.target.validateFolder( folderName = '/mv',
                                               objectIds = range(5),
                                               channels = range(4),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'desc A' )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_tag_list_multiple_folders(self):
        """
        Tests copying a list of tags from multiple folders.
        (Following up on bug report by RH 2005-11-22)
        """
        # set up tag A in folder f1
        f = self.source.writeFolder( '/f1',
                                     mode = MULTI_VERSION,
                                     objectIds = range(5),
                                     channels = range(4) )
        f.tagCurrentHead( 'A', 'desc A' )
        f.createTagRelation('ROOTTAG', 'A')
        # add some extra data to folder f1
        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.source.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()
        # set up tag B in folder f2
        f = self.source.writeFolder( '/f2',
                                     mode = MULTI_VERSION,
                                     objectIds = range(4),
                                     channels = range(3) )
        f.tagCurrentHead( 'B', 'desc B' )
        f.createTagRelation('ROOTTAG', 'B')
        # add some extra data to folder f2
        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.source.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()
        res, msg = self.source.validateFolder( folderName = '/f1',
                                               objectIds = range(5),
                                               channels = range(4),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'desc A' )
        self.assert_( res, 'source tag A test failed with message: ' + msg )
        res, msg = self.source.validateFolder( folderName = '/f2',
                                               objectIds = range(4),
                                               channels = range(3),
                                               mode = MULTI_VERSION,
                                               tag = 'B',
                                               tagDescription = 'desc B' )
        self.assert_( res, 'source tag B test failed with message: ' + msg )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/',
                                                      tags = ['A', 'B'] ) )
        res, msg = self.target.validateFolder( folderName = '/f1',
                                               objectIds = range(5),
                                               channels = range(4),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'desc A' )
        self.assert_( res, 'tag A test failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/f2',
                                               objectIds = range(4),
                                               channels = range(3),
                                               mode = MULTI_VERSION,
                                               tag = 'B',
                                               tagDescription = 'desc B' )
        self.assert_( res, 'tag B test failed with message: ' + msg )


    def test_copy_tag_list(self):
        f = self.source.writeFolder( '/mv',
                                     mode = MULTI_VERSION,
                                     objectIds = range(5),
                                     channels = range(4) )
        f.tagCurrentHead( 'A', 'desc A' )
        self.source.writeFolder( '/mv',
                                 append = True,
                                 objectIds = range(4),
                                 channels = range(3) )
        f.tagCurrentHead( 'B', 'desc B' )
        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.source.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()
        res, msg = self.source.validateFolder( folderName = '/mv',
                                               objectIds = range(5),
                                               channels = range(4),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'desc A' )
        self.assert_( res, 'source tag A test failed with message: ' + msg )
        res, msg = self.source.validateFolder( folderName = '/mv',
                                               objectIds = range(4),
                                               channels = range(3),
                                               mode = MULTI_VERSION,
                                               tag = 'B',
                                               tagDescription = 'desc B' )
        self.assert_( res, 'source tag B test failed with message: ' + msg )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/mv',
                                                      tags = ['A', 'B'] ) )
        res, msg = self.target.validateFolder( folderName = '/mv',
                                               objectIds = range(5),
                                               channels = range(4),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'desc A' )
        self.assert_( res, 'tag A test failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/mv',
                                               objectIds = range(4),
                                               channels = range(3),
                                               mode = MULTI_VERSION,
                                               tag = 'B',
                                               tagDescription = 'desc B' )
        self.assert_( res, 'tag B test failed with message: ' + msg )


    def test_copy_iov_SV(self):
        self.source.writeFolder( '/a',
                                 objectIds = range(10),
                                 channels = range(10) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a',
                                                      since = 3,
                                                      until = 6 ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(3,7),
                                               channels = range(10) )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_iov_MV(self):
        self.source.writeFolder( '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 mode = MULTI_VERSION )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a',
                                                      since = 3,
                                                      until = 6 ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(3,7),
                                               channels = range(10),
                                               mode = MULTI_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_channels_SV(self):
        self.source.writeFolder( '/a',
                                 channels = range(10),
                                 objectIds = range(10) )
        sel = Selection( '/a', channels = cool.ChannelSelection( 4, 7 ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, sel )

        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(4,8) )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_selection_SV(self):
        self.source.writeFolder( '/a',
                                 channels = range(10),
                                 objectIds = range(10) )
        sel = Selection( '/a', since = 2, until = 4,
                         channels = cool.ChannelSelection( 4, 7 ) )
        PyCoolCopy( self.source.db ).copy( self.target.db, sel )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(2,5),
                                               channels = range(4,8) )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_selection_MV(self):
        f = self.source.writeFolder( '/a',
                                     channels = range(10),
                                     objectIds = range(10),
                                     mode = MULTI_VERSION )
        f.tagCurrentHead( 'A', 'tag A' )
        f.setupStorageBuffer()
        for ch in range( 10 ):
            for i in range( 10 ):
                f.storeObject( i, cool.ValidityKeyMax,
                               self.source.createPayload( 0, 0 ), ch )
        f.flushStorageBuffer()
        sel = Selection( '/a', since = 2, until = 4,
                         channels = cool.ChannelSelection( 4, 7 ),
                         tags = ['A'] )
        PyCoolCopy( self.source.db ).copy( self.target.db, sel )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(2,5),
                                               channels = range(4,8),
                                               mode = MULTI_VERSION,
                                               tag = 'A',
                                               tagDescription = 'tag A' )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_nonexisting_node(self):
        """
        Tests exceptional behavior when trying to copy a non-existing node.
        """
        try:
            PyCoolCopy( self.source.db ).copy( self.target.db,
                                               Selection( '/a' ) )
            self.fail( 'copying a non-existing node must fail' )
        except CopyError, e:
            self.assertEquals( str(e), "Node '/a' does not exist." )


    def test_copy_nonexisting_tag(self):
        """
        Tests exceptional behavior when trying to copy a non-existing tag.
        """
        self.source.writeFolder( '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 mode = MULTI_VERSION )
        try:
            sel = Selection( '/a', tags = ['A'] )
            PyCoolCopy( self.source.db ).copy( self.target.db, sel )
            self.fail( 'copying a non-existing tag must fail' )
        except CopyError, e:
            self.assertEquals( str(e), "Tag 'A' does not exist." )


    def test_copy_nonempty_target(self):
        """
        Tests exceptional behavior when trying to copy to a non-empty target
        database.
        """
        self.source.writeFolder( '/a',
                                 objectIds = range(10),
                                 channels = range(10) )
        self.target.writeFolder( '/b',
                                 objectIds = range(10),
                                 channels = range(10) )
        try:
            PyCoolCopy( self.source.db ).copy( self.target.db,
                                               Selection( '/a' ) )
            self.fail( 'copying over a non-empty target database must fail' )
        except CopyError, e:
            self.assertEquals( str(e), ( 'Target database contains data. '
                                         'Copy aborted.' ) )


    def test_dbExists(self):
    #def test_dbExists(self):
    # AV 17.01.06 Disable the whole test (like Marco did for PyCool tests)
    # Marco's hack of adding an empty printout does not solve the problem
        """
        Tests dbExists.
        """
        # The lines with the empty print are there to avoid a lock
        # correlated with the simultaneous presence of boost:shared_pts,
        # python and oracle (exposed when moving from seal::Reflection to
        # seal::Reflex)
        #                         Marco
        print "",
        self.assert_( dbExists( targetConnectString ),
                      'db does not exist when it should' )
        print "",
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase( targetConnectString )
        print "",
        self.assert_( not dbExists( targetConnectString ),
                      'db exists when it should not' )
        print "",


    def test_copy_description(self):
        """
        Tests that the folderset description is copied.
        """
        self.source.db.createFolderSet( '/f1', 'folderset description' )
        self.source.writeFolder( '/f1/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'folder description' )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/f1/a' ) )
        a = self.target.db.getFolder( '/f1/a' )
        self.assertEquals( a.description(), 'folder description' )
        f1 = self.target.db.getFolderSet( '/f1' )
        self.assertEquals( f1.description(), 'folderset description' )


    def test_copy_folder_SV_HEAD(self):
        """
        Copies a SV folder with explicit HEAD tag. (Bug report RH 2006-02-06)
        """
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a', tags = ['HEAD'] ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folder_SV_emptyStringTag(self):
        """
        Copies a SV folder with explicit HEAD tag. (Bug report RH 2006-02-06)
        """
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a', tags = [''] ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folder_SV_noneTagList(self):
        """
        Copies a SV folder with a 'None' tag list.
        """
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a', tags = None ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_copy_folder_SV_emptyTagList(self):
        """
        Copies a SV folder with an empty tag list.
        """
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        PyCoolCopy( self.source.db ).copy( self.target.db,
                                           Selection( '/a', tags = [] ) )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


#######################################################################

class TestMultiCopy( unittest.TestCase ):


    def setUp(self):
        self.source = PyCoolPayloader( sourceConnectString, recreateDb = True )
        self.target = PyCoolPayloader( targetConnectString, recreateDb = True )


    def tearDown(self):
        del self.source.db
        del self.target.db


    def test_folders_SV(self):
        self.source.writeFolder( folderName = '/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        self.source.writeFolder( folderName = '/b',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/b' ) )
        s = [ Selection( '/a' ), Selection( '/b' ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/b',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_hierarchy_SV(self):
        """
        Tests copying two selections with a common parent folderset.
        """
        self.source.db.createFolderSet( '/a' )
        self.source.writeFolder( folderName = '/a/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/a' ) )
        self.source.writeFolder( folderName = '/a/b',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/b' ) )
        s = [ Selection( '/a/a' ), Selection( '/a/b' ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/a/b',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_overlapping_iov_SV(self):
        """
        Tests copying two selections with an overlapping iov selection.
        """
        self.source.db.createFolderSet( '/a' )
        self.source.writeFolder( folderName = '/a/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/a' ) )
        self.source.writeFolder( folderName = '/a/b',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/b' ) )
        s = [ Selection( '/a', since = 2, until = 6  ),
              Selection( '/a/a', since = 4, until = 8 ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a/a',
                                               objectIds = range(2,8),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/a/b',
                                               objectIds = range(2,6),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_overlapping_iov_SV_reverseOrder(self):
        """
        Tests copying two selections with an overlapping iov selection in reverse order of
        selection.
        """
        self.source.db.createFolderSet( '/a' )
        self.source.writeFolder( folderName = '/a/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/a' ) )
        self.source.writeFolder( folderName = '/a/b',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/b' ) )
        s = [ Selection( '/a/a', since = 4, until = 8  ),
              Selection( '/a', since = 2, until = 6 ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a/a',
                                               objectIds = range(2,8),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/a/b',
                                               objectIds = range(2,6),
                                               channels = range(10),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_overlapping_channels_SV(self):
        """
        Tests copying two selections with an overlapping channel selection.
        """
        self.source.db.createFolderSet( '/a' )
        self.source.writeFolder( folderName = '/a/a',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/a' ) )
        self.source.writeFolder( folderName = '/a/b',
                                 objectIds = range(10),
                                 channels = range(10),
                                 description = 'test',
                                 mode = SINGLE_VERSION )
        self.assert_( not self.target.db.existsFolder( '/a/b' ) )
        s = [ Selection( '/a', since = 2, until = 6,
                         channels = cool.ChannelSelection( 3, 7 )  ),
              Selection( '/a/a', since = 4, until = 8,
                         channels = cool.ChannelSelection( 5, 9 ) ),
              Selection( '/a/b', since = 0, until = 5,
                         channels = cool.ChannelSelection( 1, 6 ) ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a/a',
                                               objectIds = range(2,8),
                                               channels = range(3,9),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/a/b',
                                               objectIds = range(0,6),
                                               channels = range(1,7),
                                               description = 'test',
                                               mode = SINGLE_VERSION )
        self.assert_( res, 'failed with message: ' + msg )


    def test_folders_MV(self):
        f = self.source.writeFolder( folderName = '/a',
                                     objectIds = range(10),
                                     channels = range(10),
                                     description = 'test',
                                     mode = MULTI_VERSION )
        f.tagCurrentHead( 'A' )
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        f = self.source.writeFolder( folderName = '/b',
                                     objectIds = range(10),
                                     channels = range(10),
                                     description = 'test',
                                     mode = MULTI_VERSION )
        f.tagCurrentHead( 'B' )
        self.assert_( not self.target.db.existsFolder( '/b' ) )
        s = [ Selection( '/a', tags = ['A'] ),
              Selection( '/b', tags = ['B'] ) ]
        PyCoolCopy( self.source.db ).copy( self.target.db, s )
        res, msg = self.target.validateFolder( folderName = '/a',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = MULTI_VERSION,
                                               tag = 'A' )
        self.assert_( res, 'failed with message: ' + msg )
        res, msg = self.target.validateFolder( folderName = '/b',
                                               objectIds = range(10),
                                               channels = range(10),
                                               description = 'test',
                                               mode = MULTI_VERSION,
                                               tag = 'B' )
        self.assert_( res, 'failed with message: ' + msg )


    def test_validateSelections_0(self):
        s = [ Selection( '/a', since = 2, until = 6 ),
              Selection( '/a/a', since = 4, until = 8 ), ]
        validateSelections( s )
        self.assertEquals( '/a/a', s[0].nodeName )
        self.assertEquals( 2, s[0].since )
        self.assertEquals( 8, s[0].until )
        self.assertEquals( '/a', s[1].nodeName )
        self.assertEquals( 2, s[1].since )
        self.assertEquals( 6, s[1].until )


    def test_validateSelections_1(self):
        s = [ Selection( '/a/a', since = 4, until = 8  ),
              Selection( '/a', since = 2, until = 6 ) ]
        validateSelections( s )
        self.assertEquals( '/a/a', s[0].nodeName )
        self.assertEquals( 2, s[0].since )
        self.assertEquals( 8, s[0].until )
        self.assertEquals( '/a', s[1].nodeName )
        self.assertEquals( 2, s[1].since )
        self.assertEquals( 6, s[1].until )


    def test_validateSelections_2(self):
        s = [ Selection( '/a', since = 4, until = 6 ),
              Selection( '/a/a', since = 5, until = 8 ),
              Selection( '/a/b', since = 2, until = 5 ),
              Selection( '/a/c', since = 2, until = 8 ),
              Selection( '/a/d', since = 3, until = 5 ),
              Selection( '/b', since = 5, until = 10 ), ]
        validateSelections( s )
        self.assertEquals( '/a/d', s[0].nodeName )
        self.assertEquals( 3, s[0].since )
        self.assertEquals( 6, s[0].until )
        self.assertEquals( '/a/c', s[1].nodeName )
        self.assertEquals( 2, s[1].since )
        self.assertEquals( 8, s[1].until )
        self.assertEquals( '/a/b', s[2].nodeName )
        self.assertEquals( 2, s[2].since )
        self.assertEquals( 6, s[2].until )
        self.assertEquals( '/a/a', s[3].nodeName )
        self.assertEquals( 4, s[3].since )
        self.assertEquals( 8, s[3].until )
        self.assertEquals( '/b', s[4].nodeName )
        self.assertEquals( 5, s[4].since )
        self.assertEquals( 10, s[4].until )
        self.assertEquals( '/a', s[5].nodeName )
        self.assertEquals( 4, s[5].since )
        self.assertEquals( 6, s[5].until )


    def test_validateSelections_3(self):
        s = [ Selection( '/a', since = 4, until = 6 ),
              Selection( '/a/b', since = 5, until = 8 ),
              Selection( '/a/b/c', since = 2, until = 5 ) ]
        validateSelections( s )
        self.assertEquals( '/a/b/c', s[0].nodeName )
        self.assertEquals( 2, s[0].since )
        self.assertEquals( 8, s[0].until )
        self.assertEquals( '/a/b', s[1].nodeName )
        self.assertEquals( 4, s[1].since )
        self.assertEquals( 8, s[1].until )
        self.assertEquals( '/a', s[2].nodeName )
        self.assertEquals( 4, s[2].since )
        self.assertEquals( 6, s[2].until )


#######################################################################

class TestSelection( unittest.TestCase ):


    def test_extendIov(self):
        s = Selection( '/a', since = 2, until = 4 )
        s.extendIov( 1, 3 )
        self.assertEquals( 1, s.since )
        self.assertEquals( 4, s.until )


    def test_isParent(self):
        s = Selection( '/a/b' )
        self.assert_( s.isParent( '/a' ) )
        self.assert_( s.isParent( '/' ) )
        self.assert_( not s.isParent( '/a/b' ) )
        self.assert_( not s.isParent( '/a/b/' ) )
        self.assert_( not s.isParent( '/b' ) )
        s = Selection( '/aa' )
        self.assert_( not s.isParent( '/a' ) )


    def test_tag_sorting(self):
        s = Selection( tags = [ 'a', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b' ] )
        s = Selection( tags = [ 'HEAD', 'a', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b', 'HEAD' ] )
        s = Selection( tags = [ 'a', 'HEAD', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b', 'HEAD' ] )
        s = Selection( tags = [ '', 'a', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b', 'HEAD' ] )
        s = Selection( tags = [ 'HEAD', 'a', '', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b', 'HEAD' ] )
        s = Selection( tags = [ 'HEAD', 'a', 'HEAD', 'b' ] )
        self.assertEquals( s.tags, [ 'a', 'b', 'HEAD' ] )


    def test_hasNonHeadTags(self):
        s = Selection( tags = [ 'a', 'b' ] )
        self.assert_( s.hasNonHeadTags() )
        s = Selection( tags = [ '' ] )
        self.assert_( not s.hasNonHeadTags() )
        s = Selection( tags = [ 'HEAD' ] )
        self.assert_( not s.hasNonHeadTags() )
        s = Selection( tags = [] )
        self.assert_( not s.hasNonHeadTags() )
        s = Selection( tags = None )
        self.assert_( not s.hasNonHeadTags() )
        s = Selection( tags = [ 'HEAD', 'b' ] )
        self.assert_( s.hasNonHeadTags() )
        s = Selection( tags = [ 'a', '' ] )
        self.assert_( s.hasNonHeadTags() )
        s = Selection( tags = [ '', 'HEAD' ] )
        self.assert_( not s.hasNonHeadTags() )


    def test_hasHeadTags(self):
        s = Selection( tags = [ 'a', 'b' ] )
        self.assert_( not s.hasHeadTag() )
        s = Selection( tags = [ '' ] )
        self.assert_( s.hasHeadTag() )
        s = Selection( tags = [ 'HEAD' ] )
        self.assert_( s.hasHeadTag() )
        s = Selection( tags = [] )
        self.assert_( not s.hasHeadTag() )
        s = Selection( tags = None )
        self.assert_( not s.hasHeadTag() )
        s = Selection( tags = [ 'HEAD', 'b' ] )
        self.assert_( s.hasHeadTag() )
        s = Selection( tags = [ 'a', '' ] )
        self.assert_( s.hasHeadTag() )
        s = Selection( tags = [ '', 'HEAD' ] )
        self.assert_( s.hasHeadTag() )


    def test_cmp(self):
        s = [ Selection( '/b' ), Selection( '/a' ), Selection( '/c' ) ]
        s.sort()
        self.assertEquals( s[0].nodeName, '/a' )
        self.assertEquals( s[1].nodeName, '/b' )
        self.assertEquals( s[2].nodeName, '/c' )
        s = [ Selection( '/az' ), Selection( '/a/b' ), Selection( '/aa' ) ]
        s.sort()
        self.assertEquals( s[0].nodeName, '/aa' )
        self.assertEquals( s[1].nodeName, '/az' )
        self.assertEquals( s[2].nodeName, '/a/b' )
        s = [ Selection( '/a_z' ), Selection( '/a/b' ), Selection( '/a_a' ) ]
        s.sort()
        self.assertEquals( s[0].nodeName, '/a_a' )
        self.assertEquals( s[1].nodeName, '/a_z' )
        self.assertEquals( s[2].nodeName, '/a/b' )
        s = [ Selection( '/a' ), Selection( '/a/a' ), Selection( '/a/b' ) ]
        s.sort()
        self.assertEquals( s[0].nodeName, '/a' )
        self.assertEquals( s[1].nodeName, '/a/a' )
        self.assertEquals( s[2].nodeName, '/a/b' )
        s = [ Selection( '/a' ), Selection( '/a/a' ), Selection( '/b' ) ]
        s.sort()
        self.assertEquals( s[0].nodeName, '/a' )
        self.assertEquals( s[1].nodeName, '/b' )
        self.assertEquals( s[2].nodeName, '/a/a' )


#######################################################################

class TestHVSCopy( unittest.TestCase ):


    def setUp(self):
        self.source = PyCoolPayloader( sourceConnectString, recreateDb = True )
        self.target = PyCoolPayloader( targetConnectString, recreateDb = True )


    def tearDown(self):
        del self.source.db
        del self.target.db


    def test_restoreTagRelation(self):
        '''
        Test the copy of a tag hierarchy
        '''
        self.source.db.createFolderSet('/a')
        f = self.source.writeFolder( folderName = '/a/b',
                                     objectIds = range(10),
                                     channels = range(10),
                                     description = 'test folder',
                                     mode = MULTI_VERSION)
        self.assert_( not self.target.db.existsFolder( '/a/b' ) )
        f.tagCurrentHead( 'B' )
        f.createTagRelation('A', 'B')
        fs = self.source.db.getFolderSet('/a')
        fs.createTagRelation('ROOTTAG', 'A')
        s = Selection('/a', tags = ['A'])
        PyCoolCopy(self.source.db).copy(self.target.db, [s])
        self.assert_( self.target.db.existsFolder( '/a/b' ),
                      "Folder '/a/b' was not copied" )
        f = self.target.db.getFolder('/a/b')
        self.assertEqual('B', f.resolveTag('A'),
                         "The relation between tags 'B' and 'A' was not found")
        # This should fail because nobody asked for ROOTTAG to be
        # copied and connected.
        self.assertRaises(Exception, f.resolveTag, 'ROOTTAG')


#######################################################################

class TestAppend( unittest.TestCase ):


    def setUp(self):
        self.source = PyCoolPayloader( sourceConnectString, recreateDb = True )
        self.target = PyCoolPayloader( targetConnectString, recreateDb = True )


    def tearDown(self):
        del self.source.db
        del self.target.db


    def test_append(self):
        '''
        Test the copy of a tag hierarchy
        '''
        f = self.source.writeFolder( folderName = '/a',
                                     objectIds = range(10),
                                     channels = range(10),
                                     description = 'test folder',
                                     mode = MULTI_VERSION)
        self.assert_( not self.target.db.existsFolder( '/a' ) )
        f.tagCurrentHead( 'A' )
        s = Selection('/a', tags = ['A'])
        PyCoolCopy(self.source.db).copy(self.target.db, [s])
        f = self.source.writeFolder( folderName = '/b',
                                     objectIds = range(10),
                                     channels = range(10),
                                     description = 'test folder',
                                     mode = MULTI_VERSION)
        self.assert_( not self.target.db.existsFolder( '/b' ) )
        f.tagCurrentHead( 'B' )
        s = Selection('/b', tags = ['B'])
        try:
            PyCoolCopy(self.source.db).copy(self.target.db, [s])
        except CopyError, details:
            self.assertEqual(str(details),
                             'Target database contains data. Copy aborted.')
        PyCoolCopy(self.source.db).append(self.target.db, [s])
        self.assert_( self.target.db.existsFolder( '/b' ),
                      "Folder '/b' was not copied" )
        f = self.target.db.getFolder('/b')
        # This should fail because tag 'B' was not copied
        self.assertRaises(Exception, f.resolveTag, 'B')


#######################################################################

sourceKey = "COOLTESTDB_SOURCE"
targetKey = "COOLTESTDB_TARGET"

if __name__ == '__main__':
    if sourceKey in os.environ and targetKey in os.environ:
        sourceConnectString = os.environ[sourceKey]
        targetConnectString = os.environ[targetKey]
    else:
        print 'Usage: %s' % ( sys.argv[0] )
        print 'You must set env variables %s and %s'%( sourceKey, targetKey )
        sys.exit(-1)

    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )


