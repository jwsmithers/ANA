#-- start of make_header -----------------

#====================================
#  Library lcg_EnvironmentAuthenticationService
#
#   Generated Tue Mar 31 10:24:14 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_EnvironmentAuthenticationService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_EnvironmentAuthenticationService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_EnvironmentAuthenticationService

EnvironmentAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_EnvironmentAuthenticationService = $(EnvironmentAuthenticationService_tag)_lcg_EnvironmentAuthenticationService.make
cmt_local_tagfile_lcg_EnvironmentAuthenticationService = $(bin)$(EnvironmentAuthenticationService_tag)_lcg_EnvironmentAuthenticationService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

EnvironmentAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_EnvironmentAuthenticationService = $(EnvironmentAuthenticationService_tag).make
cmt_local_tagfile_lcg_EnvironmentAuthenticationService = $(bin)$(EnvironmentAuthenticationService_tag).make

endif

include $(cmt_local_tagfile_lcg_EnvironmentAuthenticationService)
#-include $(cmt_local_tagfile_lcg_EnvironmentAuthenticationService)

ifdef cmt_lcg_EnvironmentAuthenticationService_has_target_tag

cmt_final_setup_lcg_EnvironmentAuthenticationService = $(bin)setup_lcg_EnvironmentAuthenticationService.make
cmt_dependencies_in_lcg_EnvironmentAuthenticationService = $(bin)dependencies_lcg_EnvironmentAuthenticationService.in
#cmt_final_setup_lcg_EnvironmentAuthenticationService = $(bin)EnvironmentAuthenticationService_lcg_EnvironmentAuthenticationServicesetup.make
cmt_local_lcg_EnvironmentAuthenticationService_makefile = $(bin)lcg_EnvironmentAuthenticationService.make

else

cmt_final_setup_lcg_EnvironmentAuthenticationService = $(bin)setup.make
cmt_dependencies_in_lcg_EnvironmentAuthenticationService = $(bin)dependencies.in
#cmt_final_setup_lcg_EnvironmentAuthenticationService = $(bin)EnvironmentAuthenticationServicesetup.make
cmt_local_lcg_EnvironmentAuthenticationService_makefile = $(bin)lcg_EnvironmentAuthenticationService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)EnvironmentAuthenticationServicesetup.make

#lcg_EnvironmentAuthenticationService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_EnvironmentAuthenticationService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_EnvironmentAuthenticationService/
#lcg_EnvironmentAuthenticationService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_EnvironmentAuthenticationServicelibname   = $(bin)$(library_prefix)lcg_EnvironmentAuthenticationService$(library_suffix)
lcg_EnvironmentAuthenticationServicelib       = $(lcg_EnvironmentAuthenticationServicelibname).a
lcg_EnvironmentAuthenticationServicestamp     = $(bin)lcg_EnvironmentAuthenticationService.stamp
lcg_EnvironmentAuthenticationServiceshstamp   = $(bin)lcg_EnvironmentAuthenticationService.shstamp

lcg_EnvironmentAuthenticationService :: dirs  lcg_EnvironmentAuthenticationServiceLIB
	$(echo) "lcg_EnvironmentAuthenticationService ok"

cmt_lcg_EnvironmentAuthenticationService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_EnvironmentAuthenticationService_has_prototypes

lcg_EnvironmentAuthenticationServiceprototype :  ;

endif

lcg_EnvironmentAuthenticationServicecompile : $(bin)EnvironmentAuthenticationService.o $(bin)modules.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_EnvironmentAuthenticationServiceLIB :: $(lcg_EnvironmentAuthenticationServicelib) $(lcg_EnvironmentAuthenticationServiceshstamp)
	@/bin/echo "------> lcg_EnvironmentAuthenticationService : library ok"

$(lcg_EnvironmentAuthenticationServicelib) :: $(bin)EnvironmentAuthenticationService.o $(bin)modules.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_EnvironmentAuthenticationServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_EnvironmentAuthenticationServicelib)
	$(lib_silent) cat /dev/null >$(lcg_EnvironmentAuthenticationServicestamp)

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

$(lcg_EnvironmentAuthenticationServicelibname).$(shlibsuffix) :: $(lcg_EnvironmentAuthenticationServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_EnvironmentAuthenticationService $(lcg_EnvironmentAuthenticationService_shlibflags)

$(lcg_EnvironmentAuthenticationServiceshstamp) :: $(lcg_EnvironmentAuthenticationServicelibname).$(shlibsuffix)
	@if test -f $(lcg_EnvironmentAuthenticationServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_EnvironmentAuthenticationServiceshstamp) ; fi

lcg_EnvironmentAuthenticationServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)EnvironmentAuthenticationService.o $(bin)modules.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_EnvironmentAuthenticationServiceinstallname = $(library_prefix)lcg_EnvironmentAuthenticationService$(library_suffix).$(shlibsuffix)

