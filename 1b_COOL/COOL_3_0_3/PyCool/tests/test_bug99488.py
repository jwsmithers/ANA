#------------------------------------------------------------------------------
if __name__ == "__main__":
    def main():
    
        """ Import and set up a connection
        """
        from PyCool import cool
        app = cool.Application()
        svc = app.databaseService()
        outLvl = app.outputLevel()
        db = svc.openDatabase("oracle://ATLAS_COOLPROD;schema=ATLAS_COOLONL_TRIGGER;dbname=MONP200;")
        folder = db.getFolder("/TRIGGER/HLT/TotalRates")


        """ Get the mapping of id to name as well as a list of channelIDs
        """
        app.setOutputLevel( cool.MSG.VERBOSE )
        id_to_name = folder.listChannelsWithNames()
        channels = folder.listChannels()
        app.setOutputLevel( outLvl )
        print 'Retrieved',id_to_name.size(),'channels with names'
        print 'Retrieved',channels.size(),'channels'
        print 'Channels with names is',id_to_name
        print 'Channels is',channels
        ###print 'Type of channels with names is',type(id_to_name)
        ###print 'Type of channels is',type(channels)
        ###for id in id_to_name: print 'Channel with name',id
        ###print 'Channel with name for id=177 is',id_to_name["177"]

        """ Make the name to id map
        """
        name_to_id = {}
        for id in channels:
            ###print 'Channel',id
            try:
                name = id_to_name[id]
                name_to_id[name] = id
            except:
                # In case id is not in the id_to_name map. Fires for 177.
                print "WARNING: Id to name resolution failed for id %i." % id


        """ Print the name to id map sorted by id.
        """ 
        #for n,i in sorted(name_to_id.iteritems(), key=lambda (k,v): (v,k)):
        #    print "%-55s" % n, "%-4i" %i
        #print


        """ Select some item to test
        """
        item = "L2p_total" # Works as expected
        item = "EF_str_L1CaloCalib_calibration" # Does not work, but matches the missing ID.


        """ Make a couple of simple tests
        """
        print "%s is in names:" % item, item in name_to_id
        print "folder has channel %s:" % item, folder.existsChannel(item)
        id = folder.channelId(item)
        print "folder channel id for %s:" % item, id
        print "folder channel name for id %i:" % id, folder.channelName(id)


        """ Be gentle..
        """
        db.closeDatabase()


#------------------------------------------------------------------------------
    """ Do it...
    """
    main()
#------------------------------------------------------------------------------

