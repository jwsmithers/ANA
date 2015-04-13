#-- start of make_header -----------------

#====================================
#  Library lcg_RelationalCool
#
#   Generated Tue Mar 31 09:54:25 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_RelationalCool_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_RelationalCool_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_RelationalCool

RelationalCool_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalCool = $(RelationalCool_tag)_lcg_RelationalCool.make
cmt_local_tagfile_lcg_RelationalCool = $(bin)$(RelationalCool_tag)_lcg_RelationalCool.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RelationalCool_tag = $(tag)

#cmt_local_tagfile_lcg_RelationalCool = $(RelationalCool_tag).make
cmt_local_tagfile_lcg_RelationalCool = $(bin)$(RelationalCool_tag).make

endif

include $(cmt_local_tagfile_lcg_RelationalCool)
#-include $(cmt_local_tagfile_lcg_RelationalCool)

ifdef cmt_lcg_RelationalCool_has_target_tag

cmt_final_setup_lcg_RelationalCool = $(bin)setup_lcg_RelationalCool.make
cmt_dependencies_in_lcg_RelationalCool = $(bin)dependencies_lcg_RelationalCool.in
#cmt_final_setup_lcg_RelationalCool = $(bin)RelationalCool_lcg_RelationalCoolsetup.make
cmt_local_lcg_RelationalCool_makefile = $(bin)lcg_RelationalCool.make

else

cmt_final_setup_lcg_RelationalCool = $(bin)setup.make
cmt_dependencies_in_lcg_RelationalCool = $(bin)dependencies.in
#cmt_final_setup_lcg_RelationalCool = $(bin)RelationalCoolsetup.make
cmt_local_lcg_RelationalCool_makefile = $(bin)lcg_RelationalCool.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RelationalCoolsetup.make

#lcg_RelationalCool :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_RelationalCool'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_RelationalCool/
#lcg_RelationalCool::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_RelationalCoollibname   = $(bin)$(library_prefix)lcg_RelationalCool$(library_suffix)
lcg_RelationalCoollib       = $(lcg_RelationalCoollibname).a
lcg_RelationalCoolstamp     = $(bin)lcg_RelationalCool.stamp
lcg_RelationalCoolshstamp   = $(bin)lcg_RelationalCool.shstamp

lcg_RelationalCool :: dirs  lcg_RelationalCoolLIB
	$(echo) "lcg_RelationalCool ok"

cmt_lcg_RelationalCool_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_RelationalCool_has_prototypes

lcg_RelationalCoolprototype :  ;

endif

lcg_RelationalCoolcompile : $(bin)RalDatabaseSvc.o $(bin)RelationalNodeTable.o $(bin)RelationalQueryDefinition.o $(bin)HvsPathHandler.o $(bin)RelationalDatabaseId.o $(bin)CoralConnectionServiceProxy.o $(bin)RalDatabase.o $(bin)RelationalFolderUnsupported.o $(bin)TimingReportMgr.o $(bin)sigsegv.o $(bin)RelationalChannelTable.o $(bin)RelationalGlobalTagTable.o $(bin)RelationalNodeMgr.o $(bin)TransRelFolderSet.o $(bin)SealUtil_TimingItem.o $(bin)RelationalPayloadQuery.o $(bin)RelationalTransaction.o $(bin)TransRalDatabase.o $(bin)RelationalTagTable.o $(bin)ObjectIteratorCounter.o $(bin)CoolChrono.o $(bin)RelationalTableRow.o $(bin)TransRelHvsNode.o $(bin)RelationalSchemaMgr.o $(bin)RelationalFolder.o $(bin)RelationalException.o $(bin)RelationalFolderSetUnsupported.o $(bin)RelationalDatabase.o $(bin)RelationalSequenceTable.o $(bin)SealUtil_SealTimer.o $(bin)SealBase_TimeInfo.o $(bin)RelationalHvsNodeRecord.o $(bin)ObjectVectorIterator.o $(bin)RelationalObject.o $(bin)RelationalTableRowBase.o $(bin)RelationalObjectMgr.o $(bin)RelationalObjectTable.o $(bin)RalTransactionMgr.o $(bin)PyCool_helpers.o $(bin)DummyTransactionMgr.o $(bin)RelationalObject2TagTable.o $(bin)RelationalGlobalHeadTagTable.o $(bin)RelationalPayloadTableRow.o $(bin)RelationalHvsNode.o $(bin)RelationalObjectIterator.o $(bin)RelationalSharedSequenceTable.o $(bin)ConstRecordIterator.o $(bin)RalSequenceMgr.o $(bin)RelationalTagMgr.o $(bin)RelationalFolderSet.o $(bin)RalSchemaMgr.o $(bin)RelationalPayloadTable.o $(bin)RelationalDatabaseTable.o $(bin)RalSessionMgr.o $(bin)ConstRelationalObjectAdapter.o $(bin)ConstTimeAdapter.o $(bin)TransRelObjectIterator.o $(bin)RelationalHvsTagRecord.o $(bin)RelationalTag2TagTable.o $(bin)RelationalSequence.o $(bin)RelationalChannelTablesTable.o $(bin)RecordVectorIterator.o $(bin)TimingReport.o $(bin)ManualTransaction.o $(bin)ObjectId.o $(bin)RelationalObjectTableRow.o $(bin)RelationalSequenceMgr.o $(bin)RelationalIovTablesTable.o $(bin)RelationalGlobalUserTagTable.o $(bin)TransRelFolder.o $(bin)RelationalQueryMgr.o $(bin)CoralApplication.o $(bin)RalQueryMgr.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_RelationalCoolLIB :: $(lcg_RelationalCoollib) $(lcg_RelationalCoolshstamp)
	@/bin/echo "------> lcg_RelationalCool : library ok"

$(lcg_RelationalCoollib) :: $(bin)RalDatabaseSvc.o $(bin)RelationalNodeTable.o $(bin)RelationalQueryDefinition.o $(bin)HvsPathHandler.o $(bin)RelationalDatabaseId.o $(bin)CoralConnectionServiceProxy.o $(bin)RalDatabase.o $(bin)RelationalFolderUnsupported.o $(bin)TimingReportMgr.o $(bin)sigsegv.o $(bin)RelationalChannelTable.o $(bin)RelationalGlobalTagTable.o $(bin)RelationalNodeMgr.o $(bin)TransRelFolderSet.o $(bin)SealUtil_TimingItem.o $(bin)RelationalPayloadQuery.o $(bin)RelationalTransaction.o $(bin)TransRalDatabase.o $(bin)RelationalTagTable.o $(bin)ObjectIteratorCounter.o $(bin)CoolChrono.o $(bin)RelationalTableRow.o $(bin)TransRelHvsNode.o $(bin)RelationalSchemaMgr.o $(bin)RelationalFolder.o $(bin)RelationalException.o $(bin)RelationalFolderSetUnsupported.o $(bin)RelationalDatabase.o $(bin)RelationalSequenceTable.o $(bin)SealUtil_SealTimer.o $(bin)SealBase_TimeInfo.o $(bin)RelationalHvsNodeRecord.o $(bin)ObjectVectorIterator.o $(bin)RelationalObject.o $(bin)RelationalTableRowBase.o $(bin)RelationalObjectMgr.o $(bin)RelationalObjectTable.o $(bin)RalTransactionMgr.o $(bin)PyCool_helpers.o $(bin)DummyTransactionMgr.o $(bin)RelationalObject2TagTable.o $(bin)RelationalGlobalHeadTagTable.o $(bin)RelationalPayloadTableRow.o $(bin)RelationalHvsNode.o $(bin)RelationalObjectIterator.o $(bin)RelationalSharedSequenceTable.o $(bin)ConstRecordIterator.o $(bin)RalSequenceMgr.o $(bin)RelationalTagMgr.o $(bin)RelationalFolderSet.o $(bin)RalSchemaMgr.o $(bin)RelationalPayloadTable.o $(bin)RelationalDatabaseTable.o $(bin)RalSessionMgr.o $(bin)ConstRelationalObjectAdapter.o $(bin)ConstTimeAdapter.o $(bin)TransRelObjectIterator.o $(bin)RelationalHvsTagRecord.o $(bin)RelationalTag2TagTable.o $(bin)RelationalSequence.o $(bin)RelationalChannelTablesTable.o $(bin)RecordVectorIterator.o $(bin)TimingReport.o $(bin)ManualTransaction.o $(bin)ObjectId.o $(bin)RelationalObjectTableRow.o $(bin)RelationalSequenceMgr.o $(bin)RelationalIovTablesTable.o $(bin)RelationalGlobalUserTagTable.o $(bin)TransRelFolder.o $(bin)RelationalQueryMgr.o $(bin)CoralApplication.o $(bin)RalQueryMgr.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_RelationalCoollib) $?
	$(lib_silent) $(ranlib) $(lcg_RelationalCoollib)
	$(lib_silent) cat /dev/null >$(lcg_RelationalCoolstamp)

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

