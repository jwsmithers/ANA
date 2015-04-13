#-- start of make_header -----------------

#====================================
#  Library GaudiGSL
#
#   Generated Mon Feb 16 20:17:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSL_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSL_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSL

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSL = $(GaudiGSL_tag)_GaudiGSL.make
cmt_local_tagfile_GaudiGSL = $(bin)$(GaudiGSL_tag)_GaudiGSL.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSL = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSL = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSL)
#-include $(cmt_local_tagfile_GaudiGSL)

ifdef cmt_GaudiGSL_has_target_tag

cmt_final_setup_GaudiGSL = $(bin)setup_GaudiGSL.make
cmt_dependencies_in_GaudiGSL = $(bin)dependencies_GaudiGSL.in
#cmt_final_setup_GaudiGSL = $(bin)GaudiGSL_GaudiGSLsetup.make
cmt_local_GaudiGSL_makefile = $(bin)GaudiGSL.make

else

cmt_final_setup_GaudiGSL = $(bin)setup.make
cmt_dependencies_in_GaudiGSL = $(bin)dependencies.in
#cmt_final_setup_GaudiGSL = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSL_makefile = $(bin)GaudiGSL.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSL :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSL'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSL/
#GaudiGSL::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiGSLlibname   = $(bin)$(library_prefix)GaudiGSL$(library_suffix)
GaudiGSLlib       = $(GaudiGSLlibname).a
GaudiGSLstamp     = $(bin)GaudiGSL.stamp
GaudiGSLshstamp   = $(bin)GaudiGSL.shstamp

GaudiGSL :: dirs  GaudiGSLLIB
	$(echo) "GaudiGSL ok"

cmt_GaudiGSL_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSL_has_prototypes

GaudiGSLprototype :  ;

endif

GaudiGSLcompile : $(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiGSLLIB :: $(GaudiGSLlib) $(GaudiGSLshstamp)
GaudiGSLLIB :: $(GaudiGSLshstamp)
	$(echo) "GaudiGSL : library ok"

$(GaudiGSLlib) :: $(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiGSLlib) $?
	$(lib_silent) $(ranlib) $(GaudiGSLlib)
	$(lib_silent) cat /dev/null >$(GaudiGSLstamp)

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

$(GaudiGSLlibname).$(shlibsuffix) :: $(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o $(use_requirements) $(GaudiGSLstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o $(GaudiGSL_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiGSLstamp) && \
	  cat /dev/null >$(GaudiGSLshstamp)

$(GaudiGSLshstamp) :: $(GaudiGSLlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiGSLlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiGSLstamp) && \
	  cat /dev/null >$(GaudiGSLshstamp) ; fi

GaudiGSLclean ::
	$(cleanup_echo) objects GaudiGSL
	$(cleanup_silent) /bin/rm -f $(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o) $(patsubst %.o,%.dep,$(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o) $(patsubst %.o,%.d.stamp,$(bin)GslSvc.o $(bin)GslErrorException.o $(bin)GslErrorPrint.o $(bin)GslErrorCount.o $(bin)EqSolver.o $(bin)FuncMinimum.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiGSL_deps GaudiGSL_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiGSLinstallname = $(library_prefix)GaudiGSL$(library_suffix).$(shlibsuffix)

GaudiGSL :: GaudiGSLinstall ;

install :: GaudiGSLinstall ;

GaudiGSLinstall :: $(install_dir)/$(GaudiGSLinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiGSLinstallname) :: $(bin)$(GaudiGSLinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiGSLclean :: GaudiGSLuninstall

uninstall :: GaudiGSLuninstall ;

GaudiGSLuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GslSvc.d

$(bin)$(binobj)GslSvc.d :

$(bin)$(binobj)GslSvc.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)GslSvc.o : $(src)Components/GslSvc.cpp
	$(cpp_echo) $(src)Components/GslSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslSvc_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslSvc_cppflags) $(GslSvc_cpp_cppflags) -I../src/Components $(src)Components/GslSvc.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(GslSvc_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/GslSvc.cpp

$(bin)$(binobj)GslSvc.o : $(GslSvc_cpp_dependencies)
	$(cpp_echo) $(src)Components/GslSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslSvc_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslSvc_cppflags) $(GslSvc_cpp_cppflags) -I../src/Components $(src)Components/GslSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GslErrorException.d

$(bin)$(binobj)GslErrorException.d :

$(bin)$(binobj)GslErrorException.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)GslErrorException.o : $(src)Components/GslErrorException.cpp
	$(cpp_echo) $(src)Components/GslErrorException.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorException_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorException_cppflags) $(GslErrorException_cpp_cppflags) -I../src/Components $(src)Components/GslErrorException.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(GslErrorException_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/GslErrorException.cpp

$(bin)$(binobj)GslErrorException.o : $(GslErrorException_cpp_dependencies)
	$(cpp_echo) $(src)Components/GslErrorException.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorException_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorException_cppflags) $(GslErrorException_cpp_cppflags) -I../src/Components $(src)Components/GslErrorException.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GslErrorPrint.d

$(bin)$(binobj)GslErrorPrint.d :

$(bin)$(binobj)GslErrorPrint.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)GslErrorPrint.o : $(src)Components/GslErrorPrint.cpp
	$(cpp_echo) $(src)Components/GslErrorPrint.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorPrint_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorPrint_cppflags) $(GslErrorPrint_cpp_cppflags) -I../src/Components $(src)Components/GslErrorPrint.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(GslErrorPrint_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/GslErrorPrint.cpp

$(bin)$(binobj)GslErrorPrint.o : $(GslErrorPrint_cpp_dependencies)
	$(cpp_echo) $(src)Components/GslErrorPrint.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorPrint_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorPrint_cppflags) $(GslErrorPrint_cpp_cppflags) -I../src/Components $(src)Components/GslErrorPrint.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GslErrorCount.d

