#-- start of make_header -----------------

#====================================
#  Library lcg_CoralServerProxy
#
#   Generated Wed Jan 21 17:17:32 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralServerProxy_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralServerProxy_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralServerProxy

CoralServerProxy_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServerProxy = $(CoralServerProxy_tag)_lcg_CoralServerProxy.make
cmt_local_tagfile_lcg_CoralServerProxy = $(bin)$(CoralServerProxy_tag)_lcg_CoralServerProxy.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralServerProxy_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServerProxy = $(CoralServerProxy_tag).make
cmt_local_tagfile_lcg_CoralServerProxy = $(bin)$(CoralServerProxy_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralServerProxy)
#-include $(cmt_local_tagfile_lcg_CoralServerProxy)

ifdef cmt_lcg_CoralServerProxy_has_target_tag

cmt_final_setup_lcg_CoralServerProxy = $(bin)setup_lcg_CoralServerProxy.make
cmt_dependencies_in_lcg_CoralServerProxy = $(bin)dependencies_lcg_CoralServerProxy.in
#cmt_final_setup_lcg_CoralServerProxy = $(bin)CoralServerProxy_lcg_CoralServerProxysetup.make
cmt_local_lcg_CoralServerProxy_makefile = $(bin)lcg_CoralServerProxy.make

else

cmt_final_setup_lcg_CoralServerProxy = $(bin)setup.make
cmt_dependencies_in_lcg_CoralServerProxy = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralServerProxy = $(bin)CoralServerProxysetup.make
cmt_local_lcg_CoralServerProxy_makefile = $(bin)lcg_CoralServerProxy.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralServerProxysetup.make

#lcg_CoralServerProxy :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralServerProxy'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralServerProxy/
#lcg_CoralServerProxy::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralServerProxylibname   = $(bin)$(library_prefix)lcg_CoralServerProxy$(library_suffix)
lcg_CoralServerProxylib       = $(lcg_CoralServerProxylibname).a
lcg_CoralServerProxystamp     = $(bin)lcg_CoralServerProxy.stamp
lcg_CoralServerProxyshstamp   = $(bin)lcg_CoralServerProxy.shstamp

lcg_CoralServerProxy :: dirs  lcg_CoralServerProxyLIB
	$(echo) "lcg_CoralServerProxy ok"

cmt_lcg_CoralServerProxy_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralServerProxy_has_prototypes

lcg_CoralServerProxyprototype :  ;

endif

lcg_CoralServerProxycompile : $(bin)Packet.o $(bin)PacketHeaderQueue.o $(bin)StatCollector.o $(bin)ClientReaderFactory.o $(bin)TPCManager.o $(bin)PacketDispatcher.o $(bin)QueuedPacketList.o $(bin)PacketQueue.o $(bin)ClientConnManager.o $(bin)ClientWriter.o $(bin)RoutingTables.o $(bin)TimeStamp.o $(bin)PacketCacheMemory.o $(bin)ServerReader.o $(bin)ServerWriter.o $(bin)NetAddress.o $(bin)ServerReaderFactory.o $(bin)MultipartCollector.o $(bin)MsgLogger.o $(bin)IPacketCache.o $(bin)NetSocket.o $(bin)SingleClientReader.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralServerProxyLIB :: $(lcg_CoralServerProxylib) $(lcg_CoralServerProxyshstamp)
	@/bin/echo "------> lcg_CoralServerProxy : library ok"

