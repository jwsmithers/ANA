
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralMonitor_tag = $(tag)

#cmt_local_tagfile = $(CoralMonitor_tag).make
cmt_local_tagfile = $(bin)$(CoralMonitor_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralMonitorsetup.make
cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)$(package)setup.make

cmt_build_library_linksstamp = $(bin)cmt_build_library_links.stamp
#--------------------------------------------------------

#cmt_lock_setup = /tmp/lock$(cmt_lock_pid).make
#cmt_temp_tag = /tmp/tag$(cmt_lock_pid).make

#first :: $(cmt_local_tagfile)
#	@echo $(cmt_local_tagfile) ok
#ifndef QUICK
#first :: $(cmt_final_setup) ;
#else
#first :: ;
#endif

##	@bin=`$(cmtexe) show macro_value bin`

#$(cmt_local_tagfile) : $(cmt_lock_setup)
#	@echo "#CMT> Error: $@: No such file" >&2; exit 1
#$(cmt_local_tagfile) :
#	@echo "#CMT> Warning: $@: No such file" >&2; exit
#	@echo "#CMT> Info: $@: No need to rebuild file" >&2; exit

#$(cmt_final_setup) : $(cmt_local_tagfile) 
#	$(echo) "(constituents.make) Rebuilding $@"
#	@if test ! -d $(@D); then $(mkdir) -p $(@D); fi; \
#	  if test -f $(cmt_local_setup); then /bin/rm -f $(cmt_local_setup); fi; \
#	  trap '/bin/rm -f $(cmt_local_setup)' 0 1 2 15; \
#	  $(cmtexe) -tag=$(tags) show setup >>$(cmt_local_setup); \
#	  if test ! -f $@; then \
#	    mv $(cmt_local_setup) $@; \
#	  else \
#	    if /usr/bin/diff $(cmt_local_setup) $@ >/dev/null ; then \
#	      : ; \
#	    else \
#	      mv $(cmt_local_setup) $@; \
#	    fi; \
#	  fi

#	@/bin/echo $@ ok   

#config :: checkuses
#	@exit 0
#checkuses : ;

env.make ::
	printenv >env.make.tmp; $(cmtexe) check files env.make.tmp env.make

ifndef QUICK
all :: build_library_links ;
else
all :: $(cmt_build_library_linksstamp) ;
endif

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

dirs :: requirements
	@if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi
#	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
#	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

#requirements :
#	@if test ! -r requirements ; then echo "No requirements file" ; fi

build_library_links : dirs
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links)
#	if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi; \
#	$(build_library_links)

$(cmt_build_library_linksstamp) : $(cmt_final_setup) $(cmt_local_tagfile) $(bin)library_links.in
	$(echo) "(constituents.make) Rebuilding library links"; \
	 $(build_library_links) -f=$(bin)library_links.in -without_cmt
	$(silent) \touch $@

ifndef PEDANTIC
.DEFAULT ::
#.DEFAULT :
	$(echo) "(constituents.make) $@: No rule for such target" >&2
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of constituents_header ------
#-- start of group ------

all_groups :: all

all :: $(all_dependencies)  $(all_pre_constituents) $(all_constituents)  $(all_post_constituents)
	$(echo) "all ok."

#	@/bin/echo " all ok."

clean :: allclean

allclean ::  $(all_constituentsclean)
	$(echo) $(all_constituentsclean)
	$(echo) "allclean ok."

#	@echo $(all_constituentsclean)
#	@/bin/echo " allclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: cmt_actions

cmt_actions :: $(cmt_actions_dependencies)  $(cmt_actions_pre_constituents) $(cmt_actions_constituents)  $(cmt_actions_post_constituents)
	$(echo) "cmt_actions ok."

#	@/bin/echo " cmt_actions ok."

clean :: allclean

cmt_actionsclean ::  $(cmt_actions_constituentsclean)
	$(echo) $(cmt_actions_constituentsclean)
	$(echo) "cmt_actionsclean ok."

#	@echo $(cmt_actions_constituentsclean)
#	@/bin/echo " cmt_actionsclean ok."

#-- end of group ------
#-- start of group ------

all_groups :: tests

tests :: $(tests_dependencies)  $(tests_pre_constituents) $(tests_constituents)  $(tests_post_constituents)
	$(echo) "tests ok."

#	@/bin/echo " tests ok."

clean :: allclean

testsclean ::  $(tests_constituentsclean)
	$(echo) $(tests_constituentsclean)
	$(echo) "testsclean ok."

#	@echo $(tests_constituentsclean)
#	@/bin/echo " testsclean ok."

#-- end of group ------
#-- start of constituent_app_lib ------

cmt_lcg_CoralMonitor_has_no_target_tag = 1
cmt_lcg_CoralMonitor_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralMonitor_has_target_tag

cmt_local_tagfile_lcg_CoralMonitor = $(bin)$(CoralMonitor_tag)_lcg_CoralMonitor.make
cmt_final_setup_lcg_CoralMonitor = $(bin)setup_lcg_CoralMonitor.make
cmt_local_lcg_CoralMonitor_makefile = $(bin)lcg_CoralMonitor.make

lcg_CoralMonitor_extratags = -tag_add=target_lcg_CoralMonitor

else

cmt_local_tagfile_lcg_CoralMonitor = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_lcg_CoralMonitor = $(bin)setup.make
cmt_local_lcg_CoralMonitor_makefile = $(bin)lcg_CoralMonitor.make

endif

not_lcg_CoralMonitorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralMonitorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralMonitordirs :
	@if test ! -d $(bin)lcg_CoralMonitor; then $(mkdir) -p $(bin)lcg_CoralMonitor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralMonitor
else
lcg_CoralMonitordirs : ;
endif

