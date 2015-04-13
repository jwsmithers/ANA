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

def parseSelect( text, uppercase, debug=False ):
    ###if debug : print "0bis - Parse:", text
    # Remove newline characters
    text = text.replace('\n','')
    # Remove actual newline characters
    text = text.replace('\\n','')
    # Remove tab characters
    text = text.replace('\t','')
    if debug : print "1 - Parse:", text
    if uppercase :
        ltr = '<TR>'
        rtr = '</TR>'
        ltd = '<TD>'
        rtd = '</TD>'
    else :
        ltr = '<tr>'
        rtr = '</tr>'
        ltd = '<td>'
        rtd = '</td>'
    ###if debug : print "2a - Parse:", text
    text=text.replace(ltr+ltr,ltr) # MySQL has a <TR><TR> for the first row...
    text=text.replace(' align="right"','') # Oracle may use <td align="right">
    ###if debug : print "2b - Parse:", text
    nl = text.count( ltr )
    nr = text.count( rtr )
    if nl!=nr :
        print "ERROR! Count mismatch for '"+ltr+"' and '"+rtr + "' (",\
              nl, nr, ") in '"+text+"'"
        sys.exit(-1)
    nl = text.count( ltd )
    nr = text.count( rtd )
    if nl!=nr :
        print "ERROR! Count mismatch for '"+ltd+"' and '"+rtd + "' (",\
              nl, nr, ") in '"+text+"'"
        sys.exit(-1)
    rows = []
    for row in text.split( ltr ):
        newRow = myRPartition( row, rtr )
        if debug : print "3 - Parse:", newRow
        nl = newRow.count( ltd )
        nr = newRow.count( rtd )
        if nl!=nr :
            print "ERROR! Count mismatch for '"+ltd+"' and '"+rtd + "' (",\
                  nl, nr, ") in '"+newRow+"'"
            sys.exit(-1)
        elif nl!=0 :
            flds = []
            ifld = 0
            for fld in newRow.split( ltd ):
                ifld=ifld+1
                if ifld > 1 :
                    newFld = myRPartition( fld, rtd )
                    if debug : print "4 - Parse:", newFld
                    flds.append( newFld )
            rows.append( flds )
    if debug : print "5 - End parsing"
    return rows

def oracleSelect( dbIdProp, sql, debug=False ) :
    if debug : print "0 - Executing SQL: '" + sql + "'"
    #if os.environ["OS"] == "Windows_NT" :
    #    print "ERROR! CoolQueryManager is not supported for technology 'oracle' on OS '" + os.environ["OS"] + "' (on OSTYPE '" + os.environ["OSTYPE"] + "')"
    #    sys.exit(-1)
    server = CoolAuthentication.server( dbIdProp )
    schema = CoolAuthentication.schema( dbIdProp ).upper()
    user = CoolAuthentication.user( dbIdProp )
    password = CoolAuthentication.password( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if password != "" : proxy = user # Username/Password
    else: proxy = "[" + schema + "]" # Kerberos proxy
    if os.environ["OS"] != "Windows_NT" :
        cmd = 'echo "' + sql + '" | sqlplus -S -L -M "HTML ON" "' + proxy + '/' + password + '@' + server + '"'
        cmd_no_passwd = 'echo "' + sql + '" | sqlplus -S -L -M "HTML ON" "' + proxy + '/***' + '@' + server + '"'
        ###columns = []
        ###os.system(cmd)
        ###return columns
        fout = os.popen(cmd)
    else :
        cmd = 'sqlplus -S -L -M "HTML ON" "' + proxy + '/' + password + '@' + server + '"'
        cmd_no_passwd = 'sqlplus -S -L -M "HTML ON" "' + proxy + '/***' + '@' + server + '"'
        if debug : print "0 - Open pipe for command: '" + cmd_no_passwd + "'"
        index = sql.find('\*')
        if index!=-1 :
            if debug : print "0 - Replace '\*' by '*' in SQL"
        if debug : print "0 - Input to pipe is SQL statement: '" + sql.replace('\*','*') + "'"
        # See for instance http://effbot.org/librarybook/popen2.htm
        pipe = os.popen2(cmd)
        fin=pipe[0]
        fout=pipe[1]
        fin.write(sql.replace('\*','*')+'\n')
        fin.flush()
        fin.close()
    text = ""
    line = fout.readline()
    while line :
        text = text + line + " "
        line = fout.readline()
    status = fout.close()
    if status :
        print "ERROR! Command '" + cmd_no_passwd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    uppercase = False
    return parseSelect( text, uppercase, debug )

def mysqlSelect( dbIdProp, sql, debug=False ) :
    if debug : print "0 - Executing SQL: '" + sql + "'"
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
    cmd = 'mysql --html -u'+user + ' -p'+password + server + ' ' + schema + ' -B -N -e "'+sql + '"'
    ###print cmd
    cmd_no_passwd = 'mysql --html -u'+user + ' -p***' + server + ' ' + schema + ' -B -N -e "'+sql + '"'
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
    uppercase = True
    return parseSelect( text, uppercase, debug )

def sqliteSelect( dbIdProp, sql, debug=False ) :
    if debug : print "0 - Executing SQL: '" + sql + "'"
    schema = CoolAuthentication.schema( dbIdProp )
    dbName = CoolAuthentication.dbName( dbIdProp )
    if not os.path.exists( schema ) :
        print "ERROR! SQLite database file not found:", schema
        sys.exit(-1)
    cmd = 'sqlite3 -html ' + schema + ' "' + sql + '"'
    f = os.popen(cmd)
    text = ""
    line = f.readline()
    while line :
        text = text + line + " "
        line = f.readline()
    status = f.close()
    if status :
        print "ERROR! Command '" + cmd + "' failed! Status code:", status
        ###sys.exit(status) # Fix for bug #53850
        sys.exit(-1)
    uppercase = True
    return parseSelect( text, uppercase, debug )

def executeSqlSelect( dbId, sql, debug=False ) :
    if debug : print "Executing SQL statement: '" + sql + "'"
    index = sql.find('select')
    if index!=0 :
        index = sql.find('SELECT')
        if index!=0 :
            print "ERROR! Only 'SELECT' SQL statements are supported"
            sys.exit(-1)
    if debug : print "COOL dbId: '" + dbId + "'"
    dbIdProp = CoolAuthentication.getDbIdProperties( dbId, debug )
    tech = CoolAuthentication.technology( dbIdProp )
    if debug : print "Technology: '" + tech + "'"
    if tech == "oracle" :
        columns = oracleSelect( dbIdProp, sql, debug )
    elif tech == "mysql" :
        columns = mysqlSelect( dbIdProp, sql, debug )
    elif tech == "sqlite" :
        columns = sqliteSelect( dbIdProp, sql, debug )
    else :
        print "ERROR! CoolQueryManager is not supported for technology '" + tech + "'"
        sys.exit(-1)
    return columns
