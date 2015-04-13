#-- start of make_header -----------------

#====================================
#  Library GaudiAud
#
#   Generated Mon Feb 16 20:19:04 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAud_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAud_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAud

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAud = $(GaudiAud_tag)_GaudiAud.make
cmt_local_tagfile_GaudiAud = $(bin)$(GaudiAud_tag)_GaudiAud.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAud = $(GaudiAud_tag).make
cmt_local_tagfile_GaudiAud = $(bin)$(GaudiAud_tag).make

endif

include $(cmt_local_tagfile_GaudiAud)
#-include $(cmt_local_tagfile_GaudiAud)

ifdef cmt_GaudiAud_has_target_tag

cmt_final_setup_GaudiAud = $(bin)setup_GaudiAud.make
cmt_dependencies_in_GaudiAud = $(bin)dependencies_GaudiAud.in
#cmt_final_setup_GaudiAud = $(bin)GaudiAud_GaudiAudsetup.make
cmt_local_GaudiAud_makefile = $(bin)GaudiAud.make

else

cmt_final_setup_GaudiAud = $(bin)setup.make
cmt_dependencies_in_GaudiAud = $(bin)dependencies.in
#cmt_final_setup_GaudiAud = $(bin)GaudiAudsetup.make
cmt_local_GaudiAud_makefile = $(bin)GaudiAud.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAudsetup.make

#GaudiAud :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAud'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAud/
#GaudiAud::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiAudlibname   = $(bin)$(library_prefix)GaudiAud$(library_suffix)
GaudiAudlib       = $(GaudiAudlibname).a
GaudiAudstamp     = $(bin)GaudiAud.stamp
GaudiAudshstamp   = $(bin)GaudiAud.shstamp

GaudiAud :: dirs  GaudiAudLIB
	$(echo) "GaudiAud ok"

cmt_GaudiAud_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAud_has_prototypes

GaudiAudprototype :  ;

endif

