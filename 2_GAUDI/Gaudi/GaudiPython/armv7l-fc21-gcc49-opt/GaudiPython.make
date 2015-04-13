#-- start of make_header -----------------

#====================================
#  Library GaudiPython
#
#   Generated Mon Feb 16 20:23:15 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPython_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPython_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPython

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPython = $(GaudiPython_tag)_GaudiPython.make
cmt_local_tagfile_GaudiPython = $(bin)$(GaudiPython_tag)_GaudiPython.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPython = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPython = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPython)
#-include $(cmt_local_tagfile_GaudiPython)

ifdef cmt_GaudiPython_has_target_tag

cmt_final_setup_GaudiPython = $(bin)setup_GaudiPython.make
cmt_dependencies_in_GaudiPython = $(bin)dependencies_GaudiPython.in
#cmt_final_setup_GaudiPython = $(bin)GaudiPython_GaudiPythonsetup.make
cmt_local_GaudiPython_makefile = $(bin)GaudiPython.make

else

cmt_final_setup_GaudiPython = $(bin)setup.make
cmt_dependencies_in_GaudiPython = $(bin)dependencies.in
#cmt_final_setup_GaudiPython = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPython_makefile = $(bin)GaudiPython.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPython :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPython'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPython/
#GaudiPython::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiPythonlibname   = $(bin)$(library_prefix)GaudiPython$(library_suffix)
GaudiPythonlib       = $(GaudiPythonlibname).a
GaudiPythonstamp     = $(bin)GaudiPython.stamp
GaudiPythonshstamp   = $(bin)GaudiPython.shstamp

GaudiPython :: dirs  GaudiPythonLIB
	$(echo) "GaudiPython ok"

cmt_GaudiPython_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPython_has_prototypes

GaudiPythonprototype :  ;

endif

GaudiPythoncompile : $(bin)PythonScriptingSvc.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiPythonLIB :: $(GaudiPythonlib) $(GaudiPythonshstamp)
GaudiPythonLIB :: $(GaudiPythonshstamp)
	$(echo) "GaudiPython : library ok"

$(GaudiPythonlib) :: $(bin)PythonScriptingSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiPythonlib) $?
	$(lib_silent) $(ranlib) $(GaudiPythonlib)
	$(lib_silent) cat /dev/null >$(GaudiPythonstamp)

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

$(GaudiPythonlibname).$(shlibsuffix) :: $(bin)PythonScriptingSvc.o $(use_requirements) $(GaudiPythonstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)PythonScriptingSvc.o $(GaudiPython_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiPythonstamp) && \
	  cat /dev/null >$(GaudiPythonshstamp)

$(GaudiPythonshstamp) :: $(GaudiPythonlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiPythonlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiPythonstamp) && \
	  cat /dev/null >$(GaudiPythonshstamp) ; fi

GaudiPythonclean ::
	$(cleanup_echo) objects GaudiPython
	$(cleanup_silent) /bin/rm -f $(bin)PythonScriptingSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)PythonScriptingSvc.o) $(patsubst %.o,%.dep,$(bin)PythonScriptingSvc.o) $(patsubst %.o,%.d.stamp,$(bin)PythonScriptingSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiPython_deps GaudiPython_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiPythoninstallname = $(library_prefix)GaudiPython$(library_suffix).$(shlibsuffix)

GaudiPython :: GaudiPythoninstall ;

install :: GaudiPythoninstall ;

GaudiPythoninstall :: $(install_dir)/$(GaudiPythoninstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiPythoninstallname) :: $(bin)$(GaudiPythoninstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythoninstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiPythonclean :: GaudiPythonuninstall

uninstall :: GaudiPythonuninstall ;

GaudiPythonuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythoninstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PythonScriptingSvc.d

$(bin)$(binobj)PythonScriptingSvc.d :

$(bin)$(binobj)PythonScriptingSvc.o : $(cmt_final_setup_GaudiPython)

$(bin)$(binobj)PythonScriptingSvc.o : $(src)Services/PythonScriptingSvc.cpp
	$(cpp_echo) $(src)Services/PythonScriptingSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPython_pp_cppflags) $(lib_GaudiPython_pp_cppflags) $(PythonScriptingSvc_pp_cppflags) $(use_cppflags) $(GaudiPython_cppflags) $(lib_GaudiPython_cppflags) $(PythonScriptingSvc_cppflags) $(PythonScriptingSvc_cpp_cppflags) -I../src/Services $(src)Services/PythonScriptingSvc.cpp
endif
endif

else
$(bin)GaudiPython_dependencies.make : $(PythonScriptingSvc_cpp_dependencies)

$(bin)GaudiPython_dependencies.make : $(src)Services/PythonScriptingSvc.cpp

$(bin)$(binobj)PythonScriptingSvc.o : $(PythonScriptingSvc_cpp_dependencies)
	$(cpp_echo) $(src)Services/PythonScriptingSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPython_pp_cppflags) $(lib_GaudiPython_pp_cppflags) $(PythonScriptingSvc_pp_cppflags) $(use_cppflags) $(GaudiPython_cppflags) $(lib_GaudiPython_cppflags) $(PythonScriptingSvc_cppflags) $(PythonScriptingSvc_cpp_cppflags) -I../src/Services $(src)Services/PythonScriptingSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiPythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPython.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiPython
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiPython$(library_suffix).a $(library_prefix)GaudiPython$(library_suffix).$(shlibsuffix) GaudiPython.stamp GaudiPython.shstamp
#-- end of cleanup_library ---------------
