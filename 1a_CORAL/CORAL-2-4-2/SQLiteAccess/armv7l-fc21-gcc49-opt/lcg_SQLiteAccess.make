#-- start of make_header -----------------

#====================================
#  Library lcg_SQLiteAccess
#
#   Generated Wed Apr 15 16:30:45 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_SQLiteAccess_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_SQLiteAccess_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_SQLiteAccess

SQLiteAccess_tag = $(tag)

#cmt_local_tagfile_lcg_SQLiteAccess = $(SQLiteAccess_tag)_lcg_SQLiteAccess.make
cmt_local_tagfile_lcg_SQLiteAccess = $(bin)$(SQLiteAccess_tag)_lcg_SQLiteAccess.make

else

tags      = $(tag),$(CMTEXTRATAGS)

SQLiteAccess_tag = $(tag)

#cmt_local_tagfile_lcg_SQLiteAccess = $(SQLiteAccess_tag).make
cmt_local_tagfile_lcg_SQLiteAccess = $(bin)$(SQLiteAccess_tag).make

endif

include $(cmt_local_tagfile_lcg_SQLiteAccess)
#-include $(cmt_local_tagfile_lcg_SQLiteAccess)

ifdef cmt_lcg_SQLiteAccess_has_target_tag

cmt_final_setup_lcg_SQLiteAccess = $(bin)setup_lcg_SQLiteAccess.make
cmt_dependencies_in_lcg_SQLiteAccess = $(bin)dependencies_lcg_SQLiteAccess.in
#cmt_final_setup_lcg_SQLiteAccess = $(bin)SQLiteAccess_lcg_SQLiteAccesssetup.make
cmt_local_lcg_SQLiteAccess_makefile = $(bin)lcg_SQLiteAccess.make

else

cmt_final_setup_lcg_SQLiteAccess = $(bin)setup.make
cmt_dependencies_in_lcg_SQLiteAccess = $(bin)dependencies.in
#cmt_final_setup_lcg_SQLiteAccess = $(bin)SQLiteAccesssetup.make
cmt_local_lcg_SQLiteAccess_makefile = $(bin)lcg_SQLiteAccess.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)SQLiteAccesssetup.make

#lcg_SQLiteAccess :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_SQLiteAccess'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_SQLiteAccess/
#lcg_SQLiteAccess::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_SQLiteAccesslibname   = $(bin)$(library_prefix)lcg_SQLiteAccess$(library_suffix)
lcg_SQLiteAccesslib       = $(lcg_SQLiteAccesslibname).a
lcg_SQLiteAccessstamp     = $(bin)lcg_SQLiteAccess.stamp
lcg_SQLiteAccessshstamp   = $(bin)lcg_SQLiteAccess.shstamp

lcg_SQLiteAccess :: dirs  lcg_SQLiteAccessLIB
	$(echo) "lcg_SQLiteAccess ok"

cmt_lcg_SQLiteAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_SQLiteAccess_has_prototypes

lcg_SQLiteAccessprototype :  ;

endif

lcg_SQLiteAccesscompile : $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)SQLiteStatement.o $(bin)Cursor.o $(bin)SQLiteTableBuilder.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)SQLiteExpressionParser.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_SQLiteAccessLIB :: $(lcg_SQLiteAccesslib) $(lcg_SQLiteAccessshstamp)
	@/bin/echo "------> lcg_SQLiteAccess : library ok"

$(lcg_SQLiteAccesslib) :: $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)SQLiteStatement.o $(bin)Cursor.o $(bin)SQLiteTableBuilder.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)SQLiteExpressionParser.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_SQLiteAccesslib) $?
	$(lib_silent) $(ranlib) $(lcg_SQLiteAccesslib)
	$(lib_silent) cat /dev/null >$(lcg_SQLiteAccessstamp)

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

