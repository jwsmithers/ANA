#!/usr/bin/env python

import unittest, sys

from PyCool import cool, coral, is_64bits

class TestBlob( unittest.TestCase ):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def _test_005_typedef(self):
        """Check cool.Blob64k typedef"""
        self.assert_(cool.Blob64k == coral.Blob)
        self.assert_(dir(cool.Blob64k) == dir(coral.Blob))

    def _test_006_typedef(self):
        """Check cool.Blob16M typedef"""
        self.assert_(cool.Blob16M == coral.Blob)
        self.assert_(dir(cool.Blob16M) == dir(coral.Blob))

    def test_010_init(self):
        """Initialization"""
        blob = coral.Blob()
        self.assert_( not blob is None )

        N = 100
        blob = coral.Blob(N)
        self.assert_( not blob is None and blob.size() == N )

    def test_015_len(self):
        """Operator __len__"""
        N = 100
        blob = coral.Blob(N)
        self.assert_( blob.size() == len(blob) )

    def test_020_access(self):
        """Access bytes"""
        N = 100
        blob = coral.Blob(N)
        for i in range(N):
            blob[i] = i%256
        for i in range(N):
            self.assert_(blob[i] == i%256)

    def test_030_iterator(self):
        """Iterate over bytes"""
        N = 100
        blob = coral.Blob(N)
        for i in range(N):
            blob[i] = i%256
        i = 0
        for j in blob:
            self.assert_(j == i)
            i += 1

    def test_040_file_interface(self):
        """File-like interface"""
        blob = coral.Blob()

        blob.write('0123456789')
        blob.write('abcdefghij')
        self.assert_( 20 == len(blob) )

        blob.seek(0)
        self.assert_( "01234" == blob.read(5) )

        blob.seek(5,1)
        self.assert_( "abcde" == blob.read(5) )

        blob.seek(-3,2)
        self.assert_( "hij" == blob.read() )

        blob.seek(13)
        self.assert_( 13 == blob.tell() )

if __name__ == '__main__':
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

