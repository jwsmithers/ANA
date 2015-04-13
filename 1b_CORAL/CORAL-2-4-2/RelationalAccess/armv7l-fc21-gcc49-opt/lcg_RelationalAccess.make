#-- start of make_header -----------------

#====================================
#  Library lcg_RelationalAccess
#
#   Generated Tue Mar 31 10:22:18 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_RelationalAccess_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_RelationalAccess_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_RelationalAccess

RelationalAccess_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalAccess = $(RelationalAccess_tag)_lcg_RelationalAccess.make
cmt_local_tagfile_lcg_RelationalAccess = $(bin)$(RelationalAccess_tag)_lcg_RelationalAccess.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RelationalAccess_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalAccess = $(RelationalAccess_tag).make
cmt_local_tagfile_lcg_RelationalAccess = $(bin)$(RelationalAccess_tag).make

endif

include $(cmt_local_tagfile_lcg_RelationalAccess)
#-include $(cmt_local_tagfile_lcg_RelationalAccess)

ifdef cmt_lcg_RelationalAccess_has_target_tag

cmt_final_setup_lcg_RelationalAccess = $(bin)setup_lcg_RelationalAccess.make
cmt_dependencies_in_lcg_RelationalAccess = $(bin)dependencies_lcg_RelationalAccess.in
#cmt_final_setup_lcg_RelationalAccess = $(bin)RelationalAccess_lcg_RelationalAccesssetup.make
cmt_local_lcg_RelationalAccess_makefile = $(bin)lcg_RelationalAccess.make

else

cmt_final_setup_lcg_RelationalAccess = $(bin)setup.make
cmt_dependencies_in_lcg_RelationalAccess = $(bin)dependencies.in
#cmt_final_setup_lcg_RelationalAccess = $(bin)RelationalAccesssetup.make
cmt_local_lcg_RelationalAccess_makefile = $(bin)lcg_RelationalAccess.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RelationalAccesssetup.make

#lcg_RelationalAccess :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_RelationalAccess'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_RelationalAccess/
#lcg_RelationalAccess::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_RelationalAccesslibname   = $(bin)$(library_prefix)lcg_RelationalAccess$(library_suffix)
lcg_RelationalAccesslib       = $(lcg_RelationalAccesslibname).a
lcg_RelationalAccessstamp     = $(bin)lcg_RelationalAccess.stamp
lcg_RelationalAccessshstamp   = $(bin)lcg_RelationalAccess.shstamp

lcg_RelationalAccess :: dirs  lcg_RelationalAccessLIB
	$(echo) "lcg_RelationalAccess ok"

cmt_lcg_RelationalAccess_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_RelationalAccess_has_prototypes

lcg_RelationalAccessprototype :  ;

endif

lcg_RelationalAccesscompile : $(bin)Constants.o $(bin)AuthenticationCredentials.o $(bin)ConnectionService.o $(bin)TableDescription.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_RelationalAccessLIB :: $(lcg_RelationalAccesslib) $(lcg_RelationalAccessshstamp)
	@/bin/echo "------> lcg_RelationalAccess : library ok"

$(lcg_RelationalAccesslib) :: $(bin)Constants.o $(bin)AuthenticationCredentials.o $(bin)ConnectionService.o $(bin)TableDescription.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_RelationalAccesslib) $?
	$(lib_silent) $(ranlib) $(lcg_RelationalAccesslib)
	$(lib_silent) cat /dev/null >$(lcg_RelationalAccessstamp)

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

$(lcg_RelationalAccesslibname).$(shlibsuffix) :: $(lcg_RelationalAccesslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_RelationalAccess $(lcg_RelationalAccess_shlibflags)

$(lcg_RelationalAccessshstamp) :: $(lcg_RelationalAccesslibname).$(shlibsuffix)
	@if test -f $(lcg_RelationalAccesslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_RelationalAccessshstamp) ; fi

lcg_RelationalAccessclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Constants.o $(bin)AuthenticationCredentials.o $(bin)ConnectionService.o $(bin)TableDescription.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_RelationalAccessinstallname = $(library_prefix)lcg_RelationalAccess$(library_suffix).$(shlibsuffix)

lcg_RelationalAccess :: lcg_RelationalAccessinstall

install :: lcg_RelationalAccessinstall

lcg_RelationalAccessinstall :: $(install_dir)/$(lcg_RelationalAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_RelationalAccessinstallname) :: $(bin)$(lcg_RelationalAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalAccessinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_RelationalAccessclean :: lcg_RelationalAccessuninstall

uninstall :: lcg_RelationalAccessuninstall

lcg_RelationalAccessuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalAccessinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_RelationalAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_RelationalAccessprototype)

$(bin)lcg_RelationalAccess_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_RelationalAccess)
	$(echo) "(lcg_RelationalAccess.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Constants.cpp $(src)AuthenticationCredentials.cpp $(src)ConnectionService.cpp $(src)TableDescription.cpp -end_all $(includes) $(app_lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) -name=lcg_RelationalAccess $? -f=$(cmt_dependencies_in_lcg_RelationalAccess) -without_cmt

