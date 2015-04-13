#-- start of make_header -----------------

#====================================
#  Library lcg_MySQLAccess
#
#   Generated Tue Mar 31 10:22:27 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_MySQLAccess_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_MySQLAccess_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_MySQLAccess

MySQLAccess_tag = $(tag)

#cmt_local_tagfile_lcg_MySQLAccess = $(MySQLAccess_tag)_lcg_MySQLAccess.make
cmt_local_tagfile_lcg_MySQLAccess = $(bin)$(MySQLAccess_tag)_lcg_MySQLAccess.make

else

tags      = $(tag),$(CMTEXTRATAGS)

MySQLAccess_tag = $(tag)

#cmt_local_tagfile_lcg_MySQLAccess = $(MySQLAccess_tag).make
cmt_local_tagfile_lcg_MySQLAccess = $(bin)$(MySQLAccess_tag).make

endif

include $(cmt_local_tagfile_lcg_MySQLAccess)
#-include $(cmt_local_tagfile_lcg_MySQLAccess)

ifdef cmt_lcg_MySQLAccess_has_target_tag

cmt_final_setup_lcg_MySQLAccess = $(bin)setup_lcg_MySQLAccess.make
cmt_dependencies_in_lcg_MySQLAccess = $(bin)dependencies_lcg_MySQLAccess.in
#cmt_final_setup_lcg_MySQLAccess = $(bin)MySQLAccess_lcg_MySQLAccesssetup.make
cmt_local_lcg_MySQLAccess_makefile = $(bin)lcg_MySQLAccess.make

else

cmt_final_setup_lcg_MySQLAccess = $(bin)setup.make
cmt_dependencies_in_lcg_MySQLAccess = $(bin)dependencies.in
#cmt_final_setup_lcg_MySQLAccess = $(bin)MySQLAccesssetup.make
cmt_local_lcg_MySQLAccess_makefile = $(bin)lcg_MySQLAccess.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)MySQLAccesssetup.make

#lcg_MySQLAccess :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_MySQLAccess'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_MySQLAccess/
#lcg_MySQLAccess::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_MySQLAccesslibname   = $(bin)$(library_prefix)lcg_MySQLAccess$(library_suffix)
lcg_MySQLAccesslib       = $(lcg_MySQLAccesslibname).a
lcg_MySQLAccessstamp     = $(bin)lcg_MySQLAccess.stamp
lcg_MySQLAccessshstamp   = $(bin)lcg_MySQLAccess.shstamp

lcg_MySQLAccess :: dirs  lcg_MySQLAccessLIB
	$(echo) "lcg_MySQLAccess ok"

cmt_lcg_MySQLAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_MySQLAccess_has_prototypes

lcg_MySQLAccessprototype :  ;

endif

lcg_MySQLAccesscompile : $(bin)TableSchemaLoader.o $(bin)ColumnConstraint.o $(bin)Query.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ColumnDefinition.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)dosmap.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)TableSchemaEditor.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SchemaEditor.o $(bin)BulkDataCache.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)TableDDLBuilder.o $(bin)SchemaProperties.o $(bin)PreparedStatement.o $(bin)Statement.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_MySQLAccessLIB :: $(lcg_MySQLAccesslib) $(lcg_MySQLAccessshstamp)
	@/bin/echo "------> lcg_MySQLAccess : library ok"

$(lcg_MySQLAccesslib) :: $(bin)TableSchemaLoader.o $(bin)ColumnConstraint.o $(bin)Query.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ColumnDefinition.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)dosmap.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)TableSchemaEditor.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SchemaEditor.o $(bin)BulkDataCache.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)TableDDLBuilder.o $(bin)SchemaProperties.o $(bin)PreparedStatement.o $(bin)Statement.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_MySQLAccesslib) $?
	$(lib_silent) $(ranlib) $(lcg_MySQLAccesslib)
	$(lib_silent) cat /dev/null >$(lcg_MySQLAccessstamp)

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

