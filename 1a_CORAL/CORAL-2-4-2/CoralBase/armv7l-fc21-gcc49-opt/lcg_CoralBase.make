#-- start of make_header -----------------

#====================================
#  Library lcg_CoralBase
#
#   Generated Wed Apr 15 16:26:50 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralBase_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralBase_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralBase

CoralBase_tag = $(tag)

#cmt_local_tagfile_lcg_CoralBase = $(CoralBase_tag)_lcg_CoralBase.make
cmt_local_tagfile_lcg_CoralBase = $(bin)$(CoralBase_tag)_lcg_CoralBase.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralBase_tag = $(tag)

#cmt_local_tagfile_lcg_CoralBase = $(CoralBase_tag).make
cmt_local_tagfile_lcg_CoralBase = $(bin)$(CoralBase_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralBase)
#-include $(cmt_local_tagfile_lcg_CoralBase)

ifdef cmt_lcg_CoralBase_has_target_tag

cmt_final_setup_lcg_CoralBase = $(bin)setup_lcg_CoralBase.make
cmt_dependencies_in_lcg_CoralBase = $(bin)dependencies_lcg_CoralBase.in
#cmt_final_setup_lcg_CoralBase = $(bin)CoralBase_lcg_CoralBasesetup.make
cmt_local_lcg_CoralBase_makefile = $(bin)lcg_CoralBase.make

else

cmt_final_setup_lcg_CoralBase = $(bin)setup.make
cmt_dependencies_in_lcg_CoralBase = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralBase = $(bin)CoralBasesetup.make
cmt_local_lcg_CoralBase_makefile = $(bin)lcg_CoralBase.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralBasesetup.make

#lcg_CoralBase :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralBase'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralBase/
#lcg_CoralBase::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralBaselibname   = $(bin)$(library_prefix)lcg_CoralBase$(library_suffix)
lcg_CoralBaselib       = $(lcg_CoralBaselibname).a
lcg_CoralBasestamp     = $(bin)lcg_CoralBase.stamp
lcg_CoralBaseshstamp   = $(bin)lcg_CoralBase.shstamp

lcg_CoralBase :: dirs  lcg_CoralBaseLIB
	$(echo) "lcg_CoralBase ok"

cmt_lcg_CoralBase_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralBase_has_prototypes

lcg_CoralBaseprototype :  ;

endif

lcg_CoralBasecompile : $(bin)MsgReporter2.o $(bin)AttributeSpecification.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)Blob.o $(bin)AttributeDataFactory.o $(bin)MsgReporter.o $(bin)TimeStamp.o $(bin)AttributeListSpecification.o $(bin)MessageStream.o $(bin)Date.o $(bin)Exception.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralBaseLIB :: $(lcg_CoralBaselib) $(lcg_CoralBaseshstamp)
	@/bin/echo "------> lcg_CoralBase : library ok"

$(lcg_CoralBaselib) :: $(bin)MsgReporter2.o $(bin)AttributeSpecification.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)Blob.o $(bin)AttributeDataFactory.o $(bin)MsgReporter.o $(bin)TimeStamp.o $(bin)AttributeListSpecification.o $(bin)MessageStream.o $(bin)Date.o $(bin)Exception.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralBaselib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralBaselib)
	$(lib_silent) cat /dev/null >$(lcg_CoralBasestamp)

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

$(lcg_CoralBaselibname).$(shlibsuffix) :: $(lcg_CoralBaselib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralBase $(lcg_CoralBase_shlibflags)

$(lcg_CoralBaseshstamp) :: $(lcg_CoralBaselibname).$(shlibsuffix)
	@if test -f $(lcg_CoralBaselibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralBaseshstamp) ; fi

lcg_CoralBaseclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)MsgReporter2.o $(bin)AttributeSpecification.o $(bin)Attribute.o $(bin)AttributeList.o $(bin)Blob.o $(bin)AttributeDataFactory.o $(bin)MsgReporter.o $(bin)TimeStamp.o $(bin)AttributeListSpecification.o $(bin)MessageStream.o $(bin)Date.o $(bin)Exception.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralBaseinstallname = $(library_prefix)lcg_CoralBase$(library_suffix).$(shlibsuffix)

lcg_CoralBase :: lcg_CoralBaseinstall

install :: lcg_CoralBaseinstall

lcg_CoralBaseinstall :: $(install_dir)/$(lcg_CoralBaseinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralBaseinstallname) :: $(bin)$(lcg_CoralBaseinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralBaseinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralBaseclean :: lcg_CoralBaseuninstall

uninstall :: lcg_CoralBaseuninstall

lcg_CoralBaseuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralBaseinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralBaseprototype)

