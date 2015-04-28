import unittest, sys, os

from PyCool import cool

connectString = None

envKey = "COOLTESTDB"

if __name__ == '__main__':
    if ( len(sys.argv) == 2 ):
        connectString = sys.argv[1]
    elif envKey in os.environ:
        connectString = os.environ[envKey]
    else:
        print 'usage:', sys.argv[0], '<connect string>'
        print 'or set the environment variable %s'%(envKey)
        sys.exit(-1)
    dbSvc = cool.DatabaseSvcFactory.databaseService()
    dbSvc.dropDatabase(connectString)
    db = dbSvc.openDatabase(connectString)

