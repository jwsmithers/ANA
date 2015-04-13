#-- start of make_header -----------------

#====================================
#  Library lcg_ConnectionService
#
#   Generated Tue Mar 31 10:25:28 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_ConnectionService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_ConnectionService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_ConnectionService

ConnectionService_tag = $(tag)

#cmt_local_tagfile_lcg_ConnectionService = $(ConnectionService_tag)_lcg_ConnectionService.make
cmt_local_tagfile_lcg_ConnectionService = $(bin)$(ConnectionService_tag)_lcg_ConnectionService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ConnectionService_tag = $(tag)

#cmt_local_tagfile_lcg_ConnectionService = $(ConnectionService_tag).make
cmt_local_tagfile_lcg_ConnectionService = $(bin)$(ConnectionService_tag).make

endif

include $(cmt_local_tagfile_lcg_ConnectionService)
#-include $(cmt_local_tagfile_lcg_ConnectionService)

ifdef cmt_lcg_ConnectionService_has_target_tag

cmt_final_setup_lcg_ConnectionService = $(bin)setup_lcg_ConnectionService.make
cmt_dependencies_in_lcg_ConnectionService = $(bin)dependencies_lcg_ConnectionService.in
#cmt_final_setup_lcg_ConnectionService = $(bin)ConnectionService_lcg_ConnectionServicesetup.make
cmt_local_lcg_ConnectionService_makefile = $(bin)lcg_ConnectionService.make

else

cmt_final_setup_lcg_ConnectionService = $(bin)setup.make
cmt_dependencies_in_lcg_ConnectionService = $(bin)dependencies.in
#cmt_final_setup_lcg_ConnectionService = $(bin)ConnectionServicesetup.make
cmt_local_lcg_ConnectionService_makefile = $(bin)lcg_ConnectionService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ConnectionServicesetup.make

#lcg_ConnectionService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_ConnectionService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_ConnectionService/
#lcg_ConnectionService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_ConnectionServicelibname   = $(bin)$(library_prefix)lcg_ConnectionService$(library_suffix)
lcg_ConnectionServicelib       = $(lcg_ConnectionServicelibname).a
lcg_ConnectionServicestamp     = $(bin)lcg_ConnectionService.stamp
lcg_ConnectionServiceshstamp   = $(bin)lcg_ConnectionService.shstamp

lcg_ConnectionService :: dirs  lcg_ConnectionServiceLIB
	$(echo) "lcg_ConnectionService ok"

cmt_lcg_ConnectionService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_ConnectionService_has_prototypes

lcg_ConnectionServiceprototype :  ;

endif

lcg_ConnectionServicecompile : $(bin)ConnectionPool.o $(bin)ConnectionHandle.o $(bin)UidGenerator.o $(bin)ConnectionMap.o $(bin)SessionHandle.o $(bin)module.o $(bin)ConnectionServiceConfiguration.o $(bin)ConnectionPoolTimer.o $(bin)ConnectionService.o $(bin)ReplicaCatalogue.o $(bin)WebCacheControl.o $(bin)TransactionProxy.o $(bin)ServiceSpecificConfiguration.o $(bin)DataSource.o $(bin)SessionProxy.o $(bin)ConnectionParams.o $(bin)ConnectionString.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_ConnectionServiceLIB :: $(lcg_ConnectionServicelib) $(lcg_ConnectionServiceshstamp)
	@/bin/echo "------> lcg_ConnectionService : library ok"

$(lcg_ConnectionServicelib) :: $(bin)ConnectionPool.o $(bin)ConnectionHandle.o $(bin)UidGenerator.o $(bin)ConnectionMap.o $(bin)SessionHandle.o $(bin)module.o $(bin)ConnectionServiceConfiguration.o $(bin)ConnectionPoolTimer.o $(bin)ConnectionService.o $(bin)ReplicaCatalogue.o $(bin)WebCacheControl.o $(bin)TransactionProxy.o $(bin)ServiceSpecificConfiguration.o $(bin)DataSource.o $(bin)SessionProxy.o $(bin)ConnectionParams.o $(bin)ConnectionString.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_ConnectionServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_ConnectionServicelib)
	$(lib_silent) cat /dev/null >$(lcg_ConnectionServicestamp)

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