$(lcg_SQLiteAccesslibname).$(shlibsuffix) :: $(lcg_SQLiteAccesslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_SQLiteAccess $(lcg_SQLiteAccess_shlibflags)

$(lcg_SQLiteAccessshstamp) :: $(lcg_SQLiteAccesslibname).$(shlibsuffix)
	@if test -f $(lcg_SQLiteAccesslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_SQLiteAccessshstamp) ; fi

lcg_SQLiteAccessclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)SQLiteStatement.o $(bin)Cursor.o $(bin)SQLiteTableBuilder.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)PrivilegeManager.o $(bin)ViewFactory.o $(bin)BulkOperation.o $(bin)Connection.o $(bin)SQLiteExpressionParser.o $(bin)DataEditor.o $(bin)BulkOperationWithQuery.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_SQLiteAccessinstallname = $(library_prefix)lcg_SQLiteAccess$(library_suffix).$(shlibsuffix)

lcg_SQLiteAccess :: lcg_SQLiteAccessinstall

install :: lcg_SQLiteAccessinstall

lcg_SQLiteAccessinstall :: $(install_dir)/$(lcg_SQLiteAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_SQLiteAccessinstallname) :: $(bin)$(lcg_SQLiteAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_SQLiteAccessinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_SQLiteAccessclean :: lcg_SQLiteAccessuninstall

uninstall :: lcg_SQLiteAccessuninstall

lcg_SQLiteAccessuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_SQLiteAccessinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessprototype)

$(bin)lcg_SQLiteAccess_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_SQLiteAccess)
	$(echo) "(lcg_SQLiteAccess.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)View.cpp $(src)Query.cpp $(src)TableDescriptionProxy.cpp $(src)ColumnProxy.cpp $(src)Table.cpp $(src)ConnectionProperties.cpp $(src)Transaction.cpp $(src)QueryDefinition.cpp $(src)Schema.cpp $(src)SQLiteStatement.cpp $(src)Cursor.cpp $(src)SQLiteTableBuilder.cpp $(src)Session.cpp $(src)module.cpp $(src)MonitorController.cpp $(src)TypeConverter.cpp $(src)OperationWithQuery.cpp $(src)PrivilegeManager.cpp $(src)ViewFactory.cpp $(src)BulkOperation.cpp $(src)Connection.cpp $(src)SQLiteExpressionParser.cpp $(src)DataEditor.cpp $(src)BulkOperationWithQuery.cpp $(src)DomainProperties.cpp $(src)SessionProperties.cpp $(src)Domain.cpp -end_all $(includes) $(app_lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) -name=lcg_SQLiteAccess $? -f=$(cmt_dependencies_in_lcg_SQLiteAccess) -without_cmt

-include $(bin)lcg_SQLiteAccess_dependencies.make

endif
endif
endif

lcg_SQLiteAccessclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_SQLiteAccess_deps $(bin)lcg_SQLiteAccess_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)View.d

$(bin)$(binobj)View.d :

$(bin)$(binobj)View.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)View.o : $(src)View.cpp
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(View_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)View.cpp

$(bin)$(binobj)View.o : $(View_cpp_dependencies)
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Query.d

$(bin)$(binobj)Query.d :

$(bin)$(binobj)Query.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Query.o : $(src)Query.cpp
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Query_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Query.cpp

$(bin)$(binobj)Query.o : $(Query_cpp_dependencies)
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDescriptionProxy.d

$(bin)$(binobj)TableDescriptionProxy.d :

$(bin)$(binobj)TableDescriptionProxy.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)TableDescriptionProxy.o : $(src)TableDescriptionProxy.cpp
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(TableDescriptionProxy_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)TableDescriptionProxy.cpp

$(bin)$(binobj)TableDescriptionProxy.o : $(TableDescriptionProxy_cpp_dependencies)
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ColumnProxy.d

$(bin)$(binobj)ColumnProxy.d :

$(bin)$(binobj)ColumnProxy.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)ColumnProxy.o : $(src)ColumnProxy.cpp
	$(cpp_echo) $(src)ColumnProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ColumnProxy_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ColumnProxy_cppflags) $(ColumnProxy_cpp_cppflags)  $(src)ColumnProxy.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(ColumnProxy_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)ColumnProxy.cpp