$(lcg_RelationalCoollibname).$(shlibsuffix) :: $(lcg_RelationalCoollib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_RelationalCool $(lcg_RelationalCool_shlibflags)

$(lcg_RelationalCoolshstamp) :: $(lcg_RelationalCoollibname).$(shlibsuffix)
	@if test -f $(lcg_RelationalCoollibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_RelationalCoolshstamp) ; fi

lcg_RelationalCoolclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)RalDatabaseSvc.o $(bin)RelationalNodeTable.o $(bin)RelationalQueryDefinition.o $(bin)HvsPathHandler.o $(bin)RelationalDatabaseId.o $(bin)CoralConnectionServiceProxy.o $(bin)RalDatabase.o $(bin)RelationalFolderUnsupported.o $(bin)TimingReportMgr.o $(bin)sigsegv.o $(bin)RelationalChannelTable.o $(bin)RelationalGlobalTagTable.o $(bin)RelationalNodeMgr.o $(bin)TransRelFolderSet.o $(bin)SealUtil_TimingItem.o $(bin)RelationalPayloadQuery.o $(bin)RelationalTransaction.o $(bin)TransRalDatabase.o $(bin)RelationalTagTable.o $(bin)ObjectIteratorCounter.o $(bin)CoolChrono.o $(bin)RelationalTableRow.o $(bin)TransRelHvsNode.o $(bin)RelationalSchemaMgr.o $(bin)RelationalFolder.o $(bin)RelationalException.o $(bin)RelationalFolderSetUnsupported.o $(bin)RelationalDatabase.o $(bin)RelationalSequenceTable.o $(bin)SealUtil_SealTimer.o $(bin)SealBase_TimeInfo.o $(bin)RelationalHvsNodeRecord.o $(bin)ObjectVectorIterator.o $(bin)RelationalObject.o $(bin)RelationalTableRowBase.o $(bin)RelationalObjectMgr.o $(bin)RelationalObjectTable.o $(bin)RalTransactionMgr.o $(bin)PyCool_helpers.o $(bin)DummyTransactionMgr.o $(bin)RelationalObject2TagTable.o $(bin)RelationalGlobalHeadTagTable.o $(bin)RelationalPayloadTableRow.o $(bin)RelationalHvsNode.o $(bin)RelationalObjectIterator.o $(bin)RelationalSharedSequenceTable.o $(bin)ConstRecordIterator.o $(bin)RalSequenceMgr.o $(bin)RelationalTagMgr.o $(bin)RelationalFolderSet.o $(bin)RalSchemaMgr.o $(bin)RelationalPayloadTable.o $(bin)RelationalDatabaseTable.o $(bin)RalSessionMgr.o $(bin)ConstRelationalObjectAdapter.o $(bin)ConstTimeAdapter.o $(bin)TransRelObjectIterator.o $(bin)RelationalHvsTagRecord.o $(bin)RelationalTag2TagTable.o $(bin)RelationalSequence.o $(bin)RelationalChannelTablesTable.o $(bin)RecordVectorIterator.o $(bin)TimingReport.o $(bin)ManualTransaction.o $(bin)ObjectId.o $(bin)RelationalObjectTableRow.o $(bin)RelationalSequenceMgr.o $(bin)RelationalIovTablesTable.o $(bin)RelationalGlobalUserTagTable.o $(bin)TransRelFolder.o $(bin)RelationalQueryMgr.o $(bin)CoralApplication.o $(bin)RalQueryMgr.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_RelationalCoolinstallname = $(library_prefix)lcg_RelationalCool$(library_suffix).$(shlibsuffix)

lcg_RelationalCool :: lcg_RelationalCoolinstall

install :: lcg_RelationalCoolinstall

lcg_RelationalCoolinstall :: $(install_dir)/$(lcg_RelationalCoolinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_RelationalCoolinstallname) :: $(bin)$(lcg_RelationalCoolinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalCoolinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_RelationalCoolclean :: lcg_RelationalCooluninstall

uninstall :: lcg_RelationalCooluninstall

lcg_RelationalCooluninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_RelationalCoolinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_RelationalCoolprototype)

$(bin)lcg_RelationalCool_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_RelationalCool)
	$(echo) "(lcg_RelationalCool.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)RalDatabaseSvc.cpp $(src)RelationalNodeTable.cpp $(src)RelationalQueryDefinition.cpp $(src)HvsPathHandler.cpp $(src)RelationalDatabaseId.cpp $(src)CoralConnectionServiceProxy.cpp $(src)RalDatabase.cpp $(src)RelationalFolderUnsupported.cpp $(src)TimingReportMgr.cpp $(src)sigsegv.cpp $(src)RelationalChannelTable.cpp $(src)RelationalGlobalTagTable.cpp $(src)RelationalNodeMgr.cpp $(src)TransRelFolderSet.cpp $(src)SealUtil_TimingItem.cpp $(src)RelationalPayloadQuery.cpp $(src)RelationalTransaction.cpp $(src)TransRalDatabase.cpp $(src)RelationalTagTable.cpp $(src)ObjectIteratorCounter.cpp $(src)CoolChrono.cpp $(src)RelationalTableRow.cpp $(src)TransRelHvsNode.cpp $(src)RelationalSchemaMgr.cpp $(src)RelationalFolder.cpp $(src)RelationalException.cpp $(src)RelationalFolderSetUnsupported.cpp $(src)RelationalDatabase.cpp $(src)RelationalSequenceTable.cpp $(src)SealUtil_SealTimer.cpp $(src)SealBase_TimeInfo.cpp $(src)RelationalHvsNodeRecord.cpp $(src)ObjectVectorIterator.cpp $(src)RelationalObject.cpp $(src)RelationalTableRowBase.cpp $(src)RelationalObjectMgr.cpp $(src)RelationalObjectTable.cpp $(src)RalTransactionMgr.cpp $(src)PyCool_helpers.cpp $(src)DummyTransactionMgr.cpp $(src)RelationalObject2TagTable.cpp $(src)RelationalGlobalHeadTagTable.cpp $(src)RelationalPayloadTableRow.cpp $(src)RelationalHvsNode.cpp $(src)RelationalObjectIterator.cpp $(src)RelationalSharedSequenceTable.cpp $(src)ConstRecordIterator.cpp $(src)RalSequenceMgr.cpp $(src)RelationalTagMgr.cpp $(src)RelationalFolderSet.cpp $(src)RalSchemaMgr.cpp $(src)RelationalPayloadTable.cpp $(src)RelationalDatabaseTable.cpp $(src)RalSessionMgr.cpp $(src)ConstRelationalObjectAdapter.cpp $(src)ConstTimeAdapter.cpp $(src)TransRelObjectIterator.cpp $(src)RelationalHvsTagRecord.cpp $(src)RelationalTag2TagTable.cpp $(src)RelationalSequence.cpp $(src)RelationalChannelTablesTable.cpp $(src)RecordVectorIterator.cpp $(src)TimingReport.cpp $(src)ManualTransaction.cpp $(src)ObjectId.cpp $(src)RelationalObjectTableRow.cpp $(src)RelationalSequenceMgr.cpp $(src)RelationalIovTablesTable.cpp $(src)RelationalGlobalUserTagTable.cpp $(src)TransRelFolder.cpp $(src)RelationalQueryMgr.cpp $(src)CoralApplication.cpp $(src)RalQueryMgr.cpp -end_all $(includes) $(app_lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) -name=lcg_RelationalCool $? -f=$(cmt_dependencies_in_lcg_RelationalCool) -without_cmt

-include $(bin)lcg_RelationalCool_dependencies.make

endif
endif
endif

lcg_RelationalCoolclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_RelationalCool_deps $(bin)lcg_RelationalCool_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalDatabaseSvc.d

$(bin)$(binobj)RalDatabaseSvc.d :

$(bin)$(binobj)RalDatabaseSvc.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalDatabaseSvc.o : $(src)RalDatabaseSvc.cpp
	$(cpp_echo) $(src)RalDatabaseSvc.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalDatabaseSvc_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalDatabaseSvc_cppflags) $(RalDatabaseSvc_cpp_cppflags)  $(src)RalDatabaseSvc.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalDatabaseSvc_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalDatabaseSvc.cpp

$(bin)$(binobj)RalDatabaseSvc.o : $(RalDatabaseSvc_cpp_dependencies)
	$(cpp_echo) $(src)RalDatabaseSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalDatabaseSvc_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalDatabaseSvc_cppflags) $(RalDatabaseSvc_cpp_cppflags)  $(src)RalDatabaseSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalNodeTable.d

$(bin)$(binobj)RelationalNodeTable.d :

$(bin)$(binobj)RelationalNodeTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalNodeTable.o : $(src)RelationalNodeTable.cpp
	$(cpp_echo) $(src)RelationalNodeTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalNodeTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalNodeTable_cppflags) $(RelationalNodeTable_cpp_cppflags)  $(src)RelationalNodeTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalNodeTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalNodeTable.cpp

$(bin)$(binobj)RelationalNodeTable.o : $(RelationalNodeTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalNodeTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalNodeTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalNodeTable_cppflags) $(RelationalNodeTable_cpp_cppflags)  $(src)RelationalNodeTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalQueryDefinition.d

