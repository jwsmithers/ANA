import unittest, sys, os

from PyCool import cool
from PyCoolCopy import PyCoolCopy, silent, dbExists
from PyCoolPayloader import PyCoolPayloader

silent()

class TestPyCoolCopy( unittest.TestCase ):

    def setUp(self):
        print 'Entering setUp'
        self.source = PyCoolPayloader( sourceConnectString,
                                       recreateDb = True )
        self.target = PyCoolPayloader( targetConnectString,
                                       recreateDb = True )
        print 'Exiting setUp'

    def tearDown(self):
        print 'Entering tearDown'
        del self.source.db
        del self.target.db
        print 'Exiting tearDown'

    def test_dbExists(self):
        print 'Entering test_dbExists'
        self.assert_( dbExists( targetConnectString ),
                      'db does not exist when it should' )
        dbSvc = cool.DatabaseSvcFactory.databaseService()
        dbSvc.dropDatabase( targetConnectString )
        print 'About to open non-existent database'
        try:
            dbSvc.openDatabase( targetConnectString )
            print '??? Database open ???'
        except Exception, e:
            print 'Exception: database not open'
            pass
        #print 'About to test existence of non-existent database'
        #self.assert_( not dbExists( targetConnectString ),
        #              'db exists when it should not' )
        print 'Exiting test_dbExists'

#######################################################################

sourceKey = "COOLTESTDB_SOURCE"
targetKey = "COOLTESTDB_TARGET"

if __name__ == '__main__':
    if sourceKey in os.environ and targetKey in os.environ:
        print 'Env variable %s and %s are both set'%( sourceKey, targetKey )
        sourceConnectString = os.environ[sourceKey]
        targetConnectString = os.environ[targetKey]
    else:
        print 'Env variable %s or %s is not set'%( sourceKey, targetKey )
        print 'Using default source and target connection strings'
        sourceConnectString = 'sqlite://;schema=sqliteTestMutexLock-S.db;dbname=COOLTEST'
        targetConnectString = 'sqlite://;schema=sqliteTestMutexLock-T.db;dbname=COOLTEST'
    print 'Source:', sourceConnectString
    print 'Target:', targetConnectString
    unittest.main( testRunner =
                   unittest.TextTestRunner(stream=sys.stdout,verbosity=2) )