$(bin)$(binobj)ColumnProxy.o : $(ColumnProxy_cpp_dependencies)
	$(cpp_echo) $(src)ColumnProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ColumnProxy_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ColumnProxy_cppflags) $(ColumnProxy_cpp_cppflags)  $(src)ColumnProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Table.d

$(bin)$(binobj)Table.d :

$(bin)$(binobj)Table.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Table.o : $(src)Table.cpp
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Table_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Table.cpp

$(bin)$(binobj)Table.o : $(Table_cpp_dependencies)
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionProperties.d

$(bin)$(binobj)ConnectionProperties.d :

$(bin)$(binobj)ConnectionProperties.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)ConnectionProperties.o : $(src)ConnectionProperties.cpp
	$(cpp_echo) $(src)ConnectionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ConnectionProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ConnectionProperties_cppflags) $(ConnectionProperties_cpp_cppflags)  $(src)ConnectionProperties.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(ConnectionProperties_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)ConnectionProperties.cpp

$(bin)$(binobj)ConnectionProperties.o : $(ConnectionProperties_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ConnectionProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ConnectionProperties_cppflags) $(ConnectionProperties_cpp_cppflags)  $(src)ConnectionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Transaction.d

$(bin)$(binobj)Transaction.d :

$(bin)$(binobj)Transaction.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Transaction.o : $(src)Transaction.cpp
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Transaction_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Transaction.cpp

$(bin)$(binobj)Transaction.o : $(Transaction_cpp_dependencies)
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryDefinition.d

$(bin)$(binobj)QueryDefinition.d :

$(bin)$(binobj)QueryDefinition.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)QueryDefinition.o : $(src)QueryDefinition.cpp
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(QueryDefinition_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)QueryDefinition.cpp

$(bin)$(binobj)QueryDefinition.o : $(QueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Schema.d

$(bin)$(binobj)Schema.d :

$(bin)$(binobj)Schema.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Schema.o : $(src)Schema.cpp
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Schema_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Schema.cpp

$(bin)$(binobj)Schema.o : $(Schema_cpp_dependencies)
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SQLiteStatement.d

$(bin)$(binobj)SQLiteStatement.d :

$(bin)$(binobj)SQLiteStatement.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)SQLiteStatement.o : $(src)SQLiteStatement.cpp
	$(cpp_echo) $(src)SQLiteStatement.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteStatement_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteStatement_cppflags) $(SQLiteStatement_cpp_cppflags)  $(src)SQLiteStatement.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(SQLiteStatement_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)SQLiteStatement.cpp

$(bin)$(binobj)SQLiteStatement.o : $(SQLiteStatement_cpp_dependencies)
	$(cpp_echo) $(src)SQLiteStatement.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteStatement_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteStatement_cppflags) $(SQLiteStatement_cpp_cppflags)  $(src)SQLiteStatement.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cursor.d

$(bin)$(binobj)Cursor.d :

$(bin)$(binobj)Cursor.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Cursor.o : $(src)Cursor.cpp
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Cursor_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Cursor.cpp

$(bin)$(binobj)Cursor.o : $(Cursor_cpp_dependencies)
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SQLiteTableBuilder.d

$(bin)$(binobj)SQLiteTableBuilder.d :

$(bin)$(binobj)SQLiteTableBuilder.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)SQLiteTableBuilder.o : $(src)SQLiteTableBuilder.cpp
	$(cpp_echo) $(src)SQLiteTableBuilder.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteTableBuilder_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteTableBuilder_cppflags) $(SQLiteTableBuilder_cpp_cppflags)  $(src)SQLiteTableBuilder.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(SQLiteTableBuilder_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)SQLiteTableBuilder.cpp

$(bin)$(binobj)SQLiteTableBuilder.o : $(SQLiteTableBuilder_cpp_dependencies)
	$(cpp_echo) $(src)SQLiteTableBuilder.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteTableBuilder_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteTableBuilder_cppflags) $(SQLiteTableBuilder_cpp_cppflags)  $(src)SQLiteTableBuilder.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Session.d

