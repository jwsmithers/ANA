#-- start of make_header -----------------

#====================================
#  Library RootHistCnv
#
#   Generated Mon Feb 16 19:53:03 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnv_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnv_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnv

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnv = $(RootHistCnv_tag)_RootHistCnv.make
cmt_local_tagfile_RootHistCnv = $(bin)$(RootHistCnv_tag)_RootHistCnv.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnv = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnv = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnv)
#-include $(cmt_local_tagfile_RootHistCnv)

ifdef cmt_RootHistCnv_has_target_tag

cmt_final_setup_RootHistCnv = $(bin)setup_RootHistCnv.make
cmt_dependencies_in_RootHistCnv = $(bin)dependencies_RootHistCnv.in
#cmt_final_setup_RootHistCnv = $(bin)RootHistCnv_RootHistCnvsetup.make
cmt_local_RootHistCnv_makefile = $(bin)RootHistCnv.make

else

cmt_final_setup_RootHistCnv = $(bin)setup.make
cmt_dependencies_in_RootHistCnv = $(bin)dependencies.in
#cmt_final_setup_RootHistCnv = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnv_makefile = $(bin)RootHistCnv.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnv :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnv'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnv/
#RootHistCnv::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootHistCnvlibname   = $(bin)$(library_prefix)RootHistCnv$(library_suffix)
RootHistCnvlib       = $(RootHistCnvlibname).a
RootHistCnvstamp     = $(bin)RootHistCnv.stamp
RootHistCnvshstamp   = $(bin)RootHistCnv.shstamp

RootHistCnv :: dirs  RootHistCnvLIB
	$(echo) "RootHistCnv ok"

cmt_RootHistCnv_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootHistCnv_has_prototypes

RootHistCnvprototype :  ;

endif

