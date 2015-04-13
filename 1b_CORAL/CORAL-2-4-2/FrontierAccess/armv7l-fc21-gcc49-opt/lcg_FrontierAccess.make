#-- start of make_header -----------------

#====================================
#  Library lcg_FrontierAccess
#
#   Generated Tue Mar 31 10:22:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_FrontierAccess_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_FrontierAccess_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_FrontierAccess

FrontierAccess_tag = $(tag)

#cmt_local_tagfile_lcg_FrontierAccess = $(FrontierAccess_tag)_lcg_FrontierAccess.make
cmt_local_tagfile_lcg_FrontierAccess = $(bin)$(FrontierAccess_tag)_lcg_FrontierAccess.make

else

tags      = $(tag),$(CMTEXTRATAGS)

FrontierAccess_tag = $(tag)

#cmt_local_tagfile_lcg_FrontierAccess = $(FrontierAccess_tag).make
cmt_local_tagfile_lcg_FrontierAccess = $(bin)$(FrontierAccess_tag).make

endif

include $(cmt_local_tagfile_lcg_FrontierAccess)
#-include $(cmt_local_tagfile_lcg_FrontierAccess)

ifdef cmt_lcg_FrontierAccess_has_target_tag

cmt_final_setup_lcg_FrontierAccess = $(bin)setup_lcg_FrontierAccess.make
cmt_dependencies_in_lcg_FrontierAccess = $(bin)dependencies_lcg_FrontierAccess.in
#cmt_final_setup_lcg_FrontierAccess = $(bin)FrontierAccess_lcg_FrontierAccesssetup.make
cmt_local_lcg_FrontierAccess_makefile = $(bin)lcg_FrontierAccess.make

else

cmt_final_setup_lcg_FrontierAccess = $(bin)setup.make
cmt_dependencies_in_lcg_FrontierAccess = $(bin)dependencies.in
#cmt_final_setup_lcg_FrontierAccess = $(bin)FrontierAccesssetup.make
cmt_local_lcg_FrontierAccess_makefile = $(bin)lcg_FrontierAccess.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)FrontierAccesssetup.make

#lcg_FrontierAccess :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_FrontierAccess'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_FrontierAccess/
#lcg_FrontierAccess::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_FrontierAccesslibname   = $(bin)$(library_prefix)lcg_FrontierAccess$(library_suffix)
lcg_FrontierAccesslib       = $(lcg_FrontierAccesslibname).a
lcg_FrontierAccessstamp     = $(bin)lcg_FrontierAccess.stamp
lcg_FrontierAccessshstamp   = $(bin)lcg_FrontierAccess.shstamp

lcg_FrontierAccess :: dirs  lcg_FrontierAccessLIB
	$(echo) "lcg_FrontierAccess ok"

cmt_lcg_FrontierAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_FrontierAccess_has_prototypes

lcg_FrontierAccessprototype :  ;

endif

lcg_FrontierAccesscompile : $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)Connection.o $(bin)DomainPropertyNames.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)Statement.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_FrontierAccessLIB :: $(lcg_FrontierAccesslib) $(lcg_FrontierAccessshstamp)
	@/bin/echo "------> lcg_FrontierAccess : library ok"

$(lcg_FrontierAccesslib) :: $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)Connection.o $(bin)DomainPropertyNames.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)Statement.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_FrontierAccesslib) $?
	$(lib_silent) $(ranlib) $(lcg_FrontierAccesslib)
	$(lib_silent) cat /dev/null >$(lcg_FrontierAccessstamp)

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

$(lcg_FrontierAccesslibname).$(shlibsuffix) :: $(lcg_FrontierAccesslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_FrontierAccess $(lcg_FrontierAccess_shlibflags)

$(lcg_FrontierAccessshstamp) :: $(lcg_FrontierAccesslibname).$(shlibsuffix)
	@if test -f $(lcg_FrontierAccesslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_FrontierAccessshstamp) ; fi

lcg_FrontierAccessclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)ColumnProxy.o $(bin)Table.o $(bin)Transaction.o $(bin)QueryDefinition.o $(bin)Schema.o $(bin)Cursor.o $(bin)NamedInputParametersParser.o $(bin)ErrorHandler.o $(bin)Session.o $(bin)module.o $(bin)MonitorController.o $(bin)TypeConverter.o $(bin)OperationWithQuery.o $(bin)Connection.o $(bin)DomainPropertyNames.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o $(bin)Statement.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_FrontierAccessinstallname = $(library_prefix)lcg_FrontierAccess$(library_suffix).$(shlibsuffix)