$(lcg_MySQLAccesslibname).$(shlibsuffix) :: $(lcg_MySQLAccesslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_MySQLAccess $(lcg_MySQLAccess_shlibflags)

$(lcg_MySQLAccessshstamp) :: $(lcg_MySQLAccesslibname).$(shlibsuffix)
	@if test -f $(lcg_MySQLAccesslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_MySQLAccessshstamp) ; fi

lcg_MySQLAccessclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)TableSchemaLoader.o $(bin)ColumnConstraint.o $(bin)Query.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ColumnDefinition.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)dosmap.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)TableSchemaEditor.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SchemaEditor.o $(bin)BulkDataCache.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)TableDDLBuilder.o $(bin)SchemaProperties.o $(bin)PreparedStatement.o $(bin)Statement.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_MySQLAccessinstallname = $(library_prefix)lcg_MySQLAccess$(library_suffix).$(shlibsuffix)

lcg_MySQLAccess :: lcg_MySQLAccessinstall

install :: lcg_MySQLAccessinstall

lcg_MySQLAccessinstall :: $(install_dir)/$(lcg_MySQLAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_MySQLAccessinstallname) :: $(bin)$(lcg_MySQLAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_MySQLAccessinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_MySQLAccessclean :: lcg_MySQLAccessuninstall

uninstall :: lcg_MySQLAccessuninstall

lcg_MySQLAccessuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_MySQLAccessinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_MySQLAccessprototype)

$(bin)lcg_MySQLAccess_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_MySQLAccess)
	$(echo) "(lcg_MySQLAccess.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)TableSchemaLoader.cpp $(src)ColumnConstraint.cpp $(src)Query.cpp $(src)Table.cpp $(src)Transaction.cpp $(src)QueryDefinition.cpp $(src)Schema.cpp $(src)Cursor.cpp $(src)NamedInputParametersParser.cpp $(src)ColumnDefinition.cpp $(src)ErrorHandler.cpp $(src)Session.cpp $(src)dosmap.cpp $(src)module.cpp $(src)MonitorController.cpp $(src)TypeConverter.cpp $(src)OperationWithQuery.cpp $(src)PrivilegeManager.cpp $(src)TableSchemaEditor.cpp $(src)ViewFactory.cpp $(src)BulkOperation.cpp $(src)Connection.cpp $(src)DataEditor.cpp $(src)BulkOperationWithQuery.cpp $(src)DomainProperties.cpp $(src)SchemaEditor.cpp $(src)BulkDataCache.cpp $(src)SessionProperties.cpp $(src)Domain.cpp $(src)TableDDLBuilder.cpp $(src)SchemaProperties.cpp $(src)PreparedStatement.cpp $(src)Statement.cpp -end_all $(includes) $(app_lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) -name=lcg_MySQLAccess $? -f=$(cmt_dependencies_in_lcg_MySQLAccess) -without_cmt

-include $(bin)lcg_MySQLAccess_dependencies.make

endif
endif
endif

lcg_MySQLAccessclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_MySQLAccess_deps $(bin)lcg_MySQLAccess_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableSchemaLoader.d

$(bin)$(binobj)TableSchemaLoader.d :

$(bin)$(binobj)TableSchemaLoader.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)TableSchemaLoader.o : $(src)TableSchemaLoader.cpp
	$(cpp_echo) $(src)TableSchemaLoader.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableSchemaLoader_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableSchemaLoader_cppflags) $(TableSchemaLoader_cpp_cppflags)  $(src)TableSchemaLoader.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(TableSchemaLoader_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)TableSchemaLoader.cpp

$(bin)$(binobj)TableSchemaLoader.o : $(TableSchemaLoader_cpp_dependencies)
	$(cpp_echo) $(src)TableSchemaLoader.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableSchemaLoader_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableSchemaLoader_cppflags) $(TableSchemaLoader_cpp_cppflags)  $(src)TableSchemaLoader.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ColumnConstraint.d

$(bin)$(binobj)ColumnConstraint.d :

$(bin)$(binobj)ColumnConstraint.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)ColumnConstraint.o : $(src)ColumnConstraint.cpp
	$(cpp_echo) $(src)ColumnConstraint.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ColumnConstraint_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ColumnConstraint_cppflags) $(ColumnConstraint_cpp_cppflags)  $(src)ColumnConstraint.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(ColumnConstraint_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)ColumnConstraint.cpp

