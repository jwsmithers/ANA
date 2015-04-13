#-- start of make_header -----------------

#====================================
#  Library lcg_PyCoral
#
#   Generated Tue Mar 31 10:25:31 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_PyCoral_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_PyCoral_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_PyCoral

PyCoral_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoral = $(PyCoral_tag)_lcg_PyCoral.make
cmt_local_tagfile_lcg_PyCoral = $(bin)$(PyCoral_tag)_lcg_PyCoral.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCoral_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoral = $(PyCoral_tag).make
cmt_local_tagfile_lcg_PyCoral = $(bin)$(PyCoral_tag).make

endif

include $(cmt_local_tagfile_lcg_PyCoral)
#-include $(cmt_local_tagfile_lcg_PyCoral)

ifdef cmt_lcg_PyCoral_has_target_tag

cmt_final_setup_lcg_PyCoral = $(bin)setup_lcg_PyCoral.make
cmt_dependencies_in_lcg_PyCoral = $(bin)dependencies_lcg_PyCoral.in
#cmt_final_setup_lcg_PyCoral = $(bin)PyCoral_lcg_PyCoralsetup.make
cmt_local_lcg_PyCoral_makefile = $(bin)lcg_PyCoral.make

else

cmt_final_setup_lcg_PyCoral = $(bin)setup.make
cmt_dependencies_in_lcg_PyCoral = $(bin)dependencies.in
#cmt_final_setup_lcg_PyCoral = $(bin)PyCoralsetup.make
cmt_local_lcg_PyCoral_makefile = $(bin)lcg_PyCoral.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoralsetup.make

#lcg_PyCoral :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_PyCoral'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_PyCoral/
#lcg_PyCoral::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_PyCorallibname   = $(bin)$(library_prefix)lcg_PyCoral$(library_suffix)
lcg_PyCorallib       = $(lcg_PyCorallibname).a
lcg_PyCoralstamp     = $(bin)lcg_PyCoral.stamp
lcg_PyCoralshstamp   = $(bin)lcg_PyCoral.shstamp

lcg_PyCoral :: dirs  lcg_PyCoralLIB
	$(echo) "lcg_PyCoral ok"

cmt_lcg_PyCoral_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_PyCoral_has_prototypes

lcg_PyCoralprototype :  ;

endif

lcg_PyCoralcompile : $(bin)ITransaction.o $(bin)AttributeSpecification.o $(bin)ITableSchemaEditor.o $(bin)AttributeListIterator.o $(bin)ITableDataEditor.o $(bin)ITablePrivilegeManager.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)IColumn.o $(bin)Blob.o $(bin)IWebCacheControl.o $(bin)ISchema.o $(bin)IView.o $(bin)ITableDescription.o $(bin)TimeStamp.o $(bin)ISessionProperties.o $(bin)IIndex.o $(bin)IBulkOperationWithQuery.o $(bin)IUniqueConstraint.o $(bin)IViewFactory.o $(bin)IOperationWithQuery.o $(bin)ConnectionService.o $(bin)IQuery.o $(bin)ISessionProxy.o $(bin)IWebCacheInfo.o $(bin)coral.o $(bin)MessageStream.o $(bin)ITable.o $(bin)IMonitoringReporter.o $(bin)IPrimaryKey.o $(bin)IBulkOperation.o $(bin)IConnectionServiceConfiguration.o $(bin)Date.o $(bin)cast_to_base.o $(bin)ITypeConverter.o $(bin)TableDescription.o $(bin)IQueryDefinition.o $(bin)IForeignKey.o $(bin)ICursor.o $(bin)ICursorIterator.o $(bin)Exception.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_PyCoralLIB :: $(lcg_PyCorallib) $(lcg_PyCoralshstamp)
	@/bin/echo "------> lcg_PyCoral : library ok"

$(lcg_PyCorallib) :: $(bin)ITransaction.o $(bin)AttributeSpecification.o $(bin)ITableSchemaEditor.o $(bin)AttributeListIterator.o $(bin)ITableDataEditor.o $(bin)ITablePrivilegeManager.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)IColumn.o $(bin)Blob.o $(bin)IWebCacheControl.o $(bin)ISchema.o $(bin)IView.o $(bin)ITableDescription.o $(bin)TimeStamp.o $(bin)ISessionProperties.o $(bin)IIndex.o $(bin)IBulkOperationWithQuery.o $(bin)IUniqueConstraint.o $(bin)IViewFactory.o $(bin)IOperationWithQuery.o $(bin)ConnectionService.o $(bin)IQuery.o $(bin)ISessionProxy.o $(bin)IWebCacheInfo.o $(bin)coral.o $(bin)MessageStream.o $(bin)ITable.o $(bin)IMonitoringReporter.o $(bin)IPrimaryKey.o $(bin)IBulkOperation.o $(bin)IConnectionServiceConfiguration.o $(bin)Date.o $(bin)cast_to_base.o $(bin)ITypeConverter.o $(bin)TableDescription.o $(bin)IQueryDefinition.o $(bin)IForeignKey.o $(bin)ICursor.o $(bin)ICursorIterator.o $(bin)Exception.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_PyCorallib) $?
	$(lib_silent) $(ranlib) $(lcg_PyCorallib)
	$(lib_silent) cat /dev/null >$(lcg_PyCoralstamp)

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

