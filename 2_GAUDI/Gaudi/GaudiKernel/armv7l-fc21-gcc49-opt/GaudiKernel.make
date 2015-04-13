#-- start of make_header -----------------

#====================================
#  Library GaudiKernel
#
#   Generated Mon Feb 16 19:31:28 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiKernel_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiKernel_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiKernel

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernel = $(GaudiKernel_tag)_GaudiKernel.make
cmt_local_tagfile_GaudiKernel = $(bin)$(GaudiKernel_tag)_GaudiKernel.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernel = $(GaudiKernel_tag).make
cmt_local_tagfile_GaudiKernel = $(bin)$(GaudiKernel_tag).make

endif

include $(cmt_local_tagfile_GaudiKernel)
#-include $(cmt_local_tagfile_GaudiKernel)

ifdef cmt_GaudiKernel_has_target_tag

cmt_final_setup_GaudiKernel = $(bin)setup_GaudiKernel.make
cmt_dependencies_in_GaudiKernel = $(bin)dependencies_GaudiKernel.in
#cmt_final_setup_GaudiKernel = $(bin)GaudiKernel_GaudiKernelsetup.make
cmt_local_GaudiKernel_makefile = $(bin)GaudiKernel.make

else

cmt_final_setup_GaudiKernel = $(bin)setup.make
cmt_dependencies_in_GaudiKernel = $(bin)dependencies.in
#cmt_final_setup_GaudiKernel = $(bin)GaudiKernelsetup.make
cmt_local_GaudiKernel_makefile = $(bin)GaudiKernel.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make

#GaudiKernel :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiKernel'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiKernel/
#GaudiKernel::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiKernellibname   = $(bin)$(library_prefix)GaudiKernel$(library_suffix)
GaudiKernellib       = $(GaudiKernellibname).a
GaudiKernelstamp     = $(bin)GaudiKernel.stamp
GaudiKernelshstamp   = $(bin)GaudiKernel.shstamp

GaudiKernel :: dirs  GaudiKernelLIB
	$(echo) "GaudiKernel ok"

cmt_GaudiKernel_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiKernel_has_prototypes

GaudiKernelprototype :  ;

endif

