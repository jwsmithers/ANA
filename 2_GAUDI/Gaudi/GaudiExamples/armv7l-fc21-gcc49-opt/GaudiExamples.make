#-- start of make_header -----------------

#====================================
#  Library GaudiExamples
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

cmt_GaudiExamples_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamples_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamples

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamples = $(GaudiExamples_tag)_GaudiExamples.make
cmt_local_tagfile_GaudiExamples = $(bin)$(GaudiExamples_tag)_GaudiExamples.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamples = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamples = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamples)
#-include $(cmt_local_tagfile_GaudiExamples)

ifdef cmt_GaudiExamples_has_target_tag

cmt_final_setup_GaudiExamples = $(bin)setup_GaudiExamples.make
cmt_dependencies_in_GaudiExamples = $(bin)dependencies_GaudiExamples.in
#cmt_final_setup_GaudiExamples = $(bin)GaudiExamples_GaudiExamplessetup.make
cmt_local_GaudiExamples_makefile = $(bin)GaudiExamples.make

else

cmt_final_setup_GaudiExamples = $(bin)setup.make
cmt_dependencies_in_GaudiExamples = $(bin)dependencies.in
#cmt_final_setup_GaudiExamples = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamples_makefile = $(bin)GaudiExamples.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamples :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamples'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamples/
#GaudiExamples::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiExampleslibname   = $(bin)$(library_prefix)GaudiExamples$(library_suffix)
GaudiExampleslib       = $(GaudiExampleslibname).a
GaudiExamplesstamp     = $(bin)GaudiExamples.stamp
GaudiExamplesshstamp   = $(bin)GaudiExamples.shstamp

GaudiExamples :: dirs  GaudiExamplesLIB
	$(echo) "GaudiExamples ok"

cmt_GaudiExamples_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamples_has_prototypes

GaudiExamplesprototype :  ;

endif