$(lcg_PyCorallibname).$(shlibsuffix) :: $(lcg_PyCorallib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_PyCoral $(lcg_PyCoral_shlibflags)

$(lcg_PyCoralshstamp) :: $(lcg_PyCorallibname).$(shlibsuffix)
	@if test -f $(lcg_PyCorallibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_PyCoralshstamp) ; fi

lcg_PyCoralclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)ITransaction.o $(bin)AttributeSpecification.o $(bin)ITableSchemaEditor.o $(bin)AttributeListIterator.o $(bin)ITableDataEditor.o $(bin)ITablePrivilegeManager.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)IColumn.o $(bin)Blob.o $(bin)IWebCacheControl.o $(bin)ISchema.o $(bin)IView.o $(bin)ITableDescription.o $(bin)TimeStamp.o $(bin)ISessionProperties.o $(bin)IIndex.o $(bin)IBulkOperationWithQuery.o $(bin)IUniqueConstraint.o $(bin)IViewFactory.o $(bin)IOperationWithQuery.o $(bin)ConnectionService.o $(bin)IQuery.o $(bin)ISessionProxy.o $(bin)IWebCacheInfo.o $(bin)coral.o $(bin)MessageStream.o $(bin)ITable.o $(bin)IMonitoringReporter.o $(bin)IPrimaryKey.o $(bin)IBulkOperation.o $(bin)IConnectionServiceConfiguration.o $(bin)Date.o $(bin)cast_to_base.o $(bin)ITypeConverter.o $(bin)TableDescription.o $(bin)IQueryDefinition.o $(bin)IForeignKey.o $(bin)ICursor.o $(bin)ICursorIterator.o $(bin)Exception.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_PyCoralinstallname = $(library_prefix)lcg_PyCoral$(library_suffix).$(shlibsuffix)

lcg_PyCoral :: lcg_PyCoralinstall

install :: lcg_PyCoralinstall

lcg_PyCoralinstall :: $(install_dir)/$(lcg_PyCoralinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_PyCoralinstallname) :: $(bin)$(lcg_PyCoralinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_PyCoralinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_PyCoralclean :: lcg_PyCoraluninstall

uninstall :: lcg_PyCoraluninstall

lcg_PyCoraluninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_PyCoralinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_PyCoralprototype)

$(bin)lcg_PyCoral_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_PyCoral)
	$(echo) "(lcg_PyCoral.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ITransaction.cpp $(src)AttributeSpecification.cpp $(src)ITableSchemaEditor.cpp $(src)AttributeListIterator.cpp $(src)ITableDataEditor.cpp $(src)ITablePrivilegeManager.cpp $(src)Attribute.cpp $(src)AttributeList.cpp $(src)IColumn.cpp $(src)Blob.cpp $(src)IWebCacheControl.cpp $(src)ISchema.cpp $(src)IView.cpp $(src)ITableDescription.cpp $(src)TimeStamp.cpp $(src)ISessionProperties.cpp $(src)IIndex.cpp $(src)IBulkOperationWithQuery.cpp $(src)IUniqueConstraint.cpp $(src)IViewFactory.cpp $(src)IOperationWithQuery.cpp $(src)ConnectionService.cpp $(src)IQuery.cpp $(src)ISessionProxy.cpp $(src)IWebCacheInfo.cpp $(src)coral.cpp $(src)MessageStream.cpp $(src)ITable.cpp $(src)IMonitoringReporter.cpp $(src)IPrimaryKey.cpp $(src)IBulkOperation.cpp $(src)IConnectionServiceConfiguration.cpp $(src)Date.cpp $(src)cast_to_base.cpp $(src)ITypeConverter.cpp $(src)TableDescription.cpp $(src)IQueryDefinition.cpp $(src)IForeignKey.cpp $(src)ICursor.cpp $(src)ICursorIterator.cpp $(src)Exception.cpp -end_all $(includes) $(app_lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) -name=lcg_PyCoral $? -f=$(cmt_dependencies_in_lcg_PyCoral) -without_cmt

-include $(bin)lcg_PyCoral_dependencies.make

endif
endif
endif

lcg_PyCoralclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_PyCoral_deps $(bin)lcg_PyCoral_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITransaction.d

