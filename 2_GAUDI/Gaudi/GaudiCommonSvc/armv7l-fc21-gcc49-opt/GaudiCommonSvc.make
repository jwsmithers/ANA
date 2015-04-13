#-- start of make_header -----------------

#====================================
#  Library GaudiCommonSvc
#
#   Generated Mon Feb 16 20:19:44 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCommonSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCommonSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCommonSvc

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvc = $(GaudiCommonSvc_tag)_GaudiCommonSvc.make
cmt_local_tagfile_GaudiCommonSvc = $(bin)$(GaudiCommonSvc_tag)_GaudiCommonSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvc = $(GaudiCommonSvc_tag).make
cmt_local_tagfile_GaudiCommonSvc = $(bin)$(GaudiCommonSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCommonSvc)
#-include $(cmt_local_tagfile_GaudiCommonSvc)

ifdef cmt_GaudiCommonSvc_has_target_tag

cmt_final_setup_GaudiCommonSvc = $(bin)setup_GaudiCommonSvc.make
cmt_dependencies_in_GaudiCommonSvc = $(bin)dependencies_GaudiCommonSvc.in
#cmt_final_setup_GaudiCommonSvc = $(bin)GaudiCommonSvc_GaudiCommonSvcsetup.make
cmt_local_GaudiCommonSvc_makefile = $(bin)GaudiCommonSvc.make

else

cmt_final_setup_GaudiCommonSvc = $(bin)setup.make
cmt_dependencies_in_GaudiCommonSvc = $(bin)dependencies.in
#cmt_final_setup_GaudiCommonSvc = $(bin)GaudiCommonSvcsetup.make
cmt_local_GaudiCommonSvc_makefile = $(bin)GaudiCommonSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCommonSvcsetup.make

#GaudiCommonSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCommonSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCommonSvc/
#GaudiCommonSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiCommonSvclibname   = $(bin)$(library_prefix)GaudiCommonSvc$(library_suffix)
GaudiCommonSvclib       = $(GaudiCommonSvclibname).a
GaudiCommonSvcstamp     = $(bin)GaudiCommonSvc.stamp
GaudiCommonSvcshstamp   = $(bin)GaudiCommonSvc.shstamp

GaudiCommonSvc :: dirs  GaudiCommonSvcLIB
	$(echo) "GaudiCommonSvc ok"

cmt_GaudiCommonSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiCommonSvc_has_prototypes

GaudiCommonSvcprototype :  ;

endif

