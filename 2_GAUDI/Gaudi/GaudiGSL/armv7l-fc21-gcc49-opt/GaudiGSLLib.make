#-- start of make_header -----------------

#====================================
#  Library GaudiGSLLib
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

cmt_GaudiGSLLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLLib

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLLib = $(GaudiGSL_tag)_GaudiGSLLib.make
cmt_local_tagfile_GaudiGSLLib = $(bin)$(GaudiGSL_tag)_GaudiGSLLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLLib = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLLib = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLLib)
#-include $(cmt_local_tagfile_GaudiGSLLib)

ifdef cmt_GaudiGSLLib_has_target_tag

cmt_final_setup_GaudiGSLLib = $(bin)setup_GaudiGSLLib.make
cmt_dependencies_in_GaudiGSLLib = $(bin)dependencies_GaudiGSLLib.in
#cmt_final_setup_GaudiGSLLib = $(bin)GaudiGSL_GaudiGSLLibsetup.make
cmt_local_GaudiGSLLib_makefile = $(bin)GaudiGSLLib.make

else

cmt_final_setup_GaudiGSLLib = $(bin)setup.make
cmt_dependencies_in_GaudiGSLLib = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLLib = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLLib_makefile = $(bin)GaudiGSLLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLLib/
#GaudiGSLLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiGSLLiblibname   = $(bin)$(library_prefix)GaudiGSLLib$(library_suffix)
GaudiGSLLiblib       = $(GaudiGSLLiblibname).a
GaudiGSLLibstamp     = $(bin)GaudiGSLLib.stamp
GaudiGSLLibshstamp   = $(bin)GaudiGSLLib.shstamp

GaudiGSLLib :: dirs  GaudiGSLLibLIB
	$(echo) "GaudiGSLLib ok"

cmt_GaudiGSLLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSLLib_has_prototypes

GaudiGSLLibprototype :  ;

endif

