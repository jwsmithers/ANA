#-- start of make_header -----------------

#====================================
#  Library lcg_CoralSockets
#
#   Generated Wed Jan 21 17:19:01 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralSockets_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralSockets_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralSockets

CoralSockets_tag = $(tag)

#cmt_local_tagfile_lcg_CoralSockets = $(CoralSockets_tag)_lcg_CoralSockets.make
cmt_local_tagfile_lcg_CoralSockets = $(bin)$(CoralSockets_tag)_lcg_CoralSockets.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralSockets_tag = $(tag)

#cmt_local_tagfile_lcg_CoralSockets = $(CoralSockets_tag).make
cmt_local_tagfile_lcg_CoralSockets = $(bin)$(CoralSockets_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralSockets)
#-include $(cmt_local_tagfile_lcg_CoralSockets)

ifdef cmt_lcg_CoralSockets_has_target_tag

cmt_final_setup_lcg_CoralSockets = $(bin)setup_lcg_CoralSockets.make
cmt_dependencies_in_lcg_CoralSockets = $(bin)dependencies_lcg_CoralSockets.in
#cmt_final_setup_lcg_CoralSockets = $(bin)CoralSockets_lcg_CoralSocketssetup.make
cmt_local_lcg_CoralSockets_makefile = $(bin)lcg_CoralSockets.make

else

cmt_final_setup_lcg_CoralSockets = $(bin)setup.make
cmt_dependencies_in_lcg_CoralSockets = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralSockets = $(bin)CoralSocketssetup.make
cmt_local_lcg_CoralSockets_makefile = $(bin)lcg_CoralSockets.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralSocketssetup.make

#lcg_CoralSockets :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralSockets'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralSockets/
#lcg_CoralSockets::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralSocketslibname   = $(bin)$(library_prefix)lcg_CoralSockets$(library_suffix)
lcg_CoralSocketslib       = $(lcg_CoralSocketslibname).a
lcg_CoralSocketsstamp     = $(bin)lcg_CoralSockets.stamp
lcg_CoralSocketsshstamp   = $(bin)lcg_CoralSockets.shstamp

lcg_CoralSockets :: dirs  lcg_CoralSocketsLIB
	$(echo) "lcg_CoralSockets ok"

cmt_lcg_CoralSockets_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralSockets_has_prototypes

lcg_CoralSocketsprototype :  ;

endif

lcg_CoralSocketscompile : $(bin)SocketClient.o $(bin)ThreadManager.o $(bin)ReplyManager.o $(bin)RequestIterator.o $(bin)SocketServer.o $(bin)PacketSocket.o $(bin)TcpSocket.o $(bin)RingBufferSocket.o $(bin)CertificateData.o $(bin)SocketContext.o $(bin)ControlMsg.o $(bin)Poll.o $(bin)PollServer.o $(bin)SslSocket.o $(bin)DummyRequestHandler.o $(bin)ConnectionManager.o $(bin)ServerContext.o $(bin)SocketThread.o $(bin)SocketRequestHandler.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralSocketsLIB :: $(lcg_CoralSocketslib) $(lcg_CoralSocketsshstamp)
	@/bin/echo "------> lcg_CoralSockets : library ok"

$(lcg_CoralSocketslib) :: $(bin)SocketClient.o $(bin)ThreadManager.o $(bin)ReplyManager.o $(bin)RequestIterator.o $(bin)SocketServer.o $(bin)PacketSocket.o $(bin)TcpSocket.o $(bin)RingBufferSocket.o $(bin)CertificateData.o $(bin)SocketContext.o $(bin)ControlMsg.o $(bin)Poll.o $(bin)PollServer.o $(bin)SslSocket.o $(bin)DummyRequestHandler.o $(bin)ConnectionManager.o $(bin)ServerContext.o $(bin)SocketThread.o $(bin)SocketRequestHandler.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralSocketslib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralSocketslib)
	$(lib_silent) cat /dev/null >$(lcg_CoralSocketsstamp)

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