$(bin)$(binobj)RelationalQueryDefinition.d :

$(bin)$(binobj)RelationalQueryDefinition.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalQueryDefinition.o : $(src)RelationalQueryDefinition.cpp
	$(cpp_echo) $(src)RelationalQueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalQueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalQueryDefinition_cppflags) $(RelationalQueryDefinition_cpp_cppflags)  $(src)RelationalQueryDefinition.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalQueryDefinition_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalQueryDefinition.cpp

$(bin)$(binobj)RelationalQueryDefinition.o : $(RelationalQueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)RelationalQueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalQueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalQueryDefinition_cppflags) $(RelationalQueryDefinition_cpp_cppflags)  $(src)RelationalQueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HvsPathHandler.d

$(bin)$(binobj)HvsPathHandler.d :

$(bin)$(binobj)HvsPathHandler.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)HvsPathHandler.o : $(src)HvsPathHandler.cpp
	$(cpp_echo) $(src)HvsPathHandler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(HvsPathHandler_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(HvsPathHandler_cppflags) $(HvsPathHandler_cpp_cppflags)  $(src)HvsPathHandler.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(HvsPathHandler_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)HvsPathHandler.cpp

$(bin)$(binobj)HvsPathHandler.o : $(HvsPathHandler_cpp_dependencies)
	$(cpp_echo) $(src)HvsPathHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(HvsPathHandler_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(HvsPathHandler_cppflags) $(HvsPathHandler_cpp_cppflags)  $(src)HvsPathHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalDatabaseId.d

$(bin)$(binobj)RelationalDatabaseId.d :

$(bin)$(binobj)RelationalDatabaseId.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalDatabaseId.o : $(src)RelationalDatabaseId.cpp
	$(cpp_echo) $(src)RelationalDatabaseId.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabaseId_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabaseId_cppflags) $(RelationalDatabaseId_cpp_cppflags)  $(src)RelationalDatabaseId.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalDatabaseId_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalDatabaseId.cpp

$(bin)$(binobj)RelationalDatabaseId.o : $(RelationalDatabaseId_cpp_dependencies)
	$(cpp_echo) $(src)RelationalDatabaseId.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabaseId_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabaseId_cppflags) $(RelationalDatabaseId_cpp_cppflags)  $(src)RelationalDatabaseId.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralConnectionServiceProxy.d

$(bin)$(binobj)CoralConnectionServiceProxy.d :

$(bin)$(binobj)CoralConnectionServiceProxy.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)CoralConnectionServiceProxy.o : $(src)CoralConnectionServiceProxy.cpp
	$(cpp_echo) $(src)CoralConnectionServiceProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoralConnectionServiceProxy_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoralConnectionServiceProxy_cppflags) $(CoralConnectionServiceProxy_cpp_cppflags)  $(src)CoralConnectionServiceProxy.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(CoralConnectionServiceProxy_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)CoralConnectionServiceProxy.cpp

$(bin)$(binobj)CoralConnectionServiceProxy.o : $(CoralConnectionServiceProxy_cpp_dependencies)
	$(cpp_echo) $(src)CoralConnectionServiceProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoralConnectionServiceProxy_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoralConnectionServiceProxy_cppflags) $(CoralConnectionServiceProxy_cpp_cppflags)  $(src)CoralConnectionServiceProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalDatabase.d

$(bin)$(binobj)RalDatabase.d :

$(bin)$(binobj)RalDatabase.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalDatabase.o : $(src)RalDatabase.cpp
	$(cpp_echo) $(src)RalDatabase.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalDatabase_cppflags) $(RalDatabase_cpp_cppflags)  $(src)RalDatabase.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalDatabase_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalDatabase.cpp

$(bin)$(binobj)RalDatabase.o : $(RalDatabase_cpp_dependencies)
	$(cpp_echo) $(src)RalDatabase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalDatabase_cppflags) $(RalDatabase_cpp_cppflags)  $(src)RalDatabase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalFolderUnsupported.d

$(bin)$(binobj)RelationalFolderUnsupported.d :

$(bin)$(binobj)RelationalFolderUnsupported.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalFolderUnsupported.o : $(src)RelationalFolderUnsupported.cpp
	$(cpp_echo) $(src)RelationalFolderUnsupported.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderUnsupported_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderUnsupported_cppflags) $(RelationalFolderUnsupported_cpp_cppflags)  $(src)RelationalFolderUnsupported.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalFolderUnsupported_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalFolderUnsupported.cpp

$(bin)$(binobj)RelationalFolderUnsupported.o : $(RelationalFolderUnsupported_cpp_dependencies)
	$(cpp_echo) $(src)RelationalFolderUnsupported.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderUnsupported_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderUnsupported_cppflags) $(RelationalFolderUnsupported_cpp_cppflags)  $(src)RelationalFolderUnsupported.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimingReportMgr.d

$(bin)$(binobj)TimingReportMgr.d :

$(bin)$(binobj)TimingReportMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TimingReportMgr.o : $(src)TimingReportMgr.cpp
	$(cpp_echo) $(src)TimingReportMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TimingReportMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TimingReportMgr_cppflags) $(TimingReportMgr_cpp_cppflags)  $(src)TimingReportMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TimingReportMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TimingReportMgr.cpp

$(bin)$(binobj)TimingReportMgr.o : $(TimingReportMgr_cpp_dependencies)
	$(cpp_echo) $(src)TimingReportMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TimingReportMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TimingReportMgr_cppflags) $(TimingReportMgr_cpp_cppflags)  $(src)TimingReportMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)sigsegv.d

$(bin)$(binobj)sigsegv.d :

$(bin)$(binobj)sigsegv.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)sigsegv.o : $(src)sigsegv.cpp
	$(cpp_echo) $(src)sigsegv.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(sigsegv_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(sigsegv_cppflags) $(sigsegv_cpp_cppflags)  $(src)sigsegv.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(sigsegv_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)sigsegv.cpp

$(bin)$(binobj)sigsegv.o : $(sigsegv_cpp_dependencies)
	$(cpp_echo) $(src)sigsegv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(sigsegv_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(sigsegv_cppflags) $(sigsegv_cpp_cppflags)  $(src)sigsegv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalChannelTable.d

$(bin)$(binobj)RelationalChannelTable.d :

$(bin)$(binobj)RelationalChannelTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalChannelTable.o : $(src)RelationalChannelTable.cpp
	$(cpp_echo) $(src)RelationalChannelTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalChannelTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalChannelTable_cppflags) $(RelationalChannelTable_cpp_cppflags)  $(src)RelationalChannelTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalChannelTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalChannelTable.cpp

$(bin)$(binobj)RelationalChannelTable.o : $(RelationalChannelTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalChannelTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalChannelTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalChannelTable_cppflags) $(RelationalChannelTable_cpp_cppflags)  $(src)RelationalChannelTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalGlobalTagTable.d

$(bin)$(binobj)RelationalGlobalTagTable.d :

$(bin)$(binobj)RelationalGlobalTagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalGlobalTagTable.o : $(src)RelationalGlobalTagTable.cpp
	$(cpp_echo) $(src)RelationalGlobalTagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalTagTable_cppflags) $(RelationalGlobalTagTable_cpp_cppflags)  $(src)RelationalGlobalTagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalGlobalTagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalGlobalTagTable.cpp

$(bin)$(binobj)RelationalGlobalTagTable.o : $(RelationalGlobalTagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalGlobalTagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalTagTable_cppflags) $(RelationalGlobalTagTable_cpp_cppflags)  $(src)RelationalGlobalTagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalNodeMgr.d

$(bin)$(binobj)RelationalNodeMgr.d :

$(bin)$(binobj)RelationalNodeMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalNodeMgr.o : $(src)RelationalNodeMgr.cpp
	$(cpp_echo) $(src)RelationalNodeMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalNodeMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalNodeMgr_cppflags) $(RelationalNodeMgr_cpp_cppflags)  $(src)RelationalNodeMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalNodeMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalNodeMgr.cpp

$(bin)$(binobj)RelationalNodeMgr.o : $(RelationalNodeMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalNodeMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalNodeMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalNodeMgr_cppflags) $(RelationalNodeMgr_cpp_cppflags)  $(src)RelationalNodeMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransRelFolderSet.d

$(bin)$(binobj)TransRelFolderSet.d :

$(bin)$(binobj)TransRelFolderSet.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TransRelFolderSet.o : $(src)TransRelFolderSet.cpp
	$(cpp_echo) $(src)TransRelFolderSet.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelFolderSet_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelFolderSet_cppflags) $(TransRelFolderSet_cpp_cppflags)  $(src)TransRelFolderSet.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TransRelFolderSet_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TransRelFolderSet.cpp

$(bin)$(binobj)TransRelFolderSet.o : $(TransRelFolderSet_cpp_dependencies)
	$(cpp_echo) $(src)TransRelFolderSet.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelFolderSet_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelFolderSet_cppflags) $(TransRelFolderSet_cpp_cppflags)  $(src)TransRelFolderSet.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SealUtil_TimingItem.d

$(bin)$(binobj)SealUtil_TimingItem.d :

