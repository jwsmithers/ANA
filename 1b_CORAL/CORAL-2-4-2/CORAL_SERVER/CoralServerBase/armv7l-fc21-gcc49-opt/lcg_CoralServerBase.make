#-- start of make_header -----------------

#====================================
#  Library lcg_CoralServerBase
#
#   Generated Wed Jan 21 17:17:19 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_CoralServerBase_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_CoralServerBase_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_CoralServerBase

CoralServerBase_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServerBase = $(CoralServerBase_tag)_lcg_CoralServerBase.make
cmt_local_tagfile_lcg_CoralServerBase = $(bin)$(CoralServerBase_tag)_lcg_CoralServerBase.make

else

tags      = $(tag),$(CMTEXTRATAGS)

CoralServerBase_tag = $(tag)

#cmt_local_tagfile_lcg_CoralServerBase = $(CoralServerBase_tag).make
cmt_local_tagfile_lcg_CoralServerBase = $(bin)$(CoralServerBase_tag).make

endif

include $(cmt_local_tagfile_lcg_CoralServerBase)
#-include $(cmt_local_tagfile_lcg_CoralServerBase)

ifdef cmt_lcg_CoralServerBase_has_target_tag

cmt_final_setup_lcg_CoralServerBase = $(bin)setup_lcg_CoralServerBase.make
cmt_dependencies_in_lcg_CoralServerBase = $(bin)dependencies_lcg_CoralServerBase.in
#cmt_final_setup_lcg_CoralServerBase = $(bin)CoralServerBase_lcg_CoralServerBasesetup.make
cmt_local_lcg_CoralServerBase_makefile = $(bin)lcg_CoralServerBase.make

else

cmt_final_setup_lcg_CoralServerBase = $(bin)setup.make
cmt_dependencies_in_lcg_CoralServerBase = $(bin)dependencies.in
#cmt_final_setup_lcg_CoralServerBase = $(bin)CoralServerBasesetup.make
cmt_local_lcg_CoralServerBase_makefile = $(bin)lcg_CoralServerBase.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)CoralServerBasesetup.make

#lcg_CoralServerBase :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_CoralServerBase'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_CoralServerBase/
#lcg_CoralServerBase::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

lcg_CoralServerBaselibname   = $(bin)$(library_prefix)lcg_CoralServerBase$(library_suffix)
lcg_CoralServerBaselib       = $(lcg_CoralServerBaselibname).a
lcg_CoralServerBasestamp     = $(bin)lcg_CoralServerBase.stamp
lcg_CoralServerBaseshstamp   = $(bin)lcg_CoralServerBase.shstamp

lcg_CoralServerBase :: dirs  lcg_CoralServerBaseLIB
	$(echo) "lcg_CoralServerBase ok"

cmt_lcg_CoralServerBase_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralServerBase_has_prototypes

lcg_CoralServerBaseprototype :  ;

endif

lcg_CoralServerBasecompile : $(bin)CALPacketHeader.o $(bin)crc32.o $(bin)QueryDefinition.o $(bin)CoralServerProxyException.o $(bin)ByteBuffer.o $(bin)CTLPacketHeader.o ;

#-- end of libary_header ----------------
#-- start of libary ----------------------

lcg_CoralServerBaseLIB :: $(lcg_CoralServerBaselib) $(lcg_CoralServerBaseshstamp)
	@/bin/echo "------> lcg_CoralServerBase : library ok"

$(lcg_CoralServerBaselib) :: $(bin)CALPacketHeader.o $(bin)crc32.o $(bin)QueryDefinition.o $(bin)CoralServerProxyException.o $(bin)ByteBuffer.o $(bin)CTLPacketHeader.o
	$(lib_echo) library
	$(lib_silent) cd $(bin); \
	  $(ar) $(lcg_CoralServerBaselib) $?
	$(lib_silent) $(ranlib) $(lcg_CoralServerBaselib)
	$(lib_silent) cat /dev/null >$(lcg_CoralServerBasestamp)

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

$(lcg_CoralServerBaselibname).$(shlibsuffix) :: $(lcg_CoralServerBaselib)
	$(lib_silent) cd $(bin); QUIET=$(QUIET); $(make_shlib) "$(tags)" lcg_CoralServerBase $(lcg_CoralServerBase_shlibflags)

