#-- start of make_header -----------------

#====================================
#  Library GaudiProfiling
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

cmt_GaudiProfiling_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfiling_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfiling

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfiling = $(GaudiProfiling_tag)_GaudiProfiling.make
cmt_local_tagfile_GaudiProfiling = $(bin)$(GaudiProfiling_tag)_GaudiProfiling.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfiling = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfiling = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfiling)
#-include $(cmt_local_tagfile_GaudiProfiling)

ifdef cmt_GaudiProfiling_has_target_tag

cmt_final_setup_GaudiProfiling = $(bin)setup_GaudiProfiling.make
cmt_dependencies_in_GaudiProfiling = $(bin)dependencies_GaudiProfiling.in
#cmt_final_setup_GaudiProfiling = $(bin)GaudiProfiling_GaudiProfilingsetup.make
cmt_local_GaudiProfiling_makefile = $(bin)GaudiProfiling.make

else

cmt_final_setup_GaudiProfiling = $(bin)setup.make
cmt_dependencies_in_GaudiProfiling = $(bin)dependencies.in
#cmt_final_setup_GaudiProfiling = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfiling_makefile = $(bin)GaudiProfiling.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfiling :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfiling'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfiling/
#GaudiProfiling::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiProfilinglibname   = $(bin)$(library_prefix)GaudiProfiling$(library_suffix)
GaudiProfilinglib       = $(GaudiProfilinglibname).a
GaudiProfilingstamp     = $(bin)GaudiProfiling.stamp
GaudiProfilingshstamp   = $(bin)GaudiProfiling.shstamp

GaudiProfiling :: dirs  GaudiProfilingLIB
	$(echo) "GaudiProfiling ok"

cmt_GaudiProfiling_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiProfiling_has_prototypes

GaudiProfilingprototype :  ;

endif

GaudiProfilingcompile : $(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiProfilingLIB :: $(GaudiProfilinglib) $(GaudiProfilingshstamp)
GaudiProfilingLIB :: $(GaudiProfilingshstamp)
	$(echo) "GaudiProfiling : library ok"

$(GaudiProfilinglib) :: $(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiProfilinglib) $?
	$(lib_silent) $(ranlib) $(GaudiProfilinglib)
	$(lib_silent) cat /dev/null >$(GaudiProfilingstamp)

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

$(GaudiProfilinglibname).$(shlibsuffix) :: $(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o $(use_requirements) $(GaudiProfilingstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o $(GaudiProfiling_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiProfilingstamp) && \
	  cat /dev/null >$(GaudiProfilingshstamp)

$(GaudiProfilingshstamp) :: $(GaudiProfilinglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiProfilinglibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiProfilingstamp) && \
	  cat /dev/null >$(GaudiProfilingshstamp) ; fi

GaudiProfilingclean ::
	$(cleanup_echo) objects GaudiProfiling
	$(cleanup_silent) /bin/rm -f $(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o) $(patsubst %.o,%.dep,$(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o) $(patsubst %.o,%.d.stamp,$(bin)PerfMonAuditor.o $(bin)IgHook_IgHookTrace.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiProfiling_deps GaudiProfiling_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiProfilinginstallname = $(library_prefix)GaudiProfiling$(library_suffix).$(shlibsuffix)

GaudiProfiling :: GaudiProfilinginstall ;

install :: GaudiProfilinginstall ;

GaudiProfilinginstall :: $(install_dir)/$(GaudiProfilinginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiProfilinginstallname) :: $(bin)$(GaudiProfilinginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiProfilinginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiProfilingclean :: GaudiProfilinguninstall

uninstall :: GaudiProfilinguninstall ;

GaudiProfilinguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiProfilinginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiProfilingclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PerfMonAuditor.d

$(bin)$(binobj)PerfMonAuditor.d :

$(bin)$(binobj)PerfMonAuditor.o : $(cmt_final_setup_GaudiProfiling)

$(bin)$(binobj)PerfMonAuditor.o : $(src)component/PerfMonAuditor.cpp
	$(cpp_echo) $(src)component/PerfMonAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiProfiling_pp_cppflags) $(lib_GaudiProfiling_pp_cppflags) $(PerfMonAuditor_pp_cppflags) $(use_cppflags) $(GaudiProfiling_cppflags) $(lib_GaudiProfiling_cppflags) $(PerfMonAuditor_cppflags) $(PerfMonAuditor_cpp_cppflags) -I../src/component $(src)component/PerfMonAuditor.cpp
endif
endif

else
$(bin)GaudiProfiling_dependencies.make : $(PerfMonAuditor_cpp_dependencies)

$(bin)GaudiProfiling_dependencies.make : $(src)component/PerfMonAuditor.cpp

$(bin)$(binobj)PerfMonAuditor.o : $(PerfMonAuditor_cpp_dependencies)
	$(cpp_echo) $(src)component/PerfMonAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiProfiling_pp_cppflags) $(lib_GaudiProfiling_pp_cppflags) $(PerfMonAuditor_pp_cppflags) $(use_cppflags) $(GaudiProfiling_cppflags) $(lib_GaudiProfiling_cppflags) $(PerfMonAuditor_cppflags) $(PerfMonAuditor_cpp_cppflags) -I../src/component $(src)component/PerfMonAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiProfilingclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IgHook_IgHookTrace.d

$(bin)$(binobj)IgHook_IgHookTrace.d :

$(bin)$(binobj)IgHook_IgHookTrace.o : $(cmt_final_setup_GaudiProfiling)

$(bin)$(binobj)IgHook_IgHookTrace.o : $(src)component/IgHook_IgHookTrace.cpp
	$(cpp_echo) $(src)component/IgHook_IgHookTrace.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiProfiling_pp_cppflags) $(lib_GaudiProfiling_pp_cppflags) $(IgHook_IgHookTrace_pp_cppflags) $(use_cppflags) $(GaudiProfiling_cppflags) $(lib_GaudiProfiling_cppflags) $(IgHook_IgHookTrace_cppflags) $(IgHook_IgHookTrace_cpp_cppflags) -I../src/component $(src)component/IgHook_IgHookTrace.cpp
endif
endif

else
$(bin)GaudiProfiling_dependencies.make : $(IgHook_IgHookTrace_cpp_dependencies)

$(bin)GaudiProfiling_dependencies.make : $(src)component/IgHook_IgHookTrace.cpp

$(bin)$(binobj)IgHook_IgHookTrace.o : $(IgHook_IgHookTrace_cpp_dependencies)
	$(cpp_echo) $(src)component/IgHook_IgHookTrace.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiProfiling_pp_cppflags) $(lib_GaudiProfiling_pp_cppflags) $(IgHook_IgHookTrace_pp_cppflags) $(use_cppflags) $(GaudiProfiling_cppflags) $(lib_GaudiProfiling_cppflags) $(IgHook_IgHookTrace_cppflags) $(IgHook_IgHookTrace_cpp_cppflags) -I../src/component $(src)component/IgHook_IgHookTrace.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiProfilingclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfiling.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiProfiling
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiProfiling$(library_suffix).a $(library_prefix)GaudiProfiling$(library_suffix).$(shlibsuffix) GaudiProfiling.stamp GaudiProfiling.shstamp
#-- end of cleanup_library ---------------