$(bin)lcg_CoralBase_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralBase)
	$(echo) "(lcg_CoralBase.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)MsgReporter2.cpp $(src)AttributeSpecification.cpp $(src)Attribute.cpp $(src)AttributeList.cpp $(src)Blob.cpp $(src)AttributeDataFactory.cpp $(src)MsgReporter.cpp $(src)TimeStamp.cpp $(src)AttributeListSpecification.cpp $(src)MessageStream.cpp $(src)Date.cpp $(src)Exception.cpp -end_all $(includes) $(app_lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) -name=lcg_CoralBase $? -f=$(cmt_dependencies_in_lcg_CoralBase) -without_cmt

-include $(bin)lcg_CoralBase_dependencies.make

endif
endif
endif

lcg_CoralBaseclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralBase_deps $(bin)lcg_CoralBase_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MsgReporter2.d

$(bin)$(binobj)MsgReporter2.d :

$(bin)$(binobj)MsgReporter2.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)MsgReporter2.o : $(src)MsgReporter2.cpp
	$(cpp_echo) $(src)MsgReporter2.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MsgReporter2_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MsgReporter2_cppflags) $(MsgReporter2_cpp_cppflags)  $(src)MsgReporter2.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(MsgReporter2_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)MsgReporter2.cpp

$(bin)$(binobj)MsgReporter2.o : $(MsgReporter2_cpp_dependencies)
	$(cpp_echo) $(src)MsgReporter2.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MsgReporter2_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MsgReporter2_cppflags) $(MsgReporter2_cpp_cppflags)  $(src)MsgReporter2.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeSpecification.d

$(bin)$(binobj)AttributeSpecification.d :

$(bin)$(binobj)AttributeSpecification.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)AttributeSpecification.o : $(src)AttributeSpecification.cpp
	$(cpp_echo) $(src)AttributeSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeSpecification_cppflags) $(AttributeSpecification_cpp_cppflags)  $(src)AttributeSpecification.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(AttributeSpecification_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)AttributeSpecification.cpp

$(bin)$(binobj)AttributeSpecification.o : $(AttributeSpecification_cpp_dependencies)
	$(cpp_echo) $(src)AttributeSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeSpecification_cppflags) $(AttributeSpecification_cpp_cppflags)  $(src)AttributeSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Attribute.d

$(bin)$(binobj)Attribute.d :

$(bin)$(binobj)Attribute.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)Attribute.o : $(src)Attribute.cpp
	$(cpp_echo) $(src)Attribute.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Attribute_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Attribute_cppflags) $(Attribute_cpp_cppflags)  $(src)Attribute.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(Attribute_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)Attribute.cpp

$(bin)$(binobj)Attribute.o : $(Attribute_cpp_dependencies)
	$(cpp_echo) $(src)Attribute.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Attribute_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Attribute_cppflags) $(Attribute_cpp_cppflags)  $(src)Attribute.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeList.d

$(bin)$(binobj)AttributeList.d :

$(bin)$(binobj)AttributeList.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)AttributeList.o : $(src)AttributeList.cpp
	$(cpp_echo) $(src)AttributeList.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeList_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeList_cppflags) $(AttributeList_cpp_cppflags)  $(src)AttributeList.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(AttributeList_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)AttributeList.cpp

$(bin)$(binobj)AttributeList.o : $(AttributeList_cpp_dependencies)
	$(cpp_echo) $(src)AttributeList.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeList_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeList_cppflags) $(AttributeList_cpp_cppflags)  $(src)AttributeList.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Blob.d

$(bin)$(binobj)Blob.d :

$(bin)$(binobj)Blob.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)Blob.o : $(src)Blob.cpp
	$(cpp_echo) $(src)Blob.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Blob_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Blob_cppflags) $(Blob_cpp_cppflags)  $(src)Blob.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(Blob_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)Blob.cpp

$(bin)$(binobj)Blob.o : $(Blob_cpp_dependencies)
	$(cpp_echo) $(src)Blob.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Blob_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Blob_cppflags) $(Blob_cpp_cppflags)  $(src)Blob.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeDataFactory.d

$(bin)$(binobj)AttributeDataFactory.d :

$(bin)$(binobj)AttributeDataFactory.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)AttributeDataFactory.o : $(src)AttributeDataFactory.cpp
	$(cpp_echo) $(src)AttributeDataFactory.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeDataFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeDataFactory_cppflags) $(AttributeDataFactory_cpp_cppflags)  $(src)AttributeDataFactory.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(AttributeDataFactory_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)AttributeDataFactory.cpp