$(bin)$(binobj)SealUtil_TimingItem.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)SealUtil_TimingItem.o : $(src)SealUtil_TimingItem.cpp
	$(cpp_echo) $(src)SealUtil_TimingItem.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealUtil_TimingItem_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealUtil_TimingItem_cppflags) $(SealUtil_TimingItem_cpp_cppflags)  $(src)SealUtil_TimingItem.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(SealUtil_TimingItem_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)SealUtil_TimingItem.cpp

$(bin)$(binobj)SealUtil_TimingItem.o : $(SealUtil_TimingItem_cpp_dependencies)
	$(cpp_echo) $(src)SealUtil_TimingItem.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealUtil_TimingItem_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealUtil_TimingItem_cppflags) $(SealUtil_TimingItem_cpp_cppflags)  $(src)SealUtil_TimingItem.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalPayloadQuery.d

$(bin)$(binobj)RelationalPayloadQuery.d :

$(bin)$(binobj)RelationalPayloadQuery.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalPayloadQuery.o : $(src)RelationalPayloadQuery.cpp
	$(cpp_echo) $(src)RelationalPayloadQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadQuery_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadQuery_cppflags) $(RelationalPayloadQuery_cpp_cppflags)  $(src)RelationalPayloadQuery.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalPayloadQuery_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalPayloadQuery.cpp

$(bin)$(binobj)RelationalPayloadQuery.o : $(RelationalPayloadQuery_cpp_dependencies)
	$(cpp_echo) $(src)RelationalPayloadQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadQuery_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadQuery_cppflags) $(RelationalPayloadQuery_cpp_cppflags)  $(src)RelationalPayloadQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTransaction.d

$(bin)$(binobj)RelationalTransaction.d :

$(bin)$(binobj)RelationalTransaction.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTransaction.o : $(src)RelationalTransaction.cpp
	$(cpp_echo) $(src)RelationalTransaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTransaction_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTransaction_cppflags) $(RelationalTransaction_cpp_cppflags)  $(src)RelationalTransaction.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTransaction_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTransaction.cpp

$(bin)$(binobj)RelationalTransaction.o : $(RelationalTransaction_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTransaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTransaction_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTransaction_cppflags) $(RelationalTransaction_cpp_cppflags)  $(src)RelationalTransaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransRalDatabase.d

$(bin)$(binobj)TransRalDatabase.d :

$(bin)$(binobj)TransRalDatabase.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TransRalDatabase.o : $(src)TransRalDatabase.cpp
	$(cpp_echo) $(src)TransRalDatabase.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRalDatabase_cppflags) $(TransRalDatabase_cpp_cppflags)  $(src)TransRalDatabase.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TransRalDatabase_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TransRalDatabase.cpp

$(bin)$(binobj)TransRalDatabase.o : $(TransRalDatabase_cpp_dependencies)
	$(cpp_echo) $(src)TransRalDatabase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRalDatabase_cppflags) $(TransRalDatabase_cpp_cppflags)  $(src)TransRalDatabase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTagTable.d

$(bin)$(binobj)RelationalTagTable.d :

$(bin)$(binobj)RelationalTagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTagTable.o : $(src)RelationalTagTable.cpp
	$(cpp_echo) $(src)RelationalTagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTagTable_cppflags) $(RelationalTagTable_cpp_cppflags)  $(src)RelationalTagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTagTable.cpp

$(bin)$(binobj)RelationalTagTable.o : $(RelationalTagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTagTable_cppflags) $(RelationalTagTable_cpp_cppflags)  $(src)RelationalTagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ObjectIteratorCounter.d

$(bin)$(binobj)ObjectIteratorCounter.d :

$(bin)$(binobj)ObjectIteratorCounter.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ObjectIteratorCounter.o : $(src)ObjectIteratorCounter.cpp
	$(cpp_echo) $(src)ObjectIteratorCounter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectIteratorCounter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectIteratorCounter_cppflags) $(ObjectIteratorCounter_cpp_cppflags)  $(src)ObjectIteratorCounter.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ObjectIteratorCounter_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ObjectIteratorCounter.cpp

$(bin)$(binobj)ObjectIteratorCounter.o : $(ObjectIteratorCounter_cpp_dependencies)
	$(cpp_echo) $(src)ObjectIteratorCounter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectIteratorCounter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectIteratorCounter_cppflags) $(ObjectIteratorCounter_cpp_cppflags)  $(src)ObjectIteratorCounter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoolChrono.d

$(bin)$(binobj)CoolChrono.d :

$(bin)$(binobj)CoolChrono.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)CoolChrono.o : $(src)CoolChrono.cpp
	$(cpp_echo) $(src)CoolChrono.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoolChrono_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoolChrono_cppflags) $(CoolChrono_cpp_cppflags)  $(src)CoolChrono.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(CoolChrono_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)CoolChrono.cpp

$(bin)$(binobj)CoolChrono.o : $(CoolChrono_cpp_dependencies)
	$(cpp_echo) $(src)CoolChrono.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoolChrono_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoolChrono_cppflags) $(CoolChrono_cpp_cppflags)  $(src)CoolChrono.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTableRow.d

$(bin)$(binobj)RelationalTableRow.d :

$(bin)$(binobj)RelationalTableRow.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTableRow.o : $(src)RelationalTableRow.cpp
	$(cpp_echo) $(src)RelationalTableRow.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTableRow_cppflags) $(RelationalTableRow_cpp_cppflags)  $(src)RelationalTableRow.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTableRow_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTableRow.cpp

$(bin)$(binobj)RelationalTableRow.o : $(RelationalTableRow_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTableRow.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTableRow_cppflags) $(RelationalTableRow_cpp_cppflags)  $(src)RelationalTableRow.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransRelHvsNode.d

$(bin)$(binobj)TransRelHvsNode.d :

$(bin)$(binobj)TransRelHvsNode.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TransRelHvsNode.o : $(src)TransRelHvsNode.cpp
	$(cpp_echo) $(src)TransRelHvsNode.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelHvsNode_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelHvsNode_cppflags) $(TransRelHvsNode_cpp_cppflags)  $(src)TransRelHvsNode.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TransRelHvsNode_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TransRelHvsNode.cpp

$(bin)$(binobj)TransRelHvsNode.o : $(TransRelHvsNode_cpp_dependencies)
	$(cpp_echo) $(src)TransRelHvsNode.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelHvsNode_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelHvsNode_cppflags) $(TransRelHvsNode_cpp_cppflags)  $(src)TransRelHvsNode.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalSchemaMgr.d

$(bin)$(binobj)RelationalSchemaMgr.d :

$(bin)$(binobj)RelationalSchemaMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalSchemaMgr.o : $(src)RelationalSchemaMgr.cpp
	$(cpp_echo) $(src)RelationalSchemaMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSchemaMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSchemaMgr_cppflags) $(RelationalSchemaMgr_cpp_cppflags)  $(src)RelationalSchemaMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalSchemaMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalSchemaMgr.cpp

$(bin)$(binobj)RelationalSchemaMgr.o : $(RelationalSchemaMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalSchemaMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSchemaMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSchemaMgr_cppflags) $(RelationalSchemaMgr_cpp_cppflags)  $(src)RelationalSchemaMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalFolder.d

$(bin)$(binobj)RelationalFolder.d :

$(bin)$(binobj)RelationalFolder.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalFolder.o : $(src)RelationalFolder.cpp
	$(cpp_echo) $(src)RelationalFolder.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolder_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolder_cppflags) $(RelationalFolder_cpp_cppflags)  $(src)RelationalFolder.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalFolder_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalFolder.cpp

$(bin)$(binobj)RelationalFolder.o : $(RelationalFolder_cpp_dependencies)
	$(cpp_echo) $(src)RelationalFolder.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolder_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolder_cppflags) $(RelationalFolder_cpp_cppflags)  $(src)RelationalFolder.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalException.d

$(bin)$(binobj)RelationalException.d :

$(bin)$(binobj)RelationalException.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalException.o : $(src)RelationalException.cpp
	$(cpp_echo) $(src)RelationalException.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalException_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalException_cppflags) $(RelationalException_cpp_cppflags)  $(src)RelationalException.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalException_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalException.cpp

$(bin)$(binobj)RelationalException.o : $(RelationalException_cpp_dependencies)
	$(cpp_echo) $(src)RelationalException.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalException_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalException_cppflags) $(RelationalException_cpp_cppflags)  $(src)RelationalException.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalFolderSetUnsupported.d

$(bin)$(binobj)RelationalFolderSetUnsupported.d :

$(bin)$(binobj)RelationalFolderSetUnsupported.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalFolderSetUnsupported.o : $(src)RelationalFolderSetUnsupported.cpp
	$(cpp_echo) $(src)RelationalFolderSetUnsupported.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderSetUnsupported_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderSetUnsupported_cppflags) $(RelationalFolderSetUnsupported_cpp_cppflags)  $(src)RelationalFolderSetUnsupported.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalFolderSetUnsupported_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalFolderSetUnsupported.cpp

