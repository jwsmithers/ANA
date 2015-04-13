from PyCool import cool
import PyCoolTool
import time
import logging

log = logging.getLogger( __name__ )
log.setLevel( logging.INFO )

handler = logging.StreamHandler()
format = "%(levelname)s:%(name)s: %(message)s"
handler.setFormatter( logging.Formatter( format ) )
log.addHandler( handler )


class CopyError( Exception ):
    """
    Generic copy error class.
    """


class Selection:
    """
    The Selection class groups all selection criteria which define the scope
    of a copy.
    """

    def __init__( self,
                  nodeName = '/',
                  since = cool.ValidityKeyMin,
                  until = cool.ValidityKeyMax,
                  channels = cool.ChannelSelection.all(),
                  tags = []
                   ):
        """
        Creates a Selection object with the following fields:
            nodeName : name of a folder or folderset
            since    : beginning of IOV, long or cool.ValidiyKey
            until    : end of IOV, long or cool.ValidiyKey (NB: the end point is *included* in selections)
            channels : a channel range as specified through cool.ChannelSelection
            tags     : a list of tags (an empty list means the HEAD is selected)
        """
        if nodeName != '/':
            self.nodeName = nodeName.rstrip( '/' )
        else:
            self.nodeName = nodeName
        self.since = since
        self.until = until
        self.channels = channels
        if tags is None:
            self.tags = []
        elif not isinstance( tags, list ):
            self.tags = [ tags ]
        else:
            self.tags = tags
        self.sortTags()


    def hasNonHeadTags( self ):
        for t in self.tags:
            if not isHeadTag( t ): return True
        return False


    def hasHeadTag( self ):
        for t in self.tags:
            if isHeadTag( t ): return True
        return False


    def sortTags( self ):
        """
        Makes sure the given tag list contains only one 'HEAD' tag and that
        it is at the end.
        """
        hasHeadTag = False
        tags = []
        for t in self.tags:
            if isHeadTag( t ):
                hasHeadTag = True
            else:
                tags.append( t )
        if hasHeadTag:
            tags.append( 'HEAD' )
        self.tags = tags


    def isParent( self, nodeName ):
        """
        Tests is the given nodeName is a parent folderset of the selection's nodeName.
        """
        if len(nodeName) >= len(self.nodeName):
            return False
        if nodeName.endswith( '/' ):
            return self.nodeName.startswith( nodeName )
        else:
            return self.nodeName.startswith( nodeName + '/' )


    def extendIov( self, since, until ):
        """
        Extends the selection's IOV range to the given since, until. The IOV
        range is only changed if an end point lies outside the current range.
        """
        if since < self.since:
            self.since = since
        if until > self.until:
            self.until = until


    def extendChannels( self, channels ):
        """
        Extends the selection's channel range to the given channels. The channel
        range is only changed if an end point lies outside the current range.
        """
        firstChannel = self.channels.firstChannel()
        lastChannel = self.channels.lastChannel()
        if channels.firstChannel() < firstChannel:
            firstChannel = channels.firstChannel()
        if channels.lastChannel() > lastChannel:
            lastChannel = channels.lastChannel()
        self.channels = cool.ChannelSelection( firstChannel, lastChannel )

    def extendTagList( self, tagList):
        """
        Extends the selection's tag list. This prevent some data loss and
        breaks in relations between tags.
        """
        for tag in tagList:
            if tag not in self.tags:
                self.tags.append(tag)
        self.sortTags()


    def __str__( self ):
        """
        Returns a printable representation of a Selection object.
        """
        s = "{ nodeName : '%s', channels : %s, iov : [%s,%s], tags : %s }" % (
            self.nodeName, self.channels, self.since, self.until, self.tags )
        return s


    def __repr__( self ):
        """
        Returns a printable representation of a Selection object.
        """
        s = "{ nodeName : '%s', channels : %s, iov : [%s,%s], tags : %s }" % (
            self.nodeName, self.channels, self.since, self.until, self.tags )
        return s


    def __cmp__( self, other ):
        """
        Compare Selection objects via their nodeName.
        """
        lhs_count = self.nodeName.count( '/' )
        rhs_count = other.nodeName.count( '/' )
        if lhs_count != rhs_count:
            # paths have diff depth -- short paths are higher in the hierarchy
            return lhs_count - rhs_count
        else:
            # paths have equal depth -- sort alphabetically (recursing through
            # path segments)
            lhs_path = self.nodeName[1:].split( '/' ) # skip leading '/'
            rhs_path = other.nodeName[1:].split( '/' )
            for i in range( lhs_count ):
                if lhs_path[i] != rhs_path[i]:
                    return cmp( lhs_path[i], rhs_path[i] )
            # paths are equal
            return 0



