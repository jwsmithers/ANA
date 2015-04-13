
from PyCool import cool
from re import match

def expandConnectString( connectString ):
    """
    Expands a connect string.

    This expansion can occur when a connect string without a containing
    '://' or not in the format 'alias/DBNAME' is specified. In this case
    the string is interpreted as a sqlite file name and rewritten to a
    COOL compliant format:

        TEST.db  --> 'sqlite://;schema=TEST.db;dbname=TEST'
        TEST     --> 'sqlite://;schema=TEST;dbname=TEST'

    The filename can have a '.db' suffix which will be stripped for the
    'dbname' part of the connect string. Other suffixes will not be recognized.
    """
    if connectString.find( '://' ) == -1:
        if connectString.endswith( '.db' ):
            base = connectString[:-3]
        elif match("(sqlite_file:)?[a-zA-Z0-9_/.-]+/[A-Z0-9_-]{1,8}",connectString):
            # it is an alias/DBNAME
            return connectString
        else:
            base = connectString
        return ( 'sqlite_file:/%s/%s' ) % ( connectString, base )
    else:
        return connectString


def connect( connectString, verbose = False ):
    """
    Connects to the given database and returns a tuple
        database, connectString
    where 'database' is a cool.IDatabase object and 'connectString' is the
    possibly expanded connectString that 'database' is based on.

    This expansion can occur when a connect string without a containing
    '://' is specified. In this case the string is interpreted as a sqlite
    file name and rewritten to a RAL compliant format:

        TEST.db  --> 'sqlite://;schema=TEST.db;dbname=TEST'
        TEST     --> 'sqlite://;schema=TEST;dbname=TEST'

    The filename can have a '.db' suffix which will be stripped for the
    'dbname' part of the connect string. Other suffixes will not be recognized.

    Note that the COOL database inside the file must have the same name as the
    base of the filename for this shortcut to work. Storing a COOL database
    MYTEST in a file mytest.db will not work.

    Set verbose to True to obtain an error print out.
    """
    connectString = expandConnectString( connectString )
    try:
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        db = dbSvc.openDatabase( connectString, False )
    except Exception, e:
        if 'The database does not exist' in str(e):
            db = dbSvc.createDatabase( connectString )
        else:
            if verbose: print 'Error while connecting:', str(e)
            db = None
    return db, connectString


typeSizes = { cool.StorageType.Bool : 1,
              cool.StorageType.UChar : 1,
              cool.StorageType.Int16 : 2,
              cool.StorageType.UInt16 : 2,
              cool.StorageType.Int32 : 4,
              cool.StorageType.UInt32 : 4,
              cool.StorageType.UInt63 : 8,
              cool.StorageType.Int64 : 8,
              cool.StorageType.Float : 4,
              cool.StorageType.Double : 8,
              cool.StorageType.String255 : 255,
              cool.StorageType.String4k : 4000,
              cool.StorageType.String64k : 65535,
              cool.StorageType.String16M : 16777215,
              cool.StorageType.Blob64k : 65535,
              cool.StorageType.Blob16M : 16777215,
            }

def byteSize( spec ):
    """
    Determines the (effective) byte size of an AttributeListSpecification.
    This does not account for any extra size for the specification's own
    structure but just the byte sizes of the attributes. In other words an
    AttributeListSpecification with a single 'int' fields will report a byte
    size of 4.
    """
    size = 0
    for i in spec:
        size += typeSizes[i.storageType().id()]
    return size



class Info(dict):
    """
    This class extends a dictionary with a format string for its representation.
    It is used as the return value for the inspection commands, such that one
    can both query for the inspected object's information:

        res = tool.ls( '/a' )
        print res['name']

    as well as obtain a standard printout of the information:

        print res

    """
    def __init__( self, format = None ):
        super( Info, self ).__init__()
        self.format = format

    def __str__( self ):
        if self.format is None:
            return super( Info, self ).__str__()
        else:
            return self.format % self


class InfoList(list):
    """
    This class extends a list with a custom string representation.
    """
    def __str__( self ):
        return '\n'.join( [ str(i) for i in self ] )

    def __repr__( self ):
        return str( self )


class PyCoolTool:

    def __init__( self, database ):
        """
        Initialize the object to a given database.

        If 'database' is of type string, it must be a RAL compliant connect
        string or an sqlite filename following the requirements described
        in CoolTool.connect.

        Otherwise it must be a valid cool.IDatabase object.
        """
        if type( database ) == str:
            self.db, connectString = connect( database )
        else:
            self.db = database


    def connectString( self ):
        return self.db.databaseId()


    def less( self, node, header = False ):
        if node is None or node == '':
            raise TypeError( 'No folder specified' )

        res = InfoList()
        if self.db.existsFolder( node ):
            f = self.db.getFolder( node )
            objs = f.browseObjects( cool.ValidityKeyMin,
                                    cool.ValidityKeyMax,
                                    cool.ChannelSelection.all() )
            while objs.goToNext():
                i = Info( '  %(str)s' )
                i['str'] = str(objs.currentRef())
                res.append( i )
        else:
            raise TypeError( "Node '%s' is not a folder" % node )

        return res


    def defaultFolderInfo( self ):
        res = Info( '  %(name)-16s  %(description)-16s'
                    '  %(cardinality)-8s  %(size)-12s' )
        res['name'] = 'Name'
        res['description'] = 'Description'
        res['cardinality'] = 'Count'
        res['size'] = 'Size'
        return res


    def folderInfo( self, node ):
        f = self.db.getFolder( node )
        res = self.defaultFolderInfo()
        res['name'] = node
        res['description'] = f.description()
        res['cardinality'] = f.countObjects( cool.ValidityKeyMin,
                                             cool.ValidityKeyMax,
                                             cool.ChannelSelection.all() )
        res['size'] = res['cardinality'] * byteSize( f.payloadSpecification() )
        return res


    def defaultFolderSetInfo( self ):
        res = Info( '  %(name)-16s  %(description)-16s' )
        res['name'] = 'Name'
        res['description'] = 'Description'
        return res


    def folderSetInfo( self, node ):
        f = self.db.getFolderSet( node )
        res = self.defaultFolderSetInfo()
        res['name'] = node
        res['description'] = f.description()
        return res



    def ls( self, node = '/', header = False ):
        if node == '': node = '/'
        res = InfoList()
        if self.db.existsFolderSet( node ):
            fs = self.db.getFolderSet( node )

            if header and fs.listFolderSets():
                res.append( self.defaultFolderSetInfo() )
            for n in fs.listFolderSets():
                res.append( self.folderSetInfo( n ) )

            if header and fs.listFolders():
                res.append( self.defaultFolderInfo() )
            for n in fs.listFolders():
                res.append( self.folderInfo( n ) )
        else:
            raise TypeError( "Node '%s' is not a folderset" % node )
        return res


    def __str__( self ):
        if self.db is not None:
            return "Connected to '%s'" % self.db.databaseId()
        else:
            return "Not connected"
