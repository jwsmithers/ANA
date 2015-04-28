#!/usr/bin/python

"""
import sys, time, coral, curses

def printNoData(screen):

    screen.addstr(3, 0, "|")
    screen.addstr(4, 0, "| No data collected yet")
    screen.addstr(5, 0, "|")

    return 6

def printNoTransaction(screen):

    screen.addstr(3, 0, "|")
    screen.addstr(4, 0, "| No transaction can't be initialized yet")
    screen.addstr(5, 0, "|")

    return 6

def runQuery(session, screen):

    schema = session.nominalSchema()

    query01 = schema.tableHandle( "reply_events" ).newQuery()

    attr = coral.AttributeList()

    attr.extend( "count(id)", "unsigned long" )
    attr.extend( "sum(reply_time)", "double" )
    attr.extend( "sum(reply_size)", "unsigned long long" )
    attr.extend( "schema", "string" )
    attr.extend( "tables", "string" )
    attr.extend( "requestid", "unsigned int" )
    attr.extend( "address", "string" )

    query01.addToOutputList( "count(id)", "counts" )
    query01.addToOutputList( "sum(reply_time)", "reply" )
    query01.addToOutputList( "sum(reply_size)", "size" )
    query01.addToOutputList( "schema" )
    query01.addToOutputList( "tables" )
    query01.addToOutputList( "requestid" )
    query01.addToOutputList( "address" )

    query01.defineOutput( attr )

    query01.addToOrderList( "reply DESC" )
    #query01.setDistinct()
    query01.groupBy( "tables" )

    query01.limitReturnedRows( 30 )

    cursor01 = query01.execute()

    rowpos = 3

    while ( cursor01.next() ):

        row = cursor01.currentRow()

        screen.addstr(rowpos,0, "| %15s | %6s | %10s | %10s | %s.%s" % (row[6].data(), row[0].data(), row[1].data(), row[2].data(), row[3].data(), row[4].data()))


        rowpos = rowpos + 1

    return rowpos

def showList(session, screen):

    screen.clear()

    screen.addstr(0,0, "+-----------------+--------+------------+------------+------------------------------------------------")
    screen.addstr(1,0, "| ip-address      | counts | reply-time | reply-size | schema.tables ")
    screen.addstr(2,0, "+-----------------+--------+------------+------------+------------------------------------------------")

    rowpos = 2

    try:

        session.transaction().start(True)

        try:

            rowpos = runQuery(session, screen)


        except:

            rowpos = printNoData(screen)

        session.transaction().commit()

    except:

        rowpos = printNoTransaction(screen)

    screen.addstr(rowpos,0, "+-----------------+--------+------------+------------+------------------------------------------------")
    screen.addstr( rowpos + 1, 0, "")

    screen.refresh()

class CursorHandle:

    def __init__( self ):
        self.stdscr = curses.initscr()
        curses.noecho()
        curses.cbreak()
        #curses.start_color()
        self.stdscr.keypad(True)
        self.stdscr.nodelay(0)
        self.stdscr.refresh()

    def __del__( self ):
        self.close()

    def getScreen( self ):
        return self.stdscr

    def getch( self ):
        return self.stdscr.getch()

    def close( self ):
        curses.nocbreak()
        self.stdscr.keypad(False)
        curses.echo()
        curses.endwin()

if len(sys.argv) < 2:
    print "You have an error in your command options!"
    print
    print "%s [sqlitefile]" % sys.argv[0]
    exit(1)

svc = coral.ConnectionService()

try:
    session = svc.connect( "sqlite_file:%s" % sys.argv[1], coral.access_ReadOnly )
except:
    print "Can't connect to database"
    exit(1)


ch = CursorHandle()

while True:
    session = svc.connect( "sqlite_file:%s" % sys.argv[1], coral.access_ReadOnly )


    showList(session, ch.getScreen() )
    time.sleep(10)

"""