lcg_EnvironmentAuthenticationService :: lcg_EnvironmentAuthenticationServiceinstall

install :: lcg_EnvironmentAuthenticationServiceinstall

lcg_EnvironmentAuthenticationServiceinstall :: $(install_dir)/$(lcg_EnvironmentAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_EnvironmentAuthenticationServiceinstallname) :: $(bin)$(lcg_EnvironmentAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_EnvironmentAuthenticationServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_EnvironmentAuthenticationServiceclean :: lcg_EnvironmentAuthenticationServiceuninstall

uninstall :: lcg_EnvironmentAuthenticationServiceuninstall

lcg_EnvironmentAuthenticationServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_EnvironmentAuthenticationServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_EnvironmentAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_EnvironmentAuthenticationServiceprototype)

$(bin)lcg_EnvironmentAuthenticationService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_EnvironmentAuthenticationService)
	$(echo) "(lcg_EnvironmentAuthenticationService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)EnvironmentAuthenticationService.cpp $(src)modules.cpp -end_all $(includes) $(app_lcg_EnvironmentAuthenticationService_cppflags) $(lib_lcg_EnvironmentAuthenticationService_cppflags) -name=lcg_EnvironmentAuthenticationService $? -f=$(cmt_dependencies_in_lcg_EnvironmentAuthenticationService) -without_cmt

-include $(bin)lcg_EnvironmentAuthenticationService_dependencies.make

endif
endif
endif

lcg_EnvironmentAuthenticationServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_EnvironmentAuthenticationService_deps $(bin)lcg_EnvironmentAuthenticationService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_EnvironmentAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EnvironmentAuthenticationService.d

$(bin)$(binobj)EnvironmentAuthenticationService.d :

$(bin)$(binobj)EnvironmentAuthenticationService.o : $(cmt_final_setup_lcg_EnvironmentAuthenticationService)

$(bin)$(binobj)EnvironmentAuthenticationService.o : $(src)EnvironmentAuthenticationService.cpp
	$(cpp_echo) $(src)EnvironmentAuthenticationService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_EnvironmentAuthenticationService_pp_cppflags) $(lib_lcg_EnvironmentAuthenticationService_pp_cppflags) $(EnvironmentAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_EnvironmentAuthenticationService_cppflags) $(lib_lcg_EnvironmentAuthenticationService_cppflags) $(EnvironmentAuthenticationService_cppflags) $(EnvironmentAuthenticationService_cpp_cppflags)  $(src)EnvironmentAuthenticationService.cpp
endif
endif

else
$(bin)lcg_EnvironmentAuthenticationService_dependencies.make : $(EnvironmentAuthenticationService_cpp_dependencies)

$(bin)lcg_EnvironmentAuthenticationService_dependencies.make : $(src)EnvironmentAuthenticationService.cpp

$(bin)$(binobj)EnvironmentAuthenticationService.o : $(EnvironmentAuthenticationService_cpp_dependencies)
	$(cpp_echo) $(src)EnvironmentAuthenticationService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_EnvironmentAuthenticationService_pp_cppflags) $(lib_lcg_EnvironmentAuthenticationService_pp_cppflags) $(EnvironmentAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_EnvironmentAuthenticationService_cppflags) $(lib_lcg_EnvironmentAuthenticationService_cppflags) $(EnvironmentAuthenticationService_cppflags) $(EnvironmentAuthenticationService_cpp_cppflags)  $(src)EnvironmentAuthenticationService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_EnvironmentAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)modules.d

$(bin)$(binobj)modules.d :

$(bin)$(binobj)modules.o : $(cmt_final_setup_lcg_EnvironmentAuthenticationService)

$(bin)$(binobj)modules.o : $(src)modules.cpp
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_EnvironmentAuthenticationService_pp_cppflags) $(lib_lcg_EnvironmentAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_EnvironmentAuthenticationService_cppflags) $(lib_lcg_EnvironmentAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp
endif
endif

else
$(bin)lcg_EnvironmentAuthenticationService_dependencies.make : $(modules_cpp_dependencies)

$(bin)lcg_EnvironmentAuthenticationService_dependencies.make : $(src)modules.cpp

$(bin)$(binobj)modules.o : $(modules_cpp_dependencies)
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_EnvironmentAuthenticationService_pp_cppflags) $(lib_lcg_EnvironmentAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_EnvironmentAuthenticationService_cppflags) $(lib_lcg_EnvironmentAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_EnvironmentAuthenticationServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_EnvironmentAuthenticationService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_EnvironmentAuthenticationServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_EnvironmentAuthenticationService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_EnvironmentAuthenticationService$(library_suffix).a $(library_prefix)lcg_EnvironmentAuthenticationService$(library_suffix).$(shlibsuffix) lcg_EnvironmentAuthenticationService.stamp lcg_EnvironmentAuthenticationService.shstamp
#-- end of cleanup_library ---------------
