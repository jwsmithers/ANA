#-- start of make_header -----------------

#====================================
#  Application listcomponents
#
#   Generated Mon Feb 16 19:31:10 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_listcomponents_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_listcomponents_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_listcomponents

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_listcomponents = $(GaudiPluginService_tag)_listcomponents.make
cmt_local_tagfile_listcomponents = $(bin)$(GaudiPluginService_tag)_listcomponents.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_listcomponents = $(GaudiPluginService_tag).make
cmt_local_tagfile_listcomponents = $(bin)$(GaudiPluginService_tag).make

endif

include $(cmt_local_tagfile_listcomponents)
#-include $(cmt_local_tagfile_listcomponents)

ifdef cmt_listcomponents_has_target_tag

cmt_final_setup_listcomponents = $(bin)setup_listcomponents.make
cmt_dependencies_in_listcomponents = $(bin)dependencies_listcomponents.in
#cmt_final_setup_listcomponents = $(bin)GaudiPluginService_listcomponentssetup.make
cmt_local_listcomponents_makefile = $(bin)listcomponents.make

else

cmt_final_setup_listcomponents = $(bin)setup.make
cmt_dependencies_in_listcomponents = $(bin)dependencies.in
#cmt_final_setup_listcomponents = $(bin)GaudiPluginServicesetup.make
cmt_local_listcomponents_makefile = $(bin)listcomponents.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPluginServicesetup.make

#listcomponents :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'listcomponents'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = listcomponents/
#listcomponents::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

listcomponents :: dirs  $(bin)listcomponents${application_suffix}
	$(echo) "listcomponents ok"

cmt_listcomponents_has_prototypes = 1

#--------------------------------------

ifdef cmt_listcomponents_has_prototypes

listcomponentsprototype :  ;

endif

listcomponentscompile : $(bin)listcomponents.o ;

#-- end of application_header
#-- start of application

$(bin)listcomponents${application_suffix} :: $(bin)listcomponents.o $(use_stamps) $(listcomponents_stamps) $(listcomponentsstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)listcomponents.o $(cmt_installarea_linkopts) $(listcomponents_use_linkopts) $(listcomponentslinkopts) && mv -f $(@).new $(@)

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
listcomponentsinstallname = listcomponents${application_suffix}

listcomponents :: listcomponentsinstall ;

install :: listcomponentsinstall ;

listcomponentsinstall :: $(install_dir)/$(listcomponentsinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(listcomponentsinstallname) :: $(bin)$(listcomponentsinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(listcomponentsinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##listcomponentsclean :: listcomponentsuninstall

uninstall :: listcomponentsuninstall ;

listcomponentsuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(listcomponentsinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (listcomponents.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),listcomponentsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)listcomponents.d

$(bin)$(binobj)listcomponents.d :

$(bin)$(binobj)listcomponents.o : $(cmt_final_setup_listcomponents)

$(bin)$(binobj)listcomponents.o : $(src)listcomponents.cpp
	$(cpp_echo) $(src)listcomponents.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(listcomponents_pp_cppflags) $(app_listcomponents_pp_cppflags) $(listcomponents_pp_cppflags) $(use_cppflags) $(listcomponents_cppflags) $(app_listcomponents_cppflags) $(listcomponents_cppflags) $(listcomponents_cpp_cppflags)  $(src)listcomponents.cpp
endif
endif

else
$(bin)listcomponents_dependencies.make : $(listcomponents_cpp_dependencies)

$(bin)listcomponents_dependencies.make : $(src)listcomponents.cpp

$(bin)$(binobj)listcomponents.o : $(listcomponents_cpp_dependencies)
	$(cpp_echo) $(src)listcomponents.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(listcomponents_pp_cppflags) $(app_listcomponents_pp_cppflags) $(listcomponents_pp_cppflags) $(use_cppflags) $(listcomponents_cppflags) $(app_listcomponents_cppflags) $(listcomponents_cppflags) $(listcomponents_cpp_cppflags)  $(src)listcomponents.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: listcomponentsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(listcomponents.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

listcomponentsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application listcomponents
	-$(cleanup_silent) cd $(bin); /bin/rm -f listcomponents${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects listcomponents
	-$(cleanup_silent) /bin/rm -f $(bin)listcomponents.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)listcomponents.o) $(patsubst %.o,%.dep,$(bin)listcomponents.o) $(patsubst %.o,%.d.stamp,$(bin)listcomponents.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf listcomponents_deps listcomponents_dependencies.make
#-- end of cleanup_objects ------
