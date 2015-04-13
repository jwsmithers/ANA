#-- start of make_header -----------------

#====================================
#  Library lcg_CoralStubs
#
#   Generated Wed Jan 21 17:22:13 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralStubs_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralStubs_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralStubs

CoralStubs_tag = $(tag)

#cmt_local_tagfile_lcg_CoralStubs = $(CoralStubs_tag)_lcg_CoralStubs.make
cmt_local_tagfile_lcg_CoralStubs = $(bin)$(CoralStubs_tag)_lcg_CoralStubs.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralStubs_tag = $(tag)

#cmt_local_tagfile_lcg_CoralStubs = $(CoralStubs_tag).make
cmt_local_tagfile_lcg_CoralStubs = $(bin)$(CoralStubs_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralStubs)
#-include $(cmt_local_tagfile_lcg_CoralStubs)

ifdef cmt_lcg_CoralStubs_has_target_tag

cmt_final_setup_lcg_CoralStubs = $(bin)setup_lcg_CoralStubs.make
cmt_dependencies_in_lcg_CoralStubs = $(bin)dependencies_lcg_CoralStubs.in
#cmt_final_setup_lcg_CoralStubs = $(bin)CoralStubs_lcg_CoralStubssetup.make
cmt_local_lcg_CoralStubs_makefile = $(bin)lcg_CoralStubs.make

else

cmt_final_setup_lcg_CoralStubs = $(bin)setup.make
cmt_dependencies_in_lcg_CoralStubs = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralStubs = $(bin)CoralStubssetup.make
cmt_local_lcg_CoralStubs_makefile = $(bin)lcg_CoralStubs.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralStubssetup.make

#lcg_CoralStubs :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralStubs'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralStubs/
#lcg_CoralStubs::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralStubslibname   = $(bin)$(library_prefix)lcg_CoralStubs$(library_suffix)
lcg_CoralStubslib       = $(lcg_CoralStubslibname).a
lcg_CoralStubsstamp     = $(bin)lcg_CoralStubs.stamp
lcg_CoralStubsshstamp   = $(bin)lcg_CoralStubs.shstamp

lcg_CoralStubs :: dirs  lcg_CoralStubsLIB
	$(echo) "lcg_CoralStubs ok"

cmt_lcg_CoralStubs_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralStubs_has_prototypes

lcg_CoralStubsprototype :  ;

endif

lcg_CoralStubscompile : $(bin)ServerStub.o $(bin)SimpleByteBufferIterator.o $(bin)DummyByteBufferIterator.o $(bin)DummyFacade.o $(bin)AttributeUtils.o $(bin)SegmentWriterIterator.o $(bin)ClientStub.o $(bin)DummyRowIterator.o $(bin)RowIteratorFetch.o $(bin)Exceptions.o $(bin)SegmentReaderIterator.o $(bin)RowIteratorAll.o $(bin)ByteBufferIteratorAll.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralStubsLIB :: $(lcg_CoralStubslib) $(lcg_CoralStubsshstamp)
	@/bin/echo "------> lcg_CoralStubs : library ok"

$(lcg_CoralStubslib) :: $(bin)ServerStub.o $(bin)SimpleByteBufferIterator.o $(bin)DummyByteBufferIterator.o $(bin)DummyFacade.o $(bin)AttributeUtils.o $(bin)SegmentWriterIterator.o $(bin)ClientStub.o $(bin)DummyRowIterator.o $(bin)RowIteratorFetch.o $(bin)Exceptions.o $(bin)SegmentReaderIterator.o $(bin)RowIteratorAll.o $(bin)ByteBufferIteratorAll.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralStubslib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralStubslib)
	$(lib_silent) cat /dev/null >$(lcg_CoralStubsstamp)

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

$(lcg_CoralStubslibname).$(shlibsuffix) :: $(lcg_CoralStubslib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralStubs $(lcg_CoralStubs_shlibflags)

$(lcg_CoralStubsshstamp) :: $(lcg_CoralStubslibname).$(shlibsuffix)
	@if test -f $(lcg_CoralStubslibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralStubsshstamp) ; fi

lcg_CoralStubsclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)ServerStub.o $(bin)SimpleByteBufferIterator.o $(bin)DummyByteBufferIterator.o $(bin)DummyFacade.o $(bin)AttributeUtils.o $(bin)SegmentWriterIterator.o $(bin)ClientStub.o $(bin)DummyRowIterator.o $(bin)RowIteratorFetch.o $(bin)Exceptions.o $(bin)SegmentReaderIterator.o $(bin)RowIteratorAll.o $(bin)ByteBufferIteratorAll.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralStubsinstallname = $(library_prefix)lcg_CoralStubs$(library_suffix).$(shlibsuffix)