GaudiExamplescompile : $(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiExamplesLIB :: $(GaudiExampleslib) $(GaudiExamplesshstamp)
GaudiExamplesLIB :: $(GaudiExamplesshstamp)
	$(echo) "GaudiExamples : library ok"

$(GaudiExampleslib) :: $(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiExampleslib) $?
	$(lib_silent) $(ranlib) $(GaudiExampleslib)
	$(lib_silent) cat /dev/null >$(GaudiExamplesstamp)

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

$(GaudiExampleslibname).$(shlibsuffix) :: $(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o $(use_requirements) $(GaudiExamplesstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o $(GaudiExamples_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiExamplesstamp) && \
	  cat /dev/null >$(GaudiExamplesshstamp)

$(GaudiExamplesshstamp) :: $(GaudiExampleslibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiExampleslibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiExamplesstamp) && \
	  cat /dev/null >$(GaudiExamplesshstamp) ; fi

GaudiExamplesclean ::
	$(cleanup_echo) objects GaudiExamples
	$(cleanup_silent) /bin/rm -f $(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o) $(patsubst %.o,%.dep,$(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o) $(patsubst %.o,%.d.stamp,$(bin)AbortEventAlg.o $(bin)SubAlg.o $(bin)StopperAlg.o $(bin)ParentAlg.o $(bin)HelloWorld.o $(bin)TemplatedAlg.o $(bin)MyGaudiTool.o $(bin)MyAlgorithm.o $(bin)MyTool.o $(bin)TestToolAlg.o $(bin)TestTool.o $(bin)TestToolFailing.o $(bin)MyGaudiAlgorithm.o $(bin)TestToolAlgFailure.o $(bin)DataCreator.o $(bin)MyDataAlgorithm.o $(bin)MyAudAlgorithm.o $(bin)MyAudTool.o $(bin)EqSolverPAlg.o $(bin)FuncMinimumPAlg.o $(bin)EqSolverGenAlg.o $(bin)FuncMinimumGenAlg.o $(bin)FuncMinimumIAlg.o $(bin)EqSolverIAlg.o $(bin)RandomNumberAlg.o $(bin)HistoTimingAlg.o $(bin)HistoProps.o $(bin)Aida2Root.o $(bin)HistoAlgorithm.o $(bin)GaudiHistoAlgorithm.o $(bin)NTupleAlgorithm.o $(bin)TupleAlg.o $(bin)TupleDef.o $(bin)TupleAlg2.o $(bin)TupleAlg3.o $(bin)CounterAlg.o $(bin)StatSvcAlg.o $(bin)CounterSvcAlg.o $(bin)GaudiPPS.o $(bin)PartPropExa.o $(bin)PropertyAlg.o $(bin)PropertyProxy.o $(bin)ExtendedProperties2.o $(bin)ExtendedProperties.o $(bin)BoostArrayProperties.o $(bin)ArrayProperties.o $(bin)ExtendedEvtCol.o $(bin)EvtCollectionSelector.o $(bin)ReadTES.o $(bin)EvtExtCollectionSelector.o $(bin)EvtCollectionWrite.o $(bin)ReadAlg.o $(bin)WriteAlg.o $(bin)ColorMsgAlg.o $(bin)History.o $(bin)THistRead.o $(bin)THistWrite.o $(bin)ErrorLogTest.o $(bin)EvtColAlg.o $(bin)MapAlg.o $(bin)QotdAlg.o $(bin)GaudiCommonTests.o $(bin)IncidentListenerTest.o $(bin)IncidentListenerTestAlg.o $(bin)bug34121_MyAlgorithm.o $(bin)bug34121_Tool.o $(bin)AuditorTestAlg.o $(bin)LoggingAuditor.o $(bin)TimingAlg.o $(bin)SelCreate.o $(bin)SelFilter.o $(bin)LoopAlg.o $(bin)ServiceA.o $(bin)ServiceB.o $(bin)StringKeyEx.o $(bin)SCSAlg.o $(bin)FileMgrTest.o $(bin)TestingSvcs.o $(bin)TestingAlgs.o $(bin)CpuHungryAlg.o $(bin)BackwardCompatibleAliases.o $(bin)UseCases.o $(bin)DumpAddress.o $(bin)MIWriteAlg.o $(bin)MIReadAlg.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiExamples_deps GaudiExamples_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiExamplesinstallname = $(library_prefix)GaudiExamples$(library_suffix).$(shlibsuffix)

GaudiExamples :: GaudiExamplesinstall ;

install :: GaudiExamplesinstall ;

GaudiExamplesinstall :: $(install_dir)/$(GaudiExamplesinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiExamplesinstallname) :: $(bin)$(GaudiExamplesinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiExamplesclean :: GaudiExamplesuninstall

uninstall :: GaudiExamplesuninstall ;

GaudiExamplesuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AbortEventAlg.d

$(bin)$(binobj)AbortEventAlg.d :

$(bin)$(binobj)AbortEventAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)AbortEventAlg.o : $(src)AbortEvent/AbortEventAlg.cpp
	$(cpp_echo) $(src)AbortEvent/AbortEventAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(AbortEventAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(AbortEventAlg_cppflags) $(AbortEventAlg_cpp_cppflags) -I../src/AbortEvent $(src)AbortEvent/AbortEventAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(AbortEventAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AbortEvent/AbortEventAlg.cpp

$(bin)$(binobj)AbortEventAlg.o : $(AbortEventAlg_cpp_dependencies)
	$(cpp_echo) $(src)AbortEvent/AbortEventAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(AbortEventAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(AbortEventAlg_cppflags) $(AbortEventAlg_cpp_cppflags) -I../src/AbortEvent $(src)AbortEvent/AbortEventAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SubAlg.d

$(bin)$(binobj)SubAlg.d :

$(bin)$(binobj)SubAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)SubAlg.o : $(src)AlgSequencer/SubAlg.cpp
	$(cpp_echo) $(src)AlgSequencer/SubAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SubAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SubAlg_cppflags) $(SubAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/SubAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(SubAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgSequencer/SubAlg.cpp

$(bin)$(binobj)SubAlg.o : $(SubAlg_cpp_dependencies)
	$(cpp_echo) $(src)AlgSequencer/SubAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SubAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SubAlg_cppflags) $(SubAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/SubAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StopperAlg.d

$(bin)$(binobj)StopperAlg.d :

$(bin)$(binobj)StopperAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)StopperAlg.o : $(src)AlgSequencer/StopperAlg.cpp
	$(cpp_echo) $(src)AlgSequencer/StopperAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StopperAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StopperAlg_cppflags) $(StopperAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/StopperAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(StopperAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgSequencer/StopperAlg.cpp

$(bin)$(binobj)StopperAlg.o : $(StopperAlg_cpp_dependencies)
	$(cpp_echo) $(src)AlgSequencer/StopperAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StopperAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StopperAlg_cppflags) $(StopperAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/StopperAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParentAlg.d

$(bin)$(binobj)ParentAlg.d :

$(bin)$(binobj)ParentAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ParentAlg.o : $(src)AlgSequencer/ParentAlg.cpp
	$(cpp_echo) $(src)AlgSequencer/ParentAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ParentAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ParentAlg_cppflags) $(ParentAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/ParentAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ParentAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgSequencer/ParentAlg.cpp

$(bin)$(binobj)ParentAlg.o : $(ParentAlg_cpp_dependencies)
	$(cpp_echo) $(src)AlgSequencer/ParentAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ParentAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ParentAlg_cppflags) $(ParentAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/ParentAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HelloWorld.d

$(bin)$(binobj)HelloWorld.d :

$(bin)$(binobj)HelloWorld.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)HelloWorld.o : $(src)AlgSequencer/HelloWorld.cpp
	$(cpp_echo) $(src)AlgSequencer/HelloWorld.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HelloWorld_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HelloWorld_cppflags) $(HelloWorld_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/HelloWorld.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(HelloWorld_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgSequencer/HelloWorld.cpp

$(bin)$(binobj)HelloWorld.o : $(HelloWorld_cpp_dependencies)
	$(cpp_echo) $(src)AlgSequencer/HelloWorld.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HelloWorld_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HelloWorld_cppflags) $(HelloWorld_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/HelloWorld.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TemplatedAlg.d

$(bin)$(binobj)TemplatedAlg.d :

$(bin)$(binobj)TemplatedAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TemplatedAlg.o : $(src)AlgSequencer/TemplatedAlg.cpp
	$(cpp_echo) $(src)AlgSequencer/TemplatedAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TemplatedAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TemplatedAlg_cppflags) $(TemplatedAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/TemplatedAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TemplatedAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgSequencer/TemplatedAlg.cpp

$(bin)$(binobj)TemplatedAlg.o : $(TemplatedAlg_cpp_dependencies)
	$(cpp_echo) $(src)AlgSequencer/TemplatedAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TemplatedAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TemplatedAlg_cppflags) $(TemplatedAlg_cpp_cppflags) -I../src/AlgSequencer $(src)AlgSequencer/TemplatedAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyGaudiTool.d

$(bin)$(binobj)MyGaudiTool.d :

$(bin)$(binobj)MyGaudiTool.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyGaudiTool.o : $(src)AlgTools/MyGaudiTool.cpp
	$(cpp_echo) $(src)AlgTools/MyGaudiTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyGaudiTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyGaudiTool_cppflags) $(MyGaudiTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyGaudiTool.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyGaudiTool_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/MyGaudiTool.cpp

$(bin)$(binobj)MyGaudiTool.o : $(MyGaudiTool_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/MyGaudiTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyGaudiTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyGaudiTool_cppflags) $(MyGaudiTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyGaudiTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyAlgorithm.d

$(bin)$(binobj)MyAlgorithm.d :

$(bin)$(binobj)MyAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyAlgorithm.o : $(src)AlgTools/MyAlgorithm.cpp
	$(cpp_echo) $(src)AlgTools/MyAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAlgorithm_cppflags) $(MyAlgorithm_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/MyAlgorithm.cpp

$(bin)$(binobj)MyAlgorithm.o : $(MyAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/MyAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAlgorithm_cppflags) $(MyAlgorithm_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyTool.d

$(bin)$(binobj)MyTool.d :

$(bin)$(binobj)MyTool.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyTool.o : $(src)AlgTools/MyTool.cpp
	$(cpp_echo) $(src)AlgTools/MyTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyTool_cppflags) $(MyTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyTool.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyTool_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/MyTool.cpp

$(bin)$(binobj)MyTool.o : $(MyTool_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/MyTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyTool_cppflags) $(MyTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestToolAlg.d

$(bin)$(binobj)TestToolAlg.d :

$(bin)$(binobj)TestToolAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestToolAlg.o : $(src)AlgTools/TestToolAlg.cpp
	$(cpp_echo) $(src)AlgTools/TestToolAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolAlg_cppflags) $(TestToolAlg_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestToolAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/TestToolAlg.cpp

$(bin)$(binobj)TestToolAlg.o : $(TestToolAlg_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/TestToolAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolAlg_cppflags) $(TestToolAlg_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestTool.d

$(bin)$(binobj)TestTool.d :

$(bin)$(binobj)TestTool.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestTool.o : $(src)AlgTools/TestTool.cpp
	$(cpp_echo) $(src)AlgTools/TestTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestTool_cppflags) $(TestTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestTool.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestTool_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/TestTool.cpp

$(bin)$(binobj)TestTool.o : $(TestTool_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/TestTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestTool_cppflags) $(TestTool_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestToolFailing.d

$(bin)$(binobj)TestToolFailing.d :

$(bin)$(binobj)TestToolFailing.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestToolFailing.o : $(src)AlgTools/TestToolFailing.cpp
	$(cpp_echo) $(src)AlgTools/TestToolFailing.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolFailing_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolFailing_cppflags) $(TestToolFailing_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolFailing.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestToolFailing_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/TestToolFailing.cpp

$(bin)$(binobj)TestToolFailing.o : $(TestToolFailing_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/TestToolFailing.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolFailing_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolFailing_cppflags) $(TestToolFailing_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolFailing.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyGaudiAlgorithm.d

$(bin)$(binobj)MyGaudiAlgorithm.d :

$(bin)$(binobj)MyGaudiAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyGaudiAlgorithm.o : $(src)AlgTools/MyGaudiAlgorithm.cpp
	$(cpp_echo) $(src)AlgTools/MyGaudiAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyGaudiAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyGaudiAlgorithm_cppflags) $(MyGaudiAlgorithm_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyGaudiAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyGaudiAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/MyGaudiAlgorithm.cpp

$(bin)$(binobj)MyGaudiAlgorithm.o : $(MyGaudiAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/MyGaudiAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyGaudiAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyGaudiAlgorithm_cppflags) $(MyGaudiAlgorithm_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/MyGaudiAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestToolAlgFailure.d

$(bin)$(binobj)TestToolAlgFailure.d :

$(bin)$(binobj)TestToolAlgFailure.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestToolAlgFailure.o : $(src)AlgTools/TestToolAlgFailure.cpp
	$(cpp_echo) $(src)AlgTools/TestToolAlgFailure.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolAlgFailure_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolAlgFailure_cppflags) $(TestToolAlgFailure_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolAlgFailure.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestToolAlgFailure_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgTools/TestToolAlgFailure.cpp

$(bin)$(binobj)TestToolAlgFailure.o : $(TestToolAlgFailure_cpp_dependencies)
	$(cpp_echo) $(src)AlgTools/TestToolAlgFailure.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestToolAlgFailure_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestToolAlgFailure_cppflags) $(TestToolAlgFailure_cpp_cppflags) -I../src/AlgTools $(src)AlgTools/TestToolAlgFailure.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataCreator.d

$(bin)$(binobj)DataCreator.d :

$(bin)$(binobj)DataCreator.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)DataCreator.o : $(src)DataOnDemand/DataCreator.cpp
	$(cpp_echo) $(src)DataOnDemand/DataCreator.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(DataCreator_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(DataCreator_cppflags) $(DataCreator_cpp_cppflags) -I../src/DataOnDemand $(src)DataOnDemand/DataCreator.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(DataCreator_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)DataOnDemand/DataCreator.cpp

$(bin)$(binobj)DataCreator.o : $(DataCreator_cpp_dependencies)
	$(cpp_echo) $(src)DataOnDemand/DataCreator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(DataCreator_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(DataCreator_cppflags) $(DataCreator_cpp_cppflags) -I../src/DataOnDemand $(src)DataOnDemand/DataCreator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyDataAlgorithm.d

$(bin)$(binobj)MyDataAlgorithm.d :

$(bin)$(binobj)MyDataAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyDataAlgorithm.o : $(src)DataOnDemand/MyDataAlgorithm.cpp
	$(cpp_echo) $(src)DataOnDemand/MyDataAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyDataAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyDataAlgorithm_cppflags) $(MyDataAlgorithm_cpp_cppflags) -I../src/DataOnDemand $(src)DataOnDemand/MyDataAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyDataAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)DataOnDemand/MyDataAlgorithm.cpp

$(bin)$(binobj)MyDataAlgorithm.o : $(MyDataAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)DataOnDemand/MyDataAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyDataAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyDataAlgorithm_cppflags) $(MyDataAlgorithm_cpp_cppflags) -I../src/DataOnDemand $(src)DataOnDemand/MyDataAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyAudAlgorithm.d

$(bin)$(binobj)MyAudAlgorithm.d :

$(bin)$(binobj)MyAudAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyAudAlgorithm.o : $(src)AlgErrAud/MyAudAlgorithm.cpp
	$(cpp_echo) $(src)AlgErrAud/MyAudAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAudAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAudAlgorithm_cppflags) $(MyAudAlgorithm_cpp_cppflags) -I../src/AlgErrAud $(src)AlgErrAud/MyAudAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyAudAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgErrAud/MyAudAlgorithm.cpp

$(bin)$(binobj)MyAudAlgorithm.o : $(MyAudAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)AlgErrAud/MyAudAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAudAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAudAlgorithm_cppflags) $(MyAudAlgorithm_cpp_cppflags) -I../src/AlgErrAud $(src)AlgErrAud/MyAudAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyAudTool.d

$(bin)$(binobj)MyAudTool.d :

$(bin)$(binobj)MyAudTool.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MyAudTool.o : $(src)AlgErrAud/MyAudTool.cpp
	$(cpp_echo) $(src)AlgErrAud/MyAudTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAudTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAudTool_cppflags) $(MyAudTool_cpp_cppflags) -I../src/AlgErrAud $(src)AlgErrAud/MyAudTool.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MyAudTool_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)AlgErrAud/MyAudTool.cpp

$(bin)$(binobj)MyAudTool.o : $(MyAudTool_cpp_dependencies)
	$(cpp_echo) $(src)AlgErrAud/MyAudTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MyAudTool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MyAudTool_cppflags) $(MyAudTool_cpp_cppflags) -I../src/AlgErrAud $(src)AlgErrAud/MyAudTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EqSolverPAlg.d

$(bin)$(binobj)EqSolverPAlg.d :

$(bin)$(binobj)EqSolverPAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EqSolverPAlg.o : $(src)GSLTools/EqSolverPAlg.cpp
	$(cpp_echo) $(src)GSLTools/EqSolverPAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverPAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverPAlg_cppflags) $(EqSolverPAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverPAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EqSolverPAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/EqSolverPAlg.cpp

$(bin)$(binobj)EqSolverPAlg.o : $(EqSolverPAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/EqSolverPAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverPAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverPAlg_cppflags) $(EqSolverPAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverPAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FuncMinimumPAlg.d

$(bin)$(binobj)FuncMinimumPAlg.d :

$(bin)$(binobj)FuncMinimumPAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)FuncMinimumPAlg.o : $(src)GSLTools/FuncMinimumPAlg.cpp
	$(cpp_echo) $(src)GSLTools/FuncMinimumPAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumPAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumPAlg_cppflags) $(FuncMinimumPAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumPAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(FuncMinimumPAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/FuncMinimumPAlg.cpp

$(bin)$(binobj)FuncMinimumPAlg.o : $(FuncMinimumPAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/FuncMinimumPAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumPAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumPAlg_cppflags) $(FuncMinimumPAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumPAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EqSolverGenAlg.d

$(bin)$(binobj)EqSolverGenAlg.d :

$(bin)$(binobj)EqSolverGenAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EqSolverGenAlg.o : $(src)GSLTools/EqSolverGenAlg.cpp
	$(cpp_echo) $(src)GSLTools/EqSolverGenAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverGenAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverGenAlg_cppflags) $(EqSolverGenAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverGenAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EqSolverGenAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/EqSolverGenAlg.cpp

$(bin)$(binobj)EqSolverGenAlg.o : $(EqSolverGenAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/EqSolverGenAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverGenAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverGenAlg_cppflags) $(EqSolverGenAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverGenAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FuncMinimumGenAlg.d

$(bin)$(binobj)FuncMinimumGenAlg.d :

$(bin)$(binobj)FuncMinimumGenAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)FuncMinimumGenAlg.o : $(src)GSLTools/FuncMinimumGenAlg.cpp
	$(cpp_echo) $(src)GSLTools/FuncMinimumGenAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumGenAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumGenAlg_cppflags) $(FuncMinimumGenAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumGenAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(FuncMinimumGenAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/FuncMinimumGenAlg.cpp

$(bin)$(binobj)FuncMinimumGenAlg.o : $(FuncMinimumGenAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/FuncMinimumGenAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumGenAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumGenAlg_cppflags) $(FuncMinimumGenAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumGenAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FuncMinimumIAlg.d

$(bin)$(binobj)FuncMinimumIAlg.d :

$(bin)$(binobj)FuncMinimumIAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)FuncMinimumIAlg.o : $(src)GSLTools/FuncMinimumIAlg.cpp
	$(cpp_echo) $(src)GSLTools/FuncMinimumIAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumIAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumIAlg_cppflags) $(FuncMinimumIAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumIAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(FuncMinimumIAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/FuncMinimumIAlg.cpp

$(bin)$(binobj)FuncMinimumIAlg.o : $(FuncMinimumIAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/FuncMinimumIAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FuncMinimumIAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FuncMinimumIAlg_cppflags) $(FuncMinimumIAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/FuncMinimumIAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EqSolverIAlg.d

$(bin)$(binobj)EqSolverIAlg.d :

$(bin)$(binobj)EqSolverIAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EqSolverIAlg.o : $(src)GSLTools/EqSolverIAlg.cpp
	$(cpp_echo) $(src)GSLTools/EqSolverIAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverIAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverIAlg_cppflags) $(EqSolverIAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverIAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EqSolverIAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GSLTools/EqSolverIAlg.cpp

$(bin)$(binobj)EqSolverIAlg.o : $(EqSolverIAlg_cpp_dependencies)
	$(cpp_echo) $(src)GSLTools/EqSolverIAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EqSolverIAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EqSolverIAlg_cppflags) $(EqSolverIAlg_cpp_cppflags) -I../src/GSLTools $(src)GSLTools/EqSolverIAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RandomNumberAlg.d

$(bin)$(binobj)RandomNumberAlg.d :

$(bin)$(binobj)RandomNumberAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)RandomNumberAlg.o : $(src)RandomNumber/RandomNumberAlg.cpp
	$(cpp_echo) $(src)RandomNumber/RandomNumberAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(RandomNumberAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(RandomNumberAlg_cppflags) $(RandomNumberAlg_cpp_cppflags) -I../src/RandomNumber $(src)RandomNumber/RandomNumberAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(RandomNumberAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)RandomNumber/RandomNumberAlg.cpp

$(bin)$(binobj)RandomNumberAlg.o : $(RandomNumberAlg_cpp_dependencies)
	$(cpp_echo) $(src)RandomNumber/RandomNumberAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(RandomNumberAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(RandomNumberAlg_cppflags) $(RandomNumberAlg_cpp_cppflags) -I../src/RandomNumber $(src)RandomNumber/RandomNumberAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoTimingAlg.d

$(bin)$(binobj)HistoTimingAlg.d :

$(bin)$(binobj)HistoTimingAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)HistoTimingAlg.o : $(src)Histograms/HistoTimingAlg.cpp
	$(cpp_echo) $(src)Histograms/HistoTimingAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoTimingAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoTimingAlg_cppflags) $(HistoTimingAlg_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoTimingAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(HistoTimingAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Histograms/HistoTimingAlg.cpp

$(bin)$(binobj)HistoTimingAlg.o : $(HistoTimingAlg_cpp_dependencies)
	$(cpp_echo) $(src)Histograms/HistoTimingAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoTimingAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoTimingAlg_cppflags) $(HistoTimingAlg_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoTimingAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoProps.d

$(bin)$(binobj)HistoProps.d :

$(bin)$(binobj)HistoProps.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)HistoProps.o : $(src)Histograms/HistoProps.cpp
	$(cpp_echo) $(src)Histograms/HistoProps.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoProps_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoProps_cppflags) $(HistoProps_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoProps.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(HistoProps_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Histograms/HistoProps.cpp

$(bin)$(binobj)HistoProps.o : $(HistoProps_cpp_dependencies)
	$(cpp_echo) $(src)Histograms/HistoProps.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoProps_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoProps_cppflags) $(HistoProps_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoProps.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Aida2Root.d

$(bin)$(binobj)Aida2Root.d :

$(bin)$(binobj)Aida2Root.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)Aida2Root.o : $(src)Histograms/Aida2Root.cpp
	$(cpp_echo) $(src)Histograms/Aida2Root.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(Aida2Root_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(Aida2Root_cppflags) $(Aida2Root_cpp_cppflags) -I../src/Histograms $(src)Histograms/Aida2Root.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(Aida2Root_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Histograms/Aida2Root.cpp

$(bin)$(binobj)Aida2Root.o : $(Aida2Root_cpp_dependencies)
	$(cpp_echo) $(src)Histograms/Aida2Root.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(Aida2Root_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(Aida2Root_cppflags) $(Aida2Root_cpp_cppflags) -I../src/Histograms $(src)Histograms/Aida2Root.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoAlgorithm.d

$(bin)$(binobj)HistoAlgorithm.d :

$(bin)$(binobj)HistoAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)HistoAlgorithm.o : $(src)Histograms/HistoAlgorithm.cpp
	$(cpp_echo) $(src)Histograms/HistoAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoAlgorithm_cppflags) $(HistoAlgorithm_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(HistoAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Histograms/HistoAlgorithm.cpp

$(bin)$(binobj)HistoAlgorithm.o : $(HistoAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)Histograms/HistoAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(HistoAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(HistoAlgorithm_cppflags) $(HistoAlgorithm_cpp_cppflags) -I../src/Histograms $(src)Histograms/HistoAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiHistoAlgorithm.d

$(bin)$(binobj)GaudiHistoAlgorithm.d :

$(bin)$(binobj)GaudiHistoAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)GaudiHistoAlgorithm.o : $(src)Histograms/GaudiHistoAlgorithm.cpp
	$(cpp_echo) $(src)Histograms/GaudiHistoAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiHistoAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiHistoAlgorithm_cppflags) $(GaudiHistoAlgorithm_cpp_cppflags) -I../src/Histograms $(src)Histograms/GaudiHistoAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(GaudiHistoAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Histograms/GaudiHistoAlgorithm.cpp

$(bin)$(binobj)GaudiHistoAlgorithm.o : $(GaudiHistoAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)Histograms/GaudiHistoAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiHistoAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiHistoAlgorithm_cppflags) $(GaudiHistoAlgorithm_cpp_cppflags) -I../src/Histograms $(src)Histograms/GaudiHistoAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NTupleAlgorithm.d

$(bin)$(binobj)NTupleAlgorithm.d :

$(bin)$(binobj)NTupleAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)NTupleAlgorithm.o : $(src)NTuples/NTupleAlgorithm.cpp
	$(cpp_echo) $(src)NTuples/NTupleAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(NTupleAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(NTupleAlgorithm_cppflags) $(NTupleAlgorithm_cpp_cppflags) -I../src/NTuples $(src)NTuples/NTupleAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(NTupleAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)NTuples/NTupleAlgorithm.cpp

$(bin)$(binobj)NTupleAlgorithm.o : $(NTupleAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)NTuples/NTupleAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(NTupleAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(NTupleAlgorithm_cppflags) $(NTupleAlgorithm_cpp_cppflags) -I../src/NTuples $(src)NTuples/NTupleAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleAlg.d

$(bin)$(binobj)TupleAlg.d :

$(bin)$(binobj)TupleAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TupleAlg.o : $(src)TupleEx/TupleAlg.cpp
	$(cpp_echo) $(src)TupleEx/TupleAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg_cppflags) $(TupleAlg_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TupleAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)TupleEx/TupleAlg.cpp

$(bin)$(binobj)TupleAlg.o : $(TupleAlg_cpp_dependencies)
	$(cpp_echo) $(src)TupleEx/TupleAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg_cppflags) $(TupleAlg_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleDef.d

$(bin)$(binobj)TupleDef.d :

$(bin)$(binobj)TupleDef.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TupleDef.o : $(src)TupleEx/TupleDef.cpp
	$(cpp_echo) $(src)TupleEx/TupleDef.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleDef_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleDef_cppflags) $(TupleDef_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleDef.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TupleDef_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)TupleEx/TupleDef.cpp

$(bin)$(binobj)TupleDef.o : $(TupleDef_cpp_dependencies)
	$(cpp_echo) $(src)TupleEx/TupleDef.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleDef_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleDef_cppflags) $(TupleDef_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleDef.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleAlg2.d

$(bin)$(binobj)TupleAlg2.d :

$(bin)$(binobj)TupleAlg2.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TupleAlg2.o : $(src)TupleEx/TupleAlg2.cpp
	$(cpp_echo) $(src)TupleEx/TupleAlg2.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg2_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg2_cppflags) $(TupleAlg2_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg2.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TupleAlg2_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)TupleEx/TupleAlg2.cpp

$(bin)$(binobj)TupleAlg2.o : $(TupleAlg2_cpp_dependencies)
	$(cpp_echo) $(src)TupleEx/TupleAlg2.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg2_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg2_cppflags) $(TupleAlg2_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg2.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleAlg3.d

$(bin)$(binobj)TupleAlg3.d :

$(bin)$(binobj)TupleAlg3.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TupleAlg3.o : $(src)TupleEx/TupleAlg3.cpp
	$(cpp_echo) $(src)TupleEx/TupleAlg3.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg3_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg3_cppflags) $(TupleAlg3_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg3.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TupleAlg3_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)TupleEx/TupleAlg3.cpp

$(bin)$(binobj)TupleAlg3.o : $(TupleAlg3_cpp_dependencies)
	$(cpp_echo) $(src)TupleEx/TupleAlg3.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TupleAlg3_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TupleAlg3_cppflags) $(TupleAlg3_cpp_cppflags) -I../src/TupleEx $(src)TupleEx/TupleAlg3.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CounterAlg.d

$(bin)$(binobj)CounterAlg.d :

$(bin)$(binobj)CounterAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)CounterAlg.o : $(src)CounterEx/CounterAlg.cpp
	$(cpp_echo) $(src)CounterEx/CounterAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CounterAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CounterAlg_cppflags) $(CounterAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/CounterAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(CounterAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)CounterEx/CounterAlg.cpp

$(bin)$(binobj)CounterAlg.o : $(CounterAlg_cpp_dependencies)
	$(cpp_echo) $(src)CounterEx/CounterAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CounterAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CounterAlg_cppflags) $(CounterAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/CounterAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StatSvcAlg.d

$(bin)$(binobj)StatSvcAlg.d :

$(bin)$(binobj)StatSvcAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)StatSvcAlg.o : $(src)CounterEx/StatSvcAlg.cpp
	$(cpp_echo) $(src)CounterEx/StatSvcAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StatSvcAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StatSvcAlg_cppflags) $(StatSvcAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/StatSvcAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(StatSvcAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)CounterEx/StatSvcAlg.cpp

$(bin)$(binobj)StatSvcAlg.o : $(StatSvcAlg_cpp_dependencies)
	$(cpp_echo) $(src)CounterEx/StatSvcAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StatSvcAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StatSvcAlg_cppflags) $(StatSvcAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/StatSvcAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CounterSvcAlg.d

$(bin)$(binobj)CounterSvcAlg.d :

$(bin)$(binobj)CounterSvcAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)CounterSvcAlg.o : $(src)CounterEx/CounterSvcAlg.cpp
	$(cpp_echo) $(src)CounterEx/CounterSvcAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CounterSvcAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CounterSvcAlg_cppflags) $(CounterSvcAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/CounterSvcAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(CounterSvcAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)CounterEx/CounterSvcAlg.cpp

$(bin)$(binobj)CounterSvcAlg.o : $(CounterSvcAlg_cpp_dependencies)
	$(cpp_echo) $(src)CounterEx/CounterSvcAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CounterSvcAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CounterSvcAlg_cppflags) $(CounterSvcAlg_cpp_cppflags) -I../src/CounterEx $(src)CounterEx/CounterSvcAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiPPS.d

$(bin)$(binobj)GaudiPPS.d :

$(bin)$(binobj)GaudiPPS.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)GaudiPPS.o : $(src)PartProp/GaudiPPS.cpp
	$(cpp_echo) $(src)PartProp/GaudiPPS.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiPPS_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiPPS_cppflags) $(GaudiPPS_cpp_cppflags) -I../src/PartProp $(src)PartProp/GaudiPPS.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(GaudiPPS_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)PartProp/GaudiPPS.cpp

$(bin)$(binobj)GaudiPPS.o : $(GaudiPPS_cpp_dependencies)
	$(cpp_echo) $(src)PartProp/GaudiPPS.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiPPS_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiPPS_cppflags) $(GaudiPPS_cpp_cppflags) -I../src/PartProp $(src)PartProp/GaudiPPS.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PartPropExa.d

$(bin)$(binobj)PartPropExa.d :

$(bin)$(binobj)PartPropExa.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)PartPropExa.o : $(src)PartProp/PartPropExa.cpp
	$(cpp_echo) $(src)PartProp/PartPropExa.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PartPropExa_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PartPropExa_cppflags) $(PartPropExa_cpp_cppflags) -I../src/PartProp $(src)PartProp/PartPropExa.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(PartPropExa_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)PartProp/PartPropExa.cpp

