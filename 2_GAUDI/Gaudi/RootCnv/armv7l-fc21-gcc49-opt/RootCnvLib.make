#-- start of make_header -----------------

#====================================
#  Library RootCnvLib
#
#   Generated Mon Feb 16 20:00:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvLib

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvLib = $(RootCnv_tag)_RootCnvLib.make
cmt_local_tagfile_RootCnvLib = $(bin)$(RootCnv_tag)_RootCnvLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvLib = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvLib = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvLib)
#-include $(cmt_local_tagfile_RootCnvLib)

ifdef cmt_RootCnvLib_has_target_tag

cmt_final_setup_RootCnvLib = $(bin)setup_RootCnvLib.make
cmt_dependencies_in_RootCnvLib = $(bin)dependencies_RootCnvLib.in
#cmt_final_setup_RootCnvLib = $(bin)RootCnv_RootCnvLibsetup.make
cmt_local_RootCnvLib_makefile = $(bin)RootCnvLib.make

else

cmt_final_setup_RootCnvLib = $(bin)setup.make
cmt_dependencies_in_RootCnvLib = $(bin)dependencies.in
#cmt_final_setup_RootCnvLib = $(bin)RootCnvsetup.make
cmt_local_RootCnvLib_makefile = $(bin)RootCnvLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvLib/
#RootCnvLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootCnvLiblibname   = $(bin)$(library_prefix)RootCnvLib$(library_suffix)
RootCnvLiblib       = $(RootCnvLiblibname).a
RootCnvLibstamp     = $(bin)RootCnvLib.stamp
RootCnvLibshstamp   = $(bin)RootCnvLib.shstamp

RootCnvLib :: dirs  RootCnvLibLIB
	$(echo) "RootCnvLib ok"

cmt_RootCnvLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnvLib_has_prototypes

RootCnvLibprototype :  ;

endif

