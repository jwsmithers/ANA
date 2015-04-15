#-- start of make_header -----------------

#====================================
#  Library lcg_PyCoolDict
#
#   Generated Wed Apr 15 17:02:17 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_PyCoolDict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_PyCoolDict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_PyCoolDict

PyCool_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoolDict = $(PyCool_tag)_lcg_PyCoolDict.make
cmt_local_tagfile_lcg_PyCoolDict = $(bin)$(PyCool_tag)_lcg_PyCoolDict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCool_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoolDict = $(PyCool_tag).make
cmt_local_tagfile_lcg_PyCoolDict = $(bin)$(PyCool_tag).make

endif

include $(cmt_local_tagfile_lcg_PyCoolDict)
#-include $(cmt_local_tagfile_lcg_PyCoolDict)

ifdef cmt_lcg_PyCoolDict_has_target_tag

cmt_final_setup_lcg_PyCoolDict = $(bin)setup_lcg_PyCoolDict.make
cmt_dependencies_in_lcg_PyCoolDict = $(bin)dependencies_lcg_PyCoolDict.in
#cmt_final_setup_lcg_PyCoolDict = $(bin)PyCool_lcg_PyCoolDictsetup.make
cmt_local_lcg_PyCoolDict_makefile = $(bin)lcg_PyCoolDict.make

else

cmt_final_setup_lcg_PyCoolDict = $(bin)setup.make
cmt_dependencies_in_lcg_PyCoolDict = $(bin)dependencies.in
#cmt_final_setup_lcg_PyCoolDict = $(bin)PyCoolsetup.make
cmt_local_lcg_PyCoolDict_makefile = $(bin)lcg_PyCoolDict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoolsetup.make

#lcg_PyCoolDict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_PyCoolDict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_PyCoolDict/
#lcg_PyCoolDict::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_PyCoolDictlibname   = $(bin)$(library_prefix)lcg_PyCoolDict$(library_suffix)
lcg_PyCoolDictlib       = $(lcg_PyCoolDictlibname).a
lcg_PyCoolDictstamp     = $(bin)lcg_PyCoolDict.stamp
lcg_PyCoolDictshstamp   = $(bin)lcg_PyCoolDict.shstamp

lcg_PyCoolDict :: dirs  lcg_PyCoolDictLIB
	$(echo) "lcg_PyCoolDict ok"

cmt_lcg_PyCoolDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_PyCoolDict_has_prototypes

lcg_PyCoolDictprototype :  ;

endif

lcg_PyCoolDictcompile : $(bin)lcg_PyCoolDict.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_PyCoolDictLIB :: $(lcg_PyCoolDictlib) $(lcg_PyCoolDictshstamp)
	@/bin/echo "------> lcg_PyCoolDict : library ok"

$(lcg_PyCoolDictlib) :: $(bin)lcg_PyCoolDict.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_PyCoolDictlib) $?
	$(lib_silent) $(ranlib) $(lcg_PyCoolDictlib)
	$(lib_silent) cat /dev/null >$(lcg_PyCoolDictstamp)

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

$(lcg_PyCoolDictlibname).$(shlibsuffix) :: $(lcg_PyCoolDictlib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_PyCoolDict $(lcg_PyCoolDict_shlibflags)

$(lcg_PyCoolDictshstamp) :: $(lcg_PyCoolDictlibname).$(shlibsuffix)
	@if test -f $(lcg_PyCoolDictlibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_PyCoolDictshstamp) ; fi

lcg_PyCoolDictclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)lcg_PyCoolDict.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_PyCoolDictinstallname = $(library_prefix)lcg_PyCoolDict$(library_suffix).$(shlibsuffix)

lcg_PyCoolDict :: lcg_PyCoolDictinstall

install :: lcg_PyCoolDictinstall

lcg_PyCoolDictinstall :: $(install_dir)/$(lcg_PyCoolDictinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_PyCoolDictinstallname) :: $(bin)$(lcg_PyCoolDictinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_PyCoolDictinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_PyCoolDictclean :: lcg_PyCoolDictuninstall

uninstall :: lcg_PyCoolDictuninstall

lcg_PyCoolDictuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_PyCoolDictinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_PyCoolDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_PyCoolDictprototype)

$(bin)lcg_PyCoolDict_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_PyCoolDict)
	$(echo) "(lcg_PyCoolDict.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp -end_all $(includes) $(app_lcg_PyCoolDict_cppflags) $(lib_lcg_PyCoolDict_cppflags) -name=lcg_PyCoolDict $? -f=$(cmt_dependencies_in_lcg_PyCoolDict) -without_cmt

-include $(bin)lcg_PyCoolDict_dependencies.make

endif
endif
endif

lcg_PyCoolDictclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_PyCoolDict_deps $(bin)lcg_PyCoolDict_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoolDictclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)lcg_PyCoolDict.d

$(bin)$(binobj)lcg_PyCoolDict.d :

$(bin)$(binobj)lcg_PyCoolDict.o : $(cmt_final_setup_lcg_PyCoolDict)

$(bin)$(binobj)lcg_PyCoolDict.o : ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoolDict_pp_cppflags) $(lib_lcg_PyCoolDict_pp_cppflags) $(lcg_PyCoolDict_pp_cppflags) $(use_cppflags) $(lcg_PyCoolDict_cppflags) $(lib_lcg_PyCoolDict_cppflags) $(lcg_PyCoolDict_cppflags) $(lcg_PyCoolDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/lcg_PyCool ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp
endif
endif

else
$(bin)lcg_PyCoolDict_dependencies.make : $(lcg_PyCoolDict_cpp_dependencies)

$(bin)lcg_PyCoolDict_dependencies.make : ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp

$(bin)$(binobj)lcg_PyCoolDict.o : $(lcg_PyCoolDict_cpp_dependencies)
	$(cpp_echo) ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoolDict_pp_cppflags) $(lib_lcg_PyCoolDict_pp_cppflags) $(lcg_PyCoolDict_pp_cppflags) $(use_cppflags) $(lcg_PyCoolDict_cppflags) $(lib_lcg_PyCoolDict_cppflags) $(lcg_PyCoolDict_cppflags) $(lcg_PyCoolDict_cpp_cppflags) -I../armv7l-fc21-gcc49-opt/dict/lcg_PyCool ../armv7l-fc21-gcc49-opt/dict/lcg_PyCool/lcg_PyCoolDict.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_PyCoolDictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_PyCoolDict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_PyCoolDictclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_PyCoolDict
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_PyCoolDict$(library_suffix).a $(library_prefix)lcg_PyCoolDict$(library_suffix).$(shlibsuffix) lcg_PyCoolDict.stamp lcg_PyCoolDict.shstamp
#-- end of cleanup_library ---------------