$(bin)$(binobj)RelationalFolderSetUnsupported.o : $(RelationalFolderSetUnsupported_cpp_dependencies)
	$(cpp_echo) $(src)RelationalFolderSetUnsupported.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderSetUnsupported_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderSetUnsupported_cppflags) $(RelationalFolderSetUnsupported_cpp_cppflags)  $(src)RelationalFolderSetUnsupported.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalDatabase.d

$(bin)$(binobj)RelationalDatabase.d :

$(bin)$(binobj)RelationalDatabase.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalDatabase.o : $(src)RelationalDatabase.cpp
	$(cpp_echo) $(src)RelationalDatabase.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabase_cppflags) $(RelationalDatabase_cpp_cppflags)  $(src)RelationalDatabase.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalDatabase_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalDatabase.cpp

$(bin)$(binobj)RelationalDatabase.o : $(RelationalDatabase_cpp_dependencies)
	$(cpp_echo) $(src)RelationalDatabase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabase_cppflags) $(RelationalDatabase_cpp_cppflags)  $(src)RelationalDatabase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalSequenceTable.d

$(bin)$(binobj)RelationalSequenceTable.d :

$(bin)$(binobj)RelationalSequenceTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalSequenceTable.o : $(src)RelationalSequenceTable.cpp
	$(cpp_echo) $(src)RelationalSequenceTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequenceTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequenceTable_cppflags) $(RelationalSequenceTable_cpp_cppflags)  $(src)RelationalSequenceTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalSequenceTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalSequenceTable.cpp

$(bin)$(binobj)RelationalSequenceTable.o : $(RelationalSequenceTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalSequenceTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequenceTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequenceTable_cppflags) $(RelationalSequenceTable_cpp_cppflags)  $(src)RelationalSequenceTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SealUtil_SealTimer.d

$(bin)$(binobj)SealUtil_SealTimer.d :

$(bin)$(binobj)SealUtil_SealTimer.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)SealUtil_SealTimer.o : $(src)SealUtil_SealTimer.cpp
	$(cpp_echo) $(src)SealUtil_SealTimer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealUtil_SealTimer_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealUtil_SealTimer_cppflags) $(SealUtil_SealTimer_cpp_cppflags)  $(src)SealUtil_SealTimer.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(SealUtil_SealTimer_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)SealUtil_SealTimer.cpp

$(bin)$(binobj)SealUtil_SealTimer.o : $(SealUtil_SealTimer_cpp_dependencies)
	$(cpp_echo) $(src)SealUtil_SealTimer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealUtil_SealTimer_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealUtil_SealTimer_cppflags) $(SealUtil_SealTimer_cpp_cppflags)  $(src)SealUtil_SealTimer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SealBase_TimeInfo.d

$(bin)$(binobj)SealBase_TimeInfo.d :

$(bin)$(binobj)SealBase_TimeInfo.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)SealBase_TimeInfo.o : $(src)SealBase_TimeInfo.cpp
	$(cpp_echo) $(src)SealBase_TimeInfo.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealBase_TimeInfo_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealBase_TimeInfo_cppflags) $(SealBase_TimeInfo_cpp_cppflags)  $(src)SealBase_TimeInfo.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(SealBase_TimeInfo_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)SealBase_TimeInfo.cpp

$(bin)$(binobj)SealBase_TimeInfo.o : $(SealBase_TimeInfo_cpp_dependencies)
	$(cpp_echo) $(src)SealBase_TimeInfo.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(SealBase_TimeInfo_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(SealBase_TimeInfo_cppflags) $(SealBase_TimeInfo_cpp_cppflags)  $(src)SealBase_TimeInfo.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalHvsNodeRecord.d

$(bin)$(binobj)RelationalHvsNodeRecord.d :

$(bin)$(binobj)RelationalHvsNodeRecord.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalHvsNodeRecord.o : $(src)RelationalHvsNodeRecord.cpp
	$(cpp_echo) $(src)RelationalHvsNodeRecord.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsNodeRecord_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsNodeRecord_cppflags) $(RelationalHvsNodeRecord_cpp_cppflags)  $(src)RelationalHvsNodeRecord.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalHvsNodeRecord_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalHvsNodeRecord.cpp

$(bin)$(binobj)RelationalHvsNodeRecord.o : $(RelationalHvsNodeRecord_cpp_dependencies)
	$(cpp_echo) $(src)RelationalHvsNodeRecord.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsNodeRecord_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsNodeRecord_cppflags) $(RelationalHvsNodeRecord_cpp_cppflags)  $(src)RelationalHvsNodeRecord.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ObjectVectorIterator.d

$(bin)$(binobj)ObjectVectorIterator.d :

$(bin)$(binobj)ObjectVectorIterator.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ObjectVectorIterator.o : $(src)ObjectVectorIterator.cpp
	$(cpp_echo) $(src)ObjectVectorIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectVectorIterator_cppflags) $(ObjectVectorIterator_cpp_cppflags)  $(src)ObjectVectorIterator.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ObjectVectorIterator_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ObjectVectorIterator.cpp

$(bin)$(binobj)ObjectVectorIterator.o : $(ObjectVectorIterator_cpp_dependencies)
	$(cpp_echo) $(src)ObjectVectorIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectVectorIterator_cppflags) $(ObjectVectorIterator_cpp_cppflags)  $(src)ObjectVectorIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObject.d

$(bin)$(binobj)RelationalObject.d :

$(bin)$(binobj)RelationalObject.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObject.o : $(src)RelationalObject.cpp
	$(cpp_echo) $(src)RelationalObject.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObject_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObject_cppflags) $(RelationalObject_cpp_cppflags)  $(src)RelationalObject.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObject_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObject.cpp

$(bin)$(binobj)RelationalObject.o : $(RelationalObject_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObject.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObject_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObject_cppflags) $(RelationalObject_cpp_cppflags)  $(src)RelationalObject.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTableRowBase.d

$(bin)$(binobj)RelationalTableRowBase.d :

$(bin)$(binobj)RelationalTableRowBase.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTableRowBase.o : $(src)RelationalTableRowBase.cpp
	$(cpp_echo) $(src)RelationalTableRowBase.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTableRowBase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTableRowBase_cppflags) $(RelationalTableRowBase_cpp_cppflags)  $(src)RelationalTableRowBase.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTableRowBase_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTableRowBase.cpp

$(bin)$(binobj)RelationalTableRowBase.o : $(RelationalTableRowBase_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTableRowBase.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTableRowBase_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTableRowBase_cppflags) $(RelationalTableRowBase_cpp_cppflags)  $(src)RelationalTableRowBase.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObjectMgr.d

$(bin)$(binobj)RelationalObjectMgr.d :

$(bin)$(binobj)RelationalObjectMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObjectMgr.o : $(src)RelationalObjectMgr.cpp
	$(cpp_echo) $(src)RelationalObjectMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectMgr_cppflags) $(RelationalObjectMgr_cpp_cppflags)  $(src)RelationalObjectMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObjectMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObjectMgr.cpp

$(bin)$(binobj)RelationalObjectMgr.o : $(RelationalObjectMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObjectMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectMgr_cppflags) $(RelationalObjectMgr_cpp_cppflags)  $(src)RelationalObjectMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObjectTable.d

$(bin)$(binobj)RelationalObjectTable.d :

$(bin)$(binobj)RelationalObjectTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObjectTable.o : $(src)RelationalObjectTable.cpp
	$(cpp_echo) $(src)RelationalObjectTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectTable_cppflags) $(RelationalObjectTable_cpp_cppflags)  $(src)RelationalObjectTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObjectTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObjectTable.cpp

$(bin)$(binobj)RelationalObjectTable.o : $(RelationalObjectTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObjectTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectTable_cppflags) $(RelationalObjectTable_cpp_cppflags)  $(src)RelationalObjectTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalTransactionMgr.d

$(bin)$(binobj)RalTransactionMgr.d :

$(bin)$(binobj)RalTransactionMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalTransactionMgr.o : $(src)RalTransactionMgr.cpp
	$(cpp_echo) $(src)RalTransactionMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalTransactionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalTransactionMgr_cppflags) $(RalTransactionMgr_cpp_cppflags)  $(src)RalTransactionMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalTransactionMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalTransactionMgr.cpp

$(bin)$(binobj)RalTransactionMgr.o : $(RalTransactionMgr_cpp_dependencies)
	$(cpp_echo) $(src)RalTransactionMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalTransactionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalTransactionMgr_cppflags) $(RalTransactionMgr_cpp_cppflags)  $(src)RalTransactionMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PyCool_helpers.d

$(bin)$(binobj)PyCool_helpers.d :