$(lcg_CoralSocketslibname).$(shlibsuffix) :: $(lcg_CoralSocketslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralSockets $(lcg_CoralSockets_shlibflags)

$(lcg_CoralSocketsshstamp) :: $(lcg_CoralSocketslibname).$(shlibsuffix)
	@if test -f $(lcg_CoralSocketslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralSocketsshstamp) ; fi

lcg_CoralSocketsclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)SocketClient.o $(bin)ThreadManager.o $(bin)ReplyManager.o $(bin)RequestIterator.o $(bin)SocketServer.o $(bin)PacketSocket.o $(bin)TcpSocket.o $(bin)RingBufferSocket.o $(bin)CertificateData.o $(bin)SocketContext.o $(bin)ControlMsg.o $(bin)Poll.o $(bin)PollServer.o $(bin)SslSocket.o $(bin)DummyRequestHandler.o $(bin)ConnectionManager.o $(bin)ServerContext.o $(bin)SocketThread.o $(bin)SocketRequestHandler.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralSocketsinstallname = $(library_prefix)lcg_CoralSockets$(library_suffix).$(shlibsuffix)

lcg_CoralSockets :: lcg_CoralSocketsinstall

install :: lcg_CoralSocketsinstall

lcg_CoralSocketsinstall :: $(install_dir)/$(lcg_CoralSocketsinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralSocketsinstallname) :: $(bin)$(lcg_CoralSocketsinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralSocketsinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralSocketsclean :: lcg_CoralSocketsuninstall

uninstall :: lcg_CoralSocketsuninstall

lcg_CoralSocketsuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralSocketsinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralSocketsprototype)

$(bin)lcg_CoralSockets_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralSockets)
	$(echo) "(lcg_CoralSockets.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)SocketClient.cpp $(src)ThreadManager.cpp $(src)ReplyManager.cpp $(src)RequestIterator.cpp $(src)SocketServer.cpp $(src)PacketSocket.cpp $(src)TcpSocket.cpp $(src)RingBufferSocket.cpp $(src)CertificateData.cpp $(src)SocketContext.cpp $(src)ControlMsg.cpp $(src)Poll.cpp $(src)PollServer.cpp $(src)SslSocket.cpp $(src)DummyRequestHandler.cpp $(src)ConnectionManager.cpp $(src)ServerContext.cpp $(src)SocketThread.cpp $(src)SocketRequestHandler.cpp -end_all $(includes) $(app_lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) -name=lcg_CoralSockets $? -f=$(cmt_dependencies_in_lcg_CoralSockets) -without_cmt

-include $(bin)lcg_CoralSockets_dependencies.make

endif
endif
endif

lcg_CoralSocketsclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralSockets_deps $(bin)lcg_CoralSockets_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SocketClient.d

$(bin)$(binobj)SocketClient.d :

$(bin)$(binobj)SocketClient.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SocketClient.o : $(src)SocketClient.cpp
	$(cpp_echo) $(src)SocketClient.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketClient_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketClient_cppflags) $(SocketClient_cpp_cppflags)  $(src)SocketClient.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SocketClient_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SocketClient.cpp

$(bin)$(binobj)SocketClient.o : $(SocketClient_cpp_dependencies)
	$(cpp_echo) $(src)SocketClient.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketClient_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketClient_cppflags) $(SocketClient_cpp_cppflags)  $(src)SocketClient.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ThreadManager.d

$(bin)$(binobj)ThreadManager.d :

$(bin)$(binobj)ThreadManager.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)ThreadManager.o : $(src)ThreadManager.cpp
	$(cpp_echo) $(src)ThreadManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ThreadManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ThreadManager_cppflags) $(ThreadManager_cpp_cppflags)  $(src)ThreadManager.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(ThreadManager_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)ThreadManager.cpp

$(bin)$(binobj)ThreadManager.o : $(ThreadManager_cpp_dependencies)
	$(cpp_echo) $(src)ThreadManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ThreadManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ThreadManager_cppflags) $(ThreadManager_cpp_cppflags)  $(src)ThreadManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReplyManager.d

$(bin)$(binobj)ReplyManager.d :

