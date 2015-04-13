#!/usr/bin/env python
# See http://docs.python.org/lib/string-methods.html
import os, sys
import CoolAuthentication

def oracleShowTables( dbIdProp, debug=False ) :
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "0 - Show tables in database name: " + dbName
    sqlDir = __path__[0] + os.sep + 'sql'
    sqlFile = sqlDir  + os.sep + "oracleShowTables.sql"
    if not os.path.exists( sqlFile ) :
        print "ERROR! SQL file not found:", sqlFile
        sys.exit(-1)
    sql = "@" + sqlFile + " " + schema + " " + dbName
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    cmd = "sqlplus -S -L " + proxy + "/" + password + "@" + server + " " + sql
    tables = []
    ###f = os.system(cmd)
    ###return tables
    f = os.popen(cmd)
    line = f.readline()
    while line :
        if debug : print "1 - Parse: " + line
        line = line.replace('\n','')
        line = line.replace('\t','')
        line = line.strip(' ').rstrip(' ').split()
        # There should be only one field (ignore lines with 0 fields)
        if len(line)==1 :
            table = line[0]
            tables.append(table)
        elif len(line)>1 :
            print "PANIC! Unexpected number of words:", line
            sys.exit(-1)
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    return tables

def mysqlShowTables( dbIdProp, debug=False ) :
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp )
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "0 - Show tables in database name: " + dbName
    # A special treatment is needed for the host:port syntax:
    # the port number must be parsed out and passed explicitly
    index = server.find(':')
    if index!=-1 :
        host = server[:index]
        port = server[index+1:]
        server = " -h" + host + " -P" + port
    else:
        server = " -h" + server
    sql = "show tables like \'" + dbName + "%\'"
    cmd = "mysql -u"+user + " -p"+password + server + " " + schema \
          + " -B -N -e \"" + sql + "\""
    tables = []
    ###f = os.system(cmd)
    ###return tables
    f = os.popen(cmd)
    line = f.readline()
    while line :
        if debug : print "1 - Parse: " + line
        line = line.replace('\n','')
        line = line.replace('\t','')
        line = line.strip(' ').rstrip(' ').split()
        for table in line :
            tables.append(table)
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    tables.sort()
    return tables

def sqliteShowTables( dbIdProp, debug=False ) :
    schema = CoolAuthentication.schema( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "0 - Show tables in database name: " + dbName
    if not os.path.exists( schema ) :
        print "ERROR! SQLite database file not found:", schema
        sys.exit(-1)
    sql = ".tables " + dbName
    cmd = "sqlite3 " + schema + " '" + sql + "'"
    tables = []
    ###f = os.system(cmd)
    ###return tables
    f = os.popen(cmd)
    line = f.readline()
    while line :
        if debug : print "1 - Parse: " + line
        line = line.replace('\n','')
        line = line.replace('\t','')
        line = line.strip(' ').rstrip(' ').split()
        for table in line :
            tables.append(table)
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    tables.sort()
    return tables

def showTables( dbId, debug=False ) :
    if debug : print "COOL dbId: '" + dbId + "'"
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if debug : print "Show tables for database name: '" + dbName + "'"
    if tech == "oracle" :
        columns = oracleShowTables( dbIdProp, debug )
    elif tech == "mysql" :
        columns = mysqlShowTables( dbIdProp, debug )
    elif tech == "sqlite" :
        columns = sqliteShowTables( dbIdProp, debug )
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)
    return columns