lcg_FrontierAccess :: lcg_FrontierAccessinstall

install :: lcg_FrontierAccessinstall

lcg_FrontierAccessinstall :: $(install_dir)/$(lcg_FrontierAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_FrontierAccessinstallname) :: $(bin)$(lcg_FrontierAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_FrontierAccessinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_FrontierAccessclean :: lcg_FrontierAccessuninstall

uninstall :: lcg_FrontierAccessuninstall

lcg_FrontierAccessuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_FrontierAccessinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_FrontierAccessprototype)

$(bin)lcg_FrontierAccess_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_FrontierAccess)
	$(echo) "(lcg_FrontierAccess.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)View.cpp $(src)Query.cpp $(src)TableDescriptionProxy.cpp $(src)ColumnProxy.cpp $(src)Table.cpp $(src)Transaction.cpp $(src)QueryDefinition.cpp $(src)Schema.cpp $(src)Cursor.cpp $(src)NamedInputParametersParser.cpp $(src)ErrorHandler.cpp $(src)Session.cpp $(src)module.cpp $(src)MonitorController.cpp $(src)TypeConverter.cpp $(src)OperationWithQuery.cpp $(src)Connection.cpp $(src)DomainPropertyNames.cpp $(src)DomainProperties.cpp $(src)SessionProperties.cpp $(src)Domain.cpp $(src)Statement.cpp -end_all $(includes) $(app_lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) -name=lcg_FrontierAccess $? -f=$(cmt_dependencies_in_lcg_FrontierAccess) -without_cmt

-include $(bin)lcg_FrontierAccess_dependencies.make

endif
endif
endif

lcg_FrontierAccessclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_FrontierAccess_deps $(bin)lcg_FrontierAccess_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)View.d

$(bin)$(binobj)View.d :

$(bin)$(binobj)View.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)View.o : $(src)View.cpp
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(View_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)View.cpp

$(bin)$(binobj)View.o : $(View_cpp_dependencies)
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Query.d

$(bin)$(binobj)Query.d :

$(bin)$(binobj)Query.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Query.o : $(src)Query.cpp
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Query_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Query.cpp

$(bin)$(binobj)Query.o : $(Query_cpp_dependencies)
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDescriptionProxy.d

$(bin)$(binobj)TableDescriptionProxy.d :

$(bin)$(binobj)TableDescriptionProxy.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)TableDescriptionProxy.o : $(src)TableDescriptionProxy.cpp
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(TableDescriptionProxy_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)TableDescriptionProxy.cpp

$(bin)$(binobj)TableDescriptionProxy.o : $(TableDescriptionProxy_cpp_dependencies)
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ColumnProxy.d

$(bin)$(binobj)ColumnProxy.d :

