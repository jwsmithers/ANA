#-- start of make_header -----------------

#====================================
#  Library lcg_CoralAccess
#
#   Generated Wed Jan 21 17:23:50 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralAccess_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralAccess_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralAccess

CoralAccess_tag = $(tag)

#cmt_local_tagfile_lcg_CoralAccess = $(CoralAccess_tag)_lcg_CoralAccess.make
cmt_local_tagfile_lcg_CoralAccess = $(bin)$(CoralAccess_tag)_lcg_CoralAccess.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralAccess_tag = $(tag)

#cmt_local_tagfile_lcg_CoralAccess = $(CoralAccess_tag).make
cmt_local_tagfile_lcg_CoralAccess = $(bin)$(CoralAccess_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralAccess)
#-include $(cmt_local_tagfile_lcg_CoralAccess)

ifdef cmt_lcg_CoralAccess_has_target_tag

cmt_final_setup_lcg_CoralAccess = $(bin)setup_lcg_CoralAccess.make
cmt_dependencies_in_lcg_CoralAccess = $(bin)dependencies_lcg_CoralAccess.in
#cmt_final_setup_lcg_CoralAccess = $(bin)CoralAccess_lcg_CoralAccesssetup.make
cmt_local_lcg_CoralAccess_makefile = $(bin)lcg_CoralAccess.make

else

cmt_final_setup_lcg_CoralAccess = $(bin)setup.make
cmt_dependencies_in_lcg_CoralAccess = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralAccess = $(bin)CoralAccesssetup.make
cmt_local_lcg_CoralAccess_makefile = $(bin)lcg_CoralAccess.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralAccesssetup.make

#lcg_CoralAccess :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralAccess'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralAccess/
#lcg_CoralAccess::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralAccesslibname   = $(bin)$(library_prefix)lcg_CoralAccess$(library_suffix)
lcg_CoralAccesslib       = $(lcg_CoralAccesslibname).a
lcg_CoralAccessstamp     = $(bin)lcg_CoralAccess.stamp
lcg_CoralAccessshstamp   = $(bin)lcg_CoralAccess.shstamp

lcg_CoralAccess :: dirs  lcg_CoralAccessLIB
	$(echo) "lcg_CoralAccess ok"

cmt_lcg_CoralAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralAccess_has_prototypes

lcg_CoralAccessprototype :  ;

endif

lcg_CoralAccesscompile : $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)Schema.o $(bin)Cursor.o $(bin)Session.o $(bin)module.o $(bin)TableDataEditor.o $(bin)Connection.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralAccessLIB :: $(lcg_CoralAccesslib) $(lcg_CoralAccessshstamp)
	@/bin/echo "------> lcg_CoralAccess : library ok"

$(lcg_CoralAccesslib) :: $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)Schema.o $(bin)Cursor.o $(bin)Session.o $(bin)module.o $(bin)TableDataEditor.o $(bin)Connection.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralAccesslib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralAccesslib)
	$(lib_silent) cat /dev/null >$(lcg_CoralAccessstamp)

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

$(lcg_CoralAccesslibname).$(shlibsuffix) :: $(lcg_CoralAccesslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralAccess $(lcg_CoralAccess_shlibflags)

$(lcg_CoralAccessshstamp) :: $(lcg_CoralAccesslibname).$(shlibsuffix)
	@if test -f $(lcg_CoralAccesslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralAccessshstamp) ; fi

lcg_CoralAccessclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)View.o $(bin)Query.o $(bin)TableDescriptionProxy.o $(bin)Table.o $(bin)ConnectionProperties.o $(bin)Transaction.o $(bin)Schema.o $(bin)Cursor.o $(bin)Session.o $(bin)module.o $(bin)TableDataEditor.o $(bin)Connection.o $(bin)DomainProperties.o $(bin)SessionProperties.o $(bin)Domain.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralAccessinstallname = $(library_prefix)lcg_CoralAccess$(library_suffix).$(shlibsuffix)

lcg_CoralAccess :: lcg_CoralAccessinstall

install :: lcg_CoralAccessinstall

lcg_CoralAccessinstall :: $(install_dir)/$(lcg_CoralAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralAccessinstallname) :: $(bin)$(lcg_CoralAccessinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralAccessinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralAccessclean :: lcg_CoralAccessuninstall

uninstall :: lcg_CoralAccessuninstall

lcg_CoralAccessuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralAccessinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralAccessprototype)

