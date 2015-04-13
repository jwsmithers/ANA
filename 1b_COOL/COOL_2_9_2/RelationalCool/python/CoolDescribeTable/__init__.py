#!/usr/bin/env python
# See http://docs.python.org/lib/string-methods.html
import os, sys
import CoolAuthentication

def myLPartition( text, sep ):
    index = text.find(sep)
    if index==-1 : return text
    else : return text[(index+1):].strip(' ')

def myRPartition( text, sep ):
    index = text.rfind(sep)
    if index==-1 : return text
    else : return text[:index].strip(' ')

def mySplit( text ):
    nl = text.count('(')
    nr = text.count(')')
    if nl!=nr :
        print "ERROR! Count mismatch for '(' and ')'", nl, nr
        sys.exit(-1)
    flds = []
    newFld = ""
    for fld in text.split(','):
        if ( newFld != "" ) : newFld = newFld+","
        newFld = newFld+fld
        if newFld.count('(') == newFld.count(')') :
            flds.append(newFld)
            newFld = ""
    return flds

# See http://dev.mysql.com/doc/refman/4.1/en/create-table.html
def parseCreateTable( txt, debug=False ):
    if debug : print "1 - Parse:", txt
    # Remove newline characters
    txt = txt.replace('\n','')
    # Remove actual newline characters
    txt = txt.replace('\\n','')
    # Parse only the text until the first ";"
    while txt != myRPartition(txt,';') : txt = myRPartition(txt,';')
    # Assume that the current text is a CREATE TABLE statement
    # Parse only the column definition list "( ... , ... )"
    txt = myLPartition(txt,'(')
    txt = myRPartition(txt,')')
    if debug : print "2 - Parse:", txt
    # Split the comma-separated fields of "( ... , ... )"
    # Do not split a field that contains a comma enclosed by parentheses
    columns = []
    for fld in mySplit(txt):
        fld = fld.strip(' ').rstrip(' ').split(' ')
        if debug : print "3 - Parse:", fld
        # Check that there is at least one word in this field
        if len(fld)<=1 : break
        # Word #0 is a column name if it does not define a constraint
        if fld[0] == "CONSTRAINT" : break
        if fld[0] == "KEY" : break
        if fld[0] == "INDEX" : break
        if fld[0] == "PRIMARY" : break
        if fld[0] == "FOREIGN" : break
        if fld[0] == "UNIQUE" : break
        if fld[0] == "FULLTEXT" : break
        if fld[0] == "SPATIAL" : break
        if fld[0] == "CHECK" : break
        name = fld[0]
        # Strip off '`' (mysql)
        name = name.strip('`').rstrip('`')
        # Strip off '"' (sqlite)
        name = name.strip('"').rstrip('"')
        # Word #1 defines the type
        type = fld[1].upper()
        # Word #2 may be an UNSIGNED qualifier
        if len(fld)>2 \
               and fld[2].upper() == "UNSIGNED" :
            type=type+" UNSIGNED"
        # Else word #2 may be a BINARY qualifier
        elif len(fld)>2 \
                 and fld[2].upper() == "BINARY" :
            type=type+" BINARY"
        # Else words #2-3 may define BINARY as "COLLATE xxx_bin"
        elif len(fld)>3 \
                 and fld[2].upper() == "COLLATE" \
                 and fld[3].upper().endswith('_BIN') :
            type=type+" BINARY"
        # Else words #5-6 may define BINARY as "COLLATE xxx_bin"
        elif len(fld)>6 \
                 and fld[2].upper() == "CHARACTER" \
                 and fld[3].upper() == "SET" \
                 and fld[5].upper() == "COLLATE" \
                 and fld[6].upper().endswith('_BIN') :
            type=type+" BINARY"
        column = [ name, type ]
        columns.append(column)
    return columns