$(lcg_CoralServerBaseshstamp) :: $(lcg_CoralServerBaselibname).$(shlibsuffix)
	@if test -f $(lcg_CoralServerBaselibname).$(shlibsuffix) ; then cat /dev/null >$(lcg_CoralServerBaseshstamp) ; fi

lcg_CoralServerBaseclean ::
	$(cleanup_echo) objects
	$(cleanup_silent) cd $(bin); /bin/rm -f $(bin)CALPacketHeader.o $(bin)crc32.o $(bin)QueryDefinition.o $(bin)CoralServerProxyException.o $(bin)ByteBuffer.o $(bin)CTLPacketHeader.o

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/${libdirname}
lcg_CoralServerBaseinstallname = $(library_prefix)lcg_CoralServerBase$(library_suffix).$(shlibsuffix)

lcg_CoralServerBase :: lcg_CoralServerBaseinstall

install :: lcg_CoralServerBaseinstall

lcg_CoralServerBaseinstall :: $(install_dir)/$(lcg_CoralServerBaseinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then\
	  echo "installation done"; \
	fi

$(install_dir)/$(lcg_CoralServerBaseinstallname) :: $(bin)$(lcg_CoralServerBaseinstallname)
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_install_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerBaseinstallname)" "$(install_dir)" "$(cmt_install_area_command)" ; \
	fi

lcg_CoralServerBaseclean :: lcg_CoralServerBaseuninstall

uninstall :: lcg_CoralServerBaseuninstall

lcg_CoralServerBaseuninstall ::
	@if test ! "${CMTINSTALLAREA}" = ""; then \
	  CMTINSTALLAREA=${CMTINSTALLAREA}; export CMTINSTALLAREA; \
	  $(cmt_uninstall_action) "$(PACKAGE_ROOT)/$(tag)" "$(lcg_CoralServerBaseinstallname)" "$(install_dir)" ; \
	fi


#-- end of libary -----------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseprototype)

$(bin)lcg_CoralServerBase_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_CoralServerBase)
	$(echo) "(lcg_CoralServerBase.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all $(src)CALPacketHeader.cpp $(src)crc32.cpp $(src)QueryDefinition.cpp $(src)CoralServerProxyException.cpp $(src)ByteBuffer.cpp $(src)CTLPacketHeader.cpp -end_all $(includes) $(app_lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) -name=lcg_CoralServerBase $? -f=$(cmt_dependencies_in_lcg_CoralServerBase) -without_cmt

-include $(bin)lcg_CoralServerBase_dependencies.make

endif
endif
endif

lcg_CoralServerBaseclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_CoralServerBase_deps $(bin)lcg_CoralServerBase_dependencies.make
#-- end of dependencies -------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CALPacketHeader.d

$(bin)$(binobj)CALPacketHeader.d :

$(bin)$(binobj)CALPacketHeader.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)CALPacketHeader.o : $(src)CALPacketHeader.cpp
	$(cpp_echo) $(src)CALPacketHeader.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CALPacketHeader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CALPacketHeader_cppflags) $(CALPacketHeader_cpp_cppflags)  $(src)CALPacketHeader.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(CALPacketHeader_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)CALPacketHeader.cpp

$(bin)$(binobj)CALPacketHeader.o : $(CALPacketHeader_cpp_dependencies)
	$(cpp_echo) $(src)CALPacketHeader.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CALPacketHeader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CALPacketHeader_cppflags) $(CALPacketHeader_cpp_cppflags)  $(src)CALPacketHeader.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)crc32.d

$(bin)$(binobj)crc32.d :

$(bin)$(binobj)crc32.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)crc32.o : $(src)crc32.cpp
	$(cpp_echo) $(src)crc32.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(crc32_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(crc32_cppflags) $(crc32_cpp_cppflags)  $(src)crc32.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(crc32_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)crc32.cpp

$(bin)$(binobj)crc32.o : $(crc32_cpp_dependencies)
	$(cpp_echo) $(src)crc32.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(crc32_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(crc32_cppflags) $(crc32_cpp_cppflags)  $(src)crc32.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)QueryDefinition.d

$(bin)$(binobj)QueryDefinition.d :

$(bin)$(binobj)QueryDefinition.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)QueryDefinition.o : $(src)QueryDefinition.cpp
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(QueryDefinition_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)QueryDefinition.cpp