$(bin)$(binobj)PartPropExa.o : $(PartPropExa_cpp_dependencies)
	$(cpp_echo) $(src)PartProp/PartPropExa.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PartPropExa_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PartPropExa_cppflags) $(PartPropExa_cpp_cppflags) -I../src/PartProp $(src)PartProp/PartPropExa.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyAlg.d

$(bin)$(binobj)PropertyAlg.d :

$(bin)$(binobj)PropertyAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)PropertyAlg.o : $(src)Properties/PropertyAlg.cpp
	$(cpp_echo) $(src)Properties/PropertyAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PropertyAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PropertyAlg_cppflags) $(PropertyAlg_cpp_cppflags) -I../src/Properties $(src)Properties/PropertyAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(PropertyAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Properties/PropertyAlg.cpp

$(bin)$(binobj)PropertyAlg.o : $(PropertyAlg_cpp_dependencies)
	$(cpp_echo) $(src)Properties/PropertyAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PropertyAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PropertyAlg_cppflags) $(PropertyAlg_cpp_cppflags) -I../src/Properties $(src)Properties/PropertyAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyProxy.d

$(bin)$(binobj)PropertyProxy.d :

$(bin)$(binobj)PropertyProxy.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)PropertyProxy.o : $(src)Properties/PropertyProxy.cpp
	$(cpp_echo) $(src)Properties/PropertyProxy.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PropertyProxy_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PropertyProxy_cppflags) $(PropertyProxy_cpp_cppflags) -I../src/Properties $(src)Properties/PropertyProxy.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(PropertyProxy_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Properties/PropertyProxy.cpp

$(bin)$(binobj)PropertyProxy.o : $(PropertyProxy_cpp_dependencies)
	$(cpp_echo) $(src)Properties/PropertyProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(PropertyProxy_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(PropertyProxy_cppflags) $(PropertyProxy_cpp_cppflags) -I../src/Properties $(src)Properties/PropertyProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtendedProperties2.d

$(bin)$(binobj)ExtendedProperties2.d :

$(bin)$(binobj)ExtendedProperties2.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ExtendedProperties2.o : $(src)ExtendedProperties/ExtendedProperties2.cpp
	$(cpp_echo) $(src)ExtendedProperties/ExtendedProperties2.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedProperties2_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedProperties2_cppflags) $(ExtendedProperties2_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ExtendedProperties2.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ExtendedProperties2_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ExtendedProperties/ExtendedProperties2.cpp

$(bin)$(binobj)ExtendedProperties2.o : $(ExtendedProperties2_cpp_dependencies)
	$(cpp_echo) $(src)ExtendedProperties/ExtendedProperties2.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedProperties2_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedProperties2_cppflags) $(ExtendedProperties2_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ExtendedProperties2.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtendedProperties.d

$(bin)$(binobj)ExtendedProperties.d :

$(bin)$(binobj)ExtendedProperties.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ExtendedProperties.o : $(src)ExtendedProperties/ExtendedProperties.cpp
	$(cpp_echo) $(src)ExtendedProperties/ExtendedProperties.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedProperties_cppflags) $(ExtendedProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ExtendedProperties.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ExtendedProperties_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ExtendedProperties/ExtendedProperties.cpp

$(bin)$(binobj)ExtendedProperties.o : $(ExtendedProperties_cpp_dependencies)
	$(cpp_echo) $(src)ExtendedProperties/ExtendedProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedProperties_cppflags) $(ExtendedProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ExtendedProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BoostArrayProperties.d

$(bin)$(binobj)BoostArrayProperties.d :

$(bin)$(binobj)BoostArrayProperties.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)BoostArrayProperties.o : $(src)ExtendedProperties/BoostArrayProperties.cpp
	$(cpp_echo) $(src)ExtendedProperties/BoostArrayProperties.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(BoostArrayProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(BoostArrayProperties_cppflags) $(BoostArrayProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/BoostArrayProperties.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(BoostArrayProperties_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ExtendedProperties/BoostArrayProperties.cpp

$(bin)$(binobj)BoostArrayProperties.o : $(BoostArrayProperties_cpp_dependencies)
	$(cpp_echo) $(src)ExtendedProperties/BoostArrayProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(BoostArrayProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(BoostArrayProperties_cppflags) $(BoostArrayProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/BoostArrayProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ArrayProperties.d

$(bin)$(binobj)ArrayProperties.d :

$(bin)$(binobj)ArrayProperties.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ArrayProperties.o : $(src)ExtendedProperties/ArrayProperties.cpp
	$(cpp_echo) $(src)ExtendedProperties/ArrayProperties.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ArrayProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ArrayProperties_cppflags) $(ArrayProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ArrayProperties.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ArrayProperties_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ExtendedProperties/ArrayProperties.cpp

$(bin)$(binobj)ArrayProperties.o : $(ArrayProperties_cpp_dependencies)
	$(cpp_echo) $(src)ExtendedProperties/ArrayProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ArrayProperties_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ArrayProperties_cppflags) $(ArrayProperties_cpp_cppflags) -I../src/ExtendedProperties $(src)ExtendedProperties/ArrayProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ExtendedEvtCol.d

$(bin)$(binobj)ExtendedEvtCol.d :

$(bin)$(binobj)ExtendedEvtCol.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ExtendedEvtCol.o : $(src)IO/ExtendedEvtCol.cpp
	$(cpp_echo) $(src)IO/ExtendedEvtCol.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedEvtCol_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedEvtCol_cppflags) $(ExtendedEvtCol_cpp_cppflags) -I../src/IO $(src)IO/ExtendedEvtCol.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ExtendedEvtCol_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/ExtendedEvtCol.cpp

$(bin)$(binobj)ExtendedEvtCol.o : $(ExtendedEvtCol_cpp_dependencies)
	$(cpp_echo) $(src)IO/ExtendedEvtCol.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ExtendedEvtCol_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ExtendedEvtCol_cppflags) $(ExtendedEvtCol_cpp_cppflags) -I../src/IO $(src)IO/ExtendedEvtCol.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtCollectionSelector.d

$(bin)$(binobj)EvtCollectionSelector.d :

$(bin)$(binobj)EvtCollectionSelector.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EvtCollectionSelector.o : $(src)IO/EvtCollectionSelector.cpp
	$(cpp_echo) $(src)IO/EvtCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtCollectionSelector_cppflags) $(EvtCollectionSelector_cpp_cppflags) -I../src/IO $(src)IO/EvtCollectionSelector.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EvtCollectionSelector_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/EvtCollectionSelector.cpp

$(bin)$(binobj)EvtCollectionSelector.o : $(EvtCollectionSelector_cpp_dependencies)
	$(cpp_echo) $(src)IO/EvtCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtCollectionSelector_cppflags) $(EvtCollectionSelector_cpp_cppflags) -I../src/IO $(src)IO/EvtCollectionSelector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReadTES.d

$(bin)$(binobj)ReadTES.d :

$(bin)$(binobj)ReadTES.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ReadTES.o : $(src)IO/ReadTES.cpp
	$(cpp_echo) $(src)IO/ReadTES.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ReadTES_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ReadTES_cppflags) $(ReadTES_cpp_cppflags) -I../src/IO $(src)IO/ReadTES.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ReadTES_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/ReadTES.cpp

