#-- start of make_header -----------------

#====================================
#  Library GaudiAlgLib
#
#   Generated Mon Feb 16 20:01:34 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlgLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlgLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlgLib

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgLib = $(GaudiAlg_tag)_GaudiAlgLib.make
cmt_local_tagfile_GaudiAlgLib = $(bin)$(GaudiAlg_tag)_GaudiAlgLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgLib = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlgLib = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlgLib)
#-include $(cmt_local_tagfile_GaudiAlgLib)

ifdef cmt_GaudiAlgLib_has_target_tag

cmt_final_setup_GaudiAlgLib = $(bin)setup_GaudiAlgLib.make
cmt_dependencies_in_GaudiAlgLib = $(bin)dependencies_GaudiAlgLib.in
#cmt_final_setup_GaudiAlgLib = $(bin)GaudiAlg_GaudiAlgLibsetup.make
cmt_local_GaudiAlgLib_makefile = $(bin)GaudiAlgLib.make

else

cmt_final_setup_GaudiAlgLib = $(bin)setup.make
cmt_dependencies_in_GaudiAlgLib = $(bin)dependencies.in
#cmt_final_setup_GaudiAlgLib = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlgLib_makefile = $(bin)GaudiAlgLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlgLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlgLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlgLib/
#GaudiAlgLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiAlgLiblibname   = $(bin)$(library_prefix)GaudiAlgLib$(library_suffix)
GaudiAlgLiblib       = $(GaudiAlgLiblibname).a
GaudiAlgLibstamp     = $(bin)GaudiAlgLib.stamp
GaudiAlgLibshstamp   = $(bin)GaudiAlgLib.shstamp

GaudiAlgLib :: dirs  GaudiAlgLibLIB
	$(echo) "GaudiAlgLib ok"

cmt_GaudiAlgLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAlgLib_has_prototypes

GaudiAlgLibprototype :  ;

endif