$(bin)$(binobj)ITransaction.d :

$(bin)$(binobj)ITransaction.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITransaction.o : $(src)ITransaction.cpp
	$(cpp_echo) $(src)ITransaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITransaction_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITransaction_cppflags) $(ITransaction_cpp_cppflags)  $(src)ITransaction.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITransaction_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITransaction.cpp

$(bin)$(binobj)ITransaction.o : $(ITransaction_cpp_dependencies)
	$(cpp_echo) $(src)ITransaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITransaction_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITransaction_cppflags) $(ITransaction_cpp_cppflags)  $(src)ITransaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeSpecification.d

$(bin)$(binobj)AttributeSpecification.d :

$(bin)$(binobj)AttributeSpecification.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)AttributeSpecification.o : $(src)AttributeSpecification.cpp
	$(cpp_echo) $(src)AttributeSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeSpecification_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeSpecification_cppflags) $(AttributeSpecification_cpp_cppflags)  $(src)AttributeSpecification.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(AttributeSpecification_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)AttributeSpecification.cpp

$(bin)$(binobj)AttributeSpecification.o : $(AttributeSpecification_cpp_dependencies)
	$(cpp_echo) $(src)AttributeSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeSpecification_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeSpecification_cppflags) $(AttributeSpecification_cpp_cppflags)  $(src)AttributeSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITableSchemaEditor.d

$(bin)$(binobj)ITableSchemaEditor.d :

$(bin)$(binobj)ITableSchemaEditor.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITableSchemaEditor.o : $(src)ITableSchemaEditor.cpp
	$(cpp_echo) $(src)ITableSchemaEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableSchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableSchemaEditor_cppflags) $(ITableSchemaEditor_cpp_cppflags)  $(src)ITableSchemaEditor.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITableSchemaEditor_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITableSchemaEditor.cpp

$(bin)$(binobj)ITableSchemaEditor.o : $(ITableSchemaEditor_cpp_dependencies)
	$(cpp_echo) $(src)ITableSchemaEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableSchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableSchemaEditor_cppflags) $(ITableSchemaEditor_cpp_cppflags)  $(src)ITableSchemaEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeListIterator.d

$(bin)$(binobj)AttributeListIterator.d :

$(bin)$(binobj)AttributeListIterator.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)AttributeListIterator.o : $(src)AttributeListIterator.cpp
	$(cpp_echo) $(src)AttributeListIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeListIterator_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeListIterator_cppflags) $(AttributeListIterator_cpp_cppflags)  $(src)AttributeListIterator.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(AttributeListIterator_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)AttributeListIterator.cpp

$(bin)$(binobj)AttributeListIterator.o : $(AttributeListIterator_cpp_dependencies)
	$(cpp_echo) $(src)AttributeListIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeListIterator_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeListIterator_cppflags) $(AttributeListIterator_cpp_cppflags)  $(src)AttributeListIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITableDataEditor.d

$(bin)$(binobj)ITableDataEditor.d :

$(bin)$(binobj)ITableDataEditor.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITableDataEditor.o : $(src)ITableDataEditor.cpp
	$(cpp_echo) $(src)ITableDataEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableDataEditor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableDataEditor_cppflags) $(ITableDataEditor_cpp_cppflags)  $(src)ITableDataEditor.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITableDataEditor_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITableDataEditor.cpp

$(bin)$(binobj)ITableDataEditor.o : $(ITableDataEditor_cpp_dependencies)
	$(cpp_echo) $(src)ITableDataEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableDataEditor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableDataEditor_cppflags) $(ITableDataEditor_cpp_cppflags)  $(src)ITableDataEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITablePrivilegeManager.d

$(bin)$(binobj)ITablePrivilegeManager.d :

$(bin)$(binobj)ITablePrivilegeManager.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITablePrivilegeManager.o : $(src)ITablePrivilegeManager.cpp
	$(cpp_echo) $(src)ITablePrivilegeManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITablePrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITablePrivilegeManager_cppflags) $(ITablePrivilegeManager_cpp_cppflags)  $(src)ITablePrivilegeManager.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITablePrivilegeManager_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITablePrivilegeManager.cpp

$(bin)$(binobj)ITablePrivilegeManager.o : $(ITablePrivilegeManager_cpp_dependencies)
	$(cpp_echo) $(src)ITablePrivilegeManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITablePrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITablePrivilegeManager_cppflags) $(ITablePrivilegeManager_cpp_cppflags)  $(src)ITablePrivilegeManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Attribute.d

$(bin)$(binobj)Attribute.d :