$(bin)$(binobj)ReadTES.o : $(ReadTES_cpp_dependencies)
	$(cpp_echo) $(src)IO/ReadTES.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ReadTES_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ReadTES_cppflags) $(ReadTES_cpp_cppflags) -I../src/IO $(src)IO/ReadTES.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtExtCollectionSelector.d

$(bin)$(binobj)EvtExtCollectionSelector.d :

$(bin)$(binobj)EvtExtCollectionSelector.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EvtExtCollectionSelector.o : $(src)IO/EvtExtCollectionSelector.cpp
	$(cpp_echo) $(src)IO/EvtExtCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtExtCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtExtCollectionSelector_cppflags) $(EvtExtCollectionSelector_cpp_cppflags) -I../src/IO $(src)IO/EvtExtCollectionSelector.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EvtExtCollectionSelector_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/EvtExtCollectionSelector.cpp

$(bin)$(binobj)EvtExtCollectionSelector.o : $(EvtExtCollectionSelector_cpp_dependencies)
	$(cpp_echo) $(src)IO/EvtExtCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtExtCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtExtCollectionSelector_cppflags) $(EvtExtCollectionSelector_cpp_cppflags) -I../src/IO $(src)IO/EvtExtCollectionSelector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtCollectionWrite.d

$(bin)$(binobj)EvtCollectionWrite.d :