$(bin)$(binobj)ColumnProxy.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)ColumnProxy.o : $(src)ColumnProxy.cpp
	$(cpp_echo) $(src)ColumnProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(ColumnProxy_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(ColumnProxy_cppflags) $(ColumnProxy_cpp_cppflags)  $(src)ColumnProxy.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(ColumnProxy_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)ColumnProxy.cpp

$(bin)$(binobj)ColumnProxy.o : $(ColumnProxy_cpp_dependencies)
	$(cpp_echo) $(src)ColumnProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(ColumnProxy_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(ColumnProxy_cppflags) $(ColumnProxy_cpp_cppflags)  $(src)ColumnProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Table.d

$(bin)$(binobj)Table.d :

$(bin)$(binobj)Table.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Table.o : $(src)Table.cpp
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Table_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Table.cpp

$(bin)$(binobj)Table.o : $(Table_cpp_dependencies)
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Transaction.d

$(bin)$(binobj)Transaction.d :

$(bin)$(binobj)Transaction.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Transaction.o : $(src)Transaction.cpp
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Transaction_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Transaction.cpp

$(bin)$(binobj)Transaction.o : $(Transaction_cpp_dependencies)
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryDefinition.d

$(bin)$(binobj)QueryDefinition.d :

$(bin)$(binobj)QueryDefinition.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)QueryDefinition.o : $(src)QueryDefinition.cpp
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(QueryDefinition_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)QueryDefinition.cpp

$(bin)$(binobj)QueryDefinition.o : $(QueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Schema.d

$(bin)$(binobj)Schema.d :

$(bin)$(binobj)Schema.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Schema.o : $(src)Schema.cpp
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Schema_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Schema.cpp

$(bin)$(binobj)Schema.o : $(Schema_cpp_dependencies)
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cursor.d

$(bin)$(binobj)Cursor.d :

$(bin)$(binobj)Cursor.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Cursor.o : $(src)Cursor.cpp
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Cursor_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Cursor.cpp

$(bin)$(binobj)Cursor.o : $(Cursor_cpp_dependencies)
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NamedInputParametersParser.d

$(bin)$(binobj)NamedInputParametersParser.d :

$(bin)$(binobj)NamedInputParametersParser.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)NamedInputParametersParser.o : $(src)NamedInputParametersParser.cpp
	$(cpp_echo) $(src)NamedInputParametersParser.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(NamedInputParametersParser_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(NamedInputParametersParser_cppflags) $(NamedInputParametersParser_cpp_cppflags)  $(src)NamedInputParametersParser.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(NamedInputParametersParser_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)NamedInputParametersParser.cpp

$(bin)$(binobj)NamedInputParametersParser.o : $(NamedInputParametersParser_cpp_dependencies)
	$(cpp_echo) $(src)NamedInputParametersParser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(NamedInputParametersParser_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(NamedInputParametersParser_cppflags) $(NamedInputParametersParser_cpp_cppflags)  $(src)NamedInputParametersParser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ErrorHandler.d

$(bin)$(binobj)ErrorHandler.d :

$(bin)$(binobj)ErrorHandler.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)ErrorHandler.o : $(src)ErrorHandler.cpp
	$(cpp_echo) $(src)ErrorHandler.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(ErrorHandler_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(ErrorHandler_cppflags) $(ErrorHandler_cpp_cppflags)  $(src)ErrorHandler.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(ErrorHandler_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)ErrorHandler.cpp

$(bin)$(binobj)ErrorHandler.o : $(ErrorHandler_cpp_dependencies)
	$(cpp_echo) $(src)ErrorHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(ErrorHandler_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(ErrorHandler_cppflags) $(ErrorHandler_cpp_cppflags)  $(src)ErrorHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Session.d

$(bin)$(binobj)Session.d :

$(bin)$(binobj)Session.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Session.o : $(src)Session.cpp
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Session_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Session.cpp

$(bin)$(binobj)Session.o : $(Session_cpp_dependencies)
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MonitorController.d

$(bin)$(binobj)MonitorController.d :

$(bin)$(binobj)MonitorController.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)MonitorController.o : $(src)MonitorController.cpp
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(MonitorController_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)MonitorController.cpp

$(bin)$(binobj)MonitorController.o : $(MonitorController_cpp_dependencies)
	$(cpp_echo) $(src)MonitorController.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(MonitorController_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(MonitorController_cppflags) $(MonitorController_cpp_cppflags)  $(src)MonitorController.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TypeConverter.d

$(bin)$(binobj)TypeConverter.d :

$(bin)$(binobj)TypeConverter.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)TypeConverter.o : $(src)TypeConverter.cpp
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(TypeConverter_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)TypeConverter.cpp

$(bin)$(binobj)TypeConverter.o : $(TypeConverter_cpp_dependencies)
	$(cpp_echo) $(src)TypeConverter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(TypeConverter_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(TypeConverter_cppflags) $(TypeConverter_cpp_cppflags)  $(src)TypeConverter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)OperationWithQuery.d

$(bin)$(binobj)OperationWithQuery.d :

$(bin)$(binobj)OperationWithQuery.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)OperationWithQuery.o : $(src)OperationWithQuery.cpp
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(OperationWithQuery_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)OperationWithQuery.cpp

$(bin)$(binobj)OperationWithQuery.o : $(OperationWithQuery_cpp_dependencies)
	$(cpp_echo) $(src)OperationWithQuery.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(OperationWithQuery_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(OperationWithQuery_cppflags) $(OperationWithQuery_cpp_cppflags)  $(src)OperationWithQuery.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Connection.d

$(bin)$(binobj)Connection.d :

$(bin)$(binobj)Connection.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Connection.o : $(src)Connection.cpp
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Connection_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Connection.cpp

$(bin)$(binobj)Connection.o : $(Connection_cpp_dependencies)
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DomainPropertyNames.d

$(bin)$(binobj)DomainPropertyNames.d :

$(bin)$(binobj)DomainPropertyNames.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)DomainPropertyNames.o : $(src)DomainPropertyNames.cpp
	$(cpp_echo) $(src)DomainPropertyNames.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(DomainPropertyNames_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(DomainPropertyNames_cppflags) $(DomainPropertyNames_cpp_cppflags)  $(src)DomainPropertyNames.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(DomainPropertyNames_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)DomainPropertyNames.cpp

$(bin)$(binobj)DomainPropertyNames.o : $(DomainPropertyNames_cpp_dependencies)
	$(cpp_echo) $(src)DomainPropertyNames.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(DomainPropertyNames_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(DomainPropertyNames_cppflags) $(DomainPropertyNames_cpp_cppflags)  $(src)DomainPropertyNames.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DomainProperties.d

$(bin)$(binobj)DomainProperties.d :

$(bin)$(binobj)DomainProperties.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)DomainProperties.o : $(src)DomainProperties.cpp
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(DomainProperties_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)DomainProperties.cpp

$(bin)$(binobj)DomainProperties.o : $(DomainProperties_cpp_dependencies)
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionProperties.d

$(bin)$(binobj)SessionProperties.d :

$(bin)$(binobj)SessionProperties.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)SessionProperties.o : $(src)SessionProperties.cpp
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(SessionProperties_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)SessionProperties.cpp

$(bin)$(binobj)SessionProperties.o : $(SessionProperties_cpp_dependencies)
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Domain.d

$(bin)$(binobj)Domain.d :

$(bin)$(binobj)Domain.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Domain.o : $(src)Domain.cpp
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Domain_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Domain.cpp

$(bin)$(binobj)Domain.o : $(Domain_cpp_dependencies)
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_FrontierAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Statement.d

$(bin)$(binobj)Statement.d :

$(bin)$(binobj)Statement.o : $(cmt_final_setup_lcg_FrontierAccess)

$(bin)$(binobj)Statement.o : $(src)Statement.cpp
	$(cpp_echo) $(src)Statement.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Statement_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Statement_cppflags) $(Statement_cpp_cppflags)  $(src)Statement.cpp
endif
endif

else
$(bin)lcg_FrontierAccess_dependencies.make : $(Statement_cpp_dependencies)

$(bin)lcg_FrontierAccess_dependencies.make : $(src)Statement.cpp

$(bin)$(binobj)Statement.o : $(Statement_cpp_dependencies)
	$(cpp_echo) $(src)Statement.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_FrontierAccess_pp_cppflags) $(lib_lcg_FrontierAccess_pp_cppflags) $(Statement_pp_cppflags) $(use_cppflags) $(lcg_FrontierAccess_cppflags) $(lib_lcg_FrontierAccess_cppflags) $(Statement_cppflags) $(Statement_cpp_cppflags)  $(src)Statement.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_FrontierAccessclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_FrontierAccess.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_FrontierAccessclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_FrontierAccess
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_FrontierAccess$(library_suffix).a $(library_prefix)lcg_FrontierAccess$(library_suffix).$(shlibsuffix) lcg_FrontierAccess.stamp lcg_FrontierAccess.shstamp
#-- end of cleanup_library ---------------
