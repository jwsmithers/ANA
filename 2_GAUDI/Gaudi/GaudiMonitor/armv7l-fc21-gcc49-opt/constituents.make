
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile = $(GaudiMonitor_tag).make
cmt_local_tagfile = $(bin)$(GaudiMonitor_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make
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
#-- start of constituent_app_lib ------

cmt_GaudiMonitor_has_no_target_tag = 1
cmt_GaudiMonitor_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMonitor_has_target_tag

cmt_local_tagfile_GaudiMonitor = $(bin)$(GaudiMonitor_tag)_GaudiMonitor.make
cmt_final_setup_GaudiMonitor = $(bin)setup_GaudiMonitor.make
cmt_local_GaudiMonitor_makefile = $(bin)GaudiMonitor.make

GaudiMonitor_extratags = -tag_add=target_GaudiMonitor

else

cmt_local_tagfile_GaudiMonitor = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitor = $(bin)setup.make
cmt_local_GaudiMonitor_makefile = $(bin)GaudiMonitor.make

endif

not_GaudiMonitorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitordirs :
	@if test ! -d $(bin)GaudiMonitor; then $(mkdir) -p $(bin)GaudiMonitor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitor
else
GaudiMonitordirs : ;
endif

ifdef cmt_GaudiMonitor_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitor_makefile) : $(GaudiMonitorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitor.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_extratags) build constituent_config -out=$(cmt_local_GaudiMonitor_makefile) GaudiMonitor
else
$(cmt_local_GaudiMonitor_makefile) : $(GaudiMonitorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitor) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitor) ] || \
	  $(not_GaudiMonitorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitor.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_extratags) build constituent_config -out=$(cmt_local_GaudiMonitor_makefile) GaudiMonitor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitor_makefile) : $(GaudiMonitorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitor.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitor.in -tag=$(tags) $(GaudiMonitor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitor_makefile) GaudiMonitor
else
$(cmt_local_GaudiMonitor_makefile) : $(GaudiMonitorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitor) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitor) ] || \
	  $(not_GaudiMonitorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitor.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitor.in -tag=$(tags) $(GaudiMonitor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitor_makefile) GaudiMonitor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitor_makefile) GaudiMonitor

GaudiMonitor :: GaudiMonitorcompile GaudiMonitorinstall ;

ifdef cmt_GaudiMonitor_has_prototypes

GaudiMonitorprototype : $(GaudiMonitorprototype_dependencies) $(cmt_local_GaudiMonitor_makefile) dirs GaudiMonitordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiMonitorcompile : GaudiMonitorprototype

endif

GaudiMonitorcompile : $(GaudiMonitorcompile_dependencies) $(cmt_local_GaudiMonitor_makefile) dirs GaudiMonitordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiMonitorclean ;

GaudiMonitorclean :: $(GaudiMonitorclean_dependencies) ##$(cmt_local_GaudiMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitor_makefile) GaudiMonitorclean

##	  /bin/rm -f $(cmt_local_GaudiMonitor_makefile) $(bin)GaudiMonitor_dependencies.make

install :: GaudiMonitorinstall ;

