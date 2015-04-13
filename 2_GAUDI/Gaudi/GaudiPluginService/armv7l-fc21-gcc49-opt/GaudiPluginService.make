#-- start of make_header -----------------

#====================================
#  Library GaudiPluginService
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

cmt_GaudiPluginService_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPluginService_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPluginService

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_GaudiPluginService = $(GaudiPluginService_tag)_GaudiPluginService.make
cmt_local_tagfile_GaudiPluginService = $(bin)$(GaudiPluginService_tag)_GaudiPluginService.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_GaudiPluginService = $(GaudiPluginService_tag).make
cmt_local_tagfile_GaudiPluginService = $(bin)$(GaudiPluginService_tag).make

endif

include $(cmt_local_tagfile_GaudiPluginService)
#-include $(cmt_local_tagfile_GaudiPluginService)

ifdef cmt_GaudiPluginService_has_target_tag

cmt_final_setup_GaudiPluginService = $(bin)setup_GaudiPluginService.make
cmt_dependencies_in_GaudiPluginService = $(bin)dependencies_GaudiPluginService.in
#cmt_final_setup_GaudiPluginService = $(bin)GaudiPluginService_GaudiPluginServicesetup.make
cmt_local_GaudiPluginService_makefile = $(bin)GaudiPluginService.make

else

cmt_final_setup_GaudiPluginService = $(bin)setup.make
cmt_dependencies_in_GaudiPluginService = $(bin)dependencies.in
#cmt_final_setup_GaudiPluginService = $(bin)GaudiPluginServicesetup.make
cmt_local_GaudiPluginService_makefile = $(bin)GaudiPluginService.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPluginServicesetup.make

#GaudiPluginService :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPluginService'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPluginService/
#GaudiPluginService::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiPluginServicelibname   = $(bin)$(library_prefix)GaudiPluginService$(library_suffix)
GaudiPluginServicelib       = $(GaudiPluginServicelibname).a
GaudiPluginServicestamp     = $(bin)GaudiPluginService.stamp
GaudiPluginServiceshstamp   = $(bin)GaudiPluginService.shstamp

GaudiPluginService :: dirs  GaudiPluginServiceLIB
	$(echo) "GaudiPluginService ok"

cmt_GaudiPluginService_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPluginService_has_prototypes

GaudiPluginServiceprototype :  ;

endif

GaudiPluginServicecompile : $(bin)PluginService.o $(bin)capi_pluginservice.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiPluginServiceLIB :: $(GaudiPluginServicelib) $(GaudiPluginServiceshstamp)
GaudiPluginServiceLIB :: $(GaudiPluginServiceshstamp)
	$(echo) "GaudiPluginService : library ok"

$(GaudiPluginServicelib) :: $(bin)PluginService.o $(bin)capi_pluginservice.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiPluginServicelib) $?
	$(lib_silent) $(ranlib) $(GaudiPluginServicelib)
	$(lib_silent) cat /dev/null >$(GaudiPluginServicestamp)

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

$(GaudiPluginServicelibname).$(shlibsuffix) :: $(bin)PluginService.o $(bin)capi_pluginservice.o $(use_requirements) $(GaudiPluginServicestamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)PluginService.o $(bin)capi_pluginservice.o $(GaudiPluginService_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiPluginServicestamp) && \
	  cat /dev/null >$(GaudiPluginServiceshstamp)

$(GaudiPluginServiceshstamp) :: $(GaudiPluginServicelibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiPluginServicelibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiPluginServicestamp) && \
	  cat /dev/null >$(GaudiPluginServiceshstamp) ; fi