GaudiKernelcompile : $(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiKernelLIB :: $(GaudiKernellib) $(GaudiKernelshstamp)
GaudiKernelLIB :: $(GaudiKernelshstamp)
	$(echo) "GaudiKernel : library ok"

$(GaudiKernellib) :: $(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiKernellib) $?
	$(lib_silent) $(ranlib) $(GaudiKernellib)
	$(lib_silent) cat /dev/null >$(GaudiKernelstamp)

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

$(GaudiKernellibname).$(shlibsuffix) :: $(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o $(use_requirements) $(GaudiKernelstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o $(GaudiKernel_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiKernelstamp) && \
	  cat /dev/null >$(GaudiKernelshstamp)

$(GaudiKernelshstamp) :: $(GaudiKernellibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiKernellibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiKernelstamp) && \
	  cat /dev/null >$(GaudiKernelshstamp) ; fi

GaudiKernelclean ::
	$(cleanup_echo) objects GaudiKernel
	$(cleanup_silent) /bin/rm -f $(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o) $(patsubst %.o,%.dep,$(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o) $(patsubst %.o,%.d.stamp,$(bin)ServiceHistory.o $(bin)Range.o $(bin)CommandProperty.o $(bin)NTupleImplementation.o $(bin)Tokenizer.o $(bin)Property.o $(bin)Time.o $(bin)GaudiException.o $(bin)DataObject.o $(bin)Message.o $(bin)ModuleInfo.o $(bin)Converter.o $(bin)AlgorithmHistory.o $(bin)LinkManager.o $(bin)StringKey.o $(bin)Algorithm.o $(bin)MsgStream.o $(bin)ParsersStandardMisc1.o $(bin)IExceptionSvc.o $(bin)WatchdogThread.o $(bin)GaudiKernel.o $(bin)ParsersStandardMisc5.o $(bin)IChronoStatSvc.o $(bin)DataHistory.o $(bin)Environment.o $(bin)SmartRefBase.o $(bin)Dictionary.o $(bin)ParsersStandardList4.o $(bin)ParsersStandardSingle.o $(bin)Auditor.o $(bin)ChronoEntity.o $(bin)Sleep.o $(bin)ConversionSvc.o $(bin)Lomont.o $(bin)Timing.o $(bin)DataStreamTool.o $(bin)IssueSeverity.o $(bin)RndmGenerators.o $(bin)AllocatorPool.o $(bin)ICounterSvc.o $(bin)MinimalEventLoopMgr.o $(bin)AlgTool.o $(bin)Debugger.o $(bin)JobHistory.o $(bin)RndmTypeInfos.o $(bin)DataSvc.o $(bin)DataTypeInfo.o $(bin)ThreadGaudi.o $(bin)ParsersStandardMisc3.o $(bin)ParsersStandardMisc4.o $(bin)MapBase.o $(bin)GaudiMain.o $(bin)GaudiHandle.o $(bin)KeyedObject.o $(bin)Bootstrap.o $(bin)ParsersVct.o $(bin)ParsersStandardMisc2.o $(bin)Guards.o $(bin)PropertyMgr.o $(bin)System.o $(bin)PropertyCallbackFunctor.o $(bin)PathResolver.o $(bin)SmartDataObjectPtr.o $(bin)EventSelectorDataStream.o $(bin)StatEntity.o $(bin)RegistryEntry.o $(bin)Memory.o $(bin)ComponentManager.o $(bin)ServiceLocatorHelper.o $(bin)StateMachine.o $(bin)ParsersStandardList1.o $(bin)ProcessDescriptor.o $(bin)DirSearchPath.o $(bin)KeyedObjectManager.o $(bin)ParsersStandardList2.o $(bin)StatusCode.o $(bin)NTupleItems.o $(bin)Selector.o $(bin)xtoa.o $(bin)HistoDef.o $(bin)HistoryObj.o $(bin)ParsersHistograms.o $(bin)Stat.o $(bin)ParsersCollections.o $(bin)VirtualDestructors.o $(bin)Service.o $(bin)AlgToolHistory.o $(bin)AlgContext.o $(bin)ParsersStandardList3.o $(bin)ContainedObject.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiKernel_deps GaudiKernel_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiKernelinstallname = $(library_prefix)GaudiKernel$(library_suffix).$(shlibsuffix)

GaudiKernel :: GaudiKernelinstall ;

install :: GaudiKernelinstall ;

GaudiKernelinstall :: $(install_dir)/$(GaudiKernelinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiKernelinstallname) :: $(bin)$(GaudiKernelinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiKernelinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiKernelclean :: GaudiKerneluninstall

uninstall :: GaudiKerneluninstall ;

GaudiKerneluninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiKernelinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceHistory.d

$(bin)$(binobj)ServiceHistory.d :

$(bin)$(binobj)ServiceHistory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ServiceHistory.o : $(src)Lib/ServiceHistory.cpp
	$(cpp_echo) $(src)Lib/ServiceHistory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ServiceHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ServiceHistory_cppflags) $(ServiceHistory_cpp_cppflags) -I../src/Lib $(src)Lib/ServiceHistory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ServiceHistory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ServiceHistory.cpp

$(bin)$(binobj)ServiceHistory.o : $(ServiceHistory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ServiceHistory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ServiceHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ServiceHistory_cppflags) $(ServiceHistory_cpp_cppflags) -I../src/Lib $(src)Lib/ServiceHistory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Range.d

$(bin)$(binobj)Range.d :

$(bin)$(binobj)Range.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Range.o : $(src)Lib/Range.cpp
	$(cpp_echo) $(src)Lib/Range.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Range_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Range_cppflags) $(Range_cpp_cppflags) -I../src/Lib $(src)Lib/Range.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Range_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Range.cpp

$(bin)$(binobj)Range.o : $(Range_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Range.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Range_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Range_cppflags) $(Range_cpp_cppflags) -I../src/Lib $(src)Lib/Range.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CommandProperty.d

$(bin)$(binobj)CommandProperty.d :

$(bin)$(binobj)CommandProperty.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)CommandProperty.o : $(src)Lib/CommandProperty.cpp
	$(cpp_echo) $(src)Lib/CommandProperty.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(CommandProperty_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(CommandProperty_cppflags) $(CommandProperty_cpp_cppflags) -I../src/Lib $(src)Lib/CommandProperty.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(CommandProperty_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/CommandProperty.cpp

$(bin)$(binobj)CommandProperty.o : $(CommandProperty_cpp_dependencies)
	$(cpp_echo) $(src)Lib/CommandProperty.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(CommandProperty_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(CommandProperty_cppflags) $(CommandProperty_cpp_cppflags) -I../src/Lib $(src)Lib/CommandProperty.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NTupleImplementation.d

$(bin)$(binobj)NTupleImplementation.d :

$(bin)$(binobj)NTupleImplementation.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)NTupleImplementation.o : $(src)Lib/NTupleImplementation.cpp
	$(cpp_echo) $(src)Lib/NTupleImplementation.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(NTupleImplementation_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(NTupleImplementation_cppflags) $(NTupleImplementation_cpp_cppflags) -I../src/Lib $(src)Lib/NTupleImplementation.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(NTupleImplementation_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/NTupleImplementation.cpp

$(bin)$(binobj)NTupleImplementation.o : $(NTupleImplementation_cpp_dependencies)
	$(cpp_echo) $(src)Lib/NTupleImplementation.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(NTupleImplementation_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(NTupleImplementation_cppflags) $(NTupleImplementation_cpp_cppflags) -I../src/Lib $(src)Lib/NTupleImplementation.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Tokenizer.d

$(bin)$(binobj)Tokenizer.d :

$(bin)$(binobj)Tokenizer.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Tokenizer.o : $(src)Lib/Tokenizer.cpp
	$(cpp_echo) $(src)Lib/Tokenizer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Tokenizer_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Tokenizer_cppflags) $(Tokenizer_cpp_cppflags) -I../src/Lib $(src)Lib/Tokenizer.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Tokenizer_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Tokenizer.cpp

$(bin)$(binobj)Tokenizer.o : $(Tokenizer_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Tokenizer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Tokenizer_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Tokenizer_cppflags) $(Tokenizer_cpp_cppflags) -I../src/Lib $(src)Lib/Tokenizer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Property.d

$(bin)$(binobj)Property.d :

$(bin)$(binobj)Property.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Property.o : $(src)Lib/Property.cpp
	$(cpp_echo) $(src)Lib/Property.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Property_cppflags) $(Property_cpp_cppflags) -I../src/Lib $(src)Lib/Property.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Property_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Property.cpp

$(bin)$(binobj)Property.o : $(Property_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Property.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Property_cppflags) $(Property_cpp_cppflags) -I../src/Lib $(src)Lib/Property.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Time.d

$(bin)$(binobj)Time.d :

$(bin)$(binobj)Time.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Time.o : $(src)Lib/Time.cpp
	$(cpp_echo) $(src)Lib/Time.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Time_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Time_cppflags) $(Time_cpp_cppflags) -I../src/Lib $(src)Lib/Time.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Time_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Time.cpp

$(bin)$(binobj)Time.o : $(Time_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Time.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Time_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Time_cppflags) $(Time_cpp_cppflags) -I../src/Lib $(src)Lib/Time.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiException.d

$(bin)$(binobj)GaudiException.d :

$(bin)$(binobj)GaudiException.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)GaudiException.o : $(src)Lib/GaudiException.cpp
	$(cpp_echo) $(src)Lib/GaudiException.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiException_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiException_cppflags) $(GaudiException_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiException.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(GaudiException_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/GaudiException.cpp

$(bin)$(binobj)GaudiException.o : $(GaudiException_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GaudiException.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiException_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiException_cppflags) $(GaudiException_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiException.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataObject.d

$(bin)$(binobj)DataObject.d :

$(bin)$(binobj)DataObject.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DataObject.o : $(src)Lib/DataObject.cpp
	$(cpp_echo) $(src)Lib/DataObject.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataObject_cppflags) $(DataObject_cpp_cppflags) -I../src/Lib $(src)Lib/DataObject.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DataObject_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DataObject.cpp

$(bin)$(binobj)DataObject.o : $(DataObject_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DataObject.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataObject_cppflags) $(DataObject_cpp_cppflags) -I../src/Lib $(src)Lib/DataObject.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Message.d

$(bin)$(binobj)Message.d :

$(bin)$(binobj)Message.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Message.o : $(src)Lib/Message.cpp
	$(cpp_echo) $(src)Lib/Message.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Message_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Message_cppflags) $(Message_cpp_cppflags) -I../src/Lib $(src)Lib/Message.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Message_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Message.cpp

$(bin)$(binobj)Message.o : $(Message_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Message.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Message_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Message_cppflags) $(Message_cpp_cppflags) -I../src/Lib $(src)Lib/Message.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ModuleInfo.d

$(bin)$(binobj)ModuleInfo.d :

$(bin)$(binobj)ModuleInfo.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ModuleInfo.o : $(src)Lib/ModuleInfo.cpp
	$(cpp_echo) $(src)Lib/ModuleInfo.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ModuleInfo_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ModuleInfo_cppflags) $(ModuleInfo_cpp_cppflags) -I../src/Lib $(src)Lib/ModuleInfo.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ModuleInfo_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ModuleInfo.cpp

$(bin)$(binobj)ModuleInfo.o : $(ModuleInfo_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ModuleInfo.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ModuleInfo_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ModuleInfo_cppflags) $(ModuleInfo_cpp_cppflags) -I../src/Lib $(src)Lib/ModuleInfo.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Converter.d

$(bin)$(binobj)Converter.d :

$(bin)$(binobj)Converter.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Converter.o : $(src)Lib/Converter.cpp
	$(cpp_echo) $(src)Lib/Converter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Converter_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Converter_cppflags) $(Converter_cpp_cppflags) -I../src/Lib $(src)Lib/Converter.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Converter_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Converter.cpp

$(bin)$(binobj)Converter.o : $(Converter_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Converter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Converter_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Converter_cppflags) $(Converter_cpp_cppflags) -I../src/Lib $(src)Lib/Converter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgorithmHistory.d

$(bin)$(binobj)AlgorithmHistory.d :

$(bin)$(binobj)AlgorithmHistory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)AlgorithmHistory.o : $(src)Lib/AlgorithmHistory.cpp
	$(cpp_echo) $(src)Lib/AlgorithmHistory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgorithmHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgorithmHistory_cppflags) $(AlgorithmHistory_cpp_cppflags) -I../src/Lib $(src)Lib/AlgorithmHistory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(AlgorithmHistory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/AlgorithmHistory.cpp

$(bin)$(binobj)AlgorithmHistory.o : $(AlgorithmHistory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AlgorithmHistory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgorithmHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgorithmHistory_cppflags) $(AlgorithmHistory_cpp_cppflags) -I../src/Lib $(src)Lib/AlgorithmHistory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LinkManager.d

$(bin)$(binobj)LinkManager.d :

$(bin)$(binobj)LinkManager.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)LinkManager.o : $(src)Lib/LinkManager.cpp
	$(cpp_echo) $(src)Lib/LinkManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(LinkManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(LinkManager_cppflags) $(LinkManager_cpp_cppflags) -I../src/Lib $(src)Lib/LinkManager.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(LinkManager_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/LinkManager.cpp

$(bin)$(binobj)LinkManager.o : $(LinkManager_cpp_dependencies)
	$(cpp_echo) $(src)Lib/LinkManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(LinkManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(LinkManager_cppflags) $(LinkManager_cpp_cppflags) -I../src/Lib $(src)Lib/LinkManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StringKey.d

$(bin)$(binobj)StringKey.d :

$(bin)$(binobj)StringKey.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)StringKey.o : $(src)Lib/StringKey.cpp
	$(cpp_echo) $(src)Lib/StringKey.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StringKey_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StringKey_cppflags) $(StringKey_cpp_cppflags) -I../src/Lib $(src)Lib/StringKey.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(StringKey_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/StringKey.cpp

$(bin)$(binobj)StringKey.o : $(StringKey_cpp_dependencies)
	$(cpp_echo) $(src)Lib/StringKey.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StringKey_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StringKey_cppflags) $(StringKey_cpp_cppflags) -I../src/Lib $(src)Lib/StringKey.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Algorithm.d

$(bin)$(binobj)Algorithm.d :

$(bin)$(binobj)Algorithm.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Algorithm.o : $(src)Lib/Algorithm.cpp
	$(cpp_echo) $(src)Lib/Algorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Algorithm_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Algorithm_cppflags) $(Algorithm_cpp_cppflags) -I../src/Lib $(src)Lib/Algorithm.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Algorithm_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Algorithm.cpp

$(bin)$(binobj)Algorithm.o : $(Algorithm_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Algorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Algorithm_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Algorithm_cppflags) $(Algorithm_cpp_cppflags) -I../src/Lib $(src)Lib/Algorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MsgStream.d

$(bin)$(binobj)MsgStream.d :