$(bin)$(binobj)ColumnConstraint.o : $(ColumnConstraint_cpp_dependencies)
	$(cpp_echo) $(src)ColumnConstraint.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ColumnConstraint_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ColumnConstraint_cppflags) $(ColumnConstraint_cpp_cppflags)  $(src)ColumnConstraint.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Query.d

$(bin)$(binobj)Query.d :

$(bin)$(binobj)Query.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Query.o : $(src)Query.cpp
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Query_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Query.cpp

$(bin)$(binobj)Query.o : $(Query_cpp_dependencies)
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Table.d

$(bin)$(binobj)Table.d :

$(bin)$(binobj)Table.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Table.o : $(src)Table.cpp
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Table_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Table.cpp

$(bin)$(binobj)Table.o : $(Table_cpp_dependencies)
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Transaction.d

$(bin)$(binobj)Transaction.d :

$(bin)$(binobj)Transaction.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Transaction.o : $(src)Transaction.cpp
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Transaction_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Transaction.cpp

$(bin)$(binobj)Transaction.o : $(Transaction_cpp_dependencies)
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryDefinition.d

$(bin)$(binobj)QueryDefinition.d :

$(bin)$(binobj)QueryDefinition.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)QueryDefinition.o : $(src)QueryDefinition.cpp
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(QueryDefinition_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)QueryDefinition.cpp

$(bin)$(binobj)QueryDefinition.o : $(QueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Schema.d

$(bin)$(binobj)Schema.d :

$(bin)$(binobj)Schema.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Schema.o : $(src)Schema.cpp
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Schema_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Schema.cpp

$(bin)$(binobj)Schema.o : $(Schema_cpp_dependencies)
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cursor.d

$(bin)$(binobj)Cursor.d :

$(bin)$(binobj)Cursor.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Cursor.o : $(src)Cursor.cpp
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Cursor_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Cursor.cpp

$(bin)$(binobj)Cursor.o : $(Cursor_cpp_dependencies)
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NamedInputParametersParser.d

$(bin)$(binobj)NamedInputParametersParser.d :

$(bin)$(binobj)NamedInputParametersParser.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)NamedInputParametersParser.o : $(src)NamedInputParametersParser.cpp
	$(cpp_echo) $(src)NamedInputParametersParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(NamedInputParametersParser_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(NamedInputParametersParser_cppflags) $(NamedInputParametersParser_cpp_cppflags)  $(src)NamedInputParametersParser.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(NamedInputParametersParser_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)NamedInputParametersParser.cpp

$(bin)$(binobj)NamedInputParametersParser.o : $(NamedInputParametersParser_cpp_dependencies)
	$(cpp_echo) $(src)NamedInputParametersParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(NamedInputParametersParser_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(NamedInputParametersParser_cppflags) $(NamedInputParametersParser_cpp_cppflags)  $(src)NamedInputParametersParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ColumnDefinition.d

$(bin)$(binobj)ColumnDefinition.d :

$(bin)$(binobj)ColumnDefinition.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)ColumnDefinition.o : $(src)ColumnDefinition.cpp
	$(cpp_echo) $(src)ColumnDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ColumnDefinition_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ColumnDefinition_cppflags) $(ColumnDefinition_cpp_cppflags)  $(src)ColumnDefinition.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(ColumnDefinition_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)ColumnDefinition.cpp

$(bin)$(binobj)ColumnDefinition.o : $(ColumnDefinition_cpp_dependencies)
	$(cpp_echo) $(src)ColumnDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ColumnDefinition_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ColumnDefinition_cppflags) $(ColumnDefinition_cpp_cppflags)  $(src)ColumnDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ErrorHandler.d

$(bin)$(binobj)ErrorHandler.d :

$(bin)$(binobj)ErrorHandler.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)ErrorHandler.o : $(src)ErrorHandler.cpp
	$(cpp_echo) $(src)ErrorHandler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ErrorHandler_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ErrorHandler_cppflags) $(ErrorHandler_cpp_cppflags)  $(src)ErrorHandler.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(ErrorHandler_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)ErrorHandler.cpp

$(bin)$(binobj)ErrorHandler.o : $(ErrorHandler_cpp_dependencies)
	$(cpp_echo) $(src)ErrorHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ErrorHandler_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ErrorHandler_cppflags) $(ErrorHandler_cpp_cppflags)  $(src)ErrorHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Session.d

