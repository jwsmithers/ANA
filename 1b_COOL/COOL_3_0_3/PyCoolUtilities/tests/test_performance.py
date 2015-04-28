
import sys, os

from PyCoolPayloader import PyCoolPayloader

envKey = "COOLTESTDB"

def main():
    if len(sys.argv) == 2:
        connectString = sys.argv[1]
    elif envKey in os.environ:
        connectString = os.environ[envKey]
    else:
        print 'usage:', sys.argv[0], '<connect string>'
        print '<connect string>: a COOL (RAL) compatible connect string, e.g.'
        print ( '    "oracle://devdb10;schema=atlas_cool_sas;'
                'user=atlas_cool_sas;dbname=COOLTEST"' )
        print 'or set the environment variable %s'%(envKey)
        sys.exit(-1)


    payloader = PyCoolPayloader( connectString, recreateDb = True )

    payloader.writeFolder( '/a' )

    res, msg = payloader.validateFolder( '/a' )

    print msg



if __name__ == '__main__':
    main()

