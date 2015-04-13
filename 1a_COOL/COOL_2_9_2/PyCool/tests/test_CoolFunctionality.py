#!/usr/bin/env python

import unittest, sys, os, time
import traceback
from PyCool import cool, coral

connectString = None

def getNext( objs ):
    objs.goToNext();
    return objs.currentRef();

class TestCoolFunctionality( unittest.TestCase ):

    # This dummy member fuction overloads the original from pyunittest.
    # Because of a problem with Reflex and boost::shared_ptr and exceptions,
    # almost all the tests calling it are failing
    #def assertRaises(*args):
    #    pass

    spec = None
    unittest.TestCase.shared_db = None
    def dummyPayload( self, index ):
        """Creates a dummy payload AttributeList for a given index"""
        payload = self.defaultRecord()
        payload["I"] = index
        payload["S"] = 'Object %d' % index
        payload["X"] = index / 1000.
        return payload

    def defaultRecord( self ):
        return cool.Record( self.spec )

    def setUp(self):
        try:
            if self.spec is None:
                self.spec = cool.RecordSpecification()
                self.spec.extend( "I", cool.StorageType.Int32 )
                self.spec.extend( "S", cool.StorageType.String4k )
                self.spec.extend( "X", cool.StorageType.Float )
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


    def test_storeObject(self):
        data = self.defaultRecord()
        data['I'] = 42
        folder = self.db.createFolder( "/f1", self.spec )
        folder.storeObject( 0, 5, data, 0 )
        obj = folder.findObject( 2, 0 )
        payload = obj.payload()
        self.assertEquals( data['I'], payload['I'] )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )


    def test_getFolder(self):
        # Tests creating and retrieving a folder.
        # This test is implemented in more detail with respect to the folder
        # attributes in test_RalDatabase
        self.db.createFolder( "/myfolder", self.spec, "a description" );
        folder = self.db.getFolder( "/myfolder" )
        self.assert_( folder != None )
        self.assertEquals( "/myfolder", folder.fullPath() )
        self.assertEquals( "a description", folder.description() )
        self.assert_( folder.isLeaf() )
        self.assert_( folder.isStored() )
        self.assertEquals( len("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT"),
                           len(str(folder.insertionTime())) )
        self.assertEquals( 1, folder.id() )
        self.assertEquals( 0, folder.parentId() )


    def test_findObject(self):
        # Tests storing and reading back of an Object
        # This test is implemented in more detail with respect to the object
        # attributes in test_RalDatabase
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.storeObject( 0, 2, self.dummyPayload(1), 0 )
        folder.storeObject( 2, 4, self.dummyPayload(2), 0 )
        obj = folder.findObject( 1, 0 )
        # assert_ works better with coral.AttributeList than assertEquals
        self.assert_( self.dummyPayload( 1 ) == obj.payload() )
        obj = folder.findObject( 3, 0 )
        self.assert_( self.dummyPayload( 2 ) == obj.payload() )


    def test_findObject_MV(self):
        # Tests storing and reading back of an Object in a MultiVersion folder
        # This test is implemented in more detail with respect to the object
        # attributes in test_RalDatabase
        folder = self.db.createFolder( "/myfolder",
                                       self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, 2, self.dummyPayload( 1 ), 0 )
        folder.storeObject( 2, 4, self.dummyPayload( 2 ), 0 )
        obj = folder.findObject( 1, 0 )
        self.assert_( self.dummyPayload( 1 ) == obj.payload() )
        obj = folder.findObject( 3, 0 )
        self.assert_( self.dummyPayload( 2 ) == obj.payload() )


    def test_findObject_wrongChannel(self):
        # Tests reading back of an Object from a channel
        # that does not exist
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.storeObject( 0, 2, self.dummyPayload(1), 1 )
        folder.storeObject( 2, 4, self.dummyPayload(2), 1 )
        # This is expected to throw an exception
        # We cannot obtain the C++ exception types and have to accept
        # the blanket Exception
        self.assertRaises( Exception, folder.findObject, 1, 2 )


    def test_findObject_after_dropNode_SV(self):
        # Tests reading back of an Object from a deleted SV folder.
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.storeObject( 0, 2, self.dummyPayload(1), 0 )
        self.db.dropNode( "/myfolder" )
        self.assertRaises( Exception, folder.findObject, 1, 0 )


    def test_findObject_after_dropNode_MV(self):
        # Tests reading back of an Object from a deleted MV folder.
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, 2, self.dummyPayload(1), 0 )
        self.db.dropNode( "/myfolder" )
        self.assertRaises( Exception, folder.findObject, 1, 0 )


    def test_access_outofscope_db(self):
        # The original C++ test: "Tests reading back of a folder from
        # a db handle that went out of scope" does not make sense in python.
        pass


    def test_flushStorageBuffer(self):
        # Tests bulk operation 'flushStorageBuffer'.
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.setupStorageBuffer()
        folder.storeObject( 0, cool.ValidityKeyMax, self.dummyPayload(0), 0 )
        folder.storeObject( 1, cool.ValidityKeyMax, self.dummyPayload(1), 0 )
        self.assertRaises( Exception, folder.findObject, 1, 0 )
        folder.flushStorageBuffer()
        obj = folder.findObject( 0, 0 )
        self.assert_( self.dummyPayload(0) == obj.payload() )
        obj = folder.findObject( 1, 0 )
        self.assert_( self.dummyPayload(1) == obj.payload() )


    def test_storeObject_bulk_SV(self):
        # Tests bulk storeObject of SV objects.
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.setupStorageBuffer()
        nObjs = 100
        for i in range(nObjs):
            folder.storeObject( i, cool.ValidityKeyMax, self.dummyPayload(i), 0 )
        self.assertRaises( Exception, folder.findObject, 0, 0 )
        folder.flushStorageBuffer()
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        for i in range( objs.size() ):
            obj = getNext( objs )
            self.assert_( self.dummyPayload(i) == obj.payload(),
                          'obj %d payload' % i )
            self.assert_( obj.since() == i, 'obj %d since' % i )
            if i < nObjs-1:
                expectedUntil = i+1
            else:
                expectedUntil = cool.ValidityKeyMax
            self.assert_( obj.until() == expectedUntil, 'obj %d until' % i )


    def test_storeObject_bulk_SV_listReused(self):
        # Tests bulk storeObject of SV objects with a reused AttributeList
        # This test ensures that the payload data is copied, not referenced
        # inside the storage buffer.
        folder = self.db.createFolder( "/myfolder", self.spec )
        payload = self.dummyPayload( 0 )
        folder.setupStorageBuffer()
        nObjs = 100
        for i in range(nObjs):
            payload["I"] = i
            folder.storeObject( i, cool.ValidityKeyMax, payload, 0 )
        self.assertRaises( Exception, folder.findObject, 0, 0 )
        folder.flushStorageBuffer()
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        for i in range( objs.size() ):
            obj = getNext( objs )
            self.assertEquals( i, obj.payload()["I"], 'obj %d payload' % i )
            self.assert_( obj.since() == i, 'obj %d since' % i )
            if i < nObjs-1:
                expectedUntil = i+1
            else:
                expectedUntil = cool.ValidityKeyMax
            self.assert_( obj.until() == expectedUntil, 'obj %d until' % i )


    def _test_storeObject_bulk_70k(self):
        # Tests bulk storeObject of 70k objects: this caused an ORA-24381
        # error before a sub-batching fix was applied.
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.setupStorageBuffer()
        nObjs = 70*1000
        for i in range(nObjs):
            if i % 1000 == 0: print 'writing', i
            folder.storeObject( i, cool.ValidityKeyMax, self.dummyPayload( i ), 0 )
        folder.flushStorageBuffer()
        for i in range( 0, nObjs, 1000 ):
            if i % 1000 == 0: print 'testing', i
            obj = folder.findObject( i, 0 )
            self.assert_( self.dummyPayload(i) == obj.payload(),
                          'obj %d payload' % i )
            self.assert_( obj.since() == i, 'obj %d since' % i )
            if i < nObjs-1:
                expectedUntil = i+1
            else:
                expectedUntil = cool.ValidityKeyMax
            self.assert_( obj.until() == expectedUntil, 'obj %d until' % i )


    def test_storeObject_bulk_MV(self):
        # Tests bulk storeObject of MV objects.
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.setupStorageBuffer()
        nObjs = 10
        for i in range(nObjs):
            folder.storeObject( i, cool.ValidityKeyMax, self.dummyPayload(i), 0 )
        self.assertRaises( Exception, folder.findObject, 0, 0 )
        folder.flushStorageBuffer()
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        for i in range( objs.size() ):
            obj = getNext( objs )
            self.assert_( self.dummyPayload(i) == obj.payload(),
                          'obj %d payload' % i )
            self.assert_( obj.since() == i, 'obj %d since' % i )
            if i < nObjs-1:
                expectedUntil = i+1
            else:
                expectedUntil = cool.ValidityKeyMax
            self.assert_( obj.until() == expectedUntil, 'obj %d until' % i )


    def test_MV_tag_and_retrieve(self):
        # Tests MV tagging and retrieving.
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.setupStorageBuffer()
        folder.storeObject( 0, 4, self.dummyPayload(0), 0 )
        folder.storeObject( 2, 6, self.dummyPayload(1), 0 )
        folder.flushStorageBuffer()
        folder.tagCurrentHead( "tagA", "an optional description" )
        obj = folder.findObject( 0, 0 )
        asOfDate = obj.insertionTime()
        # this one gives a segfault
        #asOfDate = folder.findObject( 0, 0 ).insertionTime()
        # MySQL now() has 1 second granularity: need to sleep at least 1 second
        time.sleep(1)
        folder.setupStorageBuffer()
        folder.storeObject( 3, 7, self.dummyPayload(2), 0 )
        folder.storeObject( 5, 9, self.dummyPayload(3), 0 )
        folder.flushStorageBuffer()
        folder.tagCurrentHead( "tagB" )
        folder.tagHeadAsOfDate( asOfDate, "tagC" )
        # fetch tagA
        channel = 0
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(channel), "tagA" )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 2, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 6, obj.until() )
        # fetch tagB
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(channel), "tagB" )
        self.assertEquals( 4, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 2, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 3, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 3, obj.since() )
        self.assertEquals( 5, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(3), obj.payload() )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 9, obj.until() )
        # fetch head
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 2, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 3, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 3, obj.since() )
        self.assertEquals( 5, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(3), obj.payload() )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 9, obj.until() )
        # fetch tagC
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(channel), "tagC" )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 2, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 6, obj.until() )


    def test_deleteTag_andRetag(self):
        # Tests deleting a tag and retagging.
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        # First version of tagA
        folder.storeObject( 0, 4, self.dummyPayload( 0 ), 0 )
        folder.tagCurrentHead( "tagA", "an optional description" )
        channel = 0
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(channel), "tagA" )
        self.assertEquals( 1, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 4, obj.until() )
        self.assertRaises( Exception, folder.tagCurrentHead, "tagA" )
        # Second version of tagA
        folder.storeObject( 2, 6, self.dummyPayload( 1 ), 0 )
        folder.deleteTag( "tagA" )
        self.assert_( not self.db.existsTag( "tagA" ) )
        folder.tagCurrentHead( "tagA", "an optional description" )
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(channel), "tagA" )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 2, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 6, obj.until() )


    def test_deleteTag_HEAD(self):
        # Tests that attempting to delete the reserved HEAD tag throws
        # an exception.
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, 4, self.dummyPayload( 0 ), 0 )
        folder.tagCurrentHead( "tagA", "an optional description" )
        self.assertRaises( Exception, folder.deleteTag, "HEAD" )


    def test_tagExistsElsewhere(self):
        folder1 = self.db.createFolder( "/myfolder1", self.spec,
                                        "my description",
                                        cool.FolderVersioning.MULTI_VERSION )
        folder2 = self.db.createFolder( "/myfolder2", self.spec,
                                        "my description",
                                        cool.FolderVersioning.MULTI_VERSION )
        folder1.storeObject( 0, 10, self.dummyPayload( 0 ), 0 )
        folder2.storeObject( 10, 20, self.dummyPayload( 1 ), 0 )
        folder2.storeObject( 20, 30, self.dummyPayload( 2 ), 0 )
        tagA = "tagA"
        descA = "tagA description"
        tagB = "tagB"
        descB = "tagB description"
        # TagA cannot be created in folder2 if it exists in folder1 already
        folder1.tagCurrentHead( tagA, descA )
        try:
            folder2.tagCurrentHead( tagA, descA )
            self.fail( "TagExists expected" );
        except Exception:
            try:
                folder2.deleteTag( tagA );
                folder2.tagCurrentHead( tagA, descA );
                self.fail( "TagNotFound expected" )
            except Exception: # TagNotFound
                pass
        # Create tagB in folder2: this has the same tagId=1 as tagA in folder1
        # BUG in COOL_1_2_2: folder1.delete(tagA) also deletes tagB and fails
        folder2.tagCurrentHead( tagB, descB )
        folder1.deleteTag( tagA )


    def test_multiple_folders(self):
        # Stores objects to multiple folders and retrieves them in a loop
        # Tests against a problem first reported by Marco Clemencic on
        # 2005-01-27 -- cannot reproduce at the moment
        showPrintout = False
        nFolders = 5
        foldernames = [ "/f_%d" % i for i in range( nFolders ) ]
        for fname in foldernames:
            self.db.createFolder( fname, self.spec )
        nObjs = 100
        for fname in foldernames:
            folder = self.db.getFolder( fname )
            folder.setupStorageBuffer()
            for i in range( nObjs ):
                folder.storeObject( i, cool.ValidityKeyMax,
                                    self.dummyPayload(i), 0 )
            folder.flushStorageBuffer()
            if showPrintout:
                print 'wrote %d objects in folder %s' % ( nObjs, fname )
        for fname in foldernames:
            folder = self.db.getFolder( fname )
            objs = folder.browseObjects( cool.ValidityKeyMin,
                                         cool.ValidityKeyMax,
                                         cool.ChannelSelection(0), "" )
            objIndex = 0
            while objs.goToNext():
                s = "folder %s: object %d " % ( fname, objIndex )
                obj = objs.currentRef()
                self.assertEquals( self.dummyPayload(objIndex), obj.payload(),
                                   s + 'payload' )
                if showPrintout and objIndex % 10 == 0:
                    print "%s [%d]: %s" % ( fname, objIndex, obj.payload() )
                self.assertEquals( objIndex, obj.since(), s + "since" )
                if objIndex < nObjs-1:
                    expectedUntil = objIndex+1
                else:
                    expectedUntil = cool.ValidityKeyMax
                self.assertEquals( expectedUntil, obj.until(), s + "until" )
                objIndex += 1
            if showPrintout:
                print 'checked %d objects in folder %s' % ( objIndex, fname )


    def test_ValidityKey_boundaries(self):
        self.assertEquals( 0, cool.ValidityKeyMin )
        self.assertEquals( 9223372036854775807, cool.ValidityKeyMax )


    def test_ValidityKeyException(self):
        # Tests that a ValidityKeyException is thrown when since>=until
        # and when since or until are out of boundaries
        folder = self.db.createFolder( "/myfolder", self.spec )
        self.assertRaises( Exception,
                           folder.storeObject, 100, 0, self.dummyPayload(0), 0 )
        self.assertRaises( Exception,
                           folder.storeObject, 100, 100, self.dummyPayload(0), 0 )
        s = cool.ValidityKeyMin -1
        u = cool.ValidityKeyMin
        self.assertRaises( Exception,
                           folder.storeObject, s, u, self.dummyPayload(0), 0 )
        s = cool.ValidityKeyMax
        u = cool.ValidityKeyMax +1
        self.assertRaises( Exception,
                           folder.storeObject, s, u, self.dummyPayload( 0 ), 0 )


    def test_flushStorageBuffer_exception(self):
        # Tests that the storage buffer is cleared and none of the objects
        # is stored if an exception is thrown during the bulk operation
        # 'flushStorageBuffer' (for instance, because one IOV has until<since)
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.setupStorageBuffer()
        folder.storeObject( 0, cool.ValidityKeyMax, self.dummyPayload( 0 ), 0 )
        folder.storeObject( 10, 20, self.dummyPayload( 1 ), 0 )
        folder.flushStorageBuffer()
        folder.setupStorageBuffer()
        folder.storeObject( 20, cool.ValidityKeyMax, self.dummyPayload( 2 ), 0 )
        folder.storeObject( 30, 20, self.dummyPayload( 3 ), 0 )
        folder.storeObject( 40, 50, self.dummyPayload( 4 ), 0 )
        self.assertRaises( Exception, folder.flushStorageBuffer )
        folder.setupStorageBuffer()
        folder.storeObject( 50, cool.ValidityKeyMax, self.dummyPayload( 5 ), 0 )
        folder.storeObject( 60, 70, self.dummyPayload( 6 ), 0 )
        folder.flushStorageBuffer()
        obj = folder.findObject( 0, 0 )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        obj = folder.findObject( 10, 0 )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertRaises( Exception, folder.findObject, 20, 0 )
        self.assertRaises( Exception, folder.findObject, 30, 0 )
        self.assertRaises( Exception, folder.findObject, 40, 0 )
        obj = folder.findObject( 50, 0 )
        self.assertEquals( self.dummyPayload(5), obj.payload() )
        obj = folder.findObject( 60, 0 )
        self.assertEquals( self.dummyPayload(6), obj.payload() )


    def test_browseObjects_SV(self):
        # Tests object browsing (SV folders)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.SINGLE_VERSION )
        folder.storeObject( 0, 10, self.dummyPayload( 0 ), 0 )
        folder.storeObject( 10, 20, self.dummyPayload( 1 ), 0 )
        folder.storeObject( 20, cool.ValidityKeyMax, self.dummyPayload( 2 ), 0 )
        objs = folder.browseObjects( 5, 15, cool.ChannelSelection(0) )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        objs = folder.browseObjects( 10, 20, cool.ChannelSelection(0) )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        self.assertEquals( 3, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )


    def test_browseObjects_MV(self):
        # Tests object browsing (MV folders)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, 10, self.dummyPayload( 0 ), 0 )
        folder.storeObject( 10, 20, self.dummyPayload( 1 ), 0 )
        folder.storeObject( 20, cool.ValidityKeyMax, self.dummyPayload( 2 ), 0 )
        objs = folder.browseObjects( 5, 15, cool.ChannelSelection(0) )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        objs = folder.browseObjects( 10, 20, cool.ChannelSelection(0) )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax, cool.ChannelSelection(0) )
        self.assertEquals( 3, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )


    def test_browseObjects_MV_tag(self):
        # Tests object browsing in tags (MV folders)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, 10, self.dummyPayload( 0 ), 0 )
        folder.storeObject( 10, 20, self.dummyPayload( 1 ), 0 )
        folder.storeObject( 20, cool.ValidityKeyMax, self.dummyPayload( 2 ), 0 )
        folder.tagCurrentHead( "mytag" )
        objs = folder.browseObjects( 5, 15, cool.ChannelSelection(0), "mytag" )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        objs = folder.browseObjects( 10, 20, cool.ChannelSelection(0), "mytag" )
        self.assertEquals( 2, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        objs = folder.browseObjects( cool.ValidityKeyMin, cool.ValidityKeyMax,
                                     cool.ChannelSelection(0), "mytag" )
        self.assertEquals( 3, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(2), obj.payload() )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )


    def test_listChannels(self):
        # Tests listChannels (SingleVersion only, MultiVersion test in
        # test_RalDatabase)
        folder = self.db.createFolder( "/myfolder", self.spec )
        channel = 1
        folder.storeObject( 0, cool.ValidityKeyMax,
                            self.dummyPayload(0), channel )
        channel = 3
        folder.storeObject( 0, cool.ValidityKeyMax,
                            self.dummyPayload(0), channel )
        channel = 5
        folder.storeObject( 0, cool.ValidityKeyMax,
                            self.dummyPayload(0), channel )
        channels = folder.listChannels()
        self.assertEquals( 3, len(channels) )
        self.assertEquals( 1, channels[0] )
        self.assertEquals( 3, channels[1] )
        self.assertEquals( 5, channels[2] )
        # check exceptional behavior
        folder = self.db.createFolder( "/empty_folder", self.spec )
        # a folder without data has no channels
        channels = folder.listChannels()
        self.assertEquals( 0, len(channels) )


    def test_listTags(self):
        # Tests listTags (MultiVersion only, SingleVersion does not have tags
        # and returns an empty vector)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, cool.ValidityKeyMax, self.dummyPayload(0), 0 )
        folder.tagCurrentHead( "A" )
        folder.tagCurrentHead( "B" )
        tags = folder.listTags()
        self.assertEquals( 2, len(tags) )
        self.assertEquals( "A", tags[0] )
        self.assertEquals( "B", tags[1] )


    def test_tagInsertionTime(self):
        # Tests tagInsertionTime (MultiVersion only, SingleVersion does not
        # have tags and throws a RelationalException)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, cool.ValidityKeyMax, self.dummyPayload(0), 0 )
        folder.tagCurrentHead( "A" )
        tagTime = folder.tagInsertionTime( "A" )
        # the real time functionality test
        # is implemented in test_RalDatabase.cpp
        self.assertEquals( len("yyyy-mm-dd_hh:mm:ss.nnnnnnnnn GMT"),
                           len(str(tagTime)) )


    def test_tagDescription(self):
        # Tests tagDescription (MultiVersion only, SingleVersion does not have
        # tags and throws a RelationalException)
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        folder.storeObject( 0, cool.ValidityKeyMax, self.dummyPayload(0), 0 )
        folder.tagCurrentHead( "A", "desc A" );
        self.assertEquals( "desc A", folder.tagDescription( "A" ) )
        self.assertRaises( Exception, folder.tagDescription, "nonexisting tag" )


    def test_storeObjects_bulk_multichannel(self):
        # Tests bulk insertion into multiple channels (SV mode)
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.setupStorageBuffer()
        nChannels = 10;
        for ch in range(nChannels):
            folder.storeObject( 0, cool.ValidityKeyMax,
                                self.dummyPayload( ch ), ch );
        for ch in range(nChannels):
            folder.storeObject( 5, cool.ValidityKeyMax,
                                self.dummyPayload( ch ), ch );
        folder.flushStorageBuffer()
        nObjsPerChannel = 2;
        for ch in range(nChannels):
            for i in range(nObjsPerChannel):
                s = 'object %d, channel %d ' % ( i, ch )
                pointInTime = 5*i
                obj = folder.findObject( pointInTime, ch )
                self.assertEquals( self.dummyPayload(ch), obj.payload(),
                                   s + 'payload' )
                self.assertEquals( pointInTime, obj.since(), s + 'since' )
                if i < nObjsPerChannel-1:
                    expectedUntil = pointInTime +5
                else:
                    expectedUntil = cool.ValidityKeyMax
                self.assertEquals( expectedUntil, obj.until(), s + 'until' )


    def test_setDescription(self):
        # Tests updating the folder description
        folder = self.db.createFolder( "/myfolder", self.spec,
                                       "a description" )
        folder.setDescription( "new description" )
        self.assertEquals( "new description", folder.description() )
        folder = self.db.getFolder( "/myfolder" )
        self.assertEquals( "new description", folder.description() )


    def test_storeObject_SV_overlap(self):
        # Tests storeObject with overlapping intervals
        # bug #9212 reported 2005-06-24 by Federico
        try:
            folder = self.db.createFolder( "/f1", self.spec )
            folder.storeObject( 300, 400, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 200, 400, self.dummyPayload( 1 ), 0 )
            self.fail( "400 until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )
        try:
            folder = self.db.createFolder( "/f2", self.spec )
            folder.storeObject( 300, 350, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 200, 400, self.dummyPayload( 1 ), 0 )
            self.fail( "non-equal until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )
        try:
            folder = self.db.createFolder( "/f3", self.spec )
            folder.storeObject( 300, cool.ValidityKeyMax, self.dummyPayload(1), 0 )
            folder.storeObject( 200, cool.ValidityKeyMax, self.dummyPayload(1), 0 )
            self.fail( "cool.ValidityKeyMax until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )


    def test_storeObject_SV_overlap_bulk(self):
        # Tests storeObject with overlapping intervals
        # bug #9212 reported 2005-06-24 by Federico
        try:
            folder = self.db.createFolder( "/f1", self.spec )
            folder.setupStorageBuffer()
            folder.storeObject( 300, 400, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 200, 400, self.dummyPayload( 1 ), 0 )
            folder.flushStorageBuffer()
            self.fail( "400 until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )
        try:
            folder = self.db.createFolder( "/f2", self.spec )
            folder.setupStorageBuffer()
            folder.storeObject( 300, 350, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 200, 400, self.dummyPayload( 1 ), 0 )
            folder.flushStorageBuffer()
            self.fail( "non-equal until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )
        try:
            folder = self.db.createFolder( "/f3", self.spec )
            folder.setupStorageBuffer()
            folder.storeObject( 300, cool.ValidityKeyMax, self.dummyPayload(1), 0 )
            folder.storeObject( 200, cool.ValidityKeyMax, self.dummyPayload(1), 0 )
            folder.flushStorageBuffer()
            self.fail( "cool.ValidityKeyMax until exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )


    def test_storeObject_SV_unordered(self):
        # Tests that storing SV objects 'non-ordered', i.e. without increasing
        # 'since' throws exceptions in both bulk and single object mode
        try:
            folder = self.db.createFolder( "/f1", self.spec )
            folder.storeObject( 4, cool.ValidityKeyMax, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 2, 3, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 5, 6, self.dummyPayload( 1 ), 0 )
            self.fail( "exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )
        try:
            folder = self.db.createFolder( "/f2", self.spec )
            folder.setupStorageBuffer()
            folder.storeObject( 4, cool.ValidityKeyMax, self.dummyPayload( 1 ) )
            folder.storeObject( 2, 3, self.dummyPayload( 1 ), 0 )
            folder.storeObject( 5, 6, self.dummyPayload( 1 ), 0 )
            folder.flushStorageBuffer()
            self.fail( "exception expected" )
        except Exception, e:
            self.assert_( 'An exception was raised in C++' == str(e) or
                          'Overlapping intervals not allowed in '
                          'SINGLE_VERSION mode' == str(e) or
                          (str(e).rfind('Unknown C++ exception') >= 0) or
                          '(file "", line 0) Overlapping intervals not allowed'
                          ' in SINGLE_VERSION mode (C++ exception)' )


    def test_browseObjects_channel_range_SV(self):
        folder = self.db.createFolder( "/myfolder",
                                       self.spec,
                                       "my description",
                                       cool.FolderVersioning.SINGLE_VERSION )
        index = 0
        for i in range(5):
            folder.storeObject(  0, 10, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 10, 20, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 20, cool.ValidityKeyMax,
                                self.dummyPayload( index ), i )
            index += 1
        channels = cool.ChannelSelection( 2, 3 )
        objs = folder.browseObjects( 5, 15, channels )
        self.assertEquals( 4, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(6), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(7), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(9), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 3, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(10), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 3, obj.channelId() )


    def test_browseObjects_all_channels_SV(self):
        folder = self.db.createFolder( "/myfolder",
                                       self.spec,
                                       "my description",
                                       cool.FolderVersioning.SINGLE_VERSION )
        index = 0
        for i in range(3):
            folder.storeObject(  0, 10, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 10, 20, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 20, cool.ValidityKeyMax,
                                self.dummyPayload( index ), i )
            index += 1
        objs = folder.browseObjects( 5, 15, cool.ChannelSelection.all() )
        self.assertEquals( 6, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 0, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 0, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(3), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 1, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(4), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 1, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(6), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(7), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 2, obj.channelId() )


    def test_browseObjects_channel_range_MV(self):
        folder = self.db.createFolder( "/myfolder",
                                       self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        index = 0
        for i in range(5):
            folder.storeObject(  0, 10, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 10, 20, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 20, cool.ValidityKeyMax,
                                self.dummyPayload( index ), i )
            index += 1
        channels = cool.ChannelSelection( 2, 3 )
        objs = folder.browseObjects( 5, 15, channels )
        self.assertEquals( 4, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(6), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(7), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(9), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 3, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(10), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 3, obj.channelId() )


    def test_browseObjects_all_channels_MV(self):
        folder = self.db.createFolder( "/myfolder",
                                       self.spec,
                                       "my description",
                                       cool.FolderVersioning.MULTI_VERSION )
        index = 0
        for i in range(3):
            folder.storeObject(  0, 10, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 10, 20, self.dummyPayload( index ), i )
            index += 1
            folder.storeObject( 20, cool.ValidityKeyMax,
                                self.dummyPayload( index ), i )
            index += 1
        objs = folder.browseObjects( 5, 15, cool.ChannelSelection.all() )
        self.assertEquals( 6, objs.size() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(0), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 0, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(1), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 0, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(3), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 1, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(4), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 1, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(6), obj.payload() )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEquals( 2, obj.channelId() )
        obj = getNext( objs )
        self.assertEquals( self.dummyPayload(7), obj.payload() )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEquals( 2, obj.channelId() )


    def test_supportedTypes(self):
        # Tests creation of a folder with as many columns as there are
        # C++ types supported in COOL (using default payload hints)
        # [Test all types in pool/AttributeList/src/AttributePredefinedTypes.cpp]
        types = [ "Bool",
                  # Char,
                  "UChar",
                  "Int16",
                  "UInt16",
                  "Int32",
                  "UInt32",
                  "UInt63",
                  "Int64",
                  # UInt64,
                  "Float",
                  "Double",
                  "String255",
                  "String4k",
                  "String64k",
                  "String16M"  ]
        # Create a folder with 13 payload columns
        spec = cool.RecordSpecification()
        for t in types:
            spec.extend(t,getattr(cool.StorageType,t))
        record = cool.Record( spec )
        payload1 = coral.AttributeList( record.attributeList() )
        payload2 = coral.AttributeList( record.attributeList() )
        folder = self.db.createFolder( "/myfolder", spec )
        self.assert_( folder is not None )
        # Store some data into the IOV table
        payload1[ "Bool" ] = False
        #payload1[ "A_CHAR" ] = 'a' # THIS MUST BE CHARACTER DATA
        payload1[ "UChar" ] = 0
        payload1[ "Int16" ] = -32768 # SHRT_MIN
        payload1[ "UInt16" ] = 0
        payload1[ "Int32" ] = -2147483648 # INT_MIN
        payload1[ "UInt32" ] = 0
        payload1[ "UInt63" ] = 0
        payload1[ "Int64" ] = -9223372036854775808 # sInt64Max
        payload1[ "Float" ] = 0.123456789
        payload1[ "Double" ] = 0.123456789012345678901234567890
        payload1[ "String255" ] = "low values"
        payload1[ "String4k" ] = "low values"
        payload1[ "String64k" ] = "low values"
        payload1[ "String16M" ] = "low values"
        folder.storeObject( 5, 15, payload1, 0 )
        # Store more data into the IOV table
        payload2[ "Bool" ] = True
        #payload2[ "A_CHAR" ] = 'Z' # THIS MUST BE CHARACTER DATA
        payload2[ "UChar" ] = 255 # UCHAR_MAX
        payload2[ "Int16" ] = 32767 # SHRT_MAX
        payload2[ "UInt16" ] = 65535 # USHRT_MAX
        payload2[ "Int32" ] = 2147483647 # INT_MAX
        payload2[ "UInt32" ] = 4294967295 # UINT_MAX
        payload2[ "UInt63" ] = 9223372036854775807 # sInt64Max
        payload2[ "Int64" ] = 9223372036854775807 # sInt64Max
        payload2[ "Float" ] = 0.987654321098765432109876543210
        payload2[ "Double" ] = 0.987654321098765432109876543210
        payload2[ "String255" ] = "HIGH VALUES"
        payload2[ "String4k" ] = "HIGH VALUES"
        payload2[ "String64k" ] = "HIGH VALUES"
        payload2[ "String16M" ] = "HIGH VALUES"
        folder.storeObject( 15, 25, payload2, 0 )
        # Retrieve back the two objects
        obj1 = folder.findObject( 10, 0 )
        obj2 = folder.findObject( 20, 0 )


    def test_extSpec_all_strings(self):
        # (Marco's test)
        # Tests creation of a folder with four string columns
        # of all supported maximum lengths (255, 4K, 64K, 16M)
        hints = dict()
        hints[cool.StorageType.String255] = 255
        hints[cool.StorageType.String4k ] = 4000
        hints[cool.StorageType.String64k] = 65535
        hints[cool.StorageType.String16M] = 16777215
        spec = cool.RecordSpecification()
        for key in hints.keys():
            st = cool.StorageType.storageType(key)
            spec.extend( st.name(), st )
        record = cool.Record( spec )
        payload = coral.AttributeList( record.attributeList() )
        for key, value in hints.items():
            payload[cool.StorageType.storageType(key).name()] = 'x' * value
        folder = self.db.createFolder( '/myfolder', spec )
        self.assert_( folder is not None )
        folder.storeObject( 0, 100, payload, 0 )
        obj = folder.findObject( 10, 0 )
        for key, value in hints.items():
            size = len( obj.payload()[ cool.StorageType.storageType(key).name() ] )
            self.assertEquals( size, value )


    def test_highBytes(self):
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.storeObject( 0, 0x1234567887654321L, self.dummyPayload( 0 ), 0 )
        obj = folder.findObject( 1, 0 )
        self.assertEquals( obj.until() >> 32, 0x12345678L )


    def test_lowBytes(self):
        folder = self.db.createFolder( "/myfolder", self.spec )
        folder.storeObject( 0, 0x1234567887654321L, self.dummyPayload( 0 ), 0 )
        obj = folder.findObject( 1, 0 )
        self.assertEquals( obj.until() & 0xffffffffL , 0x87654321L )


###############################################################################

envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2
         and not sys.argv[1].startswith( 'TestCoolFunctionality' ) ):
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
