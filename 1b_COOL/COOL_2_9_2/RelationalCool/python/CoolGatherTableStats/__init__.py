#!/usr/bin/env python
import os, sys
import CoolAuthentication
from CoolShowTables import showTables

def oracleGatherTableStats( dbIdProp, tableName, debug=False ) :
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    sqlDir = __path__[0] + os.sep + 'sql'
    sqlFile = sqlDir  + os.sep + "oracleGatherTableStats.sql"
    if not os.path.exists( sqlFile ) :
        print "ERROR! SQL file not found:", sqlFile
        sys.exit(-1)
    sql = "@" + sqlFile + " " + schema + " " + tableName
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    cmd = "sqlplus -S -L " + proxy + "/" + password + "@" + server + " " + sql
    f = os.system(cmd)
    return

def gatherSingleTableStats( dbIdProp, tableName, debug=False ) :
    if tableName=="":
        print "ERROR! Table name not specified"
        sys.exit(-1)
    print "Gather statistics for table '"+tableName+"'"
    tech = CoolAuthentication.technology( dbIdProp )
    if tech == "oracle" :
        columns = oracleGatherTableStats( dbIdProp, tableName, debug )
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)
    return

def gatherTableStats( dbId, tableName, debug=False ) :
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if tech == "oracle" :
        if tableName=="":
            print "Gather statistics for ALL tables in database '" + dbId + "'"
            for table in showTables( dbId, debug ):
                gatherSingleTableStats( dbIdProp, table, debug )
        else:
            print "Gather statistics for table '" + tableName + \
                  "' in database '" + dbId + "'"
            gatherSingleTableStats( dbIdProp, tableName, debug )
    elif tech == "mysql" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    elif tech == "sqlite" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)