ifdef cmt_lcg_CoralMonitor_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralMonitor_makefile) : $(lcg_CoralMonitorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralMonitor.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralMonitor_extratags) build constituent_config -out=$(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitor
else
$(cmt_local_lcg_CoralMonitor_makefile) : $(lcg_CoralMonitorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralMonitor) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralMonitor) ] || \
	  $(not_lcg_CoralMonitorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralMonitor.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralMonitor_extratags) build constituent_config -out=$(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralMonitor_makefile) : $(lcg_CoralMonitorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralMonitor.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralMonitor.in -tag=$(tags) $(lcg_CoralMonitor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitor
else
$(cmt_local_lcg_CoralMonitor_makefile) : $(lcg_CoralMonitorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralMonitor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralMonitor) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralMonitor) ] || \
	  $(not_lcg_CoralMonitorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralMonitor.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralMonitor.in -tag=$(tags) $(lcg_CoralMonitor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralMonitor_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitor

lcg_CoralMonitor :: lcg_CoralMonitorcompile lcg_CoralMonitorinstall ;

ifdef cmt_lcg_CoralMonitor_has_prototypes

lcg_CoralMonitorprototype : $(lcg_CoralMonitorprototype_dependencies) $(cmt_local_lcg_CoralMonitor_makefile) dirs lcg_CoralMonitordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralMonitorcompile : lcg_CoralMonitorprototype

endif

lcg_CoralMonitorcompile : $(lcg_CoralMonitorcompile_dependencies) $(cmt_local_lcg_CoralMonitor_makefile) dirs lcg_CoralMonitordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralMonitorclean ;

lcg_CoralMonitorclean :: $(lcg_CoralMonitorclean_dependencies) ##$(cmt_local_lcg_CoralMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) lcg_CoralMonitorclean

##	  /bin/rm -f $(cmt_local_lcg_CoralMonitor_makefile) $(bin)lcg_CoralMonitor_dependencies.make

install :: lcg_CoralMonitorinstall ;

lcg_CoralMonitorinstall :: lcg_CoralMonitorcompile $(lcg_CoralMonitor_dependencies) $(cmt_local_lcg_CoralMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralMonitoruninstall

$(foreach d,$(lcg_CoralMonitor_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralMonitoruninstall))

lcg_CoralMonitoruninstall : $(lcg_CoralMonitoruninstall_dependencies) ##$(cmt_local_lcg_CoralMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralMonitor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralMonitoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralMonitor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralMonitor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_CsvStatsReporter_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_CsvStatsReporter_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_CsvStatsReporter_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_CsvStatsReporter = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_CsvStatsReporter.make
cmt_final_setup_test_unit_CoralMonitor_CsvStatsReporter = $(bin)setup_test_unit_CoralMonitor_CsvStatsReporter.make
cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile = $(bin)test_unit_CoralMonitor_CsvStatsReporter.make

test_unit_CoralMonitor_CsvStatsReporter_extratags = -tag_add=target_test_unit_CoralMonitor_CsvStatsReporter

else

cmt_local_tagfile_test_unit_CoralMonitor_CsvStatsReporter = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_CsvStatsReporter = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile = $(bin)test_unit_CoralMonitor_CsvStatsReporter.make

endif

not_test_unit_CoralMonitor_CsvStatsReportercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_CsvStatsReporterdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_CsvStatsReporter; then $(mkdir) -p $(bin)test_unit_CoralMonitor_CsvStatsReporter; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_CsvStatsReporter
else
test_unit_CoralMonitor_CsvStatsReporterdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_CsvStatsReporter_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) : $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_CsvStatsReporter.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_CsvStatsReporter_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporter
else
$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) : $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_CsvStatsReporter) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_CsvStatsReporter) ] || \
	  $(not_test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_CsvStatsReporter.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_CsvStatsReporter_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporter; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) : $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_CsvStatsReporter.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_CsvStatsReporter.in -tag=$(tags) $(test_unit_CoralMonitor_CsvStatsReporter_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporter
else
$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) : $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_CsvStatsReporter.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_CsvStatsReporter) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_CsvStatsReporter) ] || \
	  $(not_test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_CsvStatsReporter.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_CsvStatsReporter.in -tag=$(tags) $(test_unit_CoralMonitor_CsvStatsReporter_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporter; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_CsvStatsReporter_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporter

test_unit_CoralMonitor_CsvStatsReporter :: test_unit_CoralMonitor_CsvStatsReportercompile test_unit_CoralMonitor_CsvStatsReporterinstall ;

ifdef cmt_test_unit_CoralMonitor_CsvStatsReporter_has_prototypes

test_unit_CoralMonitor_CsvStatsReporterprototype : $(test_unit_CoralMonitor_CsvStatsReporterprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) dirs test_unit_CoralMonitor_CsvStatsReporterdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_CsvStatsReportercompile : test_unit_CoralMonitor_CsvStatsReporterprototype

endif

test_unit_CoralMonitor_CsvStatsReportercompile : $(test_unit_CoralMonitor_CsvStatsReportercompile_dependencies) $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) dirs test_unit_CoralMonitor_CsvStatsReporterdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_CsvStatsReporterclean ;

test_unit_CoralMonitor_CsvStatsReporterclean :: $(test_unit_CoralMonitor_CsvStatsReporterclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) test_unit_CoralMonitor_CsvStatsReporterclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $(bin)test_unit_CoralMonitor_CsvStatsReporter_dependencies.make

install :: test_unit_CoralMonitor_CsvStatsReporterinstall ;

test_unit_CoralMonitor_CsvStatsReporterinstall :: test_unit_CoralMonitor_CsvStatsReportercompile $(test_unit_CoralMonitor_CsvStatsReporter_dependencies) $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_CsvStatsReporteruninstall

$(foreach d,$(test_unit_CoralMonitor_CsvStatsReporter_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_CsvStatsReporteruninstall))

test_unit_CoralMonitor_CsvStatsReporteruninstall : $(test_unit_CoralMonitor_CsvStatsReporteruninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_CsvStatsReporter_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_CsvStatsReporteruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_CsvStatsReporter"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_CsvStatsReporter done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_MonitorService_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_MonitorService_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_MonitorService_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_MonitorService = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_MonitorService.make
cmt_final_setup_test_unit_CoralMonitor_MonitorService = $(bin)setup_test_unit_CoralMonitor_MonitorService.make
cmt_local_test_unit_CoralMonitor_MonitorService_makefile = $(bin)test_unit_CoralMonitor_MonitorService.make

test_unit_CoralMonitor_MonitorService_extratags = -tag_add=target_test_unit_CoralMonitor_MonitorService

else

cmt_local_tagfile_test_unit_CoralMonitor_MonitorService = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_MonitorService = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_MonitorService_makefile = $(bin)test_unit_CoralMonitor_MonitorService.make

endif

not_test_unit_CoralMonitor_MonitorServicecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_MonitorServicecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_MonitorServicedirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_MonitorService; then $(mkdir) -p $(bin)test_unit_CoralMonitor_MonitorService; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_MonitorService
else
test_unit_CoralMonitor_MonitorServicedirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_MonitorService_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) : $(test_unit_CoralMonitor_MonitorServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_MonitorService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_MonitorService_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorService
else
$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) : $(test_unit_CoralMonitor_MonitorServicecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_MonitorService) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_MonitorService) ] || \
	  $(not_test_unit_CoralMonitor_MonitorServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_MonitorService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_MonitorService_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorService; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) : $(test_unit_CoralMonitor_MonitorServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_MonitorService.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_MonitorService.in -tag=$(tags) $(test_unit_CoralMonitor_MonitorService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorService
else
$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) : $(test_unit_CoralMonitor_MonitorServicecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_MonitorService.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_MonitorService) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_MonitorService) ] || \
	  $(not_test_unit_CoralMonitor_MonitorServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_MonitorService.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_MonitorService.in -tag=$(tags) $(test_unit_CoralMonitor_MonitorService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorService; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_MonitorService_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorService

test_unit_CoralMonitor_MonitorService :: test_unit_CoralMonitor_MonitorServicecompile test_unit_CoralMonitor_MonitorServiceinstall ;

ifdef cmt_test_unit_CoralMonitor_MonitorService_has_prototypes

test_unit_CoralMonitor_MonitorServiceprototype : $(test_unit_CoralMonitor_MonitorServiceprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) dirs test_unit_CoralMonitor_MonitorServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_MonitorServicecompile : test_unit_CoralMonitor_MonitorServiceprototype

endif

test_unit_CoralMonitor_MonitorServicecompile : $(test_unit_CoralMonitor_MonitorServicecompile_dependencies) $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) dirs test_unit_CoralMonitor_MonitorServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_MonitorServiceclean ;

test_unit_CoralMonitor_MonitorServiceclean :: $(test_unit_CoralMonitor_MonitorServiceclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) test_unit_CoralMonitor_MonitorServiceclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $(bin)test_unit_CoralMonitor_MonitorService_dependencies.make

install :: test_unit_CoralMonitor_MonitorServiceinstall ;

test_unit_CoralMonitor_MonitorServiceinstall :: test_unit_CoralMonitor_MonitorServicecompile $(test_unit_CoralMonitor_MonitorService_dependencies) $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_MonitorServiceuninstall

$(foreach d,$(test_unit_CoralMonitor_MonitorService_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_MonitorServiceuninstall))

test_unit_CoralMonitor_MonitorServiceuninstall : $(test_unit_CoralMonitor_MonitorServiceuninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_MonitorService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_MonitorService_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_MonitorServiceuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_MonitorService"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_MonitorService done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_ServiceOrder_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_ServiceOrder_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_ServiceOrder_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_ServiceOrder = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_ServiceOrder.make
cmt_final_setup_test_unit_CoralMonitor_ServiceOrder = $(bin)setup_test_unit_CoralMonitor_ServiceOrder.make
cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile = $(bin)test_unit_CoralMonitor_ServiceOrder.make

test_unit_CoralMonitor_ServiceOrder_extratags = -tag_add=target_test_unit_CoralMonitor_ServiceOrder

else

cmt_local_tagfile_test_unit_CoralMonitor_ServiceOrder = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_ServiceOrder = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile = $(bin)test_unit_CoralMonitor_ServiceOrder.make

endif

not_test_unit_CoralMonitor_ServiceOrdercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_ServiceOrderdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_ServiceOrder; then $(mkdir) -p $(bin)test_unit_CoralMonitor_ServiceOrder; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_ServiceOrder
else
test_unit_CoralMonitor_ServiceOrderdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_ServiceOrder_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) : $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_ServiceOrder.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ServiceOrder_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrder
else
$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) : $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_ServiceOrder) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_ServiceOrder) ] || \
	  $(not_test_unit_CoralMonitor_ServiceOrdercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_ServiceOrder.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ServiceOrder_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrder; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) : $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_ServiceOrder.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_ServiceOrder.in -tag=$(tags) $(test_unit_CoralMonitor_ServiceOrder_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrder
else
$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) : $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_ServiceOrder.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_ServiceOrder) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_ServiceOrder) ] || \
	  $(not_test_unit_CoralMonitor_ServiceOrdercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_ServiceOrder.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_ServiceOrder.in -tag=$(tags) $(test_unit_CoralMonitor_ServiceOrder_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrder; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ServiceOrder_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrder

test_unit_CoralMonitor_ServiceOrder :: test_unit_CoralMonitor_ServiceOrdercompile test_unit_CoralMonitor_ServiceOrderinstall ;

ifdef cmt_test_unit_CoralMonitor_ServiceOrder_has_prototypes

test_unit_CoralMonitor_ServiceOrderprototype : $(test_unit_CoralMonitor_ServiceOrderprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) dirs test_unit_CoralMonitor_ServiceOrderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_ServiceOrdercompile : test_unit_CoralMonitor_ServiceOrderprototype

endif

test_unit_CoralMonitor_ServiceOrdercompile : $(test_unit_CoralMonitor_ServiceOrdercompile_dependencies) $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) dirs test_unit_CoralMonitor_ServiceOrderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_ServiceOrderclean ;

test_unit_CoralMonitor_ServiceOrderclean :: $(test_unit_CoralMonitor_ServiceOrderclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) test_unit_CoralMonitor_ServiceOrderclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $(bin)test_unit_CoralMonitor_ServiceOrder_dependencies.make

install :: test_unit_CoralMonitor_ServiceOrderinstall ;

test_unit_CoralMonitor_ServiceOrderinstall :: test_unit_CoralMonitor_ServiceOrdercompile $(test_unit_CoralMonitor_ServiceOrder_dependencies) $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_ServiceOrderuninstall

$(foreach d,$(test_unit_CoralMonitor_ServiceOrder_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_ServiceOrderuninstall))

test_unit_CoralMonitor_ServiceOrderuninstall : $(test_unit_CoralMonitor_ServiceOrderuninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ServiceOrder_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_ServiceOrderuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_ServiceOrder"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_ServiceOrder done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_StatsManager_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_StatsManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_StatsManager_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_StatsManager = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_StatsManager.make
cmt_final_setup_test_unit_CoralMonitor_StatsManager = $(bin)setup_test_unit_CoralMonitor_StatsManager.make
cmt_local_test_unit_CoralMonitor_StatsManager_makefile = $(bin)test_unit_CoralMonitor_StatsManager.make

test_unit_CoralMonitor_StatsManager_extratags = -tag_add=target_test_unit_CoralMonitor_StatsManager

else

cmt_local_tagfile_test_unit_CoralMonitor_StatsManager = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_StatsManager = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_StatsManager_makefile = $(bin)test_unit_CoralMonitor_StatsManager.make

endif

not_test_unit_CoralMonitor_StatsManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_StatsManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_StatsManagerdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_StatsManager; then $(mkdir) -p $(bin)test_unit_CoralMonitor_StatsManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_StatsManager
else
test_unit_CoralMonitor_StatsManagerdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_StatsManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) : $(test_unit_CoralMonitor_StatsManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManager
else
$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) : $(test_unit_CoralMonitor_StatsManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsManager) ] || \
	  $(not_test_unit_CoralMonitor_StatsManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) : $(test_unit_CoralMonitor_StatsManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsManager.in -tag=$(tags) $(test_unit_CoralMonitor_StatsManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManager
else
$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) : $(test_unit_CoralMonitor_StatsManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_StatsManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsManager) ] || \
	  $(not_test_unit_CoralMonitor_StatsManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsManager.in -tag=$(tags) $(test_unit_CoralMonitor_StatsManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManager

test_unit_CoralMonitor_StatsManager :: test_unit_CoralMonitor_StatsManagercompile test_unit_CoralMonitor_StatsManagerinstall ;

ifdef cmt_test_unit_CoralMonitor_StatsManager_has_prototypes

test_unit_CoralMonitor_StatsManagerprototype : $(test_unit_CoralMonitor_StatsManagerprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) dirs test_unit_CoralMonitor_StatsManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_StatsManagercompile : test_unit_CoralMonitor_StatsManagerprototype

endif

test_unit_CoralMonitor_StatsManagercompile : $(test_unit_CoralMonitor_StatsManagercompile_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) dirs test_unit_CoralMonitor_StatsManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_StatsManagerclean ;

test_unit_CoralMonitor_StatsManagerclean :: $(test_unit_CoralMonitor_StatsManagerclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) test_unit_CoralMonitor_StatsManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $(bin)test_unit_CoralMonitor_StatsManager_dependencies.make

install :: test_unit_CoralMonitor_StatsManagerinstall ;

test_unit_CoralMonitor_StatsManagerinstall :: test_unit_CoralMonitor_StatsManagercompile $(test_unit_CoralMonitor_StatsManager_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_StatsManageruninstall

$(foreach d,$(test_unit_CoralMonitor_StatsManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_StatsManageruninstall))

test_unit_CoralMonitor_StatsManageruninstall : $(test_unit_CoralMonitor_StatsManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_StatsManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_StatsManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_StatsManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_StatsSet_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_StatsSet_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_StatsSet_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_StatsSet = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_StatsSet.make
cmt_final_setup_test_unit_CoralMonitor_StatsSet = $(bin)setup_test_unit_CoralMonitor_StatsSet.make
cmt_local_test_unit_CoralMonitor_StatsSet_makefile = $(bin)test_unit_CoralMonitor_StatsSet.make

test_unit_CoralMonitor_StatsSet_extratags = -tag_add=target_test_unit_CoralMonitor_StatsSet

else

cmt_local_tagfile_test_unit_CoralMonitor_StatsSet = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_StatsSet = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_StatsSet_makefile = $(bin)test_unit_CoralMonitor_StatsSet.make

endif

not_test_unit_CoralMonitor_StatsSetcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_StatsSetcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_StatsSetdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_StatsSet; then $(mkdir) -p $(bin)test_unit_CoralMonitor_StatsSet; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_StatsSet
else
test_unit_CoralMonitor_StatsSetdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_StatsSet_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) : $(test_unit_CoralMonitor_StatsSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsSet_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSet
else
$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) : $(test_unit_CoralMonitor_StatsSetcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsSet) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsSet) ] || \
	  $(not_test_unit_CoralMonitor_StatsSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsSet_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSet; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) : $(test_unit_CoralMonitor_StatsSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsSet.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsSet.in -tag=$(tags) $(test_unit_CoralMonitor_StatsSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSet
else
$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) : $(test_unit_CoralMonitor_StatsSetcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_StatsSet.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsSet) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsSet) ] || \
	  $(not_test_unit_CoralMonitor_StatsSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsSet.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsSet.in -tag=$(tags) $(test_unit_CoralMonitor_StatsSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSet; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsSet_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSet

test_unit_CoralMonitor_StatsSet :: test_unit_CoralMonitor_StatsSetcompile test_unit_CoralMonitor_StatsSetinstall ;

ifdef cmt_test_unit_CoralMonitor_StatsSet_has_prototypes

test_unit_CoralMonitor_StatsSetprototype : $(test_unit_CoralMonitor_StatsSetprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) dirs test_unit_CoralMonitor_StatsSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_StatsSetcompile : test_unit_CoralMonitor_StatsSetprototype

endif

test_unit_CoralMonitor_StatsSetcompile : $(test_unit_CoralMonitor_StatsSetcompile_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) dirs test_unit_CoralMonitor_StatsSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_StatsSetclean ;

test_unit_CoralMonitor_StatsSetclean :: $(test_unit_CoralMonitor_StatsSetclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) test_unit_CoralMonitor_StatsSetclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $(bin)test_unit_CoralMonitor_StatsSet_dependencies.make

install :: test_unit_CoralMonitor_StatsSetinstall ;

test_unit_CoralMonitor_StatsSetinstall :: test_unit_CoralMonitor_StatsSetcompile $(test_unit_CoralMonitor_StatsSet_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_StatsSetuninstall

$(foreach d,$(test_unit_CoralMonitor_StatsSet_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_StatsSetuninstall))

test_unit_CoralMonitor_StatsSetuninstall : $(test_unit_CoralMonitor_StatsSetuninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsSet_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_StatsSetuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_StatsSet"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_StatsSet done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_StatsStatic_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_StatsStatic_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_StatsStatic_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_StatsStatic = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_StatsStatic.make
cmt_final_setup_test_unit_CoralMonitor_StatsStatic = $(bin)setup_test_unit_CoralMonitor_StatsStatic.make
cmt_local_test_unit_CoralMonitor_StatsStatic_makefile = $(bin)test_unit_CoralMonitor_StatsStatic.make

test_unit_CoralMonitor_StatsStatic_extratags = -tag_add=target_test_unit_CoralMonitor_StatsStatic

else

cmt_local_tagfile_test_unit_CoralMonitor_StatsStatic = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_StatsStatic = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_StatsStatic_makefile = $(bin)test_unit_CoralMonitor_StatsStatic.make

endif

not_test_unit_CoralMonitor_StatsStaticcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_StatsStaticcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_StatsStaticdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_StatsStatic; then $(mkdir) -p $(bin)test_unit_CoralMonitor_StatsStatic; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_StatsStatic
else
test_unit_CoralMonitor_StatsStaticdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_StatsStatic_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) : $(test_unit_CoralMonitor_StatsStaticcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsStatic.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsStatic_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStatic
else
$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) : $(test_unit_CoralMonitor_StatsStaticcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsStatic) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsStatic) ] || \
	  $(not_test_unit_CoralMonitor_StatsStaticcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsStatic.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsStatic_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStatic; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) : $(test_unit_CoralMonitor_StatsStaticcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StatsStatic.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsStatic.in -tag=$(tags) $(test_unit_CoralMonitor_StatsStatic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStatic
else
$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) : $(test_unit_CoralMonitor_StatsStaticcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_StatsStatic.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StatsStatic) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StatsStatic) ] || \
	  $(not_test_unit_CoralMonitor_StatsStaticcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StatsStatic.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StatsStatic.in -tag=$(tags) $(test_unit_CoralMonitor_StatsStatic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStatic; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StatsStatic_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStatic

test_unit_CoralMonitor_StatsStatic :: test_unit_CoralMonitor_StatsStaticcompile test_unit_CoralMonitor_StatsStaticinstall ;

ifdef cmt_test_unit_CoralMonitor_StatsStatic_has_prototypes

test_unit_CoralMonitor_StatsStaticprototype : $(test_unit_CoralMonitor_StatsStaticprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) dirs test_unit_CoralMonitor_StatsStaticdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_StatsStaticcompile : test_unit_CoralMonitor_StatsStaticprototype

endif

test_unit_CoralMonitor_StatsStaticcompile : $(test_unit_CoralMonitor_StatsStaticcompile_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) dirs test_unit_CoralMonitor_StatsStaticdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_StatsStaticclean ;

test_unit_CoralMonitor_StatsStaticclean :: $(test_unit_CoralMonitor_StatsStaticclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) test_unit_CoralMonitor_StatsStaticclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $(bin)test_unit_CoralMonitor_StatsStatic_dependencies.make

install :: test_unit_CoralMonitor_StatsStaticinstall ;

test_unit_CoralMonitor_StatsStaticinstall :: test_unit_CoralMonitor_StatsStaticcompile $(test_unit_CoralMonitor_StatsStatic_dependencies) $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_StatsStaticuninstall

$(foreach d,$(test_unit_CoralMonitor_StatsStatic_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_StatsStaticuninstall))

test_unit_CoralMonitor_StatsStaticuninstall : $(test_unit_CoralMonitor_StatsStaticuninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StatsStatic_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_StatsStaticuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_StatsStatic"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_StatsStatic done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_StopTimer_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_StopTimer_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_StopTimer_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_StopTimer = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_StopTimer.make
cmt_final_setup_test_unit_CoralMonitor_StopTimer = $(bin)setup_test_unit_CoralMonitor_StopTimer.make
cmt_local_test_unit_CoralMonitor_StopTimer_makefile = $(bin)test_unit_CoralMonitor_StopTimer.make

test_unit_CoralMonitor_StopTimer_extratags = -tag_add=target_test_unit_CoralMonitor_StopTimer

else

cmt_local_tagfile_test_unit_CoralMonitor_StopTimer = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_StopTimer = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_StopTimer_makefile = $(bin)test_unit_CoralMonitor_StopTimer.make

endif

not_test_unit_CoralMonitor_StopTimercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_StopTimercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_StopTimerdirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_StopTimer; then $(mkdir) -p $(bin)test_unit_CoralMonitor_StopTimer; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_StopTimer
else
test_unit_CoralMonitor_StopTimerdirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_StopTimer_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) : $(test_unit_CoralMonitor_StopTimercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StopTimer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StopTimer_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimer
else
$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) : $(test_unit_CoralMonitor_StopTimercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StopTimer) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StopTimer) ] || \
	  $(not_test_unit_CoralMonitor_StopTimercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StopTimer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StopTimer_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimer; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) : $(test_unit_CoralMonitor_StopTimercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_StopTimer.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StopTimer.in -tag=$(tags) $(test_unit_CoralMonitor_StopTimer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimer
else
$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) : $(test_unit_CoralMonitor_StopTimercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_StopTimer.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_StopTimer) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_StopTimer) ] || \
	  $(not_test_unit_CoralMonitor_StopTimercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_StopTimer.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_StopTimer.in -tag=$(tags) $(test_unit_CoralMonitor_StopTimer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimer; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_StopTimer_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimer

test_unit_CoralMonitor_StopTimer :: test_unit_CoralMonitor_StopTimercompile test_unit_CoralMonitor_StopTimerinstall ;

ifdef cmt_test_unit_CoralMonitor_StopTimer_has_prototypes

test_unit_CoralMonitor_StopTimerprototype : $(test_unit_CoralMonitor_StopTimerprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) dirs test_unit_CoralMonitor_StopTimerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_StopTimercompile : test_unit_CoralMonitor_StopTimerprototype

endif

test_unit_CoralMonitor_StopTimercompile : $(test_unit_CoralMonitor_StopTimercompile_dependencies) $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) dirs test_unit_CoralMonitor_StopTimerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_StopTimerclean ;

test_unit_CoralMonitor_StopTimerclean :: $(test_unit_CoralMonitor_StopTimerclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) test_unit_CoralMonitor_StopTimerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $(bin)test_unit_CoralMonitor_StopTimer_dependencies.make

install :: test_unit_CoralMonitor_StopTimerinstall ;

test_unit_CoralMonitor_StopTimerinstall :: test_unit_CoralMonitor_StopTimercompile $(test_unit_CoralMonitor_StopTimer_dependencies) $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_StopTimeruninstall

$(foreach d,$(test_unit_CoralMonitor_StopTimer_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_StopTimeruninstall))

test_unit_CoralMonitor_StopTimeruninstall : $(test_unit_CoralMonitor_StopTimeruninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_StopTimer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_StopTimer_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_StopTimeruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_StopTimer"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_StopTimer done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralMonitor_ThreadSafety_has_no_target_tag = 1
cmt_test_unit_CoralMonitor_ThreadSafety_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralMonitor_ThreadSafety_has_target_tag

cmt_local_tagfile_test_unit_CoralMonitor_ThreadSafety = $(bin)$(CoralMonitor_tag)_test_unit_CoralMonitor_ThreadSafety.make
cmt_final_setup_test_unit_CoralMonitor_ThreadSafety = $(bin)setup_test_unit_CoralMonitor_ThreadSafety.make
cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile = $(bin)test_unit_CoralMonitor_ThreadSafety.make

test_unit_CoralMonitor_ThreadSafety_extratags = -tag_add=target_test_unit_CoralMonitor_ThreadSafety

else

cmt_local_tagfile_test_unit_CoralMonitor_ThreadSafety = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_test_unit_CoralMonitor_ThreadSafety = $(bin)setup.make
cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile = $(bin)test_unit_CoralMonitor_ThreadSafety.make

endif

not_test_unit_CoralMonitor_ThreadSafetycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralMonitor_ThreadSafetydirs :
	@if test ! -d $(bin)test_unit_CoralMonitor_ThreadSafety; then $(mkdir) -p $(bin)test_unit_CoralMonitor_ThreadSafety; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralMonitor_ThreadSafety
else
test_unit_CoralMonitor_ThreadSafetydirs : ;
endif

ifdef cmt_test_unit_CoralMonitor_ThreadSafety_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) : $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_ThreadSafety.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ThreadSafety_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafety
else
$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) : $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_ThreadSafety) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_ThreadSafety) ] || \
	  $(not_test_unit_CoralMonitor_ThreadSafetycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_ThreadSafety.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ThreadSafety_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafety; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) : $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralMonitor_ThreadSafety.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_ThreadSafety.in -tag=$(tags) $(test_unit_CoralMonitor_ThreadSafety_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafety
else
$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) : $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralMonitor_ThreadSafety.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralMonitor_ThreadSafety) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralMonitor_ThreadSafety) ] || \
	  $(not_test_unit_CoralMonitor_ThreadSafetycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralMonitor_ThreadSafety.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralMonitor_ThreadSafety.in -tag=$(tags) $(test_unit_CoralMonitor_ThreadSafety_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafety; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralMonitor_ThreadSafety_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafety

test_unit_CoralMonitor_ThreadSafety :: test_unit_CoralMonitor_ThreadSafetycompile test_unit_CoralMonitor_ThreadSafetyinstall ;

ifdef cmt_test_unit_CoralMonitor_ThreadSafety_has_prototypes

test_unit_CoralMonitor_ThreadSafetyprototype : $(test_unit_CoralMonitor_ThreadSafetyprototype_dependencies) $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) dirs test_unit_CoralMonitor_ThreadSafetydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralMonitor_ThreadSafetycompile : test_unit_CoralMonitor_ThreadSafetyprototype

endif

test_unit_CoralMonitor_ThreadSafetycompile : $(test_unit_CoralMonitor_ThreadSafetycompile_dependencies) $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) dirs test_unit_CoralMonitor_ThreadSafetydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralMonitor_ThreadSafetyclean ;

