#-- start of make_header -----------------

#====================================
#  Library GaudiSvc
#
#   Generated Mon Feb 16 19:54:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvc_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvc_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvc

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvc = $(GaudiSvc_tag)_GaudiSvc.make
cmt_local_tagfile_GaudiSvc = $(bin)$(GaudiSvc_tag)_GaudiSvc.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvc = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvc = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvc)
#-include $(cmt_local_tagfile_GaudiSvc)

ifdef cmt_GaudiSvc_has_target_tag

cmt_final_setup_GaudiSvc = $(bin)setup_GaudiSvc.make
cmt_dependencies_in_GaudiSvc = $(bin)dependencies_GaudiSvc.in
#cmt_final_setup_GaudiSvc = $(bin)GaudiSvc_GaudiSvcsetup.make
cmt_local_GaudiSvc_makefile = $(bin)GaudiSvc.make

else

cmt_final_setup_GaudiSvc = $(bin)setup.make
cmt_dependencies_in_GaudiSvc = $(bin)dependencies.in
#cmt_final_setup_GaudiSvc = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvc_makefile = $(bin)GaudiSvc.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvc :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvc'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvc/
#GaudiSvc::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiSvclibname   = $(bin)$(library_prefix)GaudiSvc$(library_suffix)
GaudiSvclib       = $(GaudiSvclibname).a
GaudiSvcstamp     = $(bin)GaudiSvc.stamp
GaudiSvcshstamp   = $(bin)GaudiSvc.shstamp

GaudiSvc :: dirs  GaudiSvcLIB
	$(echo) "GaudiSvc ok"

cmt_GaudiSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiSvc_has_prototypes

GaudiSvcprototype :  ;

endif

