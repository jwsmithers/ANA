#!/usr/bin/env python
# $Id: use_LFCReplicaSvc.py,v 1.2 2008-04-09 17:39:04 marcocle Exp $

# Import python module
from PyCool import cool

# Initialize COOL Application
app = cool.Application()

# Load CORAL LFCReplicaService into the context of cool::Application
# @todo: (MCl) check if it works
coralConf = app.connectionSvc().configuration()
coralConf.setAuthenticationService("CORAL/Services/LFCReplicaService")
coralConf.setLookupService("CORAL/Services/LFCReplicaService");

# Obtain a handle to COOL database service
dbSvc = app.databaseService()

# Open the COOL database
connectString = "LogicalConnectionString/DBNAME"
#connectString = "LogicalConnectionString(manager)/DBNAME"

db = dbSvc.openDatabase( connectString )

# do something with the database
nodes = db.listAllNodes()
for n in nodes:
    print n
