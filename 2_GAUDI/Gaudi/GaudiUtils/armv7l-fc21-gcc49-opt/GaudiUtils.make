#-- start of make_header -----------------

#====================================
#  Library GaudiUtils
#
#   Generated Mon Feb 16 19:56:43 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtils_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtils_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtils

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtils = $(GaudiUtils_tag)_GaudiUtils.make
cmt_local_tagfile_GaudiUtils = $(bin)$(GaudiUtils_tag)_GaudiUtils.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtils = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtils = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtils)
#-include $(cmt_local_tagfile_GaudiUtils)

ifdef cmt_GaudiUtils_has_target_tag

cmt_final_setup_GaudiUtils = $(bin)setup_GaudiUtils.make
cmt_dependencies_in_GaudiUtils = $(bin)dependencies_GaudiUtils.in
#cmt_final_setup_GaudiUtils = $(bin)GaudiUtils_GaudiUtilssetup.make
cmt_local_GaudiUtils_makefile = $(bin)GaudiUtils.make

else

cmt_final_setup_GaudiUtils = $(bin)setup.make
cmt_dependencies_in_GaudiUtils = $(bin)dependencies.in
#cmt_final_setup_GaudiUtils = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtils_makefile = $(bin)GaudiUtils.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtils :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtils'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtils/
#GaudiUtils::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiUtilslibname   = $(bin)$(library_prefix)GaudiUtils$(library_suffix)
GaudiUtilslib       = $(GaudiUtilslibname).a
GaudiUtilsstamp     = $(bin)GaudiUtils.stamp
GaudiUtilsshstamp   = $(bin)GaudiUtils.shstamp

GaudiUtils :: dirs  GaudiUtilsLIB
	$(echo) "GaudiUtils ok"

cmt_GaudiUtils_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiUtils_has_prototypes

GaudiUtilsprototype :  ;

endif

