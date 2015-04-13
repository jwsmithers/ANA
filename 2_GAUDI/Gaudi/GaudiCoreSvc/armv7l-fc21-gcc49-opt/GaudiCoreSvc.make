#-- start of make_header -----------------

#====================================
#  Library GaudiCoreSvc
#
#   Generated Mon Feb 16 19:46:44 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvc

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvc = $(GaudiCoreSvc_tag)_GaudiCoreSvc.make
cmt_local_tagfile_GaudiCoreSvc = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvc = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvc = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvc)
#-include $(cmt_local_tagfile_GaudiCoreSvc)

ifdef cmt_GaudiCoreSvc_has_target_tag

cmt_final_setup_GaudiCoreSvc = $(bin)setup_GaudiCoreSvc.make
cmt_dependencies_in_GaudiCoreSvc = $(bin)dependencies_GaudiCoreSvc.in
#cmt_final_setup_GaudiCoreSvc = $(bin)GaudiCoreSvc_GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvc_makefile = $(bin)GaudiCoreSvc.make

else

cmt_final_setup_GaudiCoreSvc = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvc = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvc = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvc_makefile = $(bin)GaudiCoreSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvc/
#GaudiCoreSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiCoreSvclibname   = $(bin)$(library_prefix)GaudiCoreSvc$(library_suffix)
GaudiCoreSvclib       = $(GaudiCoreSvclibname).a
GaudiCoreSvcstamp     = $(bin)GaudiCoreSvc.stamp
GaudiCoreSvcshstamp   = $(bin)GaudiCoreSvc.shstamp

GaudiCoreSvc :: dirs  GaudiCoreSvcLIB
	$(echo) "GaudiCoreSvc ok"

cmt_GaudiCoreSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvc_has_prototypes

GaudiCoreSvcprototype :  ;

endif

