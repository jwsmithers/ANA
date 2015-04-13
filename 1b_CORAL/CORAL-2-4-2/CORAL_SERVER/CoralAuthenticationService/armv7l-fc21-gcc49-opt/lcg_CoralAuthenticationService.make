#-- start of make_header -----------------

#====================================
#  Library lcg_CoralAuthenticationService
#
#   Generated Wed Jan 21 17:21:12 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralAuthenticationService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralAuthenticationService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralAuthenticationService

CoralAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_CoralAuthenticationService = $(CoralAuthenticationService_tag)_lcg_CoralAuthenticationService.make
cmt_local_tagfile_lcg_CoralAuthenticationService = $(bin)$(CoralAuthenticationService_tag)_lcg_CoralAuthenticationService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralAuthenticationService_tag = $(tag)

#cmt_local_tagfile_lcg_CoralAuthenticationService = $(CoralAuthenticationService_tag).make
cmt_local_tagfile_lcg_CoralAuthenticationService = $(bin)$(CoralAuthenticationService_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralAuthenticationService)
#-include $(cmt_local_tagfile_lcg_CoralAuthenticationService)

ifdef cmt_lcg_CoralAuthenticationService_has_target_tag

cmt_final_setup_lcg_CoralAuthenticationService = $(bin)setup_lcg_CoralAuthenticationService.make
cmt_dependencies_in_lcg_CoralAuthenticationService = $(bin)dependencies_lcg_CoralAuthenticationService.in
#cmt_final_setup_lcg_CoralAuthenticationService = $(bin)CoralAuthenticationService_lcg_CoralAuthenticationServicesetup.make
cmt_local_lcg_CoralAuthenticationService_makefile = $(bin)lcg_CoralAuthenticationService.make

else

cmt_final_setup_lcg_CoralAuthenticationService = $(bin)setup.make
cmt_dependencies_in_lcg_CoralAuthenticationService = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralAuthenticationService = $(bin)CoralAuthenticationServicesetup.make
cmt_local_lcg_CoralAuthenticationService_makefile = $(bin)lcg_CoralAuthenticationService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralAuthenticationServicesetup.make

#lcg_CoralAuthenticationService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralAuthenticationService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralAuthenticationService/
#lcg_CoralAuthenticationService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralAuthenticationServicelibname   = $(bin)$(library_prefix)lcg_CoralAuthenticationService$(library_suffix)
lcg_CoralAuthenticationServicelib       = $(lcg_CoralAuthenticationServicelibname).a
lcg_CoralAuthenticationServicestamp     = $(bin)lcg_CoralAuthenticationService.stamp
lcg_CoralAuthenticationServiceshstamp   = $(bin)lcg_CoralAuthenticationService.shstamp

lcg_CoralAuthenticationService :: dirs  lcg_CoralAuthenticationServiceLIB
	$(echo) "lcg_CoralAuthenticationService ok"

cmt_lcg_CoralAuthenticationService_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralAuthenticationService_has_prototypes

lcg_CoralAuthenticationServiceprototype :  ;

endif

lcg_CoralAuthenticationServicecompile : $(bin)CredentialsTable.o $(bin)Config.o $(bin)OpenSSLCipher.o $(bin)modules.o $(bin)LC2PCTable.o $(bin)LogConTable.o $(bin)PermissionsTable.o $(bin)XMLLookupFileParser.o $(bin)XMLAuthenticationFileParser.o $(bin)PhysConTable.o $(bin)AuthenticationCredentialSet.o $(bin)CoralAuthenticationService.o $(bin)QueryMgr.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralAuthenticationServiceLIB :: $(lcg_CoralAuthenticationServicelib) $(lcg_CoralAuthenticationServiceshstamp)
	@/bin/echo "------> lcg_CoralAuthenticationService : library ok"

$(lcg_CoralAuthenticationServicelib) :: $(bin)CredentialsTable.o $(bin)Config.o $(bin)OpenSSLCipher.o $(bin)modules.o $(bin)LC2PCTable.o $(bin)LogConTable.o $(bin)PermissionsTable.o $(bin)XMLLookupFileParser.o $(bin)XMLAuthenticationFileParser.o $(bin)PhysConTable.o $(bin)AuthenticationCredentialSet.o $(bin)CoralAuthenticationService.o $(bin)QueryMgr.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralAuthenticationServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralAuthenticationServicelib)
	$(lib_silent) cat /dev/null >$(lcg_CoralAuthenticationServicestamp)

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

