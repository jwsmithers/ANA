#-- start of make_header -----------------

#====================================
#  Library lcg_MonitoringService
#
#   Generated Tue Mar 31 10:25:24 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_MonitoringService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_MonitoringService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_MonitoringService

MonitoringService_tag = $(tag)

#cmt_local_tagfile_lcg_MonitoringService = $(MonitoringService_tag)_lcg_MonitoringService.make
cmt_local_tagfile_lcg_MonitoringService = $(bin)$(MonitoringService_tag)_lcg_MonitoringService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

MonitoringService_tag = $(tag)

#cmt_local_tagfile_lcg_MonitoringService = $(MonitoringService_tag).make
cmt_local_tagfile_lcg_MonitoringService = $(bin)$(MonitoringService_tag).make

endif

include $(cmt_local_tagfile_lcg_MonitoringService)
#-include $(cmt_local_tagfile_lcg_MonitoringService)

ifdef cmt_lcg_MonitoringService_has_target_tag

cmt_final_setup_lcg_MonitoringService = $(bin)setup_lcg_MonitoringService.make
cmt_dependencies_in_lcg_MonitoringService = $(bin)dependencies_lcg_MonitoringService.in
#cmt_final_setup_lcg_MonitoringService = $(bin)MonitoringService_lcg_MonitoringServicesetup.make
cmt_local_lcg_MonitoringService_makefile = $(bin)lcg_MonitoringService.make

else

cmt_final_setup_lcg_MonitoringService = $(bin)setup.make
cmt_dependencies_in_lcg_MonitoringService = $(bin)dependencies.in
#cmt_final_setup_lcg_MonitoringService = $(bin)MonitoringServicesetup.make
cmt_local_lcg_MonitoringService_makefile = $(bin)lcg_MonitoringService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)MonitoringServicesetup.make

#lcg_MonitoringService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_MonitoringService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_MonitoringService/
#lcg_MonitoringService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_MonitoringServicelibname   = $(bin)$(library_prefix)lcg_MonitoringService$(library_suffix)
lcg_MonitoringServicelib       = $(lcg_MonitoringServicelibname).a
lcg_MonitoringServicestamp     = $(bin)lcg_MonitoringService.stamp
lcg_MonitoringServiceshstamp   = $(bin)lcg_MonitoringService.shstamp

lcg_MonitoringService :: dirs  lcg_MonitoringServiceLIB
	$(echo) "lcg_MonitoringService ok"

cmt_lcg_MonitoringService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_MonitoringService_has_prototypes

lcg_MonitoringServiceprototype :  ;

endif

lcg_MonitoringServicecompile : $(bin)module.o $(bin)Service.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_MonitoringServiceLIB :: $(lcg_MonitoringServicelib) $(lcg_MonitoringServiceshstamp)
	@/bin/echo "------> lcg_MonitoringService : library ok"

$(lcg_MonitoringServicelib) :: $(bin)module.o $(bin)Service.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_MonitoringServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_MonitoringServicelib)
	$(lib_silent) cat /dev/null >$(lcg_MonitoringServicestamp)

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

$(lcg_MonitoringServicelibname).$(shlibsuffix) :: $(lcg_MonitoringServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_MonitoringService $(lcg_MonitoringService_shlibflags)

$(lcg_MonitoringServiceshstamp) :: $(lcg_MonitoringServicelibname).$(shlibsuffix)
	@if test -f $(lcg_MonitoringServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_MonitoringServiceshstamp) ; fi

lcg_MonitoringServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)module.o $(bin)Service.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_MonitoringServiceinstallname = $(library_prefix)lcg_MonitoringService$(library_suffix).$(shlibsuffix)

lcg_MonitoringService :: lcg_MonitoringServiceinstall

install :: lcg_MonitoringServiceinstall

lcg_MonitoringServiceinstall :: $(install_dir)/$(lcg_MonitoringServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_MonitoringServiceinstallname) :: $(bin)$(lcg_MonitoringServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_MonitoringServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_MonitoringServiceclean :: lcg_MonitoringServiceuninstall

uninstall :: lcg_MonitoringServiceuninstall

lcg_MonitoringServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_MonitoringServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_MonitoringServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_MonitoringServiceprototype)

$(bin)lcg_MonitoringService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_MonitoringService)
	$(echo) "(lcg_MonitoringService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)module.cpp $(src)Service.cpp -end_all $(includes) $(app_lcg_MonitoringService_cppflags) $(lib_lcg_MonitoringService_cppflags) -name=lcg_MonitoringService $? -f=$(cmt_dependencies_in_lcg_MonitoringService) -without_cmt

-include $(bin)lcg_MonitoringService_dependencies.make

endif
endif
endif

lcg_MonitoringServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_MonitoringService_deps $(bin)lcg_MonitoringService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MonitoringServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_MonitoringService)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MonitoringService_pp_cppflags) $(lib_lcg_MonitoringService_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_MonitoringService_cppflags) $(lib_lcg_MonitoringService_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_MonitoringService_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_MonitoringService_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MonitoringService_pp_cppflags) $(lib_lcg_MonitoringService_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_MonitoringService_cppflags) $(lib_lcg_MonitoringService_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MonitoringServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Service.d

$(bin)$(binobj)Service.d :

$(bin)$(binobj)Service.o : $(cmt_final_setup_lcg_MonitoringService)

$(bin)$(binobj)Service.o : $(src)Service.cpp
	$(cpp_echo) $(src)Service.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MonitoringService_pp_cppflags) $(lib_lcg_MonitoringService_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(lcg_MonitoringService_cppflags) $(lib_lcg_MonitoringService_cppflags) $(Service_cppflags) $(Service_cpp_cppflags)  $(src)Service.cpp
endif
endif

else
$(bin)lcg_MonitoringService_dependencies.make : $(Service_cpp_dependencies)

$(bin)lcg_MonitoringService_dependencies.make : $(src)Service.cpp

$(bin)$(binobj)Service.o : $(Service_cpp_dependencies)
	$(cpp_echo) $(src)Service.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MonitoringService_pp_cppflags) $(lib_lcg_MonitoringService_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(lcg_MonitoringService_cppflags) $(lib_lcg_MonitoringService_cppflags) $(Service_cppflags) $(Service_cpp_cppflags)  $(src)Service.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_MonitoringServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_MonitoringService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_MonitoringServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_MonitoringService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_MonitoringService$(library_suffix).a $(library_prefix)lcg_MonitoringService$(library_suffix).$(shlibsuffix) lcg_MonitoringService.stamp lcg_MonitoringService.shstamp
#-- end of cleanup_library ---------------