GaudiGSLLibcompile : $(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiGSLLibLIB :: $(GaudiGSLLiblib) $(GaudiGSLLibshstamp)
GaudiGSLLibLIB :: $(GaudiGSLLibshstamp)
	$(echo) "GaudiGSLLib : library ok"

$(GaudiGSLLiblib) :: $(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiGSLLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiGSLLiblib)
	$(lib_silent) cat /dev/null >$(GaudiGSLLibstamp)

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

$(GaudiGSLLiblibname).$(shlibsuffix) :: $(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o $(use_requirements) $(GaudiGSLLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o $(GaudiGSLLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiGSLLibstamp) && \
	  cat /dev/null >$(GaudiGSLLibshstamp)

$(GaudiGSLLibshstamp) :: $(GaudiGSLLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiGSLLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiGSLLibstamp) && \
	  cat /dev/null >$(GaudiGSLLibshstamp) ; fi

GaudiGSLLibclean ::
	$(cleanup_echo) objects GaudiGSLLib
	$(cleanup_silent) /bin/rm -f $(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o) $(patsubst %.o,%.dep,$(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o) $(patsubst %.o,%.d.stamp,$(bin)Integral.o $(bin)NumericalIndefiniteIntegral.o $(bin)GslErrorHandlers.o $(bin)Adapters.o $(bin)GaudiGSL.o $(bin)NumericalDefiniteIntegral.o $(bin)Helpers.o $(bin)Adapter.o $(bin)GSLFunAdapters.o $(bin)Splines.o $(bin)Constant.o $(bin)NumericalDerivative.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiGSLLib_deps GaudiGSLLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiGSLLibinstallname = $(library_prefix)GaudiGSLLib$(library_suffix).$(shlibsuffix)

GaudiGSLLib :: GaudiGSLLibinstall ;

install :: GaudiGSLLibinstall ;

GaudiGSLLibinstall :: $(install_dir)/$(GaudiGSLLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiGSLLibinstallname) :: $(bin)$(GaudiGSLLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiGSLLibclean :: GaudiGSLLibuninstall

uninstall :: GaudiGSLLibuninstall ;

GaudiGSLLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiGSLLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Integral.d

$(bin)$(binobj)Integral.d :

$(bin)$(binobj)Integral.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Integral.o : $(src)Lib/Integral.cpp
	$(cpp_echo) $(src)Lib/Integral.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Integral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Integral_cppflags) $(Integral_cpp_cppflags) -I../src/Lib $(src)Lib/Integral.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Integral_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Integral.cpp

$(bin)$(binobj)Integral.o : $(Integral_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Integral.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Integral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Integral_cppflags) $(Integral_cpp_cppflags) -I../src/Lib $(src)Lib/Integral.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NumericalIndefiniteIntegral.d

$(bin)$(binobj)NumericalIndefiniteIntegral.d :

$(bin)$(binobj)NumericalIndefiniteIntegral.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)NumericalIndefiniteIntegral.o : $(src)Lib/NumericalIndefiniteIntegral.cpp
	$(cpp_echo) $(src)Lib/NumericalIndefiniteIntegral.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalIndefiniteIntegral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalIndefiniteIntegral_cppflags) $(NumericalIndefiniteIntegral_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalIndefiniteIntegral.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(NumericalIndefiniteIntegral_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/NumericalIndefiniteIntegral.cpp

$(bin)$(binobj)NumericalIndefiniteIntegral.o : $(NumericalIndefiniteIntegral_cpp_dependencies)
	$(cpp_echo) $(src)Lib/NumericalIndefiniteIntegral.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalIndefiniteIntegral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalIndefiniteIntegral_cppflags) $(NumericalIndefiniteIntegral_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalIndefiniteIntegral.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GslErrorHandlers.d

$(bin)$(binobj)GslErrorHandlers.d :

$(bin)$(binobj)GslErrorHandlers.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)GslErrorHandlers.o : $(src)Lib/GslErrorHandlers.cpp
	$(cpp_echo) $(src)Lib/GslErrorHandlers.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GslErrorHandlers_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GslErrorHandlers_cppflags) $(GslErrorHandlers_cpp_cppflags) -I../src/Lib $(src)Lib/GslErrorHandlers.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(GslErrorHandlers_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/GslErrorHandlers.cpp

$(bin)$(binobj)GslErrorHandlers.o : $(GslErrorHandlers_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GslErrorHandlers.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GslErrorHandlers_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GslErrorHandlers_cppflags) $(GslErrorHandlers_cpp_cppflags) -I../src/Lib $(src)Lib/GslErrorHandlers.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Adapters.d

$(bin)$(binobj)Adapters.d :

$(bin)$(binobj)Adapters.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Adapters.o : $(src)Lib/Adapters.cpp
	$(cpp_echo) $(src)Lib/Adapters.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Adapters_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Adapters_cppflags) $(Adapters_cpp_cppflags) -I../src/Lib $(src)Lib/Adapters.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Adapters_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Adapters.cpp

$(bin)$(binobj)Adapters.o : $(Adapters_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Adapters.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Adapters_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Adapters_cppflags) $(Adapters_cpp_cppflags) -I../src/Lib $(src)Lib/Adapters.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiGSL.d

$(bin)$(binobj)GaudiGSL.d :

$(bin)$(binobj)GaudiGSL.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)GaudiGSL.o : $(src)Lib/GaudiGSL.cpp
	$(cpp_echo) $(src)Lib/GaudiGSL.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GaudiGSL_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GaudiGSL_cppflags) $(GaudiGSL_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiGSL.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(GaudiGSL_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/GaudiGSL.cpp

$(bin)$(binobj)GaudiGSL.o : $(GaudiGSL_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GaudiGSL.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GaudiGSL_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GaudiGSL_cppflags) $(GaudiGSL_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiGSL.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NumericalDefiniteIntegral.d

$(bin)$(binobj)NumericalDefiniteIntegral.d :

$(bin)$(binobj)NumericalDefiniteIntegral.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)NumericalDefiniteIntegral.o : $(src)Lib/NumericalDefiniteIntegral.cpp
	$(cpp_echo) $(src)Lib/NumericalDefiniteIntegral.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalDefiniteIntegral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalDefiniteIntegral_cppflags) $(NumericalDefiniteIntegral_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalDefiniteIntegral.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(NumericalDefiniteIntegral_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/NumericalDefiniteIntegral.cpp

$(bin)$(binobj)NumericalDefiniteIntegral.o : $(NumericalDefiniteIntegral_cpp_dependencies)
	$(cpp_echo) $(src)Lib/NumericalDefiniteIntegral.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalDefiniteIntegral_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalDefiniteIntegral_cppflags) $(NumericalDefiniteIntegral_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalDefiniteIntegral.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Helpers.d

$(bin)$(binobj)Helpers.d :

$(bin)$(binobj)Helpers.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Helpers.o : $(src)Lib/Helpers.cpp
	$(cpp_echo) $(src)Lib/Helpers.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Helpers_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Helpers_cppflags) $(Helpers_cpp_cppflags) -I../src/Lib $(src)Lib/Helpers.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Helpers_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Helpers.cpp

$(bin)$(binobj)Helpers.o : $(Helpers_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Helpers.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Helpers_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Helpers_cppflags) $(Helpers_cpp_cppflags) -I../src/Lib $(src)Lib/Helpers.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Adapter.d

$(bin)$(binobj)Adapter.d :

$(bin)$(binobj)Adapter.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Adapter.o : $(src)Lib/Adapter.cpp
	$(cpp_echo) $(src)Lib/Adapter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Adapter_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Adapter_cppflags) $(Adapter_cpp_cppflags) -I../src/Lib $(src)Lib/Adapter.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Adapter_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Adapter.cpp

$(bin)$(binobj)Adapter.o : $(Adapter_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Adapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Adapter_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Adapter_cppflags) $(Adapter_cpp_cppflags) -I../src/Lib $(src)Lib/Adapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GSLFunAdapters.d

$(bin)$(binobj)GSLFunAdapters.d :

$(bin)$(binobj)GSLFunAdapters.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)GSLFunAdapters.o : $(src)Lib/GSLFunAdapters.cpp
	$(cpp_echo) $(src)Lib/GSLFunAdapters.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GSLFunAdapters_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GSLFunAdapters_cppflags) $(GSLFunAdapters_cpp_cppflags) -I../src/Lib $(src)Lib/GSLFunAdapters.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(GSLFunAdapters_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/GSLFunAdapters.cpp

$(bin)$(binobj)GSLFunAdapters.o : $(GSLFunAdapters_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GSLFunAdapters.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(GSLFunAdapters_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(GSLFunAdapters_cppflags) $(GSLFunAdapters_cpp_cppflags) -I../src/Lib $(src)Lib/GSLFunAdapters.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Splines.d

$(bin)$(binobj)Splines.d :

$(bin)$(binobj)Splines.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Splines.o : $(src)Lib/Splines.cpp
	$(cpp_echo) $(src)Lib/Splines.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Splines_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Splines_cppflags) $(Splines_cpp_cppflags) -I../src/Lib $(src)Lib/Splines.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Splines_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Splines.cpp

$(bin)$(binobj)Splines.o : $(Splines_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Splines.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Splines_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Splines_cppflags) $(Splines_cpp_cppflags) -I../src/Lib $(src)Lib/Splines.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Constant.d

$(bin)$(binobj)Constant.d :

$(bin)$(binobj)Constant.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)Constant.o : $(src)Lib/Constant.cpp
	$(cpp_echo) $(src)Lib/Constant.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Constant_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Constant_cppflags) $(Constant_cpp_cppflags) -I../src/Lib $(src)Lib/Constant.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(Constant_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/Constant.cpp

$(bin)$(binobj)Constant.o : $(Constant_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Constant.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(Constant_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(Constant_cppflags) $(Constant_cpp_cppflags) -I../src/Lib $(src)Lib/Constant.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiGSLLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NumericalDerivative.d

$(bin)$(binobj)NumericalDerivative.d :

$(bin)$(binobj)NumericalDerivative.o : $(cmt_final_setup_GaudiGSLLib)

$(bin)$(binobj)NumericalDerivative.o : $(src)Lib/NumericalDerivative.cpp
	$(cpp_echo) $(src)Lib/NumericalDerivative.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalDerivative_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalDerivative_cppflags) $(NumericalDerivative_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalDerivative.cpp
endif
endif

else
$(bin)GaudiGSLLib_dependencies.make : $(NumericalDerivative_cpp_dependencies)

$(bin)GaudiGSLLib_dependencies.make : $(src)Lib/NumericalDerivative.cpp

$(bin)$(binobj)NumericalDerivative.o : $(NumericalDerivative_cpp_dependencies)
	$(cpp_echo) $(src)Lib/NumericalDerivative.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiGSLLib_pp_cppflags) $(lib_GaudiGSLLib_pp_cppflags) $(NumericalDerivative_pp_cppflags) $(use_cppflags) $(GaudiGSLLib_cppflags) $(lib_GaudiGSLLib_cppflags) $(NumericalDerivative_cppflags) $(NumericalDerivative_cpp_cppflags) -I../src/Lib $(src)Lib/NumericalDerivative.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiGSLLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiGSLLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiGSLLib$(library_suffix).a $(library_prefix)GaudiGSLLib$(library_suffix).$(shlibsuffix) GaudiGSLLib.stamp GaudiGSLLib.shstamp
#-- end of cleanup_library ---------------
