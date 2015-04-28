
import unittest, sys, os

from PyCool import cool, coral
import traceback


connectString = None

class TestRecordSpecification( unittest.TestCase ):

    def setUp(self):
        self.all_types = {}
        for t in ["Bool",
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
                  "String16M",
                  "Blob64k",
                  "Blob16M"      ] :
            self.all_types[t] = getattr(cool.StorageType,t)
        self.spec = cool.RecordSpecification()
        self.spec.extend("I",cool.StorageType.Int32)
        self.spec.extend("F",cool.StorageType.Float)
        self.spec.extend("S",cool.StorageType.String4k)

        self.expected_keys = ["I","F","S"]
        self.expected_items = [("I",cool.StorageType.Int32),
                               ("F",cool.StorageType.Float),
                               ("S",cool.StorageType.String4k)]

    def tearDown(self):
        pass

    def test_010_all_types(self):
        spec = cool.RecordSpecification()
        try:
            for k,v in self.all_types.items():
                spec.extend(k,v)
        except Exception, e:
            self.fail("unexpected exception: "+str(e))

    def test_020_keys(self):
        self.assertEqual(self.expected_keys,self.spec.keys())

    def test_030_iterator(self):
        i = 0
        for item in self.spec:
            self.assertEqual(self.expected_items[i],(item.name(),item.storageType()))
            i += 1

    def test_040_len(self):
        self.assertEqual(len(self.expected_keys),len(self.spec))

    def test_050_contains(self):
        for i in self.expected_keys:
            self.assertTrue(i in self.spec)

#######################################################################


if __name__ == '__main__':
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )

