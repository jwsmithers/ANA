#-- start of make_header -----------------

#====================================
#  Library PartPropSvc
#
#   Generated Mon Feb 16 19:51:52 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PartPropSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PartPropSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PartPropSvc

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvc = $(PartPropSvc_tag)_PartPropSvc.make
cmt_local_tagfile_PartPropSvc = $(bin)$(PartPropSvc_tag)_PartPropSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvc = $(PartPropSvc_tag).make
cmt_local_tagfile_PartPropSvc = $(bin)$(PartPropSvc_tag).make

endif

include $(cmt_local_tagfile_PartPropSvc)
#-include $(cmt_local_tagfile_PartPropSvc)

ifdef cmt_PartPropSvc_has_target_tag

cmt_final_setup_PartPropSvc = $(bin)setup_PartPropSvc.make
cmt_dependencies_in_PartPropSvc = $(bin)dependencies_PartPropSvc.in
#cmt_final_setup_PartPropSvc = $(bin)PartPropSvc_PartPropSvcsetup.make
cmt_local_PartPropSvc_makefile = $(bin)PartPropSvc.make

else

cmt_final_setup_PartPropSvc = $(bin)setup.make
cmt_dependencies_in_PartPropSvc = $(bin)dependencies.in
#cmt_final_setup_PartPropSvc = $(bin)PartPropSvcsetup.make
cmt_local_PartPropSvc_makefile = $(bin)PartPropSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make

#PartPropSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PartPropSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PartPropSvc/
#PartPropSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PartPropSvclibname   = $(bin)$(library_prefix)PartPropSvc$(library_suffix)
PartPropSvclib       = $(PartPropSvclibname).a
PartPropSvcstamp     = $(bin)PartPropSvc.stamp
PartPropSvcshstamp   = $(bin)PartPropSvc.shstamp

PartPropSvc :: dirs  PartPropSvcLIB
	$(echo) "PartPropSvc ok"

cmt_PartPropSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_PartPropSvc_has_prototypes

PartPropSvcprototype :  ;

endif

PartPropSvccompile : $(bin)PartPropSvc.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#PartPropSvcLIB :: $(PartPropSvclib) $(PartPropSvcshstamp)
PartPropSvcLIB :: $(PartPropSvcshstamp)
	$(echo) "PartPropSvc : library ok"

$(PartPropSvclib) :: $(bin)PartPropSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(PartPropSvclib) $?
	$(lib_silent) $(ranlib) $(PartPropSvclib)
	$(lib_silent) cat /dev/null >$(PartPropSvcstamp)

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

$(PartPropSvclibname).$(shlibsuffix) :: $(bin)PartPropSvc.o $(use_requirements) $(PartPropSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)PartPropSvc.o $(PartPropSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(PartPropSvcstamp) && \
	  cat /dev/null >$(PartPropSvcshstamp)

$(PartPropSvcshstamp) :: $(PartPropSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PartPropSvclibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(PartPropSvcstamp) && \
	  cat /dev/null >$(PartPropSvcshstamp) ; fi

PartPropSvcclean ::
	$(cleanup_echo) objects PartPropSvc
	$(cleanup_silent) /bin/rm -f $(bin)PartPropSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PartPropSvc.o) $(patsubst %.o,%.dep,$(bin)PartPropSvc.o) $(patsubst %.o,%.d.stamp,$(bin)PartPropSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PartPropSvc_deps PartPropSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PartPropSvcinstallname = $(library_prefix)PartPropSvc$(library_suffix).$(shlibsuffix)

PartPropSvc :: PartPropSvcinstall ;

install :: PartPropSvcinstall ;

PartPropSvcinstall :: $(install_dir)/$(PartPropSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(PartPropSvcinstallname) :: $(bin)$(PartPropSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PartPropSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PartPropSvcclean :: PartPropSvcuninstall

uninstall :: PartPropSvcuninstall ;

PartPropSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PartPropSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),PartPropSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PartPropSvc.d

$(bin)$(binobj)PartPropSvc.d :

$(bin)$(binobj)PartPropSvc.o : $(cmt_final_setup_PartPropSvc)

$(bin)$(binobj)PartPropSvc.o : $(src)PartPropSvc.cpp
	$(cpp_echo) $(src)PartPropSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(PartPropSvc_pp_cppflags) $(lib_PartPropSvc_pp_cppflags) $(PartPropSvc_pp_cppflags) $(use_cppflags) $(PartPropSvc_cppflags) $(lib_PartPropSvc_cppflags) $(PartPropSvc_cppflags) $(PartPropSvc_cpp_cppflags)  $(src)PartPropSvc.cpp
endif
endif

else
$(bin)PartPropSvc_dependencies.make : $(PartPropSvc_cpp_dependencies)

$(bin)PartPropSvc_dependencies.make : $(src)PartPropSvc.cpp

$(bin)$(binobj)PartPropSvc.o : $(PartPropSvc_cpp_dependencies)
	$(cpp_echo) $(src)PartPropSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PartPropSvc_pp_cppflags) $(lib_PartPropSvc_pp_cppflags) $(PartPropSvc_pp_cppflags) $(use_cppflags) $(PartPropSvc_cppflags) $(lib_PartPropSvc_cppflags) $(PartPropSvc_cppflags) $(PartPropSvc_cpp_cppflags)  $(src)PartPropSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PartPropSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PartPropSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PartPropSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PartPropSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PartPropSvc$(library_suffix).a $(library_prefix)PartPropSvc$(library_suffix).$(shlibsuffix) PartPropSvc.stamp PartPropSvc.shstamp
#-- end of cleanup_library ---------------