test_unit_CoralMonitor_ThreadSafetyclean :: $(test_unit_CoralMonitor_ThreadSafetyclean_dependencies) ##$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) test_unit_CoralMonitor_ThreadSafetyclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $(bin)test_unit_CoralMonitor_ThreadSafety_dependencies.make

install :: test_unit_CoralMonitor_ThreadSafetyinstall ;

test_unit_CoralMonitor_ThreadSafetyinstall :: test_unit_CoralMonitor_ThreadSafetycompile $(test_unit_CoralMonitor_ThreadSafety_dependencies) $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralMonitor_ThreadSafetyuninstall

$(foreach d,$(test_unit_CoralMonitor_ThreadSafety_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralMonitor_ThreadSafetyuninstall))

test_unit_CoralMonitor_ThreadSafetyuninstall : $(test_unit_CoralMonitor_ThreadSafetyuninstall_dependencies) ##$(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralMonitor_ThreadSafety_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralMonitor_ThreadSafetyuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralMonitor_ThreadSafety"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralMonitor_ThreadSafety done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralMonitor_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_install_includes = $(bin)setup.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

endif

not_install_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_includesdirs :
	@if test ! -d $(bin)install_includes; then $(mkdir) -p $(bin)install_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_includes
else
install_includesdirs : ;
endif