$(bin)$(binobj)Session.d :

$(bin)$(binobj)Session.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Session.o : $(src)Session.cpp
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Session_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Session.cpp

$(bin)$(binobj)Session.o : $(Session_cpp_dependencies)
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)dosmap.d

$(bin)$(binobj)dosmap.d :

$(bin)$(binobj)dosmap.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)dosmap.o : $(src)dosmap.cpp
	$(cpp_echo) $(src)dosmap.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(dosmap_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(dosmap_cppflags) $(dosmap_cpp_cppflags)  $(src)dosmap.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(dosmap_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)dosmap.cpp

$(bin)$(binobj)dosmap.o : $(dosmap_cpp_dependencies)
	$(cpp_echo) $(src)dosmap.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(dosmap_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(dosmap_cppflags) $(dosmap_cpp_cppflags)  $(src)dosmap.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MonitorController.d

$(bin)$(binobj)MonitorController.d :

$(bin)$(binobj)MonitorController.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)MonitorController.o : $(src)MonitorController.cpp
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(MonitorController_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)MonitorController.cpp

$(bin)$(binobj)MonitorController.o : $(MonitorController_cpp_dependencies)
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TypeConverter.d

$(bin)$(binobj)TypeConverter.d :

$(bin)$(binobj)TypeConverter.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)TypeConverter.o : $(src)TypeConverter.cpp
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(TypeConverter_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)TypeConverter.cpp

$(bin)$(binobj)TypeConverter.o : $(TypeConverter_cpp_dependencies)
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OperationWithQuery.d

$(bin)$(binobj)OperationWithQuery.d :

$(bin)$(binobj)OperationWithQuery.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)OperationWithQuery.o : $(src)OperationWithQuery.cpp
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(OperationWithQuery_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)OperationWithQuery.cpp

$(bin)$(binobj)OperationWithQuery.o : $(OperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PrivilegeManager.d

$(bin)$(binobj)PrivilegeManager.d :

$(bin)$(binobj)PrivilegeManager.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)PrivilegeManager.o : $(src)PrivilegeManager.cpp
	$(cpp_echo) $(src)PrivilegeManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(PrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(PrivilegeManager_cppflags) $(PrivilegeManager_cpp_cppflags)  $(src)PrivilegeManager.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(PrivilegeManager_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)PrivilegeManager.cpp

$(bin)$(binobj)PrivilegeManager.o : $(PrivilegeManager_cpp_dependencies)
	$(cpp_echo) $(src)PrivilegeManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(PrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(PrivilegeManager_cppflags) $(PrivilegeManager_cpp_cppflags)  $(src)PrivilegeManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableSchemaEditor.d

$(bin)$(binobj)TableSchemaEditor.d :

$(bin)$(binobj)TableSchemaEditor.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)TableSchemaEditor.o : $(src)TableSchemaEditor.cpp
	$(cpp_echo) $(src)TableSchemaEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableSchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableSchemaEditor_cppflags) $(TableSchemaEditor_cpp_cppflags)  $(src)TableSchemaEditor.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(TableSchemaEditor_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)TableSchemaEditor.cpp

$(bin)$(binobj)TableSchemaEditor.o : $(TableSchemaEditor_cpp_dependencies)
	$(cpp_echo) $(src)TableSchemaEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableSchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableSchemaEditor_cppflags) $(TableSchemaEditor_cpp_cppflags)  $(src)TableSchemaEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ViewFactory.d

$(bin)$(binobj)ViewFactory.d :

$(bin)$(binobj)ViewFactory.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)ViewFactory.o : $(src)ViewFactory.cpp
	$(cpp_echo) $(src)ViewFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ViewFactory_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ViewFactory_cppflags) $(ViewFactory_cpp_cppflags)  $(src)ViewFactory.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(ViewFactory_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)ViewFactory.cpp

$(bin)$(binobj)ViewFactory.o : $(ViewFactory_cpp_dependencies)
	$(cpp_echo) $(src)ViewFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(ViewFactory_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(ViewFactory_cppflags) $(ViewFactory_cpp_cppflags)  $(src)ViewFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BulkOperation.d

$(bin)$(binobj)BulkOperation.d :

$(bin)$(binobj)BulkOperation.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)BulkOperation.o : $(src)BulkOperation.cpp
	$(cpp_echo) $(src)BulkOperation.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkOperation_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkOperation_cppflags) $(BulkOperation_cpp_cppflags)  $(src)BulkOperation.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(BulkOperation_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)BulkOperation.cpp

