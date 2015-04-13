#-- start of make_header -----------------

#====================================
#  Library GaudiPythonLib
#
#   Generated Mon Feb 16 20:23:14 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonLib

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonLib = $(GaudiPython_tag)_GaudiPythonLib.make
cmt_local_tagfile_GaudiPythonLib = $(bin)$(GaudiPython_tag)_GaudiPythonLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonLib = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonLib = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonLib)
#-include $(cmt_local_tagfile_GaudiPythonLib)

ifdef cmt_GaudiPythonLib_has_target_tag

cmt_final_setup_GaudiPythonLib = $(bin)setup_GaudiPythonLib.make
cmt_dependencies_in_GaudiPythonLib = $(bin)dependencies_GaudiPythonLib.in
#cmt_final_setup_GaudiPythonLib = $(bin)GaudiPython_GaudiPythonLibsetup.make
cmt_local_GaudiPythonLib_makefile = $(bin)GaudiPythonLib.make

else

cmt_final_setup_GaudiPythonLib = $(bin)setup.make
cmt_dependencies_in_GaudiPythonLib = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonLib = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonLib_makefile = $(bin)GaudiPythonLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonLib/
#GaudiPythonLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiPythonLiblibname   = $(bin)$(library_prefix)GaudiPythonLib$(library_suffix)
GaudiPythonLiblib       = $(GaudiPythonLiblibname).a
GaudiPythonLibstamp     = $(bin)GaudiPythonLib.stamp
GaudiPythonLibshstamp   = $(bin)GaudiPythonLib.shstamp

GaudiPythonLib :: dirs  GaudiPythonLibLIB
	$(echo) "GaudiPythonLib ok"

cmt_GaudiPythonLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPythonLib_has_prototypes

GaudiPythonLibprototype :  ;

endif

