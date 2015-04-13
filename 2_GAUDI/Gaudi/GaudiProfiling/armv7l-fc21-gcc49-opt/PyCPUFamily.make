#-- start of make_header -----------------

#====================================
#  Library PyCPUFamily
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

cmt_PyCPUFamily_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PyCPUFamily_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PyCPUFamily

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_PyCPUFamily = $(GaudiProfiling_tag)_PyCPUFamily.make
cmt_local_tagfile_PyCPUFamily = $(bin)$(GaudiProfiling_tag)_PyCPUFamily.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_PyCPUFamily = $(GaudiProfiling_tag).make
cmt_local_tagfile_PyCPUFamily = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_PyCPUFamily)
#-include $(cmt_local_tagfile_PyCPUFamily)

ifdef cmt_PyCPUFamily_has_target_tag

cmt_final_setup_PyCPUFamily = $(bin)setup_PyCPUFamily.make
cmt_dependencies_in_PyCPUFamily = $(bin)dependencies_PyCPUFamily.in
#cmt_final_setup_PyCPUFamily = $(bin)GaudiProfiling_PyCPUFamilysetup.make
cmt_local_PyCPUFamily_makefile = $(bin)PyCPUFamily.make

else

cmt_final_setup_PyCPUFamily = $(bin)setup.make
cmt_dependencies_in_PyCPUFamily = $(bin)dependencies.in
#cmt_final_setup_PyCPUFamily = $(bin)GaudiProfilingsetup.make
cmt_local_PyCPUFamily_makefile = $(bin)PyCPUFamily.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#PyCPUFamily :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PyCPUFamily'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PyCPUFamily/
#PyCPUFamily::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PyCPUFamilylibname   = $(bin)$(library_prefix)PyCPUFamily$(library_suffix)
PyCPUFamilylib       = $(PyCPUFamilylibname).a
PyCPUFamilystamp     = $(bin)PyCPUFamily.stamp
PyCPUFamilyshstamp   = $(bin)PyCPUFamily.shstamp

PyCPUFamily :: dirs  PyCPUFamilyLIB
	$(echo) "PyCPUFamily ok"

cmt_PyCPUFamily_has_prototypes = 1

#--------------------------------------

ifdef cmt_PyCPUFamily_has_prototypes

PyCPUFamilyprototype :  ;

endif

PyCPUFamilycompile : $(bin)CPUFamily.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#PyCPUFamilyLIB :: $(PyCPUFamilylib) $(PyCPUFamilyshstamp)
PyCPUFamilyLIB :: $(PyCPUFamilyshstamp)
	$(echo) "PyCPUFamily : library ok"

$(PyCPUFamilylib) :: $(bin)CPUFamily.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(PyCPUFamilylib) $?
	$(lib_silent) $(ranlib) $(PyCPUFamilylib)
	$(lib_silent) cat /dev/null >$(PyCPUFamilystamp)

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

$(PyCPUFamilylibname).$(shlibsuffix) :: $(bin)CPUFamily.o $(use_requirements) $(PyCPUFamilystamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)CPUFamily.o $(PyCPUFamily_shlibflags)
	$(lib_silent) cat /dev/null >$(PyCPUFamilystamp) && \
	  cat /dev/null >$(PyCPUFamilyshstamp)

$(PyCPUFamilyshstamp) :: $(PyCPUFamilylibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PyCPUFamilylibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(PyCPUFamilystamp) && \
	  cat /dev/null >$(PyCPUFamilyshstamp) ; fi

PyCPUFamilyclean ::
	$(cleanup_echo) objects PyCPUFamily
	$(cleanup_silent) /bin/rm -f $(bin)CPUFamily.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)CPUFamily.o) $(patsubst %.o,%.dep,$(bin)CPUFamily.o) $(patsubst %.o,%.d.stamp,$(bin)CPUFamily.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PyCPUFamily_deps PyCPUFamily_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PyCPUFamilyinstallname = $(library_prefix)PyCPUFamily$(library_suffix).$(shlibsuffix)

PyCPUFamily :: PyCPUFamilyinstall ;

install :: PyCPUFamilyinstall ;

PyCPUFamilyinstall :: /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload/$(PyCPUFamilyinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload/$(PyCPUFamilyinstallname) :: $(bin)$(PyCPUFamilyinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PyCPUFamilyinstallname)" \
	    -out "/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PyCPUFamilyclean :: PyCPUFamilyuninstall

uninstall :: PyCPUFamilyuninstall ;

PyCPUFamilyuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PyCPUFamilyinstallname)" \
	    -out "/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq ($(cppdepflags),)

ifneq ($(MAKECMDGOALS),PyCPUFamilyclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CPUFamily.d

$(bin)$(binobj)CPUFamily.d :

$(bin)$(binobj)CPUFamily.o : $(cmt_final_setup_PyCPUFamily)

$(bin)$(binobj)CPUFamily.o : $(src)python/CPUFamily.cpp
	$(cpp_echo) $(src)python/CPUFamily.cpp
	$(cpp_silent) $(cppcomp) $(cppdepflags) -o $@ $(use_pp_cppflags) $(PyCPUFamily_pp_cppflags) $(lib_PyCPUFamily_pp_cppflags) $(CPUFamily_pp_cppflags) $(use_cppflags) $(PyCPUFamily_cppflags) $(lib_PyCPUFamily_cppflags) $(CPUFamily_cppflags) $(CPUFamily_cpp_cppflags) -I../src/python $(src)python/CPUFamily.cpp
endif
endif

else
$(bin)PyCPUFamily_dependencies.make : $(CPUFamily_cpp_dependencies)

$(bin)PyCPUFamily_dependencies.make : $(src)python/CPUFamily.cpp

$(bin)$(binobj)CPUFamily.o : $(CPUFamily_cpp_dependencies)
	$(cpp_echo) $(src)python/CPUFamily.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PyCPUFamily_pp_cppflags) $(lib_PyCPUFamily_pp_cppflags) $(CPUFamily_pp_cppflags) $(use_cppflags) $(PyCPUFamily_cppflags) $(lib_PyCPUFamily_cppflags) $(CPUFamily_cppflags) $(CPUFamily_cpp_cppflags) -I../src/python $(src)python/CPUFamily.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PyCPUFamilyclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PyCPUFamily.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PyCPUFamilyclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PyCPUFamily
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PyCPUFamily$(library_suffix).a $(library_prefix)PyCPUFamily$(library_suffix).$(shlibsuffix) PyCPUFamily.stamp PyCPUFamily.shstamp
#-- end of cleanup_library ---------------