$(bin)$(binobj)BulkOperation.o : $(BulkOperation_cpp_dependencies)
	$(cpp_echo) $(src)BulkOperation.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkOperation_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkOperation_cppflags) $(BulkOperation_cpp_cppflags)  $(src)BulkOperation.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Connection.d

$(bin)$(binobj)Connection.d :

$(bin)$(binobj)Connection.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Connection.o : $(src)Connection.cpp
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Connection_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Connection.cpp

$(bin)$(binobj)Connection.o : $(Connection_cpp_dependencies)
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataEditor.d

$(bin)$(binobj)DataEditor.d :

$(bin)$(binobj)DataEditor.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)DataEditor.o : $(src)DataEditor.cpp
	$(cpp_echo) $(src)DataEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(DataEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(DataEditor_cppflags) $(DataEditor_cpp_cppflags)  $(src)DataEditor.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(DataEditor_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)DataEditor.cpp

$(bin)$(binobj)DataEditor.o : $(DataEditor_cpp_dependencies)
	$(cpp_echo) $(src)DataEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(DataEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(DataEditor_cppflags) $(DataEditor_cpp_cppflags)  $(src)DataEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BulkOperationWithQuery.d

$(bin)$(binobj)BulkOperationWithQuery.d :

$(bin)$(binobj)BulkOperationWithQuery.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)BulkOperationWithQuery.o : $(src)BulkOperationWithQuery.cpp
	$(cpp_echo) $(src)BulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkOperationWithQuery_cppflags) $(BulkOperationWithQuery_cpp_cppflags)  $(src)BulkOperationWithQuery.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(BulkOperationWithQuery_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)BulkOperationWithQuery.cpp

$(bin)$(binobj)BulkOperationWithQuery.o : $(BulkOperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)BulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkOperationWithQuery_cppflags) $(BulkOperationWithQuery_cpp_cppflags)  $(src)BulkOperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DomainProperties.d

$(bin)$(binobj)DomainProperties.d :

$(bin)$(binobj)DomainProperties.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)DomainProperties.o : $(src)DomainProperties.cpp
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(DomainProperties_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)DomainProperties.cpp

$(bin)$(binobj)DomainProperties.o : $(DomainProperties_cpp_dependencies)
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SchemaEditor.d

$(bin)$(binobj)SchemaEditor.d :

$(bin)$(binobj)SchemaEditor.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)SchemaEditor.o : $(src)SchemaEditor.cpp
	$(cpp_echo) $(src)SchemaEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SchemaEditor_cppflags) $(SchemaEditor_cpp_cppflags)  $(src)SchemaEditor.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(SchemaEditor_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)SchemaEditor.cpp

$(bin)$(binobj)SchemaEditor.o : $(SchemaEditor_cpp_dependencies)
	$(cpp_echo) $(src)SchemaEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SchemaEditor_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SchemaEditor_cppflags) $(SchemaEditor_cpp_cppflags)  $(src)SchemaEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BulkDataCache.d

$(bin)$(binobj)BulkDataCache.d :

$(bin)$(binobj)BulkDataCache.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)BulkDataCache.o : $(src)BulkDataCache.cpp
	$(cpp_echo) $(src)BulkDataCache.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkDataCache_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkDataCache_cppflags) $(BulkDataCache_cpp_cppflags)  $(src)BulkDataCache.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(BulkDataCache_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)BulkDataCache.cpp

$(bin)$(binobj)BulkDataCache.o : $(BulkDataCache_cpp_dependencies)
	$(cpp_echo) $(src)BulkDataCache.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(BulkDataCache_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(BulkDataCache_cppflags) $(BulkDataCache_cpp_cppflags)  $(src)BulkDataCache.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionProperties.d

$(bin)$(binobj)SessionProperties.d :

$(bin)$(binobj)SessionProperties.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)SessionProperties.o : $(src)SessionProperties.cpp
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(SessionProperties_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)SessionProperties.cpp

