#-- start of make_header -----------------

#====================================
#  Library GaudiMPDict
#
#   Generated Mon Feb 16 20:49:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPDict

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPDict = $(GaudiMP_tag)_GaudiMPDict.make
cmt_local_tagfile_GaudiMPDict = $(bin)$(GaudiMP_tag)_GaudiMPDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPDict = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPDict = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPDict)
#-include $(cmt_local_tagfile_GaudiMPDict)

ifdef cmt_GaudiMPDict_has_target_tag

cmt_final_setup_GaudiMPDict = $(bin)setup_GaudiMPDict.make
cmt_dependencies_in_GaudiMPDict = $(bin)dependencies_GaudiMPDict.in
#cmt_final_setup_GaudiMPDict = $(bin)GaudiMP_GaudiMPDictsetup.make
cmt_local_GaudiMPDict_makefile = $(bin)GaudiMPDict.make

else

cmt_final_setup_GaudiMPDict = $(bin)setup.make
cmt_dependencies_in_GaudiMPDict = $(bin)dependencies.in
#cmt_final_setup_GaudiMPDict = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPDict_makefile = $(bin)GaudiMPDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPDict/
#GaudiMPDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiMPDictlibname   = $(bin)$(library_prefix)GaudiMPDict$(library_suffix)
GaudiMPDictlib       = $(GaudiMPDictlibname).a
GaudiMPDictstamp     = $(bin)GaudiMPDict.stamp
GaudiMPDictshstamp   = $(bin)GaudiMPDict.shstamp

GaudiMPDict :: dirs  GaudiMPDictLIB
	$(echo) "GaudiMPDict ok"

cmt_GaudiMPDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMPDict_has_prototypes

GaudiMPDictprototype :  ;

endif

GaudiMPDictcompile : $(bin)GaudiMPDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GaudiMPDictLIB :: $(GaudiMPDictlib) $(GaudiMPDictshstamp)
	$(echo) "GaudiMPDict : library ok"

$(GaudiMPDictlib) :: $(bin)GaudiMPDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GaudiMPDictlib) $(bin)GaudiMPDict.o
	$(lib_silent) $(ranlib) $(GaudiMPDictlib)
	$(lib_silent) cat /dev/null >$(GaudiMPDictstamp)

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

$(GaudiMPDictlibname).$(shlibsuffix) :: $(GaudiMPDictlib) requirements $(use_requirements) $(GaudiMPDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GaudiMPDict $(GaudiMPDict_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiMPDictshstamp)

$(GaudiMPDictshstamp) :: $(GaudiMPDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiMPDictlibname).$(shlibsuffix) ; then cat /dev/null >$(GaudiMPDictshstamp) ; fi

GaudiMPDictclean ::
	$(cleanup_echo) objects GaudiMPDict
	$(cleanup_silent) /bin/rm -f $(bin)GaudiMPDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiMPDict.o) $(patsubst %.o,%.dep,$(bin)GaudiMPDict.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiMPDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiMPDict_deps GaudiMPDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiMPDictinstallname = $(library_prefix)GaudiMPDict$(library_suffix).$(shlibsuffix)

GaudiMPDict :: GaudiMPDictinstall ;

install :: GaudiMPDictinstall ;

GaudiMPDictinstall :: $(install_dir)/$(GaudiMPDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiMPDictinstallname) :: $(bin)$(GaudiMPDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiMPDictclean :: GaudiMPDictuninstall

uninstall :: GaudiMPDictuninstall ;

GaudiMPDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiMPDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiMPDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiMPDict.d

$(bin)$(binobj)GaudiMPDict.d :

$(bin)$(binobj)GaudiMPDict.o : $(cmt_final_setup_GaudiMPDict)

$(bin)$(binobj)GaudiMPDict.o : ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiMPDict_pp_cppflags) $(lib_GaudiMPDict_pp_cppflags) $(GaudiMPDict_pp_cppflags) $(use_cppflags) $(GaudiMPDict_cppflags) $(lib_GaudiMPDict_cppflags) $(GaudiMPDict_cppflags) $(GaudiMPDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiMP ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp
endif
endif

else
$(bin)GaudiMPDict_dependencies.make : $(GaudiMPDict_cpp_dependencies)

$(bin)GaudiMPDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp

$(bin)$(binobj)GaudiMPDict.o : $(GaudiMPDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiMPDict_pp_cppflags) $(lib_GaudiMPDict_pp_cppflags) $(GaudiMPDict_pp_cppflags) $(use_cppflags) $(GaudiMPDict_cppflags) $(lib_GaudiMPDict_cppflags) $(GaudiMPDict_cppflags) $(GaudiMPDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiMP ../armv7l-fc21-gcc49-opt/dict/GaudiMP/GaudiMPDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiMPDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiMPDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiMPDict$(library_suffix).a $(library_prefix)GaudiMPDict$(library_suffix).$(shlibsuffix) GaudiMPDict.stamp GaudiMPDict.shstamp
#-- end of cleanup_library ---------------