$(bin)$(binobj)PyCool_helpers.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)PyCool_helpers.o : $(src)PyCool_helpers.cpp
	$(cpp_echo) $(src)PyCool_helpers.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(PyCool_helpers_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(PyCool_helpers_cppflags) $(PyCool_helpers_cpp_cppflags)  $(src)PyCool_helpers.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(PyCool_helpers_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)PyCool_helpers.cpp

$(bin)$(binobj)PyCool_helpers.o : $(PyCool_helpers_cpp_dependencies)
	$(cpp_echo) $(src)PyCool_helpers.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(PyCool_helpers_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(PyCool_helpers_cppflags) $(PyCool_helpers_cpp_cppflags)  $(src)PyCool_helpers.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyTransactionMgr.d

$(bin)$(binobj)DummyTransactionMgr.d :

$(bin)$(binobj)DummyTransactionMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)DummyTransactionMgr.o : $(src)DummyTransactionMgr.cpp
	$(cpp_echo) $(src)DummyTransactionMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(DummyTransactionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(DummyTransactionMgr_cppflags) $(DummyTransactionMgr_cpp_cppflags)  $(src)DummyTransactionMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(DummyTransactionMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)DummyTransactionMgr.cpp

$(bin)$(binobj)DummyTransactionMgr.o : $(DummyTransactionMgr_cpp_dependencies)
	$(cpp_echo) $(src)DummyTransactionMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(DummyTransactionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(DummyTransactionMgr_cppflags) $(DummyTransactionMgr_cpp_cppflags)  $(src)DummyTransactionMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObject2TagTable.d

$(bin)$(binobj)RelationalObject2TagTable.d :

$(bin)$(binobj)RelationalObject2TagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObject2TagTable.o : $(src)RelationalObject2TagTable.cpp
	$(cpp_echo) $(src)RelationalObject2TagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObject2TagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObject2TagTable_cppflags) $(RelationalObject2TagTable_cpp_cppflags)  $(src)RelationalObject2TagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObject2TagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObject2TagTable.cpp

$(bin)$(binobj)RelationalObject2TagTable.o : $(RelationalObject2TagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObject2TagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObject2TagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObject2TagTable_cppflags) $(RelationalObject2TagTable_cpp_cppflags)  $(src)RelationalObject2TagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalGlobalHeadTagTable.d

$(bin)$(binobj)RelationalGlobalHeadTagTable.d :

$(bin)$(binobj)RelationalGlobalHeadTagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalGlobalHeadTagTable.o : $(src)RelationalGlobalHeadTagTable.cpp
	$(cpp_echo) $(src)RelationalGlobalHeadTagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalHeadTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalHeadTagTable_cppflags) $(RelationalGlobalHeadTagTable_cpp_cppflags)  $(src)RelationalGlobalHeadTagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalGlobalHeadTagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalGlobalHeadTagTable.cpp

$(bin)$(binobj)RelationalGlobalHeadTagTable.o : $(RelationalGlobalHeadTagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalGlobalHeadTagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalHeadTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalHeadTagTable_cppflags) $(RelationalGlobalHeadTagTable_cpp_cppflags)  $(src)RelationalGlobalHeadTagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalPayloadTableRow.d

$(bin)$(binobj)RelationalPayloadTableRow.d :

$(bin)$(binobj)RelationalPayloadTableRow.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalPayloadTableRow.o : $(src)RelationalPayloadTableRow.cpp
	$(cpp_echo) $(src)RelationalPayloadTableRow.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadTableRow_cppflags) $(RelationalPayloadTableRow_cpp_cppflags)  $(src)RelationalPayloadTableRow.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalPayloadTableRow_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalPayloadTableRow.cpp

$(bin)$(binobj)RelationalPayloadTableRow.o : $(RelationalPayloadTableRow_cpp_dependencies)
	$(cpp_echo) $(src)RelationalPayloadTableRow.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadTableRow_cppflags) $(RelationalPayloadTableRow_cpp_cppflags)  $(src)RelationalPayloadTableRow.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalHvsNode.d

$(bin)$(binobj)RelationalHvsNode.d :

$(bin)$(binobj)RelationalHvsNode.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalHvsNode.o : $(src)RelationalHvsNode.cpp
	$(cpp_echo) $(src)RelationalHvsNode.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsNode_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsNode_cppflags) $(RelationalHvsNode_cpp_cppflags)  $(src)RelationalHvsNode.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalHvsNode_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalHvsNode.cpp

$(bin)$(binobj)RelationalHvsNode.o : $(RelationalHvsNode_cpp_dependencies)
	$(cpp_echo) $(src)RelationalHvsNode.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsNode_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsNode_cppflags) $(RelationalHvsNode_cpp_cppflags)  $(src)RelationalHvsNode.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObjectIterator.d

$(bin)$(binobj)RelationalObjectIterator.d :

$(bin)$(binobj)RelationalObjectIterator.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObjectIterator.o : $(src)RelationalObjectIterator.cpp
	$(cpp_echo) $(src)RelationalObjectIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectIterator_cppflags) $(RelationalObjectIterator_cpp_cppflags)  $(src)RelationalObjectIterator.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObjectIterator_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObjectIterator.cpp

$(bin)$(binobj)RelationalObjectIterator.o : $(RelationalObjectIterator_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObjectIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectIterator_cppflags) $(RelationalObjectIterator_cpp_cppflags)  $(src)RelationalObjectIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalSharedSequenceTable.d

$(bin)$(binobj)RelationalSharedSequenceTable.d :

$(bin)$(binobj)RelationalSharedSequenceTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalSharedSequenceTable.o : $(src)RelationalSharedSequenceTable.cpp
	$(cpp_echo) $(src)RelationalSharedSequenceTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSharedSequenceTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSharedSequenceTable_cppflags) $(RelationalSharedSequenceTable_cpp_cppflags)  $(src)RelationalSharedSequenceTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalSharedSequenceTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalSharedSequenceTable.cpp

$(bin)$(binobj)RelationalSharedSequenceTable.o : $(RelationalSharedSequenceTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalSharedSequenceTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSharedSequenceTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSharedSequenceTable_cppflags) $(RelationalSharedSequenceTable_cpp_cppflags)  $(src)RelationalSharedSequenceTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConstRecordIterator.d

$(bin)$(binobj)ConstRecordIterator.d :

$(bin)$(binobj)ConstRecordIterator.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ConstRecordIterator.o : $(src)ConstRecordIterator.cpp
	$(cpp_echo) $(src)ConstRecordIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstRecordIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstRecordIterator_cppflags) $(ConstRecordIterator_cpp_cppflags)  $(src)ConstRecordIterator.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ConstRecordIterator_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ConstRecordIterator.cpp

$(bin)$(binobj)ConstRecordIterator.o : $(ConstRecordIterator_cpp_dependencies)
	$(cpp_echo) $(src)ConstRecordIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstRecordIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstRecordIterator_cppflags) $(ConstRecordIterator_cpp_cppflags)  $(src)ConstRecordIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalSequenceMgr.d

$(bin)$(binobj)RalSequenceMgr.d :

$(bin)$(binobj)RalSequenceMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalSequenceMgr.o : $(src)RalSequenceMgr.cpp
	$(cpp_echo) $(src)RalSequenceMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSequenceMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSequenceMgr_cppflags) $(RalSequenceMgr_cpp_cppflags)  $(src)RalSequenceMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalSequenceMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalSequenceMgr.cpp

$(bin)$(binobj)RalSequenceMgr.o : $(RalSequenceMgr_cpp_dependencies)
	$(cpp_echo) $(src)RalSequenceMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSequenceMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSequenceMgr_cppflags) $(RalSequenceMgr_cpp_cppflags)  $(src)RalSequenceMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTagMgr.d

$(bin)$(binobj)RelationalTagMgr.d :

$(bin)$(binobj)RelationalTagMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTagMgr.o : $(src)RelationalTagMgr.cpp
	$(cpp_echo) $(src)RelationalTagMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTagMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTagMgr_cppflags) $(RelationalTagMgr_cpp_cppflags)  $(src)RelationalTagMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTagMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTagMgr.cpp

$(bin)$(binobj)RelationalTagMgr.o : $(RelationalTagMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTagMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTagMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTagMgr_cppflags) $(RelationalTagMgr_cpp_cppflags)  $(src)RelationalTagMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalFolderSet.d

$(bin)$(binobj)RelationalFolderSet.d :

$(bin)$(binobj)RelationalFolderSet.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalFolderSet.o : $(src)RelationalFolderSet.cpp
	$(cpp_echo) $(src)RelationalFolderSet.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderSet_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderSet_cppflags) $(RelationalFolderSet_cpp_cppflags)  $(src)RelationalFolderSet.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalFolderSet_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalFolderSet.cpp

$(bin)$(binobj)RelationalFolderSet.o : $(RelationalFolderSet_cpp_dependencies)
	$(cpp_echo) $(src)RelationalFolderSet.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalFolderSet_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalFolderSet_cppflags) $(RelationalFolderSet_cpp_cppflags)  $(src)RelationalFolderSet.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalSchemaMgr.d

$(bin)$(binobj)RalSchemaMgr.d :

$(bin)$(binobj)RalSchemaMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalSchemaMgr.o : $(src)RalSchemaMgr.cpp
	$(cpp_echo) $(src)RalSchemaMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSchemaMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSchemaMgr_cppflags) $(RalSchemaMgr_cpp_cppflags)  $(src)RalSchemaMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalSchemaMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalSchemaMgr.cpp

