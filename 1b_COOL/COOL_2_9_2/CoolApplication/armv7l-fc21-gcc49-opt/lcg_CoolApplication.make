#-- start of make_header -----------------

#====================================
#  Library lcg_CoolApplication
#
#   Generated Wed Apr 15 17:01:34 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoolApplication_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoolApplication_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoolApplication

CoolApplication_tag = $(tag)

#cmt_local_tagfile_lcg_CoolApplication = $(CoolApplication_tag)_lcg_CoolApplication.make
cmt_local_tagfile_lcg_CoolApplication = $(bin)$(CoolApplication_tag)_lcg_CoolApplication.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoolApplication_tag = $(tag)

#cmt_local_tagfile_lcg_CoolApplication = $(CoolApplication_tag).make
cmt_local_tagfile_lcg_CoolApplication = $(bin)$(CoolApplication_tag).make

endif

include $(cmt_local_tagfile_lcg_CoolApplication)
#-include $(cmt_local_tagfile_lcg_CoolApplication)

ifdef cmt_lcg_CoolApplication_has_target_tag

cmt_final_setup_lcg_CoolApplication = $(bin)setup_lcg_CoolApplication.make
cmt_dependencies_in_lcg_CoolApplication = $(bin)dependencies_lcg_CoolApplication.in
#cmt_final_setup_lcg_CoolApplication = $(bin)CoolApplication_lcg_CoolApplicationsetup.make
cmt_local_lcg_CoolApplication_makefile = $(bin)lcg_CoolApplication.make

else

cmt_final_setup_lcg_CoolApplication = $(bin)setup.make
cmt_dependencies_in_lcg_CoolApplication = $(bin)dependencies.in
#cmt_final_setup_lcg_CoolApplication = $(bin)CoolApplicationsetup.make
cmt_local_lcg_CoolApplication_makefile = $(bin)lcg_CoolApplication.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoolApplicationsetup.make

#lcg_CoolApplication :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoolApplication'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoolApplication/
#lcg_CoolApplication::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoolApplicationlibname   = $(bin)$(library_prefix)lcg_CoolApplication$(library_suffix)
lcg_CoolApplicationlib       = $(lcg_CoolApplicationlibname).a
lcg_CoolApplicationstamp     = $(bin)lcg_CoolApplication.stamp
lcg_CoolApplicationshstamp   = $(bin)lcg_CoolApplication.shstamp

lcg_CoolApplication :: dirs  lcg_CoolApplicationLIB
	$(echo) "lcg_CoolApplication ok"

cmt_lcg_CoolApplication_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoolApplication_has_prototypes

lcg_CoolApplicationprototype :  ;

endif

lcg_CoolApplicationcompile : $(bin)DatabaseSvcFactory.o $(bin)Application.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoolApplicationLIB :: $(lcg_CoolApplicationlib) $(lcg_CoolApplicationshstamp)
	@/bin/echo "------> lcg_CoolApplication : library ok"

$(lcg_CoolApplicationlib) :: $(bin)DatabaseSvcFactory.o $(bin)Application.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoolApplicationlib) $?
	$(lib_silent) $(ranlib) $(lcg_CoolApplicationlib)
	$(lib_silent) cat /dev/null >$(lcg_CoolApplicationstamp)

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

$(lcg_CoolApplicationlibname).$(shlibsuffix) :: $(lcg_CoolApplicationlib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoolApplication $(lcg_CoolApplication_shlibflags)

$(lcg_CoolApplicationshstamp) :: $(lcg_CoolApplicationlibname).$(shlibsuffix)
	@if test -f $(lcg_CoolApplicationlibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoolApplicationshstamp) ; fi

lcg_CoolApplicationclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)DatabaseSvcFactory.o $(bin)Application.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoolApplicationinstallname = $(library_prefix)lcg_CoolApplication$(library_suffix).$(shlibsuffix)

lcg_CoolApplication :: lcg_CoolApplicationinstall

install :: lcg_CoolApplicationinstall

