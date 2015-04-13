#-- start of make_header -----------------

#====================================
#  Library lcg_CoolKernel
#
#   Generated Tue Mar 31 09:54:23 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoolKernel_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoolKernel_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoolKernel

CoolKernel_tag = $(tag)

#cmt_local_tagfile_lcg_CoolKernel = $(CoolKernel_tag)_lcg_CoolKernel.make
cmt_local_tagfile_lcg_CoolKernel = $(bin)$(CoolKernel_tag)_lcg_CoolKernel.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoolKernel_tag = $(tag)

#cmt_local_tagfile_lcg_CoolKernel = $(CoolKernel_tag).make
cmt_local_tagfile_lcg_CoolKernel = $(bin)$(CoolKernel_tag).make

endif

include $(cmt_local_tagfile_lcg_CoolKernel)
#-include $(cmt_local_tagfile_lcg_CoolKernel)

ifdef cmt_lcg_CoolKernel_has_target_tag

cmt_final_setup_lcg_CoolKernel = $(bin)setup_lcg_CoolKernel.make
cmt_dependencies_in_lcg_CoolKernel = $(bin)dependencies_lcg_CoolKernel.in
#cmt_final_setup_lcg_CoolKernel = $(bin)CoolKernel_lcg_CoolKernelsetup.make
cmt_local_lcg_CoolKernel_makefile = $(bin)lcg_CoolKernel.make

else

cmt_final_setup_lcg_CoolKernel = $(bin)setup.make
cmt_dependencies_in_lcg_CoolKernel = $(bin)dependencies.in
#cmt_final_setup_lcg_CoolKernel = $(bin)CoolKernelsetup.make
cmt_local_lcg_CoolKernel_makefile = $(bin)lcg_CoolKernel.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoolKernelsetup.make

#lcg_CoolKernel :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoolKernel'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoolKernel/
#lcg_CoolKernel::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoolKernellibname   = $(bin)$(library_prefix)lcg_CoolKernel$(library_suffix)
lcg_CoolKernellib       = $(lcg_CoolKernellibname).a
lcg_CoolKernelstamp     = $(bin)lcg_CoolKernel.stamp
lcg_CoolKernelshstamp   = $(bin)lcg_CoolKernel.shstamp

lcg_CoolKernel :: dirs  lcg_CoolKernelLIB
	$(echo) "lcg_CoolKernel ok"

cmt_lcg_CoolKernel_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoolKernel_has_prototypes

lcg_CoolKernelprototype :  ;

endif

lcg_CoolKernelcompile : $(bin)Time.o $(bin)SealBaseTime.o $(bin)RecordSpecification.o $(bin)StorageType.o $(bin)FolderSpecification.o $(bin)FieldSelection.o $(bin)CompositeSelection.o $(bin)TimeWrapper.o $(bin)ConstRecordAdapter.o $(bin)FieldAdapter.o $(bin)ChannelSelection.o $(bin)FieldSpecification.o $(bin)ConstFieldAdapter.o $(bin)Record.o $(bin)SealTime.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoolKernelLIB :: $(lcg_CoolKernellib) $(lcg_CoolKernelshstamp)
	@/bin/echo "------> lcg_CoolKernel : library ok"

$(lcg_CoolKernellib) :: $(bin)Time.o $(bin)SealBaseTime.o $(bin)RecordSpecification.o $(bin)StorageType.o $(bin)FolderSpecification.o $(bin)FieldSelection.o $(bin)CompositeSelection.o $(bin)TimeWrapper.o $(bin)ConstRecordAdapter.o $(bin)FieldAdapter.o $(bin)ChannelSelection.o $(bin)FieldSpecification.o $(bin)ConstFieldAdapter.o $(bin)Record.o $(bin)SealTime.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoolKernellib) $?
	$(lib_silent) $(ranlib) $(lcg_CoolKernellib)
	$(lib_silent) cat /dev/null >$(lcg_CoolKernelstamp)

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