$(bin)$(binobj)QueryDefinition.o : $(QueryDefinition_cpp_dependencies)
	$(cpp_echo) $(src)QueryDefinition.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(QueryDefinition_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(QueryDefinition_cppflags) $(QueryDefinition_cpp_cppflags)  $(src)QueryDefinition.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CoralServerProxyException.d

$(bin)$(binobj)CoralServerProxyException.d :

$(bin)$(binobj)CoralServerProxyException.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)CoralServerProxyException.o : $(src)CoralServerProxyException.cpp
	$(cpp_echo) $(src)CoralServerProxyException.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CoralServerProxyException_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CoralServerProxyException_cppflags) $(CoralServerProxyException_cpp_cppflags)  $(src)CoralServerProxyException.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(CoralServerProxyException_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)CoralServerProxyException.cpp

$(bin)$(binobj)CoralServerProxyException.o : $(CoralServerProxyException_cpp_dependencies)
	$(cpp_echo) $(src)CoralServerProxyException.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CoralServerProxyException_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CoralServerProxyException_cppflags) $(CoralServerProxyException_cpp_cppflags)  $(src)CoralServerProxyException.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ByteBuffer.d

$(bin)$(binobj)ByteBuffer.d :

$(bin)$(binobj)ByteBuffer.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)ByteBuffer.o : $(src)ByteBuffer.cpp
	$(cpp_echo) $(src)ByteBuffer.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(ByteBuffer_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(ByteBuffer_cppflags) $(ByteBuffer_cpp_cppflags)  $(src)ByteBuffer.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(ByteBuffer_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)ByteBuffer.cpp

$(bin)$(binobj)ByteBuffer.o : $(ByteBuffer_cpp_dependencies)
	$(cpp_echo) $(src)ByteBuffer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(ByteBuffer_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(ByteBuffer_cppflags) $(ByteBuffer_cpp_cppflags)  $(src)ByteBuffer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (,)

ifneq ($(MAKECMDGOALS),lcg_CoralServerBaseclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CTLPacketHeader.d

$(bin)$(binobj)CTLPacketHeader.d :

$(bin)$(binobj)CTLPacketHeader.o : $(cmt_final_setup_lcg_CoralServerBase)

$(bin)$(binobj)CTLPacketHeader.o : $(src)CTLPacketHeader.cpp
	$(cpp_echo) $(src)CTLPacketHeader.cpp
	$(cpp_silent) $(cppcomp)  -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CTLPacketHeader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CTLPacketHeader_cppflags) $(CTLPacketHeader_cpp_cppflags)  $(src)CTLPacketHeader.cpp
endif
endif

else
$(bin)lcg_CoralServerBase_dependencies.make : $(CTLPacketHeader_cpp_dependencies)

$(bin)lcg_CoralServerBase_dependencies.make : $(src)CTLPacketHeader.cpp

$(bin)$(binobj)CTLPacketHeader.o : $(CTLPacketHeader_cpp_dependencies)
	$(cpp_echo) $(src)CTLPacketHeader.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(lcg_CoralServerBase_pp_cppflags) $(lib_lcg_CoralServerBase_pp_cppflags) $(CTLPacketHeader_pp_cppflags) $(use_cppflags) $(lcg_CoralServerBase_cppflags) $(lib_lcg_CoralServerBase_cppflags) $(CTLPacketHeader_cppflags) $(CTLPacketHeader_cpp_cppflags)  $(src)CTLPacketHeader.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: lcg_CoralServerBaseclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_CoralServerBase.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_CoralServerBaseclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library lcg_CoralServerBase
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)lcg_CoralServerBase$(library_suffix).a $(library_prefix)lcg_CoralServerBase$(library_suffix).$(shlibsuffix) lcg_CoralServerBase.stamp lcg_CoralServerBase.shstamp
#-- end of cleanup_library ---------------