GaudiSvccompile : $(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiSvcLIB :: $(GaudiSvclib) $(GaudiSvcshstamp)
GaudiSvcLIB :: $(GaudiSvcshstamp)
	$(echo) "GaudiSvc : library ok"

$(GaudiSvclib) :: $(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiSvclib) $?
	$(lib_silent) $(ranlib) $(GaudiSvclib)
	$(lib_silent) cat /dev/null >$(GaudiSvcstamp)

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

$(GaudiSvclibname).$(shlibsuffix) :: $(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o $(use_requirements) $(GaudiSvcstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o $(GaudiSvc_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiSvcstamp) && \
	  cat /dev/null >$(GaudiSvcshstamp)

$(GaudiSvcshstamp) :: $(GaudiSvclibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiSvclibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiSvcstamp) && \
	  cat /dev/null >$(GaudiSvcshstamp) ; fi

GaudiSvcclean ::
	$(cleanup_echo) objects GaudiSvc
	$(cleanup_silent) /bin/rm -f $(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o) $(patsubst %.o,%.dep,$(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o) $(patsubst %.o,%.d.stamp,$(bin)DetDataSvc.o $(bin)NTupleSvc.o $(bin)TagCollectionSvc.o $(bin)CollectionCloneAlg.o $(bin)RndmEngine.o $(bin)HepRndmEngines.o $(bin)RndmGen.o $(bin)RndmGenSvc.o $(bin)HepRndmGenerators.o $(bin)THistSvc.o $(bin)POSIXFileHandler.o $(bin)RootFileHandler.o $(bin)FileMgr.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiSvc_deps GaudiSvc_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiSvcinstallname = $(library_prefix)GaudiSvc$(library_suffix).$(shlibsuffix)

GaudiSvc :: GaudiSvcinstall ;

install :: GaudiSvcinstall ;

GaudiSvcinstall :: $(install_dir)/$(GaudiSvcinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiSvcinstallname) :: $(bin)$(GaudiSvcinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiSvcclean :: GaudiSvcuninstall

uninstall :: GaudiSvcuninstall ;

GaudiSvcuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiSvcinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DetDataSvc.d

$(bin)$(binobj)DetDataSvc.d :

$(bin)$(binobj)DetDataSvc.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)DetDataSvc.o : $(src)DetectorDataSvc/DetDataSvc.cpp
	$(cpp_echo) $(src)DetectorDataSvc/DetDataSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(DetDataSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(DetDataSvc_cppflags) $(DetDataSvc_cpp_cppflags) -I../src/DetectorDataSvc $(src)DetectorDataSvc/DetDataSvc.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(DetDataSvc_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)DetectorDataSvc/DetDataSvc.cpp

$(bin)$(binobj)DetDataSvc.o : $(DetDataSvc_cpp_dependencies)
	$(cpp_echo) $(src)DetectorDataSvc/DetDataSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(DetDataSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(DetDataSvc_cppflags) $(DetDataSvc_cpp_cppflags) -I../src/DetectorDataSvc $(src)DetectorDataSvc/DetDataSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NTupleSvc.d

$(bin)$(binobj)NTupleSvc.d :

$(bin)$(binobj)NTupleSvc.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)NTupleSvc.o : $(src)NTupleSvc/NTupleSvc.cpp
	$(cpp_echo) $(src)NTupleSvc/NTupleSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(NTupleSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(NTupleSvc_cppflags) $(NTupleSvc_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/NTupleSvc.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(NTupleSvc_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)NTupleSvc/NTupleSvc.cpp

$(bin)$(binobj)NTupleSvc.o : $(NTupleSvc_cpp_dependencies)
	$(cpp_echo) $(src)NTupleSvc/NTupleSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(NTupleSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(NTupleSvc_cppflags) $(NTupleSvc_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/NTupleSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TagCollectionSvc.d

$(bin)$(binobj)TagCollectionSvc.d :

$(bin)$(binobj)TagCollectionSvc.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)TagCollectionSvc.o : $(src)NTupleSvc/TagCollectionSvc.cpp
	$(cpp_echo) $(src)NTupleSvc/TagCollectionSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(TagCollectionSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(TagCollectionSvc_cppflags) $(TagCollectionSvc_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/TagCollectionSvc.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(TagCollectionSvc_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)NTupleSvc/TagCollectionSvc.cpp

$(bin)$(binobj)TagCollectionSvc.o : $(TagCollectionSvc_cpp_dependencies)
	$(cpp_echo) $(src)NTupleSvc/TagCollectionSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(TagCollectionSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(TagCollectionSvc_cppflags) $(TagCollectionSvc_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/TagCollectionSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CollectionCloneAlg.d

$(bin)$(binobj)CollectionCloneAlg.d :

$(bin)$(binobj)CollectionCloneAlg.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)CollectionCloneAlg.o : $(src)NTupleSvc/CollectionCloneAlg.cpp
	$(cpp_echo) $(src)NTupleSvc/CollectionCloneAlg.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(CollectionCloneAlg_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(CollectionCloneAlg_cppflags) $(CollectionCloneAlg_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/CollectionCloneAlg.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(CollectionCloneAlg_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)NTupleSvc/CollectionCloneAlg.cpp

$(bin)$(binobj)CollectionCloneAlg.o : $(CollectionCloneAlg_cpp_dependencies)
	$(cpp_echo) $(src)NTupleSvc/CollectionCloneAlg.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(CollectionCloneAlg_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(CollectionCloneAlg_cppflags) $(CollectionCloneAlg_cpp_cppflags) -I../src/NTupleSvc $(src)NTupleSvc/CollectionCloneAlg.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RndmEngine.d

$(bin)$(binobj)RndmEngine.d :

$(bin)$(binobj)RndmEngine.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)RndmEngine.o : $(src)RndmGenSvc/RndmEngine.cpp
	$(cpp_echo) $(src)RndmGenSvc/RndmEngine.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmEngine_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmEngine_cppflags) $(RndmEngine_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmEngine.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(RndmEngine_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)RndmGenSvc/RndmEngine.cpp

$(bin)$(binobj)RndmEngine.o : $(RndmEngine_cpp_dependencies)
	$(cpp_echo) $(src)RndmGenSvc/RndmEngine.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmEngine_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmEngine_cppflags) $(RndmEngine_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmEngine.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HepRndmEngines.d

$(bin)$(binobj)HepRndmEngines.d :

$(bin)$(binobj)HepRndmEngines.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)HepRndmEngines.o : $(src)RndmGenSvc/HepRndmEngines.cpp
	$(cpp_echo) $(src)RndmGenSvc/HepRndmEngines.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(HepRndmEngines_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(HepRndmEngines_cppflags) $(HepRndmEngines_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/HepRndmEngines.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(HepRndmEngines_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)RndmGenSvc/HepRndmEngines.cpp

$(bin)$(binobj)HepRndmEngines.o : $(HepRndmEngines_cpp_dependencies)
	$(cpp_echo) $(src)RndmGenSvc/HepRndmEngines.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(HepRndmEngines_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(HepRndmEngines_cppflags) $(HepRndmEngines_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/HepRndmEngines.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RndmGen.d

$(bin)$(binobj)RndmGen.d :

$(bin)$(binobj)RndmGen.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)RndmGen.o : $(src)RndmGenSvc/RndmGen.cpp
	$(cpp_echo) $(src)RndmGenSvc/RndmGen.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmGen_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmGen_cppflags) $(RndmGen_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmGen.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(RndmGen_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)RndmGenSvc/RndmGen.cpp

$(bin)$(binobj)RndmGen.o : $(RndmGen_cpp_dependencies)
	$(cpp_echo) $(src)RndmGenSvc/RndmGen.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmGen_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmGen_cppflags) $(RndmGen_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmGen.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RndmGenSvc.d

$(bin)$(binobj)RndmGenSvc.d :

$(bin)$(binobj)RndmGenSvc.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)RndmGenSvc.o : $(src)RndmGenSvc/RndmGenSvc.cpp
	$(cpp_echo) $(src)RndmGenSvc/RndmGenSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmGenSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmGenSvc_cppflags) $(RndmGenSvc_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmGenSvc.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(RndmGenSvc_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)RndmGenSvc/RndmGenSvc.cpp

$(bin)$(binobj)RndmGenSvc.o : $(RndmGenSvc_cpp_dependencies)
	$(cpp_echo) $(src)RndmGenSvc/RndmGenSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RndmGenSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RndmGenSvc_cppflags) $(RndmGenSvc_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/RndmGenSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HepRndmGenerators.d

$(bin)$(binobj)HepRndmGenerators.d :

$(bin)$(binobj)HepRndmGenerators.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)HepRndmGenerators.o : $(src)RndmGenSvc/HepRndmGenerators.cpp
	$(cpp_echo) $(src)RndmGenSvc/HepRndmGenerators.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(HepRndmGenerators_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(HepRndmGenerators_cppflags) $(HepRndmGenerators_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/HepRndmGenerators.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(HepRndmGenerators_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)RndmGenSvc/HepRndmGenerators.cpp

$(bin)$(binobj)HepRndmGenerators.o : $(HepRndmGenerators_cpp_dependencies)
	$(cpp_echo) $(src)RndmGenSvc/HepRndmGenerators.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(HepRndmGenerators_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(HepRndmGenerators_cppflags) $(HepRndmGenerators_cpp_cppflags) -I../src/RndmGenSvc $(src)RndmGenSvc/HepRndmGenerators.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)THistSvc.d

$(bin)$(binobj)THistSvc.d :

$(bin)$(binobj)THistSvc.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)THistSvc.o : $(src)THistSvc/THistSvc.cpp
	$(cpp_echo) $(src)THistSvc/THistSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(THistSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(THistSvc_cppflags) $(THistSvc_cpp_cppflags) -I../src/THistSvc $(src)THistSvc/THistSvc.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(THistSvc_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)THistSvc/THistSvc.cpp

$(bin)$(binobj)THistSvc.o : $(THistSvc_cpp_dependencies)
	$(cpp_echo) $(src)THistSvc/THistSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(THistSvc_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(THistSvc_cppflags) $(THistSvc_cpp_cppflags) -I../src/THistSvc $(src)THistSvc/THistSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)POSIXFileHandler.d

$(bin)$(binobj)POSIXFileHandler.d :

$(bin)$(binobj)POSIXFileHandler.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)POSIXFileHandler.o : $(src)FileMgr/POSIXFileHandler.cpp
	$(cpp_echo) $(src)FileMgr/POSIXFileHandler.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(POSIXFileHandler_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(POSIXFileHandler_cppflags) $(POSIXFileHandler_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/POSIXFileHandler.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(POSIXFileHandler_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)FileMgr/POSIXFileHandler.cpp

$(bin)$(binobj)POSIXFileHandler.o : $(POSIXFileHandler_cpp_dependencies)
	$(cpp_echo) $(src)FileMgr/POSIXFileHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(POSIXFileHandler_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(POSIXFileHandler_cppflags) $(POSIXFileHandler_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/POSIXFileHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootFileHandler.d

$(bin)$(binobj)RootFileHandler.d :

$(bin)$(binobj)RootFileHandler.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)RootFileHandler.o : $(src)FileMgr/RootFileHandler.cpp
	$(cpp_echo) $(src)FileMgr/RootFileHandler.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RootFileHandler_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RootFileHandler_cppflags) $(RootFileHandler_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/RootFileHandler.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(RootFileHandler_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)FileMgr/RootFileHandler.cpp

$(bin)$(binobj)RootFileHandler.o : $(RootFileHandler_cpp_dependencies)
	$(cpp_echo) $(src)FileMgr/RootFileHandler.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(RootFileHandler_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(RootFileHandler_cppflags) $(RootFileHandler_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/RootFileHandler.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiSvcclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)FileMgr.d

$(bin)$(binobj)FileMgr.d :

$(bin)$(binobj)FileMgr.o : $(cmt_final_setup_GaudiSvc)

$(bin)$(binobj)FileMgr.o : $(src)FileMgr/FileMgr.cpp
	$(cpp_echo) $(src)FileMgr/FileMgr.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(FileMgr_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(FileMgr_cppflags) $(FileMgr_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/FileMgr.cpp
endif
endif

else
$(bin)GaudiSvc_dependencies.make : $(FileMgr_cpp_dependencies)

$(bin)GaudiSvc_dependencies.make : $(src)FileMgr/FileMgr.cpp

$(bin)$(binobj)FileMgr.o : $(FileMgr_cpp_dependencies)
	$(cpp_echo) $(src)FileMgr/FileMgr.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiSvc_pp_cppflags) $(lib_GaudiSvc_pp_cppflags) $(FileMgr_pp_cppflags) $(use_cppflags) $(GaudiSvc_cppflags) $(lib_GaudiSvc_cppflags) $(FileMgr_cppflags) $(FileMgr_cpp_cppflags) -I../src/FileMgr $(src)FileMgr/FileMgr.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiSvcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvc.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiSvc
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiSvc$(library_suffix).a $(library_prefix)GaudiSvc$(library_suffix).$(shlibsuffix) GaudiSvc.stamp GaudiSvc.shstamp
#-- end of cleanup_library ---------------
