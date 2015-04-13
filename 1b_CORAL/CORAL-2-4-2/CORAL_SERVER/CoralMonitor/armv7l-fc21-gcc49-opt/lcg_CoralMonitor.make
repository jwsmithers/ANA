#-- start of make_header -----------------

#====================================
#  Library lcg_CoralMonitor
#
#   Generated Wed Jan 21 17:16:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralMonitor_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralMonitor_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralMonitor

CoralMonitor_tag = $(tag)

#cmt_local_tagfile_lcg_CoralMonitor = $(CoralMonitor_tag)_lcg_CoralMonitor.make
cmt_local_tagfile_lcg_CoralMonitor = $(bin)$(CoralMonitor_tag)_lcg_CoralMonitor.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralMonitor_tag = $(tag)

#cmt_local_tagfile_lcg_CoralMonitor = $(CoralMonitor_tag).make
cmt_local_tagfile_lcg_CoralMonitor = $(bin)$(CoralMonitor_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralMonitor)
#-include $(cmt_local_tagfile_lcg_CoralMonitor)

ifdef cmt_lcg_CoralMonitor_has_target_tag

cmt_final_setup_lcg_CoralMonitor = $(bin)setup_lcg_CoralMonitor.make
cmt_dependencies_in_lcg_CoralMonitor = $(bin)dependencies_lcg_CoralMonitor.in
#cmt_final_setup_lcg_CoralMonitor = $(bin)CoralMonitor_lcg_CoralMonitorsetup.make
cmt_local_lcg_CoralMonitor_makefile = $(bin)lcg_CoralMonitor.make

else

cmt_final_setup_lcg_CoralMonitor = $(bin)setup.make
cmt_dependencies_in_lcg_CoralMonitor = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralMonitor = $(bin)CoralMonitorsetup.make
cmt_local_lcg_CoralMonitor_makefile = $(bin)lcg_CoralMonitor.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralMonitorsetup.make

#lcg_CoralMonitor :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralMonitor'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralMonitor/
#lcg_CoralMonitor::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralMonitorlibname   = $(bin)$(library_prefix)lcg_CoralMonitor$(library_suffix)
lcg_CoralMonitorlib       = $(lcg_CoralMonitorlibname).a
lcg_CoralMonitorstamp     = $(bin)lcg_CoralMonitor.stamp
lcg_CoralMonitorshstamp   = $(bin)lcg_CoralMonitor.shstamp

lcg_CoralMonitor :: dirs  lcg_CoralMonitorLIB
	$(echo) "lcg_CoralMonitor ok"

cmt_lcg_CoralMonitor_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralMonitor_has_prototypes

lcg_CoralMonitorprototype :  ;

endif

lcg_CoralMonitorcompile : $(bin)CPUsageData.o $(bin)StatsTypeMEMUsage.o $(bin)StatsTypeTimer.o $(bin)StatsStorage.o $(bin)StatsSimpleBuffer.o $(bin)StatsTypeCounter.o $(bin)StopTimer.o $(bin)StatsCSVPlotter.o $(bin)StatsTypeBandwidth.o $(bin)StatsTypeCPUsage.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralMonitorLIB :: $(lcg_CoralMonitorlib) $(lcg_CoralMonitorshstamp)
	@/bin/echo "------> lcg_CoralMonitor : library ok"

$(lcg_CoralMonitorlib) :: $(bin)CPUsageData.o $(bin)StatsTypeMEMUsage.o $(bin)StatsTypeTimer.o $(bin)StatsStorage.o $(bin)StatsSimpleBuffer.o $(bin)StatsTypeCounter.o $(bin)StopTimer.o $(bin)StatsCSVPlotter.o $(bin)StatsTypeBandwidth.o $(bin)StatsTypeCPUsage.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralMonitorlib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralMonitorlib)
	$(lib_silent) cat /dev/null >$(lcg_CoralMonitorstamp)

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

$(lcg_CoralMonitorlibname).$(shlibsuffix) :: $(lcg_CoralMonitorlib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralMonitor $(lcg_CoralMonitor_shlibflags)

$(lcg_CoralMonitorshstamp) :: $(lcg_CoralMonitorlibname).$(shlibsuffix)
	@if test -f $(lcg_CoralMonitorlibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralMonitorshstamp) ; fi

lcg_CoralMonitorclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)CPUsageData.o $(bin)StatsTypeMEMUsage.o $(bin)StatsTypeTimer.o $(bin)StatsStorage.o $(bin)StatsSimpleBuffer.o $(bin)StatsTypeCounter.o $(bin)StopTimer.o $(bin)StatsCSVPlotter.o $(bin)StatsTypeBandwidth.o $(bin)StatsTypeCPUsage.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralMonitorinstallname = $(library_prefix)lcg_CoralMonitor$(library_suffix).$(shlibsuffix)

lcg_CoralMonitor :: lcg_CoralMonitorinstall

install :: lcg_CoralMonitorinstall

