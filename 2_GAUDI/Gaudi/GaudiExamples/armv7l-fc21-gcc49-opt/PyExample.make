#-- start of make_header -----------------

#====================================
#  Library PyExample
#
#   Generated Mon Feb 16 20:50:01 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PyExample_has_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PyExample_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PyExample

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_PyExample = $(GaudiExamples_tag)_PyExample.make
cmt_local_tagfile_PyExample = $(bin)$(GaudiExamples_tag)_PyExample.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_PyExample = $(GaudiExamples_tag).make
cmt_local_tagfile_PyExample = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_PyExample)
#-include $(cmt_local_tagfile_PyExample)

ifdef cmt_PyExample_has_target_tag

cmt_final_setup_PyExample = $(bin)setup_PyExample.make
cmt_dependencies_in_PyExample = $(bin)dependencies_PyExample.in
#cmt_final_setup_PyExample = $(bin)GaudiExamples_PyExamplesetup.make
cmt_local_PyExample_makefile = $(bin)PyExample.make

else

cmt_final_setup_PyExample = $(bin)setup.make
cmt_dependencies_in_PyExample = $(bin)dependencies.in
#cmt_final_setup_PyExample = $(bin)GaudiExamplessetup.make
cmt_local_PyExample_makefile = $(bin)PyExample.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#PyExample :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PyExample'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PyExample/
#PyExample::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

PyExamplelibname   = $(bin)$(library_prefix)PyExample$(library_suffix)
PyExamplelib       = $(PyExamplelibname).a
PyExamplestamp     = $(bin)PyExample.stamp
PyExampleshstamp   = $(bin)PyExample.shstamp

PyExample :: dirs  PyExampleLIB
	$(echo) "PyExample ok"

cmt_PyExample_has_prototypes = 1

#--------------------------------------

ifdef cmt_PyExample_has_prototypes

PyExampleprototype :  ;

endif

PyExamplecompile : $(bin)Functions.o $(bin)PyExample.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#PyExampleLIB :: $(PyExamplelib) $(PyExampleshstamp)
PyExampleLIB :: $(PyExampleshstamp)
	$(echo) "PyExample : library ok"

$(PyExamplelib) :: $(bin)Functions.o $(bin)PyExample.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(PyExamplelib) $?
	$(lib_silent) $(ranlib) $(PyExamplelib)
	$(lib_silent) cat /dev/null >$(PyExamplestamp)

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

$(PyExamplelibname).$(shlibsuffix) :: $(bin)Functions.o $(bin)PyExample.o $(use_requirements) $(PyExamplestamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)Functions.o $(bin)PyExample.o $(PyExample_shlibflags)
	$(lib_silent) cat /dev/null >$(PyExamplestamp) && \
	  cat /dev/null >$(PyExampleshstamp)

$(PyExampleshstamp) :: $(PyExamplelibname).$(shlibsuffix)
	$(lib_silent) if test -f $(PyExamplelibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(PyExamplestamp) && \
	  cat /dev/null >$(PyExampleshstamp) ; fi

PyExampleclean ::
	$(cleanup_echo) objects PyExample
	$(cleanup_silent) /bin/rm -f $(bin)Functions.o $(bin)PyExample.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Functions.o $(bin)PyExample.o) $(patsubst %.o,%.dep,$(bin)Functions.o $(bin)PyExample.o) $(patsubst %.o,%.d.stamp,$(bin)Functions.o $(bin)PyExample.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf PyExample_deps PyExample_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
PyExampleinstallname = $(library_prefix)PyExample$(library_suffix).$(shlibsuffix)

PyExample :: PyExampleinstall ;

install :: PyExampleinstall ;

PyExampleinstall :: /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload/$(PyExampleinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload/$(PyExampleinstallname) :: $(bin)$(PyExampleinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PyExampleinstallname)" \
	    -out "/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##PyExampleclean :: PyExampleuninstall

uninstall :: PyExampleuninstall ;

PyExampleuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(PyExampleinstallname)" \
	    -out "/home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python/lib-dynload" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq ($(cppdepflags),)

ifneq ($(MAKECMDGOALS),PyExampleclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Functions.d

$(bin)$(binobj)Functions.d :

$(bin)$(binobj)Functions.o : $(cmt_final_setup_PyExample)

$(bin)$(binobj)Functions.o : $(src)PythonModule/Functions.cpp
	$(cpp_echo) $(src)PythonModule/Functions.cpp
	$(cpp_silent) $(cppcomp) $(cppdepflags) -o $@ $(use_pp_cppflags) $(PyExample_pp_cppflags) $(lib_PyExample_pp_cppflags) $(Functions_pp_cppflags) $(use_cppflags) $(PyExample_cppflags) $(lib_PyExample_cppflags) $(Functions_cppflags) $(Functions_cpp_cppflags) -I../src/PythonModule $(src)PythonModule/Functions.cpp
endif
endif

else
$(bin)PyExample_dependencies.make : $(Functions_cpp_dependencies)

$(bin)PyExample_dependencies.make : $(src)PythonModule/Functions.cpp

$(bin)$(binobj)Functions.o : $(Functions_cpp_dependencies)
	$(cpp_echo) $(src)PythonModule/Functions.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PyExample_pp_cppflags) $(lib_PyExample_pp_cppflags) $(Functions_pp_cppflags) $(use_cppflags) $(PyExample_cppflags) $(lib_PyExample_cppflags) $(Functions_cppflags) $(Functions_cpp_cppflags) -I../src/PythonModule $(src)PythonModule/Functions.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq ($(cppdepflags),)

ifneq ($(MAKECMDGOALS),PyExampleclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PyExample.d

$(bin)$(binobj)PyExample.d :

$(bin)$(binobj)PyExample.o : $(cmt_final_setup_PyExample)

$(bin)$(binobj)PyExample.o : $(src)PythonModule/PyExample.cpp
	$(cpp_echo) $(src)PythonModule/PyExample.cpp
	$(cpp_silent) $(cppcomp) $(cppdepflags) -o $@ $(use_pp_cppflags) $(PyExample_pp_cppflags) $(lib_PyExample_pp_cppflags) $(PyExample_pp_cppflags) $(use_cppflags) $(PyExample_cppflags) $(lib_PyExample_cppflags) $(PyExample_cppflags) $(PyExample_cpp_cppflags) -I../src/PythonModule $(src)PythonModule/PyExample.cpp
endif
endif

else
$(bin)PyExample_dependencies.make : $(PyExample_cpp_dependencies)

$(bin)PyExample_dependencies.make : $(src)PythonModule/PyExample.cpp

$(bin)$(binobj)PyExample.o : $(PyExample_cpp_dependencies)
	$(cpp_echo) $(src)PythonModule/PyExample.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(PyExample_pp_cppflags) $(lib_PyExample_pp_cppflags) $(PyExample_pp_cppflags) $(use_cppflags) $(PyExample_cppflags) $(lib_PyExample_cppflags) $(PyExample_cppflags) $(PyExample_cpp_cppflags) -I../src/PythonModule $(src)PythonModule/PyExample.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: PyExampleclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PyExample.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PyExampleclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library PyExample
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)PyExample$(library_suffix).a $(library_prefix)PyExample$(library_suffix).$(shlibsuffix) PyExample.stamp PyExample.shstamp
#-- end of cleanup_library ---------------