$(lcg_CoolKernellibname).$(shlibsuffix) :: $(lcg_CoolKernellib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoolKernel $(lcg_CoolKernel_shlibflags)

$(lcg_CoolKernelshstamp) :: $(lcg_CoolKernellibname).$(shlibsuffix)
	@if test -f $(lcg_CoolKernellibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoolKernelshstamp) ; fi

lcg_CoolKernelclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)Time.o $(bin)SealBaseTime.o $(bin)RecordSpecification.o $(bin)StorageType.o $(bin)FolderSpecification.o $(bin)FieldSelection.o $(bin)CompositeSelection.o $(bin)TimeWrapper.o $(bin)ConstRecordAdapter.o $(bin)FieldAdapter.o $(bin)ChannelSelection.o $(bin)FieldSpecification.o $(bin)ConstFieldAdapter.o $(bin)Record.o $(bin)SealTime.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoolKernelinstallname = $(library_prefix)lcg_CoolKernel$(library_suffix).$(shlibsuffix)

lcg_CoolKernel :: lcg_CoolKernelinstall

install :: lcg_CoolKernelinstall

lcg_CoolKernelinstall :: $(install_dir)/$(lcg_CoolKernelinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoolKernelinstallname) :: $(bin)$(lcg_CoolKernelinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoolKernelinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoolKernelclean :: lcg_CoolKerneluninstall

uninstall :: lcg_CoolKerneluninstall

lcg_CoolKerneluninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoolKernelinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoolKernelprototype)

$(bin)lcg_CoolKernel_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoolKernel)
	$(echo) "(lcg_CoolKernel.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)Time.cpp $(src)SealBaseTime.cpp $(src)RecordSpecification.cpp $(src)StorageType.cpp $(src)FolderSpecification.cpp $(src)FieldSelection.cpp $(src)CompositeSelection.cpp $(src)TimeWrapper.cpp $(src)ConstRecordAdapter.cpp $(src)FieldAdapter.cpp $(src)ChannelSelection.cpp $(src)FieldSpecification.cpp $(src)ConstFieldAdapter.cpp $(src)Record.cpp $(src)SealTime.cpp -end_all $(includes) $(app_lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) -name=lcg_CoolKernel $? -f=$(cmt_dependencies_in_lcg_CoolKernel) -without_cmt

-include $(bin)lcg_CoolKernel_dependencies.make

endif
endif
endif

lcg_CoolKernelclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoolKernel_deps $(bin)lcg_CoolKernel_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Time.d

$(bin)$(binobj)Time.d :

$(bin)$(binobj)Time.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)Time.o : $(src)Time.cpp
	$(cpp_echo) $(src)Time.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(Time_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(Time_cppflags) $(Time_cpp_cppflags)  $(src)Time.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(Time_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)Time.cpp

$(bin)$(binobj)Time.o : $(Time_cpp_dependencies)
	$(cpp_echo) $(src)Time.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(Time_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(Time_cppflags) $(Time_cpp_cppflags)  $(src)Time.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SealBaseTime.d

$(bin)$(binobj)SealBaseTime.d :

$(bin)$(binobj)SealBaseTime.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)SealBaseTime.o : $(src)SealBaseTime.cpp
	$(cpp_echo) $(src)SealBaseTime.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(SealBaseTime_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(SealBaseTime_cppflags) $(SealBaseTime_cpp_cppflags)  $(src)SealBaseTime.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(SealBaseTime_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)SealBaseTime.cpp

$(bin)$(binobj)SealBaseTime.o : $(SealBaseTime_cpp_dependencies)
	$(cpp_echo) $(src)SealBaseTime.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(SealBaseTime_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(SealBaseTime_cppflags) $(SealBaseTime_cpp_cppflags)  $(src)SealBaseTime.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecordSpecification.d

$(bin)$(binobj)RecordSpecification.d :

$(bin)$(binobj)RecordSpecification.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)RecordSpecification.o : $(src)RecordSpecification.cpp
	$(cpp_echo) $(src)RecordSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(RecordSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(RecordSpecification_cppflags) $(RecordSpecification_cpp_cppflags)  $(src)RecordSpecification.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(RecordSpecification_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)RecordSpecification.cpp

$(bin)$(binobj)RecordSpecification.o : $(RecordSpecification_cpp_dependencies)
	$(cpp_echo) $(src)RecordSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(RecordSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(RecordSpecification_cppflags) $(RecordSpecification_cpp_cppflags)  $(src)RecordSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StorageType.d

$(bin)$(binobj)StorageType.d :

$(bin)$(binobj)StorageType.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)StorageType.o : $(src)StorageType.cpp
	$(cpp_echo) $(src)StorageType.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(StorageType_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(StorageType_cppflags) $(StorageType_cpp_cppflags)  $(src)StorageType.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(StorageType_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)StorageType.cpp

$(bin)$(binobj)StorageType.o : $(StorageType_cpp_dependencies)
	$(cpp_echo) $(src)StorageType.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(StorageType_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(StorageType_cppflags) $(StorageType_cpp_cppflags)  $(src)StorageType.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FolderSpecification.d

$(bin)$(binobj)FolderSpecification.d :

$(bin)$(binobj)FolderSpecification.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)FolderSpecification.o : $(src)FolderSpecification.cpp
	$(cpp_echo) $(src)FolderSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FolderSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FolderSpecification_cppflags) $(FolderSpecification_cpp_cppflags)  $(src)FolderSpecification.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(FolderSpecification_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)FolderSpecification.cpp

$(bin)$(binobj)FolderSpecification.o : $(FolderSpecification_cpp_dependencies)
	$(cpp_echo) $(src)FolderSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FolderSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FolderSpecification_cppflags) $(FolderSpecification_cpp_cppflags)  $(src)FolderSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FieldSelection.d

$(bin)$(binobj)FieldSelection.d :

$(bin)$(binobj)FieldSelection.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)FieldSelection.o : $(src)FieldSelection.cpp
	$(cpp_echo) $(src)FieldSelection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldSelection_cppflags) $(FieldSelection_cpp_cppflags)  $(src)FieldSelection.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(FieldSelection_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)FieldSelection.cpp

