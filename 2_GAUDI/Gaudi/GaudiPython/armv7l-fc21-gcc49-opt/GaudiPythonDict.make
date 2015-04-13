#-- start of make_header -----------------

#====================================
#  Library GaudiPythonDict
#
#   Generated Mon Feb 16 20:32:11 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonDict

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonDict = $(GaudiPython_tag)_GaudiPythonDict.make
cmt_local_tagfile_GaudiPythonDict = $(bin)$(GaudiPython_tag)_GaudiPythonDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonDict = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonDict = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonDict)
#-include $(cmt_local_tagfile_GaudiPythonDict)

ifdef cmt_GaudiPythonDict_has_target_tag

cmt_final_setup_GaudiPythonDict = $(bin)setup_GaudiPythonDict.make
cmt_dependencies_in_GaudiPythonDict = $(bin)dependencies_GaudiPythonDict.in
#cmt_final_setup_GaudiPythonDict = $(bin)GaudiPython_GaudiPythonDictsetup.make
cmt_local_GaudiPythonDict_makefile = $(bin)GaudiPythonDict.make

else

cmt_final_setup_GaudiPythonDict = $(bin)setup.make
cmt_dependencies_in_GaudiPythonDict = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonDict = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonDict_makefile = $(bin)GaudiPythonDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonDict/
#GaudiPythonDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiPythonDictlibname   = $(bin)$(library_prefix)GaudiPythonDict$(library_suffix)
GaudiPythonDictlib       = $(GaudiPythonDictlibname).a
GaudiPythonDictstamp     = $(bin)GaudiPythonDict.stamp
GaudiPythonDictshstamp   = $(bin)GaudiPythonDict.shstamp

GaudiPythonDict :: dirs  GaudiPythonDictLIB
	$(echo) "GaudiPythonDict ok"

cmt_GaudiPythonDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPythonDict_has_prototypes

GaudiPythonDictprototype :  ;

endif

GaudiPythonDictcompile : $(bin)GaudiPythonDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GaudiPythonDictLIB :: $(GaudiPythonDictlib) $(GaudiPythonDictshstamp)
	$(echo) "GaudiPythonDict : library ok"

$(GaudiPythonDictlib) :: $(bin)GaudiPythonDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GaudiPythonDictlib) $(bin)GaudiPythonDict.o
	$(lib_silent) $(ranlib) $(GaudiPythonDictlib)
	$(lib_silent) cat /dev/null >$(GaudiPythonDictstamp)

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

$(GaudiPythonDictlibname).$(shlibsuffix) :: $(GaudiPythonDictlib) requirements $(use_requirements) $(GaudiPythonDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GaudiPythonDict $(GaudiPythonDict_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiPythonDictshstamp)

$(GaudiPythonDictshstamp) :: $(GaudiPythonDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiPythonDictlibname).$(shlibsuffix) ; then cat /dev/null >$(GaudiPythonDictshstamp) ; fi

GaudiPythonDictclean ::
	$(cleanup_echo) objects GaudiPythonDict
	$(cleanup_silent) /bin/rm -f $(bin)GaudiPythonDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiPythonDict.o) $(patsubst %.o,%.dep,$(bin)GaudiPythonDict.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiPythonDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiPythonDict_deps GaudiPythonDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiPythonDictinstallname = $(library_prefix)GaudiPythonDict$(library_suffix).$(shlibsuffix)

GaudiPythonDict :: GaudiPythonDictinstall ;

install :: GaudiPythonDictinstall ;

GaudiPythonDictinstall :: $(install_dir)/$(GaudiPythonDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiPythonDictinstallname) :: $(bin)$(GaudiPythonDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythonDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiPythonDictclean :: GaudiPythonDictuninstall

uninstall :: GaudiPythonDictuninstall ;

GaudiPythonDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythonDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiPythonDict.d

$(bin)$(binobj)GaudiPythonDict.d :

$(bin)$(binobj)GaudiPythonDict.o : $(cmt_final_setup_GaudiPythonDict)

$(bin)$(binobj)GaudiPythonDict.o : ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonDict_pp_cppflags) $(lib_GaudiPythonDict_pp_cppflags) $(GaudiPythonDict_pp_cppflags) $(use_cppflags) $(GaudiPythonDict_cppflags) $(lib_GaudiPythonDict_cppflags) $(GaudiPythonDict_cppflags) $(GaudiPythonDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiPython ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp
endif
endif

else
$(bin)GaudiPythonDict_dependencies.make : $(GaudiPythonDict_cpp_dependencies)

$(bin)GaudiPythonDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp

$(bin)$(binobj)GaudiPythonDict.o : $(GaudiPythonDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonDict_pp_cppflags) $(lib_GaudiPythonDict_pp_cppflags) $(GaudiPythonDict_pp_cppflags) $(use_cppflags) $(GaudiPythonDict_cppflags) $(lib_GaudiPythonDict_cppflags) $(GaudiPythonDict_cppflags) $(GaudiPythonDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiPython ../armv7l-fc21-gcc49-opt/dict/GaudiPython/GaudiPythonDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiPythonDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiPythonDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiPythonDict$(library_suffix).a $(library_prefix)GaudiPythonDict$(library_suffix).$(shlibsuffix) GaudiPythonDict.stamp GaudiPythonDict.shstamp
#-- end of cleanup_library ---------------