RootHistCnvcompile : $(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#RootHistCnvLIB :: $(RootHistCnvlib) $(RootHistCnvshstamp)
RootHistCnvLIB :: $(RootHistCnvshstamp)
	$(echo) "RootHistCnv : library ok"

$(RootHistCnvlib) :: $(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(RootHistCnvlib) $?
	$(lib_silent) $(ranlib) $(RootHistCnvlib)
	$(lib_silent) cat /dev/null >$(RootHistCnvstamp)

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

$(RootHistCnvlibname).$(shlibsuffix) :: $(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o $(use_requirements) $(RootHistCnvstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o $(RootHistCnv_shlibflags)
	$(lib_silent) cat /dev/null >$(RootHistCnvstamp) && \
	  cat /dev/null >$(RootHistCnvshstamp)

$(RootHistCnvshstamp) :: $(RootHistCnvlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootHistCnvlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(RootHistCnvstamp) && \
	  cat /dev/null >$(RootHistCnvshstamp) ; fi

RootHistCnvclean ::
	$(cleanup_echo) objects RootHistCnv
	$(cleanup_silent) /bin/rm -f $(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o) $(patsubst %.o,%.dep,$(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o) $(patsubst %.o,%.d.stamp,$(bin)RootDirFcn.o $(bin)RRWNTupleCnv.o $(bin)RConverter.o $(bin)RDirectoryCnv.o $(bin)RootCompressionSettings.o $(bin)RFileCnv.o $(bin)RCWNTupleCnv.o $(bin)RHistogramCnv.o $(bin)PersSvc.o $(bin)DirectoryCnv.o $(bin)RNTupleCnv.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootHistCnv_deps RootHistCnv_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootHistCnvinstallname = $(library_prefix)RootHistCnv$(library_suffix).$(shlibsuffix)

RootHistCnv :: RootHistCnvinstall ;

install :: RootHistCnvinstall ;

RootHistCnvinstall :: $(install_dir)/$(RootHistCnvinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootHistCnvinstallname) :: $(bin)$(RootHistCnvinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootHistCnvinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootHistCnvclean :: RootHistCnvuninstall

uninstall :: RootHistCnvuninstall ;

RootHistCnvuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootHistCnvinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootDirFcn.d

$(bin)$(binobj)RootDirFcn.d :

$(bin)$(binobj)RootDirFcn.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RootDirFcn.o : $(src)RootDirFcn.cpp
	$(cpp_echo) $(src)RootDirFcn.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RootDirFcn_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RootDirFcn_cppflags) $(RootDirFcn_cpp_cppflags)  $(src)RootDirFcn.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RootDirFcn_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RootDirFcn.cpp

$(bin)$(binobj)RootDirFcn.o : $(RootDirFcn_cpp_dependencies)
	$(cpp_echo) $(src)RootDirFcn.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RootDirFcn_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RootDirFcn_cppflags) $(RootDirFcn_cpp_cppflags)  $(src)RootDirFcn.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RRWNTupleCnv.d

$(bin)$(binobj)RRWNTupleCnv.d :

$(bin)$(binobj)RRWNTupleCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RRWNTupleCnv.o : $(src)RRWNTupleCnv.cpp
	$(cpp_echo) $(src)RRWNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RRWNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RRWNTupleCnv_cppflags) $(RRWNTupleCnv_cpp_cppflags)  $(src)RRWNTupleCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RRWNTupleCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RRWNTupleCnv.cpp

$(bin)$(binobj)RRWNTupleCnv.o : $(RRWNTupleCnv_cpp_dependencies)
	$(cpp_echo) $(src)RRWNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RRWNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RRWNTupleCnv_cppflags) $(RRWNTupleCnv_cpp_cppflags)  $(src)RRWNTupleCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RConverter.d

$(bin)$(binobj)RConverter.d :

$(bin)$(binobj)RConverter.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RConverter.o : $(src)RConverter.cpp
	$(cpp_echo) $(src)RConverter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RConverter_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RConverter_cppflags) $(RConverter_cpp_cppflags)  $(src)RConverter.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RConverter_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RConverter.cpp

$(bin)$(binobj)RConverter.o : $(RConverter_cpp_dependencies)
	$(cpp_echo) $(src)RConverter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RConverter_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RConverter_cppflags) $(RConverter_cpp_cppflags)  $(src)RConverter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RDirectoryCnv.d

$(bin)$(binobj)RDirectoryCnv.d :

$(bin)$(binobj)RDirectoryCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RDirectoryCnv.o : $(src)RDirectoryCnv.cpp
	$(cpp_echo) $(src)RDirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RDirectoryCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RDirectoryCnv_cppflags) $(RDirectoryCnv_cpp_cppflags)  $(src)RDirectoryCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RDirectoryCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RDirectoryCnv.cpp

$(bin)$(binobj)RDirectoryCnv.o : $(RDirectoryCnv_cpp_dependencies)
	$(cpp_echo) $(src)RDirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RDirectoryCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RDirectoryCnv_cppflags) $(RDirectoryCnv_cpp_cppflags)  $(src)RDirectoryCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RootCompressionSettings.d

$(bin)$(binobj)RootCompressionSettings.d :

$(bin)$(binobj)RootCompressionSettings.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RootCompressionSettings.o : $(src)RootCompressionSettings.cpp
	$(cpp_echo) $(src)RootCompressionSettings.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RootCompressionSettings_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RootCompressionSettings_cppflags) $(RootCompressionSettings_cpp_cppflags)  $(src)RootCompressionSettings.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RootCompressionSettings_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RootCompressionSettings.cpp

$(bin)$(binobj)RootCompressionSettings.o : $(RootCompressionSettings_cpp_dependencies)
	$(cpp_echo) $(src)RootCompressionSettings.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RootCompressionSettings_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RootCompressionSettings_cppflags) $(RootCompressionSettings_cpp_cppflags)  $(src)RootCompressionSettings.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RFileCnv.d

$(bin)$(binobj)RFileCnv.d :

$(bin)$(binobj)RFileCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RFileCnv.o : $(src)RFileCnv.cpp
	$(cpp_echo) $(src)RFileCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RFileCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RFileCnv_cppflags) $(RFileCnv_cpp_cppflags)  $(src)RFileCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RFileCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RFileCnv.cpp

$(bin)$(binobj)RFileCnv.o : $(RFileCnv_cpp_dependencies)
	$(cpp_echo) $(src)RFileCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RFileCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RFileCnv_cppflags) $(RFileCnv_cpp_cppflags)  $(src)RFileCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RCWNTupleCnv.d

$(bin)$(binobj)RCWNTupleCnv.d :

