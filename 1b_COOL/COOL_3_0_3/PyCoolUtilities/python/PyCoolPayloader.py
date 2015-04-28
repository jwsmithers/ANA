from PyCool import cool, coral
import PyCoolTool
import time

class PyCoolPayloader:

    def __init__( self, connectString, recreateDb = False ):
        connectString = PyCoolTool.expandConnectString( connectString )
        if recreateDb:
            self.db, self.connectString = self.recreateDatabase( connectString )
        else:
            self.db, self.connectString = PyCoolTool.connect( connectString )
        self.rspec = cool.RecordSpecification()
        self.rspec.extend( "I", cool.StorageType.Int32 )
        self.rspec.extend( "D", cool.StorageType.Double )
        self.rspec.extend( "S", cool.StorageType.String4k )
        self.fspecSV = cool.FolderSpecification( cool.FolderVersioning.SINGLE_VERSION, self.rspec )
        self.fspecMV = cool.FolderSpecification( cool.FolderVersioning.MULTI_VERSION, self.rspec )

    def recreateDatabase( self, connectString ):
        self.dbSvc = cool.DatabaseSvcFactory.databaseService()
        self.dbSvc.dropDatabase( connectString )
        return self.dbSvc.createDatabase( connectString ), connectString

    def createPayload( self, objIndex, channel ):
        """
        Creates a payload AttributeList for a given index using the
        class' payload specification.
        """
        payload = cool.Record( self.rspec )
        payload["I"] = objIndex * 1000 + channel
        payload["D"] = objIndex + float(channel) / 1000
        payload["S"] = 'Object %05d, channel %05d' % ( objIndex, channel )
        return payload

    def writeFolder( self, folderName,
                     objectIds = range(10),
                     channels = range(10),
                     description = '',
                     mode = cool.FolderVersioning.SINGLE_VERSION,
                     append = False ):
        if append:
            f = self.db.getFolder( folderName )
        else:
            if mode == cool.FolderVersioning.SINGLE_VERSION:
                f = self.db.createFolder( folderName, self.fspecSV, description )
            else:
                f = self.db.createFolder( folderName, self.fspecMV, description )
        f.setupStorageBuffer()
        for ch in channels:
            for i in objectIds:
                f.storeObject( i, i+1, self.createPayload( i, ch ), ch )
        f.flushStorageBuffer()
        return f

    def validateFolder( self, folderName,
                        objectIds = range(10),
                        channels = range(10),
                        description = '',
                        mode = cool.FolderVersioning.SINGLE_VERSION,
                        tag = '',
                        tagDescription = '' ):
        """
        Returns a pair 'result, message' describing the outcome of a folder
        validation. E.g.
            res, msg = payloader.validateFolder( folderName )
            if not res:
                print 'Validation failed, because: ' + msg
        """
        return self.__validateFolder( folderName, objectIds, channels, description, mode, tag, tagDescription )
        ###try:
        ###    return self.__validateFolder( folderName, objectIds, channels, description, mode, tag, tagDescription )
        ###except:
        ###    print "WARNING! Exception caught, will sleep 1s and retry"
        ###    time.sleep(1) # workaround for ORA-01466 (bug #87935)
        ###    return self.__validateFolder( folderName, objectIds, channels, description, mode, tag, tagDescription )

    def __validateFolder( self, folderName,
                          objectIds = range(10),
                          channels = range(10),
                          description = '',
                          mode = cool.FolderVersioning.SINGLE_VERSION,
                          tag = '',
                          tagDescription = '' ):
        # check folder existance
        if not self.db.existsFolder( folderName ):
            return False, "Folder '%s' does not exist" % folderName
        f = self.db.getFolder( folderName )
        # check versioning mode
        if mode != f.versioningMode():
            return False, ( "Folder versioning mode was '%s', "
                            "expected '%s'" ) % ( f.versioningMode(), mode )
        # check folder description
        if description != f.description():
            return False, ( "Folder description was '%s', "
                            "expected '%s'" ) % ( f.description(),
                                                   description )
        # check channel existance
        dbChannels = f.listChannels()
        for ch in channels:
            if ch not in dbChannels:
                return False, 'Channel id %d does not exist' % ch
        # check tag existance
        if not self.isHeadTag( tag ):
            if not self.db.existsTag( tag ):
                return False, "Tag '%s' does not exist" % tag
            if not tagDescription == f.tagDescription( tag ):
                msg = "Wrong tag description, was '%s', expected '%s'" % (
                        f.tagDescription( tag ), tagDescription )
                return False, msg
        # check object content
        f.setPrefetchAll( False )
        for ch in channels:
            objs = f.browseObjects( cool.ValidityKeyMin,
                                    cool.ValidityKeyMax,
                                    cool.ChannelSelection( ch ),
                                    tag )
            # check objects count
            if objs.size() < len(objectIds):
                msg = ( 'Wrong object count in channel %d, was %d, '
                        'expected >= %d' ) % ( ch, objs.size(), len(objectIds) )
                return False, msg
            # check object (meta)data
            for i in objectIds:
                objs.goToNext()
                obj = objs.currentRef().clone()
                # check since
                expectedSince = i
                if obj.since() != expectedSince:
                    return False, ( 'Object (%d,%d) since was %s, '
                                    'expected %s' ) % ( i, ch,
                                                        obj.since(),
                                                        expectedSince )
                # check until
                expectedUntil = i+1
                if obj.until() != expectedUntil:
                    return False, ( 'Object (%d,%d) until was %s, '
                                    'expected %s' ) % ( i, ch,
                                                        obj.until(),
                                                        expectedUntil )
                expectedPayload = self.createPayload( i, ch )
                # Marco: work-around for bug #20780
                payloads_equal = obj.payload()['I'] == expectedPayload['I'] \
                                 and int(obj.payload()['D']*1e14) == int(expectedPayload['D']*1e14) \
                                 and obj.payload()['S'] == expectedPayload['S']
                if not payloads_equal:
                    msg = 'Object (%d,%d) not equal, was %s, expected %s' % (
                                   i, ch,
                                   obj.payload(), expectedPayload )
                    return False, msg
            objs.close()
        return True, 'Validation successful'

    def isHeadTag( self, tag ):
        if tag == '': return True
        if tag.upper() == 'HEAD': return True
        return False

