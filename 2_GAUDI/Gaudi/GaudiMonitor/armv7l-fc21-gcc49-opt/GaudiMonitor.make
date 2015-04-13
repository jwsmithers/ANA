#-- start of make_header -----------------

#====================================
#  Library GaudiMonitor
#
#   Generated Mon Feb 16 19:52:24 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMonitor_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMonitor_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMonitor

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitor = $(GaudiMonitor_tag)_GaudiMonitor.make
cmt_local_tagfile_GaudiMonitor = $(bin)$(GaudiMonitor_tag)_GaudiMonitor.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitor = $(GaudiMonitor_tag).make
cmt_local_tagfile_GaudiMonitor = $(bin)$(GaudiMonitor_tag).make

endif

include $(cmt_local_tagfile_GaudiMonitor)
#-include $(cmt_local_tagfile_GaudiMonitor)

ifdef cmt_GaudiMonitor_has_target_tag

cmt_final_setup_GaudiMonitor = $(bin)setup_GaudiMonitor.make
cmt_dependencies_in_GaudiMonitor = $(bin)dependencies_GaudiMonitor.in
#cmt_final_setup_GaudiMonitor = $(bin)GaudiMonitor_GaudiMonitorsetup.make
cmt_local_GaudiMonitor_makefile = $(bin)GaudiMonitor.make

else

cmt_final_setup_GaudiMonitor = $(bin)setup.make
cmt_dependencies_in_GaudiMonitor = $(bin)dependencies.in
#cmt_final_setup_GaudiMonitor = $(bin)GaudiMonitorsetup.make
cmt_local_GaudiMonitor_makefile = $(bin)GaudiMonitor.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make

#GaudiMonitor :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMonitor'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMonitor/
#GaudiMonitor::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiMonitorlibname   = $(bin)$(library_prefix)GaudiMonitor$(library_suffix)
GaudiMonitorlib       = $(GaudiMonitorlibname).a
GaudiMonitorstamp     = $(bin)GaudiMonitor.stamp
GaudiMonitorshstamp   = $(bin)GaudiMonitor.shstamp

GaudiMonitor :: dirs  GaudiMonitorLIB
	$(echo) "GaudiMonitor ok"

cmt_GaudiMonitor_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMonitor_has_prototypes

GaudiMonitorprototype :  ;

endif

