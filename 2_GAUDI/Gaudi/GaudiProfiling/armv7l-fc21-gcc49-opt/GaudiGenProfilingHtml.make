#-- start of make_header -----------------

#====================================
#  Application GaudiGenProfilingHtml
#
#   Generated Mon Feb 16 20:05:10 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGenProfilingHtml_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGenProfilingHtml_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGenProfilingHtml

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGenProfilingHtml = $(GaudiProfiling_tag)_GaudiGenProfilingHtml.make
cmt_local_tagfile_GaudiGenProfilingHtml = $(bin)$(GaudiProfiling_tag)_GaudiGenProfilingHtml.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGenProfilingHtml = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiGenProfilingHtml = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiGenProfilingHtml)
#-include $(cmt_local_tagfile_GaudiGenProfilingHtml)

ifdef cmt_GaudiGenProfilingHtml_has_target_tag

cmt_final_setup_GaudiGenProfilingHtml = $(bin)setup_GaudiGenProfilingHtml.make
cmt_dependencies_in_GaudiGenProfilingHtml = $(bin)dependencies_GaudiGenProfilingHtml.in
#cmt_final_setup_GaudiGenProfilingHtml = $(bin)GaudiProfiling_GaudiGenProfilingHtmlsetup.make
cmt_local_GaudiGenProfilingHtml_makefile = $(bin)GaudiGenProfilingHtml.make

else

cmt_final_setup_GaudiGenProfilingHtml = $(bin)setup.make
cmt_dependencies_in_GaudiGenProfilingHtml = $(bin)dependencies.in
#cmt_final_setup_GaudiGenProfilingHtml = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiGenProfilingHtml_makefile = $(bin)GaudiGenProfilingHtml.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiGenProfilingHtml :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGenProfilingHtml'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGenProfilingHtml/
#GaudiGenProfilingHtml::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

GaudiGenProfilingHtml :: dirs  $(bin)GaudiGenProfilingHtml${application_suffix}
	$(echo) "GaudiGenProfilingHtml ok"

cmt_GaudiGenProfilingHtml_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGenProfilingHtml_has_prototypes

GaudiGenProfilingHtmlprototype :  ;

endif

GaudiGenProfilingHtmlcompile : $(bin)pfm_gen_analysis.o ;

#-- end of application_header
#-- start of application

$(bin)GaudiGenProfilingHtml${application_suffix} :: $(bin)pfm_gen_analysis.o $(use_stamps) $(GaudiGenProfilingHtml_stamps) $(GaudiGenProfilingHtmlstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)pfm_gen_analysis.o $(cmt_installarea_linkopts) $(GaudiGenProfilingHtml_use_linkopts) $(GaudiGenProfilingHtmllinkopts) && mv -f $(@).new $(@)

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
GaudiGenProfilingHtmlinstallname = GaudiGenProfilingHtml${application_suffix}

GaudiGenProfilingHtml :: GaudiGenProfilingHtmlinstall ;

install :: GaudiGenProfilingHtmlinstall ;

GaudiGenProfilingHtmlinstall :: $(install_dir)/$(GaudiGenProfilingHtmlinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiGenProfilingHtmlinstallname) :: $(bin)$(GaudiGenProfilingHtmlinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGenProfilingHtmlinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiGenProfilingHtmlclean :: GaudiGenProfilingHtmluninstall

uninstall :: GaudiGenProfilingHtmluninstall ;

GaudiGenProfilingHtmluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGenProfilingHtmlinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (GaudiGenProfilingHtml.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGenProfilingHtmlclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)pfm_gen_analysis.d

$(bin)$(binobj)pfm_gen_analysis.d :

$(bin)$(binobj)pfm_gen_analysis.o : $(cmt_final_setup_GaudiGenProfilingHtml)

$(bin)$(binobj)pfm_gen_analysis.o : $(src)app/pfm_gen_analysis.cpp
	$(cpp_echo) $(src)app/pfm_gen_analysis.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGenProfilingHtml_pp_cppflags) $(app_GaudiGenProfilingHtml_pp_cppflags) $(pfm_gen_analysis_pp_cppflags) $(use_cppflags) $(GaudiGenProfilingHtml_cppflags) $(app_GaudiGenProfilingHtml_cppflags) $(pfm_gen_analysis_cppflags) $(pfm_gen_analysis_cpp_cppflags) -I../src/app $(src)app/pfm_gen_analysis.cpp
endif
endif

else
$(bin)GaudiGenProfilingHtml_dependencies.make : $(pfm_gen_analysis_cpp_dependencies)

$(bin)GaudiGenProfilingHtml_dependencies.make : $(src)app/pfm_gen_analysis.cpp

$(bin)$(binobj)pfm_gen_analysis.o : $(pfm_gen_analysis_cpp_dependencies)
	$(cpp_echo) $(src)app/pfm_gen_analysis.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGenProfilingHtml_pp_cppflags) $(app_GaudiGenProfilingHtml_pp_cppflags) $(pfm_gen_analysis_pp_cppflags) $(use_cppflags) $(GaudiGenProfilingHtml_cppflags) $(app_GaudiGenProfilingHtml_cppflags) $(pfm_gen_analysis_cppflags) $(pfm_gen_analysis_cpp_cppflags) -I../src/app $(src)app/pfm_gen_analysis.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: GaudiGenProfilingHtmlclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGenProfilingHtml.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGenProfilingHtmlclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application GaudiGenProfilingHtml
	-$(cleanup_silent) cd $(bin); /bin/rm -f GaudiGenProfilingHtml${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects GaudiGenProfilingHtml
	-$(cleanup_silent) /bin/rm -f $(bin)pfm_gen_analysis.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)pfm_gen_analysis.o) $(patsubst %.o,%.dep,$(bin)pfm_gen_analysis.o) $(patsubst %.o,%.d.stamp,$(bin)pfm_gen_analysis.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiGenProfilingHtml_deps GaudiGenProfilingHtml_dependencies.make
#-- end of cleanup_objects ------
