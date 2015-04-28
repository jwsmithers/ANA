#!/usr/bin/env python
import os, sys

def coolStat( file, newTZ="ignore" ) :

    tz='TZ'

    if newTZ == "none" :
        if tz in os.environ:
            #del os.environ[tz]
            print "ERROR! Cannot unset",tz,": please unset it and start again"
            sys.exit(1)
    elif newTZ != "ignore" :
        os.environ[tz] = newTZ

    if tz in os.environ:
        print 'TZ =', os.environ[tz]
    else :
        print 'TZ = [none]'

    cmd = 'coolStat ' + file
    status = os.system(cmd)
    if status>0 : print 'Status =', status
    return status

#######################################################################

if __name__ == '__main__':

    if ( len(sys.argv) == 3 ) :
        file = sys.argv[1]
        newTZ = sys.argv[2]
    elif ( len(sys.argv) == 2 ) :
        file = sys.argv[1]
        newTZ = "ignore"
    else :
        print 'Usage:', sys.argv[0], '<fileName> [<newTZ> | none]'
        sys.exit(1)

    status = coolStat( file, newTZ )
    sys.exit(status>0)