lcg_CoralStubs :: lcg_CoralStubsinstall

install :: lcg_CoralStubsinstall

lcg_CoralStubsinstall :: $(install_dir)/$(lcg_CoralStubsinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralStubsinstallname) :: $(bin)$(lcg_CoralStubsinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralStubsinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralStubsclean :: lcg_CoralStubsuninstall

uninstall :: lcg_CoralStubsuninstall

lcg_CoralStubsuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralStubsinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralStubsprototype)

$(bin)lcg_CoralStubs_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralStubs)
	$(echo) "(lcg_CoralStubs.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)ServerStub.cpp $(src)SimpleByteBufferIterator.cpp $(src)DummyByteBufferIterator.cpp $(src)DummyFacade.cpp $(src)AttributeUtils.cpp $(src)SegmentWriterIterator.cpp $(src)ClientStub.cpp $(src)DummyRowIterator.cpp $(src)RowIteratorFetch.cpp $(src)Exceptions.cpp $(src)SegmentReaderIterator.cpp $(src)RowIteratorAll.cpp $(src)ByteBufferIteratorAll.cpp -end_all $(includes) $(app_lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) -name=lcg_CoralStubs $? -f=$(cmt_dependencies_in_lcg_CoralStubs) -without_cmt

-include $(bin)lcg_CoralStubs_dependencies.make

endif
endif
endif

lcg_CoralStubsclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralStubs_deps $(bin)lcg_CoralStubs_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ServerStub.d

$(bin)$(binobj)ServerStub.d :

$(bin)$(binobj)ServerStub.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)ServerStub.o : $(src)ServerStub.cpp
	$(cpp_echo) $(src)ServerStub.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ServerStub_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ServerStub_cppflags) $(ServerStub_cpp_cppflags)  $(src)ServerStub.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(ServerStub_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)ServerStub.cpp

$(bin)$(binobj)ServerStub.o : $(ServerStub_cpp_dependencies)
	$(cpp_echo) $(src)ServerStub.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ServerStub_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ServerStub_cppflags) $(ServerStub_cpp_cppflags)  $(src)ServerStub.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SimpleByteBufferIterator.d

$(bin)$(binobj)SimpleByteBufferIterator.d :

$(bin)$(binobj)SimpleByteBufferIterator.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)SimpleByteBufferIterator.o : $(src)SimpleByteBufferIterator.cpp
	$(cpp_echo) $(src)SimpleByteBufferIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SimpleByteBufferIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SimpleByteBufferIterator_cppflags) $(SimpleByteBufferIterator_cpp_cppflags)  $(src)SimpleByteBufferIterator.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(SimpleByteBufferIterator_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)SimpleByteBufferIterator.cpp

$(bin)$(binobj)SimpleByteBufferIterator.o : $(SimpleByteBufferIterator_cpp_dependencies)
	$(cpp_echo) $(src)SimpleByteBufferIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SimpleByteBufferIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SimpleByteBufferIterator_cppflags) $(SimpleByteBufferIterator_cpp_cppflags)  $(src)SimpleByteBufferIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyByteBufferIterator.d

$(bin)$(binobj)DummyByteBufferIterator.d :

$(bin)$(binobj)DummyByteBufferIterator.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)DummyByteBufferIterator.o : $(src)DummyByteBufferIterator.cpp
	$(cpp_echo) $(src)DummyByteBufferIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyByteBufferIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyByteBufferIterator_cppflags) $(DummyByteBufferIterator_cpp_cppflags)  $(src)DummyByteBufferIterator.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(DummyByteBufferIterator_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)DummyByteBufferIterator.cpp

$(bin)$(binobj)DummyByteBufferIterator.o : $(DummyByteBufferIterator_cpp_dependencies)
	$(cpp_echo) $(src)DummyByteBufferIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyByteBufferIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyByteBufferIterator_cppflags) $(DummyByteBufferIterator_cpp_cppflags)  $(src)DummyByteBufferIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyFacade.d

