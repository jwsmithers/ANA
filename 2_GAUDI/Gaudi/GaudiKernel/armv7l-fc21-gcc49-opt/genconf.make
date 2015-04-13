#-- start of make_header -----------------

#====================================
#  Application genconf
#
#   Generated Mon Feb 16 19:31:28 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_genconf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_genconf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_genconf

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_genconf = $(GaudiKernel_tag)_genconf.make
cmt_local_tagfile_genconf = $(bin)$(GaudiKernel_tag)_genconf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_genconf = $(GaudiKernel_tag).make
cmt_local_tagfile_genconf = $(bin)$(GaudiKernel_tag).make

endif

include $(cmt_local_tagfile_genconf)
#-include $(cmt_local_tagfile_genconf)

ifdef cmt_genconf_has_target_tag

cmt_final_setup_genconf = $(bin)setup_genconf.make
cmt_dependencies_in_genconf = $(bin)dependencies_genconf.in
#cmt_final_setup_genconf = $(bin)GaudiKernel_genconfsetup.make
cmt_local_genconf_makefile = $(bin)genconf.make

else

cmt_final_setup_genconf = $(bin)setup.make
cmt_dependencies_in_genconf = $(bin)dependencies.in
#cmt_final_setup_genconf = $(bin)GaudiKernelsetup.make
cmt_local_genconf_makefile = $(bin)genconf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make

#genconf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'genconf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = genconf/
#genconf::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

genconf :: dirs  $(bin)genconf${application_suffix}
	$(echo) "genconf ok"

cmt_genconf_has_prototypes = 1

#--------------------------------------

ifdef cmt_genconf_has_prototypes

genconfprototype :  ;

endif

genconfcompile : $(bin)genconf.o ;

#-- end of application_header
#-- start of application

$(bin)genconf${application_suffix} :: $(bin)genconf.o $(use_stamps) $(genconf_stamps) $(genconfstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)genconf.o $(cmt_installarea_linkopts) $(genconf_use_linkopts) $(genconflinkopts) && mv -f $(@).new $(@)

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
genconfinstallname = genconf${application_suffix}

genconf :: genconfinstall ;

install :: genconfinstall ;

genconfinstall :: $(install_dir)/$(genconfinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(genconfinstallname) :: $(bin)$(genconfinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(genconfinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##genconfclean :: genconfuninstall

uninstall :: genconfuninstall ;

genconfuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(genconfinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (genconf.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),genconfclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)genconf.d

$(bin)$(binobj)genconf.d :

$(bin)$(binobj)genconf.o : $(cmt_final_setup_genconf)

$(bin)$(binobj)genconf.o : $(src)Util/genconf.cpp
	$(cpp_echo) $(src)Util/genconf.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(genconf_pp_cppflags) $(app_genconf_pp_cppflags) $(genconf_pp_cppflags) $(use_cppflags) $(genconf_cppflags) $(app_genconf_cppflags) $(genconf_cppflags) $(genconf_cpp_cppflags) -I../src/Util $(src)Util/genconf.cpp
endif
endif

else
$(bin)genconf_dependencies.make : $(genconf_cpp_dependencies)

$(bin)genconf_dependencies.make : $(src)Util/genconf.cpp

$(bin)$(binobj)genconf.o : $(genconf_cpp_dependencies)
	$(cpp_echo) $(src)Util/genconf.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(genconf_pp_cppflags) $(app_genconf_pp_cppflags) $(genconf_pp_cppflags) $(use_cppflags) $(genconf_cppflags) $(app_genconf_cppflags) $(genconf_cppflags) $(genconf_cpp_cppflags) -I../src/Util $(src)Util/genconf.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: genconfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(genconf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

genconfclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application genconf
	-$(cleanup_silent) cd $(bin); /bin/rm -f genconf${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects genconf
	-$(cleanup_silent) /bin/rm -f $(bin)genconf.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)genconf.o) $(patsubst %.o,%.dep,$(bin)genconf.o) $(patsubst %.o,%.d.stamp,$(bin)genconf.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf genconf_deps genconf_dependencies.make
#-- end of cleanup_objects ------