$(bin)$(binobj)ReplyManager.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)ReplyManager.o : $(src)ReplyManager.cpp
	$(cpp_echo) $(src)ReplyManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ReplyManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ReplyManager_cppflags) $(ReplyManager_cpp_cppflags)  $(src)ReplyManager.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(ReplyManager_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)ReplyManager.cpp

$(bin)$(binobj)ReplyManager.o : $(ReplyManager_cpp_dependencies)
	$(cpp_echo) $(src)ReplyManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ReplyManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ReplyManager_cppflags) $(ReplyManager_cpp_cppflags)  $(src)ReplyManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RequestIterator.d

$(bin)$(binobj)RequestIterator.d :

$(bin)$(binobj)RequestIterator.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)RequestIterator.o : $(src)RequestIterator.cpp
	$(cpp_echo) $(src)RequestIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(RequestIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(RequestIterator_cppflags) $(RequestIterator_cpp_cppflags)  $(src)RequestIterator.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(RequestIterator_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)RequestIterator.cpp

$(bin)$(binobj)RequestIterator.o : $(RequestIterator_cpp_dependencies)
	$(cpp_echo) $(src)RequestIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(RequestIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(RequestIterator_cppflags) $(RequestIterator_cpp_cppflags)  $(src)RequestIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SocketServer.d

$(bin)$(binobj)SocketServer.d :

$(bin)$(binobj)SocketServer.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SocketServer.o : $(src)SocketServer.cpp
	$(cpp_echo) $(src)SocketServer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketServer_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketServer_cppflags) $(SocketServer_cpp_cppflags)  $(src)SocketServer.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SocketServer_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SocketServer.cpp

$(bin)$(binobj)SocketServer.o : $(SocketServer_cpp_dependencies)
	$(cpp_echo) $(src)SocketServer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketServer_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketServer_cppflags) $(SocketServer_cpp_cppflags)  $(src)SocketServer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PacketSocket.d

$(bin)$(binobj)PacketSocket.d :

$(bin)$(binobj)PacketSocket.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)PacketSocket.o : $(src)PacketSocket.cpp
	$(cpp_echo) $(src)PacketSocket.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(PacketSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(PacketSocket_cppflags) $(PacketSocket_cpp_cppflags)  $(src)PacketSocket.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(PacketSocket_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)PacketSocket.cpp

$(bin)$(binobj)PacketSocket.o : $(PacketSocket_cpp_dependencies)
	$(cpp_echo) $(src)PacketSocket.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(PacketSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(PacketSocket_cppflags) $(PacketSocket_cpp_cppflags)  $(src)PacketSocket.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TcpSocket.d

$(bin)$(binobj)TcpSocket.d :

$(bin)$(binobj)TcpSocket.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)TcpSocket.o : $(src)TcpSocket.cpp
	$(cpp_echo) $(src)TcpSocket.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(TcpSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(TcpSocket_cppflags) $(TcpSocket_cpp_cppflags)  $(src)TcpSocket.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(TcpSocket_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)TcpSocket.cpp

$(bin)$(binobj)TcpSocket.o : $(TcpSocket_cpp_dependencies)
	$(cpp_echo) $(src)TcpSocket.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(TcpSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(TcpSocket_cppflags) $(TcpSocket_cpp_cppflags)  $(src)TcpSocket.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RingBufferSocket.d

$(bin)$(binobj)RingBufferSocket.d :

$(bin)$(binobj)RingBufferSocket.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)RingBufferSocket.o : $(src)RingBufferSocket.cpp
	$(cpp_echo) $(src)RingBufferSocket.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(RingBufferSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(RingBufferSocket_cppflags) $(RingBufferSocket_cpp_cppflags)  $(src)RingBufferSocket.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(RingBufferSocket_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)RingBufferSocket.cpp

$(bin)$(binobj)RingBufferSocket.o : $(RingBufferSocket_cpp_dependencies)
	$(cpp_echo) $(src)RingBufferSocket.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(RingBufferSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(RingBufferSocket_cppflags) $(RingBufferSocket_cpp_cppflags)  $(src)RingBufferSocket.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CertificateData.d

$(bin)$(binobj)CertificateData.d :

$(bin)$(binobj)CertificateData.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)CertificateData.o : $(src)CertificateData.cpp
	$(cpp_echo) $(src)CertificateData.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(CertificateData_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(CertificateData_cppflags) $(CertificateData_cpp_cppflags)  $(src)CertificateData.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(CertificateData_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)CertificateData.cpp

$(bin)$(binobj)CertificateData.o : $(CertificateData_cpp_dependencies)
	$(cpp_echo) $(src)CertificateData.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(CertificateData_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(CertificateData_cppflags) $(CertificateData_cpp_cppflags)  $(src)CertificateData.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SocketContext.d

$(bin)$(binobj)SocketContext.d :

$(bin)$(binobj)SocketContext.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SocketContext.o : $(src)SocketContext.cpp
	$(cpp_echo) $(src)SocketContext.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketContext_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketContext_cppflags) $(SocketContext_cpp_cppflags)  $(src)SocketContext.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SocketContext_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SocketContext.cpp

$(bin)$(binobj)SocketContext.o : $(SocketContext_cpp_dependencies)
	$(cpp_echo) $(src)SocketContext.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketContext_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketContext_cppflags) $(SocketContext_cpp_cppflags)  $(src)SocketContext.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ControlMsg.d

$(bin)$(binobj)ControlMsg.d :

$(bin)$(binobj)ControlMsg.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)ControlMsg.o : $(src)ControlMsg.cpp
	$(cpp_echo) $(src)ControlMsg.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ControlMsg_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ControlMsg_cppflags) $(ControlMsg_cpp_cppflags)  $(src)ControlMsg.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(ControlMsg_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)ControlMsg.cpp

$(bin)$(binobj)ControlMsg.o : $(ControlMsg_cpp_dependencies)
	$(cpp_echo) $(src)ControlMsg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ControlMsg_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ControlMsg_cppflags) $(ControlMsg_cpp_cppflags)  $(src)ControlMsg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Poll.d