$(bin)$(binobj)DummyFacade.d :

$(bin)$(binobj)DummyFacade.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)DummyFacade.o : $(src)DummyFacade.cpp
	$(cpp_echo) $(src)DummyFacade.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyFacade_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyFacade_cppflags) $(DummyFacade_cpp_cppflags)  $(src)DummyFacade.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(DummyFacade_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)DummyFacade.cpp

$(bin)$(binobj)DummyFacade.o : $(DummyFacade_cpp_dependencies)
	$(cpp_echo) $(src)DummyFacade.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyFacade_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyFacade_cppflags) $(DummyFacade_cpp_cppflags)  $(src)DummyFacade.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AttributeUtils.d

$(bin)$(binobj)AttributeUtils.d :

$(bin)$(binobj)AttributeUtils.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)AttributeUtils.o : $(src)AttributeUtils.cpp
	$(cpp_echo) $(src)AttributeUtils.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(AttributeUtils_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(AttributeUtils_cppflags) $(AttributeUtils_cpp_cppflags)  $(src)AttributeUtils.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(AttributeUtils_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)AttributeUtils.cpp

$(bin)$(binobj)AttributeUtils.o : $(AttributeUtils_cpp_dependencies)
	$(cpp_echo) $(src)AttributeUtils.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(AttributeUtils_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(AttributeUtils_cppflags) $(AttributeUtils_cpp_cppflags)  $(src)AttributeUtils.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SegmentWriterIterator.d

$(bin)$(binobj)SegmentWriterIterator.d :

$(bin)$(binobj)SegmentWriterIterator.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)SegmentWriterIterator.o : $(src)SegmentWriterIterator.cpp
	$(cpp_echo) $(src)SegmentWriterIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SegmentWriterIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SegmentWriterIterator_cppflags) $(SegmentWriterIterator_cpp_cppflags)  $(src)SegmentWriterIterator.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(SegmentWriterIterator_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)SegmentWriterIterator.cpp

$(bin)$(binobj)SegmentWriterIterator.o : $(SegmentWriterIterator_cpp_dependencies)
	$(cpp_echo) $(src)SegmentWriterIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SegmentWriterIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SegmentWriterIterator_cppflags) $(SegmentWriterIterator_cpp_cppflags)  $(src)SegmentWriterIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ClientStub.d

$(bin)$(binobj)ClientStub.d :

$(bin)$(binobj)ClientStub.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)ClientStub.o : $(src)ClientStub.cpp
	$(cpp_echo) $(src)ClientStub.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ClientStub_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ClientStub_cppflags) $(ClientStub_cpp_cppflags)  $(src)ClientStub.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(ClientStub_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)ClientStub.cpp

$(bin)$(binobj)ClientStub.o : $(ClientStub_cpp_dependencies)
	$(cpp_echo) $(src)ClientStub.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ClientStub_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ClientStub_cppflags) $(ClientStub_cpp_cppflags)  $(src)ClientStub.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DummyRowIterator.d

$(bin)$(binobj)DummyRowIterator.d :

$(bin)$(binobj)DummyRowIterator.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)DummyRowIterator.o : $(src)DummyRowIterator.cpp
	$(cpp_echo) $(src)DummyRowIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyRowIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyRowIterator_cppflags) $(DummyRowIterator_cpp_cppflags)  $(src)DummyRowIterator.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(DummyRowIterator_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)DummyRowIterator.cpp