class PyCoolCopy:

    #===========================================================================#
    # Marco Clemencic suggests to merge the node hierarchy (which is implemented
    # in a partialy recursive way) with the tag hierarchy. This would be much
    # cleaner and faster. However, this would be a major modification of
    # PyCoolCopy.
    #===========================================================================#

    def __init__( self, source ):
        """
        Initialize the object to a given database.

        If 'source' is of type string, it must be a RAL compliant connect
        string or an sqlite filename following the requirements described
        in CoolTool.connect.

        Otherwise it must be a valid cool.IDatabase object.
        """
        if source is None:
            raise TypeError( 'Source database is nil' )
        elif type( source ) == str:
            self.sourceDb, connectString = PyCoolTool.connect( source )
        else:
            self.sourceDb = source


    def __str__( self ):
        """
        Returns a printable representation of a PyCoolCopy object.
        """
        return self.sourceDb.databaseId()

    def restoreTagRelation(self, target, nodePath, ancestorTag, nodeTag):
        """
        Recursively copy the tag relation from the ancestor tag to the folder tag.
        """
        if ancestorTag == nodeTag:
            # There is no relation to copy
            return

        parentPath = str.join('/', nodePath.split('/')[:-1])
        if parentPath == '':
            parentPath = '/'

        # Retrieve the node from the target database
        if target.existsFolder(nodePath):
            node = target.getFolder(nodePath)
        else:
            node = target.getFolderSet(nodePath)

        if nodePath != '/':
            # Retrieve the parent node from the source database
            parentNode = self.sourceDb.getFolderSet(parentPath)
            # Retrieve the parent tag from the source database
            parentTag = parentNode.resolveTag(ancestorTag)
            try:
                # check if the relation already exists
                relatedTag = node.resolveTag(parentTag)
            except:
                # an exception occured. As we have no way to check,
                # we suppose this is because no relation was found...
                relatedTag = ''

            if relatedTag != nodeTag:
                # No relation between parentTag and nodeTag was found.
                # We have to create it.
                node.createTagRelation(parentTag, nodeTag)
                log.debug("Relation between parentTag:'%s' and nodeTag:'%s' copied"%(parentTag, nodeTag))
            else:
                # Relation already exists: there is nothing else to do
                # in this branch of the tag tree.
                log.debug("Relation between parentTag:'%s' and nodeTag:'%s' already exist"%(parentTag, nodeTag))

            if parentTag == ancestorTag:
                # We have reached the top of the tag tree
                log.debug("We have reached the top of the tag hierarchy: ancestorTag = %s"%parentTag)
                return
            else:
                # Do the same operation on the parent node
                log.debug("Start restoring relation between ancestor tag %s and parentTag %s in node %s"%(ancestorTag, parentTag, parentPath))
                self.restoreTagRelation(target, parentPath, ancestorTag, parentTag)
        else:
            # We have reached the top of the database tree
            return


    def append(self, target, selections):
        """
        Copies the list of selection object to the HEAD of the target database. The
        target database may already exist.
        Each selection object can contain only one tag, but not necessarily the HEAD.
        """
        log.info( "source: %s" % str(self) )

        if type( target ) == str:
            log.info( "target: %s" % target )

            try:
                targetDb, target = PyCoolTool.connect( target )
            except Exception, e:
                raise CopyError( "Target database '%s' could not be "
                                 "created: %s"
                                 % ( target, str(e) ) )
        else:
            log.info( "target: %s" % target.databaseId() )
            targetDb = target

        # optionally promote the selection to a list
        if not isinstance( selections, list ): selections = [ selections ]

        validateSelections( selections )

        log.info( "Copying selections '%s'" % selections )

        for selection in selections:
            if len(selection.tags) > 1:
                raise CopyError("Selection object '%s' has more than one tag. "
                                "This is not allowed by the 'PyCoolCopy.append()' function."
                                %str(selection))

        for selection in selections:
            log.info( "Copying selection '%s'" % selection )
            self.copyParentFolderSets( targetDb, selection.nodeName )

            if self.sourceDb.existsFolder( selection.nodeName ):
                log.debug( "Copying folder '%s'" % selection.nodeName )
                self.copyFolder( targetDb, selection, copy_tags = False )
            elif self.sourceDb.existsFolderSet( selection.nodeName ):
                log.debug( "Copying folderset '%s'" % selection.nodeName )
                self.copyFolderSet( targetDb, selection, copy_tags = False )
            else:
                raise CopyError( "Node '%s' does not exist." %selection.nodeName )



    def copy( self, target, selections ):
        """
        Copies the specified selections from the database associated with this
        object to the given target database.

        'target' is a RAL compatible connection string or a cool.IDatabase
        object. In case of a connection string, the target database must not
        exists -- copy will attempt to create it and fail if it exists. In case
        of a cool.IDatabase object, the target database must not contain any
        data. (A check is made if any nodes other than '/' exist on the target
        database.)

        'selections' is list of Selection objects or a single seelction object.
        """
        log.info( "source: %s" % str(self) )

        if type( target ) == str:
            log.info( "target: %s" % target )

            try:
                targetDb, target = PyCoolTool.connect( target )
            except Exception, e:
                raise CopyError( "Target database '%s' could not be "
                                 "created: %s"
                                 % ( target, str(e) ) )
        else:
            log.info( "target: %s" % target.databaseId() )
            targetDb = target

        if not isEmpty( targetDb ):
            raise CopyError( 'Target database contains data. Copy aborted.' )
            # optionally allow non-interfering copies to proceed
            # to be decided/implemented

        # optionally promote the selection to a list
        if not isinstance( selections, list ): selections = [ selections ]

        validateSelections( selections )

        log.info( "Copying selections '%s'" % selections )

        for selection in selections:
            log.info( "Copying selection '%s'" % selection )
            self.copyParentFolderSets( targetDb, selection.nodeName )

            if self.sourceDb.existsFolder( selection.nodeName ):
                log.debug( "Copying folder '%s'" % selection.nodeName )
                self.copyFolder( targetDb, selection )
            elif self.sourceDb.existsFolderSet( selection.nodeName ):
                log.debug( "Copying folderset '%s'" % selection.nodeName )
                self.copyFolderSet( targetDb, selection )
            else:
                raise CopyError( "Node '%s' does not exist." %
                                 selection.nodeName )


    def copyParentFolderSets( self, targetDb, nodeName ):
        path = nodeName.split( '/' )
        for i in range(1,len(path)-1):
            fsname = '/' + '/'.join(path[1:i+1])
            selection = Selection( fsname )
            self.copyFolderSet( targetDb, selection, recursive = False )


    def copyFolderSet( self, targetDb, selection, recursive = True, copy_tags = True ):
        """
        Copies the specified selection to the target database, assuming
        selection.nodeName to be a folder set. This method will copy
        encountered nested foldersets recursively.
        """
        log.debug( "copyFolderSet '%s'" % selection.nodeName )
        fs = self.sourceDb.getFolderSet( selection.nodeName )

        if ( fs.fullPath() != '/'
             and not targetDb.existsFolderSet( fs.fullPath() ) ):
            log.debug( "Creating folderset '%s'" % fs.fullPath() )
            createParents = False
            targetDb.createFolderSet( fs.fullPath(),
                                      fs.description(),
                                      createParents )

        if recursive:
            log.debug( "Recursive copy" )
            for folderset in fs.listFolderSets():
                log.debug( "Copying folderset '%s'" % folderset )
                selection.nodeName = folderset
                self.copyFolderSet( targetDb, selection, copy_tags=copy_tags )
            for folder in fs.listFolders():
                log.debug( "Copying folder '%s'" % folder )
                selection.nodeName = folder
                self.copyFolder( targetDb, selection, copy_tags=copy_tags )


    def copyFolder( self, targetDb, selection, copy_tags = True ):
        """
        Copies the specified selection to the target database, assuming
        selection.nodeName to be a folder.
        """

        if targetDb.existsFolder( selection.nodeName ):
            log.info( "Folder '%s' already exists. Not copied."
                         % selection.nodeName )
            return

        ### AV 2007.01.12 - The following section was marked to be deleted in
        ### 1.4.0 (aka 2.0.0), but tests fail if it is removed: keep it in!!!
        # To be removed?? -- begin
        if selection.tags == [] or ( len(selection.tags) == 1
                                     and isHeadTag( selection.tags[0] ) ):
            log.debug( "No tags selected" )
            tags = [ '' ]
        else:
            log.debug( "Tags selected for copying: %s" % str(selection.tags) )
            tags = selection.tags
            for tag in tags:
                if not self.sourceDb.existsTag( tag ):
                    raise CopyError( "Tag '%s' does not exist." % tag )
        # To be removed?? -- end

        sourceFolder = self.sourceDb.getFolder( selection.nodeName )
        targetMode = sourceFolder.versioningMode()
        createParents = False
        log.debug( "Creating target folder '%s'" % selection.nodeName )
        targetFolder = targetDb.createFolder( selection.nodeName,
                                              sourceFolder.payloadSpecification(),
                                              sourceFolder.description(),
                                              targetMode,
                                              createParents )
        if selection.tags == [] or ( len(selection.tags) == 1 and isHeadTag( selection.tags[0] ) ):
            log.debug( "No tags selected" )
            tags = { 'HEAD': '' }
        else:
            # Here we are insuring that we don't copy twice the same data
            # by keeping only tags of the given folder, and not ancestor tags.
            tags = {}
            for tag in selection.tags:
                try:
                    newTag = sourceFolder.resolveTag(tag)
                except:
                    log.info( "Skipping tag '%s' for folder '%s' (not defined)"
                          % ( tag, selection.nodeName ) )
                else:
                    log.debug( "Ancestor Tag %s resolved to local tag %s" % (tag, newTag))
                    if tags.has_key(newTag):
                        tags[newTag].append(tag)
                    else:
                        tags[newTag] = [tag]
            log.debug( "Tags selected for copying: %s" % str(tags.keys()) )

        headTag_found = False
        sourceFolder.setPrefetchAll( False )
        for tag in tags:

            if isHeadTag( tag ):
                headTag_found = True
                log.debug( "Delaying HEAD tag copy to folder '%s'" % selection.nodeName )
                continue
            else:
                log.info( "Copying tag '%s' of folder '%s'"
                          % ( tag, selection.nodeName ) )

            objs = sourceFolder.browseObjects( selection.since,
                                               selection.until,
                                               selection.channels,
                                               tag )

            targetFolder.setupStorageBuffer()
            while objs.goToNext():
                obj = objs.currentRef()
                targetFolder.storeObject( obj.since(),
                                          obj.until(),
                                          obj.payload(),
                                          obj.channelId() )
            targetFolder.flushStorageBuffer()

            objs.close()

            if copy_tags:
                # tag the head in the target db
                targetFolder.tagCurrentHead( tag, sourceFolder.tagDescription( tag ) )
                # restore the tag relations in the target db
                for ancestorTag in tags[tag]:
                    log.debug( "restoring tag relation between ancestor tag %s and folder tag %s"
                               %(ancestorTag, tag))
                    self.restoreTagRelation(targetDb, selection.nodeName, ancestorTag, tag)
            else:
                log.debug("Tag relations not copied.")

        # Copy the HEAD tag at the end
        if headTag_found:
            log.info( "Copying HEAD tag to folder '%s'" % selection.nodeName )
            objs = sourceFolder.browseObjects( selection.since,
                                               selection.until,
                                               selection.channels,
                                               '' )
            targetFolder.setupStorageBuffer()
            while objs.goToNext():
                obj = objs.currentRef()
                targetFolder.storeObject( obj.since(),
                                          obj.until(),
                                          obj.payload(),
                                          obj.channelId() )
            targetFolder.flushStorageBuffer()
            objs.close()



