#-- start of make_header -----------------

#====================================
#  Library lcg_XMLLookupService
#
#   Generated Tue Mar 31 10:24:12 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_XMLLookupService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_XMLLookupService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_XMLLookupService

XMLLookupService_tag = $(tag)

#cmt_local_tagfile_lcg_XMLLookupService = $(XMLLookupService_tag)_lcg_XMLLookupService.make
cmt_local_tagfile_lcg_XMLLookupService = $(bin)$(XMLLookupService_tag)_lcg_XMLLookupService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

XMLLookupService_tag = $(tag)

#cmt_local_tagfile_lcg_XMLLookupService = $(XMLLookupService_tag).make
cmt_local_tagfile_lcg_XMLLookupService = $(bin)$(XMLLookupService_tag).make

endif

include $(cmt_local_tagfile_lcg_XMLLookupService)
#-include $(cmt_local_tagfile_lcg_XMLLookupService)

ifdef cmt_lcg_XMLLookupService_has_target_tag

cmt_final_setup_lcg_XMLLookupService = $(bin)setup_lcg_XMLLookupService.make
cmt_dependencies_in_lcg_XMLLookupService = $(bin)dependencies_lcg_XMLLookupService.in
#cmt_final_setup_lcg_XMLLookupService = $(bin)XMLLookupService_lcg_XMLLookupServicesetup.make
cmt_local_lcg_XMLLookupService_makefile = $(bin)lcg_XMLLookupService.make

else

cmt_final_setup_lcg_XMLLookupService = $(bin)setup.make
cmt_dependencies_in_lcg_XMLLookupService = $(bin)dependencies.in
#cmt_final_setup_lcg_XMLLookupService = $(bin)XMLLookupServicesetup.make
cmt_local_lcg_XMLLookupService_makefile = $(bin)lcg_XMLLookupService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)XMLLookupServicesetup.make

#lcg_XMLLookupService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_XMLLookupService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_XMLLookupService/
#lcg_XMLLookupService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_XMLLookupServicelibname   = $(bin)$(library_prefix)lcg_XMLLookupService$(library_suffix)
lcg_XMLLookupServicelib       = $(lcg_XMLLookupServicelibname).a
lcg_XMLLookupServicestamp     = $(bin)lcg_XMLLookupService.stamp
lcg_XMLLookupServiceshstamp   = $(bin)lcg_XMLLookupService.shstamp

lcg_XMLLookupService :: dirs  lcg_XMLLookupServiceLIB
	$(echo) "lcg_XMLLookupService ok"

cmt_lcg_XMLLookupService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_XMLLookupService_has_prototypes

lcg_XMLLookupServiceprototype :  ;

endif

lcg_XMLLookupServicecompile : $(bin)modules.o $(bin)XMLLookupService.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_XMLLookupServiceLIB :: $(lcg_XMLLookupServicelib) $(lcg_XMLLookupServiceshstamp)
	@/bin/echo "------> lcg_XMLLookupService : library ok"

$(lcg_XMLLookupServicelib) :: $(bin)modules.o $(bin)XMLLookupService.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_XMLLookupServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_XMLLookupServicelib)
	$(lib_silent) cat /dev/null >$(lcg_XMLLookupServicestamp)

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

$(lcg_XMLLookupServicelibname).$(shlibsuffix) :: $(lcg_XMLLookupServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_XMLLookupService $(lcg_XMLLookupService_shlibflags)

$(lcg_XMLLookupServiceshstamp) :: $(lcg_XMLLookupServicelibname).$(shlibsuffix)
	@if test -f $(lcg_XMLLookupServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_XMLLookupServiceshstamp) ; fi

lcg_XMLLookupServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)modules.o $(bin)XMLLookupService.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_XMLLookupServiceinstallname = $(library_prefix)lcg_XMLLookupService$(library_suffix).$(shlibsuffix)

lcg_XMLLookupService :: lcg_XMLLookupServiceinstall

