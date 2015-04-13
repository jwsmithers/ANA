#!/usr/bin/env python

import unittest, sys

from PyCool import cool, coral, is_64bits

class TestAttributeList( unittest.TestCase ):

    def setUp(self):
        self.alist = coral.AttributeList()
        self.alist.extend( "i", "int" )
        self.alist.extend( "f", "float" )
        self.alist.extend( "d", "double" )
        self.alist.extend( "s", "string" )


    def tearDown(self):
        pass


    def test_010_init(self):
        # Initialization
        alist = coral.AttributeList()
        self.assert_( not alist is None )
        alist = coral.AttributeList( self.alist )
        self.assert_( not alist is None )
        #alist = coral.AttributeList( self.spec )
        #self.assert_( not alist is None )


    def test_020_init_bad_type(self):
        # Initialization with  bad type
        caughtTypeError = False
        try:
            alist = coral.AttributeList( 'bad' )
        except TypeError, e:
            caughtTypeError = True
        self.assert_( caughtTypeError )


    def test_030_keys(self):
        # Keys
        keys = self.alist.keys()
        self.assertEquals( len(keys), 4 )
        self.assert_( 'i' in keys )
        self.assert_( 'f' in keys )
        self.assert_( 'd' in keys )
        self.assert_( 's' in keys )


    def test_040_typeNames(self):
        # Type names
        types = self.alist.typeNames()
        self.assertEquals( len(types), 4 )
        self.assert_( 'int' in types )
        self.assert_( 'float' in types )
        self.assert_( 'double' in types )
        self.assert_( 'string' in types )


    def test_050_typeName(self):
        # Type name
        self.assertEquals( self.alist.typeName( "i" ), 'int' )


    def test_060_typeName_bad_key(self):
        # Type name with bad key
        self.assertRaises( KeyError, self.alist.typeName, 'bad' )


    def test_070_getitem(self):
        # getitem
        self.assertEquals( self.alist["i"], 0 )


    def test_080_getitem_bad_key(self):
        # getitem with bad key
        self.assertRaises( KeyError, self.alist.__getitem__, 'bad' )

        caughtKeyError = False
        try:
            self.alist['bad']
        except KeyError, e:
            caughtKeyError = True
        self.assert_( caughtKeyError )


    def test_090_setitem(self):
        # setitem
        self.alist["i"] = 5
        self.assertEquals( self.alist["i"], 5 )


    def test_100_setitem_bad_key(self):
        # setitem with bad key
        self.assertRaises( KeyError, self.alist.__setitem__, 'bad', 0 )

        caughtKeyError = False
        try:
            self.alist['bad'] = 0
        except KeyError, e:
            caughtKeyError = True
        self.assert_( caughtKeyError )


    def test_110_iter(self):
        # default iteration
        keys = self.alist.keys()
        self.assertEquals( len(keys), 4 )
        for key in self.alist:
            self.assert_( key in keys, 'failed for key: %s' % key )
            keys.remove( key )
        self.assertEquals( len(keys), 0 )


    def test_120_iterkeys(self):
        # iterkeys
        keys = self.alist.keys()
        for key in self.alist.iterkeys():
            self.assert_( key in keys, 'failed for key: %s' % key )
            keys.remove( key )
        self.assertEquals( len(keys), 0 )


    def test_130_contains(self):
        # contains
        for key in [ 'i', 'f', 'd' ]:
            self.assert_( key in self.alist, 'failed for key: %s' % key )
        self.assert_( 'bad' not in self.alist )


    def test_140_size(self):
        # size and len
        self.assertEquals( self.alist.size(), 4 )
        self.assertEquals( len(self.alist), 4 )

    def test_150_independence(self):
        # independence
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a1["i"] = 1
        self.assertEquals( a1["i"], 1 )

        a2 = coral.AttributeList()
        a2.extend( "i", "int" )
        a2["i"] = 2
        self.assertEquals( a1["i"], 1 )
        self.assertEquals( a2["i"], 2 )


    def test_160_eq_type(self):
        # Test __eq__ for different types.
        a1 = coral.AttributeList()
        from PyCool import getRootVersion
        _ROOT_vers = getRootVersion()
        # ROOT <= 5.22
        if _ROOT_vers[:2] <= (5,22):
            try: a1 != 'wrong type'
            except TypeError: return
            self.fail()
        # ROOT >= 5.23 (see bug #49690)
        else:
            self.assert_( a1 != 'wrong type' )

    def test_170_eq_size(self):
        # Test __eq__ for different list sizes.
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a2 = coral.AttributeList()
        a2.extend( "i", "int" )
        a2.extend( "j", "int" )
        self.assert_( a1 != a2 )


    # this test doesn't work because coral::AttributeList::operator== does not check the keys.
    def test_180_eq_spec_keys(self):
        # Test __eq__ for list specs with different keys.
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a2 = coral.AttributeList()
        a2.extend( "j", "int" )
        self.assert_( a1 == a2 )


    def test_190_eq_spec_types(self):
        # Test __eq__ for list specs with different types.
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a2 = coral.AttributeList()
        a2.extend( "i", "float" )
        self.assert_( a1 != a2 )


    def test_200_eq_value(self):
        # Test __eq__ for different list values.
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a2 = coral.AttributeList()
        a2.extend( "i", "int" )
        a1["i"] = 1
        a2["i"] = 2
        self.assert_( a1 != a2 )
        a2["i"] = 1
        self.assert_( a1 == a2 )


    def test_210_ne(self):
        # Tests != comparison of AttributeLists.
        a1 = coral.AttributeList()
        a1.extend( "i", "int" )
        a2 = coral.AttributeList()
        a2.extend( "i", "int" )
        a1["i"] = 1
        a2["i"] = 2
        self.assert_( a1 != a2 )
        a2["i"] = 1
        self.assert_( not a1 != a2 ) # NB: this is different than a1 == a2!

    def test_220_supported_types(self):
        # Tests creation of a attributes with all supported types and assigning
        # values according to their maximum range (where applicable).

        payload = coral.AttributeList()
        payload.extend( "A_BOOL", "bool" )
        # not supported by COOL:
        #payload.extend( "A_CHAR", "char" ) # RAL MySQL error on retrieval
        payload.extend( "A_UCHAR", "unsigned char" )
        payload.extend( "A_SHRT", "short" )
        payload.extend( "A_USHRT", "unsigned short" )
        payload.extend( "A_INT", "int" )
        payload.extend( "A_UINT", "unsigned int" )
        payload.extend( "A_LONGLONG", "long long" )
        # not supported by COOL:
        #payload.extend( "A_ULONGLONG", "unsigned long long" )
        payload.extend( "A_FLOAT", "float" )
        payload.extend( "A_DOUBLE", "double" )
        # not supported by COOL:
        #payload.extend( "A_LONGDOUBLE", "long double" ) # NO RAL MySQL DEFAULT
        payload.extend( "A_STRING", "string" )
        payload.extend( "A_BLOB", "blob" )

        # assign minimum values (where applicable) and test content
        payload[ "A_BOOL" ] = False
        self.assertEquals( payload["A_BOOL"], False )
        #payload[ "A_CHAR" ] = 'a'
        #self.assertEquals( payload["A_CHAR"], 'a' )
        payload[ "A_UCHAR" ] = 0
        self.assertEquals( payload["A_UCHAR"], '\x00' )
        payload[ "A_SHRT" ] = -32768 # SHRT_MIN
        self.assertEquals( payload["A_SHRT"], -32768 )
        payload[ "A_USHRT" ] = 0
        self.assertEquals( payload["A_USHRT"], 0 )
        payload[ "A_INT" ] = -2147483648 # INT_MIN
        self.assertEquals( payload["A_INT"], -2147483648 )
        payload[ "A_UINT" ] = 0
        self.assertEquals( payload["A_UINT"], 0 )
        payload[ "A_LONGLONG" ] = -9223372036854775808 # sInt64Min
        self.assertEquals( payload["A_LONGLONG"], -9223372036854775808 )
        #payload[ "A_ULONGLONG" ] = 0
        #self.assertEquals( payload["A_ULONGLONG"], 0 )

        payload[ "A_FLOAT" ] = 0.123456789
        self.assertAlmostEquals( payload["A_FLOAT"], 0.123456789, 8 )
        payload[ "A_DOUBLE" ] = 0.123456789012345678901234567890
        self.assertEquals( payload["A_DOUBLE"],
                           0.123456789012345678901234567890 )
        payload[ "A_STRING" ] = "low values"
        self.assertEquals( payload["A_STRING"], "low values" )

        payload[ "A_BLOB" ].resize(10)
        for i in range(10):
            payload[ "A_BLOB" ][i] = 0
        for i in range(10):
            self.assertEquals( payload["A_BLOB"][i], 0 )

        # assign maximum values (where applicable) and test content
        payload[ "A_BOOL" ] = True
        self.assertEquals( payload["A_BOOL"], True )
        #payload[ "A_CHAR" ] = 'Z'
        #self.assertEquals( payload["A_CHAR"], 'Z' )
        payload[ "A_UCHAR" ] = '\xff' # = 255 UCHAR_MAX
        self.assertEquals( payload["A_UCHAR"], '\xff' )
        payload[ "A_SHRT" ] = 32767 # SHRT_MAX
        self.assertEquals( payload["A_SHRT"], 32767 )
        payload[ "A_USHRT" ] = 65535 # USHRT_MAX
        self.assertEquals( payload["A_USHRT"], 65535 )
        payload[ "A_INT" ] = 2147483647 # INT_MAX
        self.assertEquals( payload["A_INT"], 2147483647 )
        payload[ "A_UINT" ] = 4294967295 # UINT_MAX
        self.assertEquals( payload["A_UINT"], 4294967295 )
        payload[ "A_LONGLONG" ] = 9223372036854775807 # sInt64Max
        self.assertEquals( payload["A_LONGLONG"], 9223372036854775807 )
        #payload[ "A_ULONGLONG" ] = 9223372036854775807 # sInt64Max
        #self.assertEquals( payload["A_ULONGLONG"], 9223372036854775807 )

        payload[ "A_FLOAT" ] = 0.987654321098765432109876543210
        self.assertAlmostEquals( payload["A_FLOAT"],
                                 0.987654321098765432109876543210, 7 )
        payload[ "A_DOUBLE" ] = 0.987654321098765432109876543210
        self.assertEquals( payload["A_DOUBLE"],
                           0.987654321098765432109876543210 )
        payload[ "A_STRING" ] = "HIGH VALUES"
        self.assertEquals( payload["A_STRING"], "HIGH VALUES" )

        payload[ "A_BLOB" ].resize(10)
        for i in range(10):
            payload[ "A_BLOB" ][i] = 0xff
        for i in range(10):
            self.assertEquals( payload["A_BLOB"][i], 0xff )

    def test_230_null(self):
        # Tests the python way of setting and retrieving the null attributes

        # return value of a null attribute
        self.alist.attribute("i").setNull(True)
        self.assert_( self.alist["i"] is None )

        # return value of a non-null attribute
        self.alist.attribute("i").setNull(False)
        self.assert_( self.alist["i"] is not None )

        # set the value to null attribute
        self.alist["i"] = None
        self.assert_( self.alist["i"] is None )

        # set the value to non-null attribute
        self.alist["i"] = 5
        self.assert_( self.alist["i"] is not None )


if __name__ == '__main__':
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )



