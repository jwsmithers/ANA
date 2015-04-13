#-- start of make_header -----------------

#====================================
#  Library lcg_XMLAuthenticationService
#
#   Generated Tue Mar 31 10:25:22 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_XMLAuthenticationService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_XMLAuthenticationService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_XMLAuthenticationService

XMLAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_XMLAuthenticationService = $(XMLAuthenticationService_tag)_lcg_XMLAuthenticationService.make
cmt_local_tagfile_lcg_XMLAuthenticationService = $(bin)$(XMLAuthenticationService_tag)_lcg_XMLAuthenticationService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

XMLAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_XMLAuthenticationService = $(XMLAuthenticationService_tag).make
cmt_local_tagfile_lcg_XMLAuthenticationService = $(bin)$(XMLAuthenticationService_tag).make

endif

include $(cmt_local_tagfile_lcg_XMLAuthenticationService)
#-include $(cmt_local_tagfile_lcg_XMLAuthenticationService)

ifdef cmt_lcg_XMLAuthenticationService_has_target_tag

cmt_final_setup_lcg_XMLAuthenticationService = $(bin)setup_lcg_XMLAuthenticationService.make
cmt_dependencies_in_lcg_XMLAuthenticationService = $(bin)dependencies_lcg_XMLAuthenticationService.in
#cmt_final_setup_lcg_XMLAuthenticationService = $(bin)XMLAuthenticationService_lcg_XMLAuthenticationServicesetup.make
cmt_local_lcg_XMLAuthenticationService_makefile = $(bin)lcg_XMLAuthenticationService.make

else

cmt_final_setup_lcg_XMLAuthenticationService = $(bin)setup.make
cmt_dependencies_in_lcg_XMLAuthenticationService = $(bin)dependencies.in
#cmt_final_setup_lcg_XMLAuthenticationService = $(bin)XMLAuthenticationServicesetup.make
cmt_local_lcg_XMLAuthenticationService_makefile = $(bin)lcg_XMLAuthenticationService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)XMLAuthenticationServicesetup.make

#lcg_XMLAuthenticationService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_XMLAuthenticationService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_XMLAuthenticationService/
#lcg_XMLAuthenticationService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_XMLAuthenticationServicelibname   = $(bin)$(library_prefix)lcg_XMLAuthenticationService$(library_suffix)
lcg_XMLAuthenticationServicelib       = $(lcg_XMLAuthenticationServicelibname).a
lcg_XMLAuthenticationServicestamp     = $(bin)lcg_XMLAuthenticationService.stamp
lcg_XMLAuthenticationServiceshstamp   = $(bin)lcg_XMLAuthenticationService.shstamp

lcg_XMLAuthenticationService :: dirs  lcg_XMLAuthenticationServiceLIB
	$(echo) "lcg_XMLAuthenticationService ok"

cmt_lcg_XMLAuthenticationService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_XMLAuthenticationService_has_prototypes

lcg_XMLAuthenticationServiceprototype :  ;

endif

lcg_XMLAuthenticationServicecompile : $(bin)DataSourceEntry.o $(bin)modules.o $(bin)XMLAuthenticationService.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_XMLAuthenticationServiceLIB :: $(lcg_XMLAuthenticationServicelib) $(lcg_XMLAuthenticationServiceshstamp)
	@/bin/echo "------> lcg_XMLAuthenticationService : library ok"

$(lcg_XMLAuthenticationServicelib) :: $(bin)DataSourceEntry.o $(bin)modules.o $(bin)XMLAuthenticationService.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_XMLAuthenticationServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_XMLAuthenticationServicelib)
	$(lib_silent) cat /dev/null >$(lcg_XMLAuthenticationServicestamp)

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

$(lcg_XMLAuthenticationServicelibname).$(shlibsuffix) :: $(lcg_XMLAuthenticationServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_XMLAuthenticationService $(lcg_XMLAuthenticationService_shlibflags)

$(lcg_XMLAuthenticationServiceshstamp) :: $(lcg_XMLAuthenticationServicelibname).$(shlibsuffix)
	@if test -f $(lcg_XMLAuthenticationServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_XMLAuthenticationServiceshstamp) ; fi

lcg_XMLAuthenticationServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)DataSourceEntry.o $(bin)modules.o $(bin)XMLAuthenticationService.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_XMLAuthenticationServiceinstallname = $(library_prefix)lcg_XMLAuthenticationService$(library_suffix).$(shlibsuffix)

lcg_XMLAuthenticationService :: lcg_XMLAuthenticationServiceinstall

install :: lcg_XMLAuthenticationServiceinstall

lcg_XMLAuthenticationServiceinstall :: $(install_dir)/$(lcg_XMLAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_XMLAuthenticationServiceinstallname) :: $(bin)$(lcg_XMLAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_XMLAuthenticationServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_XMLAuthenticationServiceclean :: lcg_XMLAuthenticationServiceuninstall

uninstall :: lcg_XMLAuthenticationServiceuninstall

lcg_XMLAuthenticationServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_XMLAuthenticationServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_XMLAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_XMLAuthenticationServiceprototype)

$(bin)lcg_XMLAuthenticationService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_XMLAuthenticationService)
	$(echo) "(lcg_XMLAuthenticationService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)DataSourceEntry.cpp $(src)modules.cpp $(src)XMLAuthenticationService.cpp -end_all $(includes) $(app_lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) -name=lcg_XMLAuthenticationService $? -f=$(cmt_dependencies_in_lcg_XMLAuthenticationService) -without_cmt

-include $(bin)lcg_XMLAuthenticationService_dependencies.make

endif
endif
endif

lcg_XMLAuthenticationServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_XMLAuthenticationService_deps $(bin)lcg_XMLAuthenticationService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_XMLAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataSourceEntry.d

$(bin)$(binobj)DataSourceEntry.d :

$(bin)$(binobj)DataSourceEntry.o : $(cmt_final_setup_lcg_XMLAuthenticationService)

$(bin)$(binobj)DataSourceEntry.o : $(src)DataSourceEntry.cpp
	$(cpp_echo) $(src)DataSourceEntry.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(DataSourceEntry_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(DataSourceEntry_cppflags) $(DataSourceEntry_cpp_cppflags)  $(src)DataSourceEntry.cpp
endif
endif

else
$(bin)lcg_XMLAuthenticationService_dependencies.make : $(DataSourceEntry_cpp_dependencies)

$(bin)lcg_XMLAuthenticationService_dependencies.make : $(src)DataSourceEntry.cpp

$(bin)$(binobj)DataSourceEntry.o : $(DataSourceEntry_cpp_dependencies)
	$(cpp_echo) $(src)DataSourceEntry.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(DataSourceEntry_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(DataSourceEntry_cppflags) $(DataSourceEntry_cpp_cppflags)  $(src)DataSourceEntry.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_XMLAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)modules.d

$(bin)$(binobj)modules.d :

$(bin)$(binobj)modules.o : $(cmt_final_setup_lcg_XMLAuthenticationService)

$(bin)$(binobj)modules.o : $(src)modules.cpp
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp
endif
endif

else
$(bin)lcg_XMLAuthenticationService_dependencies.make : $(modules_cpp_dependencies)

$(bin)lcg_XMLAuthenticationService_dependencies.make : $(src)modules.cpp

$(bin)$(binobj)modules.o : $(modules_cpp_dependencies)
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_XMLAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLAuthenticationService.d

$(bin)$(binobj)XMLAuthenticationService.d :

$(bin)$(binobj)XMLAuthenticationService.o : $(cmt_final_setup_lcg_XMLAuthenticationService)

$(bin)$(binobj)XMLAuthenticationService.o : $(src)XMLAuthenticationService.cpp
	$(cpp_echo) $(src)XMLAuthenticationService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(XMLAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(XMLAuthenticationService_cppflags) $(XMLAuthenticationService_cpp_cppflags)  $(src)XMLAuthenticationService.cpp
endif
endif

else
$(bin)lcg_XMLAuthenticationService_dependencies.make : $(XMLAuthenticationService_cpp_dependencies)

$(bin)lcg_XMLAuthenticationService_dependencies.make : $(src)XMLAuthenticationService.cpp

$(bin)$(binobj)XMLAuthenticationService.o : $(XMLAuthenticationService_cpp_dependencies)
	$(cpp_echo) $(src)XMLAuthenticationService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_XMLAuthenticationService_pp_cppflags) $(lib_lcg_XMLAuthenticationService_pp_cppflags) $(XMLAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_XMLAuthenticationService_cppflags) $(lib_lcg_XMLAuthenticationService_cppflags) $(XMLAuthenticationService_cppflags) $(XMLAuthenticationService_cpp_cppflags)  $(src)XMLAuthenticationService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_XMLAuthenticationServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_XMLAuthenticationService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_XMLAuthenticationServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_XMLAuthenticationService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_XMLAuthenticationService$(library_suffix).a $(library_prefix)lcg_XMLAuthenticationService$(library_suffix).$(shlibsuffix) lcg_XMLAuthenticationService.stamp lcg_XMLAuthenticationService.shstamp
#-- end of cleanup_library ---------------