lcg_CoralMonitorinstall :: $(install_dir)/$(lcg_CoralMonitorinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralMonitorinstallname) :: $(bin)$(lcg_CoralMonitorinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralMonitorinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralMonitorclean :: lcg_CoralMonitoruninstall

uninstall :: lcg_CoralMonitoruninstall

lcg_CoralMonitoruninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralMonitorinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralMonitorprototype)

$(bin)lcg_CoralMonitor_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralMonitor)
	$(echo) "(lcg_CoralMonitor.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CPUsageData.cpp $(src)StatsTypeMEMUsage.cpp $(src)StatsTypeTimer.cpp $(src)StatsStorage.cpp $(src)StatsSimpleBuffer.cpp $(src)StatsTypeCounter.cpp $(src)StopTimer.cpp $(src)StatsCSVPlotter.cpp $(src)StatsTypeBandwidth.cpp $(src)StatsTypeCPUsage.cpp -end_all $(includes) $(app_lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) -name=lcg_CoralMonitor $? -f=$(cmt_dependencies_in_lcg_CoralMonitor) -without_cmt

-include $(bin)lcg_CoralMonitor_dependencies.make

endif
endif
endif

lcg_CoralMonitorclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralMonitor_deps $(bin)lcg_CoralMonitor_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CPUsageData.d

$(bin)$(binobj)CPUsageData.d :

$(bin)$(binobj)CPUsageData.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)CPUsageData.o : $(src)CPUsageData.cpp
	$(cpp_echo) $(src)CPUsageData.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(CPUsageData_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(CPUsageData_cppflags) $(CPUsageData_cpp_cppflags)  $(src)CPUsageData.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(CPUsageData_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)CPUsageData.cpp

$(bin)$(binobj)CPUsageData.o : $(CPUsageData_cpp_dependencies)
	$(cpp_echo) $(src)CPUsageData.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(CPUsageData_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(CPUsageData_cppflags) $(CPUsageData_cpp_cppflags)  $(src)CPUsageData.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsTypeMEMUsage.d

$(bin)$(binobj)StatsTypeMEMUsage.d :

$(bin)$(binobj)StatsTypeMEMUsage.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsTypeMEMUsage.o : $(src)StatsTypeMEMUsage.cpp
	$(cpp_echo) $(src)StatsTypeMEMUsage.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeMEMUsage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeMEMUsage_cppflags) $(StatsTypeMEMUsage_cpp_cppflags)  $(src)StatsTypeMEMUsage.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsTypeMEMUsage_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsTypeMEMUsage.cpp

$(bin)$(binobj)StatsTypeMEMUsage.o : $(StatsTypeMEMUsage_cpp_dependencies)
	$(cpp_echo) $(src)StatsTypeMEMUsage.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeMEMUsage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeMEMUsage_cppflags) $(StatsTypeMEMUsage_cpp_cppflags)  $(src)StatsTypeMEMUsage.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsTypeTimer.d

$(bin)$(binobj)StatsTypeTimer.d :

$(bin)$(binobj)StatsTypeTimer.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsTypeTimer.o : $(src)StatsTypeTimer.cpp
	$(cpp_echo) $(src)StatsTypeTimer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeTimer_cppflags) $(StatsTypeTimer_cpp_cppflags)  $(src)StatsTypeTimer.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsTypeTimer_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsTypeTimer.cpp

$(bin)$(binobj)StatsTypeTimer.o : $(StatsTypeTimer_cpp_dependencies)
	$(cpp_echo) $(src)StatsTypeTimer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeTimer_cppflags) $(StatsTypeTimer_cpp_cppflags)  $(src)StatsTypeTimer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsStorage.d

$(bin)$(binobj)StatsStorage.d :

$(bin)$(binobj)StatsStorage.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsStorage.o : $(src)StatsStorage.cpp
	$(cpp_echo) $(src)StatsStorage.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsStorage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsStorage_cppflags) $(StatsStorage_cpp_cppflags)  $(src)StatsStorage.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsStorage_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsStorage.cpp

$(bin)$(binobj)StatsStorage.o : $(StatsStorage_cpp_dependencies)
	$(cpp_echo) $(src)StatsStorage.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsStorage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsStorage_cppflags) $(StatsStorage_cpp_cppflags)  $(src)StatsStorage.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsSimpleBuffer.d

$(bin)$(binobj)StatsSimpleBuffer.d :

$(bin)$(binobj)StatsSimpleBuffer.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsSimpleBuffer.o : $(src)StatsSimpleBuffer.cpp
	$(cpp_echo) $(src)StatsSimpleBuffer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsSimpleBuffer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsSimpleBuffer_cppflags) $(StatsSimpleBuffer_cpp_cppflags)  $(src)StatsSimpleBuffer.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsSimpleBuffer_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsSimpleBuffer.cpp

$(bin)$(binobj)StatsSimpleBuffer.o : $(StatsSimpleBuffer_cpp_dependencies)
	$(cpp_echo) $(src)StatsSimpleBuffer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsSimpleBuffer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsSimpleBuffer_cppflags) $(StatsSimpleBuffer_cpp_cppflags)  $(src)StatsSimpleBuffer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsTypeCounter.d

