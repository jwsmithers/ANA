#-- start of make_header -----------------

#====================================
#  Library RootCnvDict
#
#   Generated Mon Feb 16 20:00:37 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvDict

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvDict = $(RootCnv_tag)_RootCnvDict.make
cmt_local_tagfile_RootCnvDict = $(bin)$(RootCnv_tag)_RootCnvDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvDict = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvDict = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvDict)
#-include $(cmt_local_tagfile_RootCnvDict)

ifdef cmt_RootCnvDict_has_target_tag

cmt_final_setup_RootCnvDict = $(bin)setup_RootCnvDict.make
cmt_dependencies_in_RootCnvDict = $(bin)dependencies_RootCnvDict.in
#cmt_final_setup_RootCnvDict = $(bin)RootCnv_RootCnvDictsetup.make
cmt_local_RootCnvDict_makefile = $(bin)RootCnvDict.make

else

cmt_final_setup_RootCnvDict = $(bin)setup.make
cmt_dependencies_in_RootCnvDict = $(bin)dependencies.in
#cmt_final_setup_RootCnvDict = $(bin)RootCnvsetup.make
cmt_local_RootCnvDict_makefile = $(bin)RootCnvDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvDict/
#RootCnvDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootCnvDictlibname   = $(bin)$(library_prefix)RootCnvDict$(library_suffix)
RootCnvDictlib       = $(RootCnvDictlibname).a
RootCnvDictstamp     = $(bin)RootCnvDict.stamp
RootCnvDictshstamp   = $(bin)RootCnvDict.shstamp

RootCnvDict :: dirs  RootCnvDictLIB
	$(echo) "RootCnvDict ok"

cmt_RootCnvDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnvDict_has_prototypes

RootCnvDictprototype :  ;

endif

RootCnvDictcompile : $(bin)RootCnvDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

RootCnvDictLIB :: $(RootCnvDictlib) $(RootCnvDictshstamp)
	$(echo) "RootCnvDict : library ok"

$(RootCnvDictlib) :: $(bin)RootCnvDict.o
	$(lib_echo) "static library $@"
	$(lib_silent) [ ! -f $@ ] || \rm -f $@
	$(lib_silent) $(ar) $(RootCnvDictlib) $(bin)RootCnvDict.o
	$(lib_silent) $(ranlib) $(RootCnvDictlib)
	$(lib_silent) cat /dev/null >$(RootCnvDictstamp)

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

$(RootCnvDictlibname).$(shlibsuffix) :: $(RootCnvDictlib) requirements $(use_requirements) $(RootCnvDictstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) if test "$(makecmd)"; then QUIET=; else QUIET=1; fi; QUIET=$${QUIET} bin="$(bin)" ld="$(shlibbuilder)" ldflags="$(shlibflags)" suffix=$(shlibsuffix) libprefix=$(library_prefix) libsuffix=$(library_suffix) $(make_shlib) "$(tags)" RootCnvDict $(RootCnvDict_shlibflags)
	$(lib_silent) cat /dev/null >$(RootCnvDictshstamp)

$(RootCnvDictshstamp) :: $(RootCnvDictlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootCnvDictlibname).$(shlibsuffix) ; then cat /dev/null >$(RootCnvDictshstamp) ; fi

RootCnvDictclean ::
	$(cleanup_echo) objects RootCnvDict
	$(cleanup_silent) /bin/rm -f $(bin)RootCnvDict.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootCnvDict.o) $(patsubst %.o,%.dep,$(bin)RootCnvDict.o) $(patsubst %.o,%.d.stamp,$(bin)RootCnvDict.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootCnvDict_deps RootCnvDict_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootCnvDictinstallname = $(library_prefix)RootCnvDict$(library_suffix).$(shlibsuffix)

RootCnvDict :: RootCnvDictinstall ;

install :: RootCnvDictinstall ;

RootCnvDictinstall :: $(install_dir)/$(RootCnvDictinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootCnvDictinstallname) :: $(bin)$(RootCnvDictinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootCnvDictclean :: RootCnvDictuninstall

uninstall :: RootCnvDictuninstall ;

RootCnvDictuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvDictinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of libary -----------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootCnvDict.d

$(bin)$(binobj)RootCnvDict.d :

$(bin)$(binobj)RootCnvDict.o : $(cmt_final_setup_RootCnvDict)

$(bin)$(binobj)RootCnvDict.o : ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnvDict_pp_cppflags) $(lib_RootCnvDict_pp_cppflags) $(RootCnvDict_pp_cppflags) $(use_cppflags) $(RootCnvDict_cppflags) $(lib_RootCnvDict_cppflags) $(RootCnvDict_cppflags) $(RootCnvDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/RootCnv ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp
endif
endif

else
$(bin)RootCnvDict_dependencies.make : $(RootCnvDict_cpp_dependencies)

$(bin)RootCnvDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp

$(bin)$(binobj)RootCnvDict.o : $(RootCnvDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnvDict_pp_cppflags) $(lib_RootCnvDict_pp_cppflags) $(RootCnvDict_pp_cppflags) $(use_cppflags) $(RootCnvDict_cppflags) $(lib_RootCnvDict_cppflags) $(RootCnvDict_cppflags) $(RootCnvDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/RootCnv ../armv7l-fc21-gcc49-opt/dict/RootCnv/RootCnvDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootCnvDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootCnvDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootCnvDict$(library_suffix).a $(library_prefix)RootCnvDict$(library_suffix).$(shlibsuffix) RootCnvDict.stamp RootCnvDict.shstamp
#-- end of cleanup_library ---------------