def validateSelections( selections ):
    """
    Validates a list of selections for copying and returns a validated list for
    subsequent copying. The list modified in place, therefore it is not returned.

    This list will be sorted such that deepest paths are copied first and IOV ranges
    of subfolders include selections of their parent folder sets.

    A CopyError exception will be raised if the list cannot be validated.
    """
    if len(selections) < 2:
        return True

    # sort in reverse order to ensure the 'most specific' paths come first
    selections.sort( reverse = True )

    for i in range(len(selections)):
        for s in selections[i+1:]:
            if selections[i].isParent( s.nodeName ):
                selections[i].extendIov( s.since, s.until )
                selections[i].extendChannels( s.channels )
                selections[i].extendTagList(s.tags)

    return True


def isHeadTag( tag ):
    """
    Checks if the given tag is the HEAD tag (or a synonym for it).
    """
    if type(tag) is not str: return False
    if tag == '': return True
    if tag.upper() == 'HEAD': return True
    return False


def isEmpty( db ):
    """
    Tests if the given database is empty: Any folder(set) besides the
    root folderset '/' is an indication the given database is not empty.
    """
    if len( db.listAllNodes() ) > 1: return False
    else: return True
    ###try:
    ###    if len( db.listAllNodes() ) > 1: return False
    ###    else: return True
    ###except:
    ###    print "WARNING! Exception caught, will sleep 1s and retry"
    ###    time.sleep(1) # workaround for ORA-01466 (bug #87935)
    ###    if len( db.listAllNodes() ) > 1: return False
    ###    else: return True