$(bin)$(binobj)GslErrorCount.d :

$(bin)$(binobj)GslErrorCount.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)GslErrorCount.o : $(src)Components/GslErrorCount.cpp
	$(cpp_echo) $(src)Components/GslErrorCount.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorCount_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorCount_cppflags) $(GslErrorCount_cpp_cppflags) -I../src/Components $(src)Components/GslErrorCount.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(GslErrorCount_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/GslErrorCount.cpp

$(bin)$(binobj)GslErrorCount.o : $(GslErrorCount_cpp_dependencies)
	$(cpp_echo) $(src)Components/GslErrorCount.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(GslErrorCount_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(GslErrorCount_cppflags) $(GslErrorCount_cpp_cppflags) -I../src/Components $(src)Components/GslErrorCount.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EqSolver.d

$(bin)$(binobj)EqSolver.d :

$(bin)$(binobj)EqSolver.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)EqSolver.o : $(src)Components/EqSolver.cpp
	$(cpp_echo) $(src)Components/EqSolver.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(EqSolver_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(EqSolver_cppflags) $(EqSolver_cpp_cppflags) -I../src/Components $(src)Components/EqSolver.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(EqSolver_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/EqSolver.cpp

$(bin)$(binobj)EqSolver.o : $(EqSolver_cpp_dependencies)
	$(cpp_echo) $(src)Components/EqSolver.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(EqSolver_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(EqSolver_cppflags) $(EqSolver_cpp_cppflags) -I../src/Components $(src)Components/EqSolver.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FuncMinimum.d

$(bin)$(binobj)FuncMinimum.d :

$(bin)$(binobj)FuncMinimum.o : $(cmt_final_setup_GaudiGSL)

$(bin)$(binobj)FuncMinimum.o : $(src)Components/FuncMinimum.cpp
	$(cpp_echo) $(src)Components/FuncMinimum.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(FuncMinimum_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(FuncMinimum_cppflags) $(FuncMinimum_cpp_cppflags) -I../src/Components $(src)Components/FuncMinimum.cpp
endif
endif

else
$(bin)GaudiGSL_dependencies.make : $(FuncMinimum_cpp_dependencies)

$(bin)GaudiGSL_dependencies.make : $(src)Components/FuncMinimum.cpp

$(bin)$(binobj)FuncMinimum.o : $(FuncMinimum_cpp_dependencies)
	$(cpp_echo) $(src)Components/FuncMinimum.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSL_pp_cppflags) $(lib_GaudiGSL_pp_cppflags) $(FuncMinimum_pp_cppflags) $(use_cppflags) $(GaudiGSL_cppflags) $(lib_GaudiGSL_cppflags) $(FuncMinimum_cppflags) $(FuncMinimum_cpp_cppflags) -I../src/Components $(src)Components/FuncMinimum.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiGSLclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSL.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiGSL
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiGSL$(library_suffix).a $(library_prefix)GaudiGSL$(library_suffix).$(shlibsuffix) GaudiGSL.stamp GaudiGSL.shstamp
#-- end of cleanup_library ---------------
