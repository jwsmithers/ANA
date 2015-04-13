import sys
from PyCoolCopy import PyCoolCopy, Selection

if len(sys.argv) != 3:
    print 'Usage: %s <source> <target>' % sys.argv[0]
    sys.exit(-1)

source = sys.argv[1]
target = sys.argv[2]

PyCoolCopy( source ).copy( target, Selection( '/' ) )