$(bin)$(binobj)Poll.d :

$(bin)$(binobj)Poll.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)Poll.o : $(src)Poll.cpp
	$(cpp_echo) $(src)Poll.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(Poll_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(Poll_cppflags) $(Poll_cpp_cppflags)  $(src)Poll.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(Poll_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)Poll.cpp

$(bin)$(binobj)Poll.o : $(Poll_cpp_dependencies)
	$(cpp_echo) $(src)Poll.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(Poll_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(Poll_cppflags) $(Poll_cpp_cppflags)  $(src)Poll.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PollServer.d

$(bin)$(binobj)PollServer.d :

$(bin)$(binobj)PollServer.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)PollServer.o : $(src)PollServer.cpp
	$(cpp_echo) $(src)PollServer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(PollServer_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(PollServer_cppflags) $(PollServer_cpp_cppflags)  $(src)PollServer.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(PollServer_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)PollServer.cpp

$(bin)$(binobj)PollServer.o : $(PollServer_cpp_dependencies)
	$(cpp_echo) $(src)PollServer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(PollServer_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(PollServer_cppflags) $(PollServer_cpp_cppflags)  $(src)PollServer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SslSocket.d

$(bin)$(binobj)SslSocket.d :

$(bin)$(binobj)SslSocket.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SslSocket.o : $(src)SslSocket.cpp
	$(cpp_echo) $(src)SslSocket.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SslSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SslSocket_cppflags) $(SslSocket_cpp_cppflags)  $(src)SslSocket.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SslSocket_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SslSocket.cpp

$(bin)$(binobj)SslSocket.o : $(SslSocket_cpp_dependencies)
	$(cpp_echo) $(src)SslSocket.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SslSocket_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SslSocket_cppflags) $(SslSocket_cpp_cppflags)  $(src)SslSocket.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyRequestHandler.d

$(bin)$(binobj)DummyRequestHandler.d :

$(bin)$(binobj)DummyRequestHandler.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)DummyRequestHandler.o : $(src)DummyRequestHandler.cpp
	$(cpp_echo) $(src)DummyRequestHandler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(DummyRequestHandler_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(DummyRequestHandler_cppflags) $(DummyRequestHandler_cpp_cppflags)  $(src)DummyRequestHandler.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(DummyRequestHandler_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)DummyRequestHandler.cpp

$(bin)$(binobj)DummyRequestHandler.o : $(DummyRequestHandler_cpp_dependencies)
	$(cpp_echo) $(src)DummyRequestHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(DummyRequestHandler_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(DummyRequestHandler_cppflags) $(DummyRequestHandler_cpp_cppflags)  $(src)DummyRequestHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionManager.d

$(bin)$(binobj)ConnectionManager.d :

$(bin)$(binobj)ConnectionManager.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)ConnectionManager.o : $(src)ConnectionManager.cpp
	$(cpp_echo) $(src)ConnectionManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ConnectionManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ConnectionManager_cppflags) $(ConnectionManager_cpp_cppflags)  $(src)ConnectionManager.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(ConnectionManager_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)ConnectionManager.cpp