GaudiAlgLibcompile : $(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiAlgLibLIB :: $(GaudiAlgLiblib) $(GaudiAlgLibshstamp)
GaudiAlgLibLIB :: $(GaudiAlgLibshstamp)
	$(echo) "GaudiAlgLib : library ok"

$(GaudiAlgLiblib) :: $(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiAlgLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiAlgLiblib)
	$(lib_silent) cat /dev/null >$(GaudiAlgLibstamp)

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

$(GaudiAlgLiblibname).$(shlibsuffix) :: $(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o $(use_requirements) $(GaudiAlgLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o $(GaudiAlgLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiAlgLibstamp) && \
	  cat /dev/null >$(GaudiAlgLibshstamp)

$(GaudiAlgLibshstamp) :: $(GaudiAlgLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiAlgLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiAlgLibstamp) && \
	  cat /dev/null >$(GaudiAlgLibshstamp) ; fi

GaudiAlgLibclean ::
	$(cleanup_echo) objects GaudiAlgLib
	$(cleanup_silent) /bin/rm -f $(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o) $(patsubst %.o,%.dep,$(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o) $(patsubst %.o,%.d.stamp,$(bin)GaudiSequencer.o $(bin)GaudiTupleAlg.o $(bin)ITupleTool.o $(bin)GaudiHistosConstructors.o $(bin)GaudiCommonConstructors.o $(bin)InterfaceVirtualDestructors.o $(bin)Tuple.o $(bin)Fill.o $(bin)GaudiHistoTool.o $(bin)Print.o $(bin)GaudiHistoAlg.o $(bin)EventCounter.o $(bin)GaudiTupleTool.o $(bin)GetAlg.o $(bin)GetAlgs.o $(bin)IHistoTool.o $(bin)Prescaler.o $(bin)IErrorTool.o $(bin)GaudiAlgorithm.o $(bin)GaudiTool.o $(bin)GaudiAlg.o $(bin)GaudiHistoID.o $(bin)TupleObj.o $(bin)Sequencer.o $(bin)GaudiTuplesConstructors.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiAlgLib_deps GaudiAlgLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiAlgLibinstallname = $(library_prefix)GaudiAlgLib$(library_suffix).$(shlibsuffix)

GaudiAlgLib :: GaudiAlgLibinstall ;

install :: GaudiAlgLibinstall ;

GaudiAlgLibinstall :: $(install_dir)/$(GaudiAlgLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiAlgLibinstallname) :: $(bin)$(GaudiAlgLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAlgLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiAlgLibclean :: GaudiAlgLibuninstall

uninstall :: GaudiAlgLibuninstall ;

GaudiAlgLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAlgLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiSequencer.d

$(bin)$(binobj)GaudiSequencer.d :

$(bin)$(binobj)GaudiSequencer.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiSequencer.o : $(src)lib/GaudiSequencer.cpp
	$(cpp_echo) $(src)lib/GaudiSequencer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiSequencer_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiSequencer_cppflags) $(GaudiSequencer_cpp_cppflags) -I../src/lib $(src)lib/GaudiSequencer.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiSequencer_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiSequencer.cpp

$(bin)$(binobj)GaudiSequencer.o : $(GaudiSequencer_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiSequencer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiSequencer_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiSequencer_cppflags) $(GaudiSequencer_cpp_cppflags) -I../src/lib $(src)lib/GaudiSequencer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiTupleAlg.d

$(bin)$(binobj)GaudiTupleAlg.d :

$(bin)$(binobj)GaudiTupleAlg.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiTupleAlg.o : $(src)lib/GaudiTupleAlg.cpp
	$(cpp_echo) $(src)lib/GaudiTupleAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTupleAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTupleAlg_cppflags) $(GaudiTupleAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiTupleAlg.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiTupleAlg_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiTupleAlg.cpp

$(bin)$(binobj)GaudiTupleAlg.o : $(GaudiTupleAlg_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiTupleAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTupleAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTupleAlg_cppflags) $(GaudiTupleAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiTupleAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITupleTool.d

$(bin)$(binobj)ITupleTool.d :

$(bin)$(binobj)ITupleTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)ITupleTool.o : $(src)lib/ITupleTool.cpp
	$(cpp_echo) $(src)lib/ITupleTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(ITupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(ITupleTool_cppflags) $(ITupleTool_cpp_cppflags) -I../src/lib $(src)lib/ITupleTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(ITupleTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/ITupleTool.cpp

$(bin)$(binobj)ITupleTool.o : $(ITupleTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/ITupleTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(ITupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(ITupleTool_cppflags) $(ITupleTool_cpp_cppflags) -I../src/lib $(src)lib/ITupleTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHistosConstructors.d

$(bin)$(binobj)GaudiHistosConstructors.d :

$(bin)$(binobj)GaudiHistosConstructors.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiHistosConstructors.o : $(src)lib/GaudiHistosConstructors.cpp
	$(cpp_echo) $(src)lib/GaudiHistosConstructors.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistosConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistosConstructors_cppflags) $(GaudiHistosConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistosConstructors.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiHistosConstructors_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiHistosConstructors.cpp

$(bin)$(binobj)GaudiHistosConstructors.o : $(GaudiHistosConstructors_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiHistosConstructors.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistosConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistosConstructors_cppflags) $(GaudiHistosConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistosConstructors.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiCommonConstructors.d

$(bin)$(binobj)GaudiCommonConstructors.d :

$(bin)$(binobj)GaudiCommonConstructors.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiCommonConstructors.o : $(src)lib/GaudiCommonConstructors.cpp
	$(cpp_echo) $(src)lib/GaudiCommonConstructors.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiCommonConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiCommonConstructors_cppflags) $(GaudiCommonConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiCommonConstructors.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiCommonConstructors_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiCommonConstructors.cpp

$(bin)$(binobj)GaudiCommonConstructors.o : $(GaudiCommonConstructors_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiCommonConstructors.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiCommonConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiCommonConstructors_cppflags) $(GaudiCommonConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiCommonConstructors.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)InterfaceVirtualDestructors.d

$(bin)$(binobj)InterfaceVirtualDestructors.d :

$(bin)$(binobj)InterfaceVirtualDestructors.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)InterfaceVirtualDestructors.o : $(src)lib/InterfaceVirtualDestructors.cpp
	$(cpp_echo) $(src)lib/InterfaceVirtualDestructors.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(InterfaceVirtualDestructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(InterfaceVirtualDestructors_cppflags) $(InterfaceVirtualDestructors_cpp_cppflags) -I../src/lib $(src)lib/InterfaceVirtualDestructors.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(InterfaceVirtualDestructors_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/InterfaceVirtualDestructors.cpp

$(bin)$(binobj)InterfaceVirtualDestructors.o : $(InterfaceVirtualDestructors_cpp_dependencies)
	$(cpp_echo) $(src)lib/InterfaceVirtualDestructors.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(InterfaceVirtualDestructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(InterfaceVirtualDestructors_cppflags) $(InterfaceVirtualDestructors_cpp_cppflags) -I../src/lib $(src)lib/InterfaceVirtualDestructors.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Tuple.d

$(bin)$(binobj)Tuple.d :

$(bin)$(binobj)Tuple.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)Tuple.o : $(src)lib/Tuple.cpp
	$(cpp_echo) $(src)lib/Tuple.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Tuple_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Tuple_cppflags) $(Tuple_cpp_cppflags) -I../src/lib $(src)lib/Tuple.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(Tuple_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/Tuple.cpp

$(bin)$(binobj)Tuple.o : $(Tuple_cpp_dependencies)
	$(cpp_echo) $(src)lib/Tuple.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Tuple_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Tuple_cppflags) $(Tuple_cpp_cppflags) -I../src/lib $(src)lib/Tuple.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Fill.d

$(bin)$(binobj)Fill.d :

$(bin)$(binobj)Fill.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)Fill.o : $(src)lib/Fill.cpp
	$(cpp_echo) $(src)lib/Fill.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Fill_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Fill_cppflags) $(Fill_cpp_cppflags) -I../src/lib $(src)lib/Fill.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(Fill_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/Fill.cpp

$(bin)$(binobj)Fill.o : $(Fill_cpp_dependencies)
	$(cpp_echo) $(src)lib/Fill.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Fill_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Fill_cppflags) $(Fill_cpp_cppflags) -I../src/lib $(src)lib/Fill.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHistoTool.d

$(bin)$(binobj)GaudiHistoTool.d :

$(bin)$(binobj)GaudiHistoTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiHistoTool.o : $(src)lib/GaudiHistoTool.cpp
	$(cpp_echo) $(src)lib/GaudiHistoTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoTool_cppflags) $(GaudiHistoTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiHistoTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiHistoTool.cpp

$(bin)$(binobj)GaudiHistoTool.o : $(GaudiHistoTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiHistoTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoTool_cppflags) $(GaudiHistoTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Print.d

$(bin)$(binobj)Print.d :

$(bin)$(binobj)Print.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)Print.o : $(src)lib/Print.cpp
	$(cpp_echo) $(src)lib/Print.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Print_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Print_cppflags) $(Print_cpp_cppflags) -I../src/lib $(src)lib/Print.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(Print_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/Print.cpp

$(bin)$(binobj)Print.o : $(Print_cpp_dependencies)
	$(cpp_echo) $(src)lib/Print.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Print_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Print_cppflags) $(Print_cpp_cppflags) -I../src/lib $(src)lib/Print.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHistoAlg.d

$(bin)$(binobj)GaudiHistoAlg.d :

$(bin)$(binobj)GaudiHistoAlg.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiHistoAlg.o : $(src)lib/GaudiHistoAlg.cpp
	$(cpp_echo) $(src)lib/GaudiHistoAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoAlg_cppflags) $(GaudiHistoAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoAlg.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiHistoAlg_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiHistoAlg.cpp

$(bin)$(binobj)GaudiHistoAlg.o : $(GaudiHistoAlg_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiHistoAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoAlg_cppflags) $(GaudiHistoAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventCounter.d

$(bin)$(binobj)EventCounter.d :

$(bin)$(binobj)EventCounter.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)EventCounter.o : $(src)lib/EventCounter.cpp
	$(cpp_echo) $(src)lib/EventCounter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(EventCounter_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(EventCounter_cppflags) $(EventCounter_cpp_cppflags) -I../src/lib $(src)lib/EventCounter.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(EventCounter_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/EventCounter.cpp

$(bin)$(binobj)EventCounter.o : $(EventCounter_cpp_dependencies)
	$(cpp_echo) $(src)lib/EventCounter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(EventCounter_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(EventCounter_cppflags) $(EventCounter_cpp_cppflags) -I../src/lib $(src)lib/EventCounter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiTupleTool.d

$(bin)$(binobj)GaudiTupleTool.d :

$(bin)$(binobj)GaudiTupleTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiTupleTool.o : $(src)lib/GaudiTupleTool.cpp
	$(cpp_echo) $(src)lib/GaudiTupleTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTupleTool_cppflags) $(GaudiTupleTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiTupleTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiTupleTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiTupleTool.cpp

$(bin)$(binobj)GaudiTupleTool.o : $(GaudiTupleTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiTupleTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTupleTool_cppflags) $(GaudiTupleTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiTupleTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GetAlg.d

$(bin)$(binobj)GetAlg.d :

$(bin)$(binobj)GetAlg.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GetAlg.o : $(src)lib/GetAlg.cpp
	$(cpp_echo) $(src)lib/GetAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GetAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GetAlg_cppflags) $(GetAlg_cpp_cppflags) -I../src/lib $(src)lib/GetAlg.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GetAlg_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GetAlg.cpp

$(bin)$(binobj)GetAlg.o : $(GetAlg_cpp_dependencies)
	$(cpp_echo) $(src)lib/GetAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GetAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GetAlg_cppflags) $(GetAlg_cpp_cppflags) -I../src/lib $(src)lib/GetAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GetAlgs.d

$(bin)$(binobj)GetAlgs.d :

$(bin)$(binobj)GetAlgs.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GetAlgs.o : $(src)lib/GetAlgs.cpp
	$(cpp_echo) $(src)lib/GetAlgs.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GetAlgs_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GetAlgs_cppflags) $(GetAlgs_cpp_cppflags) -I../src/lib $(src)lib/GetAlgs.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GetAlgs_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GetAlgs.cpp

$(bin)$(binobj)GetAlgs.o : $(GetAlgs_cpp_dependencies)
	$(cpp_echo) $(src)lib/GetAlgs.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GetAlgs_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GetAlgs_cppflags) $(GetAlgs_cpp_cppflags) -I../src/lib $(src)lib/GetAlgs.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IHistoTool.d

$(bin)$(binobj)IHistoTool.d :

$(bin)$(binobj)IHistoTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)IHistoTool.o : $(src)lib/IHistoTool.cpp
	$(cpp_echo) $(src)lib/IHistoTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(IHistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(IHistoTool_cppflags) $(IHistoTool_cpp_cppflags) -I../src/lib $(src)lib/IHistoTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(IHistoTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/IHistoTool.cpp

$(bin)$(binobj)IHistoTool.o : $(IHistoTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/IHistoTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(IHistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(IHistoTool_cppflags) $(IHistoTool_cpp_cppflags) -I../src/lib $(src)lib/IHistoTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Prescaler.d

$(bin)$(binobj)Prescaler.d :

$(bin)$(binobj)Prescaler.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)Prescaler.o : $(src)lib/Prescaler.cpp
	$(cpp_echo) $(src)lib/Prescaler.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Prescaler_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Prescaler_cppflags) $(Prescaler_cpp_cppflags) -I../src/lib $(src)lib/Prescaler.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(Prescaler_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/Prescaler.cpp

$(bin)$(binobj)Prescaler.o : $(Prescaler_cpp_dependencies)
	$(cpp_echo) $(src)lib/Prescaler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Prescaler_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Prescaler_cppflags) $(Prescaler_cpp_cppflags) -I../src/lib $(src)lib/Prescaler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IErrorTool.d

$(bin)$(binobj)IErrorTool.d :

$(bin)$(binobj)IErrorTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)IErrorTool.o : $(src)lib/IErrorTool.cpp
	$(cpp_echo) $(src)lib/IErrorTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(IErrorTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(IErrorTool_cppflags) $(IErrorTool_cpp_cppflags) -I../src/lib $(src)lib/IErrorTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(IErrorTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/IErrorTool.cpp

$(bin)$(binobj)IErrorTool.o : $(IErrorTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/IErrorTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(IErrorTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(IErrorTool_cppflags) $(IErrorTool_cpp_cppflags) -I../src/lib $(src)lib/IErrorTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiAlgorithm.d

$(bin)$(binobj)GaudiAlgorithm.d :

$(bin)$(binobj)GaudiAlgorithm.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiAlgorithm.o : $(src)lib/GaudiAlgorithm.cpp
	$(cpp_echo) $(src)lib/GaudiAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiAlgorithm_cppflags) $(GaudiAlgorithm_cpp_cppflags) -I../src/lib $(src)lib/GaudiAlgorithm.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiAlgorithm_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiAlgorithm.cpp

$(bin)$(binobj)GaudiAlgorithm.o : $(GaudiAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiAlgorithm_cppflags) $(GaudiAlgorithm_cpp_cppflags) -I../src/lib $(src)lib/GaudiAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiTool.d

$(bin)$(binobj)GaudiTool.d :

$(bin)$(binobj)GaudiTool.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiTool.o : $(src)lib/GaudiTool.cpp
	$(cpp_echo) $(src)lib/GaudiTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTool_cppflags) $(GaudiTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiTool.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiTool_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiTool.cpp

$(bin)$(binobj)GaudiTool.o : $(GaudiTool_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTool_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTool_cppflags) $(GaudiTool_cpp_cppflags) -I../src/lib $(src)lib/GaudiTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiAlg.d

$(bin)$(binobj)GaudiAlg.d :

$(bin)$(binobj)GaudiAlg.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiAlg.o : $(src)lib/GaudiAlg.cpp
	$(cpp_echo) $(src)lib/GaudiAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiAlg_cppflags) $(GaudiAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiAlg.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiAlg_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiAlg.cpp

$(bin)$(binobj)GaudiAlg.o : $(GaudiAlg_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiAlg_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiAlg_cppflags) $(GaudiAlg_cpp_cppflags) -I../src/lib $(src)lib/GaudiAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHistoID.d

$(bin)$(binobj)GaudiHistoID.d :

$(bin)$(binobj)GaudiHistoID.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiHistoID.o : $(src)lib/GaudiHistoID.cpp
	$(cpp_echo) $(src)lib/GaudiHistoID.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoID_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoID_cppflags) $(GaudiHistoID_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoID.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiHistoID_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiHistoID.cpp

$(bin)$(binobj)GaudiHistoID.o : $(GaudiHistoID_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiHistoID.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiHistoID_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiHistoID_cppflags) $(GaudiHistoID_cpp_cppflags) -I../src/lib $(src)lib/GaudiHistoID.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleObj.d

$(bin)$(binobj)TupleObj.d :

$(bin)$(binobj)TupleObj.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)TupleObj.o : $(src)lib/TupleObj.cpp
	$(cpp_echo) $(src)lib/TupleObj.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(TupleObj_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(TupleObj_cppflags) $(TupleObj_cpp_cppflags) -I../src/lib $(src)lib/TupleObj.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(TupleObj_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/TupleObj.cpp

$(bin)$(binobj)TupleObj.o : $(TupleObj_cpp_dependencies)
	$(cpp_echo) $(src)lib/TupleObj.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(TupleObj_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(TupleObj_cppflags) $(TupleObj_cpp_cppflags) -I../src/lib $(src)lib/TupleObj.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Sequencer.d

$(bin)$(binobj)Sequencer.d :

$(bin)$(binobj)Sequencer.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)Sequencer.o : $(src)lib/Sequencer.cpp
	$(cpp_echo) $(src)lib/Sequencer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Sequencer_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Sequencer_cppflags) $(Sequencer_cpp_cppflags) -I../src/lib $(src)lib/Sequencer.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(Sequencer_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/Sequencer.cpp

$(bin)$(binobj)Sequencer.o : $(Sequencer_cpp_dependencies)
	$(cpp_echo) $(src)lib/Sequencer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(Sequencer_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(Sequencer_cppflags) $(Sequencer_cpp_cppflags) -I../src/lib $(src)lib/Sequencer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiTuplesConstructors.d

$(bin)$(binobj)GaudiTuplesConstructors.d :

$(bin)$(binobj)GaudiTuplesConstructors.o : $(cmt_final_setup_GaudiAlgLib)

$(bin)$(binobj)GaudiTuplesConstructors.o : $(src)lib/GaudiTuplesConstructors.cpp
	$(cpp_echo) $(src)lib/GaudiTuplesConstructors.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTuplesConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTuplesConstructors_cppflags) $(GaudiTuplesConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiTuplesConstructors.cpp
endif
endif

else
$(bin)GaudiAlgLib_dependencies.make : $(GaudiTuplesConstructors_cpp_dependencies)

$(bin)GaudiAlgLib_dependencies.make : $(src)lib/GaudiTuplesConstructors.cpp

$(bin)$(binobj)GaudiTuplesConstructors.o : $(GaudiTuplesConstructors_cpp_dependencies)
	$(cpp_echo) $(src)lib/GaudiTuplesConstructors.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlgLib_pp_cppflags) $(lib_GaudiAlgLib_pp_cppflags) $(GaudiTuplesConstructors_pp_cppflags) $(use_cppflags) $(GaudiAlgLib_cppflags) $(lib_GaudiAlgLib_cppflags) $(GaudiTuplesConstructors_cppflags) $(GaudiTuplesConstructors_cpp_cppflags) -I../src/lib $(src)lib/GaudiTuplesConstructors.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiAlgLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlgLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiAlgLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiAlgLib$(library_suffix).a $(library_prefix)GaudiAlgLib$(library_suffix).$(shlibsuffix) GaudiAlgLib.stamp GaudiAlgLib.shstamp
#-- end of cleanup_library ---------------