$(bin)$(binobj)Attribute.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)Attribute.o : $(src)Attribute.cpp
	$(cpp_echo) $(src)Attribute.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Attribute_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Attribute_cppflags) $(Attribute_cpp_cppflags)  $(src)Attribute.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(Attribute_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)Attribute.cpp

$(bin)$(binobj)Attribute.o : $(Attribute_cpp_dependencies)
	$(cpp_echo) $(src)Attribute.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Attribute_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Attribute_cppflags) $(Attribute_cpp_cppflags)  $(src)Attribute.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeList.d

$(bin)$(binobj)AttributeList.d :

$(bin)$(binobj)AttributeList.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)AttributeList.o : $(src)AttributeList.cpp
	$(cpp_echo) $(src)AttributeList.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeList_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeList_cppflags) $(AttributeList_cpp_cppflags)  $(src)AttributeList.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(AttributeList_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)AttributeList.cpp

$(bin)$(binobj)AttributeList.o : $(AttributeList_cpp_dependencies)
	$(cpp_echo) $(src)AttributeList.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(AttributeList_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(AttributeList_cppflags) $(AttributeList_cpp_cppflags)  $(src)AttributeList.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IColumn.d

$(bin)$(binobj)IColumn.d :

$(bin)$(binobj)IColumn.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IColumn.o : $(src)IColumn.cpp
	$(cpp_echo) $(src)IColumn.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IColumn_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IColumn_cppflags) $(IColumn_cpp_cppflags)  $(src)IColumn.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IColumn_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IColumn.cpp

$(bin)$(binobj)IColumn.o : $(IColumn_cpp_dependencies)
	$(cpp_echo) $(src)IColumn.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IColumn_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IColumn_cppflags) $(IColumn_cpp_cppflags)  $(src)IColumn.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Blob.d

$(bin)$(binobj)Blob.d :

$(bin)$(binobj)Blob.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)Blob.o : $(src)Blob.cpp
	$(cpp_echo) $(src)Blob.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Blob_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Blob_cppflags) $(Blob_cpp_cppflags)  $(src)Blob.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(Blob_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)Blob.cpp

$(bin)$(binobj)Blob.o : $(Blob_cpp_dependencies)
	$(cpp_echo) $(src)Blob.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Blob_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Blob_cppflags) $(Blob_cpp_cppflags)  $(src)Blob.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IWebCacheControl.d

$(bin)$(binobj)IWebCacheControl.d :

$(bin)$(binobj)IWebCacheControl.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IWebCacheControl.o : $(src)IWebCacheControl.cpp
	$(cpp_echo) $(src)IWebCacheControl.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IWebCacheControl_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IWebCacheControl_cppflags) $(IWebCacheControl_cpp_cppflags)  $(src)IWebCacheControl.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IWebCacheControl_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IWebCacheControl.cpp

$(bin)$(binobj)IWebCacheControl.o : $(IWebCacheControl_cpp_dependencies)
	$(cpp_echo) $(src)IWebCacheControl.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IWebCacheControl_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IWebCacheControl_cppflags) $(IWebCacheControl_cpp_cppflags)  $(src)IWebCacheControl.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ISchema.d

$(bin)$(binobj)ISchema.d :

$(bin)$(binobj)ISchema.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ISchema.o : $(src)ISchema.cpp
	$(cpp_echo) $(src)ISchema.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISchema_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISchema_cppflags) $(ISchema_cpp_cppflags)  $(src)ISchema.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ISchema_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ISchema.cpp

$(bin)$(binobj)ISchema.o : $(ISchema_cpp_dependencies)
	$(cpp_echo) $(src)ISchema.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISchema_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISchema_cppflags) $(ISchema_cpp_cppflags)  $(src)ISchema.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IView.d

$(bin)$(binobj)IView.d :

$(bin)$(binobj)IView.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IView.o : $(src)IView.cpp
	$(cpp_echo) $(src)IView.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IView_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IView_cppflags) $(IView_cpp_cppflags)  $(src)IView.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IView_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IView.cpp

$(bin)$(binobj)IView.o : $(IView_cpp_dependencies)
	$(cpp_echo) $(src)IView.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IView_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IView_cppflags) $(IView_cpp_cppflags)  $(src)IView.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITableDescription.d

$(bin)$(binobj)ITableDescription.d :

$(bin)$(binobj)ITableDescription.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITableDescription.o : $(src)ITableDescription.cpp
	$(cpp_echo) $(src)ITableDescription.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableDescription_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableDescription_cppflags) $(ITableDescription_cpp_cppflags)  $(src)ITableDescription.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITableDescription_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITableDescription.cpp

$(bin)$(binobj)ITableDescription.o : $(ITableDescription_cpp_dependencies)
	$(cpp_echo) $(src)ITableDescription.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITableDescription_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITableDescription_cppflags) $(ITableDescription_cpp_cppflags)  $(src)ITableDescription.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeStamp.d