GaudiCoreSvccompile : $(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiCoreSvcLIB :: $(GaudiCoreSvclib) $(GaudiCoreSvcshstamp)
GaudiCoreSvcLIB :: $(GaudiCoreSvcshstamp)
	$(echo) "GaudiCoreSvc : library ok"

$(GaudiCoreSvclib) :: $(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiCoreSvclib) $?
	$(lib_silent) $(ranlib) $(GaudiCoreSvclib)
	$(lib_silent) cat /dev/null >$(GaudiCoreSvcstamp)

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

$(GaudiCoreSvclibname).$(shlibsuffix) :: $(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o $(use_requirements) $(GaudiCoreSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o $(GaudiCoreSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiCoreSvcstamp) && \
	  cat /dev/null >$(GaudiCoreSvcshstamp)

$(GaudiCoreSvcshstamp) :: $(GaudiCoreSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiCoreSvclibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiCoreSvcstamp) && \
	  cat /dev/null >$(GaudiCoreSvcshstamp) ; fi

GaudiCoreSvcclean ::
	$(cleanup_echo) objects GaudiCoreSvc
	$(cleanup_silent) /bin/rm -f $(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o) $(patsubst %.o,%.dep,$(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o) $(patsubst %.o,%.d.stamp,$(bin)ApplicationMgr.o $(bin)AlgorithmManager.o $(bin)DLLClassManager.o $(bin)AppMgrRunable.o $(bin)MinimalEventLoopMgr.o $(bin)ToolSvc.o $(bin)EventLoopMgr.o $(bin)ServiceManager.o $(bin)EventCollectionSelector.o $(bin)EventSelector.o $(bin)DataStreamToolFactory.o $(bin)DODBasicMapper.o $(bin)IncidentSvc.o $(bin)DataOnDemandSvc.o $(bin)Property.o $(bin)Message.o $(bin)SvcCatalog.o $(bin)Parser.o $(bin)Node.o $(bin)Analyzer.o $(bin)JobOptionsSvc.o $(bin)Utils.o $(bin)Units.o $(bin)IncludedFiles.o $(bin)PropertyName.o $(bin)PropertyValue.o $(bin)Catalog.o $(bin)Position.o $(bin)MessageSvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiCoreSvc_deps GaudiCoreSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiCoreSvcinstallname = $(library_prefix)GaudiCoreSvc$(library_suffix).$(shlibsuffix)

GaudiCoreSvc :: GaudiCoreSvcinstall ;

install :: GaudiCoreSvcinstall ;

GaudiCoreSvcinstall :: $(install_dir)/$(GaudiCoreSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiCoreSvcinstallname) :: $(bin)$(GaudiCoreSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiCoreSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiCoreSvcclean :: GaudiCoreSvcuninstall

uninstall :: GaudiCoreSvcuninstall ;

GaudiCoreSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiCoreSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ApplicationMgr.d

$(bin)$(binobj)ApplicationMgr.d :

$(bin)$(binobj)ApplicationMgr.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)ApplicationMgr.o : $(src)ApplicationMgr/ApplicationMgr.cpp
	$(cpp_echo) $(src)ApplicationMgr/ApplicationMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ApplicationMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ApplicationMgr_cppflags) $(ApplicationMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ApplicationMgr.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(ApplicationMgr_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/ApplicationMgr.cpp

$(bin)$(binobj)ApplicationMgr.o : $(ApplicationMgr_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/ApplicationMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ApplicationMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ApplicationMgr_cppflags) $(ApplicationMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ApplicationMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgorithmManager.d

$(bin)$(binobj)AlgorithmManager.d :

$(bin)$(binobj)AlgorithmManager.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)AlgorithmManager.o : $(src)ApplicationMgr/AlgorithmManager.cpp
	$(cpp_echo) $(src)ApplicationMgr/AlgorithmManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(AlgorithmManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(AlgorithmManager_cppflags) $(AlgorithmManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/AlgorithmManager.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(AlgorithmManager_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/AlgorithmManager.cpp

$(bin)$(binobj)AlgorithmManager.o : $(AlgorithmManager_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/AlgorithmManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(AlgorithmManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(AlgorithmManager_cppflags) $(AlgorithmManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/AlgorithmManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DLLClassManager.d

$(bin)$(binobj)DLLClassManager.d :

$(bin)$(binobj)DLLClassManager.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)DLLClassManager.o : $(src)ApplicationMgr/DLLClassManager.cpp
	$(cpp_echo) $(src)ApplicationMgr/DLLClassManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DLLClassManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DLLClassManager_cppflags) $(DLLClassManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/DLLClassManager.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(DLLClassManager_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/DLLClassManager.cpp

$(bin)$(binobj)DLLClassManager.o : $(DLLClassManager_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/DLLClassManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DLLClassManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DLLClassManager_cppflags) $(DLLClassManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/DLLClassManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AppMgrRunable.d

$(bin)$(binobj)AppMgrRunable.d :

$(bin)$(binobj)AppMgrRunable.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)AppMgrRunable.o : $(src)ApplicationMgr/AppMgrRunable.cpp
	$(cpp_echo) $(src)ApplicationMgr/AppMgrRunable.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(AppMgrRunable_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(AppMgrRunable_cppflags) $(AppMgrRunable_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/AppMgrRunable.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(AppMgrRunable_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/AppMgrRunable.cpp

$(bin)$(binobj)AppMgrRunable.o : $(AppMgrRunable_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/AppMgrRunable.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(AppMgrRunable_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(AppMgrRunable_cppflags) $(AppMgrRunable_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/AppMgrRunable.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MinimalEventLoopMgr.d

$(bin)$(binobj)MinimalEventLoopMgr.d :

$(bin)$(binobj)MinimalEventLoopMgr.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)MinimalEventLoopMgr.o : $(src)ApplicationMgr/MinimalEventLoopMgr.cpp
	$(cpp_echo) $(src)ApplicationMgr/MinimalEventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(MinimalEventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(MinimalEventLoopMgr_cppflags) $(MinimalEventLoopMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/MinimalEventLoopMgr.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(MinimalEventLoopMgr_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/MinimalEventLoopMgr.cpp

$(bin)$(binobj)MinimalEventLoopMgr.o : $(MinimalEventLoopMgr_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/MinimalEventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(MinimalEventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(MinimalEventLoopMgr_cppflags) $(MinimalEventLoopMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/MinimalEventLoopMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ToolSvc.d

$(bin)$(binobj)ToolSvc.d :

$(bin)$(binobj)ToolSvc.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)ToolSvc.o : $(src)ApplicationMgr/ToolSvc.cpp
	$(cpp_echo) $(src)ApplicationMgr/ToolSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ToolSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ToolSvc_cppflags) $(ToolSvc_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ToolSvc.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(ToolSvc_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/ToolSvc.cpp

$(bin)$(binobj)ToolSvc.o : $(ToolSvc_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/ToolSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ToolSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ToolSvc_cppflags) $(ToolSvc_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ToolSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventLoopMgr.d

$(bin)$(binobj)EventLoopMgr.d :

$(bin)$(binobj)EventLoopMgr.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)EventLoopMgr.o : $(src)ApplicationMgr/EventLoopMgr.cpp
	$(cpp_echo) $(src)ApplicationMgr/EventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventLoopMgr_cppflags) $(EventLoopMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/EventLoopMgr.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(EventLoopMgr_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/EventLoopMgr.cpp

$(bin)$(binobj)EventLoopMgr.o : $(EventLoopMgr_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/EventLoopMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventLoopMgr_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventLoopMgr_cppflags) $(EventLoopMgr_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/EventLoopMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServiceManager.d

$(bin)$(binobj)ServiceManager.d :

$(bin)$(binobj)ServiceManager.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)ServiceManager.o : $(src)ApplicationMgr/ServiceManager.cpp
	$(cpp_echo) $(src)ApplicationMgr/ServiceManager.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ServiceManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ServiceManager_cppflags) $(ServiceManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ServiceManager.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(ServiceManager_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)ApplicationMgr/ServiceManager.cpp

$(bin)$(binobj)ServiceManager.o : $(ServiceManager_cpp_dependencies)
	$(cpp_echo) $(src)ApplicationMgr/ServiceManager.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(ServiceManager_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(ServiceManager_cppflags) $(ServiceManager_cpp_cppflags) -I../src/ApplicationMgr $(src)ApplicationMgr/ServiceManager.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventCollectionSelector.d

$(bin)$(binobj)EventCollectionSelector.d :

$(bin)$(binobj)EventCollectionSelector.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)EventCollectionSelector.o : $(src)EventSelector/EventCollectionSelector.cpp
	$(cpp_echo) $(src)EventSelector/EventCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventCollectionSelector_cppflags) $(EventCollectionSelector_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/EventCollectionSelector.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(EventCollectionSelector_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)EventSelector/EventCollectionSelector.cpp

$(bin)$(binobj)EventCollectionSelector.o : $(EventCollectionSelector_cpp_dependencies)
	$(cpp_echo) $(src)EventSelector/EventCollectionSelector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventCollectionSelector_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventCollectionSelector_cppflags) $(EventCollectionSelector_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/EventCollectionSelector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventSelector.d

$(bin)$(binobj)EventSelector.d :

$(bin)$(binobj)EventSelector.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)EventSelector.o : $(src)EventSelector/EventSelector.cpp
	$(cpp_echo) $(src)EventSelector/EventSelector.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventSelector_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventSelector_cppflags) $(EventSelector_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/EventSelector.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(EventSelector_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)EventSelector/EventSelector.cpp

$(bin)$(binobj)EventSelector.o : $(EventSelector_cpp_dependencies)
	$(cpp_echo) $(src)EventSelector/EventSelector.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(EventSelector_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(EventSelector_cppflags) $(EventSelector_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/EventSelector.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataStreamToolFactory.d

$(bin)$(binobj)DataStreamToolFactory.d :

$(bin)$(binobj)DataStreamToolFactory.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)DataStreamToolFactory.o : $(src)EventSelector/DataStreamToolFactory.cpp
	$(cpp_echo) $(src)EventSelector/DataStreamToolFactory.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DataStreamToolFactory_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DataStreamToolFactory_cppflags) $(DataStreamToolFactory_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/DataStreamToolFactory.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(DataStreamToolFactory_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)EventSelector/DataStreamToolFactory.cpp

$(bin)$(binobj)DataStreamToolFactory.o : $(DataStreamToolFactory_cpp_dependencies)
	$(cpp_echo) $(src)EventSelector/DataStreamToolFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DataStreamToolFactory_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DataStreamToolFactory_cppflags) $(DataStreamToolFactory_cpp_cppflags) -I../src/EventSelector $(src)EventSelector/DataStreamToolFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DODBasicMapper.d

$(bin)$(binobj)DODBasicMapper.d :

$(bin)$(binobj)DODBasicMapper.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)DODBasicMapper.o : $(src)IncidentSvc/DODBasicMapper.cpp
	$(cpp_echo) $(src)IncidentSvc/DODBasicMapper.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DODBasicMapper_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DODBasicMapper_cppflags) $(DODBasicMapper_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/DODBasicMapper.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(DODBasicMapper_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)IncidentSvc/DODBasicMapper.cpp

$(bin)$(binobj)DODBasicMapper.o : $(DODBasicMapper_cpp_dependencies)
	$(cpp_echo) $(src)IncidentSvc/DODBasicMapper.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DODBasicMapper_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DODBasicMapper_cppflags) $(DODBasicMapper_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/DODBasicMapper.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IncidentSvc.d

$(bin)$(binobj)IncidentSvc.d :

$(bin)$(binobj)IncidentSvc.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)IncidentSvc.o : $(src)IncidentSvc/IncidentSvc.cpp
	$(cpp_echo) $(src)IncidentSvc/IncidentSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(IncidentSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(IncidentSvc_cppflags) $(IncidentSvc_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentSvc.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(IncidentSvc_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)IncidentSvc/IncidentSvc.cpp

$(bin)$(binobj)IncidentSvc.o : $(IncidentSvc_cpp_dependencies)
	$(cpp_echo) $(src)IncidentSvc/IncidentSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(IncidentSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(IncidentSvc_cppflags) $(IncidentSvc_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/IncidentSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DataOnDemandSvc.d

$(bin)$(binobj)DataOnDemandSvc.d :

$(bin)$(binobj)DataOnDemandSvc.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)DataOnDemandSvc.o : $(src)IncidentSvc/DataOnDemandSvc.cpp
	$(cpp_echo) $(src)IncidentSvc/DataOnDemandSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DataOnDemandSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DataOnDemandSvc_cppflags) $(DataOnDemandSvc_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/DataOnDemandSvc.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(DataOnDemandSvc_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)IncidentSvc/DataOnDemandSvc.cpp

$(bin)$(binobj)DataOnDemandSvc.o : $(DataOnDemandSvc_cpp_dependencies)
	$(cpp_echo) $(src)IncidentSvc/DataOnDemandSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(DataOnDemandSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(DataOnDemandSvc_cppflags) $(DataOnDemandSvc_cpp_cppflags) -I../src/IncidentSvc $(src)IncidentSvc/DataOnDemandSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Property.d

$(bin)$(binobj)Property.d :

$(bin)$(binobj)Property.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Property.o : $(src)JobOptionsSvc/Property.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Property.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Property_cppflags) $(Property_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Property.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Property_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Property.cpp

$(bin)$(binobj)Property.o : $(Property_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Property.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Property_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Property_cppflags) $(Property_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Property.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Message.d

$(bin)$(binobj)Message.d :

$(bin)$(binobj)Message.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Message.o : $(src)JobOptionsSvc/Message.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Message.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Message_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Message_cppflags) $(Message_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Message.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Message_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Message.cpp

$(bin)$(binobj)Message.o : $(Message_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Message.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Message_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Message_cppflags) $(Message_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Message.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SvcCatalog.d

$(bin)$(binobj)SvcCatalog.d :

$(bin)$(binobj)SvcCatalog.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)SvcCatalog.o : $(src)JobOptionsSvc/SvcCatalog.cpp
	$(cpp_echo) $(src)JobOptionsSvc/SvcCatalog.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(SvcCatalog_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(SvcCatalog_cppflags) $(SvcCatalog_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/SvcCatalog.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(SvcCatalog_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/SvcCatalog.cpp

$(bin)$(binobj)SvcCatalog.o : $(SvcCatalog_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/SvcCatalog.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(SvcCatalog_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(SvcCatalog_cppflags) $(SvcCatalog_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/SvcCatalog.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Parser.d

$(bin)$(binobj)Parser.d :

$(bin)$(binobj)Parser.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Parser.o : $(src)JobOptionsSvc/Parser.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Parser.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Parser_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Parser_cppflags) $(Parser_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Parser.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Parser_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Parser.cpp

$(bin)$(binobj)Parser.o : $(Parser_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Parser.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Parser_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Parser_cppflags) $(Parser_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Parser.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Node.d

$(bin)$(binobj)Node.d :

$(bin)$(binobj)Node.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Node.o : $(src)JobOptionsSvc/Node.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Node.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Node_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Node_cppflags) $(Node_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Node.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Node_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Node.cpp

$(bin)$(binobj)Node.o : $(Node_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Node.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Node_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Node_cppflags) $(Node_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Node.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Analyzer.d

$(bin)$(binobj)Analyzer.d :

$(bin)$(binobj)Analyzer.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Analyzer.o : $(src)JobOptionsSvc/Analyzer.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Analyzer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Analyzer_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Analyzer_cppflags) $(Analyzer_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Analyzer.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Analyzer_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Analyzer.cpp

$(bin)$(binobj)Analyzer.o : $(Analyzer_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Analyzer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Analyzer_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Analyzer_cppflags) $(Analyzer_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Analyzer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)JobOptionsSvc.d

$(bin)$(binobj)JobOptionsSvc.d :

$(bin)$(binobj)JobOptionsSvc.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)JobOptionsSvc.o : $(src)JobOptionsSvc/JobOptionsSvc.cpp
	$(cpp_echo) $(src)JobOptionsSvc/JobOptionsSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(JobOptionsSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(JobOptionsSvc_cppflags) $(JobOptionsSvc_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/JobOptionsSvc.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(JobOptionsSvc_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/JobOptionsSvc.cpp

$(bin)$(binobj)JobOptionsSvc.o : $(JobOptionsSvc_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/JobOptionsSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(JobOptionsSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(JobOptionsSvc_cppflags) $(JobOptionsSvc_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/JobOptionsSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Utils.d

$(bin)$(binobj)Utils.d :

$(bin)$(binobj)Utils.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Utils.o : $(src)JobOptionsSvc/Utils.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Utils.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Utils_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Utils_cppflags) $(Utils_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Utils.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Utils_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Utils.cpp

$(bin)$(binobj)Utils.o : $(Utils_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Utils.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Utils_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Utils_cppflags) $(Utils_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Utils.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Units.d

$(bin)$(binobj)Units.d :

$(bin)$(binobj)Units.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Units.o : $(src)JobOptionsSvc/Units.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Units.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Units_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Units_cppflags) $(Units_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Units.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Units_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Units.cpp

$(bin)$(binobj)Units.o : $(Units_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Units.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Units_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Units_cppflags) $(Units_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Units.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)IncludedFiles.d

$(bin)$(binobj)IncludedFiles.d :

$(bin)$(binobj)IncludedFiles.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)IncludedFiles.o : $(src)JobOptionsSvc/IncludedFiles.cpp
	$(cpp_echo) $(src)JobOptionsSvc/IncludedFiles.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(IncludedFiles_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(IncludedFiles_cppflags) $(IncludedFiles_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/IncludedFiles.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(IncludedFiles_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/IncludedFiles.cpp

$(bin)$(binobj)IncludedFiles.o : $(IncludedFiles_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/IncludedFiles.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(IncludedFiles_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(IncludedFiles_cppflags) $(IncludedFiles_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/IncludedFiles.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyName.d

$(bin)$(binobj)PropertyName.d :

$(bin)$(binobj)PropertyName.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)PropertyName.o : $(src)JobOptionsSvc/PropertyName.cpp
	$(cpp_echo) $(src)JobOptionsSvc/PropertyName.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(PropertyName_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(PropertyName_cppflags) $(PropertyName_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/PropertyName.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(PropertyName_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/PropertyName.cpp

$(bin)$(binobj)PropertyName.o : $(PropertyName_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/PropertyName.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(PropertyName_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(PropertyName_cppflags) $(PropertyName_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/PropertyName.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PropertyValue.d

$(bin)$(binobj)PropertyValue.d :

$(bin)$(binobj)PropertyValue.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)PropertyValue.o : $(src)JobOptionsSvc/PropertyValue.cpp
	$(cpp_echo) $(src)JobOptionsSvc/PropertyValue.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(PropertyValue_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(PropertyValue_cppflags) $(PropertyValue_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/PropertyValue.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(PropertyValue_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/PropertyValue.cpp

$(bin)$(binobj)PropertyValue.o : $(PropertyValue_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/PropertyValue.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(PropertyValue_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(PropertyValue_cppflags) $(PropertyValue_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/PropertyValue.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Catalog.d

$(bin)$(binobj)Catalog.d :

$(bin)$(binobj)Catalog.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Catalog.o : $(src)JobOptionsSvc/Catalog.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Catalog.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Catalog_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Catalog_cppflags) $(Catalog_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Catalog.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Catalog_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Catalog.cpp

$(bin)$(binobj)Catalog.o : $(Catalog_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Catalog.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Catalog_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Catalog_cppflags) $(Catalog_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Catalog.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Position.d

$(bin)$(binobj)Position.d :

$(bin)$(binobj)Position.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)Position.o : $(src)JobOptionsSvc/Position.cpp
	$(cpp_echo) $(src)JobOptionsSvc/Position.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Position_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Position_cppflags) $(Position_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Position.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(Position_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)JobOptionsSvc/Position.cpp

$(bin)$(binobj)Position.o : $(Position_cpp_dependencies)
	$(cpp_echo) $(src)JobOptionsSvc/Position.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(Position_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(Position_cppflags) $(Position_cpp_cppflags) -I../src/JobOptionsSvc $(src)JobOptionsSvc/Position.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiCoreSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MessageSvc.d

$(bin)$(binobj)MessageSvc.d :

$(bin)$(binobj)MessageSvc.o : $(cmt_final_setup_GaudiCoreSvc)

$(bin)$(binobj)MessageSvc.o : $(src)MessageSvc/MessageSvc.cpp
	$(cpp_echo) $(src)MessageSvc/MessageSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(MessageSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(MessageSvc_cppflags) $(MessageSvc_cpp_cppflags) -I../src/MessageSvc $(src)MessageSvc/MessageSvc.cpp
endif
endif

else
$(bin)GaudiCoreSvc_dependencies.make : $(MessageSvc_cpp_dependencies)

$(bin)GaudiCoreSvc_dependencies.make : $(src)MessageSvc/MessageSvc.cpp

$(bin)$(binobj)MessageSvc.o : $(MessageSvc_cpp_dependencies)
	$(cpp_echo) $(src)MessageSvc/MessageSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiCoreSvc_pp_cppflags) $(lib_GaudiCoreSvc_pp_cppflags) $(MessageSvc_pp_cppflags) $(use_cppflags) $(GaudiCoreSvc_cppflags) $(lib_GaudiCoreSvc_cppflags) $(MessageSvc_cppflags) $(MessageSvc_cpp_cppflags) -I../src/MessageSvc $(src)MessageSvc/MessageSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiCoreSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiCoreSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiCoreSvc$(library_suffix).a $(library_prefix)GaudiCoreSvc$(library_suffix).$(shlibsuffix) GaudiCoreSvc.stamp GaudiCoreSvc.shstamp
#-- end of cleanup_library ---------------