-include $(bin)lcg_RelationalAccess_dependencies.make

endif
endif
endif

lcg_RelationalAccessclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_RelationalAccess_deps $(bin)lcg_RelationalAccess_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Constants.d

$(bin)$(binobj)Constants.d :

$(bin)$(binobj)Constants.o : $(cmt_final_setup_lcg_RelationalAccess)

$(bin)$(binobj)Constants.o : $(src)Constants.cpp
	$(cpp_echo) $(src)Constants.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(Constants_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(Constants_cppflags) $(Constants_cpp_cppflags)  $(src)Constants.cpp
endif
endif

else
$(bin)lcg_RelationalAccess_dependencies.make : $(Constants_cpp_dependencies)

$(bin)lcg_RelationalAccess_dependencies.make : $(src)Constants.cpp

$(bin)$(binobj)Constants.o : $(Constants_cpp_dependencies)
	$(cpp_echo) $(src)Constants.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(Constants_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(Constants_cppflags) $(Constants_cpp_cppflags)  $(src)Constants.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AuthenticationCredentials.d

$(bin)$(binobj)AuthenticationCredentials.d :

$(bin)$(binobj)AuthenticationCredentials.o : $(cmt_final_setup_lcg_RelationalAccess)

$(bin)$(binobj)AuthenticationCredentials.o : $(src)AuthenticationCredentials.cpp
	$(cpp_echo) $(src)AuthenticationCredentials.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(AuthenticationCredentials_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(AuthenticationCredentials_cppflags) $(AuthenticationCredentials_cpp_cppflags)  $(src)AuthenticationCredentials.cpp
endif
endif

else
$(bin)lcg_RelationalAccess_dependencies.make : $(AuthenticationCredentials_cpp_dependencies)

$(bin)lcg_RelationalAccess_dependencies.make : $(src)AuthenticationCredentials.cpp

$(bin)$(binobj)AuthenticationCredentials.o : $(AuthenticationCredentials_cpp_dependencies)
	$(cpp_echo) $(src)AuthenticationCredentials.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(AuthenticationCredentials_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(AuthenticationCredentials_cppflags) $(AuthenticationCredentials_cpp_cppflags)  $(src)AuthenticationCredentials.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionService.d

$(bin)$(binobj)ConnectionService.d :

$(bin)$(binobj)ConnectionService.o : $(cmt_final_setup_lcg_RelationalAccess)

$(bin)$(binobj)ConnectionService.o : $(src)ConnectionService.cpp
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp
endif
endif

else
$(bin)lcg_RelationalAccess_dependencies.make : $(ConnectionService_cpp_dependencies)

$(bin)lcg_RelationalAccess_dependencies.make : $(src)ConnectionService.cpp

$(bin)$(binobj)ConnectionService.o : $(ConnectionService_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDescription.d

$(bin)$(binobj)TableDescription.d :

$(bin)$(binobj)TableDescription.o : $(cmt_final_setup_lcg_RelationalAccess)

$(bin)$(binobj)TableDescription.o : $(src)TableDescription.cpp
	$(cpp_echo) $(src)TableDescription.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(TableDescription_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(TableDescription_cppflags) $(TableDescription_cpp_cppflags)  $(src)TableDescription.cpp
endif
endif

else
$(bin)lcg_RelationalAccess_dependencies.make : $(TableDescription_cpp_dependencies)

$(bin)lcg_RelationalAccess_dependencies.make : $(src)TableDescription.cpp

$(bin)$(binobj)TableDescription.o : $(TableDescription_cpp_dependencies)
	$(cpp_echo) $(src)TableDescription.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalAccess_pp_cppflags) $(lib_lcg_RelationalAccess_pp_cppflags) $(TableDescription_pp_cppflags) $(use_cppflags) $(lcg_RelationalAccess_cppflags) $(lib_lcg_RelationalAccess_cppflags) $(TableDescription_cppflags) $(TableDescription_cpp_cppflags)  $(src)TableDescription.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_RelationalAccessclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_RelationalAccess.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_RelationalAccessclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_RelationalAccess
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_RelationalAccess$(library_suffix).a $(library_prefix)lcg_RelationalAccess$(library_suffix).$(shlibsuffix) lcg_RelationalAccess.stamp lcg_RelationalAccess.shstamp
#-- end of cleanup_library ---------------