$(bin)$(binobj)SessionProperties.o : $(SessionProperties_cpp_dependencies)
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Domain.d

$(bin)$(binobj)Domain.d :

$(bin)$(binobj)Domain.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Domain.o : $(src)Domain.cpp
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Domain_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Domain.cpp

$(bin)$(binobj)Domain.o : $(Domain_cpp_dependencies)
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDDLBuilder.d

$(bin)$(binobj)TableDDLBuilder.d :

$(bin)$(binobj)TableDDLBuilder.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)TableDDLBuilder.o : $(src)TableDDLBuilder.cpp
	$(cpp_echo) $(src)TableDDLBuilder.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableDDLBuilder_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableDDLBuilder_cppflags) $(TableDDLBuilder_cpp_cppflags)  $(src)TableDDLBuilder.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(TableDDLBuilder_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)TableDDLBuilder.cpp

$(bin)$(binobj)TableDDLBuilder.o : $(TableDDLBuilder_cpp_dependencies)
	$(cpp_echo) $(src)TableDDLBuilder.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(TableDDLBuilder_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(TableDDLBuilder_cppflags) $(TableDDLBuilder_cpp_cppflags)  $(src)TableDDLBuilder.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SchemaProperties.d

$(bin)$(binobj)SchemaProperties.d :

$(bin)$(binobj)SchemaProperties.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)SchemaProperties.o : $(src)SchemaProperties.cpp
	$(cpp_echo) $(src)SchemaProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SchemaProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SchemaProperties_cppflags) $(SchemaProperties_cpp_cppflags)  $(src)SchemaProperties.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(SchemaProperties_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)SchemaProperties.cpp

$(bin)$(binobj)SchemaProperties.o : $(SchemaProperties_cpp_dependencies)
	$(cpp_echo) $(src)SchemaProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(SchemaProperties_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(SchemaProperties_cppflags) $(SchemaProperties_cpp_cppflags)  $(src)SchemaProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PreparedStatement.d

$(bin)$(binobj)PreparedStatement.d :

$(bin)$(binobj)PreparedStatement.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)PreparedStatement.o : $(src)PreparedStatement.cpp
	$(cpp_echo) $(src)PreparedStatement.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(PreparedStatement_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(PreparedStatement_cppflags) $(PreparedStatement_cpp_cppflags)  $(src)PreparedStatement.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(PreparedStatement_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)PreparedStatement.cpp

$(bin)$(binobj)PreparedStatement.o : $(PreparedStatement_cpp_dependencies)
	$(cpp_echo) $(src)PreparedStatement.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(PreparedStatement_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(PreparedStatement_cppflags) $(PreparedStatement_cpp_cppflags)  $(src)PreparedStatement.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_MySQLAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Statement.d

$(bin)$(binobj)Statement.d :

$(bin)$(binobj)Statement.o : $(cmt_final_setup_lcg_MySQLAccess)

$(bin)$(binobj)Statement.o : $(src)Statement.cpp
	$(cpp_echo) $(src)Statement.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Statement_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Statement_cppflags) $(Statement_cpp_cppflags)  $(src)Statement.cpp
endif
endif

else
$(bin)lcg_MySQLAccess_dependencies.make : $(Statement_cpp_dependencies)

$(bin)lcg_MySQLAccess_dependencies.make : $(src)Statement.cpp

$(bin)$(binobj)Statement.o : $(Statement_cpp_dependencies)
	$(cpp_echo) $(src)Statement.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_MySQLAccess_pp_cppflags) $(lib_lcg_MySQLAccess_pp_cppflags) $(Statement_pp_cppflags) $(use_cppflags) $(lcg_MySQLAccess_cppflags) $(lib_lcg_MySQLAccess_cppflags) $(Statement_cppflags) $(Statement_cpp_cppflags)  $(src)Statement.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_MySQLAccessclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_MySQLAccess.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_MySQLAccessclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_MySQLAccess
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_MySQLAccess$(library_suffix).a $(library_prefix)lcg_MySQLAccess$(library_suffix).$(shlibsuffix) lcg_MySQLAccess.stamp lcg_MySQLAccess.shstamp
#-- end of cleanup_library ---------------
