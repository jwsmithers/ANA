#!/usr/bin/env python
import os, sys
import CoolAuthentication

def oracleLockSchemaStats( dbIdProp, debug=False ) :
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    sqlDir = __path__[0] + os.sep + 'sql'
    sqlFile = sqlDir  + os.sep + "oracleLockSchemaStats.sql"
    if not os.path.exists( sqlFile ) :
        print "ERROR! SQL file not found:", sqlFile
        sys.exit(-1)
    sql = "@" + sqlFile + " " + schema
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    cmd = "sqlplus -S -L " + proxy + "/" + password + "@" + server + " " + sql
    f = os.system(cmd)
    return

def lockSchemaStats( dbId, debug=False ) :
    print "Lock statistics for schema hosting database '"+dbId+"'"
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if tech == "oracle" :
        columns = oracleLockSchemaStats( dbIdProp, debug )
    elif tech == "mysql" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    elif tech == "sqlite" :
        print "WARNING! Statistics tools not implemented for technology "+tech
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)
    return