$(bin)lcg_CoralAccess_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralAccess)
	$(echo) "(lcg_CoralAccess.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)View.cpp $(src)Query.cpp $(src)TableDescriptionProxy.cpp $(src)Table.cpp $(src)ConnectionProperties.cpp $(src)Transaction.cpp $(src)Schema.cpp $(src)Cursor.cpp $(src)Session.cpp $(src)module.cpp $(src)TableDataEditor.cpp $(src)Connection.cpp $(src)DomainProperties.cpp $(src)SessionProperties.cpp $(src)Domain.cpp -end_all $(includes) $(app_lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) -name=lcg_CoralAccess $? -f=$(cmt_dependencies_in_lcg_CoralAccess) -without_cmt

-include $(bin)lcg_CoralAccess_dependencies.make

endif
endif
endif

lcg_CoralAccessclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralAccess_deps $(bin)lcg_CoralAccess_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)View.d

$(bin)$(binobj)View.d :

$(bin)$(binobj)View.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)View.o : $(src)View.cpp
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(View_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)View.cpp

$(bin)$(binobj)View.o : $(View_cpp_dependencies)
	$(cpp_echo) $(src)View.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(View_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(View_cppflags) $(View_cpp_cppflags)  $(src)View.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Query.d

$(bin)$(binobj)Query.d :

$(bin)$(binobj)Query.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Query.o : $(src)Query.cpp
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Query_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Query.cpp

$(bin)$(binobj)Query.o : $(Query_cpp_dependencies)
	$(cpp_echo) $(src)Query.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Query_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Query_cppflags) $(Query_cpp_cppflags)  $(src)Query.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDescriptionProxy.d

$(bin)$(binobj)TableDescriptionProxy.d :

$(bin)$(binobj)TableDescriptionProxy.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)TableDescriptionProxy.o : $(src)TableDescriptionProxy.cpp
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(TableDescriptionProxy_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)TableDescriptionProxy.cpp

$(bin)$(binobj)TableDescriptionProxy.o : $(TableDescriptionProxy_cpp_dependencies)
	$(cpp_echo) $(src)TableDescriptionProxy.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(TableDescriptionProxy_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(TableDescriptionProxy_cppflags) $(TableDescriptionProxy_cpp_cppflags)  $(src)TableDescriptionProxy.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Table.d

$(bin)$(binobj)Table.d :

$(bin)$(binobj)Table.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Table.o : $(src)Table.cpp
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Table_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Table.cpp

$(bin)$(binobj)Table.o : $(Table_cpp_dependencies)
	$(cpp_echo) $(src)Table.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Table_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Table_cppflags) $(Table_cpp_cppflags)  $(src)Table.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ConnectionProperties.d

$(bin)$(binobj)ConnectionProperties.d :

$(bin)$(binobj)ConnectionProperties.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)ConnectionProperties.o : $(src)ConnectionProperties.cpp
	$(cpp_echo) $(src)ConnectionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(ConnectionProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(ConnectionProperties_cppflags) $(ConnectionProperties_cpp_cppflags)  $(src)ConnectionProperties.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(ConnectionProperties_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)ConnectionProperties.cpp

$(bin)$(binobj)ConnectionProperties.o : $(ConnectionProperties_cpp_dependencies)
	$(cpp_echo) $(src)ConnectionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(ConnectionProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(ConnectionProperties_cppflags) $(ConnectionProperties_cpp_cppflags)  $(src)ConnectionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Transaction.d

$(bin)$(binobj)Transaction.d :

$(bin)$(binobj)Transaction.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Transaction.o : $(src)Transaction.cpp
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Transaction_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Transaction.cpp

$(bin)$(binobj)Transaction.o : $(Transaction_cpp_dependencies)
	$(cpp_echo) $(src)Transaction.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Transaction_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Transaction_cppflags) $(Transaction_cpp_cppflags)  $(src)Transaction.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Schema.d

$(bin)$(binobj)Schema.d :

$(bin)$(binobj)Schema.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Schema.o : $(src)Schema.cpp
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Schema_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Schema.cpp

$(bin)$(binobj)Schema.o : $(Schema_cpp_dependencies)
	$(cpp_echo) $(src)Schema.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Schema_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Schema_cppflags) $(Schema_cpp_cppflags)  $(src)Schema.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Cursor.d

$(bin)$(binobj)Cursor.d :

$(bin)$(binobj)Cursor.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Cursor.o : $(src)Cursor.cpp
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Cursor_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Cursor.cpp

