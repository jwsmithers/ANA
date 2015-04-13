#-- start of make_header -----------------

#====================================
#  Library lcg_CoralCommon
#
#   Generated Tue Mar 31 10:22:19 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralCommon_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralCommon_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralCommon

CoralCommon_tag = $(tag)

#cmt_local_tagfile_lcg_CoralCommon = $(CoralCommon_tag)_lcg_CoralCommon.make
cmt_local_tagfile_lcg_CoralCommon = $(bin)$(CoralCommon_tag)_lcg_CoralCommon.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralCommon_tag = $(tag)

#cmt_local_tagfile_lcg_CoralCommon = $(CoralCommon_tag).make
cmt_local_tagfile_lcg_CoralCommon = $(bin)$(CoralCommon_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralCommon)
#-include $(cmt_local_tagfile_lcg_CoralCommon)

ifdef cmt_lcg_CoralCommon_has_target_tag

cmt_final_setup_lcg_CoralCommon = $(bin)setup_lcg_CoralCommon.make
cmt_dependencies_in_lcg_CoralCommon = $(bin)dependencies_lcg_CoralCommon.in
#cmt_final_setup_lcg_CoralCommon = $(bin)CoralCommon_lcg_CoralCommonsetup.make
cmt_local_lcg_CoralCommon_makefile = $(bin)lcg_CoralCommon.make

else

cmt_final_setup_lcg_CoralCommon = $(bin)setup.make
cmt_dependencies_in_lcg_CoralCommon = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralCommon = $(bin)CoralCommonsetup.make
cmt_local_lcg_CoralCommon_makefile = $(bin)lcg_CoralCommon.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralCommonsetup.make

#lcg_CoralCommon :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralCommon'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralCommon/
#lcg_CoralCommon::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralCommonlibname   = $(bin)$(library_prefix)lcg_CoralCommon$(library_suffix)
lcg_CoralCommonlib       = $(lcg_CoralCommonlibname).a
lcg_CoralCommonstamp     = $(bin)lcg_CoralCommon.stamp
lcg_CoralCommonshstamp   = $(bin)lcg_CoralCommon.shstamp

lcg_CoralCommon :: dirs  lcg_CoralCommonLIB
	$(echo) "lcg_CoralCommon ok"

cmt_lcg_CoralCommon_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralCommon_has_prototypes

lcg_CoralCommonprototype :  ;

endif

lcg_CoralCommoncompile : $(bin)SimpleTimer.o $(bin)Cipher.o $(bin)StringOps.o $(bin)URIParser.o $(bin)DatabaseServiceSet.o $(bin)MonitoringEvent.o $(bin)IDevSession.o $(bin)ExpressionParser.o $(bin)SimpleExpressionParser.o $(bin)SearchPath.o $(bin)Utilities.o $(bin)CommandLine.o $(bin)IDevConnection.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralCommonLIB :: $(lcg_CoralCommonlib) $(lcg_CoralCommonshstamp)
	@/bin/echo "------> lcg_CoralCommon : library ok"

$(lcg_CoralCommonlib) :: $(bin)SimpleTimer.o $(bin)Cipher.o $(bin)StringOps.o $(bin)URIParser.o $(bin)DatabaseServiceSet.o $(bin)MonitoringEvent.o $(bin)IDevSession.o $(bin)ExpressionParser.o $(bin)SimpleExpressionParser.o $(bin)SearchPath.o $(bin)Utilities.o $(bin)CommandLine.o $(bin)IDevConnection.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralCommonlib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralCommonlib)
	$(lib_silent) cat /dev/null >$(lcg_CoralCommonstamp)

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