$(bin)$(binobj)FieldSelection.o : $(FieldSelection_cpp_dependencies)
	$(cpp_echo) $(src)FieldSelection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldSelection_cppflags) $(FieldSelection_cpp_cppflags)  $(src)FieldSelection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CompositeSelection.d

$(bin)$(binobj)CompositeSelection.d :

$(bin)$(binobj)CompositeSelection.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)CompositeSelection.o : $(src)CompositeSelection.cpp
	$(cpp_echo) $(src)CompositeSelection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(CompositeSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(CompositeSelection_cppflags) $(CompositeSelection_cpp_cppflags)  $(src)CompositeSelection.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(CompositeSelection_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)CompositeSelection.cpp

$(bin)$(binobj)CompositeSelection.o : $(CompositeSelection_cpp_dependencies)
	$(cpp_echo) $(src)CompositeSelection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(CompositeSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(CompositeSelection_cppflags) $(CompositeSelection_cpp_cppflags)  $(src)CompositeSelection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeWrapper.d

$(bin)$(binobj)TimeWrapper.d :

$(bin)$(binobj)TimeWrapper.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)TimeWrapper.o : $(src)TimeWrapper.cpp
	$(cpp_echo) $(src)TimeWrapper.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(TimeWrapper_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(TimeWrapper_cppflags) $(TimeWrapper_cpp_cppflags)  $(src)TimeWrapper.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(TimeWrapper_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)TimeWrapper.cpp

$(bin)$(binobj)TimeWrapper.o : $(TimeWrapper_cpp_dependencies)
	$(cpp_echo) $(src)TimeWrapper.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(TimeWrapper_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(TimeWrapper_cppflags) $(TimeWrapper_cpp_cppflags)  $(src)TimeWrapper.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConstRecordAdapter.d

$(bin)$(binobj)ConstRecordAdapter.d :

$(bin)$(binobj)ConstRecordAdapter.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)ConstRecordAdapter.o : $(src)ConstRecordAdapter.cpp
	$(cpp_echo) $(src)ConstRecordAdapter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ConstRecordAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ConstRecordAdapter_cppflags) $(ConstRecordAdapter_cpp_cppflags)  $(src)ConstRecordAdapter.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(ConstRecordAdapter_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)ConstRecordAdapter.cpp

$(bin)$(binobj)ConstRecordAdapter.o : $(ConstRecordAdapter_cpp_dependencies)
	$(cpp_echo) $(src)ConstRecordAdapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ConstRecordAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ConstRecordAdapter_cppflags) $(ConstRecordAdapter_cpp_cppflags)  $(src)ConstRecordAdapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FieldAdapter.d

$(bin)$(binobj)FieldAdapter.d :

$(bin)$(binobj)FieldAdapter.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)FieldAdapter.o : $(src)FieldAdapter.cpp
	$(cpp_echo) $(src)FieldAdapter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldAdapter_cppflags) $(FieldAdapter_cpp_cppflags)  $(src)FieldAdapter.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(FieldAdapter_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)FieldAdapter.cpp