$(bin)$(binobj)MsgStream.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)MsgStream.o : $(src)Lib/MsgStream.cpp
	$(cpp_echo) $(src)Lib/MsgStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MsgStream_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MsgStream_cppflags) $(MsgStream_cpp_cppflags) -I../src/Lib $(src)Lib/MsgStream.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(MsgStream_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/MsgStream.cpp

$(bin)$(binobj)MsgStream.o : $(MsgStream_cpp_dependencies)
	$(cpp_echo) $(src)Lib/MsgStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MsgStream_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MsgStream_cppflags) $(MsgStream_cpp_cppflags) -I../src/Lib $(src)Lib/MsgStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardMisc1.d

$(bin)$(binobj)ParsersStandardMisc1.d :

$(bin)$(binobj)ParsersStandardMisc1.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardMisc1.o : $(src)Lib/ParsersStandardMisc1.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardMisc1.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc1_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc1_cppflags) $(ParsersStandardMisc1_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc1.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardMisc1_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardMisc1.cpp

$(bin)$(binobj)ParsersStandardMisc1.o : $(ParsersStandardMisc1_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardMisc1.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc1_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc1_cppflags) $(ParsersStandardMisc1_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc1.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IExceptionSvc.d

$(bin)$(binobj)IExceptionSvc.d :

$(bin)$(binobj)IExceptionSvc.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)IExceptionSvc.o : $(src)Lib/IExceptionSvc.cpp
	$(cpp_echo) $(src)Lib/IExceptionSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IExceptionSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IExceptionSvc_cppflags) $(IExceptionSvc_cpp_cppflags) -I../src/Lib $(src)Lib/IExceptionSvc.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(IExceptionSvc_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/IExceptionSvc.cpp

$(bin)$(binobj)IExceptionSvc.o : $(IExceptionSvc_cpp_dependencies)
	$(cpp_echo) $(src)Lib/IExceptionSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IExceptionSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IExceptionSvc_cppflags) $(IExceptionSvc_cpp_cppflags) -I../src/Lib $(src)Lib/IExceptionSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WatchdogThread.d

$(bin)$(binobj)WatchdogThread.d :

$(bin)$(binobj)WatchdogThread.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)WatchdogThread.o : $(src)Lib/WatchdogThread.cpp
	$(cpp_echo) $(src)Lib/WatchdogThread.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(WatchdogThread_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(WatchdogThread_cppflags) $(WatchdogThread_cpp_cppflags) -I../src/Lib $(src)Lib/WatchdogThread.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(WatchdogThread_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/WatchdogThread.cpp

$(bin)$(binobj)WatchdogThread.o : $(WatchdogThread_cpp_dependencies)
	$(cpp_echo) $(src)Lib/WatchdogThread.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(WatchdogThread_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(WatchdogThread_cppflags) $(WatchdogThread_cpp_cppflags) -I../src/Lib $(src)Lib/WatchdogThread.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiKernel.d

$(bin)$(binobj)GaudiKernel.d :

$(bin)$(binobj)GaudiKernel.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)GaudiKernel.o : $(src)Lib/GaudiKernel.cpp
	$(cpp_echo) $(src)Lib/GaudiKernel.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiKernel_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiKernel_cppflags) $(GaudiKernel_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiKernel.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(GaudiKernel_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/GaudiKernel.cpp

$(bin)$(binobj)GaudiKernel.o : $(GaudiKernel_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GaudiKernel.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiKernel_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiKernel_cppflags) $(GaudiKernel_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiKernel.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardMisc5.d

$(bin)$(binobj)ParsersStandardMisc5.d :

$(bin)$(binobj)ParsersStandardMisc5.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardMisc5.o : $(src)Lib/ParsersStandardMisc5.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardMisc5.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc5_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc5_cppflags) $(ParsersStandardMisc5_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc5.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardMisc5_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardMisc5.cpp

$(bin)$(binobj)ParsersStandardMisc5.o : $(ParsersStandardMisc5_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardMisc5.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc5_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc5_cppflags) $(ParsersStandardMisc5_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc5.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IChronoStatSvc.d

$(bin)$(binobj)IChronoStatSvc.d :

$(bin)$(binobj)IChronoStatSvc.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)IChronoStatSvc.o : $(src)Lib/IChronoStatSvc.cpp
	$(cpp_echo) $(src)Lib/IChronoStatSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IChronoStatSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IChronoStatSvc_cppflags) $(IChronoStatSvc_cpp_cppflags) -I../src/Lib $(src)Lib/IChronoStatSvc.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(IChronoStatSvc_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/IChronoStatSvc.cpp

$(bin)$(binobj)IChronoStatSvc.o : $(IChronoStatSvc_cpp_dependencies)
	$(cpp_echo) $(src)Lib/IChronoStatSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IChronoStatSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IChronoStatSvc_cppflags) $(IChronoStatSvc_cpp_cppflags) -I../src/Lib $(src)Lib/IChronoStatSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataHistory.d

$(bin)$(binobj)DataHistory.d :

$(bin)$(binobj)DataHistory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DataHistory.o : $(src)Lib/DataHistory.cpp
	$(cpp_echo) $(src)Lib/DataHistory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataHistory_cppflags) $(DataHistory_cpp_cppflags) -I../src/Lib $(src)Lib/DataHistory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DataHistory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DataHistory.cpp

$(bin)$(binobj)DataHistory.o : $(DataHistory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DataHistory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataHistory_cppflags) $(DataHistory_cpp_cppflags) -I../src/Lib $(src)Lib/DataHistory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Environment.d

$(bin)$(binobj)Environment.d :

$(bin)$(binobj)Environment.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Environment.o : $(src)Lib/Environment.cpp
	$(cpp_echo) $(src)Lib/Environment.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Environment_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Environment_cppflags) $(Environment_cpp_cppflags) -I../src/Lib $(src)Lib/Environment.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Environment_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Environment.cpp

$(bin)$(binobj)Environment.o : $(Environment_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Environment.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Environment_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Environment_cppflags) $(Environment_cpp_cppflags) -I../src/Lib $(src)Lib/Environment.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartRefBase.d

$(bin)$(binobj)SmartRefBase.d :

$(bin)$(binobj)SmartRefBase.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)SmartRefBase.o : $(src)Lib/SmartRefBase.cpp
	$(cpp_echo) $(src)Lib/SmartRefBase.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(SmartRefBase_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(SmartRefBase_cppflags) $(SmartRefBase_cpp_cppflags) -I../src/Lib $(src)Lib/SmartRefBase.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(SmartRefBase_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/SmartRefBase.cpp

$(bin)$(binobj)SmartRefBase.o : $(SmartRefBase_cpp_dependencies)
	$(cpp_echo) $(src)Lib/SmartRefBase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(SmartRefBase_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(SmartRefBase_cppflags) $(SmartRefBase_cpp_cppflags) -I../src/Lib $(src)Lib/SmartRefBase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Dictionary.d

$(bin)$(binobj)Dictionary.d :

$(bin)$(binobj)Dictionary.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Dictionary.o : $(src)Lib/Dictionary.cpp
	$(cpp_echo) $(src)Lib/Dictionary.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Dictionary_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Dictionary_cppflags) $(Dictionary_cpp_cppflags) -I../src/Lib $(src)Lib/Dictionary.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Dictionary_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Dictionary.cpp

$(bin)$(binobj)Dictionary.o : $(Dictionary_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Dictionary.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Dictionary_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Dictionary_cppflags) $(Dictionary_cpp_cppflags) -I../src/Lib $(src)Lib/Dictionary.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardList4.d

$(bin)$(binobj)ParsersStandardList4.d :

$(bin)$(binobj)ParsersStandardList4.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardList4.o : $(src)Lib/ParsersStandardList4.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardList4.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList4_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList4_cppflags) $(ParsersStandardList4_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList4.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardList4_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardList4.cpp

$(bin)$(binobj)ParsersStandardList4.o : $(ParsersStandardList4_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardList4.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList4_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList4_cppflags) $(ParsersStandardList4_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList4.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardSingle.d

$(bin)$(binobj)ParsersStandardSingle.d :

$(bin)$(binobj)ParsersStandardSingle.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardSingle.o : $(src)Lib/ParsersStandardSingle.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardSingle.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardSingle_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardSingle_cppflags) $(ParsersStandardSingle_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardSingle.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardSingle_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardSingle.cpp

$(bin)$(binobj)ParsersStandardSingle.o : $(ParsersStandardSingle_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardSingle.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardSingle_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardSingle_cppflags) $(ParsersStandardSingle_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardSingle.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Auditor.d

$(bin)$(binobj)Auditor.d :

$(bin)$(binobj)Auditor.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Auditor.o : $(src)Lib/Auditor.cpp
	$(cpp_echo) $(src)Lib/Auditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Auditor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Auditor_cppflags) $(Auditor_cpp_cppflags) -I../src/Lib $(src)Lib/Auditor.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Auditor_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Auditor.cpp

$(bin)$(binobj)Auditor.o : $(Auditor_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Auditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Auditor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Auditor_cppflags) $(Auditor_cpp_cppflags) -I../src/Lib $(src)Lib/Auditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ChronoEntity.d

$(bin)$(binobj)ChronoEntity.d :

$(bin)$(binobj)ChronoEntity.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ChronoEntity.o : $(src)Lib/ChronoEntity.cpp
	$(cpp_echo) $(src)Lib/ChronoEntity.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ChronoEntity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ChronoEntity_cppflags) $(ChronoEntity_cpp_cppflags) -I../src/Lib $(src)Lib/ChronoEntity.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ChronoEntity_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ChronoEntity.cpp

$(bin)$(binobj)ChronoEntity.o : $(ChronoEntity_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ChronoEntity.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ChronoEntity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ChronoEntity_cppflags) $(ChronoEntity_cpp_cppflags) -I../src/Lib $(src)Lib/ChronoEntity.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Sleep.d

$(bin)$(binobj)Sleep.d :

$(bin)$(binobj)Sleep.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Sleep.o : $(src)Lib/Sleep.cpp
	$(cpp_echo) $(src)Lib/Sleep.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Sleep_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Sleep_cppflags) $(Sleep_cpp_cppflags) -I../src/Lib $(src)Lib/Sleep.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Sleep_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Sleep.cpp

$(bin)$(binobj)Sleep.o : $(Sleep_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Sleep.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Sleep_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Sleep_cppflags) $(Sleep_cpp_cppflags) -I../src/Lib $(src)Lib/Sleep.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConversionSvc.d

$(bin)$(binobj)ConversionSvc.d :

$(bin)$(binobj)ConversionSvc.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ConversionSvc.o : $(src)Lib/ConversionSvc.cpp
	$(cpp_echo) $(src)Lib/ConversionSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ConversionSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ConversionSvc_cppflags) $(ConversionSvc_cpp_cppflags) -I../src/Lib $(src)Lib/ConversionSvc.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ConversionSvc_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ConversionSvc.cpp