$(bin)$(binobj)ConnectionManager.o : $(ConnectionManager_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ConnectionManager_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ConnectionManager_cppflags) $(ConnectionManager_cpp_cppflags)  $(src)ConnectionManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServerContext.d

$(bin)$(binobj)ServerContext.d :

$(bin)$(binobj)ServerContext.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)ServerContext.o : $(src)ServerContext.cpp
	$(cpp_echo) $(src)ServerContext.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ServerContext_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ServerContext_cppflags) $(ServerContext_cpp_cppflags)  $(src)ServerContext.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(ServerContext_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)ServerContext.cpp

$(bin)$(binobj)ServerContext.o : $(ServerContext_cpp_dependencies)
	$(cpp_echo) $(src)ServerContext.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(ServerContext_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(ServerContext_cppflags) $(ServerContext_cpp_cppflags)  $(src)ServerContext.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SocketThread.d

$(bin)$(binobj)SocketThread.d :

$(bin)$(binobj)SocketThread.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SocketThread.o : $(src)SocketThread.cpp
	$(cpp_echo) $(src)SocketThread.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketThread_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketThread_cppflags) $(SocketThread_cpp_cppflags)  $(src)SocketThread.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SocketThread_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SocketThread.cpp

$(bin)$(binobj)SocketThread.o : $(SocketThread_cpp_dependencies)
	$(cpp_echo) $(src)SocketThread.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketThread_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketThread_cppflags) $(SocketThread_cpp_cppflags)  $(src)SocketThread.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralSocketsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SocketRequestHandler.d

$(bin)$(binobj)SocketRequestHandler.d :

$(bin)$(binobj)SocketRequestHandler.o : $(cmt_final_setup_lcg_CoralSockets)

$(bin)$(binobj)SocketRequestHandler.o : $(src)SocketRequestHandler.cpp
	$(cpp_echo) $(src)SocketRequestHandler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketRequestHandler_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketRequestHandler_cppflags) $(SocketRequestHandler_cpp_cppflags)  $(src)SocketRequestHandler.cpp
endif
endif

else
$(bin)lcg_CoralSockets_dependencies.make : $(SocketRequestHandler_cpp_dependencies)

$(bin)lcg_CoralSockets_dependencies.make : $(src)SocketRequestHandler.cpp

$(bin)$(binobj)SocketRequestHandler.o : $(SocketRequestHandler_cpp_dependencies)
	$(cpp_echo) $(src)SocketRequestHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralSockets_pp_cppflags) $(lib_lcg_CoralSockets_pp_cppflags) $(SocketRequestHandler_pp_cppflags) $(use_cppflags) $(lcg_CoralSockets_cppflags) $(lib_lcg_CoralSockets_cppflags) $(SocketRequestHandler_cppflags) $(SocketRequestHandler_cpp_cppflags)  $(src)SocketRequestHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralSocketsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralSockets.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralSocketsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralSockets
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralSockets$(library_suffix).a $(library_prefix)lcg_CoralSockets$(library_suffix).$(shlibsuffix) lcg_CoralSockets.stamp lcg_CoralSockets.shstamp
#-- end of cleanup_library ---------------