$(bin)$(binobj)EvtCollectionWrite.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EvtCollectionWrite.o : $(src)IO/EvtCollectionWrite.cpp
	$(cpp_echo) $(src)IO/EvtCollectionWrite.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtCollectionWrite_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtCollectionWrite_cppflags) $(EvtCollectionWrite_cpp_cppflags) -I../src/IO $(src)IO/EvtCollectionWrite.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EvtCollectionWrite_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/EvtCollectionWrite.cpp

$(bin)$(binobj)EvtCollectionWrite.o : $(EvtCollectionWrite_cpp_dependencies)
	$(cpp_echo) $(src)IO/EvtCollectionWrite.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtCollectionWrite_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtCollectionWrite_cppflags) $(EvtCollectionWrite_cpp_cppflags) -I../src/IO $(src)IO/EvtCollectionWrite.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ReadAlg.d

$(bin)$(binobj)ReadAlg.d :

$(bin)$(binobj)ReadAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ReadAlg.o : $(src)IO/ReadAlg.cpp
	$(cpp_echo) $(src)IO/ReadAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ReadAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ReadAlg_cppflags) $(ReadAlg_cpp_cppflags) -I../src/IO $(src)IO/ReadAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ReadAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/ReadAlg.cpp

$(bin)$(binobj)ReadAlg.o : $(ReadAlg_cpp_dependencies)
	$(cpp_echo) $(src)IO/ReadAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ReadAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ReadAlg_cppflags) $(ReadAlg_cpp_cppflags) -I../src/IO $(src)IO/ReadAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)WriteAlg.d

$(bin)$(binobj)WriteAlg.d :