lcg_CoolApplicationinstall :: $(install_dir)/$(lcg_CoolApplicationinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoolApplicationinstallname) :: $(bin)$(lcg_CoolApplicationinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoolApplicationinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoolApplicationclean :: lcg_CoolApplicationuninstall

uninstall :: lcg_CoolApplicationuninstall

lcg_CoolApplicationuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoolApplicationinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoolApplicationclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoolApplicationprototype)

$(bin)lcg_CoolApplication_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoolApplication)
	$(echo) "(lcg_CoolApplication.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)DatabaseSvcFactory.cpp $(src)Application.cpp -end_all $(includes) $(app_lcg_CoolApplication_cppflags) $(lib_lcg_CoolApplication_cppflags) -name=lcg_CoolApplication $? -f=$(cmt_dependencies_in_lcg_CoolApplication) -without_cmt

-include $(bin)lcg_CoolApplication_dependencies.make

endif
endif
endif

lcg_CoolApplicationclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoolApplication_deps $(bin)lcg_CoolApplication_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolApplicationclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DatabaseSvcFactory.d

$(bin)$(binobj)DatabaseSvcFactory.d :

$(bin)$(binobj)DatabaseSvcFactory.o : $(cmt_final_setup_lcg_CoolApplication)

$(bin)$(binobj)DatabaseSvcFactory.o : $(src)DatabaseSvcFactory.cpp
	$(cpp_echo) $(src)DatabaseSvcFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolApplication_pp_cppflags) $(lib_lcg_CoolApplication_pp_cppflags) $(DatabaseSvcFactory_pp_cppflags) $(use_cppflags) $(lcg_CoolApplication_cppflags) $(lib_lcg_CoolApplication_cppflags) $(DatabaseSvcFactory_cppflags) $(DatabaseSvcFactory_cpp_cppflags)  $(src)DatabaseSvcFactory.cpp
endif
endif

else
$(bin)lcg_CoolApplication_dependencies.make : $(DatabaseSvcFactory_cpp_dependencies)

$(bin)lcg_CoolApplication_dependencies.make : $(src)DatabaseSvcFactory.cpp

$(bin)$(binobj)DatabaseSvcFactory.o : $(DatabaseSvcFactory_cpp_dependencies)
	$(cpp_echo) $(src)DatabaseSvcFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolApplication_pp_cppflags) $(lib_lcg_CoolApplication_pp_cppflags) $(DatabaseSvcFactory_pp_cppflags) $(use_cppflags) $(lcg_CoolApplication_cppflags) $(lib_lcg_CoolApplication_cppflags) $(DatabaseSvcFactory_cppflags) $(DatabaseSvcFactory_cpp_cppflags)  $(src)DatabaseSvcFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolApplicationclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Application.d

$(bin)$(binobj)Application.d :

$(bin)$(binobj)Application.o : $(cmt_final_setup_lcg_CoolApplication)

$(bin)$(binobj)Application.o : $(src)Application.cpp
	$(cpp_echo) $(src)Application.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolApplication_pp_cppflags) $(lib_lcg_CoolApplication_pp_cppflags) $(Application_pp_cppflags) $(use_cppflags) $(lcg_CoolApplication_cppflags) $(lib_lcg_CoolApplication_cppflags) $(Application_cppflags) $(Application_cpp_cppflags)  $(src)Application.cpp
endif
endif

else
$(bin)lcg_CoolApplication_dependencies.make : $(Application_cpp_dependencies)

$(bin)lcg_CoolApplication_dependencies.make : $(src)Application.cpp

$(bin)$(binobj)Application.o : $(Application_cpp_dependencies)
	$(cpp_echo) $(src)Application.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolApplication_pp_cppflags) $(lib_lcg_CoolApplication_pp_cppflags) $(Application_pp_cppflags) $(use_cppflags) $(lcg_CoolApplication_cppflags) $(lib_lcg_CoolApplication_cppflags) $(Application_cppflags) $(Application_cpp_cppflags)  $(src)Application.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoolApplicationclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoolApplication.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoolApplicationclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoolApplication
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoolApplication$(library_suffix).a $(library_prefix)lcg_CoolApplication$(library_suffix).$(shlibsuffix) lcg_CoolApplication.stamp lcg_CoolApplication.shstamp
#-- end of cleanup_library ---------------