$(lcg_CoralServerProxylib) :: $(bin)Packet.o $(bin)PacketHeaderQueue.o $(bin)StatCollector.o $(bin)ClientReaderFactory.o $(bin)TPCManager.o $(bin)PacketDispatcher.o $(bin)QueuedPacketList.o $(bin)PacketQueue.o $(bin)ClientConnManager.o $(bin)ClientWriter.o $(bin)RoutingTables.o $(bin)TimeStamp.o $(bin)PacketCacheMemory.o $(bin)ServerReader.o $(bin)ServerWriter.o $(bin)NetAddress.o $(bin)ServerReaderFactory.o $(bin)MultipartCollector.o $(bin)MsgLogger.o $(bin)IPacketCache.o $(bin)NetSocket.o $(bin)SingleClientReader.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralServerProxylib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralServerProxylib)
	$(lib_silent) cat /dev/null >$(lcg_CoralServerProxystamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(lcg_CoralServerProxylibname).$(shlibsuffix) :: $(lcg_CoralServerProxylib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralServerProxy $(lcg_CoralServerProxy_shlibflags)

$(lcg_CoralServerProxyshstamp) :: $(lcg_CoralServerProxylibname).$(shlibsuffix)
	@if test -f $(lcg_CoralServerProxylibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralServerProxyshstamp) ; fi

lcg_CoralServerProxyclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Packet.o $(bin)PacketHeaderQueue.o $(bin)StatCollector.o $(bin)ClientReaderFactory.o $(bin)TPCManager.o $(bin)PacketDispatcher.o $(bin)QueuedPacketList.o $(bin)PacketQueue.o $(bin)ClientConnManager.o $(bin)ClientWriter.o $(bin)RoutingTables.o $(bin)TimeStamp.o $(bin)PacketCacheMemory.o $(bin)ServerReader.o $(bin)ServerWriter.o $(bin)NetAddress.o $(bin)ServerReaderFactory.o $(bin)MultipartCollector.o $(bin)MsgLogger.o $(bin)IPacketCache.o $(bin)NetSocket.o $(bin)SingleClientReader.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralServerProxyinstallname = $(library_prefix)lcg_CoralServerProxy$(library_suffix).$(shlibsuffix)

lcg_CoralServerProxy :: lcg_CoralServerProxyinstall

install :: lcg_CoralServerProxyinstall

lcg_CoralServerProxyinstall :: $(install_dir)/$(lcg_CoralServerProxyinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralServerProxyinstallname) :: $(bin)$(lcg_CoralServerProxyinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerProxyinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralServerProxyclean :: lcg_CoralServerProxyuninstall

uninstall :: lcg_CoralServerProxyuninstall

lcg_CoralServerProxyuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerProxyinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyprototype)

$(bin)lcg_CoralServerProxy_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralServerProxy)
	$(echo) "(lcg_CoralServerProxy.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Packet.cpp $(src)PacketHeaderQueue.cpp $(src)StatCollector.cpp $(src)ClientReaderFactory.cpp $(src)TPCManager.cpp $(src)PacketDispatcher.cpp $(src)QueuedPacketList.cpp $(src)PacketQueue.cpp $(src)ClientConnManager.cpp $(src)ClientWriter.cpp $(src)RoutingTables.cpp $(src)TimeStamp.cpp $(src)PacketCacheMemory.cpp $(src)ServerReader.cpp $(src)ServerWriter.cpp $(src)NetAddress.cpp $(src)ServerReaderFactory.cpp $(src)MultipartCollector.cpp $(src)MsgLogger.cpp $(src)IPacketCache.cpp $(src)NetSocket.cpp $(src)SingleClientReader.cpp -end_all $(includes) $(app_lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) -name=lcg_CoralServerProxy $? -f=$(cmt_dependencies_in_lcg_CoralServerProxy) -without_cmt

-include $(bin)lcg_CoralServerProxy_dependencies.make

endif
endif
endif

lcg_CoralServerProxyclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralServerProxy_deps $(bin)lcg_CoralServerProxy_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Packet.d

$(bin)$(binobj)Packet.d :

$(bin)$(binobj)Packet.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)Packet.o : $(src)Packet.cpp
	$(cpp_echo) $(src)Packet.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(Packet_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(Packet_cppflags) $(Packet_cpp_cppflags)  $(src)Packet.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(Packet_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)Packet.cpp

$(bin)$(binobj)Packet.o : $(Packet_cpp_dependencies)
	$(cpp_echo) $(src)Packet.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(Packet_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(Packet_cppflags) $(Packet_cpp_cppflags)  $(src)Packet.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PacketHeaderQueue.d

$(bin)$(binobj)PacketHeaderQueue.d :

$(bin)$(binobj)PacketHeaderQueue.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)PacketHeaderQueue.o : $(src)PacketHeaderQueue.cpp
	$(cpp_echo) $(src)PacketHeaderQueue.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketHeaderQueue_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketHeaderQueue_cppflags) $(PacketHeaderQueue_cpp_cppflags)  $(src)PacketHeaderQueue.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(PacketHeaderQueue_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)PacketHeaderQueue.cpp

