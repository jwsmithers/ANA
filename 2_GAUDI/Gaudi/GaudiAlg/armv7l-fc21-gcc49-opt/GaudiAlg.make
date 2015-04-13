#-- start of make_header -----------------

#====================================
#  Library GaudiAlg
#
#   Generated Mon Feb 16 20:01:34 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlg_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlg_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlg

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlg = $(GaudiAlg_tag)_GaudiAlg.make
cmt_local_tagfile_GaudiAlg = $(bin)$(GaudiAlg_tag)_GaudiAlg.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlg = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlg = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlg)
#-include $(cmt_local_tagfile_GaudiAlg)

ifdef cmt_GaudiAlg_has_target_tag

cmt_final_setup_GaudiAlg = $(bin)setup_GaudiAlg.make
cmt_dependencies_in_GaudiAlg = $(bin)dependencies_GaudiAlg.in
#cmt_final_setup_GaudiAlg = $(bin)GaudiAlg_GaudiAlgsetup.make
cmt_local_GaudiAlg_makefile = $(bin)GaudiAlg.make

else

cmt_final_setup_GaudiAlg = $(bin)setup.make
cmt_dependencies_in_GaudiAlg = $(bin)dependencies.in
#cmt_final_setup_GaudiAlg = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlg_makefile = $(bin)GaudiAlg.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlg :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlg'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlg/
#GaudiAlg::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiAlglibname   = $(bin)$(library_prefix)GaudiAlg$(library_suffix)
GaudiAlglib       = $(GaudiAlglibname).a
GaudiAlgstamp     = $(bin)GaudiAlg.stamp
GaudiAlgshstamp   = $(bin)GaudiAlg.shstamp

GaudiAlg :: dirs  GaudiAlgLIB
	$(echo) "GaudiAlg ok"

cmt_GaudiAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAlg_has_prototypes

GaudiAlgprototype :  ;

endif