def oracleDescribeTable( dbIdProp, table, debug=False ) :
    if debug : print "0 - Describe table: " + table
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    sqlDir = __path__[0] + os.sep + 'sql'
    sqlFile = sqlDir  + os.sep + "oracleShowCreateTable.sql"
    if not os.path.exists( sqlFile ) :
        print "ERROR! SQL file not found:", sqlFile
        sys.exit(-1)
    sql = "@" + sqlFile + " " + schema + " " + table
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    if sys.platform.startswith("win"): # Fix bug #77083
        cmd = "sqlplus -S -L " + proxy + "/" + password + "@" + server + " " + sql
        cmd_no_passwd = "sqlplus -S -L " + proxy + "/" + "***" + "@" + server + " " + sql
    else:
        cmd = "sqlplus -S -L '" + proxy + "/" + password + "@" + server + "' " + sql
        cmd_no_passwd = "sqlplus -S -L '" + proxy + "/" + "***" + "@" + server + "' " + sql
    columns = []
    ###return columns
    f = os.popen(cmd)
    line = f.readline()
    while line :
        if debug : print "1a - Parse: " + line
        line = line.replace('\n','')
        line = line.replace('\t','')
        line = line.strip(' ').rstrip(' ').split()
        if debug : print "1b - Parse: ", line
        # There should be exactly two words in this field
        if len(line)==1 and line[0]!='':
            print "PANIC! Unexpected number of words (too few):", line
            while line:
                print "(popen dump)", line
                line = f.readline()
            print "PANIC! Command '" + cmd_no_passwd + "' failed!"
            sys.exit(-1)
        elif len(line)==2 :
            name = line[0]
            type = line[1].upper()
            column = [ name, type ]
            columns.append(column)
        elif len(line)>2 :
            print "PANIC! Unexpected number of words (too many):", line
            while line:
                print "(popen dump)", line
                line = f.readline()
            print "PANIC! Command '" + cmd_no_passwd + "' failed!"
            sys.exit(-1)
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd_no_passwd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    return columns

def mysqlDescribeTable( dbIdProp, table, debug=False ) :
    if debug : print "0 - Describe table: " + table
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp )
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    # A special treatment is needed for the host:port syntax:
    # the port number must be parsed out and passed explicitly
    index = server.find(':')
    if index!=-1 :
        host = server[:index]
        port = server[index+1:]
        server = " -h" + host + " -P" + port
    else:
        server = " -h" + server
    ###sql = "describe " + schema + "." + table
    ###sql = "show columns from " + schema + "." + table
    sql = "show create table " + schema + "." + table
    # This does not work on Windows... (bug #23438)
    if os.environ["OS"] != "Windows_NT" :
        cmd = "mysql -u"+user + " -p"+password + server + " -B -N -e '"+sql + "'"
        cmd_no_passwd = "mysql -u"+user + " -p"+"***" + server + " -B -N -e '"+sql + "'"
    # This works on Windows... but it might also work elsewhere
    else :
        cmd = 'mysql -u'+user + ' -p'+password + server + ' -B -N -e "'+sql + '"'
        cmd_no_passwd = 'mysql -u'+user + ' -p'+'***' + server + ' -B -N -e "'+sql + '"'
    f = os.popen(cmd)
    text = ""
    line = f.readline()
    while line :
        text = text + line + " "
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd_no_passwd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    return parseCreateTable( text, debug )

def sqliteDescribeTable( dbIdProp, table, debug=False ) :
    if debug : print "0 - Describe table: " + table
    schema = CoolAuthentication.schema( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if not os.path.exists( schema ) :
        print "ERROR! SQLite database file not found:", schema
        sys.exit(-1)
    sql = ".schema " + table
    # This does not work on Windows... (bug #23438)
    if os.environ["OS"] != "Windows_NT" :
        cmd = "sqlite3 " + schema + " '" + sql + "'"
    # This works on Windows... but it might also work elsewhere
    else :
        cmd = 'sqlite3 ' + schema + ' "' + sql + '"'
    f = os.popen(cmd)
    text = ""
    line = f.readline()
    while line :
        text = text + line + " "
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd + "' failed! Status code:", status
        if status == 32512 and os.environ["OS"] != "Windows_NT" :
            print "*** os.environ[\"PATH\"] = " + os.environ["PATH"]
            f = os.popen("echo $PATH")
            print "*** `echo $PATH` returns " + f.readline()
            f.close()
            f = os.popen("which sqlite3")
            print "*** `which sqlite3` returns " + f.readline()
            f.close()
        print "*** Command '" + cmd + "' output: START ***"
        print text # Debug bug #67946
        print "*** Command '" + cmd + "' output: END ***"
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    return parseCreateTable( text, debug )

def describeTable( dbId, table, debug=False ) :
    if debug : print "COOL dbId: '" + dbId + "'"
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if debug : print "Describe table: '" + table + "'"
    if tech == "oracle" :
        columns = oracleDescribeTable( dbIdProp, table, debug )
    elif tech == "mysql" :
        columns = mysqlDescribeTable( dbIdProp, table, debug )
    elif tech == "sqlite" :
        columns = sqliteDescribeTable( dbIdProp, table, debug )
    else :
        print "ERROR! Technology '" + tech + "' is not supported"
        sys.exit(-1)
    return columns