$(bin)$(binobj)TimeStamp.d :

$(bin)$(binobj)TimeStamp.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)TimeStamp.o : $(src)TimeStamp.cpp
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(TimeStamp_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)TimeStamp.cpp

$(bin)$(binobj)TimeStamp.o : $(TimeStamp_cpp_dependencies)
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ISessionProperties.d

$(bin)$(binobj)ISessionProperties.d :

$(bin)$(binobj)ISessionProperties.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ISessionProperties.o : $(src)ISessionProperties.cpp
	$(cpp_echo) $(src)ISessionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISessionProperties_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISessionProperties_cppflags) $(ISessionProperties_cpp_cppflags)  $(src)ISessionProperties.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ISessionProperties_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ISessionProperties.cpp

$(bin)$(binobj)ISessionProperties.o : $(ISessionProperties_cpp_dependencies)
	$(cpp_echo) $(src)ISessionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISessionProperties_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISessionProperties_cppflags) $(ISessionProperties_cpp_cppflags)  $(src)ISessionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IIndex.d

$(bin)$(binobj)IIndex.d :

$(bin)$(binobj)IIndex.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IIndex.o : $(src)IIndex.cpp
	$(cpp_echo) $(src)IIndex.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IIndex_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IIndex_cppflags) $(IIndex_cpp_cppflags)  $(src)IIndex.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IIndex_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IIndex.cpp

$(bin)$(binobj)IIndex.o : $(IIndex_cpp_dependencies)
	$(cpp_echo) $(src)IIndex.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IIndex_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IIndex_cppflags) $(IIndex_cpp_cppflags)  $(src)IIndex.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IBulkOperationWithQuery.d

$(bin)$(binobj)IBulkOperationWithQuery.d :

$(bin)$(binobj)IBulkOperationWithQuery.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IBulkOperationWithQuery.o : $(src)IBulkOperationWithQuery.cpp
	$(cpp_echo) $(src)IBulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IBulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IBulkOperationWithQuery_cppflags) $(IBulkOperationWithQuery_cpp_cppflags)  $(src)IBulkOperationWithQuery.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IBulkOperationWithQuery_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IBulkOperationWithQuery.cpp

$(bin)$(binobj)IBulkOperationWithQuery.o : $(IBulkOperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)IBulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IBulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IBulkOperationWithQuery_cppflags) $(IBulkOperationWithQuery_cpp_cppflags)  $(src)IBulkOperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IUniqueConstraint.d

$(bin)$(binobj)IUniqueConstraint.d :

$(bin)$(binobj)IUniqueConstraint.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IUniqueConstraint.o : $(src)IUniqueConstraint.cpp
	$(cpp_echo) $(src)IUniqueConstraint.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IUniqueConstraint_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IUniqueConstraint_cppflags) $(IUniqueConstraint_cpp_cppflags)  $(src)IUniqueConstraint.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IUniqueConstraint_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IUniqueConstraint.cpp

$(bin)$(binobj)IUniqueConstraint.o : $(IUniqueConstraint_cpp_dependencies)
	$(cpp_echo) $(src)IUniqueConstraint.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IUniqueConstraint_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IUniqueConstraint_cppflags) $(IUniqueConstraint_cpp_cppflags)  $(src)IUniqueConstraint.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IViewFactory.d

$(bin)$(binobj)IViewFactory.d :

$(bin)$(binobj)IViewFactory.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IViewFactory.o : $(src)IViewFactory.cpp
	$(cpp_echo) $(src)IViewFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IViewFactory_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IViewFactory_cppflags) $(IViewFactory_cpp_cppflags)  $(src)IViewFactory.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IViewFactory_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IViewFactory.cpp

$(bin)$(binobj)IViewFactory.o : $(IViewFactory_cpp_dependencies)
	$(cpp_echo) $(src)IViewFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IViewFactory_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IViewFactory_cppflags) $(IViewFactory_cpp_cppflags)  $(src)IViewFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IOperationWithQuery.d

$(bin)$(binobj)IOperationWithQuery.d :

$(bin)$(binobj)IOperationWithQuery.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IOperationWithQuery.o : $(src)IOperationWithQuery.cpp
	$(cpp_echo) $(src)IOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IOperationWithQuery_cppflags) $(IOperationWithQuery_cpp_cppflags)  $(src)IOperationWithQuery.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IOperationWithQuery_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IOperationWithQuery.cpp

$(bin)$(binobj)IOperationWithQuery.o : $(IOperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)IOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IOperationWithQuery_cppflags) $(IOperationWithQuery_cpp_cppflags)  $(src)IOperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionService.d

$(bin)$(binobj)ConnectionService.d :