$(lcg_ConnectionServicelibname).$(shlibsuffix) :: $(lcg_ConnectionServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_ConnectionService $(lcg_ConnectionService_shlibflags)

$(lcg_ConnectionServiceshstamp) :: $(lcg_ConnectionServicelibname).$(shlibsuffix)
	@if test -f $(lcg_ConnectionServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_ConnectionServiceshstamp) ; fi

lcg_ConnectionServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)ConnectionPool.o $(bin)ConnectionHandle.o $(bin)UidGenerator.o $(bin)ConnectionMap.o $(bin)SessionHandle.o $(bin)module.o $(bin)ConnectionServiceConfiguration.o $(bin)ConnectionPoolTimer.o $(bin)ConnectionService.o $(bin)ReplicaCatalogue.o $(bin)WebCacheControl.o $(bin)TransactionProxy.o $(bin)ServiceSpecificConfiguration.o $(bin)DataSource.o $(bin)SessionProxy.o $(bin)ConnectionParams.o $(bin)ConnectionString.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_ConnectionServiceinstallname = $(library_prefix)lcg_ConnectionService$(library_suffix).$(shlibsuffix)

lcg_ConnectionService :: lcg_ConnectionServiceinstall

install :: lcg_ConnectionServiceinstall

lcg_ConnectionServiceinstall :: $(install_dir)/$(lcg_ConnectionServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_ConnectionServiceinstallname) :: $(bin)$(lcg_ConnectionServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_ConnectionServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_ConnectionServiceclean :: lcg_ConnectionServiceuninstall

uninstall :: lcg_ConnectionServiceuninstall

lcg_ConnectionServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_ConnectionServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceprototype)

$(bin)lcg_ConnectionService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_ConnectionService)
	$(echo) "(lcg_ConnectionService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ConnectionPool.cpp $(src)ConnectionHandle.cpp $(src)UidGenerator.cpp $(src)ConnectionMap.cpp $(src)SessionHandle.cpp $(src)module.cpp $(src)ConnectionServiceConfiguration.cpp $(src)ConnectionPoolTimer.cpp $(src)ConnectionService.cpp $(src)ReplicaCatalogue.cpp $(src)WebCacheControl.cpp $(src)TransactionProxy.cpp $(src)ServiceSpecificConfiguration.cpp $(src)DataSource.cpp $(src)SessionProxy.cpp $(src)ConnectionParams.cpp $(src)ConnectionString.cpp -end_all $(includes) $(app_lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) -name=lcg_ConnectionService $? -f=$(cmt_dependencies_in_lcg_ConnectionService) -without_cmt

-include $(bin)lcg_ConnectionService_dependencies.make

endif
endif
endif

lcg_ConnectionServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_ConnectionService_deps $(bin)lcg_ConnectionService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionPool.d

$(bin)$(binobj)ConnectionPool.d :

$(bin)$(binobj)ConnectionPool.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionPool.o : $(src)ConnectionPool.cpp
	$(cpp_echo) $(src)ConnectionPool.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionPool_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionPool_cppflags) $(ConnectionPool_cpp_cppflags)  $(src)ConnectionPool.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionPool_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionPool.cpp

$(bin)$(binobj)ConnectionPool.o : $(ConnectionPool_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionPool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionPool_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionPool_cppflags) $(ConnectionPool_cpp_cppflags)  $(src)ConnectionPool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionHandle.d

$(bin)$(binobj)ConnectionHandle.d :

$(bin)$(binobj)ConnectionHandle.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionHandle.o : $(src)ConnectionHandle.cpp
	$(cpp_echo) $(src)ConnectionHandle.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionHandle_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionHandle_cppflags) $(ConnectionHandle_cpp_cppflags)  $(src)ConnectionHandle.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionHandle_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionHandle.cpp

$(bin)$(binobj)ConnectionHandle.o : $(ConnectionHandle_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionHandle.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionHandle_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionHandle_cppflags) $(ConnectionHandle_cpp_cppflags)  $(src)ConnectionHandle.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UidGenerator.d

$(bin)$(binobj)UidGenerator.d :