$(bin)$(binobj)WriteAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)WriteAlg.o : $(src)IO/WriteAlg.cpp
	$(cpp_echo) $(src)IO/WriteAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(WriteAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(WriteAlg_cppflags) $(WriteAlg_cpp_cppflags) -I../src/IO $(src)IO/WriteAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(WriteAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IO/WriteAlg.cpp

$(bin)$(binobj)WriteAlg.o : $(WriteAlg_cpp_dependencies)
	$(cpp_echo) $(src)IO/WriteAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(WriteAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(WriteAlg_cppflags) $(WriteAlg_cpp_cppflags) -I../src/IO $(src)IO/WriteAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ColorMsgAlg.d

$(bin)$(binobj)ColorMsgAlg.d :

$(bin)$(binobj)ColorMsgAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ColorMsgAlg.o : $(src)ColorMsg/ColorMsgAlg.cpp
	$(cpp_echo) $(src)ColorMsg/ColorMsgAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ColorMsgAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ColorMsgAlg_cppflags) $(ColorMsgAlg_cpp_cppflags) -I../src/ColorMsg $(src)ColorMsg/ColorMsgAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ColorMsgAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ColorMsg/ColorMsgAlg.cpp

$(bin)$(binobj)ColorMsgAlg.o : $(ColorMsgAlg_cpp_dependencies)
	$(cpp_echo) $(src)ColorMsg/ColorMsgAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ColorMsgAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ColorMsgAlg_cppflags) $(ColorMsgAlg_cpp_cppflags) -I../src/ColorMsg $(src)ColorMsg/ColorMsgAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)History.d

$(bin)$(binobj)History.d :

$(bin)$(binobj)History.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)History.o : $(src)History/History.cpp
	$(cpp_echo) $(src)History/History.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(History_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(History_cppflags) $(History_cpp_cppflags) -I../src/History $(src)History/History.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(History_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)History/History.cpp

$(bin)$(binobj)History.o : $(History_cpp_dependencies)
	$(cpp_echo) $(src)History/History.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(History_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(History_cppflags) $(History_cpp_cppflags) -I../src/History $(src)History/History.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)THistRead.d

$(bin)$(binobj)THistRead.d :

$(bin)$(binobj)THistRead.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)THistRead.o : $(src)THist/THistRead.cpp
	$(cpp_echo) $(src)THist/THistRead.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(THistRead_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(THistRead_cppflags) $(THistRead_cpp_cppflags) -I../src/THist $(src)THist/THistRead.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(THistRead_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)THist/THistRead.cpp

$(bin)$(binobj)THistRead.o : $(THistRead_cpp_dependencies)
	$(cpp_echo) $(src)THist/THistRead.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(THistRead_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(THistRead_cppflags) $(THistRead_cpp_cppflags) -I../src/THist $(src)THist/THistRead.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)THistWrite.d

$(bin)$(binobj)THistWrite.d :

$(bin)$(binobj)THistWrite.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)THistWrite.o : $(src)THist/THistWrite.cpp
	$(cpp_echo) $(src)THist/THistWrite.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(THistWrite_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(THistWrite_cppflags) $(THistWrite_cpp_cppflags) -I../src/THist $(src)THist/THistWrite.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(THistWrite_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)THist/THistWrite.cpp

$(bin)$(binobj)THistWrite.o : $(THistWrite_cpp_dependencies)
	$(cpp_echo) $(src)THist/THistWrite.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(THistWrite_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(THistWrite_cppflags) $(THistWrite_cpp_cppflags) -I../src/THist $(src)THist/THistWrite.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ErrorLogTest.d

$(bin)$(binobj)ErrorLogTest.d :

$(bin)$(binobj)ErrorLogTest.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ErrorLogTest.o : $(src)ErrorLog/ErrorLogTest.cpp
	$(cpp_echo) $(src)ErrorLog/ErrorLogTest.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ErrorLogTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ErrorLogTest_cppflags) $(ErrorLogTest_cpp_cppflags) -I../src/ErrorLog $(src)ErrorLog/ErrorLogTest.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ErrorLogTest_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)ErrorLog/ErrorLogTest.cpp

$(bin)$(binobj)ErrorLogTest.o : $(ErrorLogTest_cpp_dependencies)
	$(cpp_echo) $(src)ErrorLog/ErrorLogTest.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ErrorLogTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ErrorLogTest_cppflags) $(ErrorLogTest_cpp_cppflags) -I../src/ErrorLog $(src)ErrorLog/ErrorLogTest.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EvtColAlg.d

$(bin)$(binobj)EvtColAlg.d :

$(bin)$(binobj)EvtColAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)EvtColAlg.o : $(src)EvtColsEx/EvtColAlg.cpp
	$(cpp_echo) $(src)EvtColsEx/EvtColAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtColAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtColAlg_cppflags) $(EvtColAlg_cpp_cppflags) -I../src/EvtColsEx $(src)EvtColsEx/EvtColAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(EvtColAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)EvtColsEx/EvtColAlg.cpp

$(bin)$(binobj)EvtColAlg.o : $(EvtColAlg_cpp_dependencies)
	$(cpp_echo) $(src)EvtColsEx/EvtColAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(EvtColAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(EvtColAlg_cppflags) $(EvtColAlg_cpp_cppflags) -I../src/EvtColsEx $(src)EvtColsEx/EvtColAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MapAlg.d

$(bin)$(binobj)MapAlg.d :

$(bin)$(binobj)MapAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MapAlg.o : $(src)Maps/MapAlg.cpp
	$(cpp_echo) $(src)Maps/MapAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MapAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MapAlg_cppflags) $(MapAlg_cpp_cppflags) -I../src/Maps $(src)Maps/MapAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MapAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Maps/MapAlg.cpp

$(bin)$(binobj)MapAlg.o : $(MapAlg_cpp_dependencies)
	$(cpp_echo) $(src)Maps/MapAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MapAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MapAlg_cppflags) $(MapAlg_cpp_cppflags) -I../src/Maps $(src)Maps/MapAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QotdAlg.d

$(bin)$(binobj)QotdAlg.d :

$(bin)$(binobj)QotdAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)QotdAlg.o : $(src)MultipleLogStreams/QotdAlg.cpp
	$(cpp_echo) $(src)MultipleLogStreams/QotdAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(QotdAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(QotdAlg_cppflags) $(QotdAlg_cpp_cppflags) -I../src/MultipleLogStreams $(src)MultipleLogStreams/QotdAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(QotdAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)MultipleLogStreams/QotdAlg.cpp

$(bin)$(binobj)QotdAlg.o : $(QotdAlg_cpp_dependencies)
	$(cpp_echo) $(src)MultipleLogStreams/QotdAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(QotdAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(QotdAlg_cppflags) $(QotdAlg_cpp_cppflags) -I../src/MultipleLogStreams $(src)MultipleLogStreams/QotdAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiCommonTests.d

$(bin)$(binobj)GaudiCommonTests.d :

$(bin)$(binobj)GaudiCommonTests.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)GaudiCommonTests.o : $(src)GaudiCommonTests/GaudiCommonTests.cpp
	$(cpp_echo) $(src)GaudiCommonTests/GaudiCommonTests.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiCommonTests_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiCommonTests_cppflags) $(GaudiCommonTests_cpp_cppflags) -I../src/GaudiCommonTests $(src)GaudiCommonTests/GaudiCommonTests.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(GaudiCommonTests_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)GaudiCommonTests/GaudiCommonTests.cpp

