from PyCool import cool
app = cool.Application()
svc = app.databaseService()
db = svc.openDatabase("COOL-CoralServer-Oracle-avalassi/CT121104")
folders = db.listAllNodes()
for ff in folders:
  if (not db.existsFolder(ff)): continue
  f = db.getFolder(ff)
  print "Got folder",f.fullPath()
