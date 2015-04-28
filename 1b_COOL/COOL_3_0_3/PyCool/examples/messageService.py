from PyCool import cool
app = cool.Application()
dbSvc = app.databaseService()
#msgSvc = app.messageService()
msgSvc = app

import os
connectString = os.environ["COOLTESTDB"]
dbSvc.dropDatabase( connectString )
dbSvc.createDatabase( connectString )

outLvl = msgSvc.outputLevel()

# 1 - VERBOSE
print '*********************************************************************'
msgSvc.setOutputLevel( 1 )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

# 2 - DEBUG
print '*********************************************************************'
msgSvc.setOutputLevel( 2 )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

# 3 - INFO
print '*********************************************************************'
msgSvc.setOutputLevel( 3 )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

# Test output to new file
#import sys
#sys.stdout = open("stdout.txt","w")
#sys.stderr = open("stderr.txt","w")
#print 'Output level =', msgSvc.outputLevel()
#db = dbSvc.openDatabase( connectString )
#sys.stdout = sys.__stdout__
#sys.stderr = sys.__stderr__

# 4 - WARNING
print '*********************************************************************'
msgSvc.setOutputLevel( 4 )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

# Test output appending to existing file
#sys.stdout = open("stdout.txt","a")
#sys.stderr = open("stderr.txt","a")
#print 'Output level =', msgSvc.outputLevel()
#db = dbSvc.openDatabase( connectString )
#sys.stdout = sys.__stdout__
#sys.stderr = sys.__stderr__

# 5 - ERROR
print '*********************************************************************'
msgSvc.setOutputLevel( 5 )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

print '*********************************************************************'
msgSvc.setOutputLevel( outLvl )
print 'Output level =', msgSvc.outputLevel()
db = dbSvc.openDatabase( connectString )

