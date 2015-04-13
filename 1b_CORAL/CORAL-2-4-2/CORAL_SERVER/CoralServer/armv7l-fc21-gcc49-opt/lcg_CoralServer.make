#-- start of make_header -----------------

#====================================
#  Library lcg_CoralServer
#
#   Generated Wed Jan 21 17:23:16 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralServer_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralServer_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralServer

CoralServer_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServer = $(CoralServer_tag)_lcg_CoralServer.make
cmt_local_tagfile_lcg_CoralServer = $(bin)$(CoralServer_tag)_lcg_CoralServer.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralServer_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServer = $(CoralServer_tag).make
cmt_local_tagfile_lcg_CoralServer = $(bin)$(CoralServer_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralServer)
#-include $(cmt_local_tagfile_lcg_CoralServer)

ifdef cmt_lcg_CoralServer_has_target_tag

cmt_final_setup_lcg_CoralServer = $(bin)setup_lcg_CoralServer.make
cmt_dependencies_in_lcg_CoralServer = $(bin)dependencies_lcg_CoralServer.in
#cmt_final_setup_lcg_CoralServer = $(bin)CoralServer_lcg_CoralServersetup.make
cmt_local_lcg_CoralServer_makefile = $(bin)lcg_CoralServer.make

else

cmt_final_setup_lcg_CoralServer = $(bin)setup.make
cmt_dependencies_in_lcg_CoralServer = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralServer = $(bin)CoralServersetup.make
cmt_local_lcg_CoralServer_makefile = $(bin)lcg_CoralServer.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralServersetup.make

#lcg_CoralServer :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralServer'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralServer/
#lcg_CoralServer::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralServerlibname   = $(bin)$(library_prefix)lcg_CoralServer$(library_suffix)
lcg_CoralServerlib       = $(lcg_CoralServerlibname).a
lcg_CoralServerstamp     = $(bin)lcg_CoralServer.stamp
lcg_CoralServershstamp   = $(bin)lcg_CoralServer.shstamp

lcg_CoralServer :: dirs  lcg_CoralServerLIB
	$(echo) "lcg_CoralServer ok"

cmt_lcg_CoralServer_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralServer_has_prototypes

lcg_CoralServerprototype :  ;

endif

lcg_CoralServercompile : $(bin)CoralServerFacadeService.o $(bin)CursorIterator.o $(bin)CoralServerFacade.o $(bin)module.o $(bin)RowVectorIterator.o $(bin)ObjectStoreMgr.o $(bin)QueryMgr.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralServerLIB :: $(lcg_CoralServerlib) $(lcg_CoralServershstamp)
	@/bin/echo "------> lcg_CoralServer : library ok"

$(lcg_CoralServerlib) :: $(bin)CoralServerFacadeService.o $(bin)CursorIterator.o $(bin)CoralServerFacade.o $(bin)module.o $(bin)RowVectorIterator.o $(bin)ObjectStoreMgr.o $(bin)QueryMgr.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralServerlib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralServerlib)
	$(lib_silent) cat /dev/null >$(lcg_CoralServerstamp)

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

$(lcg_CoralServerlibname).$(shlibsuffix) :: $(lcg_CoralServerlib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralServer $(lcg_CoralServer_shlibflags)

$(lcg_CoralServershstamp) :: $(lcg_CoralServerlibname).$(shlibsuffix)
	@if test -f $(lcg_CoralServerlibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralServershstamp) ; fi

lcg_CoralServerclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)CoralServerFacadeService.o $(bin)CursorIterator.o $(bin)CoralServerFacade.o $(bin)module.o $(bin)RowVectorIterator.o $(bin)ObjectStoreMgr.o $(bin)QueryMgr.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralServerinstallname = $(library_prefix)lcg_CoralServer$(library_suffix).$(shlibsuffix)

lcg_CoralServer :: lcg_CoralServerinstall

install :: lcg_CoralServerinstall

lcg_CoralServerinstall :: $(install_dir)/$(lcg_CoralServerinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralServerinstallname) :: $(bin)$(lcg_CoralServerinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralServerclean :: lcg_CoralServeruninstall

uninstall :: lcg_CoralServeruninstall

lcg_CoralServeruninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralServerprototype)

$(bin)lcg_CoralServer_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralServer)
	$(echo) "(lcg_CoralServer.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CoralServerFacadeService.cpp $(src)CursorIterator.cpp $(src)CoralServerFacade.cpp $(src)module.cpp $(src)RowVectorIterator.cpp $(src)ObjectStoreMgr.cpp $(src)QueryMgr.cpp -end_all $(includes) $(app_lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) -name=lcg_CoralServer $? -f=$(cmt_dependencies_in_lcg_CoralServer) -without_cmt

-include $(bin)lcg_CoralServer_dependencies.make

endif
endif
endif

lcg_CoralServerclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralServer_deps $(bin)lcg_CoralServer_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralServerFacadeService.d

$(bin)$(binobj)CoralServerFacadeService.d :

