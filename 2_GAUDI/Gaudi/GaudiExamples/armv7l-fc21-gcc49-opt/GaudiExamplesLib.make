#-- start of make_header -----------------

#====================================
#  Library GaudiExamplesLib
#
#   Generated Mon Feb 16 20:50:01 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesLib

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesLib = $(GaudiExamples_tag)_GaudiExamplesLib.make
cmt_local_tagfile_GaudiExamplesLib = $(bin)$(GaudiExamples_tag)_GaudiExamplesLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesLib = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesLib = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesLib)
#-include $(cmt_local_tagfile_GaudiExamplesLib)

ifdef cmt_GaudiExamplesLib_has_target_tag

cmt_final_setup_GaudiExamplesLib = $(bin)setup_GaudiExamplesLib.make
cmt_dependencies_in_GaudiExamplesLib = $(bin)dependencies_GaudiExamplesLib.in
#cmt_final_setup_GaudiExamplesLib = $(bin)GaudiExamples_GaudiExamplesLibsetup.make
cmt_local_GaudiExamplesLib_makefile = $(bin)GaudiExamplesLib.make

else

cmt_final_setup_GaudiExamplesLib = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesLib = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesLib = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesLib_makefile = $(bin)GaudiExamplesLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesLib/
#GaudiExamplesLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiExamplesLiblibname   = $(bin)$(library_prefix)GaudiExamplesLib$(library_suffix)
GaudiExamplesLiblib       = $(GaudiExamplesLiblibname).a
GaudiExamplesLibstamp     = $(bin)GaudiExamplesLib.stamp
GaudiExamplesLibshstamp   = $(bin)GaudiExamplesLib.shstamp

GaudiExamplesLib :: dirs  GaudiExamplesLibLIB
	$(echo) "GaudiExamplesLib ok"

cmt_GaudiExamplesLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamplesLib_has_prototypes

GaudiExamplesLibprototype :  ;

endif