$(bin)$(binobj)Cursor.o : $(Cursor_cpp_dependencies)
	$(cpp_echo) $(src)Cursor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Cursor_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Cursor_cppflags) $(Cursor_cpp_cppflags)  $(src)Cursor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Session.d

$(bin)$(binobj)Session.d :

$(bin)$(binobj)Session.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Session.o : $(src)Session.cpp
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Session_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Session.cpp

$(bin)$(binobj)Session.o : $(Session_cpp_dependencies)
	$(cpp_echo) $(src)Session.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Session_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Session_cppflags) $(Session_cpp_cppflags)  $(src)Session.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)module.d

$(bin)$(binobj)module.d :

$(bin)$(binobj)module.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)module.o : $(src)module.cpp
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(module_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)module.cpp

$(bin)$(binobj)module.o : $(module_cpp_dependencies)
	$(cpp_echo) $(src)module.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(module_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(module_cppflags) $(module_cpp_cppflags)  $(src)module.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TableDataEditor.d

$(bin)$(binobj)TableDataEditor.d :

$(bin)$(binobj)TableDataEditor.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)TableDataEditor.o : $(src)TableDataEditor.cpp
	$(cpp_echo) $(src)TableDataEditor.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(TableDataEditor_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(TableDataEditor_cppflags) $(TableDataEditor_cpp_cppflags)  $(src)TableDataEditor.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(TableDataEditor_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)TableDataEditor.cpp

$(bin)$(binobj)TableDataEditor.o : $(TableDataEditor_cpp_dependencies)
	$(cpp_echo) $(src)TableDataEditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(TableDataEditor_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(TableDataEditor_cppflags) $(TableDataEditor_cpp_cppflags)  $(src)TableDataEditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Connection.d

$(bin)$(binobj)Connection.d :

$(bin)$(binobj)Connection.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Connection.o : $(src)Connection.cpp
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Connection_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Connection.cpp

$(bin)$(binobj)Connection.o : $(Connection_cpp_dependencies)
	$(cpp_echo) $(src)Connection.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Connection_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Connection_cppflags) $(Connection_cpp_cppflags)  $(src)Connection.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DomainProperties.d

$(bin)$(binobj)DomainProperties.d :

$(bin)$(binobj)DomainProperties.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)DomainProperties.o : $(src)DomainProperties.cpp
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(DomainProperties_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)DomainProperties.cpp

$(bin)$(binobj)DomainProperties.o : $(DomainProperties_cpp_dependencies)
	$(cpp_echo) $(src)DomainProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(DomainProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(DomainProperties_cppflags) $(DomainProperties_cpp_cppflags)  $(src)DomainProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SessionProperties.d

$(bin)$(binobj)SessionProperties.d :

$(bin)$(binobj)SessionProperties.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)SessionProperties.o : $(src)SessionProperties.cpp
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(SessionProperties_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)SessionProperties.cpp

$(bin)$(binobj)SessionProperties.o : $(SessionProperties_cpp_dependencies)
	$(cpp_echo) $(src)SessionProperties.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(SessionProperties_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(SessionProperties_cppflags) $(SessionProperties_cpp_cppflags)  $(src)SessionProperties.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralAccessclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Domain.d

$(bin)$(binobj)Domain.d :

$(bin)$(binobj)Domain.o : $(cmt_final_setup_lcg_CoralAccess)

$(bin)$(binobj)Domain.o : $(src)Domain.cpp
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp
endif
endif

else
$(bin)lcg_CoralAccess_dependencies.make : $(Domain_cpp_dependencies)

$(bin)lcg_CoralAccess_dependencies.make : $(src)Domain.cpp

$(bin)$(binobj)Domain.o : $(Domain_cpp_dependencies)
	$(cpp_echo) $(src)Domain.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralAccess_pp_cppflags) $(lib_lcg_CoralAccess_pp_cppflags) $(Domain_pp_cppflags) $(use_cppflags) $(lcg_CoralAccess_cppflags) $(lib_lcg_CoralAccess_cppflags) $(Domain_cppflags) $(Domain_cpp_cppflags)  $(src)Domain.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralAccessclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralAccess.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralAccessclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralAccess
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralAccess$(library_suffix).a $(library_prefix)lcg_CoralAccess$(library_suffix).$(shlibsuffix) lcg_CoralAccess.stamp lcg_CoralAccess.shstamp
#-- end of cleanup_library ---------------