$(bin)$(binobj)ConnectionService.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ConnectionService.o : $(src)ConnectionService.cpp
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ConnectionService_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ConnectionService.cpp

$(bin)$(binobj)ConnectionService.o : $(ConnectionService_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionService.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ConnectionService_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ConnectionService_cppflags) $(ConnectionService_cpp_cppflags)  $(src)ConnectionService.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IQuery.d

$(bin)$(binobj)IQuery.d :

$(bin)$(binobj)IQuery.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IQuery.o : $(src)IQuery.cpp
	$(cpp_echo) $(src)IQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IQuery_cppflags) $(IQuery_cpp_cppflags)  $(src)IQuery.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IQuery_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IQuery.cpp

$(bin)$(binobj)IQuery.o : $(IQuery_cpp_dependencies)
	$(cpp_echo) $(src)IQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IQuery_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IQuery_cppflags) $(IQuery_cpp_cppflags)  $(src)IQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ISessionProxy.d

$(bin)$(binobj)ISessionProxy.d :

$(bin)$(binobj)ISessionProxy.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ISessionProxy.o : $(src)ISessionProxy.cpp
	$(cpp_echo) $(src)ISessionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISessionProxy_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISessionProxy_cppflags) $(ISessionProxy_cpp_cppflags)  $(src)ISessionProxy.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ISessionProxy_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ISessionProxy.cpp

$(bin)$(binobj)ISessionProxy.o : $(ISessionProxy_cpp_dependencies)
	$(cpp_echo) $(src)ISessionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ISessionProxy_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ISessionProxy_cppflags) $(ISessionProxy_cpp_cppflags)  $(src)ISessionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IWebCacheInfo.d

$(bin)$(binobj)IWebCacheInfo.d :

$(bin)$(binobj)IWebCacheInfo.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IWebCacheInfo.o : $(src)IWebCacheInfo.cpp
	$(cpp_echo) $(src)IWebCacheInfo.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IWebCacheInfo_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IWebCacheInfo_cppflags) $(IWebCacheInfo_cpp_cppflags)  $(src)IWebCacheInfo.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IWebCacheInfo_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IWebCacheInfo.cpp

$(bin)$(binobj)IWebCacheInfo.o : $(IWebCacheInfo_cpp_dependencies)
	$(cpp_echo) $(src)IWebCacheInfo.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IWebCacheInfo_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IWebCacheInfo_cppflags) $(IWebCacheInfo_cpp_cppflags)  $(src)IWebCacheInfo.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)coral.d

$(bin)$(binobj)coral.d :

$(bin)$(binobj)coral.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)coral.o : $(src)coral.cpp
	$(cpp_echo) $(src)coral.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(coral_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(coral_cppflags) $(coral_cpp_cppflags)  $(src)coral.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(coral_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)coral.cpp

$(bin)$(binobj)coral.o : $(coral_cpp_dependencies)
	$(cpp_echo) $(src)coral.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(coral_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(coral_cppflags) $(coral_cpp_cppflags)  $(src)coral.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MessageStream.d

$(bin)$(binobj)MessageStream.d :

$(bin)$(binobj)MessageStream.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)MessageStream.o : $(src)MessageStream.cpp
	$(cpp_echo) $(src)MessageStream.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(MessageStream_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(MessageStream_cppflags) $(MessageStream_cpp_cppflags)  $(src)MessageStream.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(MessageStream_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)MessageStream.cpp

$(bin)$(binobj)MessageStream.o : $(MessageStream_cpp_dependencies)
	$(cpp_echo) $(src)MessageStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(MessageStream_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(MessageStream_cppflags) $(MessageStream_cpp_cppflags)  $(src)MessageStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITable.d

$(bin)$(binobj)ITable.d :

$(bin)$(binobj)ITable.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITable.o : $(src)ITable.cpp
	$(cpp_echo) $(src)ITable.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITable_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITable_cppflags) $(ITable_cpp_cppflags)  $(src)ITable.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITable_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITable.cpp

$(bin)$(binobj)ITable.o : $(ITable_cpp_dependencies)
	$(cpp_echo) $(src)ITable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITable_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITable_cppflags) $(ITable_cpp_cppflags)  $(src)ITable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IMonitoringReporter.d

$(bin)$(binobj)IMonitoringReporter.d :

$(bin)$(binobj)IMonitoringReporter.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IMonitoringReporter.o : $(src)IMonitoringReporter.cpp
	$(cpp_echo) $(src)IMonitoringReporter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IMonitoringReporter_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IMonitoringReporter_cppflags) $(IMonitoringReporter_cpp_cppflags)  $(src)IMonitoringReporter.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IMonitoringReporter_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IMonitoringReporter.cpp