$(bin)$(binobj)PacketHeaderQueue.o : $(PacketHeaderQueue_cpp_dependencies)
	$(cpp_echo) $(src)PacketHeaderQueue.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketHeaderQueue_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketHeaderQueue_cppflags) $(PacketHeaderQueue_cpp_cppflags)  $(src)PacketHeaderQueue.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatCollector.d

$(bin)$(binobj)StatCollector.d :

$(bin)$(binobj)StatCollector.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)StatCollector.o : $(src)StatCollector.cpp
	$(cpp_echo) $(src)StatCollector.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(StatCollector_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(StatCollector_cppflags) $(StatCollector_cpp_cppflags)  $(src)StatCollector.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(StatCollector_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)StatCollector.cpp

$(bin)$(binobj)StatCollector.o : $(StatCollector_cpp_dependencies)
	$(cpp_echo) $(src)StatCollector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(StatCollector_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(StatCollector_cppflags) $(StatCollector_cpp_cppflags)  $(src)StatCollector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ClientReaderFactory.d

$(bin)$(binobj)ClientReaderFactory.d :

$(bin)$(binobj)ClientReaderFactory.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ClientReaderFactory.o : $(src)ClientReaderFactory.cpp
	$(cpp_echo) $(src)ClientReaderFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientReaderFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientReaderFactory_cppflags) $(ClientReaderFactory_cpp_cppflags)  $(src)ClientReaderFactory.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ClientReaderFactory_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ClientReaderFactory.cpp

$(bin)$(binobj)ClientReaderFactory.o : $(ClientReaderFactory_cpp_dependencies)
	$(cpp_echo) $(src)ClientReaderFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientReaderFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientReaderFactory_cppflags) $(ClientReaderFactory_cpp_cppflags)  $(src)ClientReaderFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TPCManager.d

$(bin)$(binobj)TPCManager.d :

$(bin)$(binobj)TPCManager.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)TPCManager.o : $(src)TPCManager.cpp
	$(cpp_echo) $(src)TPCManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(TPCManager_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(TPCManager_cppflags) $(TPCManager_cpp_cppflags)  $(src)TPCManager.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(TPCManager_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)TPCManager.cpp

$(bin)$(binobj)TPCManager.o : $(TPCManager_cpp_dependencies)
	$(cpp_echo) $(src)TPCManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(TPCManager_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(TPCManager_cppflags) $(TPCManager_cpp_cppflags)  $(src)TPCManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PacketDispatcher.d

$(bin)$(binobj)PacketDispatcher.d :

$(bin)$(binobj)PacketDispatcher.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)PacketDispatcher.o : $(src)PacketDispatcher.cpp
	$(cpp_echo) $(src)PacketDispatcher.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketDispatcher_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketDispatcher_cppflags) $(PacketDispatcher_cpp_cppflags)  $(src)PacketDispatcher.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(PacketDispatcher_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)PacketDispatcher.cpp

$(bin)$(binobj)PacketDispatcher.o : $(PacketDispatcher_cpp_dependencies)
	$(cpp_echo) $(src)PacketDispatcher.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketDispatcher_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketDispatcher_cppflags) $(PacketDispatcher_cpp_cppflags)  $(src)PacketDispatcher.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueuedPacketList.d

$(bin)$(binobj)QueuedPacketList.d :