def dbExists( connectString ):
    """
    Tests if a database exists (can be opened) for the given connect string.
    """
    dbExists = False
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    try:
        dbSvc.openDatabase( connectString )
        dbExists = True
    except Exception, e:
        pass
    return dbExists


def verbose():
    """
    Set the module's logging level to verbose.
    """
    log.setLevel( logging.INFO )


def debug():
    """
    Set the module's logging level to debug.
    """
    log.setLevel( logging.DEBUG )


def silent():
    """
    Silence the module's logging (e.g. for unit tests or batch processing).
    """
    log.setLevel( logging.ERROR )


def copy( sourceDb, targetDb,
          nodeName = '/',
          since = cool.ValidityKeyMin,
          until = cool.ValidityKeyMax,
          channels = cool.ChannelSelection.all(),
          tags = []
          ):
    """
    Copies the specified selection from the given source to the target database.

    'sourceDb' and 'targetDb' are RAL compatible connection strings or
    cool.IDatabase objects.

    If 'targetDb' is a connection string, the database must not exists
    -- 'copy' will attempt to create it and fail if it exists. In case
    'targetDb' is a cool.IDatabase object, database must not contain any
    data. (A check is made if any nodes other than '/' exist on the target
    database.)

    The selection is specified through the following arguments:
        nodeName : name of a folder or folderset
        since    : beginning of IOV, long or cool.ValidiyKey
        until    : end of IOV, long or cool.ValidiyKey (NB: the end point is *included* in selections)
        channels : a channel range as specified through cool.ChannelSelection
        tag      : a tag name
    """
    try:
        selection = Selection( nodeName, since, until, channels, tags )
        PyCoolCopy( sourceDb ).copy( targetDb, selection )
    except Exception, details:
        print 'Copy failed with error: %s' % str(details)