$(bin)$(binobj)IMonitoringReporter.o : $(IMonitoringReporter_cpp_dependencies)
	$(cpp_echo) $(src)IMonitoringReporter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IMonitoringReporter_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IMonitoringReporter_cppflags) $(IMonitoringReporter_cpp_cppflags)  $(src)IMonitoringReporter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IPrimaryKey.d

$(bin)$(binobj)IPrimaryKey.d :

$(bin)$(binobj)IPrimaryKey.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IPrimaryKey.o : $(src)IPrimaryKey.cpp
	$(cpp_echo) $(src)IPrimaryKey.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IPrimaryKey_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IPrimaryKey_cppflags) $(IPrimaryKey_cpp_cppflags)  $(src)IPrimaryKey.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IPrimaryKey_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IPrimaryKey.cpp

$(bin)$(binobj)IPrimaryKey.o : $(IPrimaryKey_cpp_dependencies)
	$(cpp_echo) $(src)IPrimaryKey.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IPrimaryKey_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IPrimaryKey_cppflags) $(IPrimaryKey_cpp_cppflags)  $(src)IPrimaryKey.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IBulkOperation.d

$(bin)$(binobj)IBulkOperation.d :

$(bin)$(binobj)IBulkOperation.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IBulkOperation.o : $(src)IBulkOperation.cpp
	$(cpp_echo) $(src)IBulkOperation.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IBulkOperation_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IBulkOperation_cppflags) $(IBulkOperation_cpp_cppflags)  $(src)IBulkOperation.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IBulkOperation_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IBulkOperation.cpp

$(bin)$(binobj)IBulkOperation.o : $(IBulkOperation_cpp_dependencies)
	$(cpp_echo) $(src)IBulkOperation.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IBulkOperation_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IBulkOperation_cppflags) $(IBulkOperation_cpp_cppflags)  $(src)IBulkOperation.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IConnectionServiceConfiguration.d

$(bin)$(binobj)IConnectionServiceConfiguration.d :

$(bin)$(binobj)IConnectionServiceConfiguration.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IConnectionServiceConfiguration.o : $(src)IConnectionServiceConfiguration.cpp
	$(cpp_echo) $(src)IConnectionServiceConfiguration.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IConnectionServiceConfiguration_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IConnectionServiceConfiguration_cppflags) $(IConnectionServiceConfiguration_cpp_cppflags)  $(src)IConnectionServiceConfiguration.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IConnectionServiceConfiguration_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IConnectionServiceConfiguration.cpp

$(bin)$(binobj)IConnectionServiceConfiguration.o : $(IConnectionServiceConfiguration_cpp_dependencies)
	$(cpp_echo) $(src)IConnectionServiceConfiguration.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IConnectionServiceConfiguration_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IConnectionServiceConfiguration_cppflags) $(IConnectionServiceConfiguration_cpp_cppflags)  $(src)IConnectionServiceConfiguration.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Date.d

$(bin)$(binobj)Date.d :

$(bin)$(binobj)Date.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)Date.o : $(src)Date.cpp
	$(cpp_echo) $(src)Date.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Date_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Date_cppflags) $(Date_cpp_cppflags)  $(src)Date.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(Date_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)Date.cpp

$(bin)$(binobj)Date.o : $(Date_cpp_dependencies)
	$(cpp_echo) $(src)Date.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Date_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Date_cppflags) $(Date_cpp_cppflags)  $(src)Date.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)cast_to_base.d

$(bin)$(binobj)cast_to_base.d :

$(bin)$(binobj)cast_to_base.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)cast_to_base.o : $(src)cast_to_base.cpp
	$(cpp_echo) $(src)cast_to_base.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(cast_to_base_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(cast_to_base_cppflags) $(cast_to_base_cpp_cppflags)  $(src)cast_to_base.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(cast_to_base_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)cast_to_base.cpp

$(bin)$(binobj)cast_to_base.o : $(cast_to_base_cpp_dependencies)
	$(cpp_echo) $(src)cast_to_base.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(cast_to_base_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(cast_to_base_cppflags) $(cast_to_base_cpp_cppflags)  $(src)cast_to_base.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ITypeConverter.d

$(bin)$(binobj)ITypeConverter.d :

$(bin)$(binobj)ITypeConverter.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ITypeConverter.o : $(src)ITypeConverter.cpp
	$(cpp_echo) $(src)ITypeConverter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITypeConverter_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITypeConverter_cppflags) $(ITypeConverter_cpp_cppflags)  $(src)ITypeConverter.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ITypeConverter_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ITypeConverter.cpp

$(bin)$(binobj)ITypeConverter.o : $(ITypeConverter_cpp_dependencies)
	$(cpp_echo) $(src)ITypeConverter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ITypeConverter_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ITypeConverter_cppflags) $(ITypeConverter_cpp_cppflags)  $(src)ITypeConverter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDescription.d