$(bin)$(binobj)Session.d :

$(bin)$(binobj)Session.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Session.o : $(src)Session.cpp
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Session_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Session.cpp

$(bin)$(binobj)Session.o : $(Session_cpp_dependencies)
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MonitorController.d

$(bin)$(binobj)MonitorController.d :

$(bin)$(binobj)MonitorController.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)MonitorController.o : $(src)MonitorController.cpp
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(MonitorController_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)MonitorController.cpp

$(bin)$(binobj)MonitorController.o : $(MonitorController_cpp_dependencies)
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TypeConverter.d

$(bin)$(binobj)TypeConverter.d :

$(bin)$(binobj)TypeConverter.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)TypeConverter.o : $(src)TypeConverter.cpp
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(TypeConverter_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)TypeConverter.cpp

$(bin)$(binobj)TypeConverter.o : $(TypeConverter_cpp_dependencies)
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OperationWithQuery.d

$(bin)$(binobj)OperationWithQuery.d :

$(bin)$(binobj)OperationWithQuery.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)OperationWithQuery.o : $(src)OperationWithQuery.cpp
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(OperationWithQuery_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)OperationWithQuery.cpp

$(bin)$(binobj)OperationWithQuery.o : $(OperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PrivilegeManager.d

$(bin)$(binobj)PrivilegeManager.d :

$(bin)$(binobj)PrivilegeManager.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)PrivilegeManager.o : $(src)PrivilegeManager.cpp
	$(cpp_echo) $(src)PrivilegeManager.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(PrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(PrivilegeManager_cppflags) $(PrivilegeManager_cpp_cppflags)  $(src)PrivilegeManager.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(PrivilegeManager_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)PrivilegeManager.cpp

$(bin)$(binobj)PrivilegeManager.o : $(PrivilegeManager_cpp_dependencies)
	$(cpp_echo) $(src)PrivilegeManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(PrivilegeManager_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(PrivilegeManager_cppflags) $(PrivilegeManager_cpp_cppflags)  $(src)PrivilegeManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ViewFactory.d

$(bin)$(binobj)ViewFactory.d :

$(bin)$(binobj)ViewFactory.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)ViewFactory.o : $(src)ViewFactory.cpp
	$(cpp_echo) $(src)ViewFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ViewFactory_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ViewFactory_cppflags) $(ViewFactory_cpp_cppflags)  $(src)ViewFactory.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(ViewFactory_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)ViewFactory.cpp

$(bin)$(binobj)ViewFactory.o : $(ViewFactory_cpp_dependencies)
	$(cpp_echo) $(src)ViewFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(ViewFactory_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(ViewFactory_cppflags) $(ViewFactory_cpp_cppflags)  $(src)ViewFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BulkOperation.d

$(bin)$(binobj)BulkOperation.d :

$(bin)$(binobj)BulkOperation.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)BulkOperation.o : $(src)BulkOperation.cpp
	$(cpp_echo) $(src)BulkOperation.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(BulkOperation_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(BulkOperation_cppflags) $(BulkOperation_cpp_cppflags)  $(src)BulkOperation.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(BulkOperation_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)BulkOperation.cpp

$(bin)$(binobj)BulkOperation.o : $(BulkOperation_cpp_dependencies)
	$(cpp_echo) $(src)BulkOperation.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(BulkOperation_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(BulkOperation_cppflags) $(BulkOperation_cpp_cppflags)  $(src)BulkOperation.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Connection.d

$(bin)$(binobj)Connection.d :

$(bin)$(binobj)Connection.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Connection.o : $(src)Connection.cpp
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Connection_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Connection.cpp

$(bin)$(binobj)Connection.o : $(Connection_cpp_dependencies)
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SQLiteExpressionParser.d

$(bin)$(binobj)SQLiteExpressionParser.d :

$(bin)$(binobj)SQLiteExpressionParser.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)SQLiteExpressionParser.o : $(src)SQLiteExpressionParser.cpp
	$(cpp_echo) $(src)SQLiteExpressionParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteExpressionParser_cppflags) $(SQLiteExpressionParser_cpp_cppflags)  $(src)SQLiteExpressionParser.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(SQLiteExpressionParser_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)SQLiteExpressionParser.cpp