$(lcg_CoralAuthenticationServicelibname).$(shlibsuffix) :: $(lcg_CoralAuthenticationServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralAuthenticationService $(lcg_CoralAuthenticationService_shlibflags)

$(lcg_CoralAuthenticationServiceshstamp) :: $(lcg_CoralAuthenticationServicelibname).$(shlibsuffix)
	@if test -f $(lcg_CoralAuthenticationServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralAuthenticationServiceshstamp) ; fi

lcg_CoralAuthenticationServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)CredentialsTable.o $(bin)Config.o $(bin)OpenSSLCipher.o $(bin)modules.o $(bin)LC2PCTable.o $(bin)LogConTable.o $(bin)PermissionsTable.o $(bin)XMLLookupFileParser.o $(bin)XMLAuthenticationFileParser.o $(bin)PhysConTable.o $(bin)AuthenticationCredentialSet.o $(bin)CoralAuthenticationService.o $(bin)QueryMgr.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralAuthenticationServiceinstallname = $(library_prefix)lcg_CoralAuthenticationService$(library_suffix).$(shlibsuffix)

lcg_CoralAuthenticationService :: lcg_CoralAuthenticationServiceinstall

install :: lcg_CoralAuthenticationServiceinstall

lcg_CoralAuthenticationServiceinstall :: $(install_dir)/$(lcg_CoralAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralAuthenticationServiceinstallname) :: $(bin)$(lcg_CoralAuthenticationServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralAuthenticationServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralAuthenticationServiceclean :: lcg_CoralAuthenticationServiceuninstall

uninstall :: lcg_CoralAuthenticationServiceuninstall

lcg_CoralAuthenticationServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralAuthenticationServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceprototype)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralAuthenticationService)
	$(echo) "(lcg_CoralAuthenticationService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CredentialsTable.cpp $(src)Config.cpp $(src)OpenSSLCipher.cpp $(src)modules.cpp $(src)LC2PCTable.cpp $(src)LogConTable.cpp $(src)PermissionsTable.cpp $(src)XMLLookupFileParser.cpp $(src)XMLAuthenticationFileParser.cpp $(src)PhysConTable.cpp $(src)AuthenticationCredentialSet.cpp $(src)CoralAuthenticationService.cpp $(src)QueryMgr.cpp -end_all $(includes) $(app_lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) -name=lcg_CoralAuthenticationService $? -f=$(cmt_dependencies_in_lcg_CoralAuthenticationService) -without_cmt

-include $(bin)lcg_CoralAuthenticationService_dependencies.make

endif
endif
endif

lcg_CoralAuthenticationServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralAuthenticationService_deps $(bin)lcg_CoralAuthenticationService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CredentialsTable.d

$(bin)$(binobj)CredentialsTable.d :