GaudiPluginServiceclean ::
	$(cleanup_echo) objects GaudiPluginService
	$(cleanup_silent) /bin/rm -f $(bin)PluginService.o $(bin)capi_pluginservice.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PluginService.o $(bin)capi_pluginservice.o) $(patsubst %.o,%.dep,$(bin)PluginService.o $(bin)capi_pluginservice.o) $(patsubst %.o,%.d.stamp,$(bin)PluginService.o $(bin)capi_pluginservice.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiPluginService_deps GaudiPluginService_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiPluginServiceinstallname = $(library_prefix)GaudiPluginService$(library_suffix).$(shlibsuffix)

GaudiPluginService :: GaudiPluginServiceinstall ;

install :: GaudiPluginServiceinstall ;

GaudiPluginServiceinstall :: $(install_dir)/$(GaudiPluginServiceinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiPluginServiceinstallname) :: $(bin)$(GaudiPluginServiceinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPluginServiceinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiPluginServiceclean :: GaudiPluginServiceuninstall

uninstall :: GaudiPluginServiceuninstall ;

GaudiPluginServiceuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPluginServiceinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPluginServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PluginService.d

$(bin)$(binobj)PluginService.d :

$(bin)$(binobj)PluginService.o : $(cmt_final_setup_GaudiPluginService)

$(bin)$(binobj)PluginService.o : $(src)PluginService.cpp
	$(cpp_echo) $(src)PluginService.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPluginService_pp_cppflags) $(lib_GaudiPluginService_pp_cppflags) $(PluginService_pp_cppflags) $(use_cppflags) $(GaudiPluginService_cppflags) $(lib_GaudiPluginService_cppflags) $(PluginService_cppflags) $(PluginService_cpp_cppflags)  $(src)PluginService.cpp
endif
endif

else
$(bin)GaudiPluginService_dependencies.make : $(PluginService_cpp_dependencies)

$(bin)GaudiPluginService_dependencies.make : $(src)PluginService.cpp

$(bin)$(binobj)PluginService.o : $(PluginService_cpp_dependencies)
	$(cpp_echo) $(src)PluginService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPluginService_pp_cppflags) $(lib_GaudiPluginService_pp_cppflags) $(PluginService_pp_cppflags) $(use_cppflags) $(GaudiPluginService_cppflags) $(lib_GaudiPluginService_cppflags) $(PluginService_cppflags) $(PluginService_cpp_cppflags)  $(src)PluginService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPluginServiceclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)capi_pluginservice.d

$(bin)$(binobj)capi_pluginservice.d :

$(bin)$(binobj)capi_pluginservice.o : $(cmt_final_setup_GaudiPluginService)

$(bin)$(binobj)capi_pluginservice.o : $(src)capi_pluginservice.cpp
	$(cpp_echo) $(src)capi_pluginservice.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPluginService_pp_cppflags) $(lib_GaudiPluginService_pp_cppflags) $(capi_pluginservice_pp_cppflags) $(use_cppflags) $(GaudiPluginService_cppflags) $(lib_GaudiPluginService_cppflags) $(capi_pluginservice_cppflags) $(capi_pluginservice_cpp_cppflags)  $(src)capi_pluginservice.cpp
endif
endif

else
$(bin)GaudiPluginService_dependencies.make : $(capi_pluginservice_cpp_dependencies)

$(bin)GaudiPluginService_dependencies.make : $(src)capi_pluginservice.cpp

$(bin)$(binobj)capi_pluginservice.o : $(capi_pluginservice_cpp_dependencies)
	$(cpp_echo) $(src)capi_pluginservice.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPluginService_pp_cppflags) $(lib_GaudiPluginService_pp_cppflags) $(capi_pluginservice_pp_cppflags) $(use_cppflags) $(GaudiPluginService_cppflags) $(lib_GaudiPluginService_cppflags) $(capi_pluginservice_cppflags) $(capi_pluginservice_cpp_cppflags)  $(src)capi_pluginservice.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiPluginServiceclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPluginService.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPluginServiceclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiPluginService
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiPluginService$(library_suffix).a $(library_prefix)GaudiPluginService$(library_suffix).$(shlibsuffix) GaudiPluginService.stamp GaudiPluginService.shstamp
#-- end of cleanup_library ---------------