$(bin)$(binobj)SQLiteExpressionParser.o : $(SQLiteExpressionParser_cpp_dependencies)
	$(cpp_echo) $(src)SQLiteExpressionParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SQLiteExpressionParser_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SQLiteExpressionParser_cppflags) $(SQLiteExpressionParser_cpp_cppflags)  $(src)SQLiteExpressionParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataEditor.d

$(bin)$(binobj)DataEditor.d :

$(bin)$(binobj)DataEditor.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)DataEditor.o : $(src)DataEditor.cpp
	$(cpp_echo) $(src)DataEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(DataEditor_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(DataEditor_cppflags) $(DataEditor_cpp_cppflags)  $(src)DataEditor.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(DataEditor_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)DataEditor.cpp

$(bin)$(binobj)DataEditor.o : $(DataEditor_cpp_dependencies)
	$(cpp_echo) $(src)DataEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(DataEditor_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(DataEditor_cppflags) $(DataEditor_cpp_cppflags)  $(src)DataEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)BulkOperationWithQuery.d

$(bin)$(binobj)BulkOperationWithQuery.d :

$(bin)$(binobj)BulkOperationWithQuery.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)BulkOperationWithQuery.o : $(src)BulkOperationWithQuery.cpp
	$(cpp_echo) $(src)BulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(BulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(BulkOperationWithQuery_cppflags) $(BulkOperationWithQuery_cpp_cppflags)  $(src)BulkOperationWithQuery.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(BulkOperationWithQuery_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)BulkOperationWithQuery.cpp

$(bin)$(binobj)BulkOperationWithQuery.o : $(BulkOperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)BulkOperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(BulkOperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(BulkOperationWithQuery_cppflags) $(BulkOperationWithQuery_cpp_cppflags)  $(src)BulkOperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DomainProperties.d

$(bin)$(binobj)DomainProperties.d :

$(bin)$(binobj)DomainProperties.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)DomainProperties.o : $(src)DomainProperties.cpp
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(DomainProperties_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)DomainProperties.cpp

$(bin)$(binobj)DomainProperties.o : $(DomainProperties_cpp_dependencies)
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionProperties.d

$(bin)$(binobj)SessionProperties.d :

$(bin)$(binobj)SessionProperties.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)SessionProperties.o : $(src)SessionProperties.cpp
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(SessionProperties_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)SessionProperties.cpp

$(bin)$(binobj)SessionProperties.o : $(SessionProperties_cpp_dependencies)
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_SQLiteAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Domain.d

$(bin)$(binobj)Domain.d :

$(bin)$(binobj)Domain.o : $(cmt_final_setup_lcg_SQLiteAccess)

$(bin)$(binobj)Domain.o : $(src)Domain.cpp
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp
endif
endif

else
$(bin)lcg_SQLiteAccess_dependencies.make : $(Domain_cpp_dependencies)

$(bin)lcg_SQLiteAccess_dependencies.make : $(src)Domain.cpp

$(bin)$(binobj)Domain.o : $(Domain_cpp_dependencies)
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_SQLiteAccess_pp_cppflags) $(lib_lcg_SQLiteAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_SQLiteAccess_cppflags) $(lib_lcg_SQLiteAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_SQLiteAccessclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_SQLiteAccess.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_SQLiteAccessclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_SQLiteAccess
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_SQLiteAccess$(library_suffix).a $(library_prefix)lcg_SQLiteAccess$(library_suffix).$(shlibsuffix) lcg_SQLiteAccess.stamp lcg_SQLiteAccess.shstamp
#-- end of cleanup_library ---------------