ifdef cmt_install_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_config -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes
else
$(cmt_local_install_includes_makefile) : $(install_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_includes) ] || \
	  $(not_install_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_includes.make"; \
	  $(cmtexe) -f=$(bin)install_includes.in -tag=$(tags) $(install_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_includes_makefile) install_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_includes_extratags) build constituent_makefile -out=$(cmt_local_install_includes_makefile) install_includes

install_includes :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile) dirs install_includesdirs
	$(echo) "(constituents.make) Starting install_includes"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) install_includes
	$(echo) "(constituents.make) install_includes done"

clean :: install_includesclean ;

install_includesclean :: $(install_includesclean_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting install_includesclean"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean; \
	fi
	$(echo) "(constituents.make) install_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install_includesclean

##	  /bin/rm -f $(cmt_local_install_includes_makefile) $(bin)install_includes_dependencies.make

install :: install_includesinstall ;

install_includesinstall :: $(install_includes_dependencies) $(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_includes_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_includesuninstall

$(foreach d,$(install_includes_dependencies),$(eval $(d)uninstall_dependencies += install_includesuninstall))

install_includesuninstall : $(install_includesuninstall_dependencies) ##$(cmt_local_install_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_includes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_includesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_includes done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_pythonmods_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_pythonmods_has_target_tag

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralMonitor_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_install_pythonmods = $(bin)setup.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

endif

not_install_pythonmods_dependencies = { n=0; for p in $?; do m=0; for d in $(install_pythonmods_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_pythonmodsdirs :
	@if test ! -d $(bin)install_pythonmods; then $(mkdir) -p $(bin)install_pythonmods; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_pythonmods
else
install_pythonmodsdirs : ;
endif

ifdef cmt_install_pythonmods_has_target_tag

ifndef QUICK
$(cmt_local_install_pythonmods_makefile) : $(install_pythonmods_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pythonmods.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pythonmods_extratags) build constituent_config -out=$(cmt_local_install_pythonmods_makefile) install_pythonmods
else
$(cmt_local_install_pythonmods_makefile) : $(install_pythonmods_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pythonmods) ] || \
	  [ ! -f $(cmt_final_setup_install_pythonmods) ] || \
	  $(not_install_pythonmods_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pythonmods.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pythonmods_extratags) build constituent_config -out=$(cmt_local_install_pythonmods_makefile) install_pythonmods; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_pythonmods_makefile) : $(install_pythonmods_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pythonmods.make"; \
	  $(cmtexe) -f=$(bin)install_pythonmods.in -tag=$(tags) $(install_pythonmods_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pythonmods_makefile) install_pythonmods
else
$(cmt_local_install_pythonmods_makefile) : $(install_pythonmods_dependencies) $(cmt_build_library_linksstamp) $(bin)install_pythonmods.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pythonmods) ] || \
	  [ ! -f $(cmt_final_setup_install_pythonmods) ] || \
	  $(not_install_pythonmods_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pythonmods.make"; \
	  $(cmtexe) -f=$(bin)install_pythonmods.in -tag=$(tags) $(install_pythonmods_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pythonmods_makefile) install_pythonmods; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_pythonmods_extratags) build constituent_makefile -out=$(cmt_local_install_pythonmods_makefile) install_pythonmods

install_pythonmods :: $(install_pythonmods_dependencies) $(cmt_local_install_pythonmods_makefile) dirs install_pythonmodsdirs
	$(echo) "(constituents.make) Starting install_pythonmods"
	@if test -f $(cmt_local_install_pythonmods_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pythonmods_makefile) install_pythonmods; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pythonmods_makefile) install_pythonmods
	$(echo) "(constituents.make) install_pythonmods done"

clean :: install_pythonmodsclean ;

install_pythonmodsclean :: $(install_pythonmodsclean_dependencies) ##$(cmt_local_install_pythonmods_makefile)
	$(echo) "(constituents.make) Starting install_pythonmodsclean"
	@-if test -f $(cmt_local_install_pythonmods_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pythonmods_makefile) install_pythonmodsclean; \
	fi
	$(echo) "(constituents.make) install_pythonmodsclean done"
#	@-$(MAKE) -f $(cmt_local_install_pythonmods_makefile) install_pythonmodsclean

##	  /bin/rm -f $(cmt_local_install_pythonmods_makefile) $(bin)install_pythonmods_dependencies.make

install :: install_pythonmodsinstall ;

install_pythonmodsinstall :: $(install_pythonmods_dependencies) $(cmt_local_install_pythonmods_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_pythonmods_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pythonmods_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_pythonmods_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_pythonmodsuninstall

$(foreach d,$(install_pythonmods_dependencies),$(eval $(d)uninstall_dependencies += install_pythonmodsuninstall))

install_pythonmodsuninstall : $(install_pythonmodsuninstall_dependencies) ##$(cmt_local_install_pythonmods_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_pythonmods_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pythonmods_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pythonmods_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_pythonmodsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_pythonmods"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_pythonmods done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(CoralMonitor_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_make = $(bin)setup.make
cmt_local_make_makefile = $(bin)make.make

endif

not_make_dependencies = { n=0; for p in $?; do m=0; for d in $(make_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
makedirs :
	@if test ! -d $(bin)make; then $(mkdir) -p $(bin)make; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)make
else
makedirs : ;
endif

ifdef cmt_make_has_target_tag

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_config -out=$(cmt_local_make_makefile) make; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_make_makefile) : $(make_dependencies) build_library_links
	$(echo) "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make
else
$(cmt_local_make_makefile) : $(make_dependencies) $(cmt_build_library_linksstamp) $(bin)make.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_make) ] || \
	  [ ! -f $(cmt_final_setup_make) ] || \
	  $(not_make_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building make.make"; \
	  $(cmtexe) -f=$(bin)make.in -tag=$(tags) $(make_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_make_makefile) make; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(make_extratags) build constituent_makefile -out=$(cmt_local_make_makefile) make

make :: $(make_dependencies) $(cmt_local_make_makefile) dirs makedirs
	$(echo) "(constituents.make) Starting make"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) make; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) make
	$(echo) "(constituents.make) make done"