$(bin)$(binobj)RCWNTupleCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RCWNTupleCnv.o : $(src)RCWNTupleCnv.cpp
	$(cpp_echo) $(src)RCWNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RCWNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RCWNTupleCnv_cppflags) $(RCWNTupleCnv_cpp_cppflags)  $(src)RCWNTupleCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RCWNTupleCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RCWNTupleCnv.cpp

$(bin)$(binobj)RCWNTupleCnv.o : $(RCWNTupleCnv_cpp_dependencies)
	$(cpp_echo) $(src)RCWNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RCWNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RCWNTupleCnv_cppflags) $(RCWNTupleCnv_cpp_cppflags)  $(src)RCWNTupleCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RHistogramCnv.d

$(bin)$(binobj)RHistogramCnv.d :

$(bin)$(binobj)RHistogramCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RHistogramCnv.o : $(src)RHistogramCnv.cpp
	$(cpp_echo) $(src)RHistogramCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RHistogramCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RHistogramCnv_cppflags) $(RHistogramCnv_cpp_cppflags)  $(src)RHistogramCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RHistogramCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RHistogramCnv.cpp

$(bin)$(binobj)RHistogramCnv.o : $(RHistogramCnv_cpp_dependencies)
	$(cpp_echo) $(src)RHistogramCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RHistogramCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RHistogramCnv_cppflags) $(RHistogramCnv_cpp_cppflags)  $(src)RHistogramCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)PersSvc.d

$(bin)$(binobj)PersSvc.d :

$(bin)$(binobj)PersSvc.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)PersSvc.o : $(src)PersSvc.cpp
	$(cpp_echo) $(src)PersSvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(PersSvc_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(PersSvc_cppflags) $(PersSvc_cpp_cppflags)  $(src)PersSvc.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(PersSvc_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)PersSvc.cpp

$(bin)$(binobj)PersSvc.o : $(PersSvc_cpp_dependencies)
	$(cpp_echo) $(src)PersSvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(PersSvc_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(PersSvc_cppflags) $(PersSvc_cpp_cppflags)  $(src)PersSvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)DirectoryCnv.d

$(bin)$(binobj)DirectoryCnv.d :

$(bin)$(binobj)DirectoryCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)DirectoryCnv.o : $(src)DirectoryCnv.cpp
	$(cpp_echo) $(src)DirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(DirectoryCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(DirectoryCnv_cppflags) $(DirectoryCnv_cpp_cppflags)  $(src)DirectoryCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(DirectoryCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)DirectoryCnv.cpp

$(bin)$(binobj)DirectoryCnv.o : $(DirectoryCnv_cpp_dependencies)
	$(cpp_echo) $(src)DirectoryCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(DirectoryCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(DirectoryCnv_cppflags) $(DirectoryCnv_cpp_cppflags)  $(src)DirectoryCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootHistCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)RNTupleCnv.d

$(bin)$(binobj)RNTupleCnv.d :

$(bin)$(binobj)RNTupleCnv.o : $(cmt_final_setup_RootHistCnv)

$(bin)$(binobj)RNTupleCnv.o : $(src)RNTupleCnv.cpp
	$(cpp_echo) $(src)RNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RNTupleCnv_cppflags) $(RNTupleCnv_cpp_cppflags)  $(src)RNTupleCnv.cpp
endif
endif

else
$(bin)RootHistCnv_dependencies.make : $(RNTupleCnv_cpp_dependencies)

$(bin)RootHistCnv_dependencies.make : $(src)RNTupleCnv.cpp

$(bin)$(binobj)RNTupleCnv.o : $(RNTupleCnv_cpp_dependencies)
	$(cpp_echo) $(src)RNTupleCnv.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootHistCnv_pp_cppflags) $(lib_RootHistCnv_pp_cppflags) $(RNTupleCnv_pp_cppflags) $(use_cppflags) $(RootHistCnv_cppflags) $(lib_RootHistCnv_cppflags) $(RNTupleCnv_cppflags) $(RNTupleCnv_cpp_cppflags)  $(src)RNTupleCnv.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootHistCnvclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnv.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnvclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootHistCnv
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootHistCnv$(library_suffix).a $(library_prefix)RootHistCnv$(library_suffix).$(shlibsuffix) RootHistCnv.stamp RootHistCnv.shstamp
#-- end of cleanup_library ---------------