$(bin)$(binobj)ConversionSvc.o : $(ConversionSvc_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ConversionSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ConversionSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ConversionSvc_cppflags) $(ConversionSvc_cpp_cppflags) -I../src/Lib $(src)Lib/ConversionSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Lomont.d

$(bin)$(binobj)Lomont.d :

$(bin)$(binobj)Lomont.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Lomont.o : $(src)Lib/Lomont.cpp
	$(cpp_echo) $(src)Lib/Lomont.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Lomont_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Lomont_cppflags) $(Lomont_cpp_cppflags) -I../src/Lib $(src)Lib/Lomont.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Lomont_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Lomont.cpp

$(bin)$(binobj)Lomont.o : $(Lomont_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Lomont.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Lomont_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Lomont_cppflags) $(Lomont_cpp_cppflags) -I../src/Lib $(src)Lib/Lomont.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Timing.d

$(bin)$(binobj)Timing.d :

$(bin)$(binobj)Timing.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Timing.o : $(src)Lib/Timing.cpp
	$(cpp_echo) $(src)Lib/Timing.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Timing_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Timing_cppflags) $(Timing_cpp_cppflags) -I../src/Lib $(src)Lib/Timing.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Timing_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Timing.cpp

$(bin)$(binobj)Timing.o : $(Timing_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Timing.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Timing_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Timing_cppflags) $(Timing_cpp_cppflags) -I../src/Lib $(src)Lib/Timing.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataStreamTool.d

$(bin)$(binobj)DataStreamTool.d :

$(bin)$(binobj)DataStreamTool.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DataStreamTool.o : $(src)Lib/DataStreamTool.cpp
	$(cpp_echo) $(src)Lib/DataStreamTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataStreamTool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataStreamTool_cppflags) $(DataStreamTool_cpp_cppflags) -I../src/Lib $(src)Lib/DataStreamTool.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DataStreamTool_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DataStreamTool.cpp

$(bin)$(binobj)DataStreamTool.o : $(DataStreamTool_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DataStreamTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataStreamTool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataStreamTool_cppflags) $(DataStreamTool_cpp_cppflags) -I../src/Lib $(src)Lib/DataStreamTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IssueSeverity.d

$(bin)$(binobj)IssueSeverity.d :

$(bin)$(binobj)IssueSeverity.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)IssueSeverity.o : $(src)Lib/IssueSeverity.cpp
	$(cpp_echo) $(src)Lib/IssueSeverity.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IssueSeverity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IssueSeverity_cppflags) $(IssueSeverity_cpp_cppflags) -I../src/Lib $(src)Lib/IssueSeverity.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(IssueSeverity_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/IssueSeverity.cpp

$(bin)$(binobj)IssueSeverity.o : $(IssueSeverity_cpp_dependencies)
	$(cpp_echo) $(src)Lib/IssueSeverity.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(IssueSeverity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(IssueSeverity_cppflags) $(IssueSeverity_cpp_cppflags) -I../src/Lib $(src)Lib/IssueSeverity.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RndmGenerators.d

$(bin)$(binobj)RndmGenerators.d :

$(bin)$(binobj)RndmGenerators.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)RndmGenerators.o : $(src)Lib/RndmGenerators.cpp
	$(cpp_echo) $(src)Lib/RndmGenerators.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RndmGenerators_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RndmGenerators_cppflags) $(RndmGenerators_cpp_cppflags) -I../src/Lib $(src)Lib/RndmGenerators.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(RndmGenerators_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/RndmGenerators.cpp

$(bin)$(binobj)RndmGenerators.o : $(RndmGenerators_cpp_dependencies)
	$(cpp_echo) $(src)Lib/RndmGenerators.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RndmGenerators_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RndmGenerators_cppflags) $(RndmGenerators_cpp_cppflags) -I../src/Lib $(src)Lib/RndmGenerators.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AllocatorPool.d

$(bin)$(binobj)AllocatorPool.d :

$(bin)$(binobj)AllocatorPool.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)AllocatorPool.o : $(src)Lib/AllocatorPool.cpp
	$(cpp_echo) $(src)Lib/AllocatorPool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AllocatorPool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AllocatorPool_cppflags) $(AllocatorPool_cpp_cppflags) -I../src/Lib $(src)Lib/AllocatorPool.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(AllocatorPool_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/AllocatorPool.cpp

$(bin)$(binobj)AllocatorPool.o : $(AllocatorPool_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AllocatorPool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AllocatorPool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AllocatorPool_cppflags) $(AllocatorPool_cpp_cppflags) -I../src/Lib $(src)Lib/AllocatorPool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ICounterSvc.d

$(bin)$(binobj)ICounterSvc.d :

$(bin)$(binobj)ICounterSvc.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ICounterSvc.o : $(src)Lib/ICounterSvc.cpp
	$(cpp_echo) $(src)Lib/ICounterSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ICounterSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ICounterSvc_cppflags) $(ICounterSvc_cpp_cppflags) -I../src/Lib $(src)Lib/ICounterSvc.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ICounterSvc_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ICounterSvc.cpp

$(bin)$(binobj)ICounterSvc.o : $(ICounterSvc_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ICounterSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ICounterSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ICounterSvc_cppflags) $(ICounterSvc_cpp_cppflags) -I../src/Lib $(src)Lib/ICounterSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MinimalEventLoopMgr.d

$(bin)$(binobj)MinimalEventLoopMgr.d :

$(bin)$(binobj)MinimalEventLoopMgr.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)MinimalEventLoopMgr.o : $(src)Lib/MinimalEventLoopMgr.cpp
	$(cpp_echo) $(src)Lib/MinimalEventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MinimalEventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MinimalEventLoopMgr_cppflags) $(MinimalEventLoopMgr_cpp_cppflags) -I../src/Lib $(src)Lib/MinimalEventLoopMgr.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(MinimalEventLoopMgr_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/MinimalEventLoopMgr.cpp

$(bin)$(binobj)MinimalEventLoopMgr.o : $(MinimalEventLoopMgr_cpp_dependencies)
	$(cpp_echo) $(src)Lib/MinimalEventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MinimalEventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MinimalEventLoopMgr_cppflags) $(MinimalEventLoopMgr_cpp_cppflags) -I../src/Lib $(src)Lib/MinimalEventLoopMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgTool.d

$(bin)$(binobj)AlgTool.d :

