#-- start of make_header -----------------

#====================================
#  Library lcg_RelationalService
#
#   Generated Tue Mar 31 10:25:26 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_RelationalService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_RelationalService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_RelationalService

RelationalService_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalService = $(RelationalService_tag)_lcg_RelationalService.make
cmt_local_tagfile_lcg_RelationalService = $(bin)$(RelationalService_tag)_lcg_RelationalService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RelationalService_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalService = $(RelationalService_tag).make
cmt_local_tagfile_lcg_RelationalService = $(bin)$(RelationalService_tag).make

endif

include $(cmt_local_tagfile_lcg_RelationalService)
#-include $(cmt_local_tagfile_lcg_RelationalService)

ifdef cmt_lcg_RelationalService_has_target_tag

cmt_final_setup_lcg_RelationalService = $(bin)setup_lcg_RelationalService.make
cmt_dependencies_in_lcg_RelationalService = $(bin)dependencies_lcg_RelationalService.in
#cmt_final_setup_lcg_RelationalService = $(bin)RelationalService_lcg_RelationalServicesetup.make
cmt_local_lcg_RelationalService_makefile = $(bin)lcg_RelationalService.make

else

cmt_final_setup_lcg_RelationalService = $(bin)setup.make
cmt_dependencies_in_lcg_RelationalService = $(bin)dependencies.in
#cmt_final_setup_lcg_RelationalService = $(bin)RelationalServicesetup.make
cmt_local_lcg_RelationalService_makefile = $(bin)lcg_RelationalService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RelationalServicesetup.make

#lcg_RelationalService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_RelationalService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_RelationalService/
#lcg_RelationalService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_RelationalServicelibname   = $(bin)$(library_prefix)lcg_RelationalService$(library_suffix)
lcg_RelationalServicelib       = $(lcg_RelationalServicelibname).a
lcg_RelationalServicestamp     = $(bin)lcg_RelationalService.stamp
lcg_RelationalServiceshstamp   = $(bin)lcg_RelationalService.shstamp

lcg_RelationalService :: dirs  lcg_RelationalServiceLIB
	$(echo) "lcg_RelationalService ok"

cmt_lcg_RelationalService_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_RelationalService_has_prototypes

lcg_RelationalServiceprototype :  ;

endif

lcg_RelationalServicecompile : $(bin)RelationalService.o $(bin)modules.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_RelationalServiceLIB :: $(lcg_RelationalServicelib) $(lcg_RelationalServiceshstamp)
	@/bin/echo "------> lcg_RelationalService : library ok"

$(lcg_RelationalServicelib) :: $(bin)RelationalService.o $(bin)modules.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_RelationalServicelib) $?
	$(lib_silent) $(ranlib) $(lcg_RelationalServicelib)
	$(lib_silent) cat /dev/null >$(lcg_RelationalServicestamp)

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

$(lcg_RelationalServicelibname).$(shlibsuffix) :: $(lcg_RelationalServicelib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_RelationalService $(lcg_RelationalService_shlibflags)

$(lcg_RelationalServiceshstamp) :: $(lcg_RelationalServicelibname).$(shlibsuffix)
	@if test -f $(lcg_RelationalServicelibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_RelationalServiceshstamp) ; fi

lcg_RelationalServiceclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)RelationalService.o $(bin)modules.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_RelationalServiceinstallname = $(library_prefix)lcg_RelationalService$(library_suffix).$(shlibsuffix)

lcg_RelationalService :: lcg_RelationalServiceinstall

install :: lcg_RelationalServiceinstall

lcg_RelationalServiceinstall :: $(install_dir)/$(lcg_RelationalServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_RelationalServiceinstallname) :: $(bin)$(lcg_RelationalServiceinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalServiceinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_RelationalServiceclean :: lcg_RelationalServiceuninstall

uninstall :: lcg_RelationalServiceuninstall

lcg_RelationalServiceuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalServiceinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_RelationalServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_RelationalServiceprototype)

$(bin)lcg_RelationalService_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_RelationalService)
	$(echo) "(lcg_RelationalService.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RelationalService.cpp $(src)modules.cpp -end_all $(includes) $(app_lcg_RelationalService_cppflags) $(lib_lcg_RelationalService_cppflags) -name=lcg_RelationalService $? -f=$(cmt_dependencies_in_lcg_RelationalService) -without_cmt

-include $(bin)lcg_RelationalService_dependencies.make

endif
endif
endif

lcg_RelationalServiceclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_RelationalService_deps $(bin)lcg_RelationalService_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalService.d

$(bin)$(binobj)RelationalService.d :

$(bin)$(binobj)RelationalService.o : $(cmt_final_setup_lcg_RelationalService)

$(bin)$(binobj)RelationalService.o : $(src)RelationalService.cpp
	$(cpp_echo) $(src)RelationalService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalService_pp_cppflags) $(lib_lcg_RelationalService_pp_cppflags) $(RelationalService_pp_cppflags) $(use_cppflags) $(lcg_RelationalService_cppflags) $(lib_lcg_RelationalService_cppflags) $(RelationalService_cppflags) $(RelationalService_cpp_cppflags)  $(src)RelationalService.cpp
endif
endif

else
$(bin)lcg_RelationalService_dependencies.make : $(RelationalService_cpp_dependencies)

$(bin)lcg_RelationalService_dependencies.make : $(src)RelationalService.cpp

$(bin)$(binobj)RelationalService.o : $(RelationalService_cpp_dependencies)
	$(cpp_echo) $(src)RelationalService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalService_pp_cppflags) $(lib_lcg_RelationalService_pp_cppflags) $(RelationalService_pp_cppflags) $(use_cppflags) $(lcg_RelationalService_cppflags) $(lib_lcg_RelationalService_cppflags) $(RelationalService_cppflags) $(RelationalService_cpp_cppflags)  $(src)RelationalService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)modules.d

$(bin)$(binobj)modules.d :

$(bin)$(binobj)modules.o : $(cmt_final_setup_lcg_RelationalService)

$(bin)$(binobj)modules.o : $(src)modules.cpp
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalService_pp_cppflags) $(lib_lcg_RelationalService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_RelationalService_cppflags) $(lib_lcg_RelationalService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp
endif
endif

else
$(bin)lcg_RelationalService_dependencies.make : $(modules_cpp_dependencies)

$(bin)lcg_RelationalService_dependencies.make : $(src)modules.cpp

$(bin)$(binobj)modules.o : $(modules_cpp_dependencies)
	$(cpp_echo) $(src)modules.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalService_pp_cppflags) $(lib_lcg_RelationalService_pp_cppflags) $(modules_pp_cppflags) $(use_cppflags) $(lcg_RelationalService_cppflags) $(lib_lcg_RelationalService_cppflags) $(modules_cppflags) $(modules_cpp_cppflags)  $(src)modules.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_RelationalServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_RelationalService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_RelationalServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_RelationalService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_RelationalService$(library_suffix).a $(library_prefix)lcg_RelationalService$(library_suffix).$(shlibsuffix) lcg_RelationalService.stamp lcg_RelationalService.shstamp
#-- end of cleanup_library ---------------
