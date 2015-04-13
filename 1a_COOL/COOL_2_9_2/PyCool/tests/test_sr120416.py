from PyCool import cool
app = cool.Application()
svc = app.databaseService()
db = svc.openDatabase( "oracle://rdtest2-scan:10121/rdtest2.cern.ch;schema=avalassi;dbname=SMVTRCWD;" )
f1 = db.getFolder( "/f1" );
outLvl = app.outputLevel()
app.setOutputLevel( cool.MSG.VERBOSE )
fo = f1.firstIovInTag( "myheadtag" );
fl = f1.lastIovInTag( "myheadtag" );
