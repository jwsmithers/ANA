#-- start of make_header -----------------

#====================================
#  Library GaudiExamplesDict
#
#   Generated Mon Feb 16 20:51:34 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesDict

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesDict = $(GaudiExamples_tag)_GaudiExamplesDict.make
cmt_local_tagfile_GaudiExamplesDict = $(bin)$(GaudiExamples_tag)_GaudiExamplesDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesDict = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesDict = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesDict)
#-include $(cmt_local_tagfile_GaudiExamplesDict)

ifdef cmt_GaudiExamplesDict_has_target_tag

cmt_final_setup_GaudiExamplesDict = $(bin)setup_GaudiExamplesDict.make
cmt_dependencies_in_GaudiExamplesDict = $(bin)dependencies_GaudiExamplesDict.in
#cmt_final_setup_GaudiExamplesDict = $(bin)GaudiExamples_GaudiExamplesDictsetup.make
cmt_local_GaudiExamplesDict_makefile = $(bin)GaudiExamplesDict.make

else

cmt_final_setup_GaudiExamplesDict = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesDict = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesDict = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesDict_makefile = $(bin)GaudiExamplesDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesDict/
#GaudiExamplesDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiExamplesDictlibname   = $(bin)$(library_prefix)GaudiExamplesDict$(library_suffix)
GaudiExamplesDictlib       = $(GaudiExamplesDictlibname).a
GaudiExamplesDictstamp     = $(bin)GaudiExamplesDict.stamp
GaudiExamplesDictshstamp   = $(bin)GaudiExamplesDict.shstamp

GaudiExamplesDict :: dirs  GaudiExamplesDictLIB
	$(echo) "GaudiExamplesDict ok"

cmt_GaudiExamplesDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamplesDict_has_prototypes

GaudiExamplesDictprototype :  ;

endif

GaudiExamplesDictcompile : $(bin)GaudiExamplesDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GaudiExamplesDictLIB :: $(GaudiExamplesDictlib) $(GaudiExamplesDictshstamp)
	$(echo) "GaudiExamplesDict : library ok"

$(GaudiExamplesDictlib) :: $(bin)GaudiExamplesDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GaudiExamplesDictlib) $(bin)GaudiExamplesDict.o
	$(lib_silent) $(ranlib) $(GaudiExamplesDictlib)
	$(lib_silent) cat /dev/null >$(GaudiExamplesDictstamp)

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

$(GaudiExamplesDictlibname).$(shlibsuffix) :: $(GaudiExamplesDictlib) requirements $(use_requirements) $(GaudiExamplesDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GaudiExamplesDict $(GaudiExamplesDict_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiExamplesDictshstamp)

$(GaudiExamplesDictshstamp) :: $(GaudiExamplesDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiExamplesDictlibname).$(shlibsuffix) ; then cat /dev/null >$(GaudiExamplesDictshstamp) ; fi

GaudiExamplesDictclean ::
	$(cleanup_echo) objects GaudiExamplesDict
	$(cleanup_silent) /bin/rm -f $(bin)GaudiExamplesDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiExamplesDict.o) $(patsubst %.o,%.dep,$(bin)GaudiExamplesDict.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiExamplesDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiExamplesDict_deps GaudiExamplesDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiExamplesDictinstallname = $(library_prefix)GaudiExamplesDict$(library_suffix).$(shlibsuffix)

GaudiExamplesDict :: GaudiExamplesDictinstall ;

install :: GaudiExamplesDictinstall ;

GaudiExamplesDictinstall :: $(install_dir)/$(GaudiExamplesDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiExamplesDictinstallname) :: $(bin)$(GaudiExamplesDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiExamplesDictclean :: GaudiExamplesDictuninstall

uninstall :: GaudiExamplesDictuninstall ;

GaudiExamplesDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiExamplesDict.d

$(bin)$(binobj)GaudiExamplesDict.d :

$(bin)$(binobj)GaudiExamplesDict.o : $(cmt_final_setup_GaudiExamplesDict)

$(bin)$(binobj)GaudiExamplesDict.o : ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamplesDict_pp_cppflags) $(lib_GaudiExamplesDict_pp_cppflags) $(GaudiExamplesDict_pp_cppflags) $(use_cppflags) $(GaudiExamplesDict_cppflags) $(lib_GaudiExamplesDict_cppflags) $(GaudiExamplesDict_cppflags) $(GaudiExamplesDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiExamples ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp
endif
endif

else
$(bin)GaudiExamplesDict_dependencies.make : $(GaudiExamplesDict_cpp_dependencies)

$(bin)GaudiExamplesDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp

$(bin)$(binobj)GaudiExamplesDict.o : $(GaudiExamplesDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamplesDict_pp_cppflags) $(lib_GaudiExamplesDict_pp_cppflags) $(GaudiExamplesDict_pp_cppflags) $(use_cppflags) $(GaudiExamplesDict_cppflags) $(lib_GaudiExamplesDict_cppflags) $(GaudiExamplesDict_cppflags) $(GaudiExamplesDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiExamples ../armv7l-fc21-gcc49-opt/dict/GaudiExamples/GaudiExamplesDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiExamplesDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiExamplesDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiExamplesDict$(library_suffix).a $(library_prefix)GaudiExamplesDict$(library_suffix).$(shlibsuffix) GaudiExamplesDict.stamp GaudiExamplesDict.shstamp
#-- end of cleanup_library ---------------