$(bin)$(binobj)QueuedPacketList.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)QueuedPacketList.o : $(src)QueuedPacketList.cpp
	$(cpp_echo) $(src)QueuedPacketList.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(QueuedPacketList_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(QueuedPacketList_cppflags) $(QueuedPacketList_cpp_cppflags)  $(src)QueuedPacketList.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(QueuedPacketList_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)QueuedPacketList.cpp

$(bin)$(binobj)QueuedPacketList.o : $(QueuedPacketList_cpp_dependencies)
	$(cpp_echo) $(src)QueuedPacketList.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(QueuedPacketList_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(QueuedPacketList_cppflags) $(QueuedPacketList_cpp_cppflags)  $(src)QueuedPacketList.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PacketQueue.d

$(bin)$(binobj)PacketQueue.d :

$(bin)$(binobj)PacketQueue.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)PacketQueue.o : $(src)PacketQueue.cpp
	$(cpp_echo) $(src)PacketQueue.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketQueue_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketQueue_cppflags) $(PacketQueue_cpp_cppflags)  $(src)PacketQueue.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(PacketQueue_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)PacketQueue.cpp

$(bin)$(binobj)PacketQueue.o : $(PacketQueue_cpp_dependencies)
	$(cpp_echo) $(src)PacketQueue.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketQueue_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketQueue_cppflags) $(PacketQueue_cpp_cppflags)  $(src)PacketQueue.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ClientConnManager.d

$(bin)$(binobj)ClientConnManager.d :

$(bin)$(binobj)ClientConnManager.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ClientConnManager.o : $(src)ClientConnManager.cpp
	$(cpp_echo) $(src)ClientConnManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientConnManager_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientConnManager_cppflags) $(ClientConnManager_cpp_cppflags)  $(src)ClientConnManager.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ClientConnManager_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ClientConnManager.cpp

$(bin)$(binobj)ClientConnManager.o : $(ClientConnManager_cpp_dependencies)
	$(cpp_echo) $(src)ClientConnManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientConnManager_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientConnManager_cppflags) $(ClientConnManager_cpp_cppflags)  $(src)ClientConnManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ClientWriter.d

$(bin)$(binobj)ClientWriter.d :

$(bin)$(binobj)ClientWriter.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ClientWriter.o : $(src)ClientWriter.cpp
	$(cpp_echo) $(src)ClientWriter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientWriter_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientWriter_cppflags) $(ClientWriter_cpp_cppflags)  $(src)ClientWriter.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ClientWriter_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ClientWriter.cpp

$(bin)$(binobj)ClientWriter.o : $(ClientWriter_cpp_dependencies)
	$(cpp_echo) $(src)ClientWriter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ClientWriter_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ClientWriter_cppflags) $(ClientWriter_cpp_cppflags)  $(src)ClientWriter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RoutingTables.d

$(bin)$(binobj)RoutingTables.d :

$(bin)$(binobj)RoutingTables.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)RoutingTables.o : $(src)RoutingTables.cpp
	$(cpp_echo) $(src)RoutingTables.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(RoutingTables_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(RoutingTables_cppflags) $(RoutingTables_cpp_cppflags)  $(src)RoutingTables.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(RoutingTables_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)RoutingTables.cpp

$(bin)$(binobj)RoutingTables.o : $(RoutingTables_cpp_dependencies)
	$(cpp_echo) $(src)RoutingTables.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(RoutingTables_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(RoutingTables_cppflags) $(RoutingTables_cpp_cppflags)  $(src)RoutingTables.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeStamp.d

$(bin)$(binobj)TimeStamp.d :

$(bin)$(binobj)TimeStamp.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)TimeStamp.o : $(src)TimeStamp.cpp
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(TimeStamp_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)TimeStamp.cpp

$(bin)$(binobj)TimeStamp.o : $(TimeStamp_cpp_dependencies)
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PacketCacheMemory.d

$(bin)$(binobj)PacketCacheMemory.d :

$(bin)$(binobj)PacketCacheMemory.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)PacketCacheMemory.o : $(src)PacketCacheMemory.cpp
	$(cpp_echo) $(src)PacketCacheMemory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketCacheMemory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketCacheMemory_cppflags) $(PacketCacheMemory_cpp_cppflags)  $(src)PacketCacheMemory.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(PacketCacheMemory_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)PacketCacheMemory.cpp