GaudiPythonLibcompile : $(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiPythonLibLIB :: $(GaudiPythonLiblib) $(GaudiPythonLibshstamp)
GaudiPythonLibLIB :: $(GaudiPythonLibshstamp)
	$(echo) "GaudiPythonLib : library ok"

$(GaudiPythonLiblib) :: $(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiPythonLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiPythonLiblib)
	$(lib_silent) cat /dev/null >$(GaudiPythonLibstamp)

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

$(GaudiPythonLiblibname).$(shlibsuffix) :: $(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o $(use_requirements) $(GaudiPythonLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o $(GaudiPythonLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiPythonLibstamp) && \
	  cat /dev/null >$(GaudiPythonLibshstamp)

$(GaudiPythonLibshstamp) :: $(GaudiPythonLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiPythonLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiPythonLibstamp) && \
	  cat /dev/null >$(GaudiPythonLibshstamp) ; fi

GaudiPythonLibclean ::
	$(cleanup_echo) objects GaudiPythonLib
	$(cleanup_silent) /bin/rm -f $(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o) $(patsubst %.o,%.dep,$(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o) $(patsubst %.o,%.d.stamp,$(bin)AlgDecorators.o $(bin)Algorithm.o $(bin)HistoDecorator.o $(bin)TupleDecorator.o $(bin)Helpers.o $(bin)CallbackStreamBuf.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiPythonLib_deps GaudiPythonLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiPythonLibinstallname = $(library_prefix)GaudiPythonLib$(library_suffix).$(shlibsuffix)

GaudiPythonLib :: GaudiPythonLibinstall ;

install :: GaudiPythonLibinstall ;

GaudiPythonLibinstall :: $(install_dir)/$(GaudiPythonLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiPythonLibinstallname) :: $(bin)$(GaudiPythonLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythonLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiPythonLibclean :: GaudiPythonLibuninstall

uninstall :: GaudiPythonLibuninstall ;

GaudiPythonLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPythonLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgDecorators.d

$(bin)$(binobj)AlgDecorators.d :

$(bin)$(binobj)AlgDecorators.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)AlgDecorators.o : $(src)Lib/AlgDecorators.cpp
	$(cpp_echo) $(src)Lib/AlgDecorators.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(AlgDecorators_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(AlgDecorators_cppflags) $(AlgDecorators_cpp_cppflags) -I../src/Lib $(src)Lib/AlgDecorators.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(AlgDecorators_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/AlgDecorators.cpp

$(bin)$(binobj)AlgDecorators.o : $(AlgDecorators_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AlgDecorators.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(AlgDecorators_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(AlgDecorators_cppflags) $(AlgDecorators_cpp_cppflags) -I../src/Lib $(src)Lib/AlgDecorators.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Algorithm.d

$(bin)$(binobj)Algorithm.d :

$(bin)$(binobj)Algorithm.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)Algorithm.o : $(src)Lib/Algorithm.cpp
	$(cpp_echo) $(src)Lib/Algorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(Algorithm_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(Algorithm_cppflags) $(Algorithm_cpp_cppflags) -I../src/Lib $(src)Lib/Algorithm.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(Algorithm_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/Algorithm.cpp

$(bin)$(binobj)Algorithm.o : $(Algorithm_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Algorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(Algorithm_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(Algorithm_cppflags) $(Algorithm_cpp_cppflags) -I../src/Lib $(src)Lib/Algorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoDecorator.d

$(bin)$(binobj)HistoDecorator.d :

$(bin)$(binobj)HistoDecorator.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)HistoDecorator.o : $(src)Lib/HistoDecorator.cpp
	$(cpp_echo) $(src)Lib/HistoDecorator.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(HistoDecorator_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(HistoDecorator_cppflags) $(HistoDecorator_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDecorator.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(HistoDecorator_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/HistoDecorator.cpp

$(bin)$(binobj)HistoDecorator.o : $(HistoDecorator_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoDecorator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(HistoDecorator_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(HistoDecorator_cppflags) $(HistoDecorator_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDecorator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleDecorator.d

$(bin)$(binobj)TupleDecorator.d :

$(bin)$(binobj)TupleDecorator.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)TupleDecorator.o : $(src)Lib/TupleDecorator.cpp
	$(cpp_echo) $(src)Lib/TupleDecorator.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(TupleDecorator_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(TupleDecorator_cppflags) $(TupleDecorator_cpp_cppflags) -I../src/Lib $(src)Lib/TupleDecorator.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(TupleDecorator_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/TupleDecorator.cpp

$(bin)$(binobj)TupleDecorator.o : $(TupleDecorator_cpp_dependencies)
	$(cpp_echo) $(src)Lib/TupleDecorator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(TupleDecorator_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(TupleDecorator_cppflags) $(TupleDecorator_cpp_cppflags) -I../src/Lib $(src)Lib/TupleDecorator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Helpers.d

$(bin)$(binobj)Helpers.d :

$(bin)$(binobj)Helpers.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)Helpers.o : $(src)Lib/Helpers.cpp
	$(cpp_echo) $(src)Lib/Helpers.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(Helpers_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(Helpers_cppflags) $(Helpers_cpp_cppflags) -I../src/Lib $(src)Lib/Helpers.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(Helpers_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/Helpers.cpp

$(bin)$(binobj)Helpers.o : $(Helpers_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Helpers.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(Helpers_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(Helpers_cppflags) $(Helpers_cpp_cppflags) -I../src/Lib $(src)Lib/Helpers.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPythonLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CallbackStreamBuf.d

$(bin)$(binobj)CallbackStreamBuf.d :

$(bin)$(binobj)CallbackStreamBuf.o : $(cmt_final_setup_GaudiPythonLib)

$(bin)$(binobj)CallbackStreamBuf.o : $(src)Lib/CallbackStreamBuf.cpp
	$(cpp_echo) $(src)Lib/CallbackStreamBuf.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(CallbackStreamBuf_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(CallbackStreamBuf_cppflags) $(CallbackStreamBuf_cpp_cppflags) -I../src/Lib $(src)Lib/CallbackStreamBuf.cpp
endif
endif

else
$(bin)GaudiPythonLib_dependencies.make : $(CallbackStreamBuf_cpp_dependencies)

$(bin)GaudiPythonLib_dependencies.make : $(src)Lib/CallbackStreamBuf.cpp

$(bin)$(binobj)CallbackStreamBuf.o : $(CallbackStreamBuf_cpp_dependencies)
	$(cpp_echo) $(src)Lib/CallbackStreamBuf.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPythonLib_pp_cppflags) $(lib_GaudiPythonLib_pp_cppflags) $(CallbackStreamBuf_pp_cppflags) $(use_cppflags) $(GaudiPythonLib_cppflags) $(lib_GaudiPythonLib_cppflags) $(CallbackStreamBuf_cppflags) $(CallbackStreamBuf_cpp_cppflags) -I../src/Lib $(src)Lib/CallbackStreamBuf.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiPythonLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiPythonLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiPythonLib$(library_suffix).a $(library_prefix)GaudiPythonLib$(library_suffix).$(shlibsuffix) GaudiPythonLib.stamp GaudiPythonLib.shstamp
#-- end of cleanup_library ---------------