def append( sourceDb, targetDb,
            nodeName = '/',
            since = cool.ValidityKeyMin,
            until = cool.ValidityKeyMax,
            channels = cool.ChannelSelection.all(),
            tag = ''
          ):
    """
    Appends the specified selection from the given source to the target database.

    'sourceDb' and 'targetDb' are RAL compatible connection strings or
    cool.IDatabase objects.

    The selection is specified through the following arguments:
        nodeName : name of a folder or folderset
        since    : beginning of IOV, long or cool.ValidiyKey
        until    : end of IOV, long or cool.ValidiyKey (NB: the end point is *included* in selections)
        channels : a channel range as specified through cool.ChannelSelection
        tag      : a tag name
    """
    try:
        selection = Selection( nodeName, since, until, channels, [tag] )
        PyCoolCopy( sourceDb ).append( targetDb, selection )
    except Exception, details:
        print 'Appending failed with error: %s' % str(details)


if __name__ == '__main__':
    source = 'sqlite://;schema=../db/CondDBConditions_v1r8.sqlite;dbname=LHCBCOND'
    target = 'sqlite://;schema=../db/test-copy.sqlite;dbname=LHCBCOND'
    copy(source, target, '/Conditions/Hcal', tags=['Conditions_v1r7'])
    append(source, target, '/Conditions/Ecal', tag='Conditions_v1r8')