clean :: makeclean ;

makeclean :: $(makeclean_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting makeclean"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) makeclean; \
	fi
	$(echo) "(constituents.make) makeclean done"
#	@-$(MAKE) -f $(cmt_local_make_makefile) makeclean

##	  /bin/rm -f $(cmt_local_make_makefile) $(bin)make_dependencies.make

install :: makeinstall ;

makeinstall :: $(make_dependencies) $(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_make_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : makeuninstall

$(foreach d,$(make_dependencies),$(eval $(d)uninstall_dependencies += makeuninstall))

makeuninstall : $(makeuninstall_dependencies) ##$(cmt_local_make_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_make_makefile); then \
	  $(MAKE) -f $(cmt_local_make_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_make_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: makeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ make"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ make done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_lcg_mkdir_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_lcg_mkdir_has_target_tag

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralMonitor_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_lcg_mkdir = $(bin)setup.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

endif

not_lcg_mkdir_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_mkdir_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_mkdirdirs :
	@if test ! -d $(bin)lcg_mkdir; then $(mkdir) -p $(bin)lcg_mkdir; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_mkdir
else
lcg_mkdirdirs : ;
endif

ifdef cmt_lcg_mkdir_has_target_tag

ifndef QUICK
$(cmt_local_lcg_mkdir_makefile) : $(lcg_mkdir_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_mkdir.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_mkdir_extratags) build constituent_config -out=$(cmt_local_lcg_mkdir_makefile) lcg_mkdir
else
$(cmt_local_lcg_mkdir_makefile) : $(lcg_mkdir_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_mkdir) ] || \
	  [ ! -f $(cmt_final_setup_lcg_mkdir) ] || \
	  $(not_lcg_mkdir_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_mkdir.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_mkdir_extratags) build constituent_config -out=$(cmt_local_lcg_mkdir_makefile) lcg_mkdir; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_mkdir_makefile) : $(lcg_mkdir_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_mkdir.make"; \
	  $(cmtexe) -f=$(bin)lcg_mkdir.in -tag=$(tags) $(lcg_mkdir_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_mkdir_makefile) lcg_mkdir
else
$(cmt_local_lcg_mkdir_makefile) : $(lcg_mkdir_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_mkdir.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_mkdir) ] || \
	  [ ! -f $(cmt_final_setup_lcg_mkdir) ] || \
	  $(not_lcg_mkdir_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_mkdir.make"; \
	  $(cmtexe) -f=$(bin)lcg_mkdir.in -tag=$(tags) $(lcg_mkdir_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_mkdir_makefile) lcg_mkdir; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_mkdir_extratags) build constituent_makefile -out=$(cmt_local_lcg_mkdir_makefile) lcg_mkdir

lcg_mkdir :: $(lcg_mkdir_dependencies) $(cmt_local_lcg_mkdir_makefile) dirs lcg_mkdirdirs
	$(echo) "(constituents.make) Starting lcg_mkdir"
	@if test -f $(cmt_local_lcg_mkdir_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_mkdir_makefile) lcg_mkdir; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_mkdir_makefile) lcg_mkdir
	$(echo) "(constituents.make) lcg_mkdir done"

clean :: lcg_mkdirclean ;

lcg_mkdirclean :: $(lcg_mkdirclean_dependencies) ##$(cmt_local_lcg_mkdir_makefile)
	$(echo) "(constituents.make) Starting lcg_mkdirclean"
	@-if test -f $(cmt_local_lcg_mkdir_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_mkdir_makefile) lcg_mkdirclean; \
	fi
	$(echo) "(constituents.make) lcg_mkdirclean done"
#	@-$(MAKE) -f $(cmt_local_lcg_mkdir_makefile) lcg_mkdirclean

##	  /bin/rm -f $(cmt_local_lcg_mkdir_makefile) $(bin)lcg_mkdir_dependencies.make

install :: lcg_mkdirinstall ;

lcg_mkdirinstall :: $(lcg_mkdir_dependencies) $(cmt_local_lcg_mkdir_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_mkdir_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_mkdir_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_lcg_mkdir_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_mkdiruninstall

$(foreach d,$(lcg_mkdir_dependencies),$(eval $(d)uninstall_dependencies += lcg_mkdiruninstall))

lcg_mkdiruninstall : $(lcg_mkdiruninstall_dependencies) ##$(cmt_local_lcg_mkdir_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_mkdir_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_mkdir_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_mkdir_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_mkdiruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_mkdir"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_mkdir done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_utilities_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_utilities_has_target_tag

cmt_local_tagfile_utilities = $(bin)$(CoralMonitor_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_utilities = $(bin)setup.make
cmt_local_utilities_makefile = $(bin)utilities.make

endif

not_utilities_dependencies = { n=0; for p in $?; do m=0; for d in $(utilities_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
utilitiesdirs :
	@if test ! -d $(bin)utilities; then $(mkdir) -p $(bin)utilities; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)utilities
else
utilitiesdirs : ;
endif

ifdef cmt_utilities_has_target_tag

ifndef QUICK
$(cmt_local_utilities_makefile) : $(utilities_dependencies) build_library_links
	$(echo) "(constituents.make) Building utilities.make"; \
	  $(cmtexe) -tag=$(tags) $(utilities_extratags) build constituent_config -out=$(cmt_local_utilities_makefile) utilities
else
$(cmt_local_utilities_makefile) : $(utilities_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_utilities) ] || \
	  [ ! -f $(cmt_final_setup_utilities) ] || \
	  $(not_utilities_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building utilities.make"; \
	  $(cmtexe) -tag=$(tags) $(utilities_extratags) build constituent_config -out=$(cmt_local_utilities_makefile) utilities; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_utilities_makefile) : $(utilities_dependencies) build_library_links
	$(echo) "(constituents.make) Building utilities.make"; \
	  $(cmtexe) -f=$(bin)utilities.in -tag=$(tags) $(utilities_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_utilities_makefile) utilities
else
$(cmt_local_utilities_makefile) : $(utilities_dependencies) $(cmt_build_library_linksstamp) $(bin)utilities.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_utilities) ] || \
	  [ ! -f $(cmt_final_setup_utilities) ] || \
	  $(not_utilities_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building utilities.make"; \
	  $(cmtexe) -f=$(bin)utilities.in -tag=$(tags) $(utilities_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_utilities_makefile) utilities; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(utilities_extratags) build constituent_makefile -out=$(cmt_local_utilities_makefile) utilities

utilities :: $(utilities_dependencies) $(cmt_local_utilities_makefile) dirs utilitiesdirs
	$(echo) "(constituents.make) Starting utilities"
	@if test -f $(cmt_local_utilities_makefile); then \
	  $(MAKE) -f $(cmt_local_utilities_makefile) utilities; \
	  fi
#	@$(MAKE) -f $(cmt_local_utilities_makefile) utilities
	$(echo) "(constituents.make) utilities done"

clean :: utilitiesclean ;

utilitiesclean :: $(utilitiesclean_dependencies) ##$(cmt_local_utilities_makefile)
	$(echo) "(constituents.make) Starting utilitiesclean"
	@-if test -f $(cmt_local_utilities_makefile); then \
	  $(MAKE) -f $(cmt_local_utilities_makefile) utilitiesclean; \
	fi
	$(echo) "(constituents.make) utilitiesclean done"
#	@-$(MAKE) -f $(cmt_local_utilities_makefile) utilitiesclean

##	  /bin/rm -f $(cmt_local_utilities_makefile) $(bin)utilities_dependencies.make

install :: utilitiesinstall ;

utilitiesinstall :: $(utilities_dependencies) $(cmt_local_utilities_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_utilities_makefile); then \
	  $(MAKE) -f $(cmt_local_utilities_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_utilities_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : utilitiesuninstall

$(foreach d,$(utilities_dependencies),$(eval $(d)uninstall_dependencies += utilitiesuninstall))

utilitiesuninstall : $(utilitiesuninstall_dependencies) ##$(cmt_local_utilities_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_utilities_makefile); then \
	  $(MAKE) -f $(cmt_local_utilities_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_utilities_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: utilitiesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ utilities"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ utilities done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_examples_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_examples_has_target_tag

cmt_local_tagfile_examples = $(bin)$(CoralMonitor_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralMonitor_tag).make
cmt_final_setup_examples = $(bin)setup.make
cmt_local_examples_makefile = $(bin)examples.make

endif

not_examples_dependencies = { n=0; for p in $?; do m=0; for d in $(examples_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
examplesdirs :
	@if test ! -d $(bin)examples; then $(mkdir) -p $(bin)examples; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)examples
else
examplesdirs : ;
endif

ifdef cmt_examples_has_target_tag

ifndef QUICK
$(cmt_local_examples_makefile) : $(examples_dependencies) build_library_links
	$(echo) "(constituents.make) Building examples.make"; \
	  $(cmtexe) -tag=$(tags) $(examples_extratags) build constituent_config -out=$(cmt_local_examples_makefile) examples
else
$(cmt_local_examples_makefile) : $(examples_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_examples) ] || \
	  [ ! -f $(cmt_final_setup_examples) ] || \
	  $(not_examples_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building examples.make"; \
	  $(cmtexe) -tag=$(tags) $(examples_extratags) build constituent_config -out=$(cmt_local_examples_makefile) examples; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_examples_makefile) : $(examples_dependencies) build_library_links
	$(echo) "(constituents.make) Building examples.make"; \
	  $(cmtexe) -f=$(bin)examples.in -tag=$(tags) $(examples_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_examples_makefile) examples
else
$(cmt_local_examples_makefile) : $(examples_dependencies) $(cmt_build_library_linksstamp) $(bin)examples.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_examples) ] || \
	  [ ! -f $(cmt_final_setup_examples) ] || \
	  $(not_examples_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building examples.make"; \
	  $(cmtexe) -f=$(bin)examples.in -tag=$(tags) $(examples_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_examples_makefile) examples; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(examples_extratags) build constituent_makefile -out=$(cmt_local_examples_makefile) examples

examples :: $(examples_dependencies) $(cmt_local_examples_makefile) dirs examplesdirs
	$(echo) "(constituents.make) Starting examples"
	@if test -f $(cmt_local_examples_makefile); then \
	  $(MAKE) -f $(cmt_local_examples_makefile) examples; \
	  fi
#	@$(MAKE) -f $(cmt_local_examples_makefile) examples
	$(echo) "(constituents.make) examples done"

clean :: examplesclean ;

examplesclean :: $(examplesclean_dependencies) ##$(cmt_local_examples_makefile)
	$(echo) "(constituents.make) Starting examplesclean"
	@-if test -f $(cmt_local_examples_makefile); then \
	  $(MAKE) -f $(cmt_local_examples_makefile) examplesclean; \
	fi
	$(echo) "(constituents.make) examplesclean done"
#	@-$(MAKE) -f $(cmt_local_examples_makefile) examplesclean

##	  /bin/rm -f $(cmt_local_examples_makefile) $(bin)examples_dependencies.make

install :: examplesinstall ;

examplesinstall :: $(examples_dependencies) $(cmt_local_examples_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_examples_makefile); then \
	  $(MAKE) -f $(cmt_local_examples_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_examples_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : examplesuninstall

$(foreach d,$(examples_dependencies),$(eval $(d)uninstall_dependencies += examplesuninstall))

examplesuninstall : $(examplesuninstall_dependencies) ##$(cmt_local_examples_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_examples_makefile); then \
	  $(MAKE) -f $(cmt_local_examples_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_examples_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: examplesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ examples"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ examples done"
endif

#-- end of constituent ------
#-- start of constituents_trailer ------

uninstall : remove_library_links ;
clean ::
	$(cleanup_echo) $(cmt_build_library_linksstamp)
	-$(cleanup_silent) \rm -f $(cmt_build_library_linksstamp)
#clean :: remove_library_links

remove_library_links ::
ifndef QUICK
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links)
else
	$(echo) "(constituents.make) Removing library links"; \
	  $(remove_library_links) -f=$(bin)library_links.in -without_cmt
endif

#-- end of constituents_trailer ------
