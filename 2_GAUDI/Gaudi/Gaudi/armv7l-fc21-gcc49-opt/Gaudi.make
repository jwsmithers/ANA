#-- start of make_header -----------------

#====================================
#  Application Gaudi
#
#   Generated Mon Feb 16 20:49:57 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Gaudi_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Gaudi_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Gaudi

Gaudi_tag = $(tag)

#cmt_local_tagfile_Gaudi = $(Gaudi_tag)_Gaudi.make
cmt_local_tagfile_Gaudi = $(bin)$(Gaudi_tag)_Gaudi.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Gaudi_tag = $(tag)

#cmt_local_tagfile_Gaudi = $(Gaudi_tag).make
cmt_local_tagfile_Gaudi = $(bin)$(Gaudi_tag).make

endif

include $(cmt_local_tagfile_Gaudi)
#-include $(cmt_local_tagfile_Gaudi)

ifdef cmt_Gaudi_has_target_tag

cmt_final_setup_Gaudi = $(bin)setup_Gaudi.make
cmt_dependencies_in_Gaudi = $(bin)dependencies_Gaudi.in
#cmt_final_setup_Gaudi = $(bin)Gaudi_Gaudisetup.make
cmt_local_Gaudi_makefile = $(bin)Gaudi.make

else

cmt_final_setup_Gaudi = $(bin)setup.make
cmt_dependencies_in_Gaudi = $(bin)dependencies.in
#cmt_final_setup_Gaudi = $(bin)Gaudisetup.make
cmt_local_Gaudi_makefile = $(bin)Gaudi.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Gaudisetup.make

#Gaudi :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Gaudi'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Gaudi/
#Gaudi::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Gaudi :: dirs  $(bin)Gaudi${application_suffix}
	$(echo) "Gaudi ok"

cmt_Gaudi_has_prototypes = 1

#--------------------------------------

ifdef cmt_Gaudi_has_prototypes

Gaudiprototype :  ;

endif

Gaudicompile : $(bin)main.o ;

#-- end of application_header
#-- start of application

$(bin)Gaudi${application_suffix} :: $(bin)main.o $(use_stamps) $(Gaudi_stamps) $(Gaudistamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)main.o $(cmt_installarea_linkopts) $(Gaudi_use_linkopts) $(Gaudilinkopts) && mv -f $(@).new $(@)

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
Gaudiinstallname = Gaudi${application_suffix}

Gaudi :: Gaudiinstall ;

install :: Gaudiinstall ;

Gaudiinstall :: $(install_dir)/$(Gaudiinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Gaudiinstallname) :: $(bin)$(Gaudiinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Gaudiinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Gaudiclean :: Gaudiuninstall

uninstall :: Gaudiuninstall ;

Gaudiuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Gaudiinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Gaudi.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),Gaudiclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)main.d

$(bin)$(binobj)main.d :

$(bin)$(binobj)main.o : $(cmt_final_setup_Gaudi)

$(bin)$(binobj)main.o : $(src)main.cpp
	$(cpp_echo) $(src)main.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(Gaudi_pp_cppflags) $(app_Gaudi_pp_cppflags) $(main_pp_cppflags) $(use_cppflags) $(Gaudi_cppflags) $(app_Gaudi_cppflags) $(main_cppflags) $(main_cpp_cppflags)  $(src)main.cpp
endif
endif

else
$(bin)Gaudi_dependencies.make : $(main_cpp_dependencies)

$(bin)Gaudi_dependencies.make : $(src)main.cpp

$(bin)$(binobj)main.o : $(main_cpp_dependencies)
	$(cpp_echo) $(src)main.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Gaudi_pp_cppflags) $(app_Gaudi_pp_cppflags) $(main_pp_cppflags) $(use_cppflags) $(Gaudi_cppflags) $(app_Gaudi_cppflags) $(main_cppflags) $(main_cpp_cppflags)  $(src)main.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Gaudiclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Gaudi.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Gaudiclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Gaudi
	-$(cleanup_silent) cd $(bin); /bin/rm -f Gaudi${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Gaudi
	-$(cleanup_silent) /bin/rm -f $(bin)main.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)main.o) $(patsubst %.o,%.dep,$(bin)main.o) $(patsubst %.o,%.d.stamp,$(bin)main.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Gaudi_deps Gaudi_dependencies.make
#-- end of cleanup_objects ------