RootCnvLibcompile : $(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#RootCnvLibLIB :: $(RootCnvLiblib) $(RootCnvLibshstamp)
RootCnvLibLIB :: $(RootCnvLibshstamp)
	$(echo) "RootCnvLib : library ok"

$(RootCnvLiblib) :: $(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(RootCnvLiblib) $?
	$(lib_silent) $(ranlib) $(RootCnvLiblib)
	$(lib_silent) cat /dev/null >$(RootCnvLibstamp)

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

$(RootCnvLiblibname).$(shlibsuffix) :: $(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o $(use_requirements) $(RootCnvLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o $(RootCnvLib_shlibflags)
	$(lib_silent) cat /dev/null >$(RootCnvLibstamp) && \
	  cat /dev/null >$(RootCnvLibshstamp)

$(RootCnvLibshstamp) :: $(RootCnvLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootCnvLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(RootCnvLibstamp) && \
	  cat /dev/null >$(RootCnvLibshstamp) ; fi

RootCnvLibclean ::
	$(cleanup_echo) objects RootCnvLib
	$(cleanup_silent) /bin/rm -f $(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o) $(patsubst %.o,%.dep,$(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o) $(patsubst %.o,%.d.stamp,$(bin)RootIOHandler.o $(bin)RootDirectoryCnv.o $(bin)RootDataConnection.o $(bin)RootStatCnv.o $(bin)RootDatabaseCnv.o $(bin)RootEvtSelector.o $(bin)RootNTupleCnv.o $(bin)RootPerfMonSvc.o $(bin)RootCnvSvc.o $(bin)SysProcStat.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootCnvLib_deps RootCnvLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootCnvLibinstallname = $(library_prefix)RootCnvLib$(library_suffix).$(shlibsuffix)

RootCnvLib :: RootCnvLibinstall ;

install :: RootCnvLibinstall ;

RootCnvLibinstall :: $(install_dir)/$(RootCnvLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootCnvLibinstallname) :: $(bin)$(RootCnvLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootCnvLibclean :: RootCnvLibuninstall

uninstall :: RootCnvLibuninstall ;

RootCnvLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootIOHandler.d

$(bin)$(binobj)RootIOHandler.d :

$(bin)$(binobj)RootIOHandler.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootIOHandler.o : $(src)RootIOHandler.cpp
	$(cpp_echo) $(src)RootIOHandler.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootIOHandler_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootIOHandler_cppflags) $(RootIOHandler_cpp_cppflags)  $(src)RootIOHandler.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootIOHandler_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootIOHandler.cpp

$(bin)$(binobj)RootIOHandler.o : $(RootIOHandler_cpp_dependencies)
	$(cpp_echo) $(src)RootIOHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootIOHandler_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootIOHandler_cppflags) $(RootIOHandler_cpp_cppflags)  $(src)RootIOHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootDirectoryCnv.d

$(bin)$(binobj)RootDirectoryCnv.d :

$(bin)$(binobj)RootDirectoryCnv.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootDirectoryCnv.o : $(src)RootDirectoryCnv.cpp
	$(cpp_echo) $(src)RootDirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDirectoryCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDirectoryCnv_cppflags) $(RootDirectoryCnv_cpp_cppflags)  $(src)RootDirectoryCnv.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootDirectoryCnv_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootDirectoryCnv.cpp

$(bin)$(binobj)RootDirectoryCnv.o : $(RootDirectoryCnv_cpp_dependencies)
	$(cpp_echo) $(src)RootDirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDirectoryCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDirectoryCnv_cppflags) $(RootDirectoryCnv_cpp_cppflags)  $(src)RootDirectoryCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootDataConnection.d

$(bin)$(binobj)RootDataConnection.d :

$(bin)$(binobj)RootDataConnection.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootDataConnection.o : $(src)RootDataConnection.cpp
	$(cpp_echo) $(src)RootDataConnection.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDataConnection_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDataConnection_cppflags) $(RootDataConnection_cpp_cppflags)  $(src)RootDataConnection.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootDataConnection_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootDataConnection.cpp

$(bin)$(binobj)RootDataConnection.o : $(RootDataConnection_cpp_dependencies)
	$(cpp_echo) $(src)RootDataConnection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDataConnection_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDataConnection_cppflags) $(RootDataConnection_cpp_cppflags)  $(src)RootDataConnection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootStatCnv.d

$(bin)$(binobj)RootStatCnv.d :

$(bin)$(binobj)RootStatCnv.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootStatCnv.o : $(src)RootStatCnv.cpp
	$(cpp_echo) $(src)RootStatCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootStatCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootStatCnv_cppflags) $(RootStatCnv_cpp_cppflags)  $(src)RootStatCnv.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootStatCnv_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootStatCnv.cpp

$(bin)$(binobj)RootStatCnv.o : $(RootStatCnv_cpp_dependencies)
	$(cpp_echo) $(src)RootStatCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootStatCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootStatCnv_cppflags) $(RootStatCnv_cpp_cppflags)  $(src)RootStatCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootDatabaseCnv.d

$(bin)$(binobj)RootDatabaseCnv.d :

$(bin)$(binobj)RootDatabaseCnv.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootDatabaseCnv.o : $(src)RootDatabaseCnv.cpp
	$(cpp_echo) $(src)RootDatabaseCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDatabaseCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDatabaseCnv_cppflags) $(RootDatabaseCnv_cpp_cppflags)  $(src)RootDatabaseCnv.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootDatabaseCnv_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootDatabaseCnv.cpp

$(bin)$(binobj)RootDatabaseCnv.o : $(RootDatabaseCnv_cpp_dependencies)
	$(cpp_echo) $(src)RootDatabaseCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootDatabaseCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootDatabaseCnv_cppflags) $(RootDatabaseCnv_cpp_cppflags)  $(src)RootDatabaseCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootEvtSelector.d

$(bin)$(binobj)RootEvtSelector.d :

$(bin)$(binobj)RootEvtSelector.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootEvtSelector.o : $(src)RootEvtSelector.cpp
	$(cpp_echo) $(src)RootEvtSelector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootEvtSelector_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootEvtSelector_cppflags) $(RootEvtSelector_cpp_cppflags)  $(src)RootEvtSelector.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootEvtSelector_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootEvtSelector.cpp