$(lcg_CoralCommonlibname).$(shlibsuffix) :: $(lcg_CoralCommonlib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralCommon $(lcg_CoralCommon_shlibflags)

$(lcg_CoralCommonshstamp) :: $(lcg_CoralCommonlibname).$(shlibsuffix)
	@if test -f $(lcg_CoralCommonlibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralCommonshstamp) ; fi

lcg_CoralCommonclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)SimpleTimer.o $(bin)Cipher.o $(bin)StringOps.o $(bin)URIParser.o $(bin)DatabaseServiceSet.o $(bin)MonitoringEvent.o $(bin)IDevSession.o $(bin)ExpressionParser.o $(bin)SimpleExpressionParser.o $(bin)SearchPath.o $(bin)Utilities.o $(bin)CommandLine.o $(bin)IDevConnection.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralCommoninstallname = $(library_prefix)lcg_CoralCommon$(library_suffix).$(shlibsuffix)

lcg_CoralCommon :: lcg_CoralCommoninstall

install :: lcg_CoralCommoninstall

lcg_CoralCommoninstall :: $(install_dir)/$(lcg_CoralCommoninstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralCommoninstallname) :: $(bin)$(lcg_CoralCommoninstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralCommoninstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralCommonclean :: lcg_CoralCommonuninstall

uninstall :: lcg_CoralCommonuninstall

lcg_CoralCommonuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralCommoninstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralCommonprototype)

$(bin)lcg_CoralCommon_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralCommon)
	$(echo) "(lcg_CoralCommon.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)SimpleTimer.cpp $(src)Cipher.cpp $(src)StringOps.cpp $(src)URIParser.cpp $(src)DatabaseServiceSet.cpp $(src)MonitoringEvent.cpp $(src)IDevSession.cpp $(src)ExpressionParser.cpp $(src)SimpleExpressionParser.cpp $(src)SearchPath.cpp $(src)Utilities.cpp $(src)CommandLine.cpp $(src)IDevConnection.cpp -end_all $(includes) $(app_lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) -name=lcg_CoralCommon $? -f=$(cmt_dependencies_in_lcg_CoralCommon) -without_cmt

-include $(bin)lcg_CoralCommon_dependencies.make

endif
endif
endif

lcg_CoralCommonclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralCommon_deps $(bin)lcg_CoralCommon_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimpleTimer.d

$(bin)$(binobj)SimpleTimer.d :

$(bin)$(binobj)SimpleTimer.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)SimpleTimer.o : $(src)SimpleTimer.cpp
	$(cpp_echo) $(src)SimpleTimer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SimpleTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SimpleTimer_cppflags) $(SimpleTimer_cpp_cppflags)  $(src)SimpleTimer.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(SimpleTimer_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)SimpleTimer.cpp

$(bin)$(binobj)SimpleTimer.o : $(SimpleTimer_cpp_dependencies)
	$(cpp_echo) $(src)SimpleTimer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SimpleTimer_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SimpleTimer_cppflags) $(SimpleTimer_cpp_cppflags)  $(src)SimpleTimer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cipher.d

$(bin)$(binobj)Cipher.d :