$(bin)$(binobj)AttributeDataFactory.o : $(AttributeDataFactory_cpp_dependencies)
	$(cpp_echo) $(src)AttributeDataFactory.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeDataFactory_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeDataFactory_cppflags) $(AttributeDataFactory_cpp_cppflags)  $(src)AttributeDataFactory.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MsgReporter.d

$(bin)$(binobj)MsgReporter.d :

$(bin)$(binobj)MsgReporter.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)MsgReporter.o : $(src)MsgReporter.cpp
	$(cpp_echo) $(src)MsgReporter.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MsgReporter_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MsgReporter_cppflags) $(MsgReporter_cpp_cppflags)  $(src)MsgReporter.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(MsgReporter_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)MsgReporter.cpp

$(bin)$(binobj)MsgReporter.o : $(MsgReporter_cpp_dependencies)
	$(cpp_echo) $(src)MsgReporter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MsgReporter_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MsgReporter_cppflags) $(MsgReporter_cpp_cppflags)  $(src)MsgReporter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimeStamp.d

$(bin)$(binobj)TimeStamp.d :

$(bin)$(binobj)TimeStamp.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)TimeStamp.o : $(src)TimeStamp.cpp
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(TimeStamp_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)TimeStamp.cpp

$(bin)$(binobj)TimeStamp.o : $(TimeStamp_cpp_dependencies)
	$(cpp_echo) $(src)TimeStamp.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(TimeStamp_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(TimeStamp_cppflags) $(TimeStamp_cpp_cppflags)  $(src)TimeStamp.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeListSpecification.d

$(bin)$(binobj)AttributeListSpecification.d :

$(bin)$(binobj)AttributeListSpecification.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)AttributeListSpecification.o : $(src)AttributeListSpecification.cpp
	$(cpp_echo) $(src)AttributeListSpecification.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeListSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeListSpecification_cppflags) $(AttributeListSpecification_cpp_cppflags)  $(src)AttributeListSpecification.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(AttributeListSpecification_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)AttributeListSpecification.cpp

$(bin)$(binobj)AttributeListSpecification.o : $(AttributeListSpecification_cpp_dependencies)
	$(cpp_echo) $(src)AttributeListSpecification.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(AttributeListSpecification_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(AttributeListSpecification_cppflags) $(AttributeListSpecification_cpp_cppflags)  $(src)AttributeListSpecification.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MessageStream.d

$(bin)$(binobj)MessageStream.d :

$(bin)$(binobj)MessageStream.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)MessageStream.o : $(src)MessageStream.cpp
	$(cpp_echo) $(src)MessageStream.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MessageStream_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MessageStream_cppflags) $(MessageStream_cpp_cppflags)  $(src)MessageStream.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(MessageStream_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)MessageStream.cpp

$(bin)$(binobj)MessageStream.o : $(MessageStream_cpp_dependencies)
	$(cpp_echo) $(src)MessageStream.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(MessageStream_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(MessageStream_cppflags) $(MessageStream_cpp_cppflags)  $(src)MessageStream.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Date.d

$(bin)$(binobj)Date.d :

$(bin)$(binobj)Date.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)Date.o : $(src)Date.cpp
	$(cpp_echo) $(src)Date.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Date_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Date_cppflags) $(Date_cpp_cppflags)  $(src)Date.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(Date_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)Date.cpp

$(bin)$(binobj)Date.o : $(Date_cpp_dependencies)
	$(cpp_echo) $(src)Date.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Date_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Date_cppflags) $(Date_cpp_cppflags)  $(src)Date.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Exception.d

$(bin)$(binobj)Exception.d :

$(bin)$(binobj)Exception.o : $(cmt_final_setup_lcg_CoralBase)

$(bin)$(binobj)Exception.o : $(src)Exception.cpp
	$(cpp_echo) $(src)Exception.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Exception_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Exception_cppflags) $(Exception_cpp_cppflags)  $(src)Exception.cpp
endif
endif

else
$(bin)lcg_CoralBase_dependencies.make : $(Exception_cpp_dependencies)

$(bin)lcg_CoralBase_dependencies.make : $(src)Exception.cpp

$(bin)$(binobj)Exception.o : $(Exception_cpp_dependencies)
	$(cpp_echo) $(src)Exception.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralBase_pp_cppflags) $(lib_lcg_CoralBase_pp_cppflags) $(Exception_pp_cppflags) $(use_cppflags) $(lcg_CoralBase_cppflags) $(lib_lcg_CoralBase_cppflags) $(Exception_cppflags) $(Exception_cpp_cppflags)  $(src)Exception.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralBaseclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralBase.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralBaseclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralBase
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralBase$(library_suffix).a $(library_prefix)lcg_CoralBase$(library_suffix).$(shlibsuffix) lcg_CoralBase.stamp lcg_CoralBase.shstamp
#-- end of cleanup_library ---------------
