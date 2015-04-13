#-- start of make_header -----------------

#====================================
#  Library GaudiGSLMathDict
#
#   Generated Mon Feb 16 20:18:25 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLMathDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLMathDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLMathDict

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMathDict = $(GaudiGSL_tag)_GaudiGSLMathDict.make
cmt_local_tagfile_GaudiGSLMathDict = $(bin)$(GaudiGSL_tag)_GaudiGSLMathDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMathDict = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLMathDict = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLMathDict)
#-include $(cmt_local_tagfile_GaudiGSLMathDict)

ifdef cmt_GaudiGSLMathDict_has_target_tag

cmt_final_setup_GaudiGSLMathDict = $(bin)setup_GaudiGSLMathDict.make
cmt_dependencies_in_GaudiGSLMathDict = $(bin)dependencies_GaudiGSLMathDict.in
#cmt_final_setup_GaudiGSLMathDict = $(bin)GaudiGSL_GaudiGSLMathDictsetup.make
cmt_local_GaudiGSLMathDict_makefile = $(bin)GaudiGSLMathDict.make

else

cmt_final_setup_GaudiGSLMathDict = $(bin)setup.make
cmt_dependencies_in_GaudiGSLMathDict = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLMathDict = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLMathDict_makefile = $(bin)GaudiGSLMathDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLMathDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLMathDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLMathDict/
#GaudiGSLMathDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiGSLMathDictlibname   = $(bin)$(library_prefix)GaudiGSLMathDict$(library_suffix)
GaudiGSLMathDictlib       = $(GaudiGSLMathDictlibname).a
GaudiGSLMathDictstamp     = $(bin)GaudiGSLMathDict.stamp
GaudiGSLMathDictshstamp   = $(bin)GaudiGSLMathDict.shstamp

GaudiGSLMathDict :: dirs  GaudiGSLMathDictLIB
	$(echo) "GaudiGSLMathDict ok"

cmt_GaudiGSLMathDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSLMathDict_has_prototypes

GaudiGSLMathDictprototype :  ;

endif

GaudiGSLMathDictcompile : $(bin)GaudiGSLMathDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

GaudiGSLMathDictLIB :: $(GaudiGSLMathDictlib) $(GaudiGSLMathDictshstamp)
	$(echo) "GaudiGSLMathDict : library ok"

$(GaudiGSLMathDictlib) :: $(bin)GaudiGSLMathDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(GaudiGSLMathDictlib) $(bin)GaudiGSLMathDict.o
	$(lib_silent) $(ranlib) $(GaudiGSLMathDictlib)
	$(lib_silent) cat /dev/null >$(GaudiGSLMathDictstamp)

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

$(GaudiGSLMathDictlibname).$(shlibsuffix) :: $(GaudiGSLMathDictlib) requirements $(use_requirements) $(GaudiGSLMathDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" GaudiGSLMathDict $(GaudiGSLMathDict_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiGSLMathDictshstamp)

$(GaudiGSLMathDictshstamp) :: $(GaudiGSLMathDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiGSLMathDictlibname).$(shlibsuffix) ; then cat /dev/null >$(GaudiGSLMathDictshstamp) ; fi

GaudiGSLMathDictclean ::
	$(cleanup_echo) objects GaudiGSLMathDict
	$(cleanup_silent) /bin/rm -f $(bin)GaudiGSLMathDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiGSLMathDict.o) $(patsubst %.o,%.dep,$(bin)GaudiGSLMathDict.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiGSLMathDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiGSLMathDict_deps GaudiGSLMathDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiGSLMathDictinstallname = $(library_prefix)GaudiGSLMathDict$(library_suffix).$(shlibsuffix)

GaudiGSLMathDict :: GaudiGSLMathDictinstall ;

install :: GaudiGSLMathDictinstall ;

GaudiGSLMathDictinstall :: $(install_dir)/$(GaudiGSLMathDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiGSLMathDictinstallname) :: $(bin)$(GaudiGSLMathDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLMathDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiGSLMathDictclean :: GaudiGSLMathDictuninstall

uninstall :: GaudiGSLMathDictuninstall ;

GaudiGSLMathDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLMathDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLMathDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiGSLMathDict.d

$(bin)$(binobj)GaudiGSLMathDict.d :

$(bin)$(binobj)GaudiGSLMathDict.o : $(cmt_final_setup_GaudiGSLMathDict)

$(bin)$(binobj)GaudiGSLMathDict.o : ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLMathDict_pp_cppflags) $(lib_GaudiGSLMathDict_pp_cppflags) $(GaudiGSLMathDict_pp_cppflags) $(use_cppflags) $(GaudiGSLMathDict_cppflags) $(lib_GaudiGSLMathDict_cppflags) $(GaudiGSLMathDict_cppflags) $(GaudiGSLMathDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp
endif
endif

else
$(bin)GaudiGSLMathDict_dependencies.make : $(GaudiGSLMathDict_cpp_dependencies)

$(bin)GaudiGSLMathDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp

$(bin)$(binobj)GaudiGSLMathDict.o : $(GaudiGSLMathDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLMathDict_pp_cppflags) $(lib_GaudiGSLMathDict_pp_cppflags) $(GaudiGSLMathDict_pp_cppflags) $(use_cppflags) $(GaudiGSLMathDict_cppflags) $(lib_GaudiGSLMathDict_cppflags) $(GaudiGSLMathDict_cppflags) $(GaudiGSLMathDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath ../armv7l-fc21-gcc49-opt/dict/GaudiGSLMath/GaudiGSLMathDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiGSLMathDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLMathDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLMathDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiGSLMathDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiGSLMathDict$(library_suffix).a $(library_prefix)GaudiGSLMathDict$(library_suffix).$(shlibsuffix) GaudiGSLMathDict.stamp GaudiGSLMathDict.shstamp
#-- end of cleanup_library ---------------
