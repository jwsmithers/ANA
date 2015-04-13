#-- start of make_header -----------------

#====================================
#  Library GaudiMPLib
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

cmt_GaudiMPLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPLib

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPLib = $(GaudiMP_tag)_GaudiMPLib.make
cmt_local_tagfile_GaudiMPLib = $(bin)$(GaudiMP_tag)_GaudiMPLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPLib = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPLib = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPLib)
#-include $(cmt_local_tagfile_GaudiMPLib)

ifdef cmt_GaudiMPLib_has_target_tag

cmt_final_setup_GaudiMPLib = $(bin)setup_GaudiMPLib.make
cmt_dependencies_in_GaudiMPLib = $(bin)dependencies_GaudiMPLib.in
#cmt_final_setup_GaudiMPLib = $(bin)GaudiMP_GaudiMPLibsetup.make
cmt_local_GaudiMPLib_makefile = $(bin)GaudiMPLib.make

else

cmt_final_setup_GaudiMPLib = $(bin)setup.make
cmt_dependencies_in_GaudiMPLib = $(bin)dependencies.in
#cmt_final_setup_GaudiMPLib = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPLib_makefile = $(bin)GaudiMPLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPLib/
#GaudiMPLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiMPLiblibname   = $(bin)$(library_prefix)GaudiMPLib$(library_suffix)
GaudiMPLiblib       = $(GaudiMPLiblibname).a
GaudiMPLibstamp     = $(bin)GaudiMPLib.stamp
GaudiMPLibshstamp   = $(bin)GaudiMPLib.shstamp

GaudiMPLib :: dirs  GaudiMPLibLIB
	$(echo) "GaudiMPLib ok"

cmt_GaudiMPLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMPLib_has_prototypes

GaudiMPLibprototype :  ;

endif

GaudiMPLibcompile : $(bin)PyROOTPickle.o $(bin)TESSerializer.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiMPLibLIB :: $(GaudiMPLiblib) $(GaudiMPLibshstamp)
GaudiMPLibLIB :: $(GaudiMPLibshstamp)
	$(echo) "GaudiMPLib : library ok"

$(GaudiMPLiblib) :: $(bin)PyROOTPickle.o $(bin)TESSerializer.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiMPLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiMPLiblib)
	$(lib_silent) cat /dev/null >$(GaudiMPLibstamp)

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

$(GaudiMPLiblibname).$(shlibsuffix) :: $(bin)PyROOTPickle.o $(bin)TESSerializer.o $(use_requirements) $(GaudiMPLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)PyROOTPickle.o $(bin)TESSerializer.o $(GaudiMPLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiMPLibstamp) && \
	  cat /dev/null >$(GaudiMPLibshstamp)

$(GaudiMPLibshstamp) :: $(GaudiMPLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiMPLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiMPLibstamp) && \
	  cat /dev/null >$(GaudiMPLibshstamp) ; fi

GaudiMPLibclean ::
	$(cleanup_echo) objects GaudiMPLib
	$(cleanup_silent) /bin/rm -f $(bin)PyROOTPickle.o $(bin)TESSerializer.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PyROOTPickle.o $(bin)TESSerializer.o) $(patsubst %.o,%.dep,$(bin)PyROOTPickle.o $(bin)TESSerializer.o) $(patsubst %.o,%.d.stamp,$(bin)PyROOTPickle.o $(bin)TESSerializer.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiMPLib_deps GaudiMPLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiMPLibinstallname = $(library_prefix)GaudiMPLib$(library_suffix).$(shlibsuffix)

GaudiMPLib :: GaudiMPLibinstall ;

install :: GaudiMPLibinstall ;

GaudiMPLibinstall :: $(install_dir)/$(GaudiMPLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiMPLibinstallname) :: $(bin)$(GaudiMPLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiMPLibclean :: GaudiMPLibuninstall

uninstall :: GaudiMPLibuninstall ;

GaudiMPLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PyROOTPickle.d

$(bin)$(binobj)PyROOTPickle.d :

$(bin)$(binobj)PyROOTPickle.o : $(cmt_final_setup_GaudiMPLib)

$(bin)$(binobj)PyROOTPickle.o : $(src)Lib/PyROOTPickle.cpp
	$(cpp_echo) $(src)Lib/PyROOTPickle.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMPLib_pp_cppflags) $(lib_GaudiMPLib_pp_cppflags) $(PyROOTPickle_pp_cppflags) $(use_cppflags) $(GaudiMPLib_cppflags) $(lib_GaudiMPLib_cppflags) $(PyROOTPickle_cppflags) $(PyROOTPickle_cpp_cppflags) -I../src/Lib $(src)Lib/PyROOTPickle.cpp
endif
endif

else
$(bin)GaudiMPLib_dependencies.make : $(PyROOTPickle_cpp_dependencies)

$(bin)GaudiMPLib_dependencies.make : $(src)Lib/PyROOTPickle.cpp

$(bin)$(binobj)PyROOTPickle.o : $(PyROOTPickle_cpp_dependencies)
	$(cpp_echo) $(src)Lib/PyROOTPickle.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMPLib_pp_cppflags) $(lib_GaudiMPLib_pp_cppflags) $(PyROOTPickle_pp_cppflags) $(use_cppflags) $(GaudiMPLib_cppflags) $(lib_GaudiMPLib_cppflags) $(PyROOTPickle_cppflags) $(PyROOTPickle_cpp_cppflags) -I../src/Lib $(src)Lib/PyROOTPickle.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TESSerializer.d

$(bin)$(binobj)TESSerializer.d :

$(bin)$(binobj)TESSerializer.o : $(cmt_final_setup_GaudiMPLib)

$(bin)$(binobj)TESSerializer.o : $(src)Lib/TESSerializer.cpp
	$(cpp_echo) $(src)Lib/TESSerializer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMPLib_pp_cppflags) $(lib_GaudiMPLib_pp_cppflags) $(TESSerializer_pp_cppflags) $(use_cppflags) $(GaudiMPLib_cppflags) $(lib_GaudiMPLib_cppflags) $(TESSerializer_cppflags) $(TESSerializer_cpp_cppflags) -I../src/Lib $(src)Lib/TESSerializer.cpp
endif
endif

else
$(bin)GaudiMPLib_dependencies.make : $(TESSerializer_cpp_dependencies)

$(bin)GaudiMPLib_dependencies.make : $(src)Lib/TESSerializer.cpp

$(bin)$(binobj)TESSerializer.o : $(TESSerializer_cpp_dependencies)
	$(cpp_echo) $(src)Lib/TESSerializer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMPLib_pp_cppflags) $(lib_GaudiMPLib_pp_cppflags) $(TESSerializer_pp_cppflags) $(use_cppflags) $(GaudiMPLib_cppflags) $(lib_GaudiMPLib_cppflags) $(TESSerializer_cppflags) $(TESSerializer_cpp_cppflags) -I../src/Lib $(src)Lib/TESSerializer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiMPLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiMPLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiMPLib$(library_suffix).a $(library_prefix)GaudiMPLib$(library_suffix).$(shlibsuffix) GaudiMPLib.stamp GaudiMPLib.shstamp
#-- end of cleanup_library ---------------
