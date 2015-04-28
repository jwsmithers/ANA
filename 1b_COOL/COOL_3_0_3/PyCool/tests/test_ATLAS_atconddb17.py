from zlib import crc32
from PyCool import cool
dbSvc=cool.DatabaseSvcFactory.databaseService()
###dbname = 'COOLOFL_TILE/CONDBR2'
dbname = 'oracle://atlas_coolprod;schema=atlas_coolofl_tile;dbname=CONDBR2'
cooldb=dbSvc.openDatabase(dbname)
NODE_FULLPATH = '/TILE/OFL02/STATUS/ADC'
thisFolder = cooldb.getFolder(NODE_FULLPATH)
RunMin = 223242
RunMax = 223243
CoolTag = 'TileOfl02StatusAdc-RUN2-HLT-UPD1-00'
chansel = cool.ChannelSelection.all()
itr = thisFolder.browseObjects(RunMin<<32,RunMax<<32,chansel,CoolTag)
while itr.goToNext():
    obj = itr.currentRef()
    channel = obj.channelId()
    payload = obj.payload()
    spec=payload.specification()
    print "Working on Channel %d" % channel
    i=""
    for idx in range(spec.size()):
	if (idx>0): i+=","
	typename=spec[idx].storageType().name()
	i+= " ["+spec[idx].name() + " (" + typename + ") : "
	if (typename.startswith("Blob")):
	    blob=payload[idx]
	    i+= "size=%i,chk=%i" % (blob.size(),crc32(blob.read()))
	else:
	    i+= str(payload[idx])
	i+="]"
	print i
itr.close()
