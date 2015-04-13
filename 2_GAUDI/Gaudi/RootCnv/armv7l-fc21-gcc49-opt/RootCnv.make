#-- start of make_header -----------------

#====================================
#  Library RootCnv
#
#   Generated Mon Feb 16 20:00:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnv_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnv_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnv

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnv = $(RootCnv_tag)_RootCnv.make
cmt_local_tagfile_RootCnv = $(bin)$(RootCnv_tag)_RootCnv.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnv = $(RootCnv_tag).make
cmt_local_tagfile_RootCnv = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnv)
#-include $(cmt_local_tagfile_RootCnv)

ifdef cmt_RootCnv_has_target_tag

cmt_final_setup_RootCnv = $(bin)setup_RootCnv.make
cmt_dependencies_in_RootCnv = $(bin)dependencies_RootCnv.in
#cmt_final_setup_RootCnv = $(bin)RootCnv_RootCnvsetup.make
cmt_local_RootCnv_makefile = $(bin)RootCnv.make

else

cmt_final_setup_RootCnv = $(bin)setup.make
cmt_dependencies_in_RootCnv = $(bin)dependencies.in
#cmt_final_setup_RootCnv = $(bin)RootCnvsetup.make
cmt_local_RootCnv_makefile = $(bin)RootCnv.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnv :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnv'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnv/
#RootCnv::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

RootCnvlibname   = $(bin)$(library_prefix)RootCnv$(library_suffix)
RootCnvlib       = $(RootCnvlibname).a
RootCnvstamp     = $(bin)RootCnv.stamp
RootCnvshstamp   = $(bin)RootCnv.shstamp

RootCnv :: dirs  RootCnvLIB
	$(echo) "RootCnv ok"

cmt_RootCnv_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnv_has_prototypes

RootCnvprototype :  ;

endif

RootCnvcompile : $(bin)Components.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#RootCnvLIB :: $(RootCnvlib) $(RootCnvshstamp)
RootCnvLIB :: $(RootCnvshstamp)
	$(echo) "RootCnv : library ok"

$(RootCnvlib) :: $(bin)Components.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(RootCnvlib) $?
	$(lib_silent) $(ranlib) $(RootCnvlib)
	$(lib_silent) cat /dev/null >$(RootCnvstamp)

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

$(RootCnvlibname).$(shlibsuffix) :: $(bin)Components.o $(use_requirements) $(RootCnvstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)Components.o $(RootCnv_shlibflags)
	$(lib_silent) cat /dev/null >$(RootCnvstamp) && \
	  cat /dev/null >$(RootCnvshstamp)

$(RootCnvshstamp) :: $(RootCnvlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(RootCnvlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(RootCnvstamp) && \
	  cat /dev/null >$(RootCnvshstamp) ; fi

RootCnvclean ::
	$(cleanup_echo) objects RootCnv
	$(cleanup_silent) /bin/rm -f $(bin)Components.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Components.o) $(patsubst %.o,%.dep,$(bin)Components.o) $(patsubst %.o,%.d.stamp,$(bin)Components.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf RootCnv_deps RootCnv_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
RootCnvinstallname = $(library_prefix)RootCnv$(library_suffix).$(shlibsuffix)

RootCnv :: RootCnvinstall ;

install :: RootCnvinstall ;

RootCnvinstall :: $(install_dir)/$(RootCnvinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(RootCnvinstallname) :: $(bin)$(RootCnvinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##RootCnvclean :: RootCnvuninstall

uninstall :: RootCnvuninstall ;

RootCnvuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(RootCnvinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),RootCnvclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Components.d

$(bin)$(binobj)Components.d :

$(bin)$(binobj)Components.o : $(cmt_final_setup_RootCnv)

$(bin)$(binobj)Components.o : ../components/Components.cpp
	$(cpp_echo) ../components/Components.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(RootCnv_pp_cppflags) $(lib_RootCnv_pp_cppflags) $(Components_pp_cppflags) $(use_cppflags) $(RootCnv_cppflags) $(lib_RootCnv_cppflags) $(Components_cppflags) $(Components_cpp_cppflags) -I../components ../components/Components.cpp
endif
endif

else
$(bin)RootCnv_dependencies.make : $(Components_cpp_dependencies)

$(bin)RootCnv_dependencies.make : ../components/Components.cpp

$(bin)$(binobj)Components.o : $(Components_cpp_dependencies)
	$(cpp_echo) ../components/Components.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(RootCnv_pp_cppflags) $(lib_RootCnv_pp_cppflags) $(Components_pp_cppflags) $(use_cppflags) $(RootCnv_cppflags) $(lib_RootCnv_cppflags) $(Components_cppflags) $(Components_cpp_cppflags) -I../components ../components/Components.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: RootCnvclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnv.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library RootCnv
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)RootCnv$(library_suffix).a $(library_prefix)RootCnv$(library_suffix).$(shlibsuffix) RootCnv.stamp RootCnv.shstamp
#-- end of cleanup_library ---------------
