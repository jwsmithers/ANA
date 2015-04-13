#!/bin/env python

import os
def printVm() :
    pid = os.getpid()
    cmd = 'more /proc/' + repr( pid ) + '/status | egrep \"VmData|VmSize\"'
    p = os.popen(cmd)
    s = p.readline()
    vmData = s[:len(s)-1]
    s = p.readline()
    vmSize = s[:len(s)-1]
    p.close()
    print vmData
    print vmSize

printVm()
# VmSize:     7008 kB
# VmData:     1080 kB

from PyCool import coral
printVm()
# VmSize:    49368 kB
# VmData:    16324 kB

from PyCool import cool
printVm()
# VmSize:    49368 kB
# VmData:    16324 kB

dbSvc = cool.DatabaseSvcFactory.databaseService()
print 'using software release', dbSvc.serviceVersion()
printVm()
# VmSize:    51524 kB
# VmData:    16328 kB

connectString = 'sqlite://;schema=COOLTEST.db;dbname=COOLTEST'
print 'recreating database'
dbSvc.dropDatabase( connectString )
db = dbSvc.createDatabase( connectString )
printVm()
# VmSize:    64100 kB
# VmData:    26832 kB

print 'setting up spec'
spec = cool.RecordSpecification()
spec.extend( 's', cool.StorageType.String255 )
printVm()
# VmSize:    64100 kB
# VmData:    26832 kB

data = cool.Record( spec )
printVm()
# VmSize:    64100 kB
# VmData:    26832 kB

data['s'] = "0123456789abcdef"
printVm()
# WOW...??
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] = "0123456789abcdef"
printVm()
# OK, stable...
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] = ""
printVm()
# ... no decrease ...
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] = "0123456789abcdef"
printVm()
# OK, stable (repeated)
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] += data['s']
printVm()
# ...stable...
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] += data['s']
printVm()
# ...stable...
# VmSize:    64240 kB
# VmData:    26972 kB

data['s'] += data['s']
printVm()
# ...stable...
# VmSize:    64240 kB
# VmData:    26972 kB

print data
printVm()
# ...stable...
# VmSize:    64240 kB
# VmData:    26972 kB

f = db.createFolder( "/folder", spec )
printVm()
# VmSize:    64372 kB
# VmData:    27104 kB

f = db.getFolder( "/folder" )
printVm()
# ...stable...
# VmSize:    64372 kB
# VmData:    27104 kB

f = db.getFolder( "/folder" )
printVm()
# OK, stable (repeated)
# VmSize:    64372 kB
# VmData:    27104 kB

i=0
f.storeObject( i, cool.ValidityKeyMax, data, 1 )
printVm()
# WOW...??
# VmSize:    64504 kB
# VmData:    27236 kB

i+=1
f.storeObject( i, cool.ValidityKeyMax, data, 1 )
printVm()
# VmSize:    64504 kB
# VmData:    27236 kB

for j in range (i, i+1200):
    i+=1
    f.storeObject( i, cool.ValidityKeyMax, data, 1 )
    if ( i/10 > (i-1)/10 ):
        print i
        printVm()

# Stable until i = 310
# VmSize:    64504 kB
# VmData:    27236 kB

# Increase at i = 310, stable until 1200
# VmSize:    64612 kB
# VmData:    27344 kB

f.setupStorageBuffer()
for j in range (i, i+1000):
    i+=1
    f.storeObject( i, cool.ValidityKeyMax, data, 1 )
    if ( i/10 > (i-1)/10 ):
        print i
        printVm()

printVm()
# Stable
# VmSize:    64612 kB
# VmData:    27344 kB
f.flushStorageBuffer()
printVm()
# Increase
# VmSize:    64776 kB
# VmData:    27508 kB

f.setupStorageBuffer()
for j in range (i, i+100):
    i+=1
    f.storeObject( i, cool.ValidityKeyMax, data, 1 )
    if ( i/10 > (i-1)/10 ):
        print i
        printVm()

printVm()
# Stable
# VmSize:    64776 kB
# VmData:    27508 kB
f.flushStorageBuffer()
printVm()
# Stable
# VmSize:    64776 kB
# VmData:    27508 kB

f.setupStorageBuffer()
for j in range (i, i+100):
    i+=1
    f.storeObject( i, cool.ValidityKeyMax, data, 1 )
    if ( i/10 > (i-1)/10 ):
        print i
        printVm()

printVm()
# Increase DURING LOOP at 2090
# VmSize:    64936 kB
# VmData:    27668 kB
f.flushStorageBuffer()
printVm()
# Stable
# VmSize:    64936 kB
# VmData:    27668 kB

f.setupStorageBuffer()
for j in range (i, i+1000):
    i+=1
    f.storeObject( i, cool.ValidityKeyMax, data, 1 )
    if ( i/10 > (i-1)/10 ):
        print i
        printVm()

printVm()
# Increase DURING LOOP at 2410
# VmSize:    65060 kB
# VmData:    27792 kB
# Increase DURING LOOP at 2730
# VmSize:    65196 kB
# VmData:    27928 kB
# Increase DURING LOOP at 3080
# VmSize:    65332 kB
# VmData:    28064 kB
f.flushStorageBuffer()
printVm()
# WOW...?
# VmSize:    67676 kB
# VmData:    30408 kB

f = db.getFolder( "/folder" )
printVm()
# ...stable...
# VmSize:    67676 kB
# VmData:    30408 kB