$(bin)$(binobj)RalSchemaMgr.o : $(RalSchemaMgr_cpp_dependencies)
	$(cpp_echo) $(src)RalSchemaMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSchemaMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSchemaMgr_cppflags) $(RalSchemaMgr_cpp_cppflags)  $(src)RalSchemaMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalPayloadTable.d

$(bin)$(binobj)RelationalPayloadTable.d :

$(bin)$(binobj)RelationalPayloadTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalPayloadTable.o : $(src)RelationalPayloadTable.cpp
	$(cpp_echo) $(src)RelationalPayloadTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadTable_cppflags) $(RelationalPayloadTable_cpp_cppflags)  $(src)RelationalPayloadTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalPayloadTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalPayloadTable.cpp

$(bin)$(binobj)RelationalPayloadTable.o : $(RelationalPayloadTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalPayloadTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalPayloadTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalPayloadTable_cppflags) $(RelationalPayloadTable_cpp_cppflags)  $(src)RelationalPayloadTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalDatabaseTable.d

$(bin)$(binobj)RelationalDatabaseTable.d :

$(bin)$(binobj)RelationalDatabaseTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalDatabaseTable.o : $(src)RelationalDatabaseTable.cpp
	$(cpp_echo) $(src)RelationalDatabaseTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabaseTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabaseTable_cppflags) $(RelationalDatabaseTable_cpp_cppflags)  $(src)RelationalDatabaseTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalDatabaseTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalDatabaseTable.cpp

$(bin)$(binobj)RelationalDatabaseTable.o : $(RelationalDatabaseTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalDatabaseTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalDatabaseTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalDatabaseTable_cppflags) $(RelationalDatabaseTable_cpp_cppflags)  $(src)RelationalDatabaseTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalSessionMgr.d

$(bin)$(binobj)RalSessionMgr.d :

$(bin)$(binobj)RalSessionMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalSessionMgr.o : $(src)RalSessionMgr.cpp
	$(cpp_echo) $(src)RalSessionMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSessionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSessionMgr_cppflags) $(RalSessionMgr_cpp_cppflags)  $(src)RalSessionMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalSessionMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalSessionMgr.cpp

$(bin)$(binobj)RalSessionMgr.o : $(RalSessionMgr_cpp_dependencies)
	$(cpp_echo) $(src)RalSessionMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalSessionMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalSessionMgr_cppflags) $(RalSessionMgr_cpp_cppflags)  $(src)RalSessionMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConstRelationalObjectAdapter.d

$(bin)$(binobj)ConstRelationalObjectAdapter.d :

$(bin)$(binobj)ConstRelationalObjectAdapter.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ConstRelationalObjectAdapter.o : $(src)ConstRelationalObjectAdapter.cpp
	$(cpp_echo) $(src)ConstRelationalObjectAdapter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstRelationalObjectAdapter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstRelationalObjectAdapter_cppflags) $(ConstRelationalObjectAdapter_cpp_cppflags)  $(src)ConstRelationalObjectAdapter.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ConstRelationalObjectAdapter_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ConstRelationalObjectAdapter.cpp

$(bin)$(binobj)ConstRelationalObjectAdapter.o : $(ConstRelationalObjectAdapter_cpp_dependencies)
	$(cpp_echo) $(src)ConstRelationalObjectAdapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstRelationalObjectAdapter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstRelationalObjectAdapter_cppflags) $(ConstRelationalObjectAdapter_cpp_cppflags)  $(src)ConstRelationalObjectAdapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConstTimeAdapter.d

$(bin)$(binobj)ConstTimeAdapter.d :

$(bin)$(binobj)ConstTimeAdapter.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ConstTimeAdapter.o : $(src)ConstTimeAdapter.cpp
	$(cpp_echo) $(src)ConstTimeAdapter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstTimeAdapter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstTimeAdapter_cppflags) $(ConstTimeAdapter_cpp_cppflags)  $(src)ConstTimeAdapter.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ConstTimeAdapter_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ConstTimeAdapter.cpp

$(bin)$(binobj)ConstTimeAdapter.o : $(ConstTimeAdapter_cpp_dependencies)
	$(cpp_echo) $(src)ConstTimeAdapter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ConstTimeAdapter_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ConstTimeAdapter_cppflags) $(ConstTimeAdapter_cpp_cppflags)  $(src)ConstTimeAdapter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransRelObjectIterator.d

$(bin)$(binobj)TransRelObjectIterator.d :

$(bin)$(binobj)TransRelObjectIterator.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TransRelObjectIterator.o : $(src)TransRelObjectIterator.cpp
	$(cpp_echo) $(src)TransRelObjectIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelObjectIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelObjectIterator_cppflags) $(TransRelObjectIterator_cpp_cppflags)  $(src)TransRelObjectIterator.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TransRelObjectIterator_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TransRelObjectIterator.cpp

$(bin)$(binobj)TransRelObjectIterator.o : $(TransRelObjectIterator_cpp_dependencies)
	$(cpp_echo) $(src)TransRelObjectIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelObjectIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelObjectIterator_cppflags) $(TransRelObjectIterator_cpp_cppflags)  $(src)TransRelObjectIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalHvsTagRecord.d

$(bin)$(binobj)RelationalHvsTagRecord.d :

$(bin)$(binobj)RelationalHvsTagRecord.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalHvsTagRecord.o : $(src)RelationalHvsTagRecord.cpp
	$(cpp_echo) $(src)RelationalHvsTagRecord.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsTagRecord_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsTagRecord_cppflags) $(RelationalHvsTagRecord_cpp_cppflags)  $(src)RelationalHvsTagRecord.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalHvsTagRecord_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalHvsTagRecord.cpp

$(bin)$(binobj)RelationalHvsTagRecord.o : $(RelationalHvsTagRecord_cpp_dependencies)
	$(cpp_echo) $(src)RelationalHvsTagRecord.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalHvsTagRecord_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalHvsTagRecord_cppflags) $(RelationalHvsTagRecord_cpp_cppflags)  $(src)RelationalHvsTagRecord.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalTag2TagTable.d

$(bin)$(binobj)RelationalTag2TagTable.d :

$(bin)$(binobj)RelationalTag2TagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalTag2TagTable.o : $(src)RelationalTag2TagTable.cpp
	$(cpp_echo) $(src)RelationalTag2TagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTag2TagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTag2TagTable_cppflags) $(RelationalTag2TagTable_cpp_cppflags)  $(src)RelationalTag2TagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalTag2TagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalTag2TagTable.cpp

$(bin)$(binobj)RelationalTag2TagTable.o : $(RelationalTag2TagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalTag2TagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalTag2TagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalTag2TagTable_cppflags) $(RelationalTag2TagTable_cpp_cppflags)  $(src)RelationalTag2TagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalSequence.d

$(bin)$(binobj)RelationalSequence.d :

$(bin)$(binobj)RelationalSequence.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalSequence.o : $(src)RelationalSequence.cpp
	$(cpp_echo) $(src)RelationalSequence.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequence_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequence_cppflags) $(RelationalSequence_cpp_cppflags)  $(src)RelationalSequence.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalSequence_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalSequence.cpp

$(bin)$(binobj)RelationalSequence.o : $(RelationalSequence_cpp_dependencies)
	$(cpp_echo) $(src)RelationalSequence.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequence_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequence_cppflags) $(RelationalSequence_cpp_cppflags)  $(src)RelationalSequence.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalChannelTablesTable.d

$(bin)$(binobj)RelationalChannelTablesTable.d :

$(bin)$(binobj)RelationalChannelTablesTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalChannelTablesTable.o : $(src)RelationalChannelTablesTable.cpp
	$(cpp_echo) $(src)RelationalChannelTablesTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalChannelTablesTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalChannelTablesTable_cppflags) $(RelationalChannelTablesTable_cpp_cppflags)  $(src)RelationalChannelTablesTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalChannelTablesTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalChannelTablesTable.cpp

$(bin)$(binobj)RelationalChannelTablesTable.o : $(RelationalChannelTablesTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalChannelTablesTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalChannelTablesTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalChannelTablesTable_cppflags) $(RelationalChannelTablesTable_cpp_cppflags)  $(src)RelationalChannelTablesTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RecordVectorIterator.d

$(bin)$(binobj)RecordVectorIterator.d :

$(bin)$(binobj)RecordVectorIterator.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RecordVectorIterator.o : $(src)RecordVectorIterator.cpp
	$(cpp_echo) $(src)RecordVectorIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RecordVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RecordVectorIterator_cppflags) $(RecordVectorIterator_cpp_cppflags)  $(src)RecordVectorIterator.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RecordVectorIterator_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RecordVectorIterator.cpp

$(bin)$(binobj)RecordVectorIterator.o : $(RecordVectorIterator_cpp_dependencies)
	$(cpp_echo) $(src)RecordVectorIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RecordVectorIterator_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RecordVectorIterator_cppflags) $(RecordVectorIterator_cpp_cppflags)  $(src)RecordVectorIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimingReport.d

$(bin)$(binobj)TimingReport.d :