$(bin)$(binobj)AlgTool.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)AlgTool.o : $(src)Lib/AlgTool.cpp
	$(cpp_echo) $(src)Lib/AlgTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgTool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgTool_cppflags) $(AlgTool_cpp_cppflags) -I../src/Lib $(src)Lib/AlgTool.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(AlgTool_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/AlgTool.cpp

$(bin)$(binobj)AlgTool.o : $(AlgTool_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AlgTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgTool_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgTool_cppflags) $(AlgTool_cpp_cppflags) -I../src/Lib $(src)Lib/AlgTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Debugger.d

$(bin)$(binobj)Debugger.d :

$(bin)$(binobj)Debugger.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Debugger.o : $(src)Lib/Debugger.cpp
	$(cpp_echo) $(src)Lib/Debugger.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Debugger_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Debugger_cppflags) $(Debugger_cpp_cppflags) -I../src/Lib $(src)Lib/Debugger.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Debugger_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Debugger.cpp

$(bin)$(binobj)Debugger.o : $(Debugger_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Debugger.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Debugger_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Debugger_cppflags) $(Debugger_cpp_cppflags) -I../src/Lib $(src)Lib/Debugger.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JobHistory.d

$(bin)$(binobj)JobHistory.d :

$(bin)$(binobj)JobHistory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)JobHistory.o : $(src)Lib/JobHistory.cpp
	$(cpp_echo) $(src)Lib/JobHistory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(JobHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(JobHistory_cppflags) $(JobHistory_cpp_cppflags) -I../src/Lib $(src)Lib/JobHistory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(JobHistory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/JobHistory.cpp

$(bin)$(binobj)JobHistory.o : $(JobHistory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/JobHistory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(JobHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(JobHistory_cppflags) $(JobHistory_cpp_cppflags) -I../src/Lib $(src)Lib/JobHistory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RndmTypeInfos.d

$(bin)$(binobj)RndmTypeInfos.d :

$(bin)$(binobj)RndmTypeInfos.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)RndmTypeInfos.o : $(src)Lib/RndmTypeInfos.cpp
	$(cpp_echo) $(src)Lib/RndmTypeInfos.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RndmTypeInfos_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RndmTypeInfos_cppflags) $(RndmTypeInfos_cpp_cppflags) -I../src/Lib $(src)Lib/RndmTypeInfos.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(RndmTypeInfos_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/RndmTypeInfos.cpp

$(bin)$(binobj)RndmTypeInfos.o : $(RndmTypeInfos_cpp_dependencies)
	$(cpp_echo) $(src)Lib/RndmTypeInfos.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RndmTypeInfos_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RndmTypeInfos_cppflags) $(RndmTypeInfos_cpp_cppflags) -I../src/Lib $(src)Lib/RndmTypeInfos.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataSvc.d

$(bin)$(binobj)DataSvc.d :

$(bin)$(binobj)DataSvc.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DataSvc.o : $(src)Lib/DataSvc.cpp
	$(cpp_echo) $(src)Lib/DataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataSvc_cppflags) $(DataSvc_cpp_cppflags) -I../src/Lib $(src)Lib/DataSvc.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DataSvc_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DataSvc.cpp

$(bin)$(binobj)DataSvc.o : $(DataSvc_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataSvc_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataSvc_cppflags) $(DataSvc_cpp_cppflags) -I../src/Lib $(src)Lib/DataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataTypeInfo.d

$(bin)$(binobj)DataTypeInfo.d :

$(bin)$(binobj)DataTypeInfo.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DataTypeInfo.o : $(src)Lib/DataTypeInfo.cpp
	$(cpp_echo) $(src)Lib/DataTypeInfo.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataTypeInfo_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataTypeInfo_cppflags) $(DataTypeInfo_cpp_cppflags) -I../src/Lib $(src)Lib/DataTypeInfo.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DataTypeInfo_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DataTypeInfo.cpp

$(bin)$(binobj)DataTypeInfo.o : $(DataTypeInfo_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DataTypeInfo.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DataTypeInfo_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DataTypeInfo_cppflags) $(DataTypeInfo_cpp_cppflags) -I../src/Lib $(src)Lib/DataTypeInfo.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ThreadGaudi.d

$(bin)$(binobj)ThreadGaudi.d :

$(bin)$(binobj)ThreadGaudi.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ThreadGaudi.o : $(src)Lib/ThreadGaudi.cpp
	$(cpp_echo) $(src)Lib/ThreadGaudi.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ThreadGaudi_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ThreadGaudi_cppflags) $(ThreadGaudi_cpp_cppflags) -I../src/Lib $(src)Lib/ThreadGaudi.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ThreadGaudi_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ThreadGaudi.cpp

$(bin)$(binobj)ThreadGaudi.o : $(ThreadGaudi_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ThreadGaudi.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ThreadGaudi_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ThreadGaudi_cppflags) $(ThreadGaudi_cpp_cppflags) -I../src/Lib $(src)Lib/ThreadGaudi.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardMisc3.d

$(bin)$(binobj)ParsersStandardMisc3.d :

