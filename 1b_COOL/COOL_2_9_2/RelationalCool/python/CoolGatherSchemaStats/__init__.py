#!/usr/bin/env python
import os, sys
import CoolAuthentication

def oracleGatherSchemaStats( dbIdProp, debug=False ) :
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    sqlDir = __path__[0] + os.sep + 'sql'
    sqlFile = sqlDir  + os.sep + "oracleGatherSchemaStats.sql"
    if not os.path.exists( sqlFile ) :
        print "ERROR! SQL file not found:", sqlFile
        sys.exit(-1)
    sql = "@" + sqlFile + " " + schema
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    cmd = "sqlplus -S -L " + proxy + "/" + password + "@" + server + " " + sql
    f = os.system(cmd)
    return

def gatherSchemaStats( dbId, debug=False ) :
    print "Gather statistics for schema hosting database '"+dbId+"'"
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if tech == "oracle" :
        columns = oracleGatherSchemaStats( dbIdProp, debug )
    elif tech == "mysql" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    elif tech == "sqlite" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)
    return
