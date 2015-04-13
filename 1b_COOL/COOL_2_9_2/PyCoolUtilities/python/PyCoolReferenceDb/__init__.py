#!/usr/bin/env python

###print 'DEBUG: Import os'
import os

###print 'DEBUG: Import sys'
import sys

###print 'DEBUG: Import time'
import time

###print 'DEBUG: Import unittest'
import unittest

###print 'DEBUG: Import CoolAuthentication'
import CoolAuthentication

###print 'DEBUG: Import CoolDescribeTable'
import CoolDescribeTable

###print 'DEBUG: Import CoolQueryManager'
import CoolQueryManager

##############################################################################

class ReferenceDbMgr:

    #-------------------------------------------------------------------------

    def __init__(self, referenceSchemaVersion="2.8.0"):
        #print 'DEBUG: *START* ReferenceDbMgr.__init__()'

        if referenceSchemaVersion == "1.3.0" :
            self.refSchemaVersion200 = False
            self.refSchemaVersion220 = False
            self.refSchemaVersion280 = False
            self.refSchemaVersion290 = False
        elif referenceSchemaVersion == "2.0.0" :
            self.refSchemaVersion200 = True
            self.refSchemaVersion220 = False
            self.refSchemaVersion280 = False
            self.refSchemaVersion290 = False
        elif referenceSchemaVersion == "2.2.0" :
            self.refSchemaVersion200 = True
            self.refSchemaVersion220 = True
            self.refSchemaVersion280 = False
            self.refSchemaVersion290 = False
        elif referenceSchemaVersion == "2.8.0" :
            self.refSchemaVersion200 = True
            self.refSchemaVersion220 = True
            self.refSchemaVersion280 = True
            self.refSchemaVersion290 = False
        elif referenceSchemaVersion == "2.9.0" :
            self.refSchemaVersion200 = True
            self.refSchemaVersion220 = True
            self.refSchemaVersion280 = True
            self.refSchemaVersion290 = True
        else :
            print 'ERROR! Unsupported schema version "' + \
                  referenceSchemaVersion + '"' + \
                  ' (supported versions: "1.3.0", "2.0.0", "2.2.0", "2.8.0", "2.9.0"'
            sys.exit(-1)

        if self.refSchemaVersion290:
            print 'DEBUG: Create ReferenceDbMgr for 2.9.0 reference schema'
        elif self.refSchemaVersion280:
            print 'DEBUG: Create ReferenceDbMgr for 2.8.0 reference schema'
        elif self.refSchemaVersion220:
            print 'DEBUG: Create ReferenceDbMgr for 2.2.0 reference schema'
        elif self.refSchemaVersion200:
            print 'DEBUG: Create ReferenceDbMgr for 2.0.0 reference schema'
        else:
            print 'DEBUG: Create ReferenceDbMgr for 1.3.0 reference schema'

        global cool
        #print 'DEBUG: Import cool'
        from PyCool import cool

        #print 'DEBUG: Load database service'
        self.app = cool.Application()
        self.dbSvc = self.app.databaseService()

        self.svcVersion = self.dbSvc.serviceVersion()
        print 'DEBUG: Database service loaded from software release', \
              self.svcVersion

        if   ( self.svcVersion == "1.2.9" ):
            print 'ERROR! Obsolete COOL database service version',\
                  self.svcVersion, 'is not supported by PyCoolReferenceDb!'
            sys.exit(-1)
        elif ( self.svcVersion == "1.3.0" or \
               self.svcVersion == "1.3.1" or \
               self.svcVersion == "1.3.2" or \
               self.svcVersion == "1.3.3" or \
               self.svcVersion == "1.3.4" ):
            self.svcVersion2xx = False
            self.svcVersion22x = False
            self.svcVersion28x = False
            self.svcVersion29x = False
        elif ( self.svcVersion == "2.0.0" or \
               self.svcVersion == "2.1.0" or \
               self.svcVersion == "2.1.1" ):
            self.svcVersion2xx = True
            self.svcVersion22x = False
            self.svcVersion28x = False
            self.svcVersion29x = False
        elif ( self.svcVersion == "2.2.0" or \
               self.svcVersion == "2.2.1" or \
               self.svcVersion == "2.2.2" or \
               self.svcVersion == "2.3.0" or \
               self.svcVersion == "2.3.1" or \
               self.svcVersion == "2.4.0" or \
               self.svcVersion == "2.5.0" or \
               self.svcVersion == "2.6.0" or \
               self.svcVersion == "2.7.0" ):
            self.svcVersion2xx = True
            self.svcVersion22x = True
            self.svcVersion28x = False
            self.svcVersion29x = False
        elif ( self.svcVersion == "2.8.0" or \
               self.svcVersion == "2.8.1" or \
               self.svcVersion == "2.8.2" or \
               self.svcVersion == "2.8.3" or \
               self.svcVersion == "2.8.4" or \
               self.svcVersion == "2.8.5" or \
               self.svcVersion == "2.8.6" or \
               self.svcVersion == "2.8.7" or \
               self.svcVersion == "2.8.8" or \
               self.svcVersion == "2.8.9" or \
               self.svcVersion == "2.8.10" or \
               self.svcVersion == "2.8.11" or \
               self.svcVersion == "2.8.12" or \
               self.svcVersion == "2.8.13" or \
               self.svcVersion == "2.8.14" or \
               self.svcVersion == "2.8.15" or \
               self.svcVersion == "2.8.16" or \
               self.svcVersion == "2.8.17" or \
               self.svcVersion == "2.8.18" or \
               self.svcVersion == "2.8.19" or \
               self.svcVersion == "2.8.20" ):
            self.svcVersion2xx = True
            self.svcVersion22x = True
            self.svcVersion28x = True
            self.svcVersion29x = False
        elif ( self.svcVersion == "2.9.0" or \
               self.svcVersion == "2.9.1" or \
               self.svcVersion == "2.9.2" or \
               self.svcVersion == "3.0.0" ):
            self.svcVersion2xx = True
            self.svcVersion22x = True
            self.svcVersion28x = True
            self.svcVersion29x = True
        else :
            print 'PANIC! Unknown software release', self.svcVersion
            sys.exit(-1)

        if self.refSchemaVersion200 and not self.svcVersion2xx :
            print 'ERROR: Cannot manage 2.0.0 reference schema',\
                  'using older software release', self.svcVersion
            sys.exit(-1)

        if self.refSchemaVersion220 and not self.svcVersion22x :
            print 'ERROR: Cannot manage 2.2.0 reference schema',\
                  'using older software release', self.svcVersion
            sys.exit(-1)

        if self.refSchemaVersion280 and not self.svcVersion28x :
            print 'ERROR: Cannot manage 2.8.0 reference schema',\
                  'using older software release', self.svcVersion
            sys.exit(-1)

        if self.refSchemaVersion290 and not self.svcVersion29x :
            print 'ERROR: Cannot manage 2.9.0 reference schema',\
                  'using older software release', self.svcVersion
            sys.exit(-1)

        global coral
        #print 'DEBUG: Import coral'
        from PyCool import coral
        if ( self.svcVersion22x ):
            connSvc = self.app.connectionSvc()
            connSvcConf = connSvc.configuration()
            connSvcConf.setConnectionRetrialPeriod(1)
            connSvcConf.setConnectionRetrialTimeOut(3)

        if ( self.svcVersion2xx ):
            #print 'DEBUG: Import is_64bits'
            from PyCool import is_64bits
            self.is_64bits = is_64bits()
        else:
            self.is_64bits = False

        #print 'DEBUG: Define reference payload spec with all supported types'
        self.referenceSpec = self.referencePayloadSpec()

        #print 'DEBUG: Define simple payload spec'
        self.simpleSpec = self.simplePayloadSpec()

        #print 'DEBUG: Define lowercase payload spec'
        self.lowercaseSpec = self.lowercasePayloadSpec()

        #print 'DEBUG: Define uchar payload spec
        self.ucharSpec = self.ucharPayloadSpec()

        #print 'DEBUG: Define SV and MV simple folder spec with payload table'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            self.simpleSpecPayloadTableSV = self.simpleFolderSpecPayloadTable( cool.FolderVersioning.SINGLE_VERSION )
            self.simpleSpecPayloadTableMV = self.simpleFolderSpecPayloadTable( cool.FolderVersioning.MULTI_VERSION )

        #print 'DEBUG: Define SV and MV simple folder spec with vector payload'
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            self.simpleSpecVectorTableSV = self.simpleFolderSpecVectorTable( cool.FolderVersioning.SINGLE_VERSION )
            self.simpleSpecVectorTableMV = self.simpleFolderSpecVectorTable( cool.FolderVersioning.MULTI_VERSION )

        #print 'DEBUG: **END** ReferenceDbMgr.__init__()'

    #-------------------------------------------------------------------------

    def __del__(self):
        #print 'DEBUG: *START* ReferenceDbMgr.__del__()'
        #print 'DEBUG: **END** ReferenceDbMgr.__del__()'
        pass

    #-------------------------------------------------------------------------

    def dropReferenceDb(self,connectString):
        #print 'DEBUG: Drop reference database'
        #print 'DEBUG: -> db ID:', connectString
        self.dbSvc.dropDatabase( connectString )

    #-------------------------------------------------------------------------

    def createReferenceDb(self,connectString):
        if self.refSchemaVersion290:
            print 'DEBUG: Create 2.9.0 reference database'
        elif self.refSchemaVersion280:
            print 'DEBUG: Create 2.8.0 reference database'
        elif self.refSchemaVersion220:
            print 'DEBUG: Create 2.2.0 reference database'
        elif self.refSchemaVersion200:
            print 'DEBUG: Create 2.0.0 reference database'
        else:
            print 'DEBUG: Create 1.3.0 reference database'

        print 'DEBUG: -> db ID:', connectString
        if self.svcVersion22x:
            dbProp = CoolAuthentication.getDbIdProperties \
                     ( connectString, True ) # R/W
            dbReplica = CoolAuthentication.coralReplica( dbProp )
            print 'DEBUG: -> db replica (R/W):', dbReplica
        db = self.dbSvc.createDatabase( connectString )

        #print 'DEBUG: Database created'
        #print 'DEBUG: -> db ID:', db.databaseId()
        ###print 'DEBUG: -> db attributes:', db.databaseAttributes()

        #print 'DEBUG: Create folder sets'
        sref = db.createFolderSet( '/ReferenceSpec' )
        ssim = db.createFolderSet( '/SimpleSpec' )
        ssv = db.createFolderSet( '/SimpleSpec/SV' )
        smv = db.createFolderSet( '/SimpleSpec/MV' )
        slc = db.createFolderSet( '/LowercaseSpec' )
        suc = db.createFolderSet( '/UcharSpec' )
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            spt = db.createFolderSet( '/SimpleSpecPayloadTable' )
            sptsv = db.createFolderSet( '/SimpleSpecPayloadTable/PTSV' )
            sptsv = db.createFolderSet( '/SimpleSpecPayloadTable/PTMV' )

        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            svt = db.createFolderSet( '/SimpleSpecVectorTable' )
            svtsv = db.createFolderSet( '/SimpleSpecVectorTable/PTSV' )
            svtmv = db.createFolderSet( '/SimpleSpecVectorTable/PTMV' )

        #print 'DEBUG: Create SV folder with reference payload spec'
        fref = db.createFolder( '/ReferenceSpec/ref', self.referenceSpec, '',
                                cool.FolderVersioning.SINGLE_VERSION )
        fref.storeObject(  5, 15, self.referencePayloadLow(), 0 )
        fref.storeObject( 15, 25, self.referencePayloadHigh(), 0 )
        fref.storeObject( 25, 35, self.referencePayloadNull(), 0 )
        #print 'DEBUG: reference payload low:', self.referencePayloadLow()
        #print 'DEBUG: reference payload high:', self.referencePayloadHigh()
        #print 'DEBUG: reference payload null:', self.referencePayloadNull()

        #print 'DEBUG: Create SV folder with simple payload spec'
        fsv = db.createFolder( '/SimpleSpec/SV/sv1', self.simpleSpec, '',
                               cool.FolderVersioning.SINGLE_VERSION )

        #print 'DEBUG: Create MV folder #1 with simple payload spec'
        fmv1 = db.createFolder( '/SimpleSpec/MV/mv1', self.simpleSpec, '',
                                cool.FolderVersioning.MULTI_VERSION )

        #print 'DEBUG: Create MV folder #2 with simple payload spec'
        fmv2 = db.createFolder( '/SimpleSpec/MV/mv2', self.simpleSpec, '',
                                cool.FolderVersioning.MULTI_VERSION )

        #print 'DEBUG: Create SV folder with lowercase payload spec'
        flc = db.createFolder( '/LowercaseSpec/sv', self.lowercaseSpec, '',
                               cool.FolderVersioning.SINGLE_VERSION )

        #print 'DEBUG: Create SV folder with uchar payload spec'
        fuc = db.createFolder( '/UcharSpec/uc', self.ucharSpec, '',
                               cool.FolderVersioning.SINGLE_VERSION )

        #print 'DEBUG: Pre-create some channels of SV folder'
        if self.refSchemaVersion200:
            fsv.createChannel(  1, "Channel01", "Channel #01" )
            fsv.createChannel( 10, "Channel10", "Channel #10" )

        #print 'DEBUG: Populate SV folder'
        inf = cool.ValidityKeyMax
        fsv.storeObject(  0, inf, self.simplePayload( 1 ), 0 )
        fsv.storeObject(  0, inf, self.simplePayload( 1 ), 1 )
        fsv.storeObject(  0, inf, self.simplePayload( 1 ), 2 )
        fsv.storeObject( 10,  15, self.simplePayload( 2 ), 0 )
        fsv.storeObject( 15,  20, self.simplePayload( 3 ), 0 )
        fsv.storeObject( 20, inf, self.simplePayload( 4 ), 0 )

        #print 'DEBUG: Post-create some channels of SV folder'
        if self.refSchemaVersion200:
            fsv.createChannel( 20, "Channel20", "Channel #20" )

        #print 'DEBUG: Pre-create some channels of MV folder #1'
        if self.refSchemaVersion200:
            fmv1.createChannel(  1, "Channel01", "Channel #01" )
            fmv1.createChannel( 10, "Channel10", "Channel #10" )

        #print 'DEBUG: Store data into MV folder #1 and tag the HEAD'
        fmv1.storeObject(  0, 20, self.simplePayload( 110 ), 1 )
        fmv1.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
        fmv1.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
        fmv1.storeObject(  0, 20, self.simplePayload( 210 ), 2 )
        fmv1.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
        fmv1.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
        fmv1.tagCurrentHead( "Tag A1", "My tag" )
        fmv1.storeObject(  5, 15, self.simplePayload( 130 ), 1 )
        fmv1.storeObject(  5, 15, self.simplePayload( 230 ), 2 )
        fmv1.tagCurrentHead( "Tag B1", "My tag" )

        #print 'DEBUG: Post-create some channels of MV folder #1'
        if self.refSchemaVersion200:
            fmv1.createChannel( 20, "Channel20", "Channel #20" )

        #print 'DEBUG: Store data into MV folder #2 with user tags
        fmv2.storeObject(  0, 20, self.simplePayload( 110 ), 1, "UserTag A2" )
        fmv2.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
        fmv2.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
        fmv2.storeObject(  0, 20, self.simplePayload( 210 ), 2, "UserTag A2" )
        fmv2.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
        fmv2.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
        fmv2.storeObject(  5, 15, self.simplePayload( 130 ), 1, "UserTag A2" )
        fmv2.storeObject(  5, 15, self.simplePayload( 230 ), 2, "UserTag A2" )

        #print 'DEBUG: Populate SV lowercase folder'
        flc.storeObject( 0, 10, self.lowercasePayload( 1 ), 0 )

        #print 'DEBUG: Populate SV uchar folder'
        for i in range( 256 ) :
            fuc.storeObject(  i, i+1, self.ucharPayload( i ), 0 )

        #print 'DEBUG: Create HVS tag relations'
        fmv1.createTagRelation( "HVS tag", "Tag A1" )
        fmv2.createTagRelation( "HVS tag", "UserTag A2" )

        #print 'DEBUG: Create SV folder with payload table'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            fptsv = db.createFolder( '/SimpleSpecPayloadTable/PTSV/ptsv1',
                                     self.simpleSpecPayloadTableSV, '' )

        #print 'DEBUG: Create MV folders with payload table'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            ###outLvl = self.app.outputLevel()
            ###self.app.setOutputLevel( 1 )
            fptmv1 = db.createFolder( '/SimpleSpecPayloadTable/PTMV/ptmv1',
                                      self.simpleSpecPayloadTableMV, '' )
            ###self.app.setOutputLevel( outLvl )
            fptmv2 = db.createFolder( '/SimpleSpecPayloadTable/PTMV/ptmv2',
                                      self.simpleSpecPayloadTableMV, '' )

        #print 'DEBUG: Populate SV folder with payload table'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            fptsv.storeObject(  0, inf, self.simplePayload( 1 ), 0 )
            fptsv.storeObject(  0, inf, self.simplePayload( 1 ), 1 )
            fptsv.storeObject(  0, inf, self.simplePayload( 1 ), 2 )
            fptsv.storeObject( 10,  15, self.simplePayload( 2 ), 0 )
            fptsv.storeObject( 15,  20, self.simplePayload( 3 ), 0 )
            fptsv.storeObject( 20, inf, self.simplePayload( 4 ), 0 )

        #print 'DEBUG: Populate MV folder1 with payload table and tag the HEAD'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            fptmv1.storeObject(  0, 20, self.simplePayload( 110 ), 1 )
            fptmv1.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
            fptmv1.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
            fptmv1.storeObject(  0, 20, self.simplePayload( 210 ), 2 )
            fptmv1.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
            fptmv1.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
            fptmv1.tagCurrentHead( "Tag A1PT", "My tag" )
            fptmv1.storeObject(  5, 15, self.simplePayload( 130 ), 1 )
            fptmv1.storeObject(  5, 15, self.simplePayload( 230 ), 2 )
            fptmv1.tagCurrentHead( "Tag B1PT", "My tag" )

        #print 'DEBUG: Populate MV folder2 with payload table with user tags'
        if self.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            fptmv2.storeObject(  0, 20, self.simplePayload( 110 ), 1, "UserTag A2PT" )
            fptmv2.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
            fptmv2.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
            fptmv2.storeObject(  0, 20, self.simplePayload( 210 ), 2, "UserTag A2PT" )
            fptmv2.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
            fptmv2.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
            fptmv2.storeObject(  5, 15, self.simplePayload( 130 ), 1, "UserTag A2PT" )
            fptmv2.storeObject(  5, 15, self.simplePayload( 230 ), 2, "UserTag A2PT" )

        # print 'DEBUG: Creating Vector Tables
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtsv = db.createFolder( '/SimpleSpecVectorTable/PTSV/ptsv1',
                                     self.simpleSpecVectorTableSV, '' )
            fvtsv1 = db.createFolder( '/SimpleSpecVectorTable/PTSV/ptsv2',
                                     self.simpleSpecVectorTableSV, '' )

            fvtmv1 = db.createFolder( '/SimpleSpecVectorTable/PTMV/ptmv1',
                                      self.simpleSpecVectorTableMV, '' )
            fvtmv2 = db.createFolder( '/SimpleSpecVectorTable/PTMV/ptmv2',
                                      self.simpleSpecVectorTableMV, '' )
            fvtmv3 = db.createFolder( '/SimpleSpecVectorTable/PTMV/ptmv3',
                                      self.simpleSpecVectorTableMV, '' )

        #print 'DEBUG: Populate SV folder with payload table'
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtsv.storeObject(  0, inf, self.simplePayload( 1 ), 0 )
            fvtsv.storeObject(  0, inf, self.simplePayload( 1 ), 1 )
            fvtsv.storeObject(  0, inf, self.simplePayload( 1 ), 2 )
            fvtsv.storeObject( 10,  15, self.simplePayload( 2 ), 0 )
            fvtsv.storeObject( 15,  20, self.simplePayload( 3 ), 0 )
            fvtsv.storeObject( 20, inf, self.simplePayload( 4 ), 0 )

        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtsv1.storeObject(  0, inf, self.simplePayloadVector( 1, 1 ), 0 )
            fvtsv1.storeObject(  0, inf, self.simplePayloadVector( 1, 2 ), 1 )
            fvtsv1.storeObject(  0, inf, self.simplePayloadVector( 1, 3 ), 2 )
            fvtsv1.storeObject( 10,  15, self.simplePayloadVector( 2, 4 ), 0 )
            fvtsv1.storeObject( 15,  20, self.simplePayloadVector( 3, 5 ), 0 )
            fvtsv1.storeObject( 20, inf, self.simplePayloadVector( 4, 6 ), 0 )

        #print 'DEBUG: Populate MV folder1 with payload table and tag the HEAD'
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtmv1.storeObject(  0, 20, self.simplePayload( 110 ), 1 )
            fvtmv1.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
            fvtmv1.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
            fvtmv1.storeObject(  0, 20, self.simplePayload( 210 ), 2 )
            fvtmv1.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
            fvtmv1.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
            fvtmv1.tagCurrentHead( "Tag A1VT", "My tag" )
            fvtmv1.storeObject(  5, 15, self.simplePayload( 130 ), 1 )
            fvtmv1.storeObject(  5, 15, self.simplePayload( 230 ), 2 )
            fvtmv1.tagCurrentHead( "Tag B1VT", "My tag" )

        #print 'DEBUG: Populate MV folder2 with payload table with user tags'
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtmv2.storeObject(  0, 20, self.simplePayload( 110 ), 1, "UserTag A2VT" )
            fvtmv2.storeObject(  0,  5, self.simplePayload( 121 ), 1 )
            fvtmv2.storeObject( 15, 20, self.simplePayload( 122 ), 1 )
            fvtmv2.storeObject(  0, 20, self.simplePayload( 210 ), 2, "UserTag A2VT" )
            fvtmv2.storeObject(  0,  5, self.simplePayload( 221 ), 2 )
            fvtmv2.storeObject( 15, 20, self.simplePayload( 222 ), 2 )
            fvtmv2.storeObject(  5, 15, self.simplePayload( 130 ), 1, "UserTag A2VT" )
            fvtmv2.storeObject(  5, 15, self.simplePayload( 230 ), 2, "UserTag A2VT" )

        #print 'DEBUG: Populate MV folder2 with payload table with user tags'
        if self.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            fvtmv3.storeObject(  0, 20, self.simplePayloadVector( 110, 1 ), 1, "UserTag A3VT" )
            fvtmv3.storeObject(  0,  5, self.simplePayloadVector( 121, 2 ), 1 )
            fvtmv3.storeObject( 15, 20, self.simplePayloadVector( 122, 3 ), 1 )
            fvtmv3.storeObject(  0, 20, self.simplePayloadVector( 210, 4 ), 2, "UserTag A3VT" )
            fvtmv3.storeObject(  0,  5, self.simplePayloadVector( 221, 5 ), 2 )
            fvtmv3.storeObject( 15, 20, self.simplePayloadVector( 222, 6 ), 2 )
            fvtmv3.storeObject(  5, 15, self.simplePayloadVector( 130, 7 ), 1, "UserTag A3VT" )
            fvtmv3.storeObject(  5, 15, self.simplePayloadVector( 230, 8 ), 2, "UserTag A3VT" )


    #-------------------------------------------------------------------------

    def referencePayloadSpec(self):
        if self.svcVersion2xx:
            spec = cool.RecordSpecification()
            spec.extend( "A_IOBJ", cool.StorageType.UInt32 )
            spec.extend( "A_BOOL", cool.StorageType.Bool )
            ###spec.extend( "A_CHAR", cool.StorageType.Char )
            spec.extend( "A_UCHAR", cool.StorageType.UChar )
            spec.extend( "A_INT16", cool.StorageType.Int16 )
            spec.extend( "A_UINT16", cool.StorageType.UInt16 )
            spec.extend( "A_INT32", cool.StorageType.Int32 )
            spec.extend( "A_UINT32", cool.StorageType.UInt32 )
            if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
                spec.extend( "A_LONG32", cool.StorageType.Int32 )
                spec.extend( "A_ULONG32", cool.StorageType.UInt32 )
            spec.extend( "A_UINT63", cool.StorageType.UInt63 )
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                spec.extend( "A_INT64", cool.StorageType.Int64 )
            ###spec.extend( "A_UINT64", cool.StorageType.UInt64 )
            spec.extend( "A_FLOAT", cool.StorageType.Float )
            spec.extend( "A_DOUBLE", cool.StorageType.Double )
            ###spec.extend( "A_LONGDOUBLE", cool.StorageType.LongDouble" )
            spec.extend( "A_STRING255", cool.StorageType.String255 )
            spec.extend( "A_STRING4K", cool.StorageType.String4k )
            spec.extend( "A_STRING64K", cool.StorageType.String64k )
            spec.extend( "A_STRING16M", cool.StorageType.String16M )
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                spec.extend( "A_BLOB64K", cool.StorageType.Blob64k )
            if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
                spec.extend( "A_BLOB16M", cool.StorageType.Blob16M )
            return spec
        else:
            eSpec = cool.ExtendedAttributeListSpecification()
            eSpec.push_back( "A_IOBJ", "unsigned long" )
            eSpec.push_back( "A_BOOL", "bool" )
            ###eSpec.push_back( "A_CHAR", "char" )
            eSpec.push_back( "A_UCHAR", "unsigned char" )
            eSpec.push_back( "A_INT16", "short" )
            eSpec.push_back( "A_UINT16", "unsigned short" )
            eSpec.push_back( "A_INT32", "int" )
            eSpec.push_back( "A_UINT32", "unsigned int" )
            if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
                if not self.is_64bits :
                    eSpec.push_back( "A_LONG32", "long" )
                    eSpec.push_back( "A_ULONG32", "unsigned long" )
                else :
                    eSpec.push_back( "A_LONG32", "int" )
                    eSpec.push_back( "A_ULONG32", "unsigned int" )
            eSpec.push_back( "A_UINT63", "unsigned long long" )
            #if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            #    spec.extend( "A_INT64", "???" )
            ###eSpec.push_back( "A_UINT64", "__unsigned long long__" )
            eSpec.push_back( "A_FLOAT", "float" )
            eSpec.push_back( "A_DOUBLE", "double" )
            ###eSpec.push_back( "A_LONGDOUBLE", "__long double__" )
            eSpec.push_back( "A_STRING255", "string", \
                             cool.PredefinedStorageHints.STRING_MAXSIZE_255 )
            eSpec.push_back( "A_STRING4K", "string", \
                             cool.PredefinedStorageHints.STRING_MAXSIZE_4K )
            eSpec.push_back( "A_STRING64K", "string", \
                             cool.PredefinedStorageHints.STRING_MAXSIZE_64K )
            eSpec.push_back( "A_STRING16M", "string", \
                             cool.PredefinedStorageHints.STRING_MAXSIZE_16M )
            #if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            #    spec.extend( "A_BLOB64K", "???" )
            #if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
            #    spec.extend( "A_BLOB16M", "???" )
            return eSpec

    #-------------------------------------------------------------------------

    def referencePayloadLow(self, hackBug30036=False):
        if self.svcVersion2xx:
            data = cool.Record( self.referenceSpec )
        else:
            eSpec = self.referenceSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
        data['A_IOBJ'] = 1
        data['A_BOOL'] = False
        data['A_UCHAR'] = 'a'
        data['A_INT16'] = -32868
        data['A_UINT16'] = 0
        data['A_INT32'] = -2147483648
        data['A_UINT32'] = 0
        if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
            data['A_LONG32'] = -2147483648
            data['A_ULONG32'] = 0
        data['A_UINT63'] = 0
        if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            data['A_INT64'] = -9223372036854775808
        data['A_FLOAT'] = 0.123456789012345678901234567890
        data['A_DOUBLE'] = 0.123456789012345678901234567890
        data['A_STRING255'] = ""
        data['A_STRING4K'] = "low values"
        data['A_STRING64K'] = "low values"
        data['A_STRING16M'] = ""
        if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            # Work around for SQLiteAccess bug #30036: expect a different value
            # on read-back (NULL instead of 0 bytes) if bug has not been fixed
            if hackBug30036 and not self.refSchemaVersion220:
                data['A_BLOB64K'] = None
            else:
                data['A_BLOB64K'].write( "" )
        if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
            data['A_BLOB16M'].write( "" )
        return data

    #-------------------------------------------------------------------------

    def referencePayloadHigh(self):
        if self.svcVersion2xx:
            data = cool.Record( self.referenceSpec )
        else:
            eSpec = self.referenceSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
        data['A_IOBJ'] = 2
        data['A_BOOL'] = True
        data['A_UCHAR'] = 'z'
        data['A_INT16'] = 32867
        data['A_UINT16'] = 65535
        data['A_INT32'] = 2147483647
        data['A_UINT32'] = 4294967295
        if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
            data['A_LONG32'] = 2147483647
            data['A_ULONG32'] = 4294967295
        data['A_UINT63'] = 9223372036854775807
        if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            data['A_INT64'] = 9223372036854775807
        data['A_FLOAT'] = 0.987654321098765432109876543210
        data['A_DOUBLE'] = 0.987654321098765432109876543210
        #data['A_STRING255'] = "HIGH VALUES"
        #data['A_STRING4K'] = "HIGH VALUES"
        #data['A_STRING64K'] = "HIGH VALUES"
        #data['A_STRING16M'] = "HIGH VALUES"
        data['A_STRING255'] = "".zfill(255)
        data['A_STRING4K'] = "".zfill(4000)
        data['A_STRING64K'] = "".zfill(64000)
        data['A_STRING16M'] = "".zfill(64001)
        if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            #data['A_BLOB64K'].write( "HIGH VALUES" )
            data['A_BLOB64K'].write( data['A_STRING64K'] )
        if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
            #data['A_BLOB16M'].write( "HIGH VALUES" )
            data['A_BLOB16M'].write( data['A_STRING16M'] )
        return data

    #-------------------------------------------------------------------------

    def referencePayloadNull(self):
        if self.svcVersion2xx:
            data = cool.Record( self.referenceSpec )
            data['A_IOBJ'] = 3
            data['A_BOOL'] = None
            data['A_UCHAR'] = None
            data['A_INT16'] = None
            data['A_UINT16'] = None
            data['A_INT32'] = None
            data['A_UINT32'] = None
            if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
                data['A_LONG32'] = None
                data['A_ULONG32'] = None
            data['A_UINT63'] = None
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                data['A_INT64'] = None
            data['A_FLOAT'] = None
            data['A_DOUBLE'] = None
            data['A_STRING255'] = None
            data['A_STRING4K'] = None
            data['A_STRING64K'] = None
            data['A_STRING16M'] = None
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                data['A_BLOB64K'] = None
            if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
                data['A_BLOB16M'] = None
            pass
        else:
            eSpec = self.referenceSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
            data['A_IOBJ'] = 3
            data.attribute('A_BOOL').setNull(True)
            data.attribute('A_UCHAR').setNull(True)
            data.attribute('A_INT16').setNull(True)
            data.attribute('A_UINT16').setNull(True)
            data.attribute('A_INT32').setNull(True)
            data.attribute('A_UINT32').setNull(True)
            if not self.refSchemaVersion200: # OLD 1.3.0 SCHEMA ONLY
                data.attribute('A_LONG32').setNull(True)
                data.attribute('A_ULONG32').setNull(True)
            data.attribute('A_UINT63').setNull(True)
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                data.attribute('A_INT64').setNull(True)
            data.attribute('A_FLOAT').setNull(True)
            data.attribute('A_DOUBLE').setNull(True)
            data.attribute('A_STRING255').setNull(True)
            data.attribute('A_STRING4K').setNull(True)
            data.attribute('A_STRING64K').setNull(True)
            data.attribute('A_STRING16M').setNull(True)
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                data.attribute('A_BLOB64K').setNull(True)
            if self.refSchemaVersion220: # NEW 2.2.0 SCHEMA ONLY
                data.attribute('A_BLOB16M').setNull(True)
        return data

    #-------------------------------------------------------------------------

    def simplePayloadSpec(self):
        if self.svcVersion2xx:
            spec = cool.RecordSpecification()
            spec.extend( "A_IOBJ", cool.StorageType.UInt32 )
            return spec
        else:
            eSpec = cool.ExtendedAttributeListSpecification()
            eSpec.push_back( "A_IOBJ", "unsigned long" )
            return eSpec

    #-------------------------------------------------------------------------

    def simplePayload(self,iobj):
        if self.svcVersion2xx:
            data = cool.Record( self.simpleSpec )
        else:
            eSpec = self.simpleSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
        data['A_IOBJ'] = iobj
        return data

    #-------------------------------------------------------------------------

    def simplePayloadVector(self, iobj, count):
        v = cool.IRecordVector()
        for i in range(1,count) :
            dataPtr = cool.PyCool.Helpers.IRecordPtr( self.simpleSpec )
            # Work around protected non-const IRecord::operator[] (bug #103844)
            ###dataPtr.get()['A_IOBJ'] = iobj * 100 + i # FAILS ON ROOT6 beta2
            dataPtr.get().field('A_IOBJ').setValue('unsigned int')(iobj*100+i)
            v.push_back( dataPtr )
        return v

    #-------------------------------------------------------------------------

    def lowercasePayloadSpec(self):
        if self.svcVersion2xx:
            spec = cool.RecordSpecification()
            spec.extend( "AIOBJ1", cool.StorageType.UInt32 )
            spec.extend( "aiobj2", cool.StorageType.UInt32 )
            spec.extend( "Aiobj3", cool.StorageType.UInt32 )
            spec.extend( "aIOBJ4", cool.StorageType.UInt32 )
            return spec
        else:
            eSpec = cool.ExtendedAttributeListSpecification()
            eSpec.push_back( "AIOBJ1", "unsigned long" )
            eSpec.push_back( "aiobj2", "unsigned long" )
            eSpec.push_back( "Aiobj3", "unsigned long" )
            eSpec.push_back( "aIOBJ4", "unsigned long" )
            return eSpec

    #-------------------------------------------------------------------------

    def lowercasePayload(self,iobj):
        if self.svcVersion2xx:
            data = cool.Record( self.lowercaseSpec )
        else:
            eSpec = self.lowercaseSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
        data['AIOBJ1'] = iobj
        data['aiobj2'] = iobj
        data['Aiobj3'] = iobj
        data['aIOBJ4'] = iobj
        return data

    #-------------------------------------------------------------------------

    def ucharPayloadSpec(self):
        if self.svcVersion2xx:
            spec = cool.RecordSpecification()
            spec.extend( "A_UCHAR", cool.StorageType.UChar )
            spec.extend( "A_STRING1", cool.StorageType.String255 )
            if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
                spec.extend( "A_BLOB1", cool.StorageType.Blob64k )
            return spec
        else:
            eSpec = cool.ExtendedAttributeListSpecification()
            eSpec.push_back( "A_UCHAR", "unsigned char" )
            eSpec.push_back( "A_STRING1", "string", \
                             cool.PredefinedStorageHints.STRING_MAXSIZE_255 )
            #if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
            #    spec.extend( "A_BLOB1", "???" )
            return eSpec

    #-------------------------------------------------------------------------

    def ucharPayload(self,iobj):
        if self.svcVersion2xx:
            data = cool.Record( self.ucharSpec )
        else:
            eSpec = self.ucharSpec
            spec = coral.AttributeListSpecification\
                   ( eSpec.attributeListSpecification() )
            data = coral.AttributeList( spec )
        ###data['A_UCHAR'] = iobj
        data['A_UCHAR'] = chr(iobj) # Workarkound for ROOT6 bug #103304
        # -- 1 character, difficult to print out
	# -- NB This would be 0 characters for iobj=0 ('\x00'!)	    
	if iobj>0:
	    data['A_STRING1'] = data['A_UCHAR'].__str__()
	else:
	    data['A_STRING1'] = '' # Fix bug #92111 ('\0' fails validation) 
	if self.refSchemaVersion200: # NEW 2.0.0 SCHEMA ONLY
	    data['A_BLOB1'].write( data['A_UCHAR'].__str__() )
        # -- Several characters using quotes
        #data['A_STRING1'] = data['A_UCHAR'].__repr__()
        #data['A_BLOB1'].write( data['A_UCHAR'].__repr__() )
        return data

    #-------------------------------------------------------------------------

    def simpleFolderSpecPayloadTable(self,mode):
        spec = cool.FolderSpecification( mode, self.simplePayloadSpec(), True )
        return spec

    #-------------------------------------------------------------------------

    def simpleFolderSpecVectorTable(self,mode):
        spec = cool.FolderSpecification( mode, self.simplePayloadSpec(),
                                         cool.PayloadMode.VECTORPAYLOAD )
        return spec

    #-------------------------------------------------------------------------

    def getNext(self,objs):
        if self.svcVersion2xx:
            objs.goToNext()
            #print 'Current ref:', objs.currentRef()
            obj = cool.PyCool.Helpers.IObjectPtr( objs.currentRef().clone() )
            #print 'Clone:', objs.currentRef()
            return obj
        else:
            return objs.next()

