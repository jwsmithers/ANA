#!/usr/bin/env python
import os, sys, time, calendar
from datetime import timedelta
from xml.dom import minidom, Node

def usage() :
    cmd = os.path.split(sys.argv[0])[1]
    print "Usage: " + cmd + " file1.xml [file2.xml...]"
    sys.exit(-1)

def myreport( item, time, ntests ) :
    tests="tests"
    if ntests==1 : tests="test"
    print str(item).ljust(46), \
          (str(time)+" seconds").rjust(17), \
          ("("+str(ntests)+" "+tests+")").rjust(12)

# See http://www.faqs.org/docs/diveintopython/kgp_parse.html
# See http://www.rexx.com/~dkuhlman/pyxmlfaq.html
# See http://pyxml.sourceforge.net/topics/howto/node20.html
def parseQmtestRun( file ) :
    ###print 'Parse qmtest run annotations from file:',file
    print "--- INDIVIDUAL TESTS ---------------------------------------------------------"
    xmldoc = minidom.parse(file)
    for node in xmldoc.childNodes:
        if node.nodeType == Node.ELEMENT_NODE \
               and node.nodeName == "report" :
            report = node
            break
    for node in report.childNodes:
        if node.nodeType == Node.ELEMENT_NODE \
               and node.nodeName == "results" :
            results = node
            break
    tgrptecs = {}
    ngrptecs = {}
    tgrps = {}
    ngrps = {}
    ttecs = {}
    ntecs = {}
    ttotal = 0
    ntotal = 0
    for node in results.childNodes:
        if node.nodeType == Node.ELEMENT_NODE and node.nodeName == "result" :
            testID = node.attributes.get('id').value
            ###print 'DEBUG: id:', testID
            start = 0
            end = 0
            for annotation in node.childNodes:
                if annotation.nodeType == Node.ELEMENT_NODE \
                       and annotation.nodeName == "annotation" :
                    annName = annotation.attributes.get('name').value
                    if annName in [ "qmtest.start_time", "qmtest.end_time" ]:
                        ###print annotation.toxml()
                        data = annotation.firstChild.data
                        data = data.strip(' ')
                        data = data.strip('\n')
                        data = data.strip(' ')
                        data = data.strip('"')
                        data = data.rstrip('Z')
                        date = time.strptime(data,"%Y-%m-%dT%H:%M:%S")
                        if annName == "qmtest.start_time" : start = date
                        if annName == "qmtest.end_time" : end = date
                        ###print 'DEBUG:', annName, data, date
            # Final report for each test
            diff = calendar.timegm(end) - calendar.timegm(start)
            ###diff = timedelta( seconds = diff )
            myreport( testID, diff, 1 )
            # Prepare the summaries
            flds = testID.split('.')
            if len(flds) == 2:
                grp = flds[0]
                tec = "no_db"
            elif len(flds) == 3 or len(flds) == 4:
                grp = flds[0]
                tec = flds[1]
            else:
                print "ERROR! Unkown #fields in", testID
                sys.exit(-1)                
            # Create the appropriate counters and arrays if not yet defined
            if grp not in tgrptecs : tgrptecs[grp] = {}
            if tec not in tgrptecs[grp] : tgrptecs[grp][tec] = 0
            if grp not in tgrps : tgrps[grp] = 0
            if tec not in ttecs : ttecs[tec] = 0
            if grp not in ngrptecs : ngrptecs[grp] = {}
            if tec not in ngrptecs[grp] : ngrptecs[grp][tec] = 0
            if grp not in ngrps : ngrps[grp] = 0
            if tec not in ntecs : ntecs[tec] = 0
            # Increment the counters
            tgrptecs[grp][tec] += diff
            tgrps[grp] += diff
            ttecs[tec] += diff
            ttotal += diff
            ngrptecs[grp][tec] += 1
            ngrps[grp] += 1
            ntecs[tec] += 1
            ntotal += 1
    print "--- SUMMARIES BY TYPE AND TECHNOLOGY -----------------------------------------"
    for grp in sorted(tgrptecs):
        for tec in tgrptecs[grp]:
            myreport( grp+'.'+tec, tgrptecs[grp][tec], ngrptecs[grp][tec] )
    print "--- SUMMARIES BY TYPE --------------------------------------------------------"
    for grp in sorted(tgrps):
        myreport( grp, tgrps[grp], ngrps[grp] )
    print "--- SUMMARIES BY TECHNOLOGY --------------------------------------------------"
    for tec in sorted(ttecs):
        myreport( tec, ttecs[tec], ntecs[tec] )
    print "--- GRAND TOTAL --------------------------------------------------------------"
    myreport( "GRAND TOTAL", ttotal, ntotal )
    myreport( "[hh:mm:ss]", timedelta( seconds = ttotal ), ntotal )

##############################################################################

if __name__ == '__main__':
    if len(sys.argv) < 2 : usage()
    for file in sys.argv[1:] :
        parseQmtestRun( file )
