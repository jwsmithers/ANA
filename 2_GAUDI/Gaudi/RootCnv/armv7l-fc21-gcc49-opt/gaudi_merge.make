#-- start of make_header -----------------

#====================================
#  Application gaudi_merge
#
#   Generated Mon Feb 16 20:00:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_gaudi_merge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_gaudi_merge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_gaudi_merge

RootCnv_tag = $(tag)

#cmt_local_tagfile_gaudi_merge = $(RootCnv_tag)_gaudi_merge.make
cmt_local_tagfile_gaudi_merge = $(bin)$(RootCnv_tag)_gaudi_merge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_gaudi_merge = $(RootCnv_tag).make
cmt_local_tagfile_gaudi_merge = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_gaudi_merge)
#-include $(cmt_local_tagfile_gaudi_merge)

ifdef cmt_gaudi_merge_has_target_tag

cmt_final_setup_gaudi_merge = $(bin)setup_gaudi_merge.make
cmt_dependencies_in_gaudi_merge = $(bin)dependencies_gaudi_merge.in
#cmt_final_setup_gaudi_merge = $(bin)RootCnv_gaudi_mergesetup.make
cmt_local_gaudi_merge_makefile = $(bin)gaudi_merge.make

else

cmt_final_setup_gaudi_merge = $(bin)setup.make
cmt_dependencies_in_gaudi_merge = $(bin)dependencies.in
#cmt_final_setup_gaudi_merge = $(bin)RootCnvsetup.make
cmt_local_gaudi_merge_makefile = $(bin)gaudi_merge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#gaudi_merge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'gaudi_merge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = gaudi_merge/
#gaudi_merge::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

gaudi_merge :: dirs  $(bin)gaudi_merge${application_suffix}
	$(echo) "gaudi_merge ok"

cmt_gaudi_merge_has_prototypes = 1

#--------------------------------------

ifdef cmt_gaudi_merge_has_prototypes

gaudi_mergeprototype :  ;

endif

gaudi_mergecompile : $(bin)merge.o ;

#-- end of application_header
#-- start of application

$(bin)gaudi_merge${application_suffix} :: $(bin)merge.o $(use_stamps) $(gaudi_merge_stamps) $(gaudi_mergestamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)merge.o $(cmt_installarea_linkopts) $(gaudi_merge_use_linkopts) $(gaudi_mergelinkopts) && mv -f $(@).new $(@)

ifneq ($(strip $(use_stamps)),)
# Work around Make errors if stamps files do not exist
$(use_stamps) :
endif

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/bin
gaudi_mergeinstallname = gaudi_merge${application_suffix}

gaudi_merge :: gaudi_mergeinstall ;

install :: gaudi_mergeinstall ;

gaudi_mergeinstall :: $(install_dir)/$(gaudi_mergeinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(gaudi_mergeinstallname) :: $(bin)$(gaudi_mergeinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(gaudi_mergeinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##gaudi_mergeclean :: gaudi_mergeuninstall

uninstall :: gaudi_mergeuninstall ;

gaudi_mergeuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(gaudi_mergeinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (gaudi_merge.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),gaudi_mergeclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)merge.d

$(bin)$(binobj)merge.d :

$(bin)$(binobj)merge.o : $(cmt_final_setup_gaudi_merge)

$(bin)$(binobj)merge.o : ../merge/merge.cpp
	$(cpp_echo) ../merge/merge.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(gaudi_merge_pp_cppflags) $(app_gaudi_merge_pp_cppflags) $(merge_pp_cppflags) $(use_cppflags) $(gaudi_merge_cppflags) $(app_gaudi_merge_cppflags) $(merge_cppflags) $(merge_cpp_cppflags) -I../merge ../merge/merge.cpp
endif
endif

else
$(bin)gaudi_merge_dependencies.make : $(merge_cpp_dependencies)

$(bin)gaudi_merge_dependencies.make : ../merge/merge.cpp

$(bin)$(binobj)merge.o : $(merge_cpp_dependencies)
	$(cpp_echo) ../merge/merge.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(gaudi_merge_pp_cppflags) $(app_gaudi_merge_pp_cppflags) $(merge_pp_cppflags) $(use_cppflags) $(gaudi_merge_cppflags) $(app_gaudi_merge_cppflags) $(merge_cppflags) $(merge_cpp_cppflags) -I../merge ../merge/merge.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: gaudi_mergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(gaudi_merge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

gaudi_mergeclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application gaudi_merge
	-$(cleanup_silent) cd $(bin); /bin/rm -f gaudi_merge${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects gaudi_merge
	-$(cleanup_silent) /bin/rm -f $(bin)merge.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)merge.o) $(patsubst %.o,%.dep,$(bin)merge.o) $(patsubst %.o,%.d.stamp,$(bin)merge.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf gaudi_merge_deps gaudi_merge_dependencies.make
#-- end of cleanup_objects ------