$(bin)$(binobj)FieldAdapter.o : $(FieldAdapter_cpp_dependencies)
	$(cpp_echo) $(src)FieldAdapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldAdapter_cppflags) $(FieldAdapter_cpp_cppflags)  $(src)FieldAdapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ChannelSelection.d

$(bin)$(binobj)ChannelSelection.d :

$(bin)$(binobj)ChannelSelection.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)ChannelSelection.o : $(src)ChannelSelection.cpp
	$(cpp_echo) $(src)ChannelSelection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ChannelSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ChannelSelection_cppflags) $(ChannelSelection_cpp_cppflags)  $(src)ChannelSelection.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(ChannelSelection_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)ChannelSelection.cpp

$(bin)$(binobj)ChannelSelection.o : $(ChannelSelection_cpp_dependencies)
	$(cpp_echo) $(src)ChannelSelection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ChannelSelection_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ChannelSelection_cppflags) $(ChannelSelection_cpp_cppflags)  $(src)ChannelSelection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FieldSpecification.d

$(bin)$(binobj)FieldSpecification.d :

$(bin)$(binobj)FieldSpecification.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)FieldSpecification.o : $(src)FieldSpecification.cpp
	$(cpp_echo) $(src)FieldSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldSpecification_cppflags) $(FieldSpecification_cpp_cppflags)  $(src)FieldSpecification.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(FieldSpecification_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)FieldSpecification.cpp

$(bin)$(binobj)FieldSpecification.o : $(FieldSpecification_cpp_dependencies)
	$(cpp_echo) $(src)FieldSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(FieldSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(FieldSpecification_cppflags) $(FieldSpecification_cpp_cppflags)  $(src)FieldSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConstFieldAdapter.d

$(bin)$(binobj)ConstFieldAdapter.d :

$(bin)$(binobj)ConstFieldAdapter.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)ConstFieldAdapter.o : $(src)ConstFieldAdapter.cpp
	$(cpp_echo) $(src)ConstFieldAdapter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ConstFieldAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ConstFieldAdapter_cppflags) $(ConstFieldAdapter_cpp_cppflags)  $(src)ConstFieldAdapter.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(ConstFieldAdapter_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)ConstFieldAdapter.cpp

$(bin)$(binobj)ConstFieldAdapter.o : $(ConstFieldAdapter_cpp_dependencies)
	$(cpp_echo) $(src)ConstFieldAdapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(ConstFieldAdapter_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(ConstFieldAdapter_cppflags) $(ConstFieldAdapter_cpp_cppflags)  $(src)ConstFieldAdapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Record.d

$(bin)$(binobj)Record.d :

$(bin)$(binobj)Record.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)Record.o : $(src)Record.cpp
	$(cpp_echo) $(src)Record.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(Record_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(Record_cppflags) $(Record_cpp_cppflags)  $(src)Record.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(Record_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)Record.cpp

$(bin)$(binobj)Record.o : $(Record_cpp_dependencies)
	$(cpp_echo) $(src)Record.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(Record_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(Record_cppflags) $(Record_cpp_cppflags)  $(src)Record.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoolKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SealTime.d

$(bin)$(binobj)SealTime.d :

$(bin)$(binobj)SealTime.o : $(cmt_final_setup_lcg_CoolKernel)

$(bin)$(binobj)SealTime.o : $(src)SealTime.cpp
	$(cpp_echo) $(src)SealTime.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(SealTime_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(SealTime_cppflags) $(SealTime_cpp_cppflags)  $(src)SealTime.cpp
endif
endif

else
$(bin)lcg_CoolKernel_dependencies.make : $(SealTime_cpp_dependencies)

$(bin)lcg_CoolKernel_dependencies.make : $(src)SealTime.cpp

$(bin)$(binobj)SealTime.o : $(SealTime_cpp_dependencies)
	$(cpp_echo) $(src)SealTime.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoolKernel_pp_cppflags) $(lib_lcg_CoolKernel_pp_cppflags) $(SealTime_pp_cppflags) $(use_cppflags) $(lcg_CoolKernel_cppflags) $(lib_lcg_CoolKernel_cppflags) $(SealTime_cppflags) $(SealTime_cpp_cppflags)  $(src)SealTime.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoolKernelclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoolKernel.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoolKernelclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoolKernel
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoolKernel$(library_suffix).a $(library_prefix)lcg_CoolKernel$(library_suffix).$(shlibsuffix) lcg_CoolKernel.stamp lcg_CoolKernel.shstamp
#-- end of cleanup_library ---------------
