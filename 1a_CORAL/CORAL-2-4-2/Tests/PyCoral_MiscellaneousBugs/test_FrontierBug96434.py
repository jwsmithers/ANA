#!/usr/bin/env python
import os, sys
from time import sleep
import coral
coral.MessageStream("").setMsgVerbosity(coral.message_Level_Error)

#--------------------------------------------------------------------------

def execQuery( query ):
    print "\nExecute query"
    cursor=query.execute()
    nrows = 0
    while cursor.next() :
	nrows = nrows + 1
	row = cursor.currentRow()
	if nrows == 1 : print "First row:", row
    if nrows > 1 : print "Last row: ", row
    print "Rows retrieved:", nrows, "\n"

#--------------------------------------------------------------------------

###urlRO = "oracle://int8r1/avalassi";
urlRO = "frontier://cmsfrontier4.cern.ch:8000/int8r/avalassi"
svc = coral.ConnectionService()
print "Connect to", urlRO
session = svc.connect( urlRO, coral.access_ReadOnly )
session.transaction().start(True)
schema = session.schema('ATLAS_CONF_TRIGGER_REPR')
sm = "SUPER_MASTER_TABLE"
hm = "HLT_MASTER_TABLE"
tm2tc = "HLT_TM_TO_TC"

al = coral.AttributeList()

if False:
    # OLD APPROACH USING SUBQUERIES
    q = schema.newQuery()
    sq = q.defineSubQuery("CHAINSQ")
    ###sq = schema.newQuery()
    sq.addToTableList(sm,"SM")
    sq.addToTableList(hm,"HM")
    sq.addToTableList(tm2tc,"TM2TC")
    swc = "SM.SMT_ID=161 AND HM.HMT_ID=SM.SMT_HLT_MASTER_TABLE_ID AND HM.HMT_TRIGGER_MENU_ID=TM2TC.HTM2TC_TRIGGER_MENU_ID" 
    sq.setCondition(swc,al)
    sq.addToOutputList("TM2TC.HTM2TC_TRIGGER_CHAIN_ID","CHAINID")
    ###execQuery(sq)
    q.addToOutputList("DISTINCT TG.HTG_TRIGGER_CHAIN_ID")
    q.addToOutputList("TG.HTG_NAME")
    wc = "TG.HTG_TRIGGER_CHAIN_ID=CHAINSQ.CHAINID"
    # This fails in Frontier
    ###q.addToTableList("HLT_TRIGGER_GROUP","TG")
    ###q.addToTableList("CHAINSQ")
    # This succeeds in Frontier
    q.addToTableList("CHAINSQ")
    q.addToTableList("HLT_TRIGGER_GROUP","TG")
else:
    # NEW APPROACH WITHOUT SUBQUERIES
    q = schema.newQuery()
    q.addToTableList("HLT_TRIGGER_GROUP","TG")
    q.addToTableList(sm,"SM")
    q.addToTableList(hm,"HM")
    q.addToTableList(tm2tc,"TM2TC")
    wc = "SM.SMT_ID=161 AND HM.HMT_ID=SM.SMT_HLT_MASTER_TABLE_ID AND HM.HMT_TRIGGER_MENU_ID=TM2TC.HTM2TC_TRIGGER_MENU_ID AND TG.HTG_TRIGGER_CHAIN_ID=TM2TC.HTM2TC_TRIGGER_CHAIN_ID"
    q.addToOutputList("DISTINCT TG.HTG_TRIGGER_CHAIN_ID")
    q.addToOutputList("TG.HTG_NAME")

q.setCondition(wc,al)
coral.MessageStream("").setMsgVerbosity(coral.message_Level_Debug)
try:
    execQuery(q)
except Exception, e:
    print "ERROR!", e
coral.MessageStream("").setMsgVerbosity(coral.message_Level_Error)

print "Test completed"

