#-- start of make_header -----------------

#====================================
#  Library GaudiPartProp
#
#   Generated Mon Feb 16 19:54:09 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPartProp_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPartProp_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPartProp

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartProp = $(GaudiPartProp_tag)_GaudiPartProp.make
cmt_local_tagfile_GaudiPartProp = $(bin)$(GaudiPartProp_tag)_GaudiPartProp.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartProp = $(GaudiPartProp_tag).make
cmt_local_tagfile_GaudiPartProp = $(bin)$(GaudiPartProp_tag).make

endif

include $(cmt_local_tagfile_GaudiPartProp)
#-include $(cmt_local_tagfile_GaudiPartProp)

ifdef cmt_GaudiPartProp_has_target_tag

cmt_final_setup_GaudiPartProp = $(bin)setup_GaudiPartProp.make
cmt_dependencies_in_GaudiPartProp = $(bin)dependencies_GaudiPartProp.in
#cmt_final_setup_GaudiPartProp = $(bin)GaudiPartProp_GaudiPartPropsetup.make
cmt_local_GaudiPartProp_makefile = $(bin)GaudiPartProp.make

else

cmt_final_setup_GaudiPartProp = $(bin)setup.make
cmt_dependencies_in_GaudiPartProp = $(bin)dependencies.in
#cmt_final_setup_GaudiPartProp = $(bin)GaudiPartPropsetup.make
cmt_local_GaudiPartProp_makefile = $(bin)GaudiPartProp.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPartPropsetup.make

#GaudiPartProp :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPartProp'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPartProp/
#GaudiPartProp::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiPartProplibname   = $(bin)$(library_prefix)GaudiPartProp$(library_suffix)
GaudiPartProplib       = $(GaudiPartProplibname).a
GaudiPartPropstamp     = $(bin)GaudiPartProp.stamp
GaudiPartPropshstamp   = $(bin)GaudiPartProp.shstamp

GaudiPartProp :: dirs  GaudiPartPropLIB
	$(echo) "GaudiPartProp ok"

cmt_GaudiPartProp_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPartProp_has_prototypes

GaudiPartPropprototype :  ;

endif

GaudiPartPropcompile : $(bin)ParticlePropertySvc.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiPartPropLIB :: $(GaudiPartProplib) $(GaudiPartPropshstamp)
GaudiPartPropLIB :: $(GaudiPartPropshstamp)
	$(echo) "GaudiPartProp : library ok"

$(GaudiPartProplib) :: $(bin)ParticlePropertySvc.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiPartProplib) $?
	$(lib_silent) $(ranlib) $(GaudiPartProplib)
	$(lib_silent) cat /dev/null >$(GaudiPartPropstamp)

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

$(GaudiPartProplibname).$(shlibsuffix) :: $(bin)ParticlePropertySvc.o $(use_requirements) $(GaudiPartPropstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)ParticlePropertySvc.o $(GaudiPartProp_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiPartPropstamp) && \
	  cat /dev/null >$(GaudiPartPropshstamp)

$(GaudiPartPropshstamp) :: $(GaudiPartProplibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiPartProplibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiPartPropstamp) && \
	  cat /dev/null >$(GaudiPartPropshstamp) ; fi

GaudiPartPropclean ::
	$(cleanup_echo) objects GaudiPartProp
	$(cleanup_silent) /bin/rm -f $(bin)ParticlePropertySvc.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)ParticlePropertySvc.o) $(patsubst %.o,%.dep,$(bin)ParticlePropertySvc.o) $(patsubst %.o,%.d.stamp,$(bin)ParticlePropertySvc.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiPartProp_deps GaudiPartProp_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiPartPropinstallname = $(library_prefix)GaudiPartProp$(library_suffix).$(shlibsuffix)

GaudiPartProp :: GaudiPartPropinstall ;

install :: GaudiPartPropinstall ;

GaudiPartPropinstall :: $(install_dir)/$(GaudiPartPropinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiPartPropinstallname) :: $(bin)$(GaudiPartPropinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPartPropinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiPartPropclean :: GaudiPartPropuninstall

uninstall :: GaudiPartPropuninstall ;

GaudiPartPropuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiPartPropinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiPartPropclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ParticlePropertySvc.d

$(bin)$(binobj)ParticlePropertySvc.d :

$(bin)$(binobj)ParticlePropertySvc.o : $(cmt_final_setup_GaudiPartProp)

$(bin)$(binobj)ParticlePropertySvc.o : $(src)ParticlePropertySvc.cpp
	$(cpp_echo) $(src)ParticlePropertySvc.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiPartProp_pp_cppflags) $(lib_GaudiPartProp_pp_cppflags) $(ParticlePropertySvc_pp_cppflags) $(use_cppflags) $(GaudiPartProp_cppflags) $(lib_GaudiPartProp_cppflags) $(ParticlePropertySvc_cppflags) $(ParticlePropertySvc_cpp_cppflags)  $(src)ParticlePropertySvc.cpp
endif
endif

else
$(bin)GaudiPartProp_dependencies.make : $(ParticlePropertySvc_cpp_dependencies)

$(bin)GaudiPartProp_dependencies.make : $(src)ParticlePropertySvc.cpp

$(bin)$(binobj)ParticlePropertySvc.o : $(ParticlePropertySvc_cpp_dependencies)
	$(cpp_echo) $(src)ParticlePropertySvc.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiPartProp_pp_cppflags) $(lib_GaudiPartProp_pp_cppflags) $(ParticlePropertySvc_pp_cppflags) $(use_cppflags) $(GaudiPartProp_cppflags) $(lib_GaudiPartProp_cppflags) $(ParticlePropertySvc_cppflags) $(ParticlePropertySvc_cpp_cppflags)  $(src)ParticlePropertySvc.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiPartPropclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPartProp.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPartPropclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiPartProp
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiPartProp$(library_suffix).a $(library_prefix)GaudiPartProp$(library_suffix).$(shlibsuffix) GaudiPartProp.stamp GaudiPartProp.shstamp
#-- end of cleanup_library ---------------
