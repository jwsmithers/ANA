#-- start of make_header -----------------

#====================================
#  Library lcg_CoralKernel
#
#   Generated Tue Mar 31 10:22:17 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralKernel_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralKernel_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralKernel

CoralKernel_tag = $(tag)

#cmt_local_tagfile_lcg_CoralKernel = $(CoralKernel_tag)_lcg_CoralKernel.make
cmt_local_tagfile_lcg_CoralKernel = $(bin)$(CoralKernel_tag)_lcg_CoralKernel.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralKernel_tag = $(tag)

#cmt_local_tagfile_lcg_CoralKernel = $(CoralKernel_tag).make
cmt_local_tagfile_lcg_CoralKernel = $(bin)$(CoralKernel_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralKernel)
#-include $(cmt_local_tagfile_lcg_CoralKernel)

ifdef cmt_lcg_CoralKernel_has_target_tag

cmt_final_setup_lcg_CoralKernel = $(bin)setup_lcg_CoralKernel.make
cmt_dependencies_in_lcg_CoralKernel = $(bin)dependencies_lcg_CoralKernel.in
#cmt_final_setup_lcg_CoralKernel = $(bin)CoralKernel_lcg_CoralKernelsetup.make
cmt_local_lcg_CoralKernel_makefile = $(bin)lcg_CoralKernel.make

else

cmt_final_setup_lcg_CoralKernel = $(bin)setup.make
cmt_dependencies_in_lcg_CoralKernel = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralKernel = $(bin)CoralKernelsetup.make
cmt_local_lcg_CoralKernel_makefile = $(bin)lcg_CoralKernel.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralKernelsetup.make

#lcg_CoralKernel :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralKernel'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralKernel/
#lcg_CoralKernel::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralKernellibname   = $(bin)$(library_prefix)lcg_CoralKernel$(library_suffix)
lcg_CoralKernellib       = $(lcg_CoralKernellibname).a
lcg_CoralKernelstamp     = $(bin)lcg_CoralKernel.stamp
lcg_CoralKernelshstamp   = $(bin)lcg_CoralKernel.shstamp

lcg_CoralKernel :: dirs  lcg_CoralKernelLIB
	$(echo) "lcg_CoralKernel ok"

cmt_lcg_CoralKernel_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralKernel_has_prototypes

lcg_CoralKernelprototype :  ;

endif

lcg_CoralKernelcompile : $(bin)Property.o $(bin)PropertyManager.o $(bin)Context.o $(bin)PluginManager.o $(bin)Service.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralKernelLIB :: $(lcg_CoralKernellib) $(lcg_CoralKernelshstamp)
	@/bin/echo "------> lcg_CoralKernel : library ok"

$(lcg_CoralKernellib) :: $(bin)Property.o $(bin)PropertyManager.o $(bin)Context.o $(bin)PluginManager.o $(bin)Service.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralKernellib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralKernellib)
	$(lib_silent) cat /dev/null >$(lcg_CoralKernelstamp)

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

$(lcg_CoralKernellibname).$(shlibsuffix) :: $(lcg_CoralKernellib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralKernel $(lcg_CoralKernel_shlibflags)

$(lcg_CoralKernelshstamp) :: $(lcg_CoralKernellibname).$(shlibsuffix)
	@if test -f $(lcg_CoralKernellibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralKernelshstamp) ; fi

lcg_CoralKernelclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Property.o $(bin)PropertyManager.o $(bin)Context.o $(bin)PluginManager.o $(bin)Service.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralKernelinstallname = $(library_prefix)lcg_CoralKernel$(library_suffix).$(shlibsuffix)

lcg_CoralKernel :: lcg_CoralKernelinstall

install :: lcg_CoralKernelinstall

lcg_CoralKernelinstall :: $(install_dir)/$(lcg_CoralKernelinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralKernelinstallname) :: $(bin)$(lcg_CoralKernelinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralKernelinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralKernelclean :: lcg_CoralKerneluninstall

uninstall :: lcg_CoralKerneluninstall

lcg_CoralKerneluninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralKernelinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralKernelprototype)

$(bin)lcg_CoralKernel_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralKernel)
	$(echo) "(lcg_CoralKernel.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Property.cpp $(src)PropertyManager.cpp $(src)Context.cpp $(src)PluginManager.cpp $(src)Service.cpp -end_all $(includes) $(app_lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) -name=lcg_CoralKernel $? -f=$(cmt_dependencies_in_lcg_CoralKernel) -without_cmt

-include $(bin)lcg_CoralKernel_dependencies.make

endif
endif
endif

lcg_CoralKernelclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralKernel_deps $(bin)lcg_CoralKernel_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Property.d