$(bin)$(binobj)GaudiCommonTests.o : $(GaudiCommonTests_cpp_dependencies)
	$(cpp_echo) $(src)GaudiCommonTests/GaudiCommonTests.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(GaudiCommonTests_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(GaudiCommonTests_cppflags) $(GaudiCommonTests_cpp_cppflags) -I../src/GaudiCommonTests $(src)GaudiCommonTests/GaudiCommonTests.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IncidentListenerTest.d

$(bin)$(binobj)IncidentListenerTest.d :

$(bin)$(binobj)IncidentListenerTest.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)IncidentListenerTest.o : $(src)IncidentSvc/IncidentListenerTest.cpp
	$(cpp_echo) $(src)IncidentSvc/IncidentListenerTest.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(IncidentListenerTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(IncidentListenerTest_cppflags) $(IncidentListenerTest_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentListenerTest.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(IncidentListenerTest_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IncidentSvc/IncidentListenerTest.cpp

$(bin)$(binobj)IncidentListenerTest.o : $(IncidentListenerTest_cpp_dependencies)
	$(cpp_echo) $(src)IncidentSvc/IncidentListenerTest.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(IncidentListenerTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(IncidentListenerTest_cppflags) $(IncidentListenerTest_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentListenerTest.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IncidentListenerTestAlg.d

$(bin)$(binobj)IncidentListenerTestAlg.d :

$(bin)$(binobj)IncidentListenerTestAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)IncidentListenerTestAlg.o : $(src)IncidentSvc/IncidentListenerTestAlg.cpp
	$(cpp_echo) $(src)IncidentSvc/IncidentListenerTestAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(IncidentListenerTestAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(IncidentListenerTestAlg_cppflags) $(IncidentListenerTestAlg_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentListenerTestAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(IncidentListenerTestAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IncidentSvc/IncidentListenerTestAlg.cpp

$(bin)$(binobj)IncidentListenerTestAlg.o : $(IncidentListenerTestAlg_cpp_dependencies)
	$(cpp_echo) $(src)IncidentSvc/IncidentListenerTestAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(IncidentListenerTestAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(IncidentListenerTestAlg_cppflags) $(IncidentListenerTestAlg_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentListenerTestAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)bug34121_MyAlgorithm.d

$(bin)$(binobj)bug34121_MyAlgorithm.d :

$(bin)$(binobj)bug34121_MyAlgorithm.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)bug34121_MyAlgorithm.o : $(src)bug_34121/bug34121_MyAlgorithm.cpp
	$(cpp_echo) $(src)bug_34121/bug34121_MyAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(bug34121_MyAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(bug34121_MyAlgorithm_cppflags) $(bug34121_MyAlgorithm_cpp_cppflags) -I../src/bug_34121 $(src)bug_34121/bug34121_MyAlgorithm.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(bug34121_MyAlgorithm_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)bug_34121/bug34121_MyAlgorithm.cpp

$(bin)$(binobj)bug34121_MyAlgorithm.o : $(bug34121_MyAlgorithm_cpp_dependencies)
	$(cpp_echo) $(src)bug_34121/bug34121_MyAlgorithm.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(bug34121_MyAlgorithm_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(bug34121_MyAlgorithm_cppflags) $(bug34121_MyAlgorithm_cpp_cppflags) -I../src/bug_34121 $(src)bug_34121/bug34121_MyAlgorithm.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)bug34121_Tool.d

$(bin)$(binobj)bug34121_Tool.d :

$(bin)$(binobj)bug34121_Tool.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)bug34121_Tool.o : $(src)bug_34121/bug34121_Tool.cpp
	$(cpp_echo) $(src)bug_34121/bug34121_Tool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(bug34121_Tool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(bug34121_Tool_cppflags) $(bug34121_Tool_cpp_cppflags) -I../src/bug_34121 $(src)bug_34121/bug34121_Tool.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(bug34121_Tool_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)bug_34121/bug34121_Tool.cpp

$(bin)$(binobj)bug34121_Tool.o : $(bug34121_Tool_cpp_dependencies)
	$(cpp_echo) $(src)bug_34121/bug34121_Tool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(bug34121_Tool_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(bug34121_Tool_cppflags) $(bug34121_Tool_cpp_cppflags) -I../src/bug_34121 $(src)bug_34121/bug34121_Tool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AuditorTestAlg.d

$(bin)$(binobj)AuditorTestAlg.d :

$(bin)$(binobj)AuditorTestAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)AuditorTestAlg.o : $(src)Auditors/AuditorTestAlg.cpp
	$(cpp_echo) $(src)Auditors/AuditorTestAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(AuditorTestAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(AuditorTestAlg_cppflags) $(AuditorTestAlg_cpp_cppflags) -I../src/Auditors $(src)Auditors/AuditorTestAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(AuditorTestAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Auditors/AuditorTestAlg.cpp

$(bin)$(binobj)AuditorTestAlg.o : $(AuditorTestAlg_cpp_dependencies)
	$(cpp_echo) $(src)Auditors/AuditorTestAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(AuditorTestAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(AuditorTestAlg_cppflags) $(AuditorTestAlg_cpp_cppflags) -I../src/Auditors $(src)Auditors/AuditorTestAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LoggingAuditor.d

$(bin)$(binobj)LoggingAuditor.d :

$(bin)$(binobj)LoggingAuditor.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)LoggingAuditor.o : $(src)Auditors/LoggingAuditor.cpp
	$(cpp_echo) $(src)Auditors/LoggingAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(LoggingAuditor_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(LoggingAuditor_cppflags) $(LoggingAuditor_cpp_cppflags) -I../src/Auditors $(src)Auditors/LoggingAuditor.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(LoggingAuditor_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Auditors/LoggingAuditor.cpp

$(bin)$(binobj)LoggingAuditor.o : $(LoggingAuditor_cpp_dependencies)
	$(cpp_echo) $(src)Auditors/LoggingAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(LoggingAuditor_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(LoggingAuditor_cppflags) $(LoggingAuditor_cpp_cppflags) -I../src/Auditors $(src)Auditors/LoggingAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimingAlg.d

$(bin)$(binobj)TimingAlg.d :

$(bin)$(binobj)TimingAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TimingAlg.o : $(src)Timing/TimingAlg.cpp
	$(cpp_echo) $(src)Timing/TimingAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TimingAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TimingAlg_cppflags) $(TimingAlg_cpp_cppflags) -I../src/Timing $(src)Timing/TimingAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TimingAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Timing/TimingAlg.cpp

$(bin)$(binobj)TimingAlg.o : $(TimingAlg_cpp_dependencies)
	$(cpp_echo) $(src)Timing/TimingAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TimingAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TimingAlg_cppflags) $(TimingAlg_cpp_cppflags) -I../src/Timing $(src)Timing/TimingAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SelCreate.d

$(bin)$(binobj)SelCreate.d :

$(bin)$(binobj)SelCreate.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)SelCreate.o : $(src)Selections/SelCreate.cpp
	$(cpp_echo) $(src)Selections/SelCreate.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SelCreate_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SelCreate_cppflags) $(SelCreate_cpp_cppflags) -I../src/Selections $(src)Selections/SelCreate.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(SelCreate_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Selections/SelCreate.cpp

$(bin)$(binobj)SelCreate.o : $(SelCreate_cpp_dependencies)
	$(cpp_echo) $(src)Selections/SelCreate.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SelCreate_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SelCreate_cppflags) $(SelCreate_cpp_cppflags) -I../src/Selections $(src)Selections/SelCreate.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SelFilter.d

$(bin)$(binobj)SelFilter.d :

$(bin)$(binobj)SelFilter.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)SelFilter.o : $(src)Selections/SelFilter.cpp
	$(cpp_echo) $(src)Selections/SelFilter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SelFilter_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SelFilter_cppflags) $(SelFilter_cpp_cppflags) -I../src/Selections $(src)Selections/SelFilter.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(SelFilter_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)Selections/SelFilter.cpp

$(bin)$(binobj)SelFilter.o : $(SelFilter_cpp_dependencies)
	$(cpp_echo) $(src)Selections/SelFilter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SelFilter_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SelFilter_cppflags) $(SelFilter_cpp_cppflags) -I../src/Selections $(src)Selections/SelFilter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)LoopAlg.d

$(bin)$(binobj)LoopAlg.d :

$(bin)$(binobj)LoopAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)LoopAlg.o : $(src)SvcInitLoop/LoopAlg.cpp
	$(cpp_echo) $(src)SvcInitLoop/LoopAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(LoopAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(LoopAlg_cppflags) $(LoopAlg_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/LoopAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(LoopAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)SvcInitLoop/LoopAlg.cpp

$(bin)$(binobj)LoopAlg.o : $(LoopAlg_cpp_dependencies)
	$(cpp_echo) $(src)SvcInitLoop/LoopAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(LoopAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(LoopAlg_cppflags) $(LoopAlg_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/LoopAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceA.d

$(bin)$(binobj)ServiceA.d :

$(bin)$(binobj)ServiceA.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ServiceA.o : $(src)SvcInitLoop/ServiceA.cpp
	$(cpp_echo) $(src)SvcInitLoop/ServiceA.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ServiceA_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ServiceA_cppflags) $(ServiceA_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/ServiceA.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ServiceA_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)SvcInitLoop/ServiceA.cpp

$(bin)$(binobj)ServiceA.o : $(ServiceA_cpp_dependencies)
	$(cpp_echo) $(src)SvcInitLoop/ServiceA.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ServiceA_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ServiceA_cppflags) $(ServiceA_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/ServiceA.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceB.d

$(bin)$(binobj)ServiceB.d :

$(bin)$(binobj)ServiceB.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)ServiceB.o : $(src)SvcInitLoop/ServiceB.cpp
	$(cpp_echo) $(src)SvcInitLoop/ServiceB.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ServiceB_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ServiceB_cppflags) $(ServiceB_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/ServiceB.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(ServiceB_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)SvcInitLoop/ServiceB.cpp

$(bin)$(binobj)ServiceB.o : $(ServiceB_cpp_dependencies)
	$(cpp_echo) $(src)SvcInitLoop/ServiceB.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(ServiceB_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(ServiceB_cppflags) $(ServiceB_cpp_cppflags) -I../src/SvcInitLoop $(src)SvcInitLoop/ServiceB.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)StringKeyEx.d

$(bin)$(binobj)StringKeyEx.d :

$(bin)$(binobj)StringKeyEx.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)StringKeyEx.o : $(src)StringKeys/StringKeyEx.cpp
	$(cpp_echo) $(src)StringKeys/StringKeyEx.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StringKeyEx_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StringKeyEx_cppflags) $(StringKeyEx_cpp_cppflags) -I../src/StringKeys $(src)StringKeys/StringKeyEx.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(StringKeyEx_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)StringKeys/StringKeyEx.cpp

$(bin)$(binobj)StringKeyEx.o : $(StringKeyEx_cpp_dependencies)
	$(cpp_echo) $(src)StringKeys/StringKeyEx.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(StringKeyEx_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(StringKeyEx_cppflags) $(StringKeyEx_cpp_cppflags) -I../src/StringKeys $(src)StringKeys/StringKeyEx.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SCSAlg.d

$(bin)$(binobj)SCSAlg.d :

$(bin)$(binobj)SCSAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)SCSAlg.o : $(src)StatusCodeSvc/SCSAlg.cpp
	$(cpp_echo) $(src)StatusCodeSvc/SCSAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SCSAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SCSAlg_cppflags) $(SCSAlg_cpp_cppflags) -I../src/StatusCodeSvc $(src)StatusCodeSvc/SCSAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(SCSAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)StatusCodeSvc/SCSAlg.cpp

$(bin)$(binobj)SCSAlg.o : $(SCSAlg_cpp_dependencies)
	$(cpp_echo) $(src)StatusCodeSvc/SCSAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(SCSAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(SCSAlg_cppflags) $(SCSAlg_cpp_cppflags) -I../src/StatusCodeSvc $(src)StatusCodeSvc/SCSAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileMgrTest.d

$(bin)$(binobj)FileMgrTest.d :

$(bin)$(binobj)FileMgrTest.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)FileMgrTest.o : $(src)FileMgr/FileMgrTest.cpp
	$(cpp_echo) $(src)FileMgr/FileMgrTest.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FileMgrTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FileMgrTest_cppflags) $(FileMgrTest_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/FileMgrTest.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(FileMgrTest_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)FileMgr/FileMgrTest.cpp

$(bin)$(binobj)FileMgrTest.o : $(FileMgrTest_cpp_dependencies)
	$(cpp_echo) $(src)FileMgr/FileMgrTest.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(FileMgrTest_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(FileMgrTest_cppflags) $(FileMgrTest_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/FileMgrTest.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestingSvcs.d

$(bin)$(binobj)TestingSvcs.d :

$(bin)$(binobj)TestingSvcs.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestingSvcs.o : $(src)testing/TestingSvcs.cpp
	$(cpp_echo) $(src)testing/TestingSvcs.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestingSvcs_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestingSvcs_cppflags) $(TestingSvcs_cpp_cppflags) -I../src/testing $(src)testing/TestingSvcs.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestingSvcs_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)testing/TestingSvcs.cpp

$(bin)$(binobj)TestingSvcs.o : $(TestingSvcs_cpp_dependencies)
	$(cpp_echo) $(src)testing/TestingSvcs.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestingSvcs_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestingSvcs_cppflags) $(TestingSvcs_cpp_cppflags) -I../src/testing $(src)testing/TestingSvcs.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TestingAlgs.d

$(bin)$(binobj)TestingAlgs.d :

$(bin)$(binobj)TestingAlgs.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)TestingAlgs.o : $(src)testing/TestingAlgs.cpp
	$(cpp_echo) $(src)testing/TestingAlgs.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestingAlgs_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestingAlgs_cppflags) $(TestingAlgs_cpp_cppflags) -I../src/testing $(src)testing/TestingAlgs.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(TestingAlgs_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)testing/TestingAlgs.cpp

