#-- start of make_header -----------------

#====================================
#  Library GaudiMP
#
#   Generated Mon Feb 16 20:49:04 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMP_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMP_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMP

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMP = $(GaudiMP_tag)_GaudiMP.make
cmt_local_tagfile_GaudiMP = $(bin)$(GaudiMP_tag)_GaudiMP.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMP = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMP = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMP)
#-include $(cmt_local_tagfile_GaudiMP)

ifdef cmt_GaudiMP_has_target_tag

cmt_final_setup_GaudiMP = $(bin)setup_GaudiMP.make
cmt_dependencies_in_GaudiMP = $(bin)dependencies_GaudiMP.in
#cmt_final_setup_GaudiMP = $(bin)GaudiMP_GaudiMPsetup.make
cmt_local_GaudiMP_makefile = $(bin)GaudiMP.make

else

cmt_final_setup_GaudiMP = $(bin)setup.make
cmt_dependencies_in_GaudiMP = $(bin)dependencies.in
#cmt_final_setup_GaudiMP = $(bin)GaudiMPsetup.make
cmt_local_GaudiMP_makefile = $(bin)GaudiMP.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMP :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMP'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMP/
#GaudiMP::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiMPlibname   = $(bin)$(library_prefix)GaudiMP$(library_suffix)
GaudiMPlib       = $(GaudiMPlibname).a
GaudiMPstamp     = $(bin)GaudiMP.stamp
GaudiMPshstamp   = $(bin)GaudiMP.shstamp

GaudiMP :: dirs  GaudiMPLIB
	$(echo) "GaudiMP ok"

cmt_GaudiMP_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMP_has_prototypes

GaudiMPprototype :  ;

endif

GaudiMPcompile : $(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiMPLIB :: $(GaudiMPlib) $(GaudiMPshstamp)
GaudiMPLIB :: $(GaudiMPshstamp)
	$(echo) "GaudiMP : library ok"

$(GaudiMPlib) :: $(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiMPlib) $?
	$(lib_silent) $(ranlib) $(GaudiMPlib)
	$(lib_silent) cat /dev/null >$(GaudiMPstamp)

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

$(GaudiMPlibname).$(shlibsuffix) :: $(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o $(use_requirements) $(GaudiMPstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o $(GaudiMP_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiMPstamp) && \
	  cat /dev/null >$(GaudiMPshstamp)

$(GaudiMPshstamp) :: $(GaudiMPlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiMPlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiMPstamp) && \
	  cat /dev/null >$(GaudiMPshstamp) ; fi

GaudiMPclean ::
	$(cleanup_echo) objects GaudiMP
	$(cleanup_silent) /bin/rm -f $(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o) $(patsubst %.o,%.dep,$(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o) $(patsubst %.o,%.d.stamp,$(bin)RecordOutputStream.o $(bin)IoComponentMgr.o $(bin)ReplayOutputStream.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiMP_deps GaudiMP_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiMPinstallname = $(library_prefix)GaudiMP$(library_suffix).$(shlibsuffix)

GaudiMP :: GaudiMPinstall ;

install :: GaudiMPinstall ;

GaudiMPinstall :: $(install_dir)/$(GaudiMPinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiMPinstallname) :: $(bin)$(GaudiMPinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiMPclean :: GaudiMPuninstall

uninstall :: GaudiMPuninstall ;

GaudiMPuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecordOutputStream.d

$(bin)$(binobj)RecordOutputStream.d :

$(bin)$(binobj)RecordOutputStream.o : $(cmt_final_setup_GaudiMP)

$(bin)$(binobj)RecordOutputStream.o : $(src)component/RecordOutputStream.cpp
	$(cpp_echo) $(src)component/RecordOutputStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(RecordOutputStream_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(RecordOutputStream_cppflags) $(RecordOutputStream_cpp_cppflags) -I../src/component $(src)component/RecordOutputStream.cpp
endif
endif

else
$(bin)GaudiMP_dependencies.make : $(RecordOutputStream_cpp_dependencies)

$(bin)GaudiMP_dependencies.make : $(src)component/RecordOutputStream.cpp

$(bin)$(binobj)RecordOutputStream.o : $(RecordOutputStream_cpp_dependencies)
	$(cpp_echo) $(src)component/RecordOutputStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(RecordOutputStream_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(RecordOutputStream_cppflags) $(RecordOutputStream_cpp_cppflags) -I../src/component $(src)component/RecordOutputStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IoComponentMgr.d

$(bin)$(binobj)IoComponentMgr.d :

$(bin)$(binobj)IoComponentMgr.o : $(cmt_final_setup_GaudiMP)

$(bin)$(binobj)IoComponentMgr.o : $(src)component/IoComponentMgr.cpp
	$(cpp_echo) $(src)component/IoComponentMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(IoComponentMgr_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(IoComponentMgr_cppflags) $(IoComponentMgr_cpp_cppflags) -I../src/component $(src)component/IoComponentMgr.cpp
endif
endif

else
$(bin)GaudiMP_dependencies.make : $(IoComponentMgr_cpp_dependencies)

$(bin)GaudiMP_dependencies.make : $(src)component/IoComponentMgr.cpp

$(bin)$(binobj)IoComponentMgr.o : $(IoComponentMgr_cpp_dependencies)
	$(cpp_echo) $(src)component/IoComponentMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(IoComponentMgr_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(IoComponentMgr_cppflags) $(IoComponentMgr_cpp_cppflags) -I../src/component $(src)component/IoComponentMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReplayOutputStream.d

$(bin)$(binobj)ReplayOutputStream.d :

$(bin)$(binobj)ReplayOutputStream.o : $(cmt_final_setup_GaudiMP)

$(bin)$(binobj)ReplayOutputStream.o : $(src)component/ReplayOutputStream.cpp
	$(cpp_echo) $(src)component/ReplayOutputStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(ReplayOutputStream_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(ReplayOutputStream_cppflags) $(ReplayOutputStream_cpp_cppflags) -I../src/component $(src)component/ReplayOutputStream.cpp
endif
endif

else
$(bin)GaudiMP_dependencies.make : $(ReplayOutputStream_cpp_dependencies)

$(bin)GaudiMP_dependencies.make : $(src)component/ReplayOutputStream.cpp

$(bin)$(binobj)ReplayOutputStream.o : $(ReplayOutputStream_cpp_dependencies)
	$(cpp_echo) $(src)component/ReplayOutputStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMP_pp_cppflags) $(lib_GaudiMP_pp_cppflags) $(ReplayOutputStream_pp_cppflags) $(use_cppflags) $(GaudiMP_cppflags) $(lib_GaudiMP_cppflags) $(ReplayOutputStream_cppflags) $(ReplayOutputStream_cpp_cppflags) -I../src/component $(src)component/ReplayOutputStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiMPclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMP.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiMP
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiMP$(library_suffix).a $(library_prefix)GaudiMP$(library_suffix).$(shlibsuffix) GaudiMP.stamp GaudiMP.shstamp
#-- end of cleanup_library ---------------