$(bin)$(binobj)Property.d :

$(bin)$(binobj)Property.o : $(cmt_final_setup_lcg_CoralKernel)

$(bin)$(binobj)Property.o : $(src)Property.cpp
	$(cpp_echo) $(src)Property.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Property_cppflags) $(Property_cpp_cppflags)  $(src)Property.cpp
endif
endif

else
$(bin)lcg_CoralKernel_dependencies.make : $(Property_cpp_dependencies)

$(bin)lcg_CoralKernel_dependencies.make : $(src)Property.cpp

$(bin)$(binobj)Property.o : $(Property_cpp_dependencies)
	$(cpp_echo) $(src)Property.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Property_cppflags) $(Property_cpp_cppflags)  $(src)Property.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyManager.d

$(bin)$(binobj)PropertyManager.d :

$(bin)$(binobj)PropertyManager.o : $(cmt_final_setup_lcg_CoralKernel)

$(bin)$(binobj)PropertyManager.o : $(src)PropertyManager.cpp
	$(cpp_echo) $(src)PropertyManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(PropertyManager_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(PropertyManager_cppflags) $(PropertyManager_cpp_cppflags)  $(src)PropertyManager.cpp
endif
endif

else
$(bin)lcg_CoralKernel_dependencies.make : $(PropertyManager_cpp_dependencies)

$(bin)lcg_CoralKernel_dependencies.make : $(src)PropertyManager.cpp

$(bin)$(binobj)PropertyManager.o : $(PropertyManager_cpp_dependencies)
	$(cpp_echo) $(src)PropertyManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(PropertyManager_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(PropertyManager_cppflags) $(PropertyManager_cpp_cppflags)  $(src)PropertyManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Context.d

$(bin)$(binobj)Context.d :

$(bin)$(binobj)Context.o : $(cmt_final_setup_lcg_CoralKernel)

$(bin)$(binobj)Context.o : $(src)Context.cpp
	$(cpp_echo) $(src)Context.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Context_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Context_cppflags) $(Context_cpp_cppflags)  $(src)Context.cpp
endif
endif

else
$(bin)lcg_CoralKernel_dependencies.make : $(Context_cpp_dependencies)

$(bin)lcg_CoralKernel_dependencies.make : $(src)Context.cpp

$(bin)$(binobj)Context.o : $(Context_cpp_dependencies)
	$(cpp_echo) $(src)Context.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Context_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Context_cppflags) $(Context_cpp_cppflags)  $(src)Context.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PluginManager.d

$(bin)$(binobj)PluginManager.d :

$(bin)$(binobj)PluginManager.o : $(cmt_final_setup_lcg_CoralKernel)

$(bin)$(binobj)PluginManager.o : $(src)PluginManager.cpp
	$(cpp_echo) $(src)PluginManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(PluginManager_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(PluginManager_cppflags) $(PluginManager_cpp_cppflags)  $(src)PluginManager.cpp
endif
endif

else
$(bin)lcg_CoralKernel_dependencies.make : $(PluginManager_cpp_dependencies)

$(bin)lcg_CoralKernel_dependencies.make : $(src)PluginManager.cpp

$(bin)$(binobj)PluginManager.o : $(PluginManager_cpp_dependencies)
	$(cpp_echo) $(src)PluginManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(PluginManager_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(PluginManager_cppflags) $(PluginManager_cpp_cppflags)  $(src)PluginManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Service.d

$(bin)$(binobj)Service.d :

$(bin)$(binobj)Service.o : $(cmt_final_setup_lcg_CoralKernel)

$(bin)$(binobj)Service.o : $(src)Service.cpp
	$(cpp_echo) $(src)Service.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Service_cppflags) $(Service_cpp_cppflags)  $(src)Service.cpp
endif
endif

else
$(bin)lcg_CoralKernel_dependencies.make : $(Service_cpp_dependencies)

$(bin)lcg_CoralKernel_dependencies.make : $(src)Service.cpp

$(bin)$(binobj)Service.o : $(Service_cpp_dependencies)
	$(cpp_echo) $(src)Service.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralKernel_pp_cppflags) $(lib_lcg_CoralKernel_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(lcg_CoralKernel_cppflags) $(lib_lcg_CoralKernel_cppflags) $(Service_cppflags) $(Service_cpp_cppflags)  $(src)Service.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralKernelclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralKernel.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralKernelclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralKernel
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralKernel$(library_suffix).a $(library_prefix)lcg_CoralKernel$(library_suffix).$(shlibsuffix) lcg_CoralKernel.stamp lcg_CoralKernel.shstamp
#-- end of cleanup_library ---------------