$(bin)$(binobj)ParsersStandardMisc3.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardMisc3.o : $(src)Lib/ParsersStandardMisc3.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardMisc3.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc3_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc3_cppflags) $(ParsersStandardMisc3_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc3.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardMisc3_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardMisc3.cpp

$(bin)$(binobj)ParsersStandardMisc3.o : $(ParsersStandardMisc3_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardMisc3.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc3_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc3_cppflags) $(ParsersStandardMisc3_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc3.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardMisc4.d

$(bin)$(binobj)ParsersStandardMisc4.d :

$(bin)$(binobj)ParsersStandardMisc4.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardMisc4.o : $(src)Lib/ParsersStandardMisc4.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardMisc4.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc4_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc4_cppflags) $(ParsersStandardMisc4_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc4.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardMisc4_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardMisc4.cpp

$(bin)$(binobj)ParsersStandardMisc4.o : $(ParsersStandardMisc4_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardMisc4.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc4_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc4_cppflags) $(ParsersStandardMisc4_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc4.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MapBase.d

$(bin)$(binobj)MapBase.d :

$(bin)$(binobj)MapBase.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)MapBase.o : $(src)Lib/MapBase.cpp
	$(cpp_echo) $(src)Lib/MapBase.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MapBase_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MapBase_cppflags) $(MapBase_cpp_cppflags) -I../src/Lib $(src)Lib/MapBase.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(MapBase_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/MapBase.cpp

$(bin)$(binobj)MapBase.o : $(MapBase_cpp_dependencies)
	$(cpp_echo) $(src)Lib/MapBase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(MapBase_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(MapBase_cppflags) $(MapBase_cpp_cppflags) -I../src/Lib $(src)Lib/MapBase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiMain.d

$(bin)$(binobj)GaudiMain.d :

$(bin)$(binobj)GaudiMain.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)GaudiMain.o : $(src)Lib/GaudiMain.cpp
	$(cpp_echo) $(src)Lib/GaudiMain.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiMain_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiMain_cppflags) $(GaudiMain_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiMain.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(GaudiMain_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/GaudiMain.cpp

$(bin)$(binobj)GaudiMain.o : $(GaudiMain_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GaudiMain.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiMain_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiMain_cppflags) $(GaudiMain_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiMain.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHandle.d

$(bin)$(binobj)GaudiHandle.d :

$(bin)$(binobj)GaudiHandle.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)GaudiHandle.o : $(src)Lib/GaudiHandle.cpp
	$(cpp_echo) $(src)Lib/GaudiHandle.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiHandle_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiHandle_cppflags) $(GaudiHandle_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiHandle.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(GaudiHandle_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/GaudiHandle.cpp

$(bin)$(binobj)GaudiHandle.o : $(GaudiHandle_cpp_dependencies)
	$(cpp_echo) $(src)Lib/GaudiHandle.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(GaudiHandle_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(GaudiHandle_cppflags) $(GaudiHandle_cpp_cppflags) -I../src/Lib $(src)Lib/GaudiHandle.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)KeyedObject.d

$(bin)$(binobj)KeyedObject.d :

$(bin)$(binobj)KeyedObject.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)KeyedObject.o : $(src)Lib/KeyedObject.cpp
	$(cpp_echo) $(src)Lib/KeyedObject.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(KeyedObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(KeyedObject_cppflags) $(KeyedObject_cpp_cppflags) -I../src/Lib $(src)Lib/KeyedObject.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(KeyedObject_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/KeyedObject.cpp

$(bin)$(binobj)KeyedObject.o : $(KeyedObject_cpp_dependencies)
	$(cpp_echo) $(src)Lib/KeyedObject.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(KeyedObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(KeyedObject_cppflags) $(KeyedObject_cpp_cppflags) -I../src/Lib $(src)Lib/KeyedObject.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Bootstrap.d

$(bin)$(binobj)Bootstrap.d :

$(bin)$(binobj)Bootstrap.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Bootstrap.o : $(src)Lib/Bootstrap.cpp
	$(cpp_echo) $(src)Lib/Bootstrap.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Bootstrap_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Bootstrap_cppflags) $(Bootstrap_cpp_cppflags) -I../src/Lib $(src)Lib/Bootstrap.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Bootstrap_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Bootstrap.cpp

$(bin)$(binobj)Bootstrap.o : $(Bootstrap_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Bootstrap.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Bootstrap_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Bootstrap_cppflags) $(Bootstrap_cpp_cppflags) -I../src/Lib $(src)Lib/Bootstrap.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersVct.d

$(bin)$(binobj)ParsersVct.d :

$(bin)$(binobj)ParsersVct.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersVct.o : $(src)Lib/ParsersVct.cpp
	$(cpp_echo) $(src)Lib/ParsersVct.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersVct_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersVct_cppflags) $(ParsersVct_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersVct.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersVct_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersVct.cpp

$(bin)$(binobj)ParsersVct.o : $(ParsersVct_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersVct.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersVct_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersVct_cppflags) $(ParsersVct_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersVct.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardMisc2.d

$(bin)$(binobj)ParsersStandardMisc2.d :

$(bin)$(binobj)ParsersStandardMisc2.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardMisc2.o : $(src)Lib/ParsersStandardMisc2.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardMisc2.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc2_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc2_cppflags) $(ParsersStandardMisc2_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc2.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardMisc2_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardMisc2.cpp

$(bin)$(binobj)ParsersStandardMisc2.o : $(ParsersStandardMisc2_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardMisc2.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardMisc2_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardMisc2_cppflags) $(ParsersStandardMisc2_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardMisc2.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Guards.d

$(bin)$(binobj)Guards.d :

$(bin)$(binobj)Guards.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Guards.o : $(src)Lib/Guards.cpp
	$(cpp_echo) $(src)Lib/Guards.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Guards_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Guards_cppflags) $(Guards_cpp_cppflags) -I../src/Lib $(src)Lib/Guards.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Guards_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Guards.cpp

$(bin)$(binobj)Guards.o : $(Guards_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Guards.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Guards_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Guards_cppflags) $(Guards_cpp_cppflags) -I../src/Lib $(src)Lib/Guards.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyMgr.d

$(bin)$(binobj)PropertyMgr.d :

$(bin)$(binobj)PropertyMgr.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)PropertyMgr.o : $(src)Lib/PropertyMgr.cpp
	$(cpp_echo) $(src)Lib/PropertyMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PropertyMgr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PropertyMgr_cppflags) $(PropertyMgr_cpp_cppflags) -I../src/Lib $(src)Lib/PropertyMgr.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(PropertyMgr_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/PropertyMgr.cpp

$(bin)$(binobj)PropertyMgr.o : $(PropertyMgr_cpp_dependencies)
	$(cpp_echo) $(src)Lib/PropertyMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PropertyMgr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PropertyMgr_cppflags) $(PropertyMgr_cpp_cppflags) -I../src/Lib $(src)Lib/PropertyMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)System.d

$(bin)$(binobj)System.d :

$(bin)$(binobj)System.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)System.o : $(src)Lib/System.cpp
	$(cpp_echo) $(src)Lib/System.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(System_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(System_cppflags) $(System_cpp_cppflags) -I../src/Lib $(src)Lib/System.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(System_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/System.cpp

$(bin)$(binobj)System.o : $(System_cpp_dependencies)
	$(cpp_echo) $(src)Lib/System.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(System_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(System_cppflags) $(System_cpp_cppflags) -I../src/Lib $(src)Lib/System.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyCallbackFunctor.d

$(bin)$(binobj)PropertyCallbackFunctor.d :

$(bin)$(binobj)PropertyCallbackFunctor.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)PropertyCallbackFunctor.o : $(src)Lib/PropertyCallbackFunctor.cpp
	$(cpp_echo) $(src)Lib/PropertyCallbackFunctor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PropertyCallbackFunctor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PropertyCallbackFunctor_cppflags) $(PropertyCallbackFunctor_cpp_cppflags) -I../src/Lib $(src)Lib/PropertyCallbackFunctor.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(PropertyCallbackFunctor_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/PropertyCallbackFunctor.cpp

$(bin)$(binobj)PropertyCallbackFunctor.o : $(PropertyCallbackFunctor_cpp_dependencies)
	$(cpp_echo) $(src)Lib/PropertyCallbackFunctor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PropertyCallbackFunctor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PropertyCallbackFunctor_cppflags) $(PropertyCallbackFunctor_cpp_cppflags) -I../src/Lib $(src)Lib/PropertyCallbackFunctor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PathResolver.d

$(bin)$(binobj)PathResolver.d :

$(bin)$(binobj)PathResolver.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)PathResolver.o : $(src)Lib/PathResolver.cpp
	$(cpp_echo) $(src)Lib/PathResolver.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PathResolver_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PathResolver_cppflags) $(PathResolver_cpp_cppflags) -I../src/Lib $(src)Lib/PathResolver.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(PathResolver_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/PathResolver.cpp

$(bin)$(binobj)PathResolver.o : $(PathResolver_cpp_dependencies)
	$(cpp_echo) $(src)Lib/PathResolver.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(PathResolver_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(PathResolver_cppflags) $(PathResolver_cpp_cppflags) -I../src/Lib $(src)Lib/PathResolver.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SmartDataObjectPtr.d

$(bin)$(binobj)SmartDataObjectPtr.d :

$(bin)$(binobj)SmartDataObjectPtr.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)SmartDataObjectPtr.o : $(src)Lib/SmartDataObjectPtr.cpp
	$(cpp_echo) $(src)Lib/SmartDataObjectPtr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(SmartDataObjectPtr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(SmartDataObjectPtr_cppflags) $(SmartDataObjectPtr_cpp_cppflags) -I../src/Lib $(src)Lib/SmartDataObjectPtr.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(SmartDataObjectPtr_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/SmartDataObjectPtr.cpp

$(bin)$(binobj)SmartDataObjectPtr.o : $(SmartDataObjectPtr_cpp_dependencies)
	$(cpp_echo) $(src)Lib/SmartDataObjectPtr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(SmartDataObjectPtr_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(SmartDataObjectPtr_cppflags) $(SmartDataObjectPtr_cpp_cppflags) -I../src/Lib $(src)Lib/SmartDataObjectPtr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventSelectorDataStream.d

$(bin)$(binobj)EventSelectorDataStream.d :

$(bin)$(binobj)EventSelectorDataStream.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)EventSelectorDataStream.o : $(src)Lib/EventSelectorDataStream.cpp
	$(cpp_echo) $(src)Lib/EventSelectorDataStream.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(EventSelectorDataStream_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(EventSelectorDataStream_cppflags) $(EventSelectorDataStream_cpp_cppflags) -I../src/Lib $(src)Lib/EventSelectorDataStream.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(EventSelectorDataStream_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/EventSelectorDataStream.cpp

$(bin)$(binobj)EventSelectorDataStream.o : $(EventSelectorDataStream_cpp_dependencies)
	$(cpp_echo) $(src)Lib/EventSelectorDataStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(EventSelectorDataStream_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(EventSelectorDataStream_cppflags) $(EventSelectorDataStream_cpp_cppflags) -I../src/Lib $(src)Lib/EventSelectorDataStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatEntity.d

$(bin)$(binobj)StatEntity.d :

$(bin)$(binobj)StatEntity.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)StatEntity.o : $(src)Lib/StatEntity.cpp
	$(cpp_echo) $(src)Lib/StatEntity.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StatEntity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StatEntity_cppflags) $(StatEntity_cpp_cppflags) -I../src/Lib $(src)Lib/StatEntity.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(StatEntity_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/StatEntity.cpp

$(bin)$(binobj)StatEntity.o : $(StatEntity_cpp_dependencies)
	$(cpp_echo) $(src)Lib/StatEntity.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StatEntity_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StatEntity_cppflags) $(StatEntity_cpp_cppflags) -I../src/Lib $(src)Lib/StatEntity.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RegistryEntry.d

$(bin)$(binobj)RegistryEntry.d :

$(bin)$(binobj)RegistryEntry.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)RegistryEntry.o : $(src)Lib/RegistryEntry.cpp
	$(cpp_echo) $(src)Lib/RegistryEntry.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RegistryEntry_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RegistryEntry_cppflags) $(RegistryEntry_cpp_cppflags) -I../src/Lib $(src)Lib/RegistryEntry.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(RegistryEntry_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/RegistryEntry.cpp

$(bin)$(binobj)RegistryEntry.o : $(RegistryEntry_cpp_dependencies)
	$(cpp_echo) $(src)Lib/RegistryEntry.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(RegistryEntry_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(RegistryEntry_cppflags) $(RegistryEntry_cpp_cppflags) -I../src/Lib $(src)Lib/RegistryEntry.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Memory.d

$(bin)$(binobj)Memory.d :

$(bin)$(binobj)Memory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Memory.o : $(src)Lib/Memory.cpp
	$(cpp_echo) $(src)Lib/Memory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Memory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Memory_cppflags) $(Memory_cpp_cppflags) -I../src/Lib $(src)Lib/Memory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Memory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Memory.cpp

$(bin)$(binobj)Memory.o : $(Memory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Memory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Memory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Memory_cppflags) $(Memory_cpp_cppflags) -I../src/Lib $(src)Lib/Memory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ComponentManager.d

$(bin)$(binobj)ComponentManager.d :

$(bin)$(binobj)ComponentManager.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ComponentManager.o : $(src)Lib/ComponentManager.cpp
	$(cpp_echo) $(src)Lib/ComponentManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ComponentManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ComponentManager_cppflags) $(ComponentManager_cpp_cppflags) -I../src/Lib $(src)Lib/ComponentManager.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ComponentManager_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ComponentManager.cpp

$(bin)$(binobj)ComponentManager.o : $(ComponentManager_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ComponentManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ComponentManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ComponentManager_cppflags) $(ComponentManager_cpp_cppflags) -I../src/Lib $(src)Lib/ComponentManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceLocatorHelper.d

$(bin)$(binobj)ServiceLocatorHelper.d :

$(bin)$(binobj)ServiceLocatorHelper.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ServiceLocatorHelper.o : $(src)Lib/ServiceLocatorHelper.cpp
	$(cpp_echo) $(src)Lib/ServiceLocatorHelper.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ServiceLocatorHelper_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ServiceLocatorHelper_cppflags) $(ServiceLocatorHelper_cpp_cppflags) -I../src/Lib $(src)Lib/ServiceLocatorHelper.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ServiceLocatorHelper_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ServiceLocatorHelper.cpp

$(bin)$(binobj)ServiceLocatorHelper.o : $(ServiceLocatorHelper_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ServiceLocatorHelper.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ServiceLocatorHelper_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ServiceLocatorHelper_cppflags) $(ServiceLocatorHelper_cpp_cppflags) -I../src/Lib $(src)Lib/ServiceLocatorHelper.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StateMachine.d

$(bin)$(binobj)StateMachine.d :

$(bin)$(binobj)StateMachine.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)StateMachine.o : $(src)Lib/StateMachine.cpp
	$(cpp_echo) $(src)Lib/StateMachine.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StateMachine_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StateMachine_cppflags) $(StateMachine_cpp_cppflags) -I../src/Lib $(src)Lib/StateMachine.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(StateMachine_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/StateMachine.cpp

$(bin)$(binobj)StateMachine.o : $(StateMachine_cpp_dependencies)
	$(cpp_echo) $(src)Lib/StateMachine.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StateMachine_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StateMachine_cppflags) $(StateMachine_cpp_cppflags) -I../src/Lib $(src)Lib/StateMachine.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardList1.d

