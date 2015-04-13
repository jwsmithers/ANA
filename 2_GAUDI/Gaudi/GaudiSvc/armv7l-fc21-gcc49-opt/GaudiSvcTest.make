#-- start of make_header -----------------

#====================================
#  Library GaudiSvcTest
#
#   Generated Mon Feb 16 19:54:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcTest_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcTest_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcTest

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTest = $(GaudiSvc_tag)_GaudiSvcTest.make
cmt_local_tagfile_GaudiSvcTest = $(bin)$(GaudiSvc_tag)_GaudiSvcTest.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTest = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcTest = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcTest)
#-include $(cmt_local_tagfile_GaudiSvcTest)

ifdef cmt_GaudiSvcTest_has_target_tag

cmt_final_setup_GaudiSvcTest = $(bin)setup_GaudiSvcTest.make
cmt_dependencies_in_GaudiSvcTest = $(bin)dependencies_GaudiSvcTest.in
#cmt_final_setup_GaudiSvcTest = $(bin)GaudiSvc_GaudiSvcTestsetup.make
cmt_local_GaudiSvcTest_makefile = $(bin)GaudiSvcTest.make

else

cmt_final_setup_GaudiSvcTest = $(bin)setup.make
cmt_dependencies_in_GaudiSvcTest = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcTest = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcTest_makefile = $(bin)GaudiSvcTest.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcTest :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcTest'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcTest/
#GaudiSvcTest::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiSvcTestlibname   = $(bin)$(library_prefix)GaudiSvcTest$(library_suffix)
GaudiSvcTestlib       = $(GaudiSvcTestlibname).a
GaudiSvcTeststamp     = $(bin)GaudiSvcTest.stamp
GaudiSvcTestshstamp   = $(bin)GaudiSvcTest.shstamp

GaudiSvcTest :: dirs  GaudiSvcTestLIB
	$(echo) "GaudiSvcTest ok"

cmt_GaudiSvcTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiSvcTest_has_prototypes

GaudiSvcTestprototype :  ;

endif

GaudiSvcTestcompile : $(bin)CounterTestAlg.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiSvcTestLIB :: $(GaudiSvcTestlib) $(GaudiSvcTestshstamp)
GaudiSvcTestLIB :: $(GaudiSvcTestshstamp)
	$(echo) "GaudiSvcTest : library ok"

$(GaudiSvcTestlib) :: $(bin)CounterTestAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiSvcTestlib) $?
	$(lib_silent) $(ranlib) $(GaudiSvcTestlib)
	$(lib_silent) cat /dev/null >$(GaudiSvcTeststamp)

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

$(GaudiSvcTestlibname).$(shlibsuffix) :: $(bin)CounterTestAlg.o $(use_requirements) $(GaudiSvcTeststamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)CounterTestAlg.o $(GaudiSvcTest_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiSvcTeststamp) && \
	  cat /dev/null >$(GaudiSvcTestshstamp)

$(GaudiSvcTestshstamp) :: $(GaudiSvcTestlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiSvcTestlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiSvcTeststamp) && \
	  cat /dev/null >$(GaudiSvcTestshstamp) ; fi

GaudiSvcTestclean ::
	$(cleanup_echo) objects GaudiSvcTest
	$(cleanup_silent) /bin/rm -f $(bin)CounterTestAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)CounterTestAlg.o) $(patsubst %.o,%.dep,$(bin)CounterTestAlg.o) $(patsubst %.o,%.d.stamp,$(bin)CounterTestAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiSvcTest_deps GaudiSvcTest_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiSvcTestinstallname = $(library_prefix)GaudiSvcTest$(library_suffix).$(shlibsuffix)

GaudiSvcTest :: GaudiSvcTestinstall ;

install :: GaudiSvcTestinstall ;

GaudiSvcTestinstall :: $(install_dir)/$(GaudiSvcTestinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiSvcTestinstallname) :: $(bin)$(GaudiSvcTestinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiSvcTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiSvcTestclean :: GaudiSvcTestuninstall

uninstall :: GaudiSvcTestuninstall ;

GaudiSvcTestuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiSvcTestinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcTestclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CounterTestAlg.d

$(bin)$(binobj)CounterTestAlg.d :

$(bin)$(binobj)CounterTestAlg.o : $(cmt_final_setup_GaudiSvcTest)

$(bin)$(binobj)CounterTestAlg.o : ../tests/src/component/CounterTestAlg.cpp
	$(cpp_echo) ../tests/src/component/CounterTestAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvcTest_pp_cppflags) $(lib_GaudiSvcTest_pp_cppflags) $(CounterTestAlg_pp_cppflags) $(use_cppflags) $(GaudiSvcTest_cppflags) $(lib_GaudiSvcTest_cppflags) $(CounterTestAlg_cppflags) $(CounterTestAlg_cpp_cppflags) -I../tests/src/component ../tests/src/component/CounterTestAlg.cpp
endif
endif

else
$(bin)GaudiSvcTest_dependencies.make : $(CounterTestAlg_cpp_dependencies)

$(bin)GaudiSvcTest_dependencies.make : ../tests/src/component/CounterTestAlg.cpp

$(bin)$(binobj)CounterTestAlg.o : $(CounterTestAlg_cpp_dependencies)
	$(cpp_echo) ../tests/src/component/CounterTestAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvcTest_pp_cppflags) $(lib_GaudiSvcTest_pp_cppflags) $(CounterTestAlg_pp_cppflags) $(use_cppflags) $(GaudiSvcTest_cppflags) $(lib_GaudiSvcTest_cppflags) $(CounterTestAlg_cppflags) $(CounterTestAlg_cpp_cppflags) -I../tests/src/component ../tests/src/component/CounterTestAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiSvcTestclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcTest.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcTestclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiSvcTest
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiSvcTest$(library_suffix).a $(library_prefix)GaudiSvcTest$(library_suffix).$(shlibsuffix) GaudiSvcTest.stamp GaudiSvcTest.shstamp
#-- end of cleanup_library ---------------