GaudiMonitorinstall :: GaudiMonitorcompile $(GaudiMonitor_dependencies) $(cmt_local_GaudiMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitoruninstall

$(foreach d,$(GaudiMonitor_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitoruninstall))

GaudiMonitoruninstall : $(GaudiMonitoruninstall_dependencies) ##$(cmt_local_GaudiMonitor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitor_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiMonitorComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMonitorComponentsList_has_target_tag

cmt_local_tagfile_GaudiMonitorComponentsList = $(bin)$(GaudiMonitor_tag)_GaudiMonitorComponentsList.make
cmt_final_setup_GaudiMonitorComponentsList = $(bin)setup_GaudiMonitorComponentsList.make
cmt_local_GaudiMonitorComponentsList_makefile = $(bin)GaudiMonitorComponentsList.make

GaudiMonitorComponentsList_extratags = -tag_add=target_GaudiMonitorComponentsList

else

cmt_local_tagfile_GaudiMonitorComponentsList = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitorComponentsList = $(bin)setup.make
cmt_local_GaudiMonitorComponentsList_makefile = $(bin)GaudiMonitorComponentsList.make

endif

not_GaudiMonitorComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitorComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitorComponentsListdirs :
	@if test ! -d $(bin)GaudiMonitorComponentsList; then $(mkdir) -p $(bin)GaudiMonitorComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitorComponentsList
else
GaudiMonitorComponentsListdirs : ;
endif

ifdef cmt_GaudiMonitorComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitorComponentsList_makefile) : $(GaudiMonitorComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList
else
$(cmt_local_GaudiMonitorComponentsList_makefile) : $(GaudiMonitorComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorComponentsList) ] || \
	  $(not_GaudiMonitorComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitorComponentsList_makefile) : $(GaudiMonitorComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorComponentsList.in -tag=$(tags) $(GaudiMonitorComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList
else
$(cmt_local_GaudiMonitorComponentsList_makefile) : $(GaudiMonitorComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitorComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorComponentsList) ] || \
	  $(not_GaudiMonitorComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorComponentsList.in -tag=$(tags) $(GaudiMonitorComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitorComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList

GaudiMonitorComponentsList :: $(GaudiMonitorComponentsList_dependencies) $(cmt_local_GaudiMonitorComponentsList_makefile) dirs GaudiMonitorComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiMonitorComponentsList"
	@if test -f $(cmt_local_GaudiMonitorComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsList
	$(echo) "(constituents.make) GaudiMonitorComponentsList done"

clean :: GaudiMonitorComponentsListclean ;

GaudiMonitorComponentsListclean :: $(GaudiMonitorComponentsListclean_dependencies) ##$(cmt_local_GaudiMonitorComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiMonitorComponentsListclean"
	@-if test -f $(cmt_local_GaudiMonitorComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiMonitorComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) GaudiMonitorComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiMonitorComponentsList_makefile) $(bin)GaudiMonitorComponentsList_dependencies.make

install :: GaudiMonitorComponentsListinstall ;

GaudiMonitorComponentsListinstall :: $(GaudiMonitorComponentsList_dependencies) $(cmt_local_GaudiMonitorComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitorComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitorComponentsListuninstall

$(foreach d,$(GaudiMonitorComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitorComponentsListuninstall))

GaudiMonitorComponentsListuninstall : $(GaudiMonitorComponentsListuninstall_dependencies) ##$(cmt_local_GaudiMonitorComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitorComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitorComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitorComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitorComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMonitorMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMonitorMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(bin)$(GaudiMonitor_tag)_GaudiMonitorMergeComponentsList.make
cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)setup_GaudiMonitorMergeComponentsList.make
cmt_local_GaudiMonitorMergeComponentsList_makefile = $(bin)GaudiMonitorMergeComponentsList.make

GaudiMonitorMergeComponentsList_extratags = -tag_add=target_GaudiMonitorMergeComponentsList

else

cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)setup.make
cmt_local_GaudiMonitorMergeComponentsList_makefile = $(bin)GaudiMonitorMergeComponentsList.make

endif

not_GaudiMonitorMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitorMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitorMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiMonitorMergeComponentsList; then $(mkdir) -p $(bin)GaudiMonitorMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitorMergeComponentsList
else
GaudiMonitorMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiMonitorMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitorMergeComponentsList_makefile) : $(GaudiMonitorMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList
else
$(cmt_local_GaudiMonitorMergeComponentsList_makefile) : $(GaudiMonitorMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorMergeComponentsList) ] || \
	  $(not_GaudiMonitorMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitorMergeComponentsList_makefile) : $(GaudiMonitorMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorMergeComponentsList.in -tag=$(tags) $(GaudiMonitorMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList
else
$(cmt_local_GaudiMonitorMergeComponentsList_makefile) : $(GaudiMonitorMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitorMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorMergeComponentsList) ] || \
	  $(not_GaudiMonitorMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorMergeComponentsList.in -tag=$(tags) $(GaudiMonitorMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitorMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList

GaudiMonitorMergeComponentsList :: $(GaudiMonitorMergeComponentsList_dependencies) $(cmt_local_GaudiMonitorMergeComponentsList_makefile) dirs GaudiMonitorMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiMonitorMergeComponentsList"
	@if test -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsList
	$(echo) "(constituents.make) GaudiMonitorMergeComponentsList done"

clean :: GaudiMonitorMergeComponentsListclean ;

GaudiMonitorMergeComponentsListclean :: $(GaudiMonitorMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiMonitorMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiMonitorMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiMonitorMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) GaudiMonitorMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) $(bin)GaudiMonitorMergeComponentsList_dependencies.make

install :: GaudiMonitorMergeComponentsListinstall ;

GaudiMonitorMergeComponentsListinstall :: $(GaudiMonitorMergeComponentsList_dependencies) $(cmt_local_GaudiMonitorMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitorMergeComponentsListuninstall

$(foreach d,$(GaudiMonitorMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitorMergeComponentsListuninstall))

GaudiMonitorMergeComponentsListuninstall : $(GaudiMonitorMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiMonitorMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitorMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitorMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitorMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMonitorConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMonitorConf_has_target_tag

cmt_local_tagfile_GaudiMonitorConf = $(bin)$(GaudiMonitor_tag)_GaudiMonitorConf.make
cmt_final_setup_GaudiMonitorConf = $(bin)setup_GaudiMonitorConf.make
cmt_local_GaudiMonitorConf_makefile = $(bin)GaudiMonitorConf.make

GaudiMonitorConf_extratags = -tag_add=target_GaudiMonitorConf

else

cmt_local_tagfile_GaudiMonitorConf = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitorConf = $(bin)setup.make
cmt_local_GaudiMonitorConf_makefile = $(bin)GaudiMonitorConf.make

endif

not_GaudiMonitorConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitorConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitorConfdirs :
	@if test ! -d $(bin)GaudiMonitorConf; then $(mkdir) -p $(bin)GaudiMonitorConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitorConf
else
GaudiMonitorConfdirs : ;
endif

ifdef cmt_GaudiMonitorConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitorConf_makefile) : $(GaudiMonitorConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConf_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf
else
$(cmt_local_GaudiMonitorConf_makefile) : $(GaudiMonitorConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorConf) ] || \
	  $(not_GaudiMonitorConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConf_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitorConf_makefile) : $(GaudiMonitorConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorConf.in -tag=$(tags) $(GaudiMonitorConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf
else
$(cmt_local_GaudiMonitorConf_makefile) : $(GaudiMonitorConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitorConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorConf) ] || \
	  $(not_GaudiMonitorConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorConf.in -tag=$(tags) $(GaudiMonitorConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf

GaudiMonitorConf :: $(GaudiMonitorConf_dependencies) $(cmt_local_GaudiMonitorConf_makefile) dirs GaudiMonitorConfdirs
	$(echo) "(constituents.make) Starting GaudiMonitorConf"
	@if test -f $(cmt_local_GaudiMonitorConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConf
	$(echo) "(constituents.make) GaudiMonitorConf done"

clean :: GaudiMonitorConfclean ;

GaudiMonitorConfclean :: $(GaudiMonitorConfclean_dependencies) ##$(cmt_local_GaudiMonitorConf_makefile)
	$(echo) "(constituents.make) Starting GaudiMonitorConfclean"
	@-if test -f $(cmt_local_GaudiMonitorConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConfclean; \
	fi
	$(echo) "(constituents.make) GaudiMonitorConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) GaudiMonitorConfclean

##	  /bin/rm -f $(cmt_local_GaudiMonitorConf_makefile) $(bin)GaudiMonitorConf_dependencies.make

install :: GaudiMonitorConfinstall ;

GaudiMonitorConfinstall :: $(GaudiMonitorConf_dependencies) $(cmt_local_GaudiMonitorConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitorConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitorConfuninstall

$(foreach d,$(GaudiMonitorConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitorConfuninstall))

GaudiMonitorConfuninstall : $(GaudiMonitorConfuninstall_dependencies) ##$(cmt_local_GaudiMonitorConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitorConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitorConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitorConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitorConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMonitor_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMonitor_python_init_has_target_tag

cmt_local_tagfile_GaudiMonitor_python_init = $(bin)$(GaudiMonitor_tag)_GaudiMonitor_python_init.make
cmt_final_setup_GaudiMonitor_python_init = $(bin)setup_GaudiMonitor_python_init.make
cmt_local_GaudiMonitor_python_init_makefile = $(bin)GaudiMonitor_python_init.make

GaudiMonitor_python_init_extratags = -tag_add=target_GaudiMonitor_python_init

else

cmt_local_tagfile_GaudiMonitor_python_init = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitor_python_init = $(bin)setup.make
cmt_local_GaudiMonitor_python_init_makefile = $(bin)GaudiMonitor_python_init.make

endif

not_GaudiMonitor_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitor_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitor_python_initdirs :
	@if test ! -d $(bin)GaudiMonitor_python_init; then $(mkdir) -p $(bin)GaudiMonitor_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitor_python_init
else
GaudiMonitor_python_initdirs : ;
endif

ifdef cmt_GaudiMonitor_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitor_python_init_makefile) : $(GaudiMonitor_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitor_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init
else
$(cmt_local_GaudiMonitor_python_init_makefile) : $(GaudiMonitor_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitor_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitor_python_init) ] || \
	  $(not_GaudiMonitor_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitor_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitor_python_init_makefile) : $(GaudiMonitor_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitor_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitor_python_init.in -tag=$(tags) $(GaudiMonitor_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init
else
$(cmt_local_GaudiMonitor_python_init_makefile) : $(GaudiMonitor_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitor_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitor_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitor_python_init) ] || \
	  $(not_GaudiMonitor_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitor_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitor_python_init.in -tag=$(tags) $(GaudiMonitor_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitor_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init

GaudiMonitor_python_init :: $(GaudiMonitor_python_init_dependencies) $(cmt_local_GaudiMonitor_python_init_makefile) dirs GaudiMonitor_python_initdirs
	$(echo) "(constituents.make) Starting GaudiMonitor_python_init"
	@if test -f $(cmt_local_GaudiMonitor_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_init
	$(echo) "(constituents.make) GaudiMonitor_python_init done"

clean :: GaudiMonitor_python_initclean ;

GaudiMonitor_python_initclean :: $(GaudiMonitor_python_initclean_dependencies) ##$(cmt_local_GaudiMonitor_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiMonitor_python_initclean"
	@-if test -f $(cmt_local_GaudiMonitor_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiMonitor_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) GaudiMonitor_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiMonitor_python_init_makefile) $(bin)GaudiMonitor_python_init_dependencies.make

install :: GaudiMonitor_python_initinstall ;

GaudiMonitor_python_initinstall :: $(GaudiMonitor_python_init_dependencies) $(cmt_local_GaudiMonitor_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitor_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitor_python_inituninstall

$(foreach d,$(GaudiMonitor_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitor_python_inituninstall))

GaudiMonitor_python_inituninstall : $(GaudiMonitor_python_inituninstall_dependencies) ##$(cmt_local_GaudiMonitor_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitor_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitor_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitor_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitor_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitor_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiMonitor_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiMonitor_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiMonitor_python_modules = $(bin)$(GaudiMonitor_tag)_zip_GaudiMonitor_python_modules.make
cmt_final_setup_zip_GaudiMonitor_python_modules = $(bin)setup_zip_GaudiMonitor_python_modules.make
cmt_local_zip_GaudiMonitor_python_modules_makefile = $(bin)zip_GaudiMonitor_python_modules.make

zip_GaudiMonitor_python_modules_extratags = -tag_add=target_zip_GaudiMonitor_python_modules

else

cmt_local_tagfile_zip_GaudiMonitor_python_modules = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_zip_GaudiMonitor_python_modules = $(bin)setup.make
cmt_local_zip_GaudiMonitor_python_modules_makefile = $(bin)zip_GaudiMonitor_python_modules.make

endif

not_zip_GaudiMonitor_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiMonitor_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiMonitor_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiMonitor_python_modules; then $(mkdir) -p $(bin)zip_GaudiMonitor_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiMonitor_python_modules
else
zip_GaudiMonitor_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiMonitor_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiMonitor_python_modules_makefile) : $(zip_GaudiMonitor_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiMonitor_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiMonitor_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules
else
$(cmt_local_zip_GaudiMonitor_python_modules_makefile) : $(zip_GaudiMonitor_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiMonitor_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiMonitor_python_modules) ] || \
	  $(not_zip_GaudiMonitor_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiMonitor_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiMonitor_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiMonitor_python_modules_makefile) : $(zip_GaudiMonitor_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiMonitor_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiMonitor_python_modules.in -tag=$(tags) $(zip_GaudiMonitor_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules
else
$(cmt_local_zip_GaudiMonitor_python_modules_makefile) : $(zip_GaudiMonitor_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiMonitor_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiMonitor_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiMonitor_python_modules) ] || \
	  $(not_zip_GaudiMonitor_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiMonitor_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiMonitor_python_modules.in -tag=$(tags) $(zip_GaudiMonitor_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiMonitor_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules

zip_GaudiMonitor_python_modules :: $(zip_GaudiMonitor_python_modules_dependencies) $(cmt_local_zip_GaudiMonitor_python_modules_makefile) dirs zip_GaudiMonitor_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiMonitor_python_modules"
	@if test -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modules
	$(echo) "(constituents.make) zip_GaudiMonitor_python_modules done"

clean :: zip_GaudiMonitor_python_modulesclean ;

zip_GaudiMonitor_python_modulesclean :: $(zip_GaudiMonitor_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiMonitor_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiMonitor_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiMonitor_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) zip_GaudiMonitor_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) $(bin)zip_GaudiMonitor_python_modules_dependencies.make

install :: zip_GaudiMonitor_python_modulesinstall ;

zip_GaudiMonitor_python_modulesinstall :: $(zip_GaudiMonitor_python_modules_dependencies) $(cmt_local_zip_GaudiMonitor_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiMonitor_python_modulesuninstall

$(foreach d,$(zip_GaudiMonitor_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiMonitor_python_modulesuninstall))

zip_GaudiMonitor_python_modulesuninstall : $(zip_GaudiMonitor_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiMonitor_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiMonitor_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiMonitor_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiMonitor_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiMonitor_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMonitorConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMonitorConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiMonitorConfDbMerge = $(bin)$(GaudiMonitor_tag)_GaudiMonitorConfDbMerge.make
cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)setup_GaudiMonitorConfDbMerge.make
cmt_local_GaudiMonitorConfDbMerge_makefile = $(bin)GaudiMonitorConfDbMerge.make

GaudiMonitorConfDbMerge_extratags = -tag_add=target_GaudiMonitorConfDbMerge

else

cmt_local_tagfile_GaudiMonitorConfDbMerge = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)setup.make
cmt_local_GaudiMonitorConfDbMerge_makefile = $(bin)GaudiMonitorConfDbMerge.make

endif

not_GaudiMonitorConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMonitorConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMonitorConfDbMergedirs :
	@if test ! -d $(bin)GaudiMonitorConfDbMerge; then $(mkdir) -p $(bin)GaudiMonitorConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMonitorConfDbMerge
else
GaudiMonitorConfDbMergedirs : ;
endif

ifdef cmt_GaudiMonitorConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMonitorConfDbMerge_makefile) : $(GaudiMonitorConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge
else
$(cmt_local_GaudiMonitorConfDbMerge_makefile) : $(GaudiMonitorConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorConfDbMerge) ] || \
	  $(not_GaudiMonitorConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMonitorConfDbMerge_makefile) : $(GaudiMonitorConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMonitorConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorConfDbMerge.in -tag=$(tags) $(GaudiMonitorConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge
else
$(cmt_local_GaudiMonitorConfDbMerge_makefile) : $(GaudiMonitorConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMonitorConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMonitorConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMonitorConfDbMerge) ] || \
	  $(not_GaudiMonitorConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMonitorConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMonitorConfDbMerge.in -tag=$(tags) $(GaudiMonitorConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMonitorConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge

GaudiMonitorConfDbMerge :: $(GaudiMonitorConfDbMerge_dependencies) $(cmt_local_GaudiMonitorConfDbMerge_makefile) dirs GaudiMonitorConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiMonitorConfDbMerge"
	@if test -f $(cmt_local_GaudiMonitorConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMerge
	$(echo) "(constituents.make) GaudiMonitorConfDbMerge done"

clean :: GaudiMonitorConfDbMergeclean ;

GaudiMonitorConfDbMergeclean :: $(GaudiMonitorConfDbMergeclean_dependencies) ##$(cmt_local_GaudiMonitorConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiMonitorConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiMonitorConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiMonitorConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) GaudiMonitorConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) $(bin)GaudiMonitorConfDbMerge_dependencies.make

install :: GaudiMonitorConfDbMergeinstall ;

GaudiMonitorConfDbMergeinstall :: $(GaudiMonitorConfDbMerge_dependencies) $(cmt_local_GaudiMonitorConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMonitorConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMonitorConfDbMergeuninstall

$(foreach d,$(GaudiMonitorConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiMonitorConfDbMergeuninstall))

GaudiMonitorConfDbMergeuninstall : $(GaudiMonitorConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiMonitorConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMonitorConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMonitorConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMonitorConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMonitorConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMonitorConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiMonitor_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiMonitor_tag).make
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

cmt_CompilePython_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CompilePython_has_target_tag

cmt_local_tagfile_CompilePython = $(bin)$(GaudiMonitor_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_CompilePython = $(bin)setup.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

endif

not_CompilePython_dependencies = { n=0; for p in $?; do m=0; for d in $(CompilePython_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
CompilePythondirs :
	@if test ! -d $(bin)CompilePython; then $(mkdir) -p $(bin)CompilePython; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)CompilePython
else
CompilePythondirs : ;
endif

ifdef cmt_CompilePython_has_target_tag

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_config -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) build_library_links
	$(echo) "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython
else
$(cmt_local_CompilePython_makefile) : $(CompilePython_dependencies) $(cmt_build_library_linksstamp) $(bin)CompilePython.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_CompilePython) ] || \
	  [ ! -f $(cmt_final_setup_CompilePython) ] || \
	  $(not_CompilePython_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building CompilePython.make"; \
	  $(cmtexe) -f=$(bin)CompilePython.in -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(CompilePython_extratags) build constituent_makefile -out=$(cmt_local_CompilePython_makefile) CompilePython

CompilePython :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile) dirs CompilePythondirs
	$(echo) "(constituents.make) Starting CompilePython"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePython
	$(echo) "(constituents.make) CompilePython done"

clean :: CompilePythonclean ;

CompilePythonclean :: $(CompilePythonclean_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting CompilePythonclean"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean; \
	fi
	$(echo) "(constituents.make) CompilePythonclean done"
#	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) CompilePythonclean

##	  /bin/rm -f $(cmt_local_CompilePython_makefile) $(bin)CompilePython_dependencies.make

install :: CompilePythoninstall ;

CompilePythoninstall :: $(CompilePython_dependencies) $(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_CompilePython_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : CompilePythonuninstall

$(foreach d,$(CompilePython_dependencies),$(eval $(d)uninstall_dependencies += CompilePythonuninstall))

CompilePythonuninstall : $(CompilePythonuninstall_dependencies) ##$(cmt_local_CompilePython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_CompilePython_makefile); then \
	  $(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_CompilePython_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: CompilePythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ CompilePython"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ CompilePython done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_run_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_qmtest_run_has_target_tag

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiMonitor_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_qmtest_run = $(bin)setup.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

endif

not_qmtest_run_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_run_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_rundirs :
	@if test ! -d $(bin)qmtest_run; then $(mkdir) -p $(bin)qmtest_run; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_run
else
qmtest_rundirs : ;
endif

ifdef cmt_qmtest_run_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_config -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run
else
$(cmt_local_qmtest_run_makefile) : $(qmtest_run_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_run.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_run) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_run) ] || \
	  $(not_qmtest_run_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_run.make"; \
	  $(cmtexe) -f=$(bin)qmtest_run.in -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_run_extratags) build constituent_makefile -out=$(cmt_local_qmtest_run_makefile) qmtest_run

qmtest_run :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile) dirs qmtest_rundirs
	$(echo) "(constituents.make) Starting qmtest_run"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_run
	$(echo) "(constituents.make) qmtest_run done"

clean :: qmtest_runclean ;

qmtest_runclean :: $(qmtest_runclean_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting qmtest_runclean"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean; \
	fi
	$(echo) "(constituents.make) qmtest_runclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) qmtest_runclean

##	  /bin/rm -f $(cmt_local_qmtest_run_makefile) $(bin)qmtest_run_dependencies.make

install :: qmtest_runinstall ;

qmtest_runinstall :: $(qmtest_run_dependencies) $(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_qmtest_run_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : qmtest_rununinstall

$(foreach d,$(qmtest_run_dependencies),$(eval $(d)uninstall_dependencies += qmtest_rununinstall))

qmtest_rununinstall : $(qmtest_rununinstall_dependencies) ##$(cmt_local_qmtest_run_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_qmtest_run_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_run_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: qmtest_rununinstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_run"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_run done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_qmtest_summarize_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_qmtest_summarize_has_target_tag

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiMonitor_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_qmtest_summarize = $(bin)setup.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

endif

not_qmtest_summarize_dependencies = { n=0; for p in $?; do m=0; for d in $(qmtest_summarize_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
qmtest_summarizedirs :
	@if test ! -d $(bin)qmtest_summarize; then $(mkdir) -p $(bin)qmtest_summarize; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)qmtest_summarize
else
qmtest_summarizedirs : ;
endif

ifdef cmt_qmtest_summarize_has_target_tag

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_config -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) build_library_links
	$(echo) "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize
else
$(cmt_local_qmtest_summarize_makefile) : $(qmtest_summarize_dependencies) $(cmt_build_library_linksstamp) $(bin)qmtest_summarize.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_qmtest_summarize) ] || \
	  [ ! -f $(cmt_final_setup_qmtest_summarize) ] || \
	  $(not_qmtest_summarize_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building qmtest_summarize.make"; \
	  $(cmtexe) -f=$(bin)qmtest_summarize.in -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(qmtest_summarize_extratags) build constituent_makefile -out=$(cmt_local_qmtest_summarize_makefile) qmtest_summarize

qmtest_summarize :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile) dirs qmtest_summarizedirs
	$(echo) "(constituents.make) Starting qmtest_summarize"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarize
	$(echo) "(constituents.make) qmtest_summarize done"

clean :: qmtest_summarizeclean ;

qmtest_summarizeclean :: $(qmtest_summarizeclean_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting qmtest_summarizeclean"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean; \
	fi
	$(echo) "(constituents.make) qmtest_summarizeclean done"
#	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) qmtest_summarizeclean

##	  /bin/rm -f $(cmt_local_qmtest_summarize_makefile) $(bin)qmtest_summarize_dependencies.make

install :: qmtest_summarizeinstall ;

qmtest_summarizeinstall :: $(qmtest_summarize_dependencies) $(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : qmtest_summarizeuninstall

$(foreach d,$(qmtest_summarize_dependencies),$(eval $(d)uninstall_dependencies += qmtest_summarizeuninstall))

qmtest_summarizeuninstall : $(qmtest_summarizeuninstall_dependencies) ##$(cmt_local_qmtest_summarize_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_qmtest_summarize_makefile); then \
	  $(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_qmtest_summarize_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: qmtest_summarizeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ qmtest_summarize"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ qmtest_summarize done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestPackage_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_TestPackage_has_target_tag

cmt_local_tagfile_TestPackage = $(bin)$(GaudiMonitor_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_TestPackage = $(bin)setup.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

endif

not_TestPackage_dependencies = { n=0; for p in $?; do m=0; for d in $(TestPackage_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestPackagedirs :
	@if test ! -d $(bin)TestPackage; then $(mkdir) -p $(bin)TestPackage; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestPackage
else
TestPackagedirs : ;
endif

ifdef cmt_TestPackage_has_target_tag

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_config -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage
else
$(cmt_local_TestPackage_makefile) : $(TestPackage_dependencies) $(cmt_build_library_linksstamp) $(bin)TestPackage.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestPackage) ] || \
	  [ ! -f $(cmt_final_setup_TestPackage) ] || \
	  $(not_TestPackage_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestPackage.make"; \
	  $(cmtexe) -f=$(bin)TestPackage.in -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestPackage_extratags) build constituent_makefile -out=$(cmt_local_TestPackage_makefile) TestPackage

TestPackage :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile) dirs TestPackagedirs
	$(echo) "(constituents.make) Starting TestPackage"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackage
	$(echo) "(constituents.make) TestPackage done"

clean :: TestPackageclean ;

TestPackageclean :: $(TestPackageclean_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting TestPackageclean"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean; \
	fi
	$(echo) "(constituents.make) TestPackageclean done"
#	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) TestPackageclean

##	  /bin/rm -f $(cmt_local_TestPackage_makefile) $(bin)TestPackage_dependencies.make

install :: TestPackageinstall ;

TestPackageinstall :: $(TestPackage_dependencies) $(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_TestPackage_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : TestPackageuninstall

$(foreach d,$(TestPackage_dependencies),$(eval $(d)uninstall_dependencies += TestPackageuninstall))

TestPackageuninstall : $(TestPackageuninstall_dependencies) ##$(cmt_local_TestPackage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_TestPackage_makefile); then \
	  $(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestPackage_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: TestPackageuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestPackage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestPackage done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_TestProject_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_TestProject_has_target_tag

cmt_local_tagfile_TestProject = $(bin)$(GaudiMonitor_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_TestProject = $(bin)setup.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

endif

not_TestProject_dependencies = { n=0; for p in $?; do m=0; for d in $(TestProject_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
TestProjectdirs :
	@if test ! -d $(bin)TestProject; then $(mkdir) -p $(bin)TestProject; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)TestProject
else
TestProjectdirs : ;
endif

ifdef cmt_TestProject_has_target_tag

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_config -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) build_library_links
	$(echo) "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject
else
$(cmt_local_TestProject_makefile) : $(TestProject_dependencies) $(cmt_build_library_linksstamp) $(bin)TestProject.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_TestProject) ] || \
	  [ ! -f $(cmt_final_setup_TestProject) ] || \
	  $(not_TestProject_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building TestProject.make"; \
	  $(cmtexe) -f=$(bin)TestProject.in -tag=$(tags) $(TestProject_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_TestProject_makefile) TestProject; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(TestProject_extratags) build constituent_makefile -out=$(cmt_local_TestProject_makefile) TestProject

TestProject :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile) dirs TestProjectdirs
	$(echo) "(constituents.make) Starting TestProject"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProject; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) TestProject
	$(echo) "(constituents.make) TestProject done"

clean :: TestProjectclean ;

TestProjectclean :: $(TestProjectclean_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting TestProjectclean"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean; \
	fi
	$(echo) "(constituents.make) TestProjectclean done"
#	@-$(MAKE) -f $(cmt_local_TestProject_makefile) TestProjectclean

##	  /bin/rm -f $(cmt_local_TestProject_makefile) $(bin)TestProject_dependencies.make

install :: TestProjectinstall ;

TestProjectinstall :: $(TestProject_dependencies) $(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_TestProject_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : TestProjectuninstall

$(foreach d,$(TestProject_dependencies),$(eval $(d)uninstall_dependencies += TestProjectuninstall))

TestProjectuninstall : $(TestProjectuninstall_dependencies) ##$(cmt_local_TestProject_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_TestProject_makefile); then \
	  $(MAKE) -f $(cmt_local_TestProject_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_TestProject_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: TestProjectuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ TestProject"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ TestProject done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_new_rootsys_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_new_rootsys_has_target_tag

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiMonitor_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiMonitor_tag).make
cmt_final_setup_new_rootsys = $(bin)setup.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

endif

not_new_rootsys_dependencies = { n=0; for p in $?; do m=0; for d in $(new_rootsys_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
new_rootsysdirs :
	@if test ! -d $(bin)new_rootsys; then $(mkdir) -p $(bin)new_rootsys; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)new_rootsys
else
new_rootsysdirs : ;
endif

ifdef cmt_new_rootsys_has_target_tag

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_config -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) build_library_links
	$(echo) "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys
else
$(cmt_local_new_rootsys_makefile) : $(new_rootsys_dependencies) $(cmt_build_library_linksstamp) $(bin)new_rootsys.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_new_rootsys) ] || \
	  [ ! -f $(cmt_final_setup_new_rootsys) ] || \
	  $(not_new_rootsys_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building new_rootsys.make"; \
	  $(cmtexe) -f=$(bin)new_rootsys.in -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(new_rootsys_extratags) build constituent_makefile -out=$(cmt_local_new_rootsys_makefile) new_rootsys

new_rootsys :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile) dirs new_rootsysdirs
	$(echo) "(constituents.make) Starting new_rootsys"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsys
	$(echo) "(constituents.make) new_rootsys done"

clean :: new_rootsysclean ;

new_rootsysclean :: $(new_rootsysclean_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting new_rootsysclean"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean; \
	fi
	$(echo) "(constituents.make) new_rootsysclean done"
#	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) new_rootsysclean

##	  /bin/rm -f $(cmt_local_new_rootsys_makefile) $(bin)new_rootsys_dependencies.make

install :: new_rootsysinstall ;

new_rootsysinstall :: $(new_rootsys_dependencies) $(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_new_rootsys_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : new_rootsysuninstall

$(foreach d,$(new_rootsys_dependencies),$(eval $(d)uninstall_dependencies += new_rootsysuninstall))

new_rootsysuninstall : $(new_rootsysuninstall_dependencies) ##$(cmt_local_new_rootsys_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_new_rootsys_makefile); then \
	  $(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_new_rootsys_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: new_rootsysuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ new_rootsys"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ new_rootsys done"
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