$(bin)$(binobj)TimingReport.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TimingReport.o : $(src)TimingReport.cpp
	$(cpp_echo) $(src)TimingReport.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TimingReport_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TimingReport_cppflags) $(TimingReport_cpp_cppflags)  $(src)TimingReport.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TimingReport_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TimingReport.cpp

$(bin)$(binobj)TimingReport.o : $(TimingReport_cpp_dependencies)
	$(cpp_echo) $(src)TimingReport.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TimingReport_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TimingReport_cppflags) $(TimingReport_cpp_cppflags)  $(src)TimingReport.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ManualTransaction.d

$(bin)$(binobj)ManualTransaction.d :

$(bin)$(binobj)ManualTransaction.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ManualTransaction.o : $(src)ManualTransaction.cpp
	$(cpp_echo) $(src)ManualTransaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ManualTransaction_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ManualTransaction_cppflags) $(ManualTransaction_cpp_cppflags)  $(src)ManualTransaction.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ManualTransaction_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ManualTransaction.cpp

$(bin)$(binobj)ManualTransaction.o : $(ManualTransaction_cpp_dependencies)
	$(cpp_echo) $(src)ManualTransaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ManualTransaction_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ManualTransaction_cppflags) $(ManualTransaction_cpp_cppflags)  $(src)ManualTransaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ObjectId.d

$(bin)$(binobj)ObjectId.d :

$(bin)$(binobj)ObjectId.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)ObjectId.o : $(src)ObjectId.cpp
	$(cpp_echo) $(src)ObjectId.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectId_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectId_cppflags) $(ObjectId_cpp_cppflags)  $(src)ObjectId.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(ObjectId_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)ObjectId.cpp

$(bin)$(binobj)ObjectId.o : $(ObjectId_cpp_dependencies)
	$(cpp_echo) $(src)ObjectId.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(ObjectId_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(ObjectId_cppflags) $(ObjectId_cpp_cppflags)  $(src)ObjectId.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalObjectTableRow.d

$(bin)$(binobj)RelationalObjectTableRow.d :

$(bin)$(binobj)RelationalObjectTableRow.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalObjectTableRow.o : $(src)RelationalObjectTableRow.cpp
	$(cpp_echo) $(src)RelationalObjectTableRow.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectTableRow_cppflags) $(RelationalObjectTableRow_cpp_cppflags)  $(src)RelationalObjectTableRow.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalObjectTableRow_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalObjectTableRow.cpp

$(bin)$(binobj)RelationalObjectTableRow.o : $(RelationalObjectTableRow_cpp_dependencies)
	$(cpp_echo) $(src)RelationalObjectTableRow.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalObjectTableRow_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalObjectTableRow_cppflags) $(RelationalObjectTableRow_cpp_cppflags)  $(src)RelationalObjectTableRow.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalSequenceMgr.d

$(bin)$(binobj)RelationalSequenceMgr.d :

$(bin)$(binobj)RelationalSequenceMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalSequenceMgr.o : $(src)RelationalSequenceMgr.cpp
	$(cpp_echo) $(src)RelationalSequenceMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequenceMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequenceMgr_cppflags) $(RelationalSequenceMgr_cpp_cppflags)  $(src)RelationalSequenceMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalSequenceMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalSequenceMgr.cpp

$(bin)$(binobj)RelationalSequenceMgr.o : $(RelationalSequenceMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalSequenceMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalSequenceMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalSequenceMgr_cppflags) $(RelationalSequenceMgr_cpp_cppflags)  $(src)RelationalSequenceMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalIovTablesTable.d

$(bin)$(binobj)RelationalIovTablesTable.d :

$(bin)$(binobj)RelationalIovTablesTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalIovTablesTable.o : $(src)RelationalIovTablesTable.cpp
	$(cpp_echo) $(src)RelationalIovTablesTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalIovTablesTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalIovTablesTable_cppflags) $(RelationalIovTablesTable_cpp_cppflags)  $(src)RelationalIovTablesTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalIovTablesTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalIovTablesTable.cpp

$(bin)$(binobj)RelationalIovTablesTable.o : $(RelationalIovTablesTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalIovTablesTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalIovTablesTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalIovTablesTable_cppflags) $(RelationalIovTablesTable_cpp_cppflags)  $(src)RelationalIovTablesTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalGlobalUserTagTable.d

$(bin)$(binobj)RelationalGlobalUserTagTable.d :

$(bin)$(binobj)RelationalGlobalUserTagTable.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalGlobalUserTagTable.o : $(src)RelationalGlobalUserTagTable.cpp
	$(cpp_echo) $(src)RelationalGlobalUserTagTable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalUserTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalUserTagTable_cppflags) $(RelationalGlobalUserTagTable_cpp_cppflags)  $(src)RelationalGlobalUserTagTable.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalGlobalUserTagTable_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalGlobalUserTagTable.cpp

$(bin)$(binobj)RelationalGlobalUserTagTable.o : $(RelationalGlobalUserTagTable_cpp_dependencies)
	$(cpp_echo) $(src)RelationalGlobalUserTagTable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalGlobalUserTagTable_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalGlobalUserTagTable_cppflags) $(RelationalGlobalUserTagTable_cpp_cppflags)  $(src)RelationalGlobalUserTagTable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TransRelFolder.d

$(bin)$(binobj)TransRelFolder.d :

$(bin)$(binobj)TransRelFolder.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)TransRelFolder.o : $(src)TransRelFolder.cpp
	$(cpp_echo) $(src)TransRelFolder.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelFolder_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelFolder_cppflags) $(TransRelFolder_cpp_cppflags)  $(src)TransRelFolder.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(TransRelFolder_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)TransRelFolder.cpp

$(bin)$(binobj)TransRelFolder.o : $(TransRelFolder_cpp_dependencies)
	$(cpp_echo) $(src)TransRelFolder.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(TransRelFolder_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(TransRelFolder_cppflags) $(TransRelFolder_cpp_cppflags)  $(src)TransRelFolder.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RelationalQueryMgr.d

$(bin)$(binobj)RelationalQueryMgr.d :

$(bin)$(binobj)RelationalQueryMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RelationalQueryMgr.o : $(src)RelationalQueryMgr.cpp
	$(cpp_echo) $(src)RelationalQueryMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalQueryMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalQueryMgr_cppflags) $(RelationalQueryMgr_cpp_cppflags)  $(src)RelationalQueryMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RelationalQueryMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RelationalQueryMgr.cpp

$(bin)$(binobj)RelationalQueryMgr.o : $(RelationalQueryMgr_cpp_dependencies)
	$(cpp_echo) $(src)RelationalQueryMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RelationalQueryMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RelationalQueryMgr_cppflags) $(RelationalQueryMgr_cpp_cppflags)  $(src)RelationalQueryMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralApplication.d

$(bin)$(binobj)CoralApplication.d :

$(bin)$(binobj)CoralApplication.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)CoralApplication.o : $(src)CoralApplication.cpp
	$(cpp_echo) $(src)CoralApplication.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoralApplication_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoralApplication_cppflags) $(CoralApplication_cpp_cppflags)  $(src)CoralApplication.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(CoralApplication_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)CoralApplication.cpp

$(bin)$(binobj)CoralApplication.o : $(CoralApplication_cpp_dependencies)
	$(cpp_echo) $(src)CoralApplication.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(CoralApplication_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(CoralApplication_cppflags) $(CoralApplication_cpp_cppflags)  $(src)CoralApplication.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_RelationalCoolclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RalQueryMgr.d

$(bin)$(binobj)RalQueryMgr.d :

$(bin)$(binobj)RalQueryMgr.o : $(cmt_final_setup_lcg_RelationalCool)

$(bin)$(binobj)RalQueryMgr.o : $(src)RalQueryMgr.cpp
	$(cpp_echo) $(src)RalQueryMgr.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalQueryMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalQueryMgr_cppflags) $(RalQueryMgr_cpp_cppflags)  $(src)RalQueryMgr.cpp
endif
endif

else
$(bin)lcg_RelationalCool_dependencies.make : $(RalQueryMgr_cpp_dependencies)

$(bin)lcg_RelationalCool_dependencies.make : $(src)RalQueryMgr.cpp

$(bin)$(binobj)RalQueryMgr.o : $(RalQueryMgr_cpp_dependencies)
	$(cpp_echo) $(src)RalQueryMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_RelationalCool_pp_cppflags) $(lib_lcg_RelationalCool_pp_cppflags) $(RalQueryMgr_pp_cppflags) $(use_cppflags) $(lcg_RelationalCool_cppflags) $(lib_lcg_RelationalCool_cppflags) $(RalQueryMgr_cppflags) $(RalQueryMgr_cpp_cppflags)  $(src)RalQueryMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_RelationalCoolclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_RelationalCool.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_RelationalCoolclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_RelationalCool
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_RelationalCool$(library_suffix).a $(library_prefix)lcg_RelationalCool$(library_suffix).$(shlibsuffix) lcg_RelationalCool.stamp lcg_RelationalCool.shstamp
#-- end of cleanup_library ---------------