$(bin)$(binobj)PacketCacheMemory.o : $(PacketCacheMemory_cpp_dependencies)
	$(cpp_echo) $(src)PacketCacheMemory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(PacketCacheMemory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(PacketCacheMemory_cppflags) $(PacketCacheMemory_cpp_cppflags)  $(src)PacketCacheMemory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServerReader.d

$(bin)$(binobj)ServerReader.d :

$(bin)$(binobj)ServerReader.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ServerReader.o : $(src)ServerReader.cpp
	$(cpp_echo) $(src)ServerReader.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerReader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerReader_cppflags) $(ServerReader_cpp_cppflags)  $(src)ServerReader.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ServerReader_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ServerReader.cpp

$(bin)$(binobj)ServerReader.o : $(ServerReader_cpp_dependencies)
	$(cpp_echo) $(src)ServerReader.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerReader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerReader_cppflags) $(ServerReader_cpp_cppflags)  $(src)ServerReader.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServerWriter.d

$(bin)$(binobj)ServerWriter.d :

$(bin)$(binobj)ServerWriter.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ServerWriter.o : $(src)ServerWriter.cpp
	$(cpp_echo) $(src)ServerWriter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerWriter_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerWriter_cppflags) $(ServerWriter_cpp_cppflags)  $(src)ServerWriter.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ServerWriter_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ServerWriter.cpp

$(bin)$(binobj)ServerWriter.o : $(ServerWriter_cpp_dependencies)
	$(cpp_echo) $(src)ServerWriter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerWriter_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerWriter_cppflags) $(ServerWriter_cpp_cppflags)  $(src)ServerWriter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NetAddress.d

$(bin)$(binobj)NetAddress.d :

$(bin)$(binobj)NetAddress.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)NetAddress.o : $(src)NetAddress.cpp
	$(cpp_echo) $(src)NetAddress.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(NetAddress_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(NetAddress_cppflags) $(NetAddress_cpp_cppflags)  $(src)NetAddress.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(NetAddress_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)NetAddress.cpp

$(bin)$(binobj)NetAddress.o : $(NetAddress_cpp_dependencies)
	$(cpp_echo) $(src)NetAddress.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(NetAddress_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(NetAddress_cppflags) $(NetAddress_cpp_cppflags)  $(src)NetAddress.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServerReaderFactory.d

$(bin)$(binobj)ServerReaderFactory.d :

$(bin)$(binobj)ServerReaderFactory.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)ServerReaderFactory.o : $(src)ServerReaderFactory.cpp
	$(cpp_echo) $(src)ServerReaderFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerReaderFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerReaderFactory_cppflags) $(ServerReaderFactory_cpp_cppflags)  $(src)ServerReaderFactory.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(ServerReaderFactory_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)ServerReaderFactory.cpp

