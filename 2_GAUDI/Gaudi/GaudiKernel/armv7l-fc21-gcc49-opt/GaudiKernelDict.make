#-- start of make_header -----------------

#====================================
#  Library GaudiKernelDict
#
#   Generated Mon Feb 16 19:32:59 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiKernelDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiKernelDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiKernelDict

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernelDict = $(GaudiKernel_tag)_GaudiKernelDict.make
cmt_local_tagfile_GaudiKernelDict = $(bin)$(GaudiKernel_tag)_GaudiKernelDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernelDict = $(GaudiKernel_tag).make
cmt_local_tagfile_GaudiKernelDict = $(bin)$(GaudiKernel_tag).make

endif

include $(cmt_local_tagfile_GaudiKernelDict)
#-include $(cmt_local_tagfile_GaudiKernelDict)

ifdef cmt_GaudiKernelDict_has_target_tag

cmt_final_setup_GaudiKernelDict = $(bin)setup_GaudiKernelDict.make
cmt_dependencies_in_GaudiKernelDict = $(bin)dependencies_GaudiKernelDict.in
#cmt_final_setup_GaudiKernelDict = $(bin)GaudiKernel_GaudiKernelDictsetup.make
cmt_local_GaudiKernelDict_makefile = $(bin)GaudiKernelDict.make

else

cmt_final_setup_GaudiKernelDict = $(bin)setup.make
cmt_dependencies_in_GaudiKernelDict = $(bin)dependencies.in
#cmt_final_setup_GaudiKernelDict = $(bin)GaudiKernelsetup.make
cmt_local_GaudiKernelDict_makefile = $(bin)GaudiKernelDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make

#GaudiKernelDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiKernelDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiKernelDict/
#GaudiKernelDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiKernelDictlibname   = $(bin)$(library_prefix)GaudiKernelDict$(library_suffix)
GaudiKernelDictlib       = $(GaudiKernelDictlibname).a
GaudiKernelDictstamp     = $(bin)GaudiKernelDict.stamp
GaudiKernelDictshstamp   = $(bin)GaudiKernelDict.shstamp

GaudiKernelDict :: dirs  GaudiKernelDictLIB
	$(echo) "GaudiKernelDict ok"

cmt_GaudiKernelDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiKernelDict_has_prototypes

GaudiKernelDictprototype :  ;

endif

GaudiKernelDictcompile : $(bin)GaudiKernelDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GaudiKernelDictLIB :: $(GaudiKernelDictlib) $(GaudiKernelDictshstamp)
	$(echo) "GaudiKernelDict : library ok"

$(GaudiKernelDictlib) :: $(bin)GaudiKernelDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GaudiKernelDictlib) $(bin)GaudiKernelDict.o
	$(lib_silent) $(ranlib) $(GaudiKernelDictlib)
	$(lib_silent) cat /dev/null >$(GaudiKernelDictstamp)

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

$(GaudiKernelDictlibname).$(shlibsuffix) :: $(GaudiKernelDictlib) requirements $(use_requirements) $(GaudiKernelDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GaudiKernelDict $(GaudiKernelDict_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiKernelDictshstamp)

$(GaudiKernelDictshstamp) :: $(GaudiKernelDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiKernelDictlibname).$(shlibsuffix) ; then cat /dev/null >$(GaudiKernelDictshstamp) ; fi

GaudiKernelDictclean ::
	$(cleanup_echo) objects GaudiKernelDict
	$(cleanup_silent) /bin/rm -f $(bin)GaudiKernelDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiKernelDict.o) $(patsubst %.o,%.dep,$(bin)GaudiKernelDict.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiKernelDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiKernelDict_deps GaudiKernelDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiKernelDictinstallname = $(library_prefix)GaudiKernelDict$(library_suffix).$(shlibsuffix)

GaudiKernelDict :: GaudiKernelDictinstall ;

install :: GaudiKernelDictinstall ;

GaudiKernelDictinstall :: $(install_dir)/$(GaudiKernelDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiKernelDictinstallname) :: $(bin)$(GaudiKernelDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiKernelDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiKernelDictclean :: GaudiKernelDictuninstall

uninstall :: GaudiKernelDictuninstall ;

GaudiKernelDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiKernelDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiKernelDict.d

$(bin)$(binobj)GaudiKernelDict.d :

$(bin)$(binobj)GaudiKernelDict.o : $(cmt_final_setup_GaudiKernelDict)

$(bin)$(binobj)GaudiKernelDict.o : ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernelDict_pp_cppflags) $(lib_GaudiKernelDict_pp_cppflags) $(GaudiKernelDict_pp_cppflags) $(use_cppflags) $(GaudiKernelDict_cppflags) $(lib_GaudiKernelDict_cppflags) $(GaudiKernelDict_cppflags) $(GaudiKernelDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiKernel ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp
endif
endif

else
$(bin)GaudiKernelDict_dependencies.make : $(GaudiKernelDict_cpp_dependencies)

$(bin)GaudiKernelDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp

$(bin)$(binobj)GaudiKernelDict.o : $(GaudiKernelDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernelDict_pp_cppflags) $(lib_GaudiKernelDict_pp_cppflags) $(GaudiKernelDict_pp_cppflags) $(use_cppflags) $(GaudiKernelDict_cppflags) $(lib_GaudiKernelDict_cppflags) $(GaudiKernelDict_cppflags) $(GaudiKernelDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiKernel ../armv7l-fc21-gcc49-opt/dict/GaudiKernel/GaudiKernelDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiKernelDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiKernelDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiKernelDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiKernelDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiKernelDict$(library_suffix).a $(library_prefix)GaudiKernelDict$(library_suffix).$(shlibsuffix) GaudiKernelDict.stamp GaudiKernelDict.shstamp
#-- end of cleanup_library ---------------