$(bin)$(binobj)CredentialsTable.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)CredentialsTable.o : $(src)CredentialsTable.cpp
	$(cpp_echo) $(src)CredentialsTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(CredentialsTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(CredentialsTable_cppflags) $(CredentialsTable_cpp_cppflags)  $(src)CredentialsTable.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(CredentialsTable_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)CredentialsTable.cpp

$(bin)$(binobj)CredentialsTable.o : $(CredentialsTable_cpp_dependencies)
	$(cpp_echo) $(src)CredentialsTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(CredentialsTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(CredentialsTable_cppflags) $(CredentialsTable_cpp_cppflags)  $(src)CredentialsTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Config.d

$(bin)$(binobj)Config.d :

$(bin)$(binobj)Config.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)Config.o : $(src)Config.cpp
	$(cpp_echo) $(src)Config.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(Config_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(Config_cppflags) $(Config_cpp_cppflags)  $(src)Config.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(Config_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)Config.cpp

$(bin)$(binobj)Config.o : $(Config_cpp_dependencies)
	$(cpp_echo) $(src)Config.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(Config_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(Config_cppflags) $(Config_cpp_cppflags)  $(src)Config.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OpenSSLCipher.d

$(bin)$(binobj)OpenSSLCipher.d :

$(bin)$(binobj)OpenSSLCipher.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)OpenSSLCipher.o : $(src)OpenSSLCipher.cpp
	$(cpp_echo) $(src)OpenSSLCipher.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(OpenSSLCipher_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(OpenSSLCipher_cppflags) $(OpenSSLCipher_cpp_cppflags)  $(src)OpenSSLCipher.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(OpenSSLCipher_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)OpenSSLCipher.cpp

$(bin)$(binobj)OpenSSLCipher.o : $(OpenSSLCipher_cpp_dependencies)
	$(cpp_echo) $(src)OpenSSLCipher.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(OpenSSLCipher_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(OpenSSLCipher_cppflags) $(OpenSSLCipher_cpp_cppflags)  $(src)OpenSSLCipher.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)modules.d

$(bin)$(binobj)modules.d :

$(bin)$(binobj)modules.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)modules.o : $(src)modules.cpp
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(modules_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)modules.cpp

$(bin)$(binobj)modules.o : $(modules_cpp_dependencies)
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LC2PCTable.d

$(bin)$(binobj)LC2PCTable.d :

$(bin)$(binobj)LC2PCTable.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)LC2PCTable.o : $(src)LC2PCTable.cpp
	$(cpp_echo) $(src)LC2PCTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(LC2PCTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(LC2PCTable_cppflags) $(LC2PCTable_cpp_cppflags)  $(src)LC2PCTable.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(LC2PCTable_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)LC2PCTable.cpp

$(bin)$(binobj)LC2PCTable.o : $(LC2PCTable_cpp_dependencies)
	$(cpp_echo) $(src)LC2PCTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(LC2PCTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(LC2PCTable_cppflags) $(LC2PCTable_cpp_cppflags)  $(src)LC2PCTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LogConTable.d

$(bin)$(binobj)LogConTable.d :

$(bin)$(binobj)LogConTable.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)LogConTable.o : $(src)LogConTable.cpp
	$(cpp_echo) $(src)LogConTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(LogConTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(LogConTable_cppflags) $(LogConTable_cpp_cppflags)  $(src)LogConTable.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(LogConTable_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)LogConTable.cpp

$(bin)$(binobj)LogConTable.o : $(LogConTable_cpp_dependencies)
	$(cpp_echo) $(src)LogConTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(LogConTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(LogConTable_cppflags) $(LogConTable_cpp_cppflags)  $(src)LogConTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PermissionsTable.d

$(bin)$(binobj)PermissionsTable.d :

$(bin)$(binobj)PermissionsTable.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)PermissionsTable.o : $(src)PermissionsTable.cpp
	$(cpp_echo) $(src)PermissionsTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(PermissionsTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(PermissionsTable_cppflags) $(PermissionsTable_cpp_cppflags)  $(src)PermissionsTable.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(PermissionsTable_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)PermissionsTable.cpp

$(bin)$(binobj)PermissionsTable.o : $(PermissionsTable_cpp_dependencies)
	$(cpp_echo) $(src)PermissionsTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(PermissionsTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(PermissionsTable_cppflags) $(PermissionsTable_cpp_cppflags)  $(src)PermissionsTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLLookupFileParser.d

$(bin)$(binobj)XMLLookupFileParser.d :

$(bin)$(binobj)XMLLookupFileParser.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)XMLLookupFileParser.o : $(src)XMLLookupFileParser.cpp
	$(cpp_echo) $(src)XMLLookupFileParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(XMLLookupFileParser_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(XMLLookupFileParser_cppflags) $(XMLLookupFileParser_cpp_cppflags)  $(src)XMLLookupFileParser.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(XMLLookupFileParser_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)XMLLookupFileParser.cpp

$(bin)$(binobj)XMLLookupFileParser.o : $(XMLLookupFileParser_cpp_dependencies)
	$(cpp_echo) $(src)XMLLookupFileParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(XMLLookupFileParser_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(XMLLookupFileParser_cppflags) $(XMLLookupFileParser_cpp_cppflags)  $(src)XMLLookupFileParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLAuthenticationFileParser.d

$(bin)$(binobj)XMLAuthenticationFileParser.d :

$(bin)$(binobj)XMLAuthenticationFileParser.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)XMLAuthenticationFileParser.o : $(src)XMLAuthenticationFileParser.cpp
	$(cpp_echo) $(src)XMLAuthenticationFileParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(XMLAuthenticationFileParser_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(XMLAuthenticationFileParser_cppflags) $(XMLAuthenticationFileParser_cpp_cppflags)  $(src)XMLAuthenticationFileParser.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(XMLAuthenticationFileParser_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)XMLAuthenticationFileParser.cpp

$(bin)$(binobj)XMLAuthenticationFileParser.o : $(XMLAuthenticationFileParser_cpp_dependencies)
	$(cpp_echo) $(src)XMLAuthenticationFileParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(XMLAuthenticationFileParser_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(XMLAuthenticationFileParser_cppflags) $(XMLAuthenticationFileParser_cpp_cppflags)  $(src)XMLAuthenticationFileParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PhysConTable.d

$(bin)$(binobj)PhysConTable.d :

$(bin)$(binobj)PhysConTable.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)PhysConTable.o : $(src)PhysConTable.cpp
	$(cpp_echo) $(src)PhysConTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(PhysConTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(PhysConTable_cppflags) $(PhysConTable_cpp_cppflags)  $(src)PhysConTable.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(PhysConTable_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)PhysConTable.cpp

$(bin)$(binobj)PhysConTable.o : $(PhysConTable_cpp_dependencies)
	$(cpp_echo) $(src)PhysConTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(PhysConTable_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(PhysConTable_cppflags) $(PhysConTable_cpp_cppflags)  $(src)PhysConTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AuthenticationCredentialSet.d

$(bin)$(binobj)AuthenticationCredentialSet.d :

$(bin)$(binobj)AuthenticationCredentialSet.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)AuthenticationCredentialSet.o : $(src)AuthenticationCredentialSet.cpp
	$(cpp_echo) $(src)AuthenticationCredentialSet.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(AuthenticationCredentialSet_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(AuthenticationCredentialSet_cppflags) $(AuthenticationCredentialSet_cpp_cppflags)  $(src)AuthenticationCredentialSet.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(AuthenticationCredentialSet_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)AuthenticationCredentialSet.cpp

$(bin)$(binobj)AuthenticationCredentialSet.o : $(AuthenticationCredentialSet_cpp_dependencies)
	$(cpp_echo) $(src)AuthenticationCredentialSet.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(AuthenticationCredentialSet_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(AuthenticationCredentialSet_cppflags) $(AuthenticationCredentialSet_cpp_cppflags)  $(src)AuthenticationCredentialSet.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralAuthenticationService.d

$(bin)$(binobj)CoralAuthenticationService.d :

$(bin)$(binobj)CoralAuthenticationService.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)CoralAuthenticationService.o : $(src)CoralAuthenticationService.cpp
	$(cpp_echo) $(src)CoralAuthenticationService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(CoralAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(CoralAuthenticationService_cppflags) $(CoralAuthenticationService_cpp_cppflags)  $(src)CoralAuthenticationService.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(CoralAuthenticationService_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)CoralAuthenticationService.cpp

$(bin)$(binobj)CoralAuthenticationService.o : $(CoralAuthenticationService_cpp_dependencies)
	$(cpp_echo) $(src)CoralAuthenticationService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(CoralAuthenticationService_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(CoralAuthenticationService_cppflags) $(CoralAuthenticationService_cpp_cppflags)  $(src)CoralAuthenticationService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAuthenticationServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryMgr.d

$(bin)$(binobj)QueryMgr.d :

$(bin)$(binobj)QueryMgr.o : $(cmt_final_setup_lcg_CoralAuthenticationService)

$(bin)$(binobj)QueryMgr.o : $(src)QueryMgr.cpp
	$(cpp_echo) $(src)QueryMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(QueryMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(QueryMgr_cppflags) $(QueryMgr_cpp_cppflags)  $(src)QueryMgr.cpp
endif
endif

else
$(bin)lcg_CoralAuthenticationService_dependencies.make : $(QueryMgr_cpp_dependencies)

$(bin)lcg_CoralAuthenticationService_dependencies.make : $(src)QueryMgr.cpp

$(bin)$(binobj)QueryMgr.o : $(QueryMgr_cpp_dependencies)
	$(cpp_echo) $(src)QueryMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAuthenticationService_pp_cppflags) $(lib_lcg_CoralAuthenticationService_pp_cppflags) $(QueryMgr_pp_cppflags) $(use_cppflags) $(lcg_CoralAuthenticationService_cppflags) $(lib_lcg_CoralAuthenticationService_cppflags) $(QueryMgr_cppflags) $(QueryMgr_cpp_cppflags)  $(src)QueryMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralAuthenticationServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralAuthenticationService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralAuthenticationServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralAuthenticationService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralAuthenticationService$(library_suffix).a $(library_prefix)lcg_CoralAuthenticationService$(library_suffix).$(shlibsuffix) lcg_CoralAuthenticationService.stamp lcg_CoralAuthenticationService.shstamp
#-- end of cleanup_library ---------------