$(bin)$(binobj)StatsTypeCounter.d :

$(bin)$(binobj)StatsTypeCounter.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsTypeCounter.o : $(src)StatsTypeCounter.cpp
	$(cpp_echo) $(src)StatsTypeCounter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeCounter_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeCounter_cppflags) $(StatsTypeCounter_cpp_cppflags)  $(src)StatsTypeCounter.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsTypeCounter_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsTypeCounter.cpp

$(bin)$(binobj)StatsTypeCounter.o : $(StatsTypeCounter_cpp_dependencies)
	$(cpp_echo) $(src)StatsTypeCounter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeCounter_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeCounter_cppflags) $(StatsTypeCounter_cpp_cppflags)  $(src)StatsTypeCounter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StopTimer.d

$(bin)$(binobj)StopTimer.d :

$(bin)$(binobj)StopTimer.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StopTimer.o : $(src)StopTimer.cpp
	$(cpp_echo) $(src)StopTimer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StopTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StopTimer_cppflags) $(StopTimer_cpp_cppflags)  $(src)StopTimer.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StopTimer_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StopTimer.cpp

$(bin)$(binobj)StopTimer.o : $(StopTimer_cpp_dependencies)
	$(cpp_echo) $(src)StopTimer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StopTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StopTimer_cppflags) $(StopTimer_cpp_cppflags)  $(src)StopTimer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsCSVPlotter.d

$(bin)$(binobj)StatsCSVPlotter.d :

$(bin)$(binobj)StatsCSVPlotter.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsCSVPlotter.o : $(src)StatsCSVPlotter.cpp
	$(cpp_echo) $(src)StatsCSVPlotter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsCSVPlotter_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsCSVPlotter_cppflags) $(StatsCSVPlotter_cpp_cppflags)  $(src)StatsCSVPlotter.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsCSVPlotter_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsCSVPlotter.cpp

$(bin)$(binobj)StatsCSVPlotter.o : $(StatsCSVPlotter_cpp_dependencies)
	$(cpp_echo) $(src)StatsCSVPlotter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsCSVPlotter_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsCSVPlotter_cppflags) $(StatsCSVPlotter_cpp_cppflags)  $(src)StatsCSVPlotter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsTypeBandwidth.d

$(bin)$(binobj)StatsTypeBandwidth.d :

$(bin)$(binobj)StatsTypeBandwidth.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsTypeBandwidth.o : $(src)StatsTypeBandwidth.cpp
	$(cpp_echo) $(src)StatsTypeBandwidth.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeBandwidth_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeBandwidth_cppflags) $(StatsTypeBandwidth_cpp_cppflags)  $(src)StatsTypeBandwidth.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsTypeBandwidth_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsTypeBandwidth.cpp

$(bin)$(binobj)StatsTypeBandwidth.o : $(StatsTypeBandwidth_cpp_dependencies)
	$(cpp_echo) $(src)StatsTypeBandwidth.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeBandwidth_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeBandwidth_cppflags) $(StatsTypeBandwidth_cpp_cppflags)  $(src)StatsTypeBandwidth.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatsTypeCPUsage.d

$(bin)$(binobj)StatsTypeCPUsage.d :

$(bin)$(binobj)StatsTypeCPUsage.o : $(cmt_final_setup_lcg_CoralMonitor)

$(bin)$(binobj)StatsTypeCPUsage.o : $(src)StatsTypeCPUsage.cpp
	$(cpp_echo) $(src)StatsTypeCPUsage.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeCPUsage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeCPUsage_cppflags) $(StatsTypeCPUsage_cpp_cppflags)  $(src)StatsTypeCPUsage.cpp
endif
endif

else
$(bin)lcg_CoralMonitor_dependencies.make : $(StatsTypeCPUsage_cpp_dependencies)

$(bin)lcg_CoralMonitor_dependencies.make : $(src)StatsTypeCPUsage.cpp

$(bin)$(binobj)StatsTypeCPUsage.o : $(StatsTypeCPUsage_cpp_dependencies)
	$(cpp_echo) $(src)StatsTypeCPUsage.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralMonitor_pp_cppflags) $(lib_lcg_CoralMonitor_pp_cppflags) $(StatsTypeCPUsage_pp_cppflags) $(use_cppflags) $(lcg_CoralMonitor_cppflags) $(lib_lcg_CoralMonitor_cppflags) $(StatsTypeCPUsage_cppflags) $(StatsTypeCPUsage_cpp_cppflags)  $(src)StatsTypeCPUsage.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralMonitorclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralMonitor.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralMonitorclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralMonitor
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralMonitor$(library_suffix).a $(library_prefix)lcg_CoralMonitor$(library_suffix).$(shlibsuffix) lcg_CoralMonitor.stamp lcg_CoralMonitor.shstamp
#-- end of cleanup_library ---------------