$(bin)$(binobj)DummyRowIterator.o : $(DummyRowIterator_cpp_dependencies)
	$(cpp_echo) $(src)DummyRowIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(DummyRowIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(DummyRowIterator_cppflags) $(DummyRowIterator_cpp_cppflags)  $(src)DummyRowIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RowIteratorFetch.d

$(bin)$(binobj)RowIteratorFetch.d :

$(bin)$(binobj)RowIteratorFetch.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)RowIteratorFetch.o : $(src)RowIteratorFetch.cpp
	$(cpp_echo) $(src)RowIteratorFetch.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(RowIteratorFetch_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(RowIteratorFetch_cppflags) $(RowIteratorFetch_cpp_cppflags)  $(src)RowIteratorFetch.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(RowIteratorFetch_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)RowIteratorFetch.cpp

$(bin)$(binobj)RowIteratorFetch.o : $(RowIteratorFetch_cpp_dependencies)
	$(cpp_echo) $(src)RowIteratorFetch.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(RowIteratorFetch_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(RowIteratorFetch_cppflags) $(RowIteratorFetch_cpp_cppflags)  $(src)RowIteratorFetch.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Exceptions.d

$(bin)$(binobj)Exceptions.d :

$(bin)$(binobj)Exceptions.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)Exceptions.o : $(src)Exceptions.cpp
	$(cpp_echo) $(src)Exceptions.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(Exceptions_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(Exceptions_cppflags) $(Exceptions_cpp_cppflags)  $(src)Exceptions.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(Exceptions_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)Exceptions.cpp

$(bin)$(binobj)Exceptions.o : $(Exceptions_cpp_dependencies)
	$(cpp_echo) $(src)Exceptions.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(Exceptions_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(Exceptions_cppflags) $(Exceptions_cpp_cppflags)  $(src)Exceptions.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SegmentReaderIterator.d

$(bin)$(binobj)SegmentReaderIterator.d :

$(bin)$(binobj)SegmentReaderIterator.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)SegmentReaderIterator.o : $(src)SegmentReaderIterator.cpp
	$(cpp_echo) $(src)SegmentReaderIterator.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SegmentReaderIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SegmentReaderIterator_cppflags) $(SegmentReaderIterator_cpp_cppflags)  $(src)SegmentReaderIterator.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(SegmentReaderIterator_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)SegmentReaderIterator.cpp

$(bin)$(binobj)SegmentReaderIterator.o : $(SegmentReaderIterator_cpp_dependencies)
	$(cpp_echo) $(src)SegmentReaderIterator.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(SegmentReaderIterator_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(SegmentReaderIterator_cppflags) $(SegmentReaderIterator_cpp_cppflags)  $(src)SegmentReaderIterator.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RowIteratorAll.d

$(bin)$(binobj)RowIteratorAll.d :

$(bin)$(binobj)RowIteratorAll.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)RowIteratorAll.o : $(src)RowIteratorAll.cpp
	$(cpp_echo) $(src)RowIteratorAll.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(RowIteratorAll_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(RowIteratorAll_cppflags) $(RowIteratorAll_cpp_cppflags)  $(src)RowIteratorAll.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(RowIteratorAll_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)RowIteratorAll.cpp

$(bin)$(binobj)RowIteratorAll.o : $(RowIteratorAll_cpp_dependencies)
	$(cpp_echo) $(src)RowIteratorAll.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(RowIteratorAll_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(RowIteratorAll_cppflags) $(RowIteratorAll_cpp_cppflags)  $(src)RowIteratorAll.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralStubsclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ByteBufferIteratorAll.d

$(bin)$(binobj)ByteBufferIteratorAll.d :

$(bin)$(binobj)ByteBufferIteratorAll.o : $(cmt_final_setup_lcg_CoralStubs)

$(bin)$(binobj)ByteBufferIteratorAll.o : $(src)ByteBufferIteratorAll.cpp
	$(cpp_echo) $(src)ByteBufferIteratorAll.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ByteBufferIteratorAll_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ByteBufferIteratorAll_cppflags) $(ByteBufferIteratorAll_cpp_cppflags)  $(src)ByteBufferIteratorAll.cpp
endif
endif

else
$(bin)lcg_CoralStubs_dependencies.make : $(ByteBufferIteratorAll_cpp_dependencies)

$(bin)lcg_CoralStubs_dependencies.make : $(src)ByteBufferIteratorAll.cpp

$(bin)$(binobj)ByteBufferIteratorAll.o : $(ByteBufferIteratorAll_cpp_dependencies)
	$(cpp_echo) $(src)ByteBufferIteratorAll.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralStubs_pp_cppflags) $(lib_lcg_CoralStubs_pp_cppflags) $(ByteBufferIteratorAll_pp_cppflags) $(use_cppflags) $(lcg_CoralStubs_cppflags) $(lib_lcg_CoralStubs_cppflags) $(ByteBufferIteratorAll_cppflags) $(ByteBufferIteratorAll_cpp_cppflags)  $(src)ByteBufferIteratorAll.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralStubsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralStubs.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralStubsclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralStubs
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralStubs$(library_suffix).a $(library_prefix)lcg_CoralStubs$(library_suffix).$(shlibsuffix) lcg_CoralStubs.stamp lcg_CoralStubs.shstamp
#-- end of cleanup_library ---------------