$(bin)$(binobj)RootEvtSelector.o : $(RootEvtSelector_cpp_dependencies)
	$(cpp_echo) $(src)RootEvtSelector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootEvtSelector_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootEvtSelector_cppflags) $(RootEvtSelector_cpp_cppflags)  $(src)RootEvtSelector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootNTupleCnv.d

$(bin)$(binobj)RootNTupleCnv.d :

$(bin)$(binobj)RootNTupleCnv.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootNTupleCnv.o : $(src)RootNTupleCnv.cpp
	$(cpp_echo) $(src)RootNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootNTupleCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootNTupleCnv_cppflags) $(RootNTupleCnv_cpp_cppflags)  $(src)RootNTupleCnv.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootNTupleCnv_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootNTupleCnv.cpp

$(bin)$(binobj)RootNTupleCnv.o : $(RootNTupleCnv_cpp_dependencies)
	$(cpp_echo) $(src)RootNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootNTupleCnv_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootNTupleCnv_cppflags) $(RootNTupleCnv_cpp_cppflags)  $(src)RootNTupleCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootPerfMonSvc.d

$(bin)$(binobj)RootPerfMonSvc.d :

$(bin)$(binobj)RootPerfMonSvc.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootPerfMonSvc.o : $(src)RootPerfMonSvc.cpp
	$(cpp_echo) $(src)RootPerfMonSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootPerfMonSvc_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootPerfMonSvc_cppflags) $(RootPerfMonSvc_cpp_cppflags)  $(src)RootPerfMonSvc.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootPerfMonSvc_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootPerfMonSvc.cpp

$(bin)$(binobj)RootPerfMonSvc.o : $(RootPerfMonSvc_cpp_dependencies)
	$(cpp_echo) $(src)RootPerfMonSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootPerfMonSvc_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootPerfMonSvc_cppflags) $(RootPerfMonSvc_cpp_cppflags)  $(src)RootPerfMonSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootCnvSvc.d

$(bin)$(binobj)RootCnvSvc.d :

$(bin)$(binobj)RootCnvSvc.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)RootCnvSvc.o : $(src)RootCnvSvc.cpp
	$(cpp_echo) $(src)RootCnvSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootCnvSvc_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootCnvSvc_cppflags) $(RootCnvSvc_cpp_cppflags)  $(src)RootCnvSvc.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(RootCnvSvc_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)RootCnvSvc.cpp

$(bin)$(binobj)RootCnvSvc.o : $(RootCnvSvc_cpp_dependencies)
	$(cpp_echo) $(src)RootCnvSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(RootCnvSvc_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(RootCnvSvc_cppflags) $(RootCnvSvc_cpp_cppflags)  $(src)RootCnvSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SysProcStat.d

$(bin)$(binobj)SysProcStat.d :

$(bin)$(binobj)SysProcStat.o : $(cmt_final_setup_RootCnvLib)

$(bin)$(binobj)SysProcStat.o : $(src)SysProcStat.cpp
	$(cpp_echo) $(src)SysProcStat.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(SysProcStat_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(SysProcStat_cppflags) $(SysProcStat_cpp_cppflags)  $(src)SysProcStat.cpp
endif
endif

else
$(bin)RootCnvLib_dependencies.make : $(SysProcStat_cpp_dependencies)

$(bin)RootCnvLib_dependencies.make : $(src)SysProcStat.cpp

$(bin)$(binobj)SysProcStat.o : $(SysProcStat_cpp_dependencies)
	$(cpp_echo) $(src)SysProcStat.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvLib_pp_cppflags) $(lib_RootCnvLib_pp_cppflags) $(SysProcStat_pp_cppflags) $(use_cppflags) $(RootCnvLib_cppflags) $(lib_RootCnvLib_cppflags) $(SysProcStat_cppflags) $(SysProcStat_cpp_cppflags)  $(src)SysProcStat.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootCnvLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootCnvLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootCnvLib$(library_suffix).a $(library_prefix)RootCnvLib$(library_suffix).$(shlibsuffix) RootCnvLib.stamp RootCnvLib.shstamp
#-- end of cleanup_library ---------------
