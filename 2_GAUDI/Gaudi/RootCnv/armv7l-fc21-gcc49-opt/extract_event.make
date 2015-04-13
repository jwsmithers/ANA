#-- start of make_header -----------------

#====================================
#  Application extract_event
#
#   Generated Mon Feb 16 20:00:37 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_extract_event_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_extract_event_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_extract_event

RootCnv_tag = $(tag)

#cmt_local_tagfile_extract_event = $(RootCnv_tag)_extract_event.make
cmt_local_tagfile_extract_event = $(bin)$(RootCnv_tag)_extract_event.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_extract_event = $(RootCnv_tag).make
cmt_local_tagfile_extract_event = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_extract_event)
#-include $(cmt_local_tagfile_extract_event)

ifdef cmt_extract_event_has_target_tag

cmt_final_setup_extract_event = $(bin)setup_extract_event.make
cmt_dependencies_in_extract_event = $(bin)dependencies_extract_event.in
#cmt_final_setup_extract_event = $(bin)RootCnv_extract_eventsetup.make
cmt_local_extract_event_makefile = $(bin)extract_event.make

else

cmt_final_setup_extract_event = $(bin)setup.make
cmt_dependencies_in_extract_event = $(bin)dependencies.in
#cmt_final_setup_extract_event = $(bin)RootCnvsetup.make
cmt_local_extract_event_makefile = $(bin)extract_event.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#extract_event :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'extract_event'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = extract_event/
#extract_event::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

extract_event :: dirs  $(bin)extract_event${application_suffix}
	$(echo) "extract_event ok"

cmt_extract_event_has_prototypes = 1

#--------------------------------------

ifdef cmt_extract_event_has_prototypes

extract_eventprototype :  ;

endif

extract_eventcompile : $(bin)extractEvt.o ;

#-- end of application_header
#-- start of application

$(bin)extract_event${application_suffix} :: $(bin)extractEvt.o $(use_stamps) $(extract_event_stamps) $(extract_eventstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)extractEvt.o $(cmt_installarea_linkopts) $(extract_event_use_linkopts) $(extract_eventlinkopts) && mv -f $(@).new $(@)

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
extract_eventinstallname = extract_event${application_suffix}

extract_event :: extract_eventinstall ;

install :: extract_eventinstall ;

extract_eventinstall :: $(install_dir)/$(extract_eventinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(extract_eventinstallname) :: $(bin)$(extract_eventinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(extract_eventinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##extract_eventclean :: extract_eventuninstall

uninstall :: extract_eventuninstall ;

extract_eventuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(extract_eventinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (extract_event.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),extract_eventclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)extractEvt.d

$(bin)$(binobj)extractEvt.d :

$(bin)$(binobj)extractEvt.o : $(cmt_final_setup_extract_event)

$(bin)$(binobj)extractEvt.o : ../merge/extractEvt.cpp
	$(cpp_echo) ../merge/extractEvt.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(extract_event_pp_cppflags) $(app_extract_event_pp_cppflags) $(extractEvt_pp_cppflags) $(use_cppflags) $(extract_event_cppflags) $(app_extract_event_cppflags) $(extractEvt_cppflags) $(extractEvt_cpp_cppflags) -I../merge ../merge/extractEvt.cpp
endif
endif

else
$(bin)extract_event_dependencies.make : $(extractEvt_cpp_dependencies)

$(bin)extract_event_dependencies.make : ../merge/extractEvt.cpp

$(bin)$(binobj)extractEvt.o : $(extractEvt_cpp_dependencies)
	$(cpp_echo) ../merge/extractEvt.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(extract_event_pp_cppflags) $(app_extract_event_pp_cppflags) $(extractEvt_pp_cppflags) $(use_cppflags) $(extract_event_cppflags) $(app_extract_event_cppflags) $(extractEvt_cppflags) $(extractEvt_cpp_cppflags) -I../merge ../merge/extractEvt.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: extract_eventclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(extract_event.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

extract_eventclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application extract_event
	-$(cleanup_silent) cd $(bin); /bin/rm -f extract_event${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects extract_event
	-$(cleanup_silent) /bin/rm -f $(bin)extractEvt.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)extractEvt.o) $(patsubst %.o,%.dep,$(bin)extractEvt.o) $(patsubst %.o,%.d.stamp,$(bin)extractEvt.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf extract_event_deps extract_event_dependencies.make
#-- end of cleanup_objects ------
