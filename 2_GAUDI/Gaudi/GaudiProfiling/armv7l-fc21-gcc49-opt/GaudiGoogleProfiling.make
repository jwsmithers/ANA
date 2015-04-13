#-- start of make_header -----------------

#====================================
#  Library GaudiGoogleProfiling
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

cmt_GaudiGoogleProfiling_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGoogleProfiling_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGoogleProfiling

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfiling = $(GaudiProfiling_tag)_GaudiGoogleProfiling.make
cmt_local_tagfile_GaudiGoogleProfiling = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfiling.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfiling = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiGoogleProfiling = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiGoogleProfiling)
#-include $(cmt_local_tagfile_GaudiGoogleProfiling)

ifdef cmt_GaudiGoogleProfiling_has_target_tag

cmt_final_setup_GaudiGoogleProfiling = $(bin)setup_GaudiGoogleProfiling.make
cmt_dependencies_in_GaudiGoogleProfiling = $(bin)dependencies_GaudiGoogleProfiling.in
#cmt_final_setup_GaudiGoogleProfiling = $(bin)GaudiProfiling_GaudiGoogleProfilingsetup.make
cmt_local_GaudiGoogleProfiling_makefile = $(bin)GaudiGoogleProfiling.make

else

cmt_final_setup_GaudiGoogleProfiling = $(bin)setup.make
cmt_dependencies_in_GaudiGoogleProfiling = $(bin)dependencies.in
#cmt_final_setup_GaudiGoogleProfiling = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiGoogleProfiling_makefile = $(bin)GaudiGoogleProfiling.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiGoogleProfiling :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGoogleProfiling'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGoogleProfiling/
#GaudiGoogleProfiling::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiGoogleProfilinglibname   = $(bin)$(library_prefix)GaudiGoogleProfiling$(library_suffix)
GaudiGoogleProfilinglib       = $(GaudiGoogleProfilinglibname).a
GaudiGoogleProfilingstamp     = $(bin)GaudiGoogleProfiling.stamp
GaudiGoogleProfilingshstamp   = $(bin)GaudiGoogleProfiling.shstamp

GaudiGoogleProfiling :: dirs  GaudiGoogleProfilingLIB
	$(echo) "GaudiGoogleProfiling ok"

cmt_GaudiGoogleProfiling_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfiling_has_prototypes

GaudiGoogleProfilingprototype :  ;

endif

GaudiGoogleProfilingcompile : $(bin)GoogleAuditor.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiGoogleProfilingLIB :: $(GaudiGoogleProfilinglib) $(GaudiGoogleProfilingshstamp)
GaudiGoogleProfilingLIB :: $(GaudiGoogleProfilingshstamp)
	$(echo) "GaudiGoogleProfiling : library ok"

$(GaudiGoogleProfilinglib) :: $(bin)GoogleAuditor.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiGoogleProfilinglib) $?
	$(lib_silent) $(ranlib) $(GaudiGoogleProfilinglib)
	$(lib_silent) cat /dev/null >$(GaudiGoogleProfilingstamp)

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

$(GaudiGoogleProfilinglibname).$(shlibsuffix) :: $(bin)GoogleAuditor.o $(use_requirements) $(GaudiGoogleProfilingstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)GoogleAuditor.o $(GaudiGoogleProfiling_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiGoogleProfilingstamp) && \
	  cat /dev/null >$(GaudiGoogleProfilingshstamp)

$(GaudiGoogleProfilingshstamp) :: $(GaudiGoogleProfilinglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiGoogleProfilinglibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiGoogleProfilingstamp) && \
	  cat /dev/null >$(GaudiGoogleProfilingshstamp) ; fi

GaudiGoogleProfilingclean ::
	$(cleanup_echo) objects GaudiGoogleProfiling
	$(cleanup_silent) /bin/rm -f $(bin)GoogleAuditor.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GoogleAuditor.o) $(patsubst %.o,%.dep,$(bin)GoogleAuditor.o) $(patsubst %.o,%.d.stamp,$(bin)GoogleAuditor.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiGoogleProfiling_deps GaudiGoogleProfiling_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiGoogleProfilinginstallname = $(library_prefix)GaudiGoogleProfiling$(library_suffix).$(shlibsuffix)

GaudiGoogleProfiling :: GaudiGoogleProfilinginstall ;

install :: GaudiGoogleProfilinginstall ;

GaudiGoogleProfilinginstall :: $(install_dir)/$(GaudiGoogleProfilinginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiGoogleProfilinginstallname) :: $(bin)$(GaudiGoogleProfilinginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGoogleProfilinginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiGoogleProfilingclean :: GaudiGoogleProfilinguninstall

uninstall :: GaudiGoogleProfilinguninstall ;

GaudiGoogleProfilinguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGoogleProfilinginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGoogleProfilingclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GoogleAuditor.d

$(bin)$(binobj)GoogleAuditor.d :

$(bin)$(binobj)GoogleAuditor.o : $(cmt_final_setup_GaudiGoogleProfiling)

$(bin)$(binobj)GoogleAuditor.o : $(src)component/google/GoogleAuditor.cpp
	$(cpp_echo) $(src)component/google/GoogleAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGoogleProfiling_pp_cppflags) $(lib_GaudiGoogleProfiling_pp_cppflags) $(GoogleAuditor_pp_cppflags) $(use_cppflags) $(GaudiGoogleProfiling_cppflags) $(lib_GaudiGoogleProfiling_cppflags) $(GoogleAuditor_cppflags) $(GoogleAuditor_cpp_cppflags) -I../src/component/google $(src)component/google/GoogleAuditor.cpp
endif
endif

else
$(bin)GaudiGoogleProfiling_dependencies.make : $(GoogleAuditor_cpp_dependencies)

$(bin)GaudiGoogleProfiling_dependencies.make : $(src)component/google/GoogleAuditor.cpp

$(bin)$(binobj)GoogleAuditor.o : $(GoogleAuditor_cpp_dependencies)
	$(cpp_echo) $(src)component/google/GoogleAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGoogleProfiling_pp_cppflags) $(lib_GaudiGoogleProfiling_pp_cppflags) $(GoogleAuditor_pp_cppflags) $(use_cppflags) $(GaudiGoogleProfiling_cppflags) $(lib_GaudiGoogleProfiling_cppflags) $(GoogleAuditor_cppflags) $(GoogleAuditor_cpp_cppflags) -I../src/component/google $(src)component/google/GoogleAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiGoogleProfilingclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGoogleProfiling.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGoogleProfilingclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiGoogleProfiling
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiGoogleProfiling$(library_suffix).a $(library_prefix)GaudiGoogleProfiling$(library_suffix).$(shlibsuffix) GaudiGoogleProfiling.stamp GaudiGoogleProfiling.shstamp
#-- end of cleanup_library ---------------