GaudiUtilscompile : $(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiUtilsLIB :: $(GaudiUtilslib) $(GaudiUtilsshstamp)
GaudiUtilsLIB :: $(GaudiUtilsshstamp)
	$(echo) "GaudiUtils : library ok"

$(GaudiUtilslib) :: $(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiUtilslib) $?
	$(lib_silent) $(ranlib) $(GaudiUtilslib)
	$(lib_silent) cat /dev/null >$(GaudiUtilsstamp)

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

$(GaudiUtilslibname).$(shlibsuffix) :: $(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o $(use_requirements) $(GaudiUtilsstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o $(GaudiUtils_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiUtilsstamp) && \
	  cat /dev/null >$(GaudiUtilsshstamp)

$(GaudiUtilsshstamp) :: $(GaudiUtilslibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiUtilslibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiUtilsstamp) && \
	  cat /dev/null >$(GaudiUtilsshstamp) ; fi

GaudiUtilsclean ::
	$(cleanup_echo) objects GaudiUtils
	$(cleanup_silent) /bin/rm -f $(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o) $(patsubst %.o,%.dep,$(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o) $(patsubst %.o,%.d.stamp,$(bin)XMLCatalogTest.o $(bin)MultiFileCatalog.o $(bin)SignalMonitorSvc.o $(bin)StalledEventMonitor.o $(bin)VFSSvc.o $(bin)XMLFileCatalog.o $(bin)IODataManager.o $(bin)FileReadTool.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiUtils_deps GaudiUtils_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiUtilsinstallname = $(library_prefix)GaudiUtils$(library_suffix).$(shlibsuffix)

GaudiUtils :: GaudiUtilsinstall ;

install :: GaudiUtilsinstall ;

GaudiUtilsinstall :: $(install_dir)/$(GaudiUtilsinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiUtilsinstallname) :: $(bin)$(GaudiUtilsinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiUtilsinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiUtilsclean :: GaudiUtilsuninstall

uninstall :: GaudiUtilsuninstall ;

GaudiUtilsuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiUtilsinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLCatalogTest.d

$(bin)$(binobj)XMLCatalogTest.d :

$(bin)$(binobj)XMLCatalogTest.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)XMLCatalogTest.o : $(src)component/XMLCatalogTest.cpp
	$(cpp_echo) $(src)component/XMLCatalogTest.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(XMLCatalogTest_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(XMLCatalogTest_cppflags) $(XMLCatalogTest_cpp_cppflags) -I../src/component $(src)component/XMLCatalogTest.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(XMLCatalogTest_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/XMLCatalogTest.cpp

$(bin)$(binobj)XMLCatalogTest.o : $(XMLCatalogTest_cpp_dependencies)
	$(cpp_echo) $(src)component/XMLCatalogTest.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(XMLCatalogTest_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(XMLCatalogTest_cppflags) $(XMLCatalogTest_cpp_cppflags) -I../src/component $(src)component/XMLCatalogTest.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MultiFileCatalog.d

$(bin)$(binobj)MultiFileCatalog.d :

$(bin)$(binobj)MultiFileCatalog.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)MultiFileCatalog.o : $(src)component/MultiFileCatalog.cpp
	$(cpp_echo) $(src)component/MultiFileCatalog.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(MultiFileCatalog_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(MultiFileCatalog_cppflags) $(MultiFileCatalog_cpp_cppflags) -I../src/component $(src)component/MultiFileCatalog.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(MultiFileCatalog_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/MultiFileCatalog.cpp

$(bin)$(binobj)MultiFileCatalog.o : $(MultiFileCatalog_cpp_dependencies)
	$(cpp_echo) $(src)component/MultiFileCatalog.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(MultiFileCatalog_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(MultiFileCatalog_cppflags) $(MultiFileCatalog_cpp_cppflags) -I../src/component $(src)component/MultiFileCatalog.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SignalMonitorSvc.d

$(bin)$(binobj)SignalMonitorSvc.d :

$(bin)$(binobj)SignalMonitorSvc.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)SignalMonitorSvc.o : $(src)component/SignalMonitorSvc.cpp
	$(cpp_echo) $(src)component/SignalMonitorSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(SignalMonitorSvc_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(SignalMonitorSvc_cppflags) $(SignalMonitorSvc_cpp_cppflags) -I../src/component $(src)component/SignalMonitorSvc.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(SignalMonitorSvc_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/SignalMonitorSvc.cpp

$(bin)$(binobj)SignalMonitorSvc.o : $(SignalMonitorSvc_cpp_dependencies)
	$(cpp_echo) $(src)component/SignalMonitorSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(SignalMonitorSvc_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(SignalMonitorSvc_cppflags) $(SignalMonitorSvc_cpp_cppflags) -I../src/component $(src)component/SignalMonitorSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StalledEventMonitor.d

$(bin)$(binobj)StalledEventMonitor.d :

$(bin)$(binobj)StalledEventMonitor.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)StalledEventMonitor.o : $(src)component/StalledEventMonitor.cpp
	$(cpp_echo) $(src)component/StalledEventMonitor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(StalledEventMonitor_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(StalledEventMonitor_cppflags) $(StalledEventMonitor_cpp_cppflags) -I../src/component $(src)component/StalledEventMonitor.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(StalledEventMonitor_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/StalledEventMonitor.cpp

$(bin)$(binobj)StalledEventMonitor.o : $(StalledEventMonitor_cpp_dependencies)
	$(cpp_echo) $(src)component/StalledEventMonitor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(StalledEventMonitor_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(StalledEventMonitor_cppflags) $(StalledEventMonitor_cpp_cppflags) -I../src/component $(src)component/StalledEventMonitor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)VFSSvc.d

$(bin)$(binobj)VFSSvc.d :

$(bin)$(binobj)VFSSvc.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)VFSSvc.o : $(src)component/VFSSvc.cpp
	$(cpp_echo) $(src)component/VFSSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(VFSSvc_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(VFSSvc_cppflags) $(VFSSvc_cpp_cppflags) -I../src/component $(src)component/VFSSvc.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(VFSSvc_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/VFSSvc.cpp

$(bin)$(binobj)VFSSvc.o : $(VFSSvc_cpp_dependencies)
	$(cpp_echo) $(src)component/VFSSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(VFSSvc_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(VFSSvc_cppflags) $(VFSSvc_cpp_cppflags) -I../src/component $(src)component/VFSSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLFileCatalog.d

$(bin)$(binobj)XMLFileCatalog.d :

$(bin)$(binobj)XMLFileCatalog.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)XMLFileCatalog.o : $(src)component/XMLFileCatalog.cpp
	$(cpp_echo) $(src)component/XMLFileCatalog.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(XMLFileCatalog_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(XMLFileCatalog_cppflags) $(XMLFileCatalog_cpp_cppflags) -I../src/component $(src)component/XMLFileCatalog.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(XMLFileCatalog_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/XMLFileCatalog.cpp

$(bin)$(binobj)XMLFileCatalog.o : $(XMLFileCatalog_cpp_dependencies)
	$(cpp_echo) $(src)component/XMLFileCatalog.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(XMLFileCatalog_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(XMLFileCatalog_cppflags) $(XMLFileCatalog_cpp_cppflags) -I../src/component $(src)component/XMLFileCatalog.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IODataManager.d

$(bin)$(binobj)IODataManager.d :

$(bin)$(binobj)IODataManager.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)IODataManager.o : $(src)component/IODataManager.cpp
	$(cpp_echo) $(src)component/IODataManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(IODataManager_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(IODataManager_cppflags) $(IODataManager_cpp_cppflags) -I../src/component $(src)component/IODataManager.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(IODataManager_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/IODataManager.cpp

$(bin)$(binobj)IODataManager.o : $(IODataManager_cpp_dependencies)
	$(cpp_echo) $(src)component/IODataManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(IODataManager_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(IODataManager_cppflags) $(IODataManager_cpp_cppflags) -I../src/component $(src)component/IODataManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileReadTool.d

$(bin)$(binobj)FileReadTool.d :

$(bin)$(binobj)FileReadTool.o : $(cmt_final_setup_GaudiUtils)

$(bin)$(binobj)FileReadTool.o : $(src)component/FileReadTool.cpp
	$(cpp_echo) $(src)component/FileReadTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(FileReadTool_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(FileReadTool_cppflags) $(FileReadTool_cpp_cppflags) -I../src/component $(src)component/FileReadTool.cpp
endif
endif

else
$(bin)GaudiUtils_dependencies.make : $(FileReadTool_cpp_dependencies)

$(bin)GaudiUtils_dependencies.make : $(src)component/FileReadTool.cpp

$(bin)$(binobj)FileReadTool.o : $(FileReadTool_cpp_dependencies)
	$(cpp_echo) $(src)component/FileReadTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtils_pp_cppflags) $(lib_GaudiUtils_pp_cppflags) $(FileReadTool_pp_cppflags) $(use_cppflags) $(GaudiUtils_cppflags) $(lib_GaudiUtils_cppflags) $(FileReadTool_cppflags) $(FileReadTool_cpp_cppflags) -I../src/component $(src)component/FileReadTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiUtilsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtils.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiUtils
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiUtils$(library_suffix).a $(library_prefix)GaudiUtils$(library_suffix).$(shlibsuffix) GaudiUtils.stamp GaudiUtils.shstamp
#-- end of cleanup_library ---------------