GaudiMonitorcompile : $(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiMonitorLIB :: $(GaudiMonitorlib) $(GaudiMonitorshstamp)
GaudiMonitorLIB :: $(GaudiMonitorshstamp)
	$(echo) "GaudiMonitor : library ok"

$(GaudiMonitorlib) :: $(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiMonitorlib) $?
	$(lib_silent) $(ranlib) $(GaudiMonitorlib)
	$(lib_silent) cat /dev/null >$(GaudiMonitorstamp)

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

$(GaudiMonitorlibname).$(shlibsuffix) :: $(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o $(use_requirements) $(GaudiMonitorstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o $(GaudiMonitor_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiMonitorstamp) && \
	  cat /dev/null >$(GaudiMonitorshstamp)

$(GaudiMonitorshstamp) :: $(GaudiMonitorlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiMonitorlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiMonitorstamp) && \
	  cat /dev/null >$(GaudiMonitorshstamp) ; fi

GaudiMonitorclean ::
	$(cleanup_echo) objects GaudiMonitor
	$(cleanup_silent) /bin/rm -f $(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o) $(patsubst %.o,%.dep,$(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o) $(patsubst %.o,%.d.stamp,$(bin)HistorySvc.o $(bin)IssueLogger.o $(bin)ExceptionSvc.o $(bin)StreamLogger.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiMonitor_deps GaudiMonitor_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiMonitorinstallname = $(library_prefix)GaudiMonitor$(library_suffix).$(shlibsuffix)

GaudiMonitor :: GaudiMonitorinstall ;

install :: GaudiMonitorinstall ;

GaudiMonitorinstall :: $(install_dir)/$(GaudiMonitorinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiMonitorinstallname) :: $(bin)$(GaudiMonitorinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMonitorinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiMonitorclean :: GaudiMonitoruninstall

uninstall :: GaudiMonitoruninstall ;

GaudiMonitoruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMonitorinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistorySvc.d

$(bin)$(binobj)HistorySvc.d :

$(bin)$(binobj)HistorySvc.o : $(cmt_final_setup_GaudiMonitor)

$(bin)$(binobj)HistorySvc.o : $(src)HistorySvc.cpp
	$(cpp_echo) $(src)HistorySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(HistorySvc_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(HistorySvc_cppflags) $(HistorySvc_cpp_cppflags)  $(src)HistorySvc.cpp
endif
endif

else
$(bin)GaudiMonitor_dependencies.make : $(HistorySvc_cpp_dependencies)

$(bin)GaudiMonitor_dependencies.make : $(src)HistorySvc.cpp

$(bin)$(binobj)HistorySvc.o : $(HistorySvc_cpp_dependencies)
	$(cpp_echo) $(src)HistorySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(HistorySvc_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(HistorySvc_cppflags) $(HistorySvc_cpp_cppflags)  $(src)HistorySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IssueLogger.d

$(bin)$(binobj)IssueLogger.d :

$(bin)$(binobj)IssueLogger.o : $(cmt_final_setup_GaudiMonitor)

$(bin)$(binobj)IssueLogger.o : $(src)IssueLogger.cpp
	$(cpp_echo) $(src)IssueLogger.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(IssueLogger_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(IssueLogger_cppflags) $(IssueLogger_cpp_cppflags)  $(src)IssueLogger.cpp
endif
endif

else
$(bin)GaudiMonitor_dependencies.make : $(IssueLogger_cpp_dependencies)

$(bin)GaudiMonitor_dependencies.make : $(src)IssueLogger.cpp

$(bin)$(binobj)IssueLogger.o : $(IssueLogger_cpp_dependencies)
	$(cpp_echo) $(src)IssueLogger.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(IssueLogger_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(IssueLogger_cppflags) $(IssueLogger_cpp_cppflags)  $(src)IssueLogger.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExceptionSvc.d

$(bin)$(binobj)ExceptionSvc.d :

$(bin)$(binobj)ExceptionSvc.o : $(cmt_final_setup_GaudiMonitor)

$(bin)$(binobj)ExceptionSvc.o : $(src)ExceptionSvc.cpp
	$(cpp_echo) $(src)ExceptionSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(ExceptionSvc_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(ExceptionSvc_cppflags) $(ExceptionSvc_cpp_cppflags)  $(src)ExceptionSvc.cpp
endif
endif

else
$(bin)GaudiMonitor_dependencies.make : $(ExceptionSvc_cpp_dependencies)

$(bin)GaudiMonitor_dependencies.make : $(src)ExceptionSvc.cpp

$(bin)$(binobj)ExceptionSvc.o : $(ExceptionSvc_cpp_dependencies)
	$(cpp_echo) $(src)ExceptionSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(ExceptionSvc_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(ExceptionSvc_cppflags) $(ExceptionSvc_cpp_cppflags)  $(src)ExceptionSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMonitorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StreamLogger.d

$(bin)$(binobj)StreamLogger.d :

$(bin)$(binobj)StreamLogger.o : $(cmt_final_setup_GaudiMonitor)

$(bin)$(binobj)StreamLogger.o : $(src)StreamLogger.cpp
	$(cpp_echo) $(src)StreamLogger.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(StreamLogger_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(StreamLogger_cppflags) $(StreamLogger_cpp_cppflags)  $(src)StreamLogger.cpp
endif
endif

else
$(bin)GaudiMonitor_dependencies.make : $(StreamLogger_cpp_dependencies)

$(bin)GaudiMonitor_dependencies.make : $(src)StreamLogger.cpp

$(bin)$(binobj)StreamLogger.o : $(StreamLogger_cpp_dependencies)
	$(cpp_echo) $(src)StreamLogger.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMonitor_pp_cppflags) $(lib_GaudiMonitor_pp_cppflags) $(StreamLogger_pp_cppflags) $(use_cppflags) $(GaudiMonitor_cppflags) $(lib_GaudiMonitor_cppflags) $(StreamLogger_cppflags) $(StreamLogger_cpp_cppflags)  $(src)StreamLogger.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiMonitorclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMonitor.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMonitorclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiMonitor
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiMonitor$(library_suffix).a $(library_prefix)GaudiMonitor$(library_suffix).$(shlibsuffix) GaudiMonitor.stamp GaudiMonitor.shstamp
#-- end of cleanup_library ---------------