install :: lcg_XMLLookupServiceinstall

lcg_XMLLookupServiceinstall :: $(install_dir)/$(lcg_XMLLookupServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_XMLLookupServiceinstallname) :: $(bin)$(lcg_XMLLookupServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_XMLLookupServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_XMLLookupServiceclean :: lcg_XMLLookupServiceuninstall

uninstall :: lcg_XMLLookupServiceuninstall

lcg_XMLLookupServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_XMLLookupServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_XMLLookupServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_XMLLookupServiceprototype)

$(bin)lcg_XMLLookupService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_XMLLookupService)
	$(echo) "(lcg_XMLLookupService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)modules.cpp $(src)XMLLookupService.cpp -end_all $(includes) $(app_lcg_XMLLookupService_cppflags) $(lib_lcg_XMLLookupService_cppflags) -name=lcg_XMLLookupService $? -f=$(cmt_dependencies_in_lcg_XMLLookupService) -without_cmt

-include $(bin)lcg_XMLLookupService_dependencies.make

endif
endif
endif

lcg_XMLLookupServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_XMLLookupService_deps $(bin)lcg_XMLLookupService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_XMLLookupServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)modules.d

$(bin)$(binobj)modules.d :

$(bin)$(binobj)modules.o : $(cmt_final_setup_lcg_XMLLookupService)

$(bin)$(binobj)modules.o : $(src)modules.cpp
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_XMLLookupService_pp_cppflags) $(lib_lcg_XMLLookupService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_XMLLookupService_cppflags) $(lib_lcg_XMLLookupService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp
endif
endif

else
$(bin)lcg_XMLLookupService_dependencies.make : $(modules_cpp_dependencies)

$(bin)lcg_XMLLookupService_dependencies.make : $(src)modules.cpp

$(bin)$(binobj)modules.o : $(modules_cpp_dependencies)
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_XMLLookupService_pp_cppflags) $(lib_lcg_XMLLookupService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_XMLLookupService_cppflags) $(lib_lcg_XMLLookupService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_XMLLookupServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)XMLLookupService.d

$(bin)$(binobj)XMLLookupService.d :

$(bin)$(binobj)XMLLookupService.o : $(cmt_final_setup_lcg_XMLLookupService)

$(bin)$(binobj)XMLLookupService.o : $(src)XMLLookupService.cpp
	$(cpp_echo) $(src)XMLLookupService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_XMLLookupService_pp_cppflags) $(lib_lcg_XMLLookupService_pp_cppflags) $(XMLLookupService_pp_cppflags) $(use_cppflags) $(lcg_XMLLookupService_cppflags) $(lib_lcg_XMLLookupService_cppflags) $(XMLLookupService_cppflags) $(XMLLookupService_cpp_cppflags)  $(src)XMLLookupService.cpp
endif
endif

else
$(bin)lcg_XMLLookupService_dependencies.make : $(XMLLookupService_cpp_dependencies)

$(bin)lcg_XMLLookupService_dependencies.make : $(src)XMLLookupService.cpp

$(bin)$(binobj)XMLLookupService.o : $(XMLLookupService_cpp_dependencies)
	$(cpp_echo) $(src)XMLLookupService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_XMLLookupService_pp_cppflags) $(lib_lcg_XMLLookupService_pp_cppflags) $(XMLLookupService_pp_cppflags) $(use_cppflags) $(lcg_XMLLookupService_cppflags) $(lib_lcg_XMLLookupService_cppflags) $(XMLLookupService_cppflags) $(XMLLookupService_cpp_cppflags)  $(src)XMLLookupService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_XMLLookupServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_XMLLookupService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_XMLLookupServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_XMLLookupService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_XMLLookupService$(library_suffix).a $(library_prefix)lcg_XMLLookupService$(library_suffix).$(shlibsuffix) lcg_XMLLookupService.stamp lcg_XMLLookupService.shstamp
#-- end of cleanup_library ---------------