$(bin)$(binobj)CoralServerFacadeService.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)CoralServerFacadeService.o : $(src)CoralServerFacadeService.cpp
	$(cpp_echo) $(src)CoralServerFacadeService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CoralServerFacadeService_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CoralServerFacadeService_cppflags) $(CoralServerFacadeService_cpp_cppflags)  $(src)CoralServerFacadeService.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(CoralServerFacadeService_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)CoralServerFacadeService.cpp

$(bin)$(binobj)CoralServerFacadeService.o : $(CoralServerFacadeService_cpp_dependencies)
	$(cpp_echo) $(src)CoralServerFacadeService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CoralServerFacadeService_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CoralServerFacadeService_cppflags) $(CoralServerFacadeService_cpp_cppflags)  $(src)CoralServerFacadeService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CursorIterator.d

$(bin)$(binobj)CursorIterator.d :

$(bin)$(binobj)CursorIterator.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)CursorIterator.o : $(src)CursorIterator.cpp
	$(cpp_echo) $(src)CursorIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CursorIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CursorIterator_cppflags) $(CursorIterator_cpp_cppflags)  $(src)CursorIterator.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(CursorIterator_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)CursorIterator.cpp

$(bin)$(binobj)CursorIterator.o : $(CursorIterator_cpp_dependencies)
	$(cpp_echo) $(src)CursorIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CursorIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CursorIterator_cppflags) $(CursorIterator_cpp_cppflags)  $(src)CursorIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralServerFacade.d

$(bin)$(binobj)CoralServerFacade.d :

$(bin)$(binobj)CoralServerFacade.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)CoralServerFacade.o : $(src)CoralServerFacade.cpp
	$(cpp_echo) $(src)CoralServerFacade.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CoralServerFacade_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CoralServerFacade_cppflags) $(CoralServerFacade_cpp_cppflags)  $(src)CoralServerFacade.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(CoralServerFacade_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)CoralServerFacade.cpp

$(bin)$(binobj)CoralServerFacade.o : $(CoralServerFacade_cpp_dependencies)
	$(cpp_echo) $(src)CoralServerFacade.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(CoralServerFacade_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(CoralServerFacade_cppflags) $(CoralServerFacade_cpp_cppflags)  $(src)CoralServerFacade.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RowVectorIterator.d

$(bin)$(binobj)RowVectorIterator.d :

$(bin)$(binobj)RowVectorIterator.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)RowVectorIterator.o : $(src)RowVectorIterator.cpp
	$(cpp_echo) $(src)RowVectorIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(RowVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(RowVectorIterator_cppflags) $(RowVectorIterator_cpp_cppflags)  $(src)RowVectorIterator.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(RowVectorIterator_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)RowVectorIterator.cpp

$(bin)$(binobj)RowVectorIterator.o : $(RowVectorIterator_cpp_dependencies)
	$(cpp_echo) $(src)RowVectorIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(RowVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(RowVectorIterator_cppflags) $(RowVectorIterator_cpp_cppflags)  $(src)RowVectorIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ObjectStoreMgr.d

$(bin)$(binobj)ObjectStoreMgr.d :

$(bin)$(binobj)ObjectStoreMgr.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)ObjectStoreMgr.o : $(src)ObjectStoreMgr.cpp
	$(cpp_echo) $(src)ObjectStoreMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(ObjectStoreMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(ObjectStoreMgr_cppflags) $(ObjectStoreMgr_cpp_cppflags)  $(src)ObjectStoreMgr.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(ObjectStoreMgr_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)ObjectStoreMgr.cpp

$(bin)$(binobj)ObjectStoreMgr.o : $(ObjectStoreMgr_cpp_dependencies)
	$(cpp_echo) $(src)ObjectStoreMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(ObjectStoreMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(ObjectStoreMgr_cppflags) $(ObjectStoreMgr_cpp_cppflags)  $(src)ObjectStoreMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryMgr.d

$(bin)$(binobj)QueryMgr.d :

$(bin)$(binobj)QueryMgr.o : $(cmt_final_setup_lcg_CoralServer)

$(bin)$(binobj)QueryMgr.o : $(src)QueryMgr.cpp
	$(cpp_echo) $(src)QueryMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(QueryMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(QueryMgr_cppflags) $(QueryMgr_cpp_cppflags)  $(src)QueryMgr.cpp
endif
endif

else
$(bin)lcg_CoralServer_dependencies.make : $(QueryMgr_cpp_dependencies)

$(bin)lcg_CoralServer_dependencies.make : $(src)QueryMgr.cpp

$(bin)$(binobj)QueryMgr.o : $(QueryMgr_cpp_dependencies)
	$(cpp_echo) $(src)QueryMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServer_pp_cppflags) $(lib_lcg_CoralServer_pp_cppflags) $(QueryMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralServer_cppflags) $(lib_lcg_CoralServer_cppflags) $(QueryMgr_cppflags) $(QueryMgr_cpp_cppflags)  $(src)QueryMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralServerclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralServer.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralServerclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralServer
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralServer$(library_suffix).a $(library_prefix)lcg_CoralServer$(library_suffix).$(shlibsuffix) lcg_CoralServer.stamp lcg_CoralServer.shstamp
#-- end of cleanup_library ---------------