##############################################################################

class TestReferenceDb1RO( unittest.TestCase ):

    #print 'DEBUG: *START* TestReferenceDb1RO CLASS INITIALIZATION'
    iTest=0
    nTest=0
    refSchemaVersion="2.8.0"
    connectString=""
    mgr=0
    db=0
    dbSchemaVersion200=True
    invalidateCacheUrl=""
    #print 'DEBUG: **END** TestReferenceDb1RO CLASS INITIALIZATION'

    #-------------------------------------------------------------------------

    def __init__(self, methodName='runTest'):
        #print 'DEBUG: *START* TestReferenceDb1RO.__init__()'

        TestReferenceDb1RO.iTest = TestReferenceDb1RO.iTest+1
        self.iTest = TestReferenceDb1RO.iTest
        #print 'DEBUG: RO instance number=', self.iTest
        TestReferenceDb1RO.nTest = TestReferenceDb1RO.nTest+1
        #print 'DEBUG: Total # RO instances=', self.nTest

        if TestReferenceDb1RO.iTest == 1 :
            if TestReferenceDb1RO.refSchemaVersion == "2.9.0" :
                print 'DEBUG: Create TestReferenceDb1RO',\
                      'for 2.9.0 reference schema'
            elif TestReferenceDb1RO.refSchemaVersion == "2.8.0" :
                print 'DEBUG: Create TestReferenceDb1RO',\
                      'for 2.8.0 reference schema'
            elif TestReferenceDb1RO.refSchemaVersion == "2.2.0" :
                print 'DEBUG: Create TestReferenceDb1RO',\
                      'for 2.2.0 reference schema'
            elif TestReferenceDb1RO.refSchemaVersion == "2.0.0" :
                print 'DEBUG: Create TestReferenceDb1RO',\
                      'for 2.0.0 reference schema'
            elif TestReferenceDb1RO.refSchemaVersion == "1.3.0" :
                print 'DEBUG: Create TestReferenceDb1RO',\
                      'for 1.3.0 reference schema'
            else:
                print 'ERROR: Cannot create TestReferenceDb1RO for unknown',\
                      TestReferenceDb1RO.refSchemaVersion, 'reference schema'
            #print 'DEBUG: Instantiate a ReferenceDbMgr'
            TestReferenceDb1RO.mgr = ReferenceDbMgr\
                                    (TestReferenceDb1RO.refSchemaVersion)

        ### See http://www.byteofpython.info/read/inheritance.html
        unittest.TestCase.__init__(self, methodName)

        #print 'DEBUG: **END** TestReferenceDb1RO.__init__()'

    #-------------------------------------------------------------------------

    def __del__(self):
        #print 'DEBUG: *START* TestReferenceDb1RO.__del__()'
        #print 'DEBUG: RO instance number=', self.iTest
        TestReferenceDb1RO.nTest = TestReferenceDb1RO.nTest-1
        #print 'DEBUG: Total # RO instances=', self.nTest
        #print 'DEBUG: **END** TestReferenceDb1RO.__del__()'
        pass

    #-------------------------------------------------------------------------

    def setUp(self):
        #print 'DEBUG: SetUp'
        pass

    #-------------------------------------------------------------------------

    def tearDown(self):
        #print 'DEBUG: TearDown'
        pass

    #-------------------------------------------------------------------------

    # Strictly needed only if you want to instantiate this class
    def runTest(self):
        #print 'DEBUG: RunTests'
        pass

    #-------------------------------------------------------------------------

    def abort(self,msg):
        #print 'DEBUG: abort'
        print 'ERROR (abort):',msg
        ###sys.exit(-1)

    #-------------------------------------------------------------------------

    def test_1RO_00_initialise(self):
        print ''
        print 'DEBUG: (TestReferenceDb1RO) **********************************'
        if TestReferenceDb1RO.connectString == "":
            print 'ERROR! TestReferenceDb1RO.connectString is not set!'
            sys.exit(-1)
        connectString = TestReferenceDb1RO.connectString
        print 'DEBUG: (TestReferenceDb1RO) Open reference database'
        print 'DEBUG: (TestReferenceDb1RO) -> db ID:', connectString
        if self.mgr.svcVersion22x:
            ###dbProp = CoolAuthentication.getDbIdProperties \
            ###         ( connectString, True ) # R/W
            ###dbReplica = CoolAuthentication.coralReplica( dbProp )
            ###print 'DEBUG: -> db replica (R/W):', dbReplica
            dbProp = CoolAuthentication.getDbIdProperties \
                     ( connectString, False ) # R/O
            dbReplica = CoolAuthentication.coralReplica( dbProp )
            print 'DEBUG: -> db replica (R/O):', dbReplica
        readOnly = True
        TestReferenceDb1RO.db = TestReferenceDb1RO.mgr.dbSvc.openDatabase\
                                ( connectString, readOnly )
        print 'DEBUG: Database opened'
        #print 'DEBUG: -> db ID:', TestReferenceDb1RO.db.databaseId()
        dbAttributes = TestReferenceDb1RO.db.databaseAttributes()
        #print 'DEBUG: -> db attributes:', dbAttributes
        dbSchemaVersion = dbAttributes["SCHEMA_VERSION"]
        print 'DEBUG: -> db schema version:', dbSchemaVersion
        if   ( dbSchemaVersion == "1.3.0" ):
            TestReferenceDb1RO.dbSchemaVersion200 = False
            if self.mgr.refSchemaVersion290 :
                print 'ERROR: TestReferenceDb1RO (2.9.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion280 :
                print 'ERROR: TestReferenceDb1RO (2.8.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion220 :
                print 'ERROR: TestReferenceDb1RO (2.2.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion200 :
                print 'ERROR: TestReferenceDb1RO (2.0.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            else :
                print 'DEBUG: Test 1.3.0 reference schema on a 1.3.0 db',\
                      '(R/O test)'
        elif ( dbSchemaVersion == "2.0.0" ):
            TestReferenceDb1RO.dbSchemaVersion200 = True
            if self.mgr.refSchemaVersion280 :
                print 'DEBUG: Test 2.8.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            elif self.mgr.refSchemaVersion220 :
                print 'DEBUG: Test 2.2.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            elif self.mgr.refSchemaVersion200 :
                print 'DEBUG: Test 2.0.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            else:
                print 'DEBUG: Test 1.3.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
        else :
            print 'ERROR: unknown database schema', dbSchemaVersion
            sys.exit(-1)
        if self.invalidateCacheUrl != "":
            print 'DEBUG: Refresh Frontier cache for', self.invalidateCacheUrl
            connSvc = self.mgr.app.connectionSvc()
            webCacheCtl = connSvc.webCacheControl()
            webCacheCtl.refreshSchemaInfo( self.invalidateCacheUrl )

        if ( self.db.existsFolderSet( '/TestRW' ) ):
            print 'ERROR: R/O test cannot be executed',\
                  'after R/W test has been executed'
            sys.exit(-1)

    #-------------------------------------------------------------------------

    def test_1RO_99_finalise(self):
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        print ''
        print 'DEBUG: (TestReferenceDb1RO) Close reference database'
        print 'DEBUG: (TestReferenceDb1RO) **********************************'
        TestReferenceDb1RO.db.closeDatabase()

    #-------------------------------------------------------------------------

    def test_1RO_01_NodeHierarchy(self):
        #print 'DEBUG: Test01'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        self.assert_( self.db.existsFolderSet( '/' ) )
        fsroot = self.db.getFolderSet( '/' )
        ###outLvl = self.mgr.app.outputLevel()
        ###self.mgr.app.setOutputLevel( 1 )
        folders=fsroot.listFolders()
        foldersets=fsroot.listFolderSets()
        ###self.mgr.app.setOutputLevel( outLvl )
        self.assertEquals( folders.size(), 0 )
        if self.mgr.refSchemaVersion290 : # NEW 2.8.0 SCHEMA ONLY
            self.assertEquals( foldersets.size(), 6 )
        elif self.mgr.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            self.assertEquals( foldersets.size(), 5 )
        else:
            self.assertEquals( foldersets.size(), 4 )
        self.assert_( self.db.existsFolderSet( '/LowercaseSpec' ) )
        self.assert_( self.db.existsFolderSet( '/ReferenceSpec' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec' ) )
        self.assert_( self.db.existsFolderSet( '/UcharSpec' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec/SV' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec/MV' ) )
        self.assert_( self.db.existsFolder( '/ReferenceSpec/ref' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/SV/sv1' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv1' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv2' ) )
        self.assert_( self.db.existsFolder( '/LowercaseSpec/sv' ) )
        if self.mgr.refSchemaVersion280 : # NEW 2.8.0 SCHEMA ONLY
            self.assert_( self.db.existsFolderSet( '/SimpleSpecPayloadTable' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpecPayloadTable/PTSV' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpecPayloadTable/PTMV' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecPayloadTable/PTSV/ptsv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecPayloadTable/PTMV/ptmv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecPayloadTable/PTMV/ptmv2' ) )
        if self.mgr.refSchemaVersion290 : # NEW 2.9.0 SCHEMA ONLY
            self.assert_( self.db.existsFolderSet( '/SimpleSpecVectorTable' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpecVectorTable/PTSV' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpecVectorTable/PTMV' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecVectorTable/PTSV/ptsv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecVectorTable/PTSV/ptsv2' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecVectorTable/PTMV/ptmv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecVectorTable/PTMV/ptmv2' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpecVectorTable/PTMV/ptmv3' ) )
        # The following are created in the RW test
        self.assert_( not self.db.existsFolderSet( '/TestRW' ) )
        self.assert_( not self.db.existsFolder( '/SimpleSpec/SV/sv2' ) )
        self.assert_( not self.db.existsFolder( '/SimpleSpec/MV/mv3' ) )
        self.assert_( not self.db.existsFolder( '/SimpleSpec/MV/mv4' ) )
        self.assert_( not self.db.existsFolder( '/LongSpec' ) )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution.
    # Test method to compare two Records deeply
    # (standard comparison only compares their pointers).
    def assertEqualsAL( self, lhs, rhs, skipA_UCHAR=True, skipA_BLOB64K=True ):
        self.assertEquals( lhs.size(), rhs.size() )
        ##print 'DEBUG: lhs:', lhs
        ##print 'DEBUG: rhs:', rhs
        for i in lhs:
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-type:', type(lhs[i]), 'rhs-type:', type(rhs[i])
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-value:', lhs[i].__repr__(),\
            #      'rhs-value:', rhs[i].__repr__()
            if type(lhs[i]) == float:
                self.assertAlmostEqual( lhs[i], rhs[i], 6 )
            elif i == 'A_UCHAR':
                # A_UCHAR comparison fails for Frontier - see CORAL bug #22307
                if skipA_UCHAR : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            elif i == 'A_BLOB64K' or i == 'A_BLOB16M' :
                # Blobs used to fail for Frontier (bug #22203) - now fixed
                if skipA_BLOB64K : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            else:
                self.assertEquals( lhs[i], rhs[i] )

    #-------------------------------------------------------------------------

    # compares to payload vectors deeply (using assertEqualsAL)
    def assertEqualsVector( self, lhs, rhsI, skipA_UCHAR=True, skipA_BLOB64K=True ):
        print 'DEBUG: comparing payload vectors'

        for no in range(0,lhs.size()):
            try :
                r = rhsI.__iter__().next()
            except StopIteration:
                raise Exception( "Payload Vector size not equal" )

            self.assertEqualsAL( lhs.at( no ).get() , r.get(), skipA_UCHAR, skipA_BLOB64K )

        try :
            r = rhsI.__iter__().next()
            raise Exception( "Payload Vector size not equal")
        except StopIteration:
            pass

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/RalDatabase_extendedSpec
    def test_1RO_02_ReferencePayload(self):
        #print 'DEBUG: Test02'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        obj = fref.findObject( 10, 0 )
        self.assertEquals(  5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.referencePayloadLow(), obj.payload() )
        obj = fref.findObject( 20, 0 )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 25, obj.until() )
        self.assertEqualsAL( self.mgr.referencePayloadHigh(), obj.payload() )
        #obj = fref.findObject( 30, 0 )
        #self.assertEquals( 25, obj.since() )
        #self.assertEquals( 35, obj.until() )
        #self.assertEqualsAL( self.mgr.referencePayloadNull(), obj.payload() )

    # Test A_UCHAR explicitly
    def test_1RO_02a_ReferencePayloadUChar(self):
        #print 'DEBUG: Test02a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        obj = fref.findObject( 10, 0 )
        self.assertEquals(  5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.referencePayloadLow(), obj.payload(),
                             False, True )
        obj = fref.findObject( 20, 0 )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 25, obj.until() )
        self.assertEqualsAL( self.mgr.referencePayloadHigh(), obj.payload(),
                             False, True )

    # Test A_BLOB64K and A_BLOB16M explicitly for an empty blob
    def test_1RO_02b1_ReferencePayloadBlobEmpty(self):
        #print 'DEBUG: Test02b1'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        obj = fref.findObject( 10, 0 )
        self.assertEquals(  5, obj.since() )
        self.assertEquals( 15, obj.until() )
        # Work around for SQLiteAccess bug #30036
        # Determine technology as in test_1RO_07_ReferenceSchema
        dbId = self.db.databaseId()
        if dbId.startswith( "sqlite" ):
            hackBug30036 = True
        else:
            hackBug30036 = False
        self.assertEqualsAL( self.mgr.referencePayloadLow( hackBug30036 ),
                             obj.payload(), True, False )

    # Test A_BLOB64K and A_BLOB16M explicitly
    def test_1RO_02b2_ReferencePayloadBlob(self):
        #print 'DEBUG: Test02a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        obj = fref.findObject( 20, 0 )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 25, obj.until() )
        self.assertEqualsAL( self.mgr.referencePayloadHigh(), obj.payload(),
                             True, False )

    # From RelationalCool/tests/RalDatabase_extendedSpec
    def test_1RO_02c_ReferencePayloadNull(self):
        #print 'DEBUG: Test02c'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        obj = fref.findObject( 30, 0 )
        self.assertEquals( 25, obj.since() )
        self.assertEquals( 35, obj.until() )
        # All but uchar and blob
        self.assertEqualsAL( self.mgr.referencePayloadNull(), obj.payload() )
        # Only uchar
        self.assertEqualsAL( self.mgr.referencePayloadNull(), obj.payload(),
                             False, True )
        # Only blob
        self.assertEqualsAL( self.mgr.referencePayloadNull(), obj.payload(),
                             True, False )

    #-------------------------------------------------------------------------

    # Test for Richard's bug #16995 in Frontier (due to CORAL bug #18285)
    def test_1RO_03a_listChannels_SV(self):
        #print 'DEBUG: Test03a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fsv = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        channels = fsv.listChannels()
        # Analyse databases created using COOL13
        if not self.mgr.refSchemaVersion200:
            self.assertEquals( channels.size(), 3 )
        # Analyse databases created using COOL20 or COOL22
        else:
            # Read back using COOL20 or COOL21 (bug #24448)
            if not self.mgr.svcVersion22x:
                self.assertEquals( channels.size(), 3 )
            # Read back using COOL22 or later
            else:
                self.assertEquals( channels.size(), 5 )

    #-------------------------------------------------------------------------

    def test_1RO_03b_listChannels_MV(self):
        #print 'DEBUG: Test03b'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        channels = fmv1.listChannels()
        # Analyse databases created using COOL13
        if not self.mgr.refSchemaVersion200:
            self.assertEquals( channels.size(), 2 )
        # Analyse databases created using COOL20 or COOL22
        else:
            # Read back using COOL20 or COOL21 (bug #30443)
            if not self.mgr.svcVersion22x:
                self.assertEquals( channels.size(), 2 )
            # Read back using latest COOL (fix bug #30443)
            else:
                self.assertEquals( channels.size(), 4 )

    #-------------------------------------------------------------------------

    # Test for findObject for MV HEAD and tag
    def test_1RO_04_findMV_headTag(self):
        #print 'DEBUG: Test04'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        obj = fmv1.findObject( 10, 1 )
        self.assertEquals(  5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Test for findObject for MV user tag (test for Frontier MV bug #19753)
    def test_1RO_05_findMV_userTag(self):
        #print 'DEBUG: Test05'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv2 = self.db.getFolder( '/SimpleSpec/MV/mv2' )
        obj = fmv2.findObject( 10, 1, "UserTag A2" )
        self.assertEquals(  5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Test A_UCHAR for all 256 values (COOL bug #18146, CORAL bug #22203)
    def test_1RO_06a_UCharPayload(self):
        #print 'DEBUG: Test06a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fuc = self.db.getFolder( '/UcharSpec/uc' )
        for i in range( 256 ) :
            obj = fuc.findObject( i, 0 )
            self.assertEquals( i, obj.since() )
            self.assertEquals( i+1, obj.until() )
            lhs = self.mgr.ucharPayload(i)
            rhs = obj.payload()
            #if i == 0 : print 'DEBUG'
            #print 'DEBUG: Value of A_UCHAR[', i , ']',\
            #      'lhs:', lhs["A_UCHAR"].__repr__(),\
            #      'rhs:', rhs["A_UCHAR"].__repr__()
            self.assertEquals( lhs["A_UCHAR"], rhs["A_UCHAR"] )

    #-------------------------------------------------------------------------

    # Test A_STRING1 for all 256 values
    def test_1RO_06b_UCharPayload_asString(self):
        #print 'DEBUG: Test06b'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fuc = self.db.getFolder( '/UcharSpec/uc' )
        for i in range( 256 ) :
            obj = fuc.findObject( i, 0 )
            self.assertEquals( i, obj.since() )
            self.assertEquals( i+1, obj.until() )
            lhs = self.mgr.ucharPayload(i)
            rhs = obj.payload()
            ###if i == 0 :
            ###    self.assertEquals( 0, len( lhs["A_STRING1"] ) ) # 0 char!?
            ###    self.assertEquals( 0, len( rhs["A_STRING1"] ) ) # 0 char!?
            ###else :
            ###    self.assertEquals( 1, len( lhs["A_STRING1"] ) ) # 1 char
            ###    self.assertEquals( 1, len( rhs["A_STRING1"] ) ) # 1 char
            #if i == 0 : print 'DEBUG'
            if lhs["A_STRING1"] is None :
                llen = 0
                lrep = "NULL"
            else :
                llen = len( lhs["A_STRING1"] )
                lrep = lhs["A_STRING1"].__repr__()
            if rhs["A_STRING1"] is None :
                rlen = 0
                rrep = "NULL"
            else :
                rlen = len( rhs["A_STRING1"] )
                rrep = rhs["A_STRING1"].__repr__()
            if i == 0 : print ''
            ###print 'DEBUG: Value of A_STRING1[', i , ']',\
            ###      'l-size:', llen, 'r-size:', rlen,\
            ###      'lhs:', lrep, 'rhs:', rrep
            self.assertEquals( lhs["A_STRING1"], rhs["A_STRING1"] )
        # Split DEBUG printout from assertEquals to debug any errors
        ###for i in range( 256 ) :
        ###    obj = fuc.findObject( i, 0 )
        ###    self.assertEquals( i, obj.since() )
        ###    self.assertEquals( i+1, obj.until() )
        ###    lhs = self.mgr.ucharPayload(i)
        ###    rhs = obj.payload()
        ###    self.assertEquals( lhs["A_STRING1"], rhs["A_STRING1"] )

    #-------------------------------------------------------------------------

    # Test A_BLOB1 for all 256 values
    def test_1RO_06c_UCharPayload_asBlob(self):
        #print 'DEBUG: Test06c'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fuc = self.db.getFolder( '/UcharSpec/uc' )
        for i in range( 256 ) :
            obj = fuc.findObject( i, 0 )
            self.assertEquals( i, obj.since() )
            self.assertEquals( i+1, obj.until() )
            lhs = self.mgr.ucharPayload(i)
            rhs = obj.payload()
            ###self.assertEquals( 1, lhs["A_BLOB1"].size() ) # 1 char
            ###self.assertEquals( 1, rhs["A_BLOB1"].size() ) # 1 char
            #lhs_read = lhs["A_BLOB1"].read()
            #rhs_read = rhs["A_BLOB1"].read()
            #if i == 0 : print 'DEBUG'
            #print 'DEBUG: Value of A_BLOB1[', i , ']',\
            #      'l-size:', lhs["A_BLOB1"].size(),\
            #      'r-size:', rhs["A_BLOB1"].size(),\
            #      'lhs:', lhs_read.__repr__(),\
            #      'rhs:', rhs_read.__repr__()
            if self.mgr.refSchemaVersion200 :
                # NEW 2.0.0 SCHEMA ONLY
                self.assertEquals( lhs["A_BLOB1"], rhs["A_BLOB1"] )

    #-------------------------------------------------------------------------

    def expectedSqlType( self, stType, technology ) :
        coolST = cool.StorageType
        if technology == "oracle" :
            if   stType == coolST.Bool      : return "NUMBER(1)"
            elif stType == coolST.UChar     : return "NUMBER(3)"
            elif stType == coolST.Int16     : return "NUMBER(5)"
            elif stType == coolST.UInt16    : return "NUMBER(5)"
            elif stType == coolST.Int32     : return "NUMBER(10)"
            elif stType == coolST.UInt32    : return "NUMBER(10)"
            elif stType == coolST.UInt63    : return "NUMBER(20)"
            elif stType == coolST.Int64     : return "NUMBER(20)"
            elif stType == coolST.Float     : return "BINARY_FLOAT"
            elif stType == coolST.Double    : return "BINARY_DOUBLE"
            elif stType == coolST.String255 : return "VARCHAR2(255)"
            elif stType == coolST.String4k  : return "VARCHAR2(4000)"
            elif stType == coolST.String64k : return "CLOB"
            elif stType == coolST.String16M : return "CLOB"
            elif stType == coolST.Blob64k   : return "BLOB"
            elif stType == coolST.Blob16M   : return "BLOB"
            else : raise Exception( "Unsupported COOL storage type", stType )
        elif technology == "mysql" :
            if   stType == coolST.Bool      : return "TINYINT(1)"
            elif stType == coolST.UChar     : return "TINYINT(3) UNSIGNED"
            elif stType == coolST.Int16     : return "SMALLINT(6)"
            elif stType == coolST.UInt16    : return "SMALLINT(5) UNSIGNED"
            elif stType == coolST.Int32     : return "INT(11)"
            elif stType == coolST.UInt32    : return "INT(10) UNSIGNED"
            elif stType == coolST.UInt63    : return "BIGINT(20) UNSIGNED"
            elif stType == coolST.Int64     : return "BIGINT(20)"
            elif stType == coolST.Float     : return "FLOAT"
            elif stType == coolST.Double    : return "DOUBLE"
            elif stType == coolST.String255 :
                if self.mgr.svcVersion22x   : return "VARCHAR(255) BINARY"
                elif self.mgr.svcVersion2xx : return "VARCHAR(255)"
                else                        : return "VARCHAR(255) BINARY"
            elif stType == coolST.String4k  : return "TEXT"
            #elif stType == coolST.String4k  : return "TEXT BINARY"
            elif stType == coolST.String64k : return "TEXT"
            #elif stType == coolST.String64k : return "TEXT BINARY"
            elif stType == coolST.String16M : return "MEDIUMTEXT"
            #elif stType == coolST.String16M : return "MEDIUMTEXT BINARY"
            elif stType == coolST.Blob64k   : return "BLOB"
            elif stType == coolST.Blob16M   : return "MEDIUMBLOB"
            else : raise Exception( "Unsupported COOL storage type", stType )
        elif technology == "sqlite" :
            if   stType == coolST.Bool      : return "BOOLEAN"
            elif stType == coolST.UChar     : return "UNSIGNEDCHAR"
            elif stType == coolST.Int16     : return "SHORT"
            elif stType == coolST.UInt16    : return "UNSIGNEDSHORT"
            elif stType == coolST.Int32     : return "INT"
            elif stType == coolST.UInt32    : return "UNSIGNEDINT"
            elif stType == coolST.UInt63    : return "ULONGLONG"
            elif stType == coolST.Int64     : return "SLONGLONG"
            elif stType == coolST.Float     : return "FLOAT"
            elif stType == coolST.Double    : return "DOUBLE"
            elif stType == coolST.String255 : return "TEXT"
            elif stType == coolST.String4k  : return "TEXT"
            elif stType == coolST.String64k : return "TEXT"
            elif stType == coolST.String16M : return "TEXT"
            elif stType == coolST.Blob64k   : return "BLOB"
            elif stType == coolST.Blob16M   : return "BLOB"
            else : raise Exception( "Unsupported COOL storage type", stType )
        else : raise Exception( "Unknown technology: " + technology )

    #-------------------------------------------------------------------------

    # Compare expected and actual SQL column types in the reference IOV table
    # Only run this test if the current software release is 2.0 or higher:
    # need the StorageType API - could also implement it using ExtendedALS,
    # but this would not add anything useful to the schema evolution tests.
    def test_1RO_07_ReferenceSchema(self):
        #print 'DEBUG: Test07'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')

        # Get the actual SQL types of all columns in the reference IOV table
        fref = self.db.getFolder( '/ReferenceSpec/ref' )
        frefAtt = fref.folderAttributes()
        frefTab = frefAtt["FOLDER_IOVTABLENAME"]
        ###print 'DEBUG: Reference folder IOV table name:', frefTab

        # Get the databaseId
        dbId = self.db.databaseId()
        ###print 'DEBUG: db ID:', dbId

        # Try to determine the current database technology.
        # Fix bug #24248: do not call coolAuthentication for sqlite/frontier,
        # avoiding the need for dummy username/password in authentication.xml.
        # NB: this bug has been fixed in coolAuthentication in COOL200, but
        # the schema evolution test uses coolAuthentication from COOL133c.
        if dbId.startswith( "sqlite" ):
            tech = "sqlite"
        elif dbId.startswith( "frontier" ):
            tech = "frontier"
        else:
            dbIdProp = CoolAuthentication.getDbIdProperties( dbId )
            tech = CoolAuthentication.technology( dbIdProp )

        # Do not run this test if the current technology cannot be determined
        # This may happen if you are using a CORAL host alias (see task #4259)
        if tech == "":
            print 'WARNING: skip SQL type test:'\
                  ' technology cannot be determined'

        # Do not run this test if the current technology is frontier
        elif tech == "frontier":
            #print 'WARNING: skip SQL type test for Frontier'
            pass

        # Only run this test if the current software release is 2.0 or higher
        elif self.mgr.svcVersion2xx:
            # Get the expected SQL types of all columns
            refSpec = self.mgr.referencePayloadSpec()
            for field in refSpec:
                type = field.storageType()
                ###print 'DEBUG: Payload:', field.name(), \
                ###      ', storageType:', type, ', expectedSqlType:',\
                ###      self.expectedSqlType( type, tech )

            # Compare expected and actual SQL column types
            frefCol = CoolDescribeTable.describeTable( dbId, frefTab, debug=False )
            for i in frefCol:
                name = i[0]
                sqlType = i[1]
                print 'DEBUG: Column SQL type:', sqlType, ', name:', name
                for field in refSpec:
                    if ( name == field.name() ):
                        expType = field.storageType()
                        expSqlType = self.expectedSqlType( expType, tech )
                        print 'DEBUG: -----> expected:', expSqlType

            # Compare expected and actual SQL column types
            for i in frefCol:
                name = i[0]
                sqlType = i[1]
                ###print 'DEBUG: Column SQL type:', sqlType, ', name:', name
                for field in refSpec:
                    if ( name == field.name() ):
                        expType = field.storageType()
                        expSqlType = self.expectedSqlType( expType, tech )
                        ###print 'DEBUG: -----> expected:', expSqlType
                        self.assertEquals( expSqlType, sqlType )

        # Only print the SQL types if the current software release is < 2.0
        else:
            frefCol = CoolDescribeTable.describeTable( dbId, frefTab )
            for i in frefCol:
                name = i[0]
                sqlType = i[1]
                print 'DEBUG: Column SQL type:', sqlType, ', name:', name

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_02_content_sv1]
    def test_1RO_08_content_sv(self):
        #print 'DEBUG: Test08'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        #print 'Object #1 in [1,4]:', obj
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #2 in [1,4]:', obj
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #3 in [1,4]:', obj
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #4 in [1,4]:', obj
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as above, using a live iterator
    def test_1RO_08a_content_sv(self):
        #print 'DEBUG: Test08a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        f.setPrefetchAll( False )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_03_content_mv1_HEAD]
    def test_1RO_09_content_mv1_HEAD(self):
        #print 'DEBUG: Test09'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_04_content_mv1_Tag_A1]
    def test_1RO_10_content_mv1_Tag_A1(self):
        #print 'DEBUG: Test10'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A1' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_05_content_mv1_Tag_B1]
    def test_1RO_11_content_mv1_Tag_B1(self):
        #print 'DEBUG: Test11'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag B1' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was approximately test_06_content_mv2_HEAD]
    def test_1RO_12_content_mv2_HEAD(self):
        #print 'DEBUG: Test12'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/MV/mv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was approximately test_07_content_mv2_Tag_A2]
    def test_1RO_13_content_mv2_UserTag_A2(self):
        #print 'DEBUG: Test13'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/MV/mv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'UserTag A2' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Test that channels exist
    def test_1RO_14_channelsExist_SV(self):
        #print 'DEBUG: Test14'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fsv = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        if self.mgr.svcVersion2xx:
            self.assertEquals( fsv.existsChannel(  0 ), True )
            self.assertEquals( fsv.existsChannel(  1 ), True )
            self.assertEquals( fsv.existsChannel(  2 ), True )
            if self.mgr.refSchemaVersion200:
                self.assertEquals( fsv.existsChannel( 10 ), True )
                self.assertEquals( fsv.existsChannel( 20 ), True )

    #-------------------------------------------------------------------------

    # Test that channels exist in the channels table
    def test_1RO_14a_channelsExist_SV(self):
        #print 'DEBUG: Test14a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fsv = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        fsvAtt = fsv.folderAttributes()
        if TestReferenceDb1RO.dbSchemaVersion200 :
            fsvChT = fsvAtt["FOLDER_CHANNELTABLENAME"]
            dbId = self.db.databaseId()
            sql = 'SELECT CHANNEL_ID FROM ' + fsvChT + ' ORDER BY CHANNEL_ID;'
            # Determine technology as in test_1RO_07_ReferenceSchema
            if dbId.startswith( "sqlite" ):
                tech = "sqlite"
            elif dbId.startswith( "frontier" ):
                tech = "frontier"
            else:
                dbIdProp = CoolAuthentication.getDbIdProperties( dbId )
                tech = CoolAuthentication.technology( dbIdProp )
            # Skip this test for frontier (fix bug #28040)
            # Enable this test for oracle on Windows (task #5255, bug #28109)
            if ( tech == "oracle" ) or \
               ( tech == "mysql" ) or \
               ( tech == "sqlite" ) :
                chRows = CoolQueryManager.executeSqlSelect( dbId, sql )
                if not self.mgr.refSchemaVersion200:
                    self.assertEquals( len(chRows), 3 )
                else:
                    self.assertEquals( len(chRows), 5 )
                self.assertEquals( long(chRows[0][0]), 0 )
                self.assertEquals( long(chRows[1][0]), 1 )
                self.assertEquals( long(chRows[2][0]), 2 )
                if self.mgr.refSchemaVersion200:
                    self.assertEquals( long(chRows[3][0]), 10 )
                    self.assertEquals( long(chRows[4][0]), 20 )

    #-------------------------------------------------------------------------

    # Test that channels exist
    def test_1RO_15_channelsExist_MV(self):
        #print 'DEBUG: Test15'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        if self.mgr.svcVersion2xx:
            self.assertEquals( fmv1.existsChannel( 1 ), True )
            self.assertEquals( fmv1.existsChannel( 2 ), True )
            # Test for bug #30431 (affects COOL_2_0_0 to COOL_2_2_1)
            if self.mgr.refSchemaVersion200:
                # Do not read back using COOL20 or COOL21 (bug #30431)
                # Read back only using latest COOL (fix bug #30443)
                if self.mgr.svcVersion22x:
                    self.assertEquals( fmv1.existsChannel( 10 ), True )
                    self.assertEquals( fmv1.existsChannel( 20 ), True )

    #-------------------------------------------------------------------------

    # Test that channels exist in the channels table
    # This is not true for 2.0.0 folders (bug #23755)
    def test_1RO_15a_channelsExist_MV(self):
        #print 'DEBUG: Test15a'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        fmvAtt = fmv.folderAttributes()
        if TestReferenceDb1RO.dbSchemaVersion200 :
            fmvChT = fmvAtt["FOLDER_CHANNELTABLENAME"]
            fmvSch = fmvAtt["NODE_SCHEMA_VERSION"]
            dbId = self.db.databaseId()
            sql = 'SELECT CHANNEL_ID FROM ' + fmvChT + ' ORDER BY CHANNEL_ID;'
            # Determine technology as in test_1RO_07_ReferenceSchema
            if dbId.startswith( "sqlite" ):
                tech = "sqlite"
            elif dbId.startswith( "frontier" ):
                tech = "frontier"
            else:
                dbIdProp = CoolAuthentication.getDbIdProperties( dbId )
                tech = CoolAuthentication.technology( dbIdProp )
            # Skip this test for frontier (fix bug #28040)
            # Enable this test for oracle on Windows (task #5255, bug #28109)
            if ( tech == "oracle" ) or \
               ( tech == "mysql" ) or \
               ( tech == "sqlite" ) :
                chRows = CoolQueryManager.executeSqlSelect( dbId, sql )
                # Analyse databases created using COOL13
                if not self.mgr.refSchemaVersion200:
                    if fmvSch == "2.0.1" :
                        self.assertEquals( len(chRows), 2 )
                        self.assertEquals( long(chRows[0][0]), 1 )
                        self.assertEquals( long(chRows[1][0]), 2 )
                    else :
                        self.assertEquals( fmvSch, "2.0.0" )
                # Analyse databases created using COOL20 or COOL22
                else:
                    if fmvSch == "2.0.1" :
                        self.assertEquals( len(chRows), 4 )
                        self.assertEquals( long(chRows[0][0]),  1 )
                        self.assertEquals( long(chRows[1][0]),  2 )
                        self.assertEquals( long(chRows[2][0]), 10 )
                        self.assertEquals( long(chRows[3][0]), 20 )
                    else :
                        self.assertEquals( fmvSch, "2.0.0" )
                        self.assertEquals( len(chRows), 3 )
                        self.assertEquals( long(chRows[0][0]),  1 )
                        self.assertEquals( long(chRows[1][0]), 10 )
                        self.assertEquals( long(chRows[2][0]), 20 )

    #-------------------------------------------------------------------------

    # Test the folder schema version.
    # Expect 2.0.1 if the reference schema version is 2.0.1.
    # Expect 2.0.1 if the software version is COOL_2_2_0,
    # even if the reference schema version is 2.0.0.
    # *** This is needed in the schema evolution test 200->220.
    # *** WARNING: this will fail for a regression test
    # *** of the 2.0.0 reference schema using COOL_2_2_0.
    def test_1RO_16_folderSchemaVersion(self):
        #print 'DEBUG: Test16'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        fmv = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        fmvAtt = fmv.folderAttributes()
        if TestReferenceDb1RO.dbSchemaVersion200 :
            fmvSch = fmvAtt["NODE_SCHEMA_VERSION"]
            if self.mgr.refSchemaVersion220 :
                self.assertEquals( fmvSch, "2.0.1" )
            elif self.mgr.svcVersion22x:
                self.assertEquals( fmvSch, "2.0.1" )
            else :
                self.assertEquals( fmvSch, "2.0.0" )

    #-------------------------------------------------------------------------

    # Tests HVS tag relations.
    def test_1RO_17_tagRelations(self):
        #print 'DEBUG: Test17'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')

        # Test HVS tag relations
        f1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        self.assertEquals( "Tag A1", f1.findTagRelation( "HVS tag" ) )

    #-------------------------------------------------------------------------

    # Test lowercase payload
    def test_1RO_18_lowercase(self):
        #print 'DEBUG: Test18'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/LowercaseSpec/sv' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 1, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.lowercasePayload( 1 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_08_content_sv, with payload table
    def test_1RO_19_content_ptsv(self):
        #print 'DEBUG: Test19'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion280: return # NEW 2.8.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecPayloadTable/PTSV/ptsv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        #print 'Object #1 in [1,4]:', obj
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #2 in [1,4]:', obj
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #3 in [1,4]:', obj
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #4 in [1,4]:', obj
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_09_content_mv1_HEAD, with payload table
    def test_1RO_20_content_ptmv1_HEAD(self):
        #print 'DEBUG: Test20'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion280: return # NEW 2.8.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecPayloadTable/PTMV/ptmv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    # Same as test_1RO_10_content_mv1_Tag_A1, with payload table
    def test_1RO_21_content_ptmv1_Tag_A1PT(self):
        #print 'DEBUG: Test21'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion280: return # NEW 2.8.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecPayloadTable/PTMV/ptmv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A1PT' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_12_content_mv2_HEAD, with payload table
    def test_1RO_22_content_ptmv2_HEAD(self):
        #print 'DEBUG: Test22'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion280: return # NEW 2.8.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecPayloadTable/PTMV/ptmv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    # Same as test_1RO_13_content_mv2_UserTag_A2, with payload table
    def test_1RO_23_content_ptmv2_UserTag_A2PT(self):
        #print 'DEBUG: Test23'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion280: return # NEW 2.8.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecPayloadTable/PTMV/ptmv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'UserTag A2PT' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_08_content_sv, with payload table
    def test_1RO_24_content_ptsv(self):
        #print 'DEBUG: Test24'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTSV/ptsv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        #print 'Object #1 in [1,4]:', obj
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #2 in [1,4]:', obj
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #3 in [1,4]:', obj
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        #print 'Object #4 in [1,4]:', obj
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_08_content_sv, with vector folder and vector content
    def test_1RO_24a_content_ptsv(self):
        #print 'DEBUG: Test24'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTSV/ptsv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        #print 'Object #1 in [1,4]:', obj
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 1, 1 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        #print 'Object #2 in [1,4]:', obj
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 2, 4 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        #print 'Object #3 in [1,4]:', obj
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 3, 5 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        #print 'Object #4 in [1,4]:', obj
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 4, 6 ), obj.payloadIterator() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_09_content_mv1_HEAD, with payload table
    def test_1RO_25_content_ptmv1_HEAD(self):
        #print 'DEBUG: Test20'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTMV/ptmv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    # Same as test_1RO_10_content_mv1_Tag_A1, with payload table
    def test_1RO_26_content_ptmv1_Tag_A1PT(self):
        #print 'DEBUG: Test21'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTMV/ptmv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag A1VT' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Same as test_1RO_12_content_mv2_HEAD, with payload table
    def test_1RO_27_content_ptmv2_HEAD(self):
        #print 'DEBUG: Test22'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTMV/ptmv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

    # Same as test_1RO_12_content_mv2_HEAD, with vector table
    def test_1RO_27a_content_ptmv2_HEAD(self):
        #print 'DEBUG: Test22'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTMV/ptmv3' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 121, 2 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 130, 7 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 122, 3 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 221, 5 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 230, 8 ), obj.payloadIterator() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsVector( self.mgr.simplePayloadVector( 222, 6 ), obj.payloadIterator() )


    # Same as test_1RO_13_content_mv2_UserTag_A2, with payload table
    def test_1RO_28_content_ptmv2_UserTag_A2PT(self):
        #print 'DEBUG: Test23'
        if TestReferenceDb1RO.db == 0 : return self.abort('The database is not open')
        if not self.mgr.refSchemaVersion290: return # NEW 2.9.0 SCHEMA ONLY
        f = self.db.getFolder( '/SimpleSpecVectorTable/PTMV/ptmv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'UserTag A2VT' )
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )


##############################################################################

class TestReferenceDb1RW( unittest.TestCase ):

    #print 'DEBUG: *START* TestReferenceDb1RW CLASS INITIALIZATION'
    iTest=0
    nTest=0
    refSchemaVersion="2.8.0"
    connectString=""
    mgr=0
    db=0
    dbSchemaVersion200=True
    grantPublicReader=False
    #print 'DEBUG: **END** TestReferenceDb1RW CLASS INITIALIZATION'

    #-------------------------------------------------------------------------

    def __init__(self, methodName='runTest'):
        #print 'DEBUG: *START* TestReferenceDb1RW.__init__()'

        TestReferenceDb1RW.iTest = TestReferenceDb1RW.iTest+1
        self.iTest = TestReferenceDb1RW.iTest
        #print 'DEBUG: RW instance number=', self.iTest
        TestReferenceDb1RW.nTest = TestReferenceDb1RW.nTest+1
        #print 'DEBUG: Total # RW instances=', self.nTest

        if TestReferenceDb1RW.iTest == 1 :
            if TestReferenceDb1RW.refSchemaVersion == "2.8.0" :
                print 'DEBUG: Create TestReferenceDb1RW',\
                      'for 2.8.0 reference schema'
            elif TestReferenceDb1RW.refSchemaVersion == "2.2.0" :
                print 'DEBUG: Create TestReferenceDb1RW',\
                      'for 2.2.0 reference schema'
            elif TestReferenceDb1RW.refSchemaVersion == "2.0.0" :
                print 'DEBUG: Create TestReferenceDb1RW',\
                      'for 2.0.0 reference schema'
            elif TestReferenceDb1RW.refSchemaVersion == "1.3.0" :
                print 'DEBUG: Create TestReferenceDb1RW',\
                      'for 1.3.0 reference schema'
            else:
                print 'ERROR: Cannot create TestReferenceDb1RW for unknown',\
                      TestReferenceDb1RW.refSchemaVersion, 'reference schema'
            #print 'DEBUG: Instantiate a ReferenceDbMgr'
            TestReferenceDb1RW.mgr = ReferenceDbMgr\
                                    (TestReferenceDb1RW.refSchemaVersion)

        ### See http://www.byteofpython.info/read/inheritance.html
        unittest.TestCase.__init__(self, methodName)

        #print 'DEBUG: **END** TestReferenceDb1RW.__init__()'

    #-------------------------------------------------------------------------

    def __del__(self):
        #print 'DEBUG: *START* TestReferenceDb1RW.__del__()'
        #print 'DEBUG: RW instance number=', self.iTest
        TestReferenceDb1RW.nTest = TestReferenceDb1RW.nTest-1
        #print 'DEBUG: Total # RW instances=', self.nTest
        #print 'DEBUG: **END** TestReferenceDb1RW.__del__()'
        pass

    #-------------------------------------------------------------------------

    def setUp(self):
        #print 'DEBUG: SetUp'
        pass

    #-------------------------------------------------------------------------

    def tearDown(self):
        #print 'DEBUG: TearDown'
        pass

    #-------------------------------------------------------------------------

    # Strictly needed only if you want to instantiate this class
    def runTest(self):
        #print 'DEBUG: RunTests'
        pass

    #-------------------------------------------------------------------------

    def test_1RW_00_initialise(self):
        print ''
        print 'DEBUG: (TestReferenceDb1RO) **********************************'
        if TestReferenceDb1RW.connectString == "":
            print 'ERROR! TestReferenceDb1RW.connectString is not set!'
            sys.exit(-1)
        connectString = TestReferenceDb1RW.connectString
        print 'DEBUG: (TestReferenceDb1RW) Open reference database'
        print 'DEBUG: (TestReferenceDb1RW) -> db ID:', connectString
        if self.mgr.svcVersion22x:
            dbProp = CoolAuthentication.getDbIdProperties \
                     ( connectString, True ) # R/W
            dbReplica = CoolAuthentication.coralReplica( dbProp )
            print 'DEBUG: -> db replica (R/W):', dbReplica
        readOnly = False
        TestReferenceDb1RW.db = TestReferenceDb1RW.mgr.dbSvc.openDatabase\
                                ( connectString, readOnly )
        print 'DEBUG: Database opened'
        #print 'DEBUG: -> db ID:', TestReferenceDb1RW.db.databaseId()
        dbAttributes = TestReferenceDb1RW.db.databaseAttributes()
        #print 'DEBUG: -> db attributes:', dbAttributes
        dbSchemaVersion = dbAttributes["SCHEMA_VERSION"]
        print 'DEBUG: -> db schema version:', dbSchemaVersion
        if   ( dbSchemaVersion == "1.3.0" ):
            TestReferenceDb1RW.dbSchemaVersion200 = False
            if self.mgr.refSchemaVersion280 :
                print 'ERROR: TestReferenceDb1RW (2.8.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion220 :
                print 'ERROR: TestReferenceDb1RW (2.2.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion200 :
                print 'ERROR: TestReferenceDb1RW (2.0.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            else :
                print 'DEBUG: Test 1.3.0 reference schema on a 1.3.0 db',\
                      '(R/W test)'
        elif ( dbSchemaVersion == "2.0.0" ):
            TestReferenceDb1RW.dbSchemaVersion200 = True
            if self.mgr.refSchemaVersion280 :
                print 'DEBUG: Test 2.8.0 reference schema on a 2.0.0 db',\
                      '(R/W test)'
            elif self.mgr.refSchemaVersion220 :
                print 'DEBUG: Test 2.2.0 reference schema on a 2.0.0 db',\
                      '(R/W test)'
            elif self.mgr.refSchemaVersion200 :
                print 'DEBUG: Test 2.0.0 reference schema on a 2.0.0 db',\
                      '(R/W test)'
            else:
                print 'DEBUG: Test 1.3.0 reference schema on a 2.0.0 db',\
                      '(R/W test)'
        else :
            print 'ERROR: unknown database schema', dbSchemaVersion
            sys.exit(-1)

        if ( self.db.existsFolderSet( '/TestRW' ) ):
            print 'ERROR: R/W test cannot be repeated more than once'
            sys.exit(-1)

    #-------------------------------------------------------------------------

    def test_1RW_99_finalise(self):
        print ''
        print 'DEBUG: (TestReferenceDb1RW) Close reference database'
        print 'DEBUG: (TestReferenceDb1RW) **********************************'
        TestReferenceDb1RW.db.closeDatabase()
        if self.grantPublicReader:
            print 'DEBUG: (TestReferenceDb1RW)',\
                  'Grant READER privileges to public'
            connectString = TestReferenceDb1RW.connectString
            cmd = 'coolPrivileges "' # You may need to add .exe on Windows...
            cmd = cmd + connectString + '" GRANT READER public > /dev/null'
            os.system( cmd )

    #-------------------------------------------------------------------------

    def test_1RW_01_createNewFolderSet(self):
        #print 'DEBUG: Test01'
        self.db.createFolderSet( '/TestRW' )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution.
    # Test method to compare two Records deeply
    # (standard comparison only compares their pointers).
    def assertEqualsAL( self, lhs, rhs, skipA_UCHAR=True, skipA_BLOB64K=True ):
        self.assertEquals( lhs.size(), rhs.size() )
        ##print 'DEBUG: lhs:', lhs
        ##print 'DEBUG: rhs:', rhs
        for i in lhs:
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-type:', type(lhs[i]), 'rhs-type:', type(rhs[i])
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-value:', lhs[i].__repr__(),\
            #      'rhs-value:', rhs[i].__repr__()
            if type(lhs[i]) == float:
                self.assertAlmostEqual( lhs[i], rhs[i], 6 )
            elif i == 'A_UCHAR':
                # A_UCHAR comparison fails for Frontier - see CORAL bug #22307
                if skipA_UCHAR : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            elif i == 'A_BLOB64K' or i == 'A_BLOB16M' :
                # Blobs used to fail for Frontier (bug #22203) - now fixed
                if skipA_BLOB64K : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            else:
                self.assertEquals( lhs[i], rhs[i] )

    #-------------------------------------------------------------------------

    # Tests adding a new SV folder.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_09_add_folder_SV]
    def test_1RW_02_add_folder_SV(self):
        #print 'DEBUG: Test02'

        # Create a new SV folder and add data
        f = self.db.createFolder( '/SimpleSpec/SV/sv2', self.mgr.simpleSpec,
                                  '', cool.FolderVersioning.SINGLE_VERSION )
        inf = cool.ValidityKeyMax
        f.storeObject(  0, inf, self.mgr.simplePayload( 101 ), 0 )
        f.storeObject( 10,  15, self.mgr.simplePayload( 102 ), 0 )
        f.storeObject( 15,  20, self.mgr.simplePayload( 103 ), 0 )
        f.storeObject( 20, inf, self.mgr.simplePayload( 104 ), 0 )

        # Access and test SV HEAD
        f = self.db.getFolder( '/SimpleSpec/SV/sv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEquals( 4, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 101 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 102 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 103 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 104 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests adding a new MV folder.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_10_add_folder_MV]
    def test_1RW_03_add_folder_MV(self):
        #print 'DEBUG: Test03'

        # Create a new MV folder and add data
        f = self.db.createFolder( '/SimpleSpec/MV/mv3', self.mgr.simpleSpec,
                                  '', cool.FolderVersioning.MULTI_VERSION )
        f.storeObject(  0, 10, self.mgr.simplePayload( 111 ), 0 )
        f.storeObject(  0,  5, self.mgr.simplePayload( 112 ), 0 )
        f.storeObject( 15, 20, self.mgr.simplePayload( 113 ), 0 )
        f.tagCurrentHead( "Tag D1", "My tag D1" )
        f.storeObject(  5, 15, self.mgr.simplePayload( 114 ), 0 )
        f.tagCurrentHead( "Tag E1", "My tag E1" )

        # Access and test HEAD
        f = self.db.getFolder( '/SimpleSpec/MV/mv3' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD')
        self.assertEquals( 3, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 112 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 114 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 113 ), obj.payload() )

        # Access and test tag D1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag D1')
        self.assertEquals( 3, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 112 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 111 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 113 ), obj.payload() )

        # Access and test tag E1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'Tag E1')
        self.assertEquals( 3, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 112 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 114 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 113 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests adding a new MV folder with user tagged data.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_11_add_folder_userTag]
    def test_1RW_04_add_folder_MV_userTag(self):
        #print 'DEBUG: Test04'

        # Create a new MV folder and add data with user tags
        f = self.db.createFolder( '/SimpleSpec/MV/mv4', self.mgr.simpleSpec,
                                  '', cool.FolderVersioning.MULTI_VERSION )
        f.storeObject( 0, 10, self.mgr.simplePayload( 201 ), 0 )
        f.storeObject( 1,  5, self.mgr.simplePayload( 202 ), 0, "user tag A" )
        f.storeObject( 3,  8, self.mgr.simplePayload( 203 ), 0, "user tag B" )
        f.storeObject( 2,  4, self.mgr.simplePayload( 204 ), 0, "user tag A" )
        f.storeObject( 3,  7, self.mgr.simplePayload( 205 ), 0, "user tag B" )

        # Access and test HEAD
        f = self.db.getFolder( '/SimpleSpec/MV/mv4' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD')
        self.assertEquals( 6, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 1, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 201 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 1, obj.since() )
        self.assertEquals( 2, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 202 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 3, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 204 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 3, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 205 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 8, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 203 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 8, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 201 ), obj.payload() )

        # Access and test user tag A
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'user tag A')
        self.assertEquals( 3, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 1, obj.since() )
        self.assertEquals( 2, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 202 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 2, obj.since() )
        self.assertEquals( 4, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 204 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 4, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 202 ), obj.payload() )

        # Access and test user tag B
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'user tag B')
        self.assertEquals( 2, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 3, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 205 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 8, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 203 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests adding new SV data to an existing evolved folder.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_12_add_data_existing_folder_SV]
    def test_1RW_05_add_data_existing_folder_SV(self):
        #print 'DEBUG: Test05'

        # Get the SV folder and add data
        f = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        inf = cool.ValidityKeyMax
        f.storeObject( 25, inf, self.mgr.simplePayload( 5 ), 0 )

        # Access and test SV HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )
        self.assertEquals( 5, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( 25, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 25, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 5 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests adding new MV data to an existing evolved folder.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_13_add_data_existing_folder_MV]
    # [this was also test_14_add_userTag_existing_folder_MV]
    def test_1RW_06_add_data_existing_folder_MV(self):
        #print 'DEBUG: Test06'

        # Get the MV folder and add data
        f = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        f.storeObject(  7, 17, self.mgr.simplePayload( 140 ), 1, "UserTag1" )
        f.storeObject( 12, 17, self.mgr.simplePayload( 150 ), 1, "UserTag1" )

        # Access and test HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(1),
                                'HEAD' )
        self.assertEquals( 5, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 12, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 12, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 150 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 17, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        # Access and test tag A1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(1),
                                'Tag A1' )
        self.assertEquals( 3, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        # Create and test tag C1
        f.tagCurrentHead( "Tag C1" )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(1),
                                'Tag C1' )
        self.assertEquals( 5, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 12, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 12, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 150 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 17, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        # Access and test user tag UserTag1
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(1),
                                'UserTag1' )
        self.assertEquals( 2, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 12, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 12, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 150 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests adding new MV data with user tags to an existing evolved folder.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_14_add_userTag_existing_folder_MV]
    def test_1RW_07_add_dataUserTag_existing_folder_MV(self):
        #print 'DEBUG: Test07'

        # Get the MV folder and add data
        f = self.db.getFolder( '/SimpleSpec/MV/mv2' )
        f.storeObject( 7, 17, self.mgr.simplePayload( 140 ), 1, "UserTag A2" )
        f.storeObject( 7, 17, self.mgr.simplePayload( 240 ), 2, "UserTag B2" )

        # Access and test HEAD
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'HEAD' )
        self.assertEquals( 8, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 121 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 17, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 122 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 221 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 240 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 17, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 222 ), obj.payload() )

        # Access and test user tag A2
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all(),
                                'UserTag A2' )
        self.assertEquals( 7, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 7, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 7, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 17, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 110 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 5, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 5, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 230 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 210 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests HVS with existing tags.
    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was approximately test_15_createTagRelation]
    def test_1RW_08_createTagRelation(self):
        #print 'DEBUG: Test08'

        # Modify HVS tag relations
        f1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        f1.deleteTagRelation( "HVS tag" )
        f1.createTagRelation( "HVS tag", "Tag B1" )

        # Test HVS tag relations
        self.assertEquals( "Tag B1", f1.findTagRelation( "HVS tag" ) )

    #-------------------------------------------------------------------------

    # Tests adding a new folder with a long payload description
    def test_1RW_09_add_folder_longPayloadDesc(self):
        #print 'DEBUG: Test09'
        if self.mgr.svcVersion2xx:
            spec = cool.RecordSpecification()
            for i in range(900):
                name = "S1234567890123456789012345%4.4d" % ( i+1000 )
                spec.extend( name, cool.StorageType.String64k )
            f = self.db.createFolder( '/LongSpec', spec, '',
                                      cool.FolderVersioning.SINGLE_VERSION )

##############################################################################

class TestReferenceDb2RO( unittest.TestCase ):

    #print 'DEBUG: *START* TestReferenceDb2RO CLASS INITIALIZATION'
    iTest=0
    nTest=0
    refSchemaVersion="2.8.0"
    connectString=""
    mgr=0
    db=0
    dbSchemaVersion200=True
    invalidateCacheUrl=""
    #print 'DEBUG: **END** TestReferenceDb2RO CLASS INITIALIZATION'

    #-------------------------------------------------------------------------

    def __init__(self, methodName='runTest'):
        #print 'DEBUG: *START* TestReferenceDb2RO.__init__()'

        TestReferenceDb2RO.iTest = TestReferenceDb2RO.iTest+1
        self.iTest = TestReferenceDb2RO.iTest
        #print 'DEBUG: RO instance number=', self.iTest
        TestReferenceDb2RO.nTest = TestReferenceDb2RO.nTest+1
        #print 'DEBUG: Total # RO instances=', self.nTest

        if TestReferenceDb2RO.iTest == 1 :
            if TestReferenceDb2RO.refSchemaVersion == "2.8.0" :
                print 'DEBUG: Create TestReferenceDb2RO',\
                      'for 2.8.0 reference schema'
            elif TestReferenceDb2RO.refSchemaVersion == "2.2.0" :
                print 'DEBUG: Create TestReferenceDb2RO',\
                      'for 2.2.0 reference schema'
            elif TestReferenceDb2RO.refSchemaVersion == "2.0.0" :
                print 'DEBUG: Create TestReferenceDb2RO',\
                      'for 2.0.0 reference schema'
            elif TestReferenceDb2RO.refSchemaVersion == "1.3.0" :
                print 'DEBUG: Create TestReferenceDb2RO',\
                      'for 1.3.0 reference schema'
            else:
                print 'ERROR: Cannot create TestReferenceDb2RO for unknown',\
                      TestReferenceDb2RO.refSchemaVersion, 'reference schema'
            #print 'DEBUG: Instantiate a ReferenceDbMgr'
            TestReferenceDb2RO.mgr = ReferenceDbMgr\
                                    (TestReferenceDb2RO.refSchemaVersion)

        ### See http://www.byteofpython.info/read/inheritance.html
        unittest.TestCase.__init__(self, methodName)

        #print 'DEBUG: **END** TestReferenceDb2RO.__init__()'

    #-------------------------------------------------------------------------

    def __del__(self):
        #print 'DEBUG: *START* TestReferenceDb2RO.__del__()'
        #print 'DEBUG: RO instance number=', self.iTest
        TestReferenceDb2RO.nTest = TestReferenceDb2RO.nTest-1
        #print 'DEBUG: Total # RO instances=', self.nTest
        #print 'DEBUG: **END** TestReferenceDb2RO.__del__()'
        pass

    #-------------------------------------------------------------------------

    def setUp(self):
        #print 'DEBUG: SetUp'
        pass

    #-------------------------------------------------------------------------

    def tearDown(self):
        #print 'DEBUG: TearDown'
        pass

    #-------------------------------------------------------------------------

    # Strictly needed only if you want to instantiate this class
    def runTest(self):
        #print 'DEBUG: RunTests'
        pass

    #-------------------------------------------------------------------------

    def abort(self,msg):
        #print 'DEBUG: abort'
        print 'ERROR (abort):',msg
        ###sys.exit(-1)

    #-------------------------------------------------------------------------

    def test_2RO_00_initialise(self):
        print ''
        print 'DEBUG: (TestReferenceDb2RO) **********************************'
        if TestReferenceDb2RO.connectString == "":
            print 'ERROR! TestReferenceDb2RO.connectString is not set!'
            sys.exit(-1)
        connectString = TestReferenceDb2RO.connectString
        print 'DEBUG: (TestReferenceDb2RO) Open reference database'
        print 'DEBUG: (TestReferenceDb2RO) -> db ID:', connectString
        if self.mgr.svcVersion22x:
            ###dbProp = CoolAuthentication.getDbIdProperties \
            ###         ( connectString, True ) # R/W
            ###dbReplica = CoolAuthentication.coralReplica( dbProp )
            ###print 'DEBUG: -> db replica (R/W):', dbReplica
            dbProp = CoolAuthentication.getDbIdProperties \
                     ( connectString, False ) # R/O
            dbReplica = CoolAuthentication.coralReplica( dbProp )
            print 'DEBUG: -> db replica (R/O):', dbReplica
        readOnly = True
        TestReferenceDb2RO.db = TestReferenceDb2RO.mgr.dbSvc.openDatabase\
                                ( connectString, readOnly )
        print 'DEBUG: Database opened'
        #print 'DEBUG: -> db ID:', TestReferenceDb2RO.db.databaseId()
        dbAttributes = TestReferenceDb2RO.db.databaseAttributes()
        #print 'DEBUG: -> db attributes:', dbAttributes
        dbSchemaVersion = dbAttributes["SCHEMA_VERSION"]
        print 'DEBUG: -> db schema version:', dbSchemaVersion
        if   ( dbSchemaVersion == "1.3.0" ):
            TestReferenceDb2RO.dbSchemaVersion200 = False
            if self.mgr.refSchemaVersion280 :
                print 'ERROR: TestReferenceDb2RO (2.8.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion220 :
                print 'ERROR: TestReferenceDb2RO (2.2.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            elif self.mgr.refSchemaVersion200 :
                print 'ERROR: TestReferenceDb2RO (2.0.0)',\
                      'cannot be executed on a 1.3.0 db'
                sys.exit(-1)
            else :
                print 'DEBUG: Test 1.3.0 reference schema on a 1.3.0 db',\
                      '(R/O test)'
        elif ( dbSchemaVersion == "2.0.0" ):
            TestReferenceDb2RO.dbSchemaVersion200 = True
            if self.mgr.refSchemaVersion280 :
                print 'DEBUG: Test 2.8.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            elif self.mgr.refSchemaVersion220 :
                print 'DEBUG: Test 2.2.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            elif self.mgr.refSchemaVersion200 :
                print 'DEBUG: Test 2.0.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
            else:
                print 'DEBUG: Test 1.3.0 reference schema on a 2.0.0 db',\
                      '(R/O test)'
        else :
            print 'ERROR: unknown database schema', dbSchemaVersion
            sys.exit(-1)
        if self.invalidateCacheUrl != "":
            print 'DEBUG: Refresh Frontier cache for', self.invalidateCacheUrl
            connSvc = self.mgr.app.connectionSvc()
            webCacheCtl = connSvc.webCacheControl()
            webCacheCtl.refreshSchemaInfo( self.invalidateCacheUrl )

    #-------------------------------------------------------------------------

    def test_2RO_99_finalise(self):
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        print ''
        print 'DEBUG: (TestReferenceDb2RO) Close reference database'
        print 'DEBUG: (TestReferenceDb2RO) **********************************'
        TestReferenceDb2RO.db.closeDatabase()

    #-------------------------------------------------------------------------

    def test_2RO_01_NodeHierarchy(self):
        #print 'DEBUG: Test01'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        self.assert_( self.db.existsFolderSet( '/ReferenceSpec' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec/SV' ) )
        self.assert_( self.db.existsFolderSet( '/SimpleSpec/MV' ) )
        self.assert_( self.db.existsFolder( '/ReferenceSpec/ref' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/SV/sv1' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv1' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv2' ) )
        # The following are created in the RW test
        self.assert_( self.db.existsFolderSet( '/TestRW' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/SV/sv2' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv3' ) )
        self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv4' ) )
        self.assert_( self.db.existsFolder( '/LongSpec' ) )

    #-------------------------------------------------------------------------

    # Test for Frontier bug #42465: repeat the previous test with
    # FRONTIER_FORCERELOAD=none to check if the Squid was updated persistently
    def test_2RO_01bis_NodeHierarchy(self):
        #print 'DEBUG: Test01bis'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        envKey = "FRONTIER_FORCERELOAD"
        self.assert_( envKey in os.environ )
        ###self.assertEquals( os.environ[envKey], "short" )
        envOld = os.environ[envKey]
        os.environ[envKey] = "none"
        self.assertEquals( os.environ[envKey], "none" )
        try:
            self.assert_( self.db.existsFolderSet( '/ReferenceSpec' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpec' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpec/SV' ) )
            self.assert_( self.db.existsFolderSet( '/SimpleSpec/MV' ) )
            self.assert_( self.db.existsFolder( '/ReferenceSpec/ref' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/SV/sv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv1' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv2' ) )
            # The following are created in the RW test
            self.assert_( self.db.existsFolderSet( '/TestRW' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/SV/sv2' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv3' ) )
            self.assert_( self.db.existsFolder( '/SimpleSpec/MV/mv4' ) )
            self.assert_( self.db.existsFolder( '/LongSpec' ) )
        except:
            os.environ[envKey] = envOld
            self.assertEquals( os.environ[envKey], envOld )
            raise

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution.
    # Test method to compare two Records deeply
    # (standard comparison only compares their pointers).
    def assertEqualsAL( self, lhs, rhs, skipA_UCHAR=True, skipA_BLOB64K=True ):
        self.assertEquals( lhs.size(), rhs.size() )
        ##print 'DEBUG: lhs:', lhs
        ##print 'DEBUG: rhs:', rhs
        for i in lhs:
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-type:', type(lhs[i]), 'rhs-type:', type(rhs[i])
            #print 'DEBUG: Attribute:', i,\
            #      'lhs-value:', lhs[i].__repr__(),\
            #      'rhs-value:', rhs[i].__repr__()
            if type(lhs[i]) == float:
                self.assertAlmostEqual( lhs[i], rhs[i], 6 )
            elif i == 'A_UCHAR':
                # A_UCHAR comparison fails for Frontier - see CORAL bug #22307
                if skipA_UCHAR : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            elif i == 'A_BLOB64K' or i == 'A_BLOB16M' :
                # Blobs used to fail for Frontier (bug #22203) - now fixed
                if skipA_BLOB64K : pass
                else : self.assertEquals( lhs[i], rhs[i] )
            else:
                self.assertEquals( lhs[i], rhs[i] )

    #-------------------------------------------------------------------------

    # Tests retrieving data from a new SV folder.
    def test_2RO_02_readNewFolderSV(self):
        #print 'DEBUG: Test02'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')

        # Access and test SV HEAD
        f = self.db.getFolder( '/SimpleSpec/SV/sv2' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection.all() )
        self.assertEquals( 4, objs.size() )

    #-------------------------------------------------------------------------

    # Test for findObject for MV HEAD and tag
    def test_2RO_04_findMV_headTag(self):
        #print 'DEBUG: Test04'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        fmv1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        obj = fmv1.findObject( 10, 1 )

        # A new IOV is inserted during the RW test
        ###self.assertEquals(  5, obj.since() )
        ###self.assertEquals( 15, obj.until() )
        ###self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )
        self.assertEquals(  7, obj.since() )
        self.assertEquals( 12, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Test for findObject for MV user tag (test for Frontier MV bug #19753)
    def test_2RO_05_findMV_userTag(self):
        #print 'DEBUG: Test05'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        fmv2 = self.db.getFolder( '/SimpleSpec/MV/mv2' )
        obj = fmv2.findObject( 10, 1, "UserTag A2" )

        # A new IOV is inserted during the RW test
        ###self.assertEquals(  5, obj.since() )
        ###self.assertEquals( 15, obj.until() )
        ###self.assertEqualsAL( self.mgr.simplePayload( 130 ), obj.payload() )
        self.assertEquals(  7, obj.since() )
        self.assertEquals( 17, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 140 ), obj.payload() )

    #-------------------------------------------------------------------------

    # From RelationalCool/tests/SchemaEvolution/Attic/test_ReferenceDb.py
    # [this was test_02_content_sv1]
    def test_2RO_08_content_sv(self):
        #print 'DEBUG: Test08'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')
        f = self.db.getFolder( '/SimpleSpec/SV/sv1' )
        objs = f.browseObjects( cool.ValidityKeyMin,
                                cool.ValidityKeyMax,
                                cool.ChannelSelection(0) )

        # A new IOV is inserted during the RW test
        ###self.assertEquals( 4, objs.size() )
        self.assertEquals( 5, objs.size() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 0, obj.since() )
        self.assertEquals( 10, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 1 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 10, obj.since() )
        self.assertEquals( 15, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 2 ), obj.payload() )

        obj = self.mgr.getNext( objs )
        self.assertEquals( 15, obj.since() )
        self.assertEquals( 20, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 3 ), obj.payload() )

        # A new IOV is inserted during the RW test
        ###obj = self.mgr.getNext( objs )
        ###self.assertEquals( 20, obj.since() )
        ###self.assertEquals( cool.ValidityKeyMax, obj.until() )
        ###self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )
        obj = self.mgr.getNext( objs )
        self.assertEquals( 20, obj.since() )
        self.assertEquals( 25, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 4 ), obj.payload() )
        obj = self.mgr.getNext( objs )
        self.assertEquals( 25, obj.since() )
        self.assertEquals( cool.ValidityKeyMax, obj.until() )
        self.assertEqualsAL( self.mgr.simplePayload( 5 ), obj.payload() )

    #-------------------------------------------------------------------------

    # Tests HVS tag relations.
    def test_2RO_17_tagRelations(self):
        #print 'DEBUG: Test17'
        if TestReferenceDb2RO.db == 0 : return self.abort('The database is not open')

        # Test HVS tag relations
        f1 = self.db.getFolder( '/SimpleSpec/MV/mv1' )
        self.assertEquals( "Tag B1", f1.findTagRelation( "HVS tag" ) )

##############################################################################