$(bin)$(binobj)Cipher.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)Cipher.o : $(src)Cipher.cpp
	$(cpp_echo) $(src)Cipher.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(Cipher_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(Cipher_cppflags) $(Cipher_cpp_cppflags)  $(src)Cipher.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(Cipher_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)Cipher.cpp

$(bin)$(binobj)Cipher.o : $(Cipher_cpp_dependencies)
	$(cpp_echo) $(src)Cipher.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(Cipher_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(Cipher_cppflags) $(Cipher_cpp_cppflags)  $(src)Cipher.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StringOps.d

$(bin)$(binobj)StringOps.d :

$(bin)$(binobj)StringOps.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)StringOps.o : $(src)StringOps.cpp
	$(cpp_echo) $(src)StringOps.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(StringOps_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(StringOps_cppflags) $(StringOps_cpp_cppflags)  $(src)StringOps.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(StringOps_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)StringOps.cpp

$(bin)$(binobj)StringOps.o : $(StringOps_cpp_dependencies)
	$(cpp_echo) $(src)StringOps.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(StringOps_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(StringOps_cppflags) $(StringOps_cpp_cppflags)  $(src)StringOps.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)URIParser.d

$(bin)$(binobj)URIParser.d :

$(bin)$(binobj)URIParser.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)URIParser.o : $(src)URIParser.cpp
	$(cpp_echo) $(src)URIParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(URIParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(URIParser_cppflags) $(URIParser_cpp_cppflags)  $(src)URIParser.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(URIParser_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)URIParser.cpp

$(bin)$(binobj)URIParser.o : $(URIParser_cpp_dependencies)
	$(cpp_echo) $(src)URIParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(URIParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(URIParser_cppflags) $(URIParser_cpp_cppflags)  $(src)URIParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DatabaseServiceSet.d

$(bin)$(binobj)DatabaseServiceSet.d :

$(bin)$(binobj)DatabaseServiceSet.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)DatabaseServiceSet.o : $(src)DatabaseServiceSet.cpp
	$(cpp_echo) $(src)DatabaseServiceSet.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(DatabaseServiceSet_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(DatabaseServiceSet_cppflags) $(DatabaseServiceSet_cpp_cppflags)  $(src)DatabaseServiceSet.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(DatabaseServiceSet_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)DatabaseServiceSet.cpp

$(bin)$(binobj)DatabaseServiceSet.o : $(DatabaseServiceSet_cpp_dependencies)
	$(cpp_echo) $(src)DatabaseServiceSet.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(DatabaseServiceSet_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(DatabaseServiceSet_cppflags) $(DatabaseServiceSet_cpp_cppflags)  $(src)DatabaseServiceSet.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MonitoringEvent.d

$(bin)$(binobj)MonitoringEvent.d :

$(bin)$(binobj)MonitoringEvent.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)MonitoringEvent.o : $(src)MonitoringEvent.cpp
	$(cpp_echo) $(src)MonitoringEvent.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(MonitoringEvent_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(MonitoringEvent_cppflags) $(MonitoringEvent_cpp_cppflags)  $(src)MonitoringEvent.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(MonitoringEvent_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)MonitoringEvent.cpp

$(bin)$(binobj)MonitoringEvent.o : $(MonitoringEvent_cpp_dependencies)
	$(cpp_echo) $(src)MonitoringEvent.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(MonitoringEvent_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(MonitoringEvent_cppflags) $(MonitoringEvent_cpp_cppflags)  $(src)MonitoringEvent.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IDevSession.d

$(bin)$(binobj)IDevSession.d :

$(bin)$(binobj)IDevSession.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)IDevSession.o : $(src)IDevSession.cpp
	$(cpp_echo) $(src)IDevSession.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(IDevSession_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(IDevSession_cppflags) $(IDevSession_cpp_cppflags)  $(src)IDevSession.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(IDevSession_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)IDevSession.cpp

$(bin)$(binobj)IDevSession.o : $(IDevSession_cpp_dependencies)
	$(cpp_echo) $(src)IDevSession.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(IDevSession_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(IDevSession_cppflags) $(IDevSession_cpp_cppflags)  $(src)IDevSession.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExpressionParser.d

$(bin)$(binobj)ExpressionParser.d :

$(bin)$(binobj)ExpressionParser.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)ExpressionParser.o : $(src)ExpressionParser.cpp
	$(cpp_echo) $(src)ExpressionParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(ExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(ExpressionParser_cppflags) $(ExpressionParser_cpp_cppflags)  $(src)ExpressionParser.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(ExpressionParser_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)ExpressionParser.cpp

$(bin)$(binobj)ExpressionParser.o : $(ExpressionParser_cpp_dependencies)
	$(cpp_echo) $(src)ExpressionParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(ExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(ExpressionParser_cppflags) $(ExpressionParser_cpp_cppflags)  $(src)ExpressionParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimpleExpressionParser.d

$(bin)$(binobj)SimpleExpressionParser.d :

$(bin)$(binobj)SimpleExpressionParser.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)SimpleExpressionParser.o : $(src)SimpleExpressionParser.cpp
	$(cpp_echo) $(src)SimpleExpressionParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SimpleExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SimpleExpressionParser_cppflags) $(SimpleExpressionParser_cpp_cppflags)  $(src)SimpleExpressionParser.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(SimpleExpressionParser_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)SimpleExpressionParser.cpp

$(bin)$(binobj)SimpleExpressionParser.o : $(SimpleExpressionParser_cpp_dependencies)
	$(cpp_echo) $(src)SimpleExpressionParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SimpleExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SimpleExpressionParser_cppflags) $(SimpleExpressionParser_cpp_cppflags)  $(src)SimpleExpressionParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SearchPath.d

$(bin)$(binobj)SearchPath.d :

$(bin)$(binobj)SearchPath.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)SearchPath.o : $(src)SearchPath.cpp
	$(cpp_echo) $(src)SearchPath.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SearchPath_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SearchPath_cppflags) $(SearchPath_cpp_cppflags)  $(src)SearchPath.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(SearchPath_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)SearchPath.cpp

$(bin)$(binobj)SearchPath.o : $(SearchPath_cpp_dependencies)
	$(cpp_echo) $(src)SearchPath.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(SearchPath_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(SearchPath_cppflags) $(SearchPath_cpp_cppflags)  $(src)SearchPath.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Utilities.d

$(bin)$(binobj)Utilities.d :

$(bin)$(binobj)Utilities.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)Utilities.o : $(src)Utilities.cpp
	$(cpp_echo) $(src)Utilities.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(Utilities_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(Utilities_cppflags) $(Utilities_cpp_cppflags)  $(src)Utilities.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(Utilities_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)Utilities.cpp

$(bin)$(binobj)Utilities.o : $(Utilities_cpp_dependencies)
	$(cpp_echo) $(src)Utilities.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(Utilities_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(Utilities_cppflags) $(Utilities_cpp_cppflags)  $(src)Utilities.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CommandLine.d

$(bin)$(binobj)CommandLine.d :

$(bin)$(binobj)CommandLine.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)CommandLine.o : $(src)CommandLine.cpp
	$(cpp_echo) $(src)CommandLine.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(CommandLine_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(CommandLine_cppflags) $(CommandLine_cpp_cppflags)  $(src)CommandLine.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(CommandLine_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)CommandLine.cpp

$(bin)$(binobj)CommandLine.o : $(CommandLine_cpp_dependencies)
	$(cpp_echo) $(src)CommandLine.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(CommandLine_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(CommandLine_cppflags) $(CommandLine_cpp_cppflags)  $(src)CommandLine.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralCommonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IDevConnection.d

$(bin)$(binobj)IDevConnection.d :

$(bin)$(binobj)IDevConnection.o : $(cmt_final_setup_lcg_CoralCommon)

$(bin)$(binobj)IDevConnection.o : $(src)IDevConnection.cpp
	$(cpp_echo) $(src)IDevConnection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(IDevConnection_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(IDevConnection_cppflags) $(IDevConnection_cpp_cppflags)  $(src)IDevConnection.cpp
endif
endif

else
$(bin)lcg_CoralCommon_dependencies.make : $(IDevConnection_cpp_dependencies)

$(bin)lcg_CoralCommon_dependencies.make : $(src)IDevConnection.cpp

$(bin)$(binobj)IDevConnection.o : $(IDevConnection_cpp_dependencies)
	$(cpp_echo) $(src)IDevConnection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralCommon_pp_cppflags) $(lib_lcg_CoralCommon_pp_cppflags) $(IDevConnection_pp_cppflags) $(use_cppflags) $(lcg_CoralCommon_cppflags) $(lib_lcg_CoralCommon_cppflags) $(IDevConnection_cppflags) $(IDevConnection_cpp_cppflags)  $(src)IDevConnection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralCommonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralCommon.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralCommonclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralCommon
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralCommon$(library_suffix).a $(library_prefix)lcg_CoralCommon$(library_suffix).$(shlibsuffix) lcg_CoralCommon.stamp lcg_CoralCommon.shstamp
#-- end of cleanup_library ---------------