GaudiAlgcompile : $(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiAlgLIB :: $(GaudiAlglib) $(GaudiAlgshstamp)
GaudiAlgLIB :: $(GaudiAlgshstamp)
	$(echo) "GaudiAlg : library ok"

$(GaudiAlglib) :: $(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiAlglib) $?
	$(lib_silent) $(ranlib) $(GaudiAlglib)
	$(lib_silent) cat /dev/null >$(GaudiAlgstamp)

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

$(GaudiAlglibname).$(shlibsuffix) :: $(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o $(use_requirements) $(GaudiAlgstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o $(GaudiAlg_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiAlgstamp) && \
	  cat /dev/null >$(GaudiAlgshstamp)

$(GaudiAlgshstamp) :: $(GaudiAlglibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiAlglibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiAlgstamp) && \
	  cat /dev/null >$(GaudiAlgshstamp) ; fi

GaudiAlgclean ::
	$(cleanup_echo) objects GaudiAlg
	$(cleanup_silent) /bin/rm -f $(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o) $(patsubst %.o,%.dep,$(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o) $(patsubst %.o,%.d.stamp,$(bin)TimerForSequencer.o $(bin)GaudiAlg_entries.o $(bin)TupleTool.o $(bin)SequencerTimerTool.o $(bin)EventNodeKiller.o $(bin)ErrorTool.o $(bin)HistoTool.o $(bin)TimingAuditor.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiAlg_deps GaudiAlg_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiAlginstallname = $(library_prefix)GaudiAlg$(library_suffix).$(shlibsuffix)

GaudiAlg :: GaudiAlginstall ;

install :: GaudiAlginstall ;

GaudiAlginstall :: $(install_dir)/$(GaudiAlginstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiAlginstallname) :: $(bin)$(GaudiAlginstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiAlgclean :: GaudiAlguninstall

uninstall :: GaudiAlguninstall ;

GaudiAlguninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiAlginstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimerForSequencer.d

$(bin)$(binobj)TimerForSequencer.d :

$(bin)$(binobj)TimerForSequencer.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)TimerForSequencer.o : $(src)components/TimerForSequencer.cpp
	$(cpp_echo) $(src)components/TimerForSequencer.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TimerForSequencer_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TimerForSequencer_cppflags) $(TimerForSequencer_cpp_cppflags) -I../src/components $(src)components/TimerForSequencer.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(TimerForSequencer_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/TimerForSequencer.cpp

$(bin)$(binobj)TimerForSequencer.o : $(TimerForSequencer_cpp_dependencies)
	$(cpp_echo) $(src)components/TimerForSequencer.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TimerForSequencer_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TimerForSequencer_cppflags) $(TimerForSequencer_cpp_cppflags) -I../src/components $(src)components/TimerForSequencer.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)GaudiAlg_entries.d

$(bin)$(binobj)GaudiAlg_entries.d :

$(bin)$(binobj)GaudiAlg_entries.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)GaudiAlg_entries.o : $(src)components/GaudiAlg_entries.cpp
	$(cpp_echo) $(src)components/GaudiAlg_entries.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(GaudiAlg_entries_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(GaudiAlg_entries_cppflags) $(GaudiAlg_entries_cpp_cppflags) -I../src/components $(src)components/GaudiAlg_entries.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(GaudiAlg_entries_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/GaudiAlg_entries.cpp

$(bin)$(binobj)GaudiAlg_entries.o : $(GaudiAlg_entries_cpp_dependencies)
	$(cpp_echo) $(src)components/GaudiAlg_entries.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(GaudiAlg_entries_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(GaudiAlg_entries_cppflags) $(GaudiAlg_entries_cpp_cppflags) -I../src/components $(src)components/GaudiAlg_entries.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TupleTool.d

$(bin)$(binobj)TupleTool.d :

$(bin)$(binobj)TupleTool.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)TupleTool.o : $(src)components/TupleTool.cpp
	$(cpp_echo) $(src)components/TupleTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TupleTool_cppflags) $(TupleTool_cpp_cppflags) -I../src/components $(src)components/TupleTool.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(TupleTool_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/TupleTool.cpp

$(bin)$(binobj)TupleTool.o : $(TupleTool_cpp_dependencies)
	$(cpp_echo) $(src)components/TupleTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TupleTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TupleTool_cppflags) $(TupleTool_cpp_cppflags) -I../src/components $(src)components/TupleTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)SequencerTimerTool.d

$(bin)$(binobj)SequencerTimerTool.d :

$(bin)$(binobj)SequencerTimerTool.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)SequencerTimerTool.o : $(src)components/SequencerTimerTool.cpp
	$(cpp_echo) $(src)components/SequencerTimerTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(SequencerTimerTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(SequencerTimerTool_cppflags) $(SequencerTimerTool_cpp_cppflags) -I../src/components $(src)components/SequencerTimerTool.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(SequencerTimerTool_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/SequencerTimerTool.cpp

$(bin)$(binobj)SequencerTimerTool.o : $(SequencerTimerTool_cpp_dependencies)
	$(cpp_echo) $(src)components/SequencerTimerTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(SequencerTimerTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(SequencerTimerTool_cppflags) $(SequencerTimerTool_cpp_cppflags) -I../src/components $(src)components/SequencerTimerTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)EventNodeKiller.d

$(bin)$(binobj)EventNodeKiller.d :

$(bin)$(binobj)EventNodeKiller.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)EventNodeKiller.o : $(src)components/EventNodeKiller.cpp
	$(cpp_echo) $(src)components/EventNodeKiller.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(EventNodeKiller_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(EventNodeKiller_cppflags) $(EventNodeKiller_cpp_cppflags) -I../src/components $(src)components/EventNodeKiller.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(EventNodeKiller_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/EventNodeKiller.cpp

$(bin)$(binobj)EventNodeKiller.o : $(EventNodeKiller_cpp_dependencies)
	$(cpp_echo) $(src)components/EventNodeKiller.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(EventNodeKiller_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(EventNodeKiller_cppflags) $(EventNodeKiller_cpp_cppflags) -I../src/components $(src)components/EventNodeKiller.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)ErrorTool.d

$(bin)$(binobj)ErrorTool.d :

$(bin)$(binobj)ErrorTool.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)ErrorTool.o : $(src)components/ErrorTool.cpp
	$(cpp_echo) $(src)components/ErrorTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(ErrorTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(ErrorTool_cppflags) $(ErrorTool_cpp_cppflags) -I../src/components $(src)components/ErrorTool.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(ErrorTool_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/ErrorTool.cpp

$(bin)$(binobj)ErrorTool.o : $(ErrorTool_cpp_dependencies)
	$(cpp_echo) $(src)components/ErrorTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(ErrorTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(ErrorTool_cppflags) $(ErrorTool_cpp_cppflags) -I../src/components $(src)components/ErrorTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoTool.d

$(bin)$(binobj)HistoTool.d :

$(bin)$(binobj)HistoTool.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)HistoTool.o : $(src)components/HistoTool.cpp
	$(cpp_echo) $(src)components/HistoTool.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(HistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(HistoTool_cppflags) $(HistoTool_cpp_cppflags) -I../src/components $(src)components/HistoTool.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(HistoTool_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/HistoTool.cpp

$(bin)$(binobj)HistoTool.o : $(HistoTool_cpp_dependencies)
	$(cpp_echo) $(src)components/HistoTool.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(HistoTool_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(HistoTool_cppflags) $(HistoTool_cpp_cppflags) -I../src/components $(src)components/HistoTool.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiAlgclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)TimingAuditor.d

$(bin)$(binobj)TimingAuditor.d :

$(bin)$(binobj)TimingAuditor.o : $(cmt_final_setup_GaudiAlg)

$(bin)$(binobj)TimingAuditor.o : $(src)components/TimingAuditor.cpp
	$(cpp_echo) $(src)components/TimingAuditor.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TimingAuditor_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TimingAuditor_cppflags) $(TimingAuditor_cpp_cppflags) -I../src/components $(src)components/TimingAuditor.cpp
endif
endif

else
$(bin)GaudiAlg_dependencies.make : $(TimingAuditor_cpp_dependencies)

$(bin)GaudiAlg_dependencies.make : $(src)components/TimingAuditor.cpp

$(bin)$(binobj)TimingAuditor.o : $(TimingAuditor_cpp_dependencies)
	$(cpp_echo) $(src)components/TimingAuditor.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiAlg_pp_cppflags) $(lib_GaudiAlg_pp_cppflags) $(TimingAuditor_pp_cppflags) $(use_cppflags) $(GaudiAlg_cppflags) $(lib_GaudiAlg_cppflags) $(TimingAuditor_cppflags) $(TimingAuditor_cpp_cppflags) -I../src/components $(src)components/TimingAuditor.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiAlgclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlg.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiAlg
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiAlg$(library_suffix).a $(library_prefix)GaudiAlg$(library_suffix).$(shlibsuffix) GaudiAlg.stamp GaudiAlg.shstamp
#-- end of cleanup_library ---------------