$(bin)$(binobj)TestingAlgs.o : $(TestingAlgs_cpp_dependencies)
	$(cpp_echo) $(src)testing/TestingAlgs.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(TestingAlgs_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(TestingAlgs_cppflags) $(TestingAlgs_cpp_cppflags) -I../src/testing $(src)testing/TestingAlgs.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CpuHungryAlg.d

$(bin)$(binobj)CpuHungryAlg.d :

$(bin)$(binobj)CpuHungryAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)CpuHungryAlg.o : $(src)IntelProfiler/CpuHungryAlg.cpp
	$(cpp_echo) $(src)IntelProfiler/CpuHungryAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CpuHungryAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CpuHungryAlg_cppflags) $(CpuHungryAlg_cpp_cppflags) -I../src/IntelProfiler $(src)IntelProfiler/CpuHungryAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(CpuHungryAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)IntelProfiler/CpuHungryAlg.cpp

$(bin)$(binobj)CpuHungryAlg.o : $(CpuHungryAlg_cpp_dependencies)
	$(cpp_echo) $(src)IntelProfiler/CpuHungryAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(CpuHungryAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(CpuHungryAlg_cppflags) $(CpuHungryAlg_cpp_cppflags) -I../src/IntelProfiler $(src)IntelProfiler/CpuHungryAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BackwardCompatibleAliases.d

$(bin)$(binobj)BackwardCompatibleAliases.d :

$(bin)$(binobj)BackwardCompatibleAliases.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)BackwardCompatibleAliases.o : $(src)PluginService/BackwardCompatibleAliases.cpp
	$(cpp_echo) $(src)PluginService/BackwardCompatibleAliases.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(BackwardCompatibleAliases_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(BackwardCompatibleAliases_cppflags) $(BackwardCompatibleAliases_cpp_cppflags) -I../src/PluginService $(src)PluginService/BackwardCompatibleAliases.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(BackwardCompatibleAliases_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)PluginService/BackwardCompatibleAliases.cpp

$(bin)$(binobj)BackwardCompatibleAliases.o : $(BackwardCompatibleAliases_cpp_dependencies)
	$(cpp_echo) $(src)PluginService/BackwardCompatibleAliases.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(BackwardCompatibleAliases_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(BackwardCompatibleAliases_cppflags) $(BackwardCompatibleAliases_cpp_cppflags) -I../src/PluginService $(src)PluginService/BackwardCompatibleAliases.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)UseCases.d

$(bin)$(binobj)UseCases.d :

$(bin)$(binobj)UseCases.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)UseCases.o : $(src)PluginService/UseCases.cpp
	$(cpp_echo) $(src)PluginService/UseCases.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(UseCases_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(UseCases_cppflags) $(UseCases_cpp_cppflags) -I../src/PluginService $(src)PluginService/UseCases.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(UseCases_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)PluginService/UseCases.cpp

$(bin)$(binobj)UseCases.o : $(UseCases_cpp_dependencies)
	$(cpp_echo) $(src)PluginService/UseCases.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(UseCases_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(UseCases_cppflags) $(UseCases_cpp_cppflags) -I../src/PluginService $(src)PluginService/UseCases.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DumpAddress.d

$(bin)$(binobj)DumpAddress.d :

$(bin)$(binobj)DumpAddress.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)DumpAddress.o : $(src)MultiInput/DumpAddress.cpp
	$(cpp_echo) $(src)MultiInput/DumpAddress.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(DumpAddress_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(DumpAddress_cppflags) $(DumpAddress_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/DumpAddress.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(DumpAddress_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)MultiInput/DumpAddress.cpp

$(bin)$(binobj)DumpAddress.o : $(DumpAddress_cpp_dependencies)
	$(cpp_echo) $(src)MultiInput/DumpAddress.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(DumpAddress_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(DumpAddress_cppflags) $(DumpAddress_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/DumpAddress.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MIWriteAlg.d

$(bin)$(binobj)MIWriteAlg.d :

$(bin)$(binobj)MIWriteAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MIWriteAlg.o : $(src)MultiInput/MIWriteAlg.cpp
	$(cpp_echo) $(src)MultiInput/MIWriteAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MIWriteAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MIWriteAlg_cppflags) $(MIWriteAlg_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/MIWriteAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MIWriteAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)MultiInput/MIWriteAlg.cpp

$(bin)$(binobj)MIWriteAlg.o : $(MIWriteAlg_cpp_dependencies)
	$(cpp_echo) $(src)MultiInput/MIWriteAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MIWriteAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MIWriteAlg_cppflags) $(MIWriteAlg_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/MIWriteAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MIReadAlg.d

$(bin)$(binobj)MIReadAlg.d :

$(bin)$(binobj)MIReadAlg.o : $(cmt_final_setup_GaudiExamples)

$(bin)$(binobj)MIReadAlg.o : $(src)MultiInput/MIReadAlg.cpp
	$(cpp_echo) $(src)MultiInput/MIReadAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MIReadAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MIReadAlg_cppflags) $(MIReadAlg_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/MIReadAlg.cpp
endif
endif

else
$(bin)GaudiExamples_dependencies.make : $(MIReadAlg_cpp_dependencies)

$(bin)GaudiExamples_dependencies.make : $(src)MultiInput/MIReadAlg.cpp

$(bin)$(binobj)MIReadAlg.o : $(MIReadAlg_cpp_dependencies)
	$(cpp_echo) $(src)MultiInput/MIReadAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamples_pp_cppflags) $(lib_GaudiExamples_pp_cppflags) $(MIReadAlg_pp_cppflags) $(use_cppflags) $(GaudiExamples_cppflags) $(lib_GaudiExamples_cppflags) $(MIReadAlg_cppflags) $(MIReadAlg_cpp_cppflags) -I../src/MultiInput $(src)MultiInput/MIReadAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiExamplesclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamples.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiExamples
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiExamples$(library_suffix).a $(library_prefix)GaudiExamples$(library_suffix).$(shlibsuffix) GaudiExamples.stamp GaudiExamples.shstamp
#-- end of cleanup_library ---------------