$(bin)$(binobj)ServerReaderFactory.o : $(ServerReaderFactory_cpp_dependencies)
	$(cpp_echo) $(src)ServerReaderFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(ServerReaderFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(ServerReaderFactory_cppflags) $(ServerReaderFactory_cpp_cppflags)  $(src)ServerReaderFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MultipartCollector.d

$(bin)$(binobj)MultipartCollector.d :

$(bin)$(binobj)MultipartCollector.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)MultipartCollector.o : $(src)MultipartCollector.cpp
	$(cpp_echo) $(src)MultipartCollector.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(MultipartCollector_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(MultipartCollector_cppflags) $(MultipartCollector_cpp_cppflags)  $(src)MultipartCollector.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(MultipartCollector_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)MultipartCollector.cpp

$(bin)$(binobj)MultipartCollector.o : $(MultipartCollector_cpp_dependencies)
	$(cpp_echo) $(src)MultipartCollector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(MultipartCollector_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(MultipartCollector_cppflags) $(MultipartCollector_cpp_cppflags)  $(src)MultipartCollector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MsgLogger.d

$(bin)$(binobj)MsgLogger.d :

$(bin)$(binobj)MsgLogger.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)MsgLogger.o : $(src)MsgLogger.cpp
	$(cpp_echo) $(src)MsgLogger.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(MsgLogger_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(MsgLogger_cppflags) $(MsgLogger_cpp_cppflags)  $(src)MsgLogger.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(MsgLogger_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)MsgLogger.cpp

$(bin)$(binobj)MsgLogger.o : $(MsgLogger_cpp_dependencies)
	$(cpp_echo) $(src)MsgLogger.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(MsgLogger_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(MsgLogger_cppflags) $(MsgLogger_cpp_cppflags)  $(src)MsgLogger.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IPacketCache.d

$(bin)$(binobj)IPacketCache.d :

$(bin)$(binobj)IPacketCache.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)IPacketCache.o : $(src)IPacketCache.cpp
	$(cpp_echo) $(src)IPacketCache.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(IPacketCache_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(IPacketCache_cppflags) $(IPacketCache_cpp_cppflags)  $(src)IPacketCache.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(IPacketCache_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)IPacketCache.cpp

$(bin)$(binobj)IPacketCache.o : $(IPacketCache_cpp_dependencies)
	$(cpp_echo) $(src)IPacketCache.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(IPacketCache_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(IPacketCache_cppflags) $(IPacketCache_cpp_cppflags)  $(src)IPacketCache.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NetSocket.d

$(bin)$(binobj)NetSocket.d :

$(bin)$(binobj)NetSocket.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)NetSocket.o : $(src)NetSocket.cpp
	$(cpp_echo) $(src)NetSocket.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(NetSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(NetSocket_cppflags) $(NetSocket_cpp_cppflags)  $(src)NetSocket.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(NetSocket_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)NetSocket.cpp

$(bin)$(binobj)NetSocket.o : $(NetSocket_cpp_dependencies)
	$(cpp_echo) $(src)NetSocket.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(NetSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(NetSocket_cppflags) $(NetSocket_cpp_cppflags)  $(src)NetSocket.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerProxyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SingleClientReader.d

$(bin)$(binobj)SingleClientReader.d :

$(bin)$(binobj)SingleClientReader.o : $(cmt_final_setup_lcg_CoralServerProxy)

$(bin)$(binobj)SingleClientReader.o : $(src)SingleClientReader.cpp
	$(cpp_echo) $(src)SingleClientReader.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(SingleClientReader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(SingleClientReader_cppflags) $(SingleClientReader_cpp_cppflags)  $(src)SingleClientReader.cpp
endif
endif

else
$(bin)lcg_CoralServerProxy_dependencies.make : $(SingleClientReader_cpp_dependencies)

$(bin)lcg_CoralServerProxy_dependencies.make : $(src)SingleClientReader.cpp

$(bin)$(binobj)SingleClientReader.o : $(SingleClientReader_cpp_dependencies)
	$(cpp_echo) $(src)SingleClientReader.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerProxy_pp_cppflags) $(lib_lcg_CoralServerProxy_pp_cppflags) $(SingleClientReader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerProxy_cppflags) $(lib_lcg_CoralServerProxy_cppflags) $(SingleClientReader_cppflags) $(SingleClientReader_cpp_cppflags)  $(src)SingleClientReader.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralServerProxyclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralServerProxy.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralServerProxyclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralServerProxy
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralServerProxy$(library_suffix).a $(library_prefix)lcg_CoralServerProxy$(library_suffix).$(shlibsuffix) lcg_CoralServerProxy.stamp lcg_CoralServerProxy.shstamp
#-- end of cleanup_library ---------------