$(bin)$(binobj)TableDescription.d :

$(bin)$(binobj)TableDescription.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)TableDescription.o : $(src)TableDescription.cpp
	$(cpp_echo) $(src)TableDescription.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(TableDescription_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(TableDescription_cppflags) $(TableDescription_cpp_cppflags)  $(src)TableDescription.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(TableDescription_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)TableDescription.cpp

$(bin)$(binobj)TableDescription.o : $(TableDescription_cpp_dependencies)
	$(cpp_echo) $(src)TableDescription.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(TableDescription_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(TableDescription_cppflags) $(TableDescription_cpp_cppflags)  $(src)TableDescription.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IQueryDefinition.d

$(bin)$(binobj)IQueryDefinition.d :

$(bin)$(binobj)IQueryDefinition.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IQueryDefinition.o : $(src)IQueryDefinition.cpp
	$(cpp_echo) $(src)IQueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IQueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IQueryDefinition_cppflags) $(IQueryDefinition_cpp_cppflags)  $(src)IQueryDefinition.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IQueryDefinition_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IQueryDefinition.cpp

$(bin)$(binobj)IQueryDefinition.o : $(IQueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)IQueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IQueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IQueryDefinition_cppflags) $(IQueryDefinition_cpp_cppflags)  $(src)IQueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IForeignKey.d

$(bin)$(binobj)IForeignKey.d :

$(bin)$(binobj)IForeignKey.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)IForeignKey.o : $(src)IForeignKey.cpp
	$(cpp_echo) $(src)IForeignKey.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IForeignKey_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IForeignKey_cppflags) $(IForeignKey_cpp_cppflags)  $(src)IForeignKey.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(IForeignKey_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)IForeignKey.cpp

$(bin)$(binobj)IForeignKey.o : $(IForeignKey_cpp_dependencies)
	$(cpp_echo) $(src)IForeignKey.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(IForeignKey_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(IForeignKey_cppflags) $(IForeignKey_cpp_cppflags)  $(src)IForeignKey.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ICursor.d

$(bin)$(binobj)ICursor.d :

$(bin)$(binobj)ICursor.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ICursor.o : $(src)ICursor.cpp
	$(cpp_echo) $(src)ICursor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ICursor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ICursor_cppflags) $(ICursor_cpp_cppflags)  $(src)ICursor.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ICursor_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ICursor.cpp

$(bin)$(binobj)ICursor.o : $(ICursor_cpp_dependencies)
	$(cpp_echo) $(src)ICursor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ICursor_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ICursor_cppflags) $(ICursor_cpp_cppflags)  $(src)ICursor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ICursorIterator.d

$(bin)$(binobj)ICursorIterator.d :

$(bin)$(binobj)ICursorIterator.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)ICursorIterator.o : $(src)ICursorIterator.cpp
	$(cpp_echo) $(src)ICursorIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ICursorIterator_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ICursorIterator_cppflags) $(ICursorIterator_cpp_cppflags)  $(src)ICursorIterator.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(ICursorIterator_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)ICursorIterator.cpp

$(bin)$(binobj)ICursorIterator.o : $(ICursorIterator_cpp_dependencies)
	$(cpp_echo) $(src)ICursorIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(ICursorIterator_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(ICursorIterator_cppflags) $(ICursorIterator_cpp_cppflags)  $(src)ICursorIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_PyCoralclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Exception.d

$(bin)$(binobj)Exception.d :

$(bin)$(binobj)Exception.o : $(cmt_final_setup_lcg_PyCoral)

$(bin)$(binobj)Exception.o : $(src)Exception.cpp
	$(cpp_echo) $(src)Exception.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Exception_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Exception_cppflags) $(Exception_cpp_cppflags)  $(src)Exception.cpp
endif
endif

else
$(bin)lcg_PyCoral_dependencies.make : $(Exception_cpp_dependencies)

$(bin)lcg_PyCoral_dependencies.make : $(src)Exception.cpp

$(bin)$(binobj)Exception.o : $(Exception_cpp_dependencies)
	$(cpp_echo) $(src)Exception.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_PyCoral_pp_cppflags) $(lib_lcg_PyCoral_pp_cppflags) $(Exception_pp_cppflags) $(use_cppflags) $(lcg_PyCoral_cppflags) $(lib_lcg_PyCoral_cppflags) $(Exception_cppflags) $(Exception_cpp_cppflags)  $(src)Exception.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_PyCoralclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_PyCoral.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_PyCoralclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_PyCoral
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_PyCoral$(library_suffix).a $(library_prefix)lcg_PyCoral$(library_suffix).$(shlibsuffix) lcg_PyCoral.stamp lcg_PyCoral.shstamp
#-- end of cleanup_library ---------------