GaudiCommonSvccompile : $(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiCommonSvcLIB :: $(GaudiCommonSvclib) $(GaudiCommonSvcshstamp)
GaudiCommonSvcLIB :: $(GaudiCommonSvcshstamp)
	$(echo) "GaudiCommonSvc : library ok"

$(GaudiCommonSvclib) :: $(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiCommonSvclib) $?
	$(lib_silent) $(ranlib) $(GaudiCommonSvclib)
	$(lib_silent) cat /dev/null >$(GaudiCommonSvcstamp)

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

$(GaudiCommonSvclibname).$(shlibsuffix) :: $(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o $(use_requirements) $(GaudiCommonSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o $(GaudiCommonSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiCommonSvcstamp) && \
	  cat /dev/null >$(GaudiCommonSvcshstamp)

$(GaudiCommonSvcshstamp) :: $(GaudiCommonSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiCommonSvclibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiCommonSvcstamp) && \
	  cat /dev/null >$(GaudiCommonSvcshstamp) ; fi

GaudiCommonSvcclean ::
	$(cleanup_echo) objects GaudiCommonSvc
	$(cleanup_silent) /bin/rm -f $(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o) $(patsubst %.o,%.dep,$(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o) $(patsubst %.o,%.d.stamp,$(bin)FileRecordDataSvc.o $(bin)RunRecordDataSvc.o $(bin)PartitionSwitchTool.o $(bin)EvtDataSvc.o $(bin)MultiStoreSvc.o $(bin)PartitionSwitchAlg.o $(bin)StoreSnifferAlg.o $(bin)StoreExplorerAlg.o $(bin)RecordDataSvc.o $(bin)AIDA_visibility_hack.o $(bin)P2D.o $(bin)HistogramSvc.o $(bin)P1D.o $(bin)H3D.o $(bin)H2D.o $(bin)H1D.o $(bin)DataSvcFileEntriesTool.o $(bin)SequentialOutputStream.o $(bin)EvtCollectionStream.o $(bin)InputCopyStream.o $(bin)RunRecordStream.o $(bin)OutputStream.o $(bin)TagCollectionStream.o $(bin)DetPersistencySvc.o $(bin)EvtPersistencySvc.o $(bin)RecordStream.o $(bin)PersistencySvc.o $(bin)HistogramPersistencySvc.o $(bin)OutputStreamAgent.o $(bin)ChronoStatSvc.o $(bin)CounterSvc.o $(bin)AuditorSvc.o $(bin)StatusCodeSvc.o $(bin)AlgContextSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiCommonSvc_deps GaudiCommonSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiCommonSvcinstallname = $(library_prefix)GaudiCommonSvc$(library_suffix).$(shlibsuffix)

GaudiCommonSvc :: GaudiCommonSvcinstall ;

install :: GaudiCommonSvcinstall ;

GaudiCommonSvcinstall :: $(install_dir)/$(GaudiCommonSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiCommonSvcinstallname) :: $(bin)$(GaudiCommonSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiCommonSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiCommonSvcclean :: GaudiCommonSvcuninstall

uninstall :: GaudiCommonSvcuninstall ;

GaudiCommonSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiCommonSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileRecordDataSvc.d

$(bin)$(binobj)FileRecordDataSvc.d :

$(bin)$(binobj)FileRecordDataSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)FileRecordDataSvc.o : $(src)DataSvc/FileRecordDataSvc.cpp
	$(cpp_echo) $(src)DataSvc/FileRecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(FileRecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(FileRecordDataSvc_cppflags) $(FileRecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/FileRecordDataSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(FileRecordDataSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/FileRecordDataSvc.cpp

$(bin)$(binobj)FileRecordDataSvc.o : $(FileRecordDataSvc_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/FileRecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(FileRecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(FileRecordDataSvc_cppflags) $(FileRecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/FileRecordDataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RunRecordDataSvc.d

$(bin)$(binobj)RunRecordDataSvc.d :

$(bin)$(binobj)RunRecordDataSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)RunRecordDataSvc.o : $(src)DataSvc/RunRecordDataSvc.cpp
	$(cpp_echo) $(src)DataSvc/RunRecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RunRecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RunRecordDataSvc_cppflags) $(RunRecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/RunRecordDataSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(RunRecordDataSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/RunRecordDataSvc.cpp

$(bin)$(binobj)RunRecordDataSvc.o : $(RunRecordDataSvc_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/RunRecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RunRecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RunRecordDataSvc_cppflags) $(RunRecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/RunRecordDataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PartitionSwitchTool.d

$(bin)$(binobj)PartitionSwitchTool.d :

$(bin)$(binobj)PartitionSwitchTool.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)PartitionSwitchTool.o : $(src)DataSvc/PartitionSwitchTool.cpp
	$(cpp_echo) $(src)DataSvc/PartitionSwitchTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PartitionSwitchTool_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PartitionSwitchTool_cppflags) $(PartitionSwitchTool_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/PartitionSwitchTool.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(PartitionSwitchTool_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/PartitionSwitchTool.cpp

$(bin)$(binobj)PartitionSwitchTool.o : $(PartitionSwitchTool_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/PartitionSwitchTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PartitionSwitchTool_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PartitionSwitchTool_cppflags) $(PartitionSwitchTool_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/PartitionSwitchTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtDataSvc.d

$(bin)$(binobj)EvtDataSvc.d :

$(bin)$(binobj)EvtDataSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)EvtDataSvc.o : $(src)DataSvc/EvtDataSvc.cpp
	$(cpp_echo) $(src)DataSvc/EvtDataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtDataSvc_cppflags) $(EvtDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/EvtDataSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(EvtDataSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/EvtDataSvc.cpp

$(bin)$(binobj)EvtDataSvc.o : $(EvtDataSvc_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/EvtDataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtDataSvc_cppflags) $(EvtDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/EvtDataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MultiStoreSvc.d

$(bin)$(binobj)MultiStoreSvc.d :

$(bin)$(binobj)MultiStoreSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)MultiStoreSvc.o : $(src)DataSvc/MultiStoreSvc.cpp
	$(cpp_echo) $(src)DataSvc/MultiStoreSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(MultiStoreSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(MultiStoreSvc_cppflags) $(MultiStoreSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/MultiStoreSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(MultiStoreSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/MultiStoreSvc.cpp

$(bin)$(binobj)MultiStoreSvc.o : $(MultiStoreSvc_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/MultiStoreSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(MultiStoreSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(MultiStoreSvc_cppflags) $(MultiStoreSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/MultiStoreSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PartitionSwitchAlg.d

$(bin)$(binobj)PartitionSwitchAlg.d :

$(bin)$(binobj)PartitionSwitchAlg.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)PartitionSwitchAlg.o : $(src)DataSvc/PartitionSwitchAlg.cpp
	$(cpp_echo) $(src)DataSvc/PartitionSwitchAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PartitionSwitchAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PartitionSwitchAlg_cppflags) $(PartitionSwitchAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/PartitionSwitchAlg.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(PartitionSwitchAlg_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/PartitionSwitchAlg.cpp

$(bin)$(binobj)PartitionSwitchAlg.o : $(PartitionSwitchAlg_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/PartitionSwitchAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PartitionSwitchAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PartitionSwitchAlg_cppflags) $(PartitionSwitchAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/PartitionSwitchAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StoreSnifferAlg.d

$(bin)$(binobj)StoreSnifferAlg.d :

$(bin)$(binobj)StoreSnifferAlg.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)StoreSnifferAlg.o : $(src)DataSvc/StoreSnifferAlg.cpp
	$(cpp_echo) $(src)DataSvc/StoreSnifferAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StoreSnifferAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StoreSnifferAlg_cppflags) $(StoreSnifferAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/StoreSnifferAlg.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(StoreSnifferAlg_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/StoreSnifferAlg.cpp

$(bin)$(binobj)StoreSnifferAlg.o : $(StoreSnifferAlg_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/StoreSnifferAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StoreSnifferAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StoreSnifferAlg_cppflags) $(StoreSnifferAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/StoreSnifferAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StoreExplorerAlg.d

$(bin)$(binobj)StoreExplorerAlg.d :

$(bin)$(binobj)StoreExplorerAlg.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)StoreExplorerAlg.o : $(src)DataSvc/StoreExplorerAlg.cpp
	$(cpp_echo) $(src)DataSvc/StoreExplorerAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StoreExplorerAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StoreExplorerAlg_cppflags) $(StoreExplorerAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/StoreExplorerAlg.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(StoreExplorerAlg_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/StoreExplorerAlg.cpp

$(bin)$(binobj)StoreExplorerAlg.o : $(StoreExplorerAlg_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/StoreExplorerAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StoreExplorerAlg_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StoreExplorerAlg_cppflags) $(StoreExplorerAlg_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/StoreExplorerAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecordDataSvc.d

$(bin)$(binobj)RecordDataSvc.d :

$(bin)$(binobj)RecordDataSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)RecordDataSvc.o : $(src)DataSvc/RecordDataSvc.cpp
	$(cpp_echo) $(src)DataSvc/RecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RecordDataSvc_cppflags) $(RecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/RecordDataSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(RecordDataSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)DataSvc/RecordDataSvc.cpp

$(bin)$(binobj)RecordDataSvc.o : $(RecordDataSvc_cpp_dependencies)
	$(cpp_echo) $(src)DataSvc/RecordDataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RecordDataSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RecordDataSvc_cppflags) $(RecordDataSvc_cpp_cppflags) -I../src/DataSvc $(src)DataSvc/RecordDataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AIDA_visibility_hack.d

$(bin)$(binobj)AIDA_visibility_hack.d :

$(bin)$(binobj)AIDA_visibility_hack.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)AIDA_visibility_hack.o : $(src)HistogramSvc/AIDA_visibility_hack.cpp
	$(cpp_echo) $(src)HistogramSvc/AIDA_visibility_hack.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AIDA_visibility_hack_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AIDA_visibility_hack_cppflags) $(AIDA_visibility_hack_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/AIDA_visibility_hack.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(AIDA_visibility_hack_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/AIDA_visibility_hack.cpp

$(bin)$(binobj)AIDA_visibility_hack.o : $(AIDA_visibility_hack_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/AIDA_visibility_hack.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AIDA_visibility_hack_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AIDA_visibility_hack_cppflags) $(AIDA_visibility_hack_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/AIDA_visibility_hack.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)P2D.d

$(bin)$(binobj)P2D.d :

$(bin)$(binobj)P2D.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)P2D.o : $(src)HistogramSvc/P2D.cpp
	$(cpp_echo) $(src)HistogramSvc/P2D.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(P2D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(P2D_cppflags) $(P2D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/P2D.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(P2D_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/P2D.cpp

$(bin)$(binobj)P2D.o : $(P2D_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/P2D.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(P2D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(P2D_cppflags) $(P2D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/P2D.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistogramSvc.d

$(bin)$(binobj)HistogramSvc.d :

$(bin)$(binobj)HistogramSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)HistogramSvc.o : $(src)HistogramSvc/HistogramSvc.cpp
	$(cpp_echo) $(src)HistogramSvc/HistogramSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(HistogramSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(HistogramSvc_cppflags) $(HistogramSvc_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/HistogramSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(HistogramSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/HistogramSvc.cpp

$(bin)$(binobj)HistogramSvc.o : $(HistogramSvc_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/HistogramSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(HistogramSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(HistogramSvc_cppflags) $(HistogramSvc_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/HistogramSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)P1D.d

$(bin)$(binobj)P1D.d :

$(bin)$(binobj)P1D.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)P1D.o : $(src)HistogramSvc/P1D.cpp
	$(cpp_echo) $(src)HistogramSvc/P1D.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(P1D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(P1D_cppflags) $(P1D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/P1D.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(P1D_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/P1D.cpp

$(bin)$(binobj)P1D.o : $(P1D_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/P1D.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(P1D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(P1D_cppflags) $(P1D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/P1D.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)H3D.d

$(bin)$(binobj)H3D.d :

$(bin)$(binobj)H3D.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)H3D.o : $(src)HistogramSvc/H3D.cpp
	$(cpp_echo) $(src)HistogramSvc/H3D.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H3D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H3D_cppflags) $(H3D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H3D.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(H3D_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/H3D.cpp

$(bin)$(binobj)H3D.o : $(H3D_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/H3D.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H3D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H3D_cppflags) $(H3D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H3D.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)H2D.d

$(bin)$(binobj)H2D.d :

$(bin)$(binobj)H2D.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)H2D.o : $(src)HistogramSvc/H2D.cpp
	$(cpp_echo) $(src)HistogramSvc/H2D.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H2D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H2D_cppflags) $(H2D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H2D.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(H2D_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/H2D.cpp

$(bin)$(binobj)H2D.o : $(H2D_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/H2D.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H2D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H2D_cppflags) $(H2D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H2D.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)H1D.d

$(bin)$(binobj)H1D.d :

$(bin)$(binobj)H1D.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)H1D.o : $(src)HistogramSvc/H1D.cpp
	$(cpp_echo) $(src)HistogramSvc/H1D.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H1D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H1D_cppflags) $(H1D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H1D.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(H1D_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)HistogramSvc/H1D.cpp

$(bin)$(binobj)H1D.o : $(H1D_cpp_dependencies)
	$(cpp_echo) $(src)HistogramSvc/H1D.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(H1D_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(H1D_cppflags) $(H1D_cpp_cppflags) -I../src/HistogramSvc $(src)HistogramSvc/H1D.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataSvcFileEntriesTool.d

$(bin)$(binobj)DataSvcFileEntriesTool.d :

$(bin)$(binobj)DataSvcFileEntriesTool.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)DataSvcFileEntriesTool.o : $(src)PersistencySvc/DataSvcFileEntriesTool.cpp
	$(cpp_echo) $(src)PersistencySvc/DataSvcFileEntriesTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(DataSvcFileEntriesTool_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(DataSvcFileEntriesTool_cppflags) $(DataSvcFileEntriesTool_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/DataSvcFileEntriesTool.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(DataSvcFileEntriesTool_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/DataSvcFileEntriesTool.cpp

$(bin)$(binobj)DataSvcFileEntriesTool.o : $(DataSvcFileEntriesTool_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/DataSvcFileEntriesTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(DataSvcFileEntriesTool_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(DataSvcFileEntriesTool_cppflags) $(DataSvcFileEntriesTool_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/DataSvcFileEntriesTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SequentialOutputStream.d

$(bin)$(binobj)SequentialOutputStream.d :

$(bin)$(binobj)SequentialOutputStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)SequentialOutputStream.o : $(src)PersistencySvc/SequentialOutputStream.cpp
	$(cpp_echo) $(src)PersistencySvc/SequentialOutputStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(SequentialOutputStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(SequentialOutputStream_cppflags) $(SequentialOutputStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/SequentialOutputStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(SequentialOutputStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/SequentialOutputStream.cpp

$(bin)$(binobj)SequentialOutputStream.o : $(SequentialOutputStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/SequentialOutputStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(SequentialOutputStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(SequentialOutputStream_cppflags) $(SequentialOutputStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/SequentialOutputStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtCollectionStream.d

$(bin)$(binobj)EvtCollectionStream.d :

$(bin)$(binobj)EvtCollectionStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)EvtCollectionStream.o : $(src)PersistencySvc/EvtCollectionStream.cpp
	$(cpp_echo) $(src)PersistencySvc/EvtCollectionStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtCollectionStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtCollectionStream_cppflags) $(EvtCollectionStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/EvtCollectionStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(EvtCollectionStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/EvtCollectionStream.cpp

$(bin)$(binobj)EvtCollectionStream.o : $(EvtCollectionStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/EvtCollectionStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtCollectionStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtCollectionStream_cppflags) $(EvtCollectionStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/EvtCollectionStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)InputCopyStream.d

$(bin)$(binobj)InputCopyStream.d :

$(bin)$(binobj)InputCopyStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)InputCopyStream.o : $(src)PersistencySvc/InputCopyStream.cpp
	$(cpp_echo) $(src)PersistencySvc/InputCopyStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(InputCopyStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(InputCopyStream_cppflags) $(InputCopyStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/InputCopyStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(InputCopyStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/InputCopyStream.cpp

$(bin)$(binobj)InputCopyStream.o : $(InputCopyStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/InputCopyStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(InputCopyStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(InputCopyStream_cppflags) $(InputCopyStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/InputCopyStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RunRecordStream.d

$(bin)$(binobj)RunRecordStream.d :

$(bin)$(binobj)RunRecordStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)RunRecordStream.o : $(src)PersistencySvc/RunRecordStream.cpp
	$(cpp_echo) $(src)PersistencySvc/RunRecordStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RunRecordStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RunRecordStream_cppflags) $(RunRecordStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/RunRecordStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(RunRecordStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/RunRecordStream.cpp

$(bin)$(binobj)RunRecordStream.o : $(RunRecordStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/RunRecordStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RunRecordStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RunRecordStream_cppflags) $(RunRecordStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/RunRecordStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OutputStream.d

$(bin)$(binobj)OutputStream.d :

$(bin)$(binobj)OutputStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)OutputStream.o : $(src)PersistencySvc/OutputStream.cpp
	$(cpp_echo) $(src)PersistencySvc/OutputStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(OutputStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(OutputStream_cppflags) $(OutputStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/OutputStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(OutputStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/OutputStream.cpp

$(bin)$(binobj)OutputStream.o : $(OutputStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/OutputStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(OutputStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(OutputStream_cppflags) $(OutputStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/OutputStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TagCollectionStream.d

$(bin)$(binobj)TagCollectionStream.d :

$(bin)$(binobj)TagCollectionStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)TagCollectionStream.o : $(src)PersistencySvc/TagCollectionStream.cpp
	$(cpp_echo) $(src)PersistencySvc/TagCollectionStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(TagCollectionStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(TagCollectionStream_cppflags) $(TagCollectionStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/TagCollectionStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(TagCollectionStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/TagCollectionStream.cpp

$(bin)$(binobj)TagCollectionStream.o : $(TagCollectionStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/TagCollectionStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(TagCollectionStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(TagCollectionStream_cppflags) $(TagCollectionStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/TagCollectionStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DetPersistencySvc.d

$(bin)$(binobj)DetPersistencySvc.d :

$(bin)$(binobj)DetPersistencySvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)DetPersistencySvc.o : $(src)PersistencySvc/DetPersistencySvc.cpp
	$(cpp_echo) $(src)PersistencySvc/DetPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(DetPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(DetPersistencySvc_cppflags) $(DetPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/DetPersistencySvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(DetPersistencySvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/DetPersistencySvc.cpp

$(bin)$(binobj)DetPersistencySvc.o : $(DetPersistencySvc_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/DetPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(DetPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(DetPersistencySvc_cppflags) $(DetPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/DetPersistencySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtPersistencySvc.d

$(bin)$(binobj)EvtPersistencySvc.d :

$(bin)$(binobj)EvtPersistencySvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)EvtPersistencySvc.o : $(src)PersistencySvc/EvtPersistencySvc.cpp
	$(cpp_echo) $(src)PersistencySvc/EvtPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtPersistencySvc_cppflags) $(EvtPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/EvtPersistencySvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(EvtPersistencySvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/EvtPersistencySvc.cpp

$(bin)$(binobj)EvtPersistencySvc.o : $(EvtPersistencySvc_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/EvtPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(EvtPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(EvtPersistencySvc_cppflags) $(EvtPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/EvtPersistencySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecordStream.d

$(bin)$(binobj)RecordStream.d :

$(bin)$(binobj)RecordStream.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)RecordStream.o : $(src)PersistencySvc/RecordStream.cpp
	$(cpp_echo) $(src)PersistencySvc/RecordStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RecordStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RecordStream_cppflags) $(RecordStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/RecordStream.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(RecordStream_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/RecordStream.cpp

$(bin)$(binobj)RecordStream.o : $(RecordStream_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/RecordStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(RecordStream_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(RecordStream_cppflags) $(RecordStream_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/RecordStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PersistencySvc.d

$(bin)$(binobj)PersistencySvc.d :

$(bin)$(binobj)PersistencySvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)PersistencySvc.o : $(src)PersistencySvc/PersistencySvc.cpp
	$(cpp_echo) $(src)PersistencySvc/PersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PersistencySvc_cppflags) $(PersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/PersistencySvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(PersistencySvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/PersistencySvc.cpp

$(bin)$(binobj)PersistencySvc.o : $(PersistencySvc_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/PersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(PersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(PersistencySvc_cppflags) $(PersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/PersistencySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistogramPersistencySvc.d

$(bin)$(binobj)HistogramPersistencySvc.d :

$(bin)$(binobj)HistogramPersistencySvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)HistogramPersistencySvc.o : $(src)PersistencySvc/HistogramPersistencySvc.cpp
	$(cpp_echo) $(src)PersistencySvc/HistogramPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(HistogramPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(HistogramPersistencySvc_cppflags) $(HistogramPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/HistogramPersistencySvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(HistogramPersistencySvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/HistogramPersistencySvc.cpp

$(bin)$(binobj)HistogramPersistencySvc.o : $(HistogramPersistencySvc_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/HistogramPersistencySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(HistogramPersistencySvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(HistogramPersistencySvc_cppflags) $(HistogramPersistencySvc_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/HistogramPersistencySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OutputStreamAgent.d

$(bin)$(binobj)OutputStreamAgent.d :

$(bin)$(binobj)OutputStreamAgent.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)OutputStreamAgent.o : $(src)PersistencySvc/OutputStreamAgent.cpp
	$(cpp_echo) $(src)PersistencySvc/OutputStreamAgent.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(OutputStreamAgent_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(OutputStreamAgent_cppflags) $(OutputStreamAgent_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/OutputStreamAgent.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(OutputStreamAgent_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)PersistencySvc/OutputStreamAgent.cpp

$(bin)$(binobj)OutputStreamAgent.o : $(OutputStreamAgent_cpp_dependencies)
	$(cpp_echo) $(src)PersistencySvc/OutputStreamAgent.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(OutputStreamAgent_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(OutputStreamAgent_cppflags) $(OutputStreamAgent_cpp_cppflags) -I../src/PersistencySvc $(src)PersistencySvc/OutputStreamAgent.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ChronoStatSvc.d

$(bin)$(binobj)ChronoStatSvc.d :

$(bin)$(binobj)ChronoStatSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)ChronoStatSvc.o : $(src)ChronoStatSvc.cpp
	$(cpp_echo) $(src)ChronoStatSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(ChronoStatSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(ChronoStatSvc_cppflags) $(ChronoStatSvc_cpp_cppflags)  $(src)ChronoStatSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(ChronoStatSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)ChronoStatSvc.cpp

$(bin)$(binobj)ChronoStatSvc.o : $(ChronoStatSvc_cpp_dependencies)
	$(cpp_echo) $(src)ChronoStatSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(ChronoStatSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(ChronoStatSvc_cppflags) $(ChronoStatSvc_cpp_cppflags)  $(src)ChronoStatSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CounterSvc.d

$(bin)$(binobj)CounterSvc.d :

$(bin)$(binobj)CounterSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)CounterSvc.o : $(src)CounterSvc.cpp
	$(cpp_echo) $(src)CounterSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(CounterSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(CounterSvc_cppflags) $(CounterSvc_cpp_cppflags)  $(src)CounterSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(CounterSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)CounterSvc.cpp

$(bin)$(binobj)CounterSvc.o : $(CounterSvc_cpp_dependencies)
	$(cpp_echo) $(src)CounterSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(CounterSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(CounterSvc_cppflags) $(CounterSvc_cpp_cppflags)  $(src)CounterSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AuditorSvc.d

$(bin)$(binobj)AuditorSvc.d :

$(bin)$(binobj)AuditorSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)AuditorSvc.o : $(src)AuditorSvc.cpp
	$(cpp_echo) $(src)AuditorSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AuditorSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AuditorSvc_cppflags) $(AuditorSvc_cpp_cppflags)  $(src)AuditorSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(AuditorSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)AuditorSvc.cpp

$(bin)$(binobj)AuditorSvc.o : $(AuditorSvc_cpp_dependencies)
	$(cpp_echo) $(src)AuditorSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AuditorSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AuditorSvc_cppflags) $(AuditorSvc_cpp_cppflags)  $(src)AuditorSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatusCodeSvc.d

$(bin)$(binobj)StatusCodeSvc.d :

$(bin)$(binobj)StatusCodeSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)StatusCodeSvc.o : $(src)StatusCodeSvc.cpp
	$(cpp_echo) $(src)StatusCodeSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StatusCodeSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StatusCodeSvc_cppflags) $(StatusCodeSvc_cpp_cppflags)  $(src)StatusCodeSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(StatusCodeSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)StatusCodeSvc.cpp

$(bin)$(binobj)StatusCodeSvc.o : $(StatusCodeSvc_cpp_dependencies)
	$(cpp_echo) $(src)StatusCodeSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(StatusCodeSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(StatusCodeSvc_cppflags) $(StatusCodeSvc_cpp_cppflags)  $(src)StatusCodeSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCommonSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgContextSvc.d

$(bin)$(binobj)AlgContextSvc.d :

$(bin)$(binobj)AlgContextSvc.o : $(cmt_final_setup_GaudiCommonSvc)

$(bin)$(binobj)AlgContextSvc.o : $(src)AlgContextSvc.cpp
	$(cpp_echo) $(src)AlgContextSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AlgContextSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AlgContextSvc_cppflags) $(AlgContextSvc_cpp_cppflags)  $(src)AlgContextSvc.cpp
endif
endif

else
$(bin)GaudiCommonSvc_dependencies.make : $(AlgContextSvc_cpp_dependencies)

$(bin)GaudiCommonSvc_dependencies.make : $(src)AlgContextSvc.cpp

$(bin)$(binobj)AlgContextSvc.o : $(AlgContextSvc_cpp_dependencies)
	$(cpp_echo) $(src)AlgContextSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCommonSvc_pp_cppflags) $(lib_GaudiCommonSvc_pp_cppflags) $(AlgContextSvc_pp_cppflags) $(use_cppflags) $(GaudiCommonSvc_cppflags) $(lib_GaudiCommonSvc_cppflags) $(AlgContextSvc_cppflags) $(AlgContextSvc_cpp_cppflags)  $(src)AlgContextSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiCommonSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCommonSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCommonSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiCommonSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiCommonSvc$(library_suffix).a $(library_prefix)GaudiCommonSvc$(library_suffix).$(shlibsuffix) GaudiCommonSvc.stamp GaudiCommonSvc.shstamp
#-- end of cleanup_library ---------------