GaudiExamplesLibcompile : $(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiExamplesLibLIB :: $(GaudiExamplesLiblib) $(GaudiExamplesLibshstamp)
GaudiExamplesLibLIB :: $(GaudiExamplesLibshstamp)
	$(echo) "GaudiExamplesLib : library ok"

$(GaudiExamplesLiblib) :: $(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiExamplesLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiExamplesLiblib)
	$(lib_silent) cat /dev/null >$(GaudiExamplesLibstamp)

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

$(GaudiExamplesLiblibname).$(shlibsuffix) :: $(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o $(use_requirements) $(GaudiExamplesLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o $(GaudiExamplesLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiExamplesLibstamp) && \
	  cat /dev/null >$(GaudiExamplesLibshstamp)

$(GaudiExamplesLibshstamp) :: $(GaudiExamplesLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiExamplesLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiExamplesLibstamp) && \
	  cat /dev/null >$(GaudiExamplesLibshstamp) ; fi

GaudiExamplesLibclean ::
	$(cleanup_echo) objects GaudiExamplesLib
	$(cleanup_silent) /bin/rm -f $(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o) $(patsubst %.o,%.dep,$(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o) $(patsubst %.o,%.d.stamp,$(bin)Counter.o $(bin)MyVertex.o $(bin)Event.o $(bin)MyTrack.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiExamplesLib_deps GaudiExamplesLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiExamplesLibinstallname = $(library_prefix)GaudiExamplesLib$(library_suffix).$(shlibsuffix)

GaudiExamplesLib :: GaudiExamplesLibinstall ;

install :: GaudiExamplesLibinstall ;

GaudiExamplesLibinstall :: $(install_dir)/$(GaudiExamplesLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiExamplesLibinstallname) :: $(bin)$(GaudiExamplesLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiExamplesLibclean :: GaudiExamplesLibuninstall

uninstall :: GaudiExamplesLibuninstall ;

GaudiExamplesLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiExamplesLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Counter.d

$(bin)$(binobj)Counter.d :

$(bin)$(binobj)Counter.o : $(cmt_final_setup_GaudiExamplesLib)

$(bin)$(binobj)Counter.o : $(src)Lib/Counter.cpp
	$(cpp_echo) $(src)Lib/Counter.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(Counter_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(Counter_cppflags) $(Counter_cpp_cppflags) -I../src/Lib $(src)Lib/Counter.cpp
endif
endif

else
$(bin)GaudiExamplesLib_dependencies.make : $(Counter_cpp_dependencies)

$(bin)GaudiExamplesLib_dependencies.make : $(src)Lib/Counter.cpp

$(bin)$(binobj)Counter.o : $(Counter_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Counter.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(Counter_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(Counter_cppflags) $(Counter_cpp_cppflags) -I../src/Lib $(src)Lib/Counter.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyVertex.d

$(bin)$(binobj)MyVertex.d :

$(bin)$(binobj)MyVertex.o : $(cmt_final_setup_GaudiExamplesLib)

$(bin)$(binobj)MyVertex.o : $(src)Lib/MyVertex.cpp
	$(cpp_echo) $(src)Lib/MyVertex.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(MyVertex_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(MyVertex_cppflags) $(MyVertex_cpp_cppflags) -I../src/Lib $(src)Lib/MyVertex.cpp
endif
endif

else
$(bin)GaudiExamplesLib_dependencies.make : $(MyVertex_cpp_dependencies)

$(bin)GaudiExamplesLib_dependencies.make : $(src)Lib/MyVertex.cpp

$(bin)$(binobj)MyVertex.o : $(MyVertex_cpp_dependencies)
	$(cpp_echo) $(src)Lib/MyVertex.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(MyVertex_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(MyVertex_cppflags) $(MyVertex_cpp_cppflags) -I../src/Lib $(src)Lib/MyVertex.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Event.d

$(bin)$(binobj)Event.d :

$(bin)$(binobj)Event.o : $(cmt_final_setup_GaudiExamplesLib)

$(bin)$(binobj)Event.o : $(src)Lib/Event.cpp
	$(cpp_echo) $(src)Lib/Event.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(Event_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(Event_cppflags) $(Event_cpp_cppflags) -I../src/Lib $(src)Lib/Event.cpp
endif
endif

else
$(bin)GaudiExamplesLib_dependencies.make : $(Event_cpp_dependencies)

$(bin)GaudiExamplesLib_dependencies.make : $(src)Lib/Event.cpp

$(bin)$(binobj)Event.o : $(Event_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Event.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(Event_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(Event_cppflags) $(Event_cpp_cppflags) -I../src/Lib $(src)Lib/Event.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiExamplesLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)MyTrack.d

$(bin)$(binobj)MyTrack.d :

$(bin)$(binobj)MyTrack.o : $(cmt_final_setup_GaudiExamplesLib)

$(bin)$(binobj)MyTrack.o : $(src)Lib/MyTrack.cpp
	$(cpp_echo) $(src)Lib/MyTrack.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(MyTrack_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(MyTrack_cppflags) $(MyTrack_cpp_cppflags) -I../src/Lib $(src)Lib/MyTrack.cpp
endif
endif

else
$(bin)GaudiExamplesLib_dependencies.make : $(MyTrack_cpp_dependencies)

$(bin)GaudiExamplesLib_dependencies.make : $(src)Lib/MyTrack.cpp

$(bin)$(binobj)MyTrack.o : $(MyTrack_cpp_dependencies)
	$(cpp_echo) $(src)Lib/MyTrack.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiExamplesLib_pp_cppflags) $(lib_GaudiExamplesLib_pp_cppflags) $(MyTrack_pp_cppflags) $(use_cppflags) $(GaudiExamplesLib_cppflags) $(lib_GaudiExamplesLib_cppflags) $(MyTrack_cppflags) $(MyTrack_cpp_cppflags) -I../src/Lib $(src)Lib/MyTrack.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiExamplesLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiExamplesLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiExamplesLib$(library_suffix).a $(library_prefix)GaudiExamplesLib$(library_suffix).$(shlibsuffix) GaudiExamplesLib.stamp GaudiExamplesLib.shstamp
#-- end of cleanup_library ---------------
