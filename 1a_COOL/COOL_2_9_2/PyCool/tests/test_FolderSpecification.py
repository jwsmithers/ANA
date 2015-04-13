import unittest, sys
from PyCool import cool

app = cool.Application()
svc = app.databaseService()
svr = svc.serviceVersion()
svl = svr.split('.')
if len(svl) != 3 : raise Exception( "Invalid service version: " + svr )
VERSION = int(svl[0])*10000+int(svl[1])*100+int(svl[2])

SV = cool.FolderVersioning.SINGLE_VERSION
MV = cool.FolderVersioning.MULTI_VERSION

if VERSION >= 20900:
    INLINE = cool.PayloadMode.INLINEPAYLOAD
    SEPARATE = cool.PayloadMode.SEPARATEPAYLOAD
    VECTOR = cool.PayloadMode.VECTORPAYLOAD

class TestFolderSpecification( unittest.TestCase ): # test for bug #103351

    def setUp(self):
        self.rspec0 = cool.RecordSpecification()
        self.rspec = cool.RecordSpecification()
        self.rspec.extend("I",cool.StorageType.Int32)
        self.rspec.extend("F",cool.StorageType.Float)
        self.rspec.extend("S",cool.StorageType.String4k)

    def tearDown(self):
        pass

    def test_010_ctor_no3rd(self):
        fspec = cool.FolderSpecification( SV, self.rspec )
        self.assertEqual( SV, fspec.versioningMode() )
        self.assertEqual( self.rspec, fspec.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            self.assertEqual( INLINE, fspec.payloadMode() )

    def test_020_ctor_boolean3rd(self):
        SV = cool.FolderVersioning.SINGLE_VERSION
        # 3rd argument is false (0): expect inline payload
        fspec = cool.FolderSpecification( SV, self.rspec, False )
        self.assertEqual( SV, fspec.versioningMode() )
        self.assertEqual( self.rspec, fspec.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            self.assertEqual( INLINE, fspec.payloadMode() )
        # 3rd argument is true (1): expect separate payload
        fspec = cool.FolderSpecification( SV, self.rspec, True )
        self.assertEqual( SV, fspec.versioningMode() )
        self.assertEqual( self.rspec, fspec.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( True, fspec.hasPayloadTable() )
        else:
            self.assertEqual( SEPARATE, fspec.payloadMode() )

    def test_030_ctor_int3rd(self):
        SV = cool.FolderVersioning.SINGLE_VERSION
        # 3rd argument is 0 (false): expect inline payload
        fspec = cool.FolderSpecification( SV, self.rspec, 0 )
        self.assertEqual( SV, fspec.versioningMode() )
        self.assertEqual( self.rspec, fspec.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            self.assertEqual( INLINE, fspec.payloadMode() )
        # 3rd argument is 1 (true): expect separate payload
        fspec = cool.FolderSpecification( SV, self.rspec, 1 )
        self.assertEqual( SV, fspec.versioningMode() )
        self.assertEqual( self.rspec, fspec.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( True, fspec.hasPayloadTable() )
        else:
            self.assertEqual( SEPARATE, fspec.payloadMode() )
        # 3rd argument is 2: expect separate payload on 290,
        # but expect an exception on 28x
        if VERSION < 20900:
            try: fspec = cool.FolderSpecification( SV, self.rspec, 2 )
            except TypeError: pass
            else: self.fail( '3rd arg == 2 should throw in COOL28x' )
        else:
            fspec = cool.FolderSpecification( SV, self.rspec, 2 )
            self.assertEqual( SV, fspec.versioningMode() )
            self.assertEqual( self.rspec, fspec.payloadSpecification() )
        # 3rd argument is 3: expect an exception
        try: fspec = cool.FolderSpecification( SV, self.rspec, 3 )
        except TypeError: pass
        else: self.fail( '3rd arg == 3 should always throw' )
        # 3rd argument is -1: expect an exception
        try: fspec = cool.FolderSpecification( SV, self.rspec, -1 )
        except TypeError: pass
        else: self.fail( '3rd arg == -1 should always throw' )

    def test_040_other_ctors(self):
        # default ctor
        if VERSION < 20900:
            fspec = cool.FolderSpecification()
            self.assertEqual( SV, fspec.versioningMode() )
            self.assertEqual( self.rspec0, fspec.payloadSpecification() ) # no fields
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            try: fspec = cool.FolderSpecification()
            except TypeError: pass
            else: self.fail( 'default ctor should throw in COOL290' )
        # ctor from versioning mode
        if VERSION < 20900:
            fspec = cool.FolderSpecification( SV )
            self.assertEqual( SV, fspec.versioningMode() )
            self.assertEqual( self.rspec0, fspec.payloadSpecification() ) # no fields
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            try: fspec = cool.FolderSpecification( SV )
            except TypeError: pass
            else: self.fail( 'ctor from versioning mode should throw in COOL290' )
        # ctor from payload specification
        if VERSION < 20900:
            try: fspec = cool.FolderSpecification( self.rspec )
            except TypeError: pass
            else: self.fail( 'ctor from payload spec should throw in COOL28x' )
        else:
            fspec = cool.FolderSpecification( self.rspec )
            self.assertEqual( SV, fspec.versioningMode() )
            self.assertEqual( self.rspec, fspec.payloadSpecification() )
            self.assertEqual( INLINE, fspec.payloadMode() )
        # ctor with 1 argument == 0
        if VERSION < 20900:
            fspec = cool.FolderSpecification( 0 )
            self.assertEqual( SV, fspec.versioningMode() )
            self.assertEqual( self.rspec0, fspec.payloadSpecification() ) # no fields
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            try: fspec = cool.FolderSpecification( 0 )
            except TypeError: pass
            else: self.fail( 'ctor from 1 arg == 0 should throw in COOL290' )
        # ctor with 1 argument == 1
        if VERSION < 20900:
            fspec = cool.FolderSpecification( 1 )
            self.assertEqual( MV, fspec.versioningMode() ) # MV
            self.assertEqual( self.rspec0, fspec.payloadSpecification() ) # no fields
            self.assertEqual( False, fspec.hasPayloadTable() )
        else:
            try: fspec = cool.FolderSpecification( 1 )
            except TypeError: pass
            else: self.fail( 'ctor from 1 arg == 1 should throw in COOL290' )
        # ctor with 1 argument == 2
        try: fspec = cool.FolderSpecification( 2 )
        except TypeError: pass
        else: self.fail( 'ctor from 1 arg == 2 should always throw' )
        # ctor with 1 argument == -1
        try: fspec = cool.FolderSpecification( -1 )
        except TypeError: pass
        else: self.fail( 'ctor from 1 arg == -1 should always throw' )
        # copy ctor (explicit in COOL290, default in COOL28x)
        fspec = cool.FolderSpecification( SV, self.rspec )
        fspec2 = cool.FolderSpecification( fspec )
        self.assertEqual( SV, fspec2.versioningMode() )
        self.assertEqual( self.rspec, fspec2.payloadSpecification() )
        if VERSION < 20900:
            self.assertEqual( False, fspec2.hasPayloadTable() )
        else:
            self.assertEqual( INLINE, fspec2.payloadMode() )

        
#######################################################################

if __name__ == '__main__':
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