$(bin)$(binobj)UidGenerator.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)UidGenerator.o : $(src)UidGenerator.cpp
	$(cpp_echo) $(src)UidGenerator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(UidGenerator_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(UidGenerator_cppflags) $(UidGenerator_cpp_cppflags)  $(src)UidGenerator.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(UidGenerator_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)UidGenerator.cpp

$(bin)$(binobj)UidGenerator.o : $(UidGenerator_cpp_dependencies)
	$(cpp_echo) $(src)UidGenerator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(UidGenerator_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(UidGenerator_cppflags) $(UidGenerator_cpp_cppflags)  $(src)UidGenerator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionMap.d

$(bin)$(binobj)ConnectionMap.d :

$(bin)$(binobj)ConnectionMap.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionMap.o : $(src)ConnectionMap.cpp
	$(cpp_echo) $(src)ConnectionMap.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionMap_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionMap_cppflags) $(ConnectionMap_cpp_cppflags)  $(src)ConnectionMap.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionMap_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionMap.cpp

$(bin)$(binobj)ConnectionMap.o : $(ConnectionMap_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionMap.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionMap_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionMap_cppflags) $(ConnectionMap_cpp_cppflags)  $(src)ConnectionMap.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionHandle.d

$(bin)$(binobj)SessionHandle.d :

$(bin)$(binobj)SessionHandle.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)SessionHandle.o : $(src)SessionHandle.cpp
	$(cpp_echo) $(src)SessionHandle.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(SessionHandle_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(SessionHandle_cppflags) $(SessionHandle_cpp_cppflags)  $(src)SessionHandle.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(SessionHandle_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)SessionHandle.cpp

$(bin)$(binobj)SessionHandle.o : $(SessionHandle_cpp_dependencies)
	$(cpp_echo) $(src)SessionHandle.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(SessionHandle_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(SessionHandle_cppflags) $(SessionHandle_cpp_cppflags)  $(src)SessionHandle.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionServiceConfiguration.d

$(bin)$(binobj)ConnectionServiceConfiguration.d :

$(bin)$(binobj)ConnectionServiceConfiguration.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionServiceConfiguration.o : $(src)ConnectionServiceConfiguration.cpp
	$(cpp_echo) $(src)ConnectionServiceConfiguration.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionServiceConfiguration_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionServiceConfiguration_cppflags) $(ConnectionServiceConfiguration_cpp_cppflags)  $(src)ConnectionServiceConfiguration.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionServiceConfiguration_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionServiceConfiguration.cpp

$(bin)$(binobj)ConnectionServiceConfiguration.o : $(ConnectionServiceConfiguration_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionServiceConfiguration.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionServiceConfiguration_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionServiceConfiguration_cppflags) $(ConnectionServiceConfiguration_cpp_cppflags)  $(src)ConnectionServiceConfiguration.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionPoolTimer.d

$(bin)$(binobj)ConnectionPoolTimer.d :

$(bin)$(binobj)ConnectionPoolTimer.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionPoolTimer.o : $(src)ConnectionPoolTimer.cpp
	$(cpp_echo) $(src)ConnectionPoolTimer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionPoolTimer_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionPoolTimer_cppflags) $(ConnectionPoolTimer_cpp_cppflags)  $(src)ConnectionPoolTimer.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionPoolTimer_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionPoolTimer.cpp

$(bin)$(binobj)ConnectionPoolTimer.o : $(ConnectionPoolTimer_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionPoolTimer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionPoolTimer_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionPoolTimer_cppflags) $(ConnectionPoolTimer_cpp_cppflags)  $(src)ConnectionPoolTimer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionService.d

$(bin)$(binobj)ConnectionService.d :

$(bin)$(binobj)ConnectionService.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionService.o : $(src)ConnectionService.cpp
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionService_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionService.cpp

$(bin)$(binobj)ConnectionService.o : $(ConnectionService_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReplicaCatalogue.d

$(bin)$(binobj)ReplicaCatalogue.d :

$(bin)$(binobj)ReplicaCatalogue.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ReplicaCatalogue.o : $(src)ReplicaCatalogue.cpp
	$(cpp_echo) $(src)ReplicaCatalogue.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ReplicaCatalogue_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ReplicaCatalogue_cppflags) $(ReplicaCatalogue_cpp_cppflags)  $(src)ReplicaCatalogue.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ReplicaCatalogue_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ReplicaCatalogue.cpp

$(bin)$(binobj)ReplicaCatalogue.o : $(ReplicaCatalogue_cpp_dependencies)
	$(cpp_echo) $(src)ReplicaCatalogue.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ReplicaCatalogue_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ReplicaCatalogue_cppflags) $(ReplicaCatalogue_cpp_cppflags)  $(src)ReplicaCatalogue.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WebCacheControl.d

$(bin)$(binobj)WebCacheControl.d :