GaudiAudcompile : $(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiAudLIB :: $(GaudiAudlib) $(GaudiAudshstamp)
GaudiAudLIB :: $(GaudiAudshstamp)
	$(echo) "GaudiAud : library ok"

$(GaudiAudlib) :: $(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiAudlib) $?
	$(lib_silent) $(ranlib) $(GaudiAudlib)
	$(lib_silent) cat /dev/null >$(GaudiAudstamp)

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

$(GaudiAudlibname).$(shlibsuffix) :: $(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o $(use_requirements) $(GaudiAudstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o $(GaudiAud_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiAudstamp) && \
	  cat /dev/null >$(GaudiAudshstamp)

$(GaudiAudshstamp) :: $(GaudiAudlibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiAudlibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiAudstamp) && \
	  cat /dev/null >$(GaudiAudshstamp) ; fi

GaudiAudclean ::
	$(cleanup_echo) objects GaudiAud
	$(cleanup_silent) /bin/rm -f $(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o) $(patsubst %.o,%.dep,$(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o) $(patsubst %.o,%.d.stamp,$(bin)MemoryAuditor.o $(bin)AlgContextAuditor.o $(bin)CommonAuditor.o $(bin)NameAuditor.o $(bin)AlgErrorAuditor.o $(bin)ProcStats.o $(bin)ChronoAuditor.o $(bin)MemStatAuditor.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiAud_deps GaudiAud_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiAudinstallname = $(library_prefix)GaudiAud$(library_suffix).$(shlibsuffix)

GaudiAud :: GaudiAudinstall ;

install :: GaudiAudinstall ;

GaudiAudinstall :: $(install_dir)/$(GaudiAudinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiAudinstallname) :: $(bin)$(GaudiAudinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAudinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiAudclean :: GaudiAuduninstall

uninstall :: GaudiAuduninstall ;

GaudiAuduninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAudinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MemoryAuditor.d

$(bin)$(binobj)MemoryAuditor.d :

$(bin)$(binobj)MemoryAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)MemoryAuditor.o : $(src)MemoryAuditor.cpp
	$(cpp_echo) $(src)MemoryAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(MemoryAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(MemoryAuditor_cppflags) $(MemoryAuditor_cpp_cppflags)  $(src)MemoryAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(MemoryAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)MemoryAuditor.cpp

$(bin)$(binobj)MemoryAuditor.o : $(MemoryAuditor_cpp_dependencies)
	$(cpp_echo) $(src)MemoryAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(MemoryAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(MemoryAuditor_cppflags) $(MemoryAuditor_cpp_cppflags)  $(src)MemoryAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgContextAuditor.d

$(bin)$(binobj)AlgContextAuditor.d :

$(bin)$(binobj)AlgContextAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)AlgContextAuditor.o : $(src)AlgContextAuditor.cpp
	$(cpp_echo) $(src)AlgContextAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(AlgContextAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(AlgContextAuditor_cppflags) $(AlgContextAuditor_cpp_cppflags)  $(src)AlgContextAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(AlgContextAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)AlgContextAuditor.cpp

$(bin)$(binobj)AlgContextAuditor.o : $(AlgContextAuditor_cpp_dependencies)
	$(cpp_echo) $(src)AlgContextAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(AlgContextAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(AlgContextAuditor_cppflags) $(AlgContextAuditor_cpp_cppflags)  $(src)AlgContextAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)CommonAuditor.d

$(bin)$(binobj)CommonAuditor.d :

$(bin)$(binobj)CommonAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)CommonAuditor.o : $(src)CommonAuditor.cpp
	$(cpp_echo) $(src)CommonAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(CommonAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(CommonAuditor_cppflags) $(CommonAuditor_cpp_cppflags)  $(src)CommonAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(CommonAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)CommonAuditor.cpp

$(bin)$(binobj)CommonAuditor.o : $(CommonAuditor_cpp_dependencies)
	$(cpp_echo) $(src)CommonAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(CommonAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(CommonAuditor_cppflags) $(CommonAuditor_cpp_cppflags)  $(src)CommonAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)NameAuditor.d

$(bin)$(binobj)NameAuditor.d :

$(bin)$(binobj)NameAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)NameAuditor.o : $(src)NameAuditor.cpp
	$(cpp_echo) $(src)NameAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(NameAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(NameAuditor_cppflags) $(NameAuditor_cpp_cppflags)  $(src)NameAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(NameAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)NameAuditor.cpp

$(bin)$(binobj)NameAuditor.o : $(NameAuditor_cpp_dependencies)
	$(cpp_echo) $(src)NameAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(NameAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(NameAuditor_cppflags) $(NameAuditor_cpp_cppflags)  $(src)NameAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)AlgErrorAuditor.d

$(bin)$(binobj)AlgErrorAuditor.d :

$(bin)$(binobj)AlgErrorAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)AlgErrorAuditor.o : $(src)AlgErrorAuditor.cpp
	$(cpp_echo) $(src)AlgErrorAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(AlgErrorAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(AlgErrorAuditor_cppflags) $(AlgErrorAuditor_cpp_cppflags)  $(src)AlgErrorAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(AlgErrorAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)AlgErrorAuditor.cpp

$(bin)$(binobj)AlgErrorAuditor.o : $(AlgErrorAuditor_cpp_dependencies)
	$(cpp_echo) $(src)AlgErrorAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(AlgErrorAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(AlgErrorAuditor_cppflags) $(AlgErrorAuditor_cpp_cppflags)  $(src)AlgErrorAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ProcStats.d

$(bin)$(binobj)ProcStats.d :

$(bin)$(binobj)ProcStats.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)ProcStats.o : $(src)ProcStats.cpp
	$(cpp_echo) $(src)ProcStats.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(ProcStats_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(ProcStats_cppflags) $(ProcStats_cpp_cppflags)  $(src)ProcStats.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(ProcStats_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)ProcStats.cpp

$(bin)$(binobj)ProcStats.o : $(ProcStats_cpp_dependencies)
	$(cpp_echo) $(src)ProcStats.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(ProcStats_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(ProcStats_cppflags) $(ProcStats_cpp_cppflags)  $(src)ProcStats.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ChronoAuditor.d

$(bin)$(binobj)ChronoAuditor.d :

$(bin)$(binobj)ChronoAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)ChronoAuditor.o : $(src)ChronoAuditor.cpp
	$(cpp_echo) $(src)ChronoAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(ChronoAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(ChronoAuditor_cppflags) $(ChronoAuditor_cpp_cppflags)  $(src)ChronoAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(ChronoAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)ChronoAuditor.cpp

$(bin)$(binobj)ChronoAuditor.o : $(ChronoAuditor_cpp_dependencies)
	$(cpp_echo) $(src)ChronoAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(ChronoAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(ChronoAuditor_cppflags) $(ChronoAuditor_cpp_cppflags)  $(src)ChronoAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAudclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MemStatAuditor.d

$(bin)$(binobj)MemStatAuditor.d :

$(bin)$(binobj)MemStatAuditor.o : $(cmt_final_setup_GaudiAud)

$(bin)$(binobj)MemStatAuditor.o : $(src)MemStatAuditor.cpp
	$(cpp_echo) $(src)MemStatAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(MemStatAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(MemStatAuditor_cppflags) $(MemStatAuditor_cpp_cppflags)  $(src)MemStatAuditor.cpp
endif
endif

else
$(bin)GaudiAud_dependencies.make : $(MemStatAuditor_cpp_dependencies)

$(bin)GaudiAud_dependencies.make : $(src)MemStatAuditor.cpp

$(bin)$(binobj)MemStatAuditor.o : $(MemStatAuditor_cpp_dependencies)
	$(cpp_echo) $(src)MemStatAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAud_pp_cppflags) $(lib_GaudiAud_pp_cppflags) $(MemStatAuditor_pp_cppflags) $(use_cppflags) $(GaudiAud_cppflags) $(lib_GaudiAud_cppflags) $(MemStatAuditor_cppflags) $(MemStatAuditor_cpp_cppflags)  $(src)MemStatAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiAudclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAud.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAudclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiAud
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiAud$(library_suffix).a $(library_prefix)GaudiAud$(library_suffix).$(shlibsuffix) GaudiAud.stamp GaudiAud.shstamp
#-- end of cleanup_library ---------------
