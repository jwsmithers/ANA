#-- start of make_header -----------------

#====================================
#  Application Allocator
#
#   Generated Mon Feb 16 20:50:17 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Allocator_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Allocator_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Allocator

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_Allocator = $(GaudiExamples_tag)_Allocator.make
cmt_local_tagfile_Allocator = $(bin)$(GaudiExamples_tag)_Allocator.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_Allocator = $(GaudiExamples_tag).make
cmt_local_tagfile_Allocator = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_Allocator)
#-include $(cmt_local_tagfile_Allocator)

ifdef cmt_Allocator_has_target_tag

cmt_final_setup_Allocator = $(bin)setup_Allocator.make
cmt_dependencies_in_Allocator = $(bin)dependencies_Allocator.in
#cmt_final_setup_Allocator = $(bin)GaudiExamples_Allocatorsetup.make
cmt_local_Allocator_makefile = $(bin)Allocator.make

else

cmt_final_setup_Allocator = $(bin)setup.make
cmt_dependencies_in_Allocator = $(bin)dependencies.in
#cmt_final_setup_Allocator = $(bin)GaudiExamplessetup.make
cmt_local_Allocator_makefile = $(bin)Allocator.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#Allocator :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Allocator'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Allocator/
#Allocator::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of application_header

Allocator :: dirs  $(bin)Allocator${application_suffix}
	$(echo) "Allocator ok"

cmt_Allocator_has_prototypes = 1

#--------------------------------------

ifdef cmt_Allocator_has_prototypes

Allocatorprototype :  ;

endif

Allocatorcompile : $(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o ;

#-- end of application_header
#-- start of application

$(bin)Allocator${application_suffix} :: $(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o $(use_stamps) $(Allocator_stamps) $(Allocatorstamps) $(use_requirements)
	$(link_echo) "application $@"
	$(link_silent) $(cpplink) -o $(@).new $(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o $(cmt_installarea_linkopts) $(Allocator_use_linkopts) $(Allocatorlinkopts) && mv -f $(@).new $(@)

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
Allocatorinstallname = Allocator${application_suffix}

Allocator :: Allocatorinstall ;

install :: Allocatorinstall ;

Allocatorinstall :: $(install_dir)/$(Allocatorinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(Allocatorinstallname) :: $(bin)$(Allocatorinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Allocatorinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##Allocatorclean :: Allocatoruninstall

uninstall :: Allocatoruninstall ;

Allocatoruninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(Allocatorinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#	@echo "------> (Allocator.make) Removing installed files"
#-- end of application
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),Allocatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyClass1.d

$(bin)$(binobj)MyClass1.d :

$(bin)$(binobj)MyClass1.o : $(cmt_final_setup_Allocator)

$(bin)$(binobj)MyClass1.o : $(src)Allocator/MyClass1.cpp
	$(cpp_echo) $(src)Allocator/MyClass1.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(MyClass1_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(MyClass1_cppflags) $(MyClass1_cpp_cppflags) -I../src/Allocator $(src)Allocator/MyClass1.cpp
endif
endif

else
$(bin)Allocator_dependencies.make : $(MyClass1_cpp_dependencies)

$(bin)Allocator_dependencies.make : $(src)Allocator/MyClass1.cpp

$(bin)$(binobj)MyClass1.o : $(MyClass1_cpp_dependencies)
	$(cpp_echo) $(src)Allocator/MyClass1.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(MyClass1_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(MyClass1_cppflags) $(MyClass1_cpp_cppflags) -I../src/Allocator $(src)Allocator/MyClass1.cpp

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),Allocatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Allocator.d

$(bin)$(binobj)Allocator.d :

$(bin)$(binobj)Allocator.o : $(cmt_final_setup_Allocator)

$(bin)$(binobj)Allocator.o : $(src)Allocator/Allocator.cpp
	$(cpp_echo) $(src)Allocator/Allocator.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(Allocator_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(Allocator_cppflags) $(Allocator_cpp_cppflags) -I../src/Allocator $(src)Allocator/Allocator.cpp
endif
endif

else
$(bin)Allocator_dependencies.make : $(Allocator_cpp_dependencies)

$(bin)Allocator_dependencies.make : $(src)Allocator/Allocator.cpp

$(bin)$(binobj)Allocator.o : $(Allocator_cpp_dependencies)
	$(cpp_echo) $(src)Allocator/Allocator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(Allocator_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(Allocator_cppflags) $(Allocator_cpp_cppflags) -I../src/Allocator $(src)Allocator/Allocator.cpp

endif

#-- end of cpp ------
#-- start of cpp ------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),Allocatorclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyClass1A.d

$(bin)$(binobj)MyClass1A.d :

$(bin)$(binobj)MyClass1A.o : $(cmt_final_setup_Allocator)

$(bin)$(binobj)MyClass1A.o : $(src)Allocator/MyClass1A.cpp
	$(cpp_echo) $(src)Allocator/MyClass1A.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(MyClass1A_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(MyClass1A_cppflags) $(MyClass1A_cpp_cppflags) -I../src/Allocator $(src)Allocator/MyClass1A.cpp
endif
endif

else
$(bin)Allocator_dependencies.make : $(MyClass1A_cpp_dependencies)

$(bin)Allocator_dependencies.make : $(src)Allocator/MyClass1A.cpp

$(bin)$(binobj)MyClass1A.o : $(MyClass1A_cpp_dependencies)
	$(cpp_echo) $(src)Allocator/MyClass1A.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(Allocator_pp_cppflags) $(app_Allocator_pp_cppflags) $(MyClass1A_pp_cppflags) $(use_cppflags) $(Allocator_cppflags) $(app_Allocator_cppflags) $(MyClass1A_cppflags) $(MyClass1A_cpp_cppflags) -I../src/Allocator $(src)Allocator/MyClass1A.cpp

endif

#-- end of cpp ------
#-- start of cleanup_header --------------

clean :: Allocatorclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Allocator.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Allocatorclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_application ------
	$(cleanup_echo) application Allocator
	-$(cleanup_silent) cd $(bin); /bin/rm -f Allocator${application_suffix}
#-- end of cleanup_application ------
#-- start of cleanup_objects ------
	$(cleanup_echo) objects Allocator
	-$(cleanup_silent) /bin/rm -f $(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o
	-$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o) $(patsubst %.o,%.dep,$(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o) $(patsubst %.o,%.d.stamp,$(bin)MyClass1.o $(bin)Allocator.o $(bin)MyClass1A.o)
	-$(cleanup_silent) cd $(bin); /bin/rm -rf Allocator_deps Allocator_dependencies.make
#-- end of cleanup_objects ------