$(bin)$(binobj)WebCacheControl.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)WebCacheControl.o : $(src)WebCacheControl.cpp
	$(cpp_echo) $(src)WebCacheControl.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(WebCacheControl_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(WebCacheControl_cppflags) $(WebCacheControl_cpp_cppflags)  $(src)WebCacheControl.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(WebCacheControl_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)WebCacheControl.cpp

$(bin)$(binobj)WebCacheControl.o : $(WebCacheControl_cpp_dependencies)
	$(cpp_echo) $(src)WebCacheControl.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(WebCacheControl_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(WebCacheControl_cppflags) $(WebCacheControl_cpp_cppflags)  $(src)WebCacheControl.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransactionProxy.d

$(bin)$(binobj)TransactionProxy.d :

$(bin)$(binobj)TransactionProxy.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)TransactionProxy.o : $(src)TransactionProxy.cpp
	$(cpp_echo) $(src)TransactionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(TransactionProxy_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(TransactionProxy_cppflags) $(TransactionProxy_cpp_cppflags)  $(src)TransactionProxy.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(TransactionProxy_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)TransactionProxy.cpp

$(bin)$(binobj)TransactionProxy.o : $(TransactionProxy_cpp_dependencies)
	$(cpp_echo) $(src)TransactionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(TransactionProxy_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(TransactionProxy_cppflags) $(TransactionProxy_cpp_cppflags)  $(src)TransactionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceSpecificConfiguration.d

$(bin)$(binobj)ServiceSpecificConfiguration.d :

$(bin)$(binobj)ServiceSpecificConfiguration.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ServiceSpecificConfiguration.o : $(src)ServiceSpecificConfiguration.cpp
	$(cpp_echo) $(src)ServiceSpecificConfiguration.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ServiceSpecificConfiguration_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ServiceSpecificConfiguration_cppflags) $(ServiceSpecificConfiguration_cpp_cppflags)  $(src)ServiceSpecificConfiguration.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ServiceSpecificConfiguration_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ServiceSpecificConfiguration.cpp

$(bin)$(binobj)ServiceSpecificConfiguration.o : $(ServiceSpecificConfiguration_cpp_dependencies)
	$(cpp_echo) $(src)ServiceSpecificConfiguration.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ServiceSpecificConfiguration_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ServiceSpecificConfiguration_cppflags) $(ServiceSpecificConfiguration_cpp_cppflags)  $(src)ServiceSpecificConfiguration.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataSource.d

$(bin)$(binobj)DataSource.d :

$(bin)$(binobj)DataSource.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)DataSource.o : $(src)DataSource.cpp
	$(cpp_echo) $(src)DataSource.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(DataSource_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(DataSource_cppflags) $(DataSource_cpp_cppflags)  $(src)DataSource.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(DataSource_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)DataSource.cpp

$(bin)$(binobj)DataSource.o : $(DataSource_cpp_dependencies)
	$(cpp_echo) $(src)DataSource.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(DataSource_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(DataSource_cppflags) $(DataSource_cpp_cppflags)  $(src)DataSource.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionProxy.d

$(bin)$(binobj)SessionProxy.d :

$(bin)$(binobj)SessionProxy.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)SessionProxy.o : $(src)SessionProxy.cpp
	$(cpp_echo) $(src)SessionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(SessionProxy_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(SessionProxy_cppflags) $(SessionProxy_cpp_cppflags)  $(src)SessionProxy.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(SessionProxy_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)SessionProxy.cpp

$(bin)$(binobj)SessionProxy.o : $(SessionProxy_cpp_dependencies)
	$(cpp_echo) $(src)SessionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(SessionProxy_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(SessionProxy_cppflags) $(SessionProxy_cpp_cppflags)  $(src)SessionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionParams.d

$(bin)$(binobj)ConnectionParams.d :

$(bin)$(binobj)ConnectionParams.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionParams.o : $(src)ConnectionParams.cpp
	$(cpp_echo) $(src)ConnectionParams.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionParams_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionParams_cppflags) $(ConnectionParams_cpp_cppflags)  $(src)ConnectionParams.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionParams_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionParams.cpp

$(bin)$(binobj)ConnectionParams.o : $(ConnectionParams_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionParams.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionParams_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionParams_cppflags) $(ConnectionParams_cpp_cppflags)  $(src)ConnectionParams.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_ConnectionServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionString.d

$(bin)$(binobj)ConnectionString.d :

$(bin)$(binobj)ConnectionString.o : $(cmt_final_setup_lcg_ConnectionService)

$(bin)$(binobj)ConnectionString.o : $(src)ConnectionString.cpp
	$(cpp_echo) $(src)ConnectionString.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionString_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionString_cppflags) $(ConnectionString_cpp_cppflags)  $(src)ConnectionString.cpp
endif
endif

else
$(bin)lcg_ConnectionService_dependencies.make : $(ConnectionString_cpp_dependencies)

$(bin)lcg_ConnectionService_dependencies.make : $(src)ConnectionString.cpp

$(bin)$(binobj)ConnectionString.o : $(ConnectionString_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionString.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_ConnectionService_pp_cppflags) $(lib_lcg_ConnectionService_pp_cppflags) $(ConnectionString_pp_cppflags) $(use_cppflags) $(lcg_ConnectionService_cppflags) $(lib_lcg_ConnectionService_cppflags) $(ConnectionString_cppflags) $(ConnectionString_cpp_cppflags)  $(src)ConnectionString.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_ConnectionServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_ConnectionService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_ConnectionServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_ConnectionService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_ConnectionService$(library_suffix).a $(library_prefix)lcg_ConnectionService$(library_suffix).$(shlibsuffix) lcg_ConnectionService.stamp lcg_ConnectionService.shstamp
#-- end of cleanup_library ---------------