$(bin)$(binobj)ParsersStandardList1.d :

$(bin)$(binobj)ParsersStandardList1.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardList1.o : $(src)Lib/ParsersStandardList1.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardList1.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList1_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList1_cppflags) $(ParsersStandardList1_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList1.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardList1_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardList1.cpp

$(bin)$(binobj)ParsersStandardList1.o : $(ParsersStandardList1_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardList1.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList1_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList1_cppflags) $(ParsersStandardList1_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList1.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ProcessDescriptor.d

$(bin)$(binobj)ProcessDescriptor.d :

$(bin)$(binobj)ProcessDescriptor.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ProcessDescriptor.o : $(src)Lib/ProcessDescriptor.cpp
	$(cpp_echo) $(src)Lib/ProcessDescriptor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ProcessDescriptor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ProcessDescriptor_cppflags) $(ProcessDescriptor_cpp_cppflags) -I../src/Lib $(src)Lib/ProcessDescriptor.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ProcessDescriptor_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ProcessDescriptor.cpp

$(bin)$(binobj)ProcessDescriptor.o : $(ProcessDescriptor_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ProcessDescriptor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ProcessDescriptor_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ProcessDescriptor_cppflags) $(ProcessDescriptor_cpp_cppflags) -I../src/Lib $(src)Lib/ProcessDescriptor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DirSearchPath.d

$(bin)$(binobj)DirSearchPath.d :

$(bin)$(binobj)DirSearchPath.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)DirSearchPath.o : $(src)Lib/DirSearchPath.cpp
	$(cpp_echo) $(src)Lib/DirSearchPath.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DirSearchPath_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DirSearchPath_cppflags) $(DirSearchPath_cpp_cppflags) -I../src/Lib $(src)Lib/DirSearchPath.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(DirSearchPath_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/DirSearchPath.cpp

$(bin)$(binobj)DirSearchPath.o : $(DirSearchPath_cpp_dependencies)
	$(cpp_echo) $(src)Lib/DirSearchPath.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(DirSearchPath_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(DirSearchPath_cppflags) $(DirSearchPath_cpp_cppflags) -I../src/Lib $(src)Lib/DirSearchPath.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)KeyedObjectManager.d

$(bin)$(binobj)KeyedObjectManager.d :

$(bin)$(binobj)KeyedObjectManager.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)KeyedObjectManager.o : $(src)Lib/KeyedObjectManager.cpp
	$(cpp_echo) $(src)Lib/KeyedObjectManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(KeyedObjectManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(KeyedObjectManager_cppflags) $(KeyedObjectManager_cpp_cppflags) -I../src/Lib $(src)Lib/KeyedObjectManager.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(KeyedObjectManager_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/KeyedObjectManager.cpp

$(bin)$(binobj)KeyedObjectManager.o : $(KeyedObjectManager_cpp_dependencies)
	$(cpp_echo) $(src)Lib/KeyedObjectManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(KeyedObjectManager_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(KeyedObjectManager_cppflags) $(KeyedObjectManager_cpp_cppflags) -I../src/Lib $(src)Lib/KeyedObjectManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardList2.d

$(bin)$(binobj)ParsersStandardList2.d :

$(bin)$(binobj)ParsersStandardList2.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardList2.o : $(src)Lib/ParsersStandardList2.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardList2.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList2_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList2_cppflags) $(ParsersStandardList2_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList2.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardList2_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardList2.cpp

$(bin)$(binobj)ParsersStandardList2.o : $(ParsersStandardList2_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardList2.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList2_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList2_cppflags) $(ParsersStandardList2_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList2.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatusCode.d

$(bin)$(binobj)StatusCode.d :

$(bin)$(binobj)StatusCode.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)StatusCode.o : $(src)Lib/StatusCode.cpp
	$(cpp_echo) $(src)Lib/StatusCode.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StatusCode_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StatusCode_cppflags) $(StatusCode_cpp_cppflags) -I../src/Lib $(src)Lib/StatusCode.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(StatusCode_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/StatusCode.cpp

$(bin)$(binobj)StatusCode.o : $(StatusCode_cpp_dependencies)
	$(cpp_echo) $(src)Lib/StatusCode.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(StatusCode_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(StatusCode_cppflags) $(StatusCode_cpp_cppflags) -I../src/Lib $(src)Lib/StatusCode.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NTupleItems.d

$(bin)$(binobj)NTupleItems.d :

$(bin)$(binobj)NTupleItems.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)NTupleItems.o : $(src)Lib/NTupleItems.cpp
	$(cpp_echo) $(src)Lib/NTupleItems.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(NTupleItems_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(NTupleItems_cppflags) $(NTupleItems_cpp_cppflags) -I../src/Lib $(src)Lib/NTupleItems.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(NTupleItems_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/NTupleItems.cpp

$(bin)$(binobj)NTupleItems.o : $(NTupleItems_cpp_dependencies)
	$(cpp_echo) $(src)Lib/NTupleItems.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(NTupleItems_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(NTupleItems_cppflags) $(NTupleItems_cpp_cppflags) -I../src/Lib $(src)Lib/NTupleItems.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Selector.d

$(bin)$(binobj)Selector.d :

$(bin)$(binobj)Selector.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Selector.o : $(src)Lib/Selector.cpp
	$(cpp_echo) $(src)Lib/Selector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Selector_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Selector_cppflags) $(Selector_cpp_cppflags) -I../src/Lib $(src)Lib/Selector.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Selector_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Selector.cpp

$(bin)$(binobj)Selector.o : $(Selector_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Selector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Selector_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Selector_cppflags) $(Selector_cpp_cppflags) -I../src/Lib $(src)Lib/Selector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)xtoa.d

$(bin)$(binobj)xtoa.d :

$(bin)$(binobj)xtoa.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)xtoa.o : $(src)Lib/xtoa.cpp
	$(cpp_echo) $(src)Lib/xtoa.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(xtoa_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(xtoa_cppflags) $(xtoa_cpp_cppflags) -I../src/Lib $(src)Lib/xtoa.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(xtoa_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/xtoa.cpp

$(bin)$(binobj)xtoa.o : $(xtoa_cpp_dependencies)
	$(cpp_echo) $(src)Lib/xtoa.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(xtoa_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(xtoa_cppflags) $(xtoa_cpp_cppflags) -I../src/Lib $(src)Lib/xtoa.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoDef.d

$(bin)$(binobj)HistoDef.d :

$(bin)$(binobj)HistoDef.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)HistoDef.o : $(src)Lib/HistoDef.cpp
	$(cpp_echo) $(src)Lib/HistoDef.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(HistoDef_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(HistoDef_cppflags) $(HistoDef_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDef.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(HistoDef_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/HistoDef.cpp

$(bin)$(binobj)HistoDef.o : $(HistoDef_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoDef.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(HistoDef_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(HistoDef_cppflags) $(HistoDef_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDef.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoryObj.d

$(bin)$(binobj)HistoryObj.d :

$(bin)$(binobj)HistoryObj.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)HistoryObj.o : $(src)Lib/HistoryObj.cpp
	$(cpp_echo) $(src)Lib/HistoryObj.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(HistoryObj_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(HistoryObj_cppflags) $(HistoryObj_cpp_cppflags) -I../src/Lib $(src)Lib/HistoryObj.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(HistoryObj_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/HistoryObj.cpp

$(bin)$(binobj)HistoryObj.o : $(HistoryObj_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoryObj.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(HistoryObj_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(HistoryObj_cppflags) $(HistoryObj_cpp_cppflags) -I../src/Lib $(src)Lib/HistoryObj.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersHistograms.d

$(bin)$(binobj)ParsersHistograms.d :

$(bin)$(binobj)ParsersHistograms.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersHistograms.o : $(src)Lib/ParsersHistograms.cpp
	$(cpp_echo) $(src)Lib/ParsersHistograms.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersHistograms_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersHistograms_cppflags) $(ParsersHistograms_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersHistograms.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersHistograms_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersHistograms.cpp

$(bin)$(binobj)ParsersHistograms.o : $(ParsersHistograms_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersHistograms.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersHistograms_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersHistograms_cppflags) $(ParsersHistograms_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersHistograms.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Stat.d

$(bin)$(binobj)Stat.d :

$(bin)$(binobj)Stat.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Stat.o : $(src)Lib/Stat.cpp
	$(cpp_echo) $(src)Lib/Stat.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Stat_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Stat_cppflags) $(Stat_cpp_cppflags) -I../src/Lib $(src)Lib/Stat.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Stat_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Stat.cpp

$(bin)$(binobj)Stat.o : $(Stat_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Stat.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Stat_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Stat_cppflags) $(Stat_cpp_cppflags) -I../src/Lib $(src)Lib/Stat.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersCollections.d

$(bin)$(binobj)ParsersCollections.d :

$(bin)$(binobj)ParsersCollections.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersCollections.o : $(src)Lib/ParsersCollections.cpp
	$(cpp_echo) $(src)Lib/ParsersCollections.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersCollections_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersCollections_cppflags) $(ParsersCollections_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersCollections.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersCollections_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersCollections.cpp

$(bin)$(binobj)ParsersCollections.o : $(ParsersCollections_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersCollections.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersCollections_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersCollections_cppflags) $(ParsersCollections_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersCollections.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)VirtualDestructors.d

$(bin)$(binobj)VirtualDestructors.d :

$(bin)$(binobj)VirtualDestructors.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)VirtualDestructors.o : $(src)Lib/VirtualDestructors.cpp
	$(cpp_echo) $(src)Lib/VirtualDestructors.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(VirtualDestructors_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(VirtualDestructors_cppflags) $(VirtualDestructors_cpp_cppflags) -I../src/Lib $(src)Lib/VirtualDestructors.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(VirtualDestructors_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/VirtualDestructors.cpp

$(bin)$(binobj)VirtualDestructors.o : $(VirtualDestructors_cpp_dependencies)
	$(cpp_echo) $(src)Lib/VirtualDestructors.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(VirtualDestructors_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(VirtualDestructors_cppflags) $(VirtualDestructors_cpp_cppflags) -I../src/Lib $(src)Lib/VirtualDestructors.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Service.d

$(bin)$(binobj)Service.d :

$(bin)$(binobj)Service.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)Service.o : $(src)Lib/Service.cpp
	$(cpp_echo) $(src)Lib/Service.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Service_cppflags) $(Service_cpp_cppflags) -I../src/Lib $(src)Lib/Service.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(Service_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/Service.cpp

$(bin)$(binobj)Service.o : $(Service_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Service.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(Service_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(Service_cppflags) $(Service_cpp_cppflags) -I../src/Lib $(src)Lib/Service.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgToolHistory.d

$(bin)$(binobj)AlgToolHistory.d :

$(bin)$(binobj)AlgToolHistory.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)AlgToolHistory.o : $(src)Lib/AlgToolHistory.cpp
	$(cpp_echo) $(src)Lib/AlgToolHistory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgToolHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgToolHistory_cppflags) $(AlgToolHistory_cpp_cppflags) -I../src/Lib $(src)Lib/AlgToolHistory.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(AlgToolHistory_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/AlgToolHistory.cpp

$(bin)$(binobj)AlgToolHistory.o : $(AlgToolHistory_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AlgToolHistory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgToolHistory_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgToolHistory_cppflags) $(AlgToolHistory_cpp_cppflags) -I../src/Lib $(src)Lib/AlgToolHistory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgContext.d

$(bin)$(binobj)AlgContext.d :

$(bin)$(binobj)AlgContext.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)AlgContext.o : $(src)Lib/AlgContext.cpp
	$(cpp_echo) $(src)Lib/AlgContext.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgContext_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgContext_cppflags) $(AlgContext_cpp_cppflags) -I../src/Lib $(src)Lib/AlgContext.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(AlgContext_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/AlgContext.cpp

$(bin)$(binobj)AlgContext.o : $(AlgContext_cpp_dependencies)
	$(cpp_echo) $(src)Lib/AlgContext.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(AlgContext_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(AlgContext_cppflags) $(AlgContext_cpp_cppflags) -I../src/Lib $(src)Lib/AlgContext.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParsersStandardList3.d

$(bin)$(binobj)ParsersStandardList3.d :

$(bin)$(binobj)ParsersStandardList3.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ParsersStandardList3.o : $(src)Lib/ParsersStandardList3.cpp
	$(cpp_echo) $(src)Lib/ParsersStandardList3.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList3_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList3_cppflags) $(ParsersStandardList3_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList3.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ParsersStandardList3_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ParsersStandardList3.cpp

$(bin)$(binobj)ParsersStandardList3.o : $(ParsersStandardList3_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ParsersStandardList3.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ParsersStandardList3_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ParsersStandardList3_cppflags) $(ParsersStandardList3_cpp_cppflags) -I../src/Lib $(src)Lib/ParsersStandardList3.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiKernelclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ContainedObject.d

$(bin)$(binobj)ContainedObject.d :

$(bin)$(binobj)ContainedObject.o : $(cmt_final_setup_GaudiKernel)

$(bin)$(binobj)ContainedObject.o : $(src)Lib/ContainedObject.cpp
	$(cpp_echo) $(src)Lib/ContainedObject.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ContainedObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ContainedObject_cppflags) $(ContainedObject_cpp_cppflags) -I../src/Lib $(src)Lib/ContainedObject.cpp
endif
endif

else
$(bin)GaudiKernel_dependencies.make : $(ContainedObject_cpp_dependencies)

$(bin)GaudiKernel_dependencies.make : $(src)Lib/ContainedObject.cpp

$(bin)$(binobj)ContainedObject.o : $(ContainedObject_cpp_dependencies)
	$(cpp_echo) $(src)Lib/ContainedObject.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiKernel_pp_cppflags) $(lib_GaudiKernel_pp_cppflags) $(ContainedObject_pp_cppflags) $(use_cppflags) $(GaudiKernel_cppflags) $(lib_GaudiKernel_cppflags) $(ContainedObject_cppflags) $(ContainedObject_cpp_cppflags) -I../src/Lib $(src)Lib/ContainedObject.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiKernelclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiKernel.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiKernelclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiKernel
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiKernel$(library_suffix).a $(library_prefix)GaudiKernel$(library_suffix).$(shlibsuffix) GaudiKernel.stamp GaudiKernel.shstamp
#-- end of cleanup_library ---------------
