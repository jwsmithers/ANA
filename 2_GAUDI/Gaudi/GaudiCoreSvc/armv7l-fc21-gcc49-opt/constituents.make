
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile = $(GaudiCoreSvc_tag).make
cmt_local_tagfile = $(bin)$(GaudiCoreSvc_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make
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

cmt_GaudiCoreSvc_has_no_target_tag = 1
cmt_GaudiCoreSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvc_has_target_tag

cmt_local_tagfile_GaudiCoreSvc = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvc.make
cmt_final_setup_GaudiCoreSvc = $(bin)setup_GaudiCoreSvc.make
cmt_local_GaudiCoreSvc_makefile = $(bin)GaudiCoreSvc.make

GaudiCoreSvc_extratags = -tag_add=target_GaudiCoreSvc

else

cmt_local_tagfile_GaudiCoreSvc = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvc = $(bin)setup.make
cmt_local_GaudiCoreSvc_makefile = $(bin)GaudiCoreSvc.make

endif

not_GaudiCoreSvccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvcdirs :
	@if test ! -d $(bin)GaudiCoreSvc; then $(mkdir) -p $(bin)GaudiCoreSvc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvc
else
GaudiCoreSvcdirs : ;
endif

ifdef cmt_GaudiCoreSvc_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvc_makefile) : $(GaudiCoreSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvc
else
$(cmt_local_GaudiCoreSvc_makefile) : $(GaudiCoreSvccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvc) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvc) ] || \
	  $(not_GaudiCoreSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvc_makefile) : $(GaudiCoreSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvc.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvc.in -tag=$(tags) $(GaudiCoreSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvc
else
$(cmt_local_GaudiCoreSvc_makefile) : $(GaudiCoreSvccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvc) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvc) ] || \
	  $(not_GaudiCoreSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvc.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvc.in -tag=$(tags) $(GaudiCoreSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvc

GaudiCoreSvc :: GaudiCoreSvccompile GaudiCoreSvcinstall ;

ifdef cmt_GaudiCoreSvc_has_prototypes

GaudiCoreSvcprototype : $(GaudiCoreSvcprototype_dependencies) $(cmt_local_GaudiCoreSvc_makefile) dirs GaudiCoreSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiCoreSvccompile : GaudiCoreSvcprototype

endif

GaudiCoreSvccompile : $(GaudiCoreSvccompile_dependencies) $(cmt_local_GaudiCoreSvc_makefile) dirs GaudiCoreSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiCoreSvcclean ;

GaudiCoreSvcclean :: $(GaudiCoreSvcclean_dependencies) ##$(cmt_local_GaudiCoreSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) GaudiCoreSvcclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvc_makefile) $(bin)GaudiCoreSvc_dependencies.make

install :: GaudiCoreSvcinstall ;

GaudiCoreSvcinstall :: GaudiCoreSvccompile $(GaudiCoreSvc_dependencies) $(cmt_local_GaudiCoreSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvcuninstall

$(foreach d,$(GaudiCoreSvc_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvcuninstall))

GaudiCoreSvcuninstall : $(GaudiCoreSvcuninstall_dependencies) ##$(cmt_local_GaudiCoreSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvc done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiCoreSvcComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvcComponentsList_has_target_tag

cmt_local_tagfile_GaudiCoreSvcComponentsList = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcComponentsList.make
cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)setup_GaudiCoreSvcComponentsList.make
cmt_local_GaudiCoreSvcComponentsList_makefile = $(bin)GaudiCoreSvcComponentsList.make

GaudiCoreSvcComponentsList_extratags = -tag_add=target_GaudiCoreSvcComponentsList

else

cmt_local_tagfile_GaudiCoreSvcComponentsList = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)setup.make
cmt_local_GaudiCoreSvcComponentsList_makefile = $(bin)GaudiCoreSvcComponentsList.make

endif

not_GaudiCoreSvcComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvcComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvcComponentsListdirs :
	@if test ! -d $(bin)GaudiCoreSvcComponentsList; then $(mkdir) -p $(bin)GaudiCoreSvcComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvcComponentsList
else
GaudiCoreSvcComponentsListdirs : ;
endif

ifdef cmt_GaudiCoreSvcComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvcComponentsList_makefile) : $(GaudiCoreSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList
else
$(cmt_local_GaudiCoreSvcComponentsList_makefile) : $(GaudiCoreSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcComponentsList) ] || \
	  $(not_GaudiCoreSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvcComponentsList_makefile) : $(GaudiCoreSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcComponentsList.in -tag=$(tags) $(GaudiCoreSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList
else
$(cmt_local_GaudiCoreSvcComponentsList_makefile) : $(GaudiCoreSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvcComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcComponentsList) ] || \
	  $(not_GaudiCoreSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcComponentsList.in -tag=$(tags) $(GaudiCoreSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList

GaudiCoreSvcComponentsList :: $(GaudiCoreSvcComponentsList_dependencies) $(cmt_local_GaudiCoreSvcComponentsList_makefile) dirs GaudiCoreSvcComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiCoreSvcComponentsList"
	@if test -f $(cmt_local_GaudiCoreSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsList
	$(echo) "(constituents.make) GaudiCoreSvcComponentsList done"

clean :: GaudiCoreSvcComponentsListclean ;

GaudiCoreSvcComponentsListclean :: $(GaudiCoreSvcComponentsListclean_dependencies) ##$(cmt_local_GaudiCoreSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiCoreSvcComponentsListclean"
	@-if test -f $(cmt_local_GaudiCoreSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiCoreSvcComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) GaudiCoreSvcComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) $(bin)GaudiCoreSvcComponentsList_dependencies.make

install :: GaudiCoreSvcComponentsListinstall ;

GaudiCoreSvcComponentsListinstall :: $(GaudiCoreSvcComponentsList_dependencies) $(cmt_local_GaudiCoreSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvcComponentsListuninstall

$(foreach d,$(GaudiCoreSvcComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvcComponentsListuninstall))

GaudiCoreSvcComponentsListuninstall : $(GaudiCoreSvcComponentsListuninstall_dependencies) ##$(cmt_local_GaudiCoreSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvcComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvcComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvcComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiCoreSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvcMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcMergeComponentsList.make
cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)setup_GaudiCoreSvcMergeComponentsList.make
cmt_local_GaudiCoreSvcMergeComponentsList_makefile = $(bin)GaudiCoreSvcMergeComponentsList.make

GaudiCoreSvcMergeComponentsList_extratags = -tag_add=target_GaudiCoreSvcMergeComponentsList

else

cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)setup.make
cmt_local_GaudiCoreSvcMergeComponentsList_makefile = $(bin)GaudiCoreSvcMergeComponentsList.make

endif

not_GaudiCoreSvcMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvcMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvcMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiCoreSvcMergeComponentsList; then $(mkdir) -p $(bin)GaudiCoreSvcMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvcMergeComponentsList
else
GaudiCoreSvcMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiCoreSvcMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) : $(GaudiCoreSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList
else
$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) : $(GaudiCoreSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcMergeComponentsList) ] || \
	  $(not_GaudiCoreSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) : $(GaudiCoreSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcMergeComponentsList.in -tag=$(tags) $(GaudiCoreSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList
else
$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) : $(GaudiCoreSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvcMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcMergeComponentsList) ] || \
	  $(not_GaudiCoreSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcMergeComponentsList.in -tag=$(tags) $(GaudiCoreSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList

GaudiCoreSvcMergeComponentsList :: $(GaudiCoreSvcMergeComponentsList_dependencies) $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) dirs GaudiCoreSvcMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiCoreSvcMergeComponentsList"
	@if test -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsList
	$(echo) "(constituents.make) GaudiCoreSvcMergeComponentsList done"

clean :: GaudiCoreSvcMergeComponentsListclean ;

GaudiCoreSvcMergeComponentsListclean :: $(GaudiCoreSvcMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiCoreSvcMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiCoreSvcMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) GaudiCoreSvcMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) $(bin)GaudiCoreSvcMergeComponentsList_dependencies.make

install :: GaudiCoreSvcMergeComponentsListinstall ;

GaudiCoreSvcMergeComponentsListinstall :: $(GaudiCoreSvcMergeComponentsList_dependencies) $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvcMergeComponentsListuninstall

$(foreach d,$(GaudiCoreSvcMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvcMergeComponentsListuninstall))

GaudiCoreSvcMergeComponentsListuninstall : $(GaudiCoreSvcMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiCoreSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvcMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvcMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvcMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiCoreSvcConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvcConf_has_target_tag

cmt_local_tagfile_GaudiCoreSvcConf = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcConf.make
cmt_final_setup_GaudiCoreSvcConf = $(bin)setup_GaudiCoreSvcConf.make
cmt_local_GaudiCoreSvcConf_makefile = $(bin)GaudiCoreSvcConf.make

GaudiCoreSvcConf_extratags = -tag_add=target_GaudiCoreSvcConf

else

cmt_local_tagfile_GaudiCoreSvcConf = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvcConf = $(bin)setup.make
cmt_local_GaudiCoreSvcConf_makefile = $(bin)GaudiCoreSvcConf.make

endif

not_GaudiCoreSvcConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvcConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvcConfdirs :
	@if test ! -d $(bin)GaudiCoreSvcConf; then $(mkdir) -p $(bin)GaudiCoreSvcConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvcConf
else
GaudiCoreSvcConfdirs : ;
endif

ifdef cmt_GaudiCoreSvcConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvcConf_makefile) : $(GaudiCoreSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConf_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf
else
$(cmt_local_GaudiCoreSvcConf_makefile) : $(GaudiCoreSvcConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcConf) ] || \
	  $(not_GaudiCoreSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConf_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvcConf_makefile) : $(GaudiCoreSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcConf.in -tag=$(tags) $(GaudiCoreSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf
else
$(cmt_local_GaudiCoreSvcConf_makefile) : $(GaudiCoreSvcConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvcConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcConf) ] || \
	  $(not_GaudiCoreSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcConf.in -tag=$(tags) $(GaudiCoreSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf

GaudiCoreSvcConf :: $(GaudiCoreSvcConf_dependencies) $(cmt_local_GaudiCoreSvcConf_makefile) dirs GaudiCoreSvcConfdirs
	$(echo) "(constituents.make) Starting GaudiCoreSvcConf"
	@if test -f $(cmt_local_GaudiCoreSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConf
	$(echo) "(constituents.make) GaudiCoreSvcConf done"

clean :: GaudiCoreSvcConfclean ;

GaudiCoreSvcConfclean :: $(GaudiCoreSvcConfclean_dependencies) ##$(cmt_local_GaudiCoreSvcConf_makefile)
	$(echo) "(constituents.make) Starting GaudiCoreSvcConfclean"
	@-if test -f $(cmt_local_GaudiCoreSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConfclean; \
	fi
	$(echo) "(constituents.make) GaudiCoreSvcConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) GaudiCoreSvcConfclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvcConf_makefile) $(bin)GaudiCoreSvcConf_dependencies.make

install :: GaudiCoreSvcConfinstall ;

GaudiCoreSvcConfinstall :: $(GaudiCoreSvcConf_dependencies) $(cmt_local_GaudiCoreSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvcConfuninstall

$(foreach d,$(GaudiCoreSvcConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvcConfuninstall))

GaudiCoreSvcConfuninstall : $(GaudiCoreSvcConfuninstall_dependencies) ##$(cmt_local_GaudiCoreSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvcConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvcConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvcConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiCoreSvc_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvc_python_init_has_target_tag

cmt_local_tagfile_GaudiCoreSvc_python_init = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvc_python_init.make
cmt_final_setup_GaudiCoreSvc_python_init = $(bin)setup_GaudiCoreSvc_python_init.make
cmt_local_GaudiCoreSvc_python_init_makefile = $(bin)GaudiCoreSvc_python_init.make

GaudiCoreSvc_python_init_extratags = -tag_add=target_GaudiCoreSvc_python_init

else

cmt_local_tagfile_GaudiCoreSvc_python_init = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvc_python_init = $(bin)setup.make
cmt_local_GaudiCoreSvc_python_init_makefile = $(bin)GaudiCoreSvc_python_init.make

endif

not_GaudiCoreSvc_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvc_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvc_python_initdirs :
	@if test ! -d $(bin)GaudiCoreSvc_python_init; then $(mkdir) -p $(bin)GaudiCoreSvc_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvc_python_init
else
GaudiCoreSvc_python_initdirs : ;
endif

ifdef cmt_GaudiCoreSvc_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvc_python_init_makefile) : $(GaudiCoreSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init
else
$(cmt_local_GaudiCoreSvc_python_init_makefile) : $(GaudiCoreSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvc_python_init) ] || \
	  $(not_GaudiCoreSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvc_python_init_makefile) : $(GaudiCoreSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvc_python_init.in -tag=$(tags) $(GaudiCoreSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init
else
$(cmt_local_GaudiCoreSvc_python_init_makefile) : $(GaudiCoreSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvc_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvc_python_init) ] || \
	  $(not_GaudiCoreSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvc_python_init.in -tag=$(tags) $(GaudiCoreSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvc_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init

GaudiCoreSvc_python_init :: $(GaudiCoreSvc_python_init_dependencies) $(cmt_local_GaudiCoreSvc_python_init_makefile) dirs GaudiCoreSvc_python_initdirs
	$(echo) "(constituents.make) Starting GaudiCoreSvc_python_init"
	@if test -f $(cmt_local_GaudiCoreSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_init
	$(echo) "(constituents.make) GaudiCoreSvc_python_init done"

clean :: GaudiCoreSvc_python_initclean ;

GaudiCoreSvc_python_initclean :: $(GaudiCoreSvc_python_initclean_dependencies) ##$(cmt_local_GaudiCoreSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiCoreSvc_python_initclean"
	@-if test -f $(cmt_local_GaudiCoreSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiCoreSvc_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) GaudiCoreSvc_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvc_python_init_makefile) $(bin)GaudiCoreSvc_python_init_dependencies.make

install :: GaudiCoreSvc_python_initinstall ;

GaudiCoreSvc_python_initinstall :: $(GaudiCoreSvc_python_init_dependencies) $(cmt_local_GaudiCoreSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvc_python_inituninstall

$(foreach d,$(GaudiCoreSvc_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvc_python_inituninstall))

GaudiCoreSvc_python_inituninstall : $(GaudiCoreSvc_python_inituninstall_dependencies) ##$(cmt_local_GaudiCoreSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvc_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvc_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvc_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvc_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiCoreSvc_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiCoreSvc_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiCoreSvc_python_modules = $(bin)$(GaudiCoreSvc_tag)_zip_GaudiCoreSvc_python_modules.make
cmt_final_setup_zip_GaudiCoreSvc_python_modules = $(bin)setup_zip_GaudiCoreSvc_python_modules.make
cmt_local_zip_GaudiCoreSvc_python_modules_makefile = $(bin)zip_GaudiCoreSvc_python_modules.make

zip_GaudiCoreSvc_python_modules_extratags = -tag_add=target_zip_GaudiCoreSvc_python_modules

else

cmt_local_tagfile_zip_GaudiCoreSvc_python_modules = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_zip_GaudiCoreSvc_python_modules = $(bin)setup.make
cmt_local_zip_GaudiCoreSvc_python_modules_makefile = $(bin)zip_GaudiCoreSvc_python_modules.make

endif

not_zip_GaudiCoreSvc_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiCoreSvc_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiCoreSvc_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiCoreSvc_python_modules; then $(mkdir) -p $(bin)zip_GaudiCoreSvc_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiCoreSvc_python_modules
else
zip_GaudiCoreSvc_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiCoreSvc_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) : $(zip_GaudiCoreSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiCoreSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiCoreSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules
else
$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) : $(zip_GaudiCoreSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiCoreSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiCoreSvc_python_modules) ] || \
	  $(not_zip_GaudiCoreSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiCoreSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiCoreSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) : $(zip_GaudiCoreSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiCoreSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiCoreSvc_python_modules.in -tag=$(tags) $(zip_GaudiCoreSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules
else
$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) : $(zip_GaudiCoreSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiCoreSvc_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiCoreSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiCoreSvc_python_modules) ] || \
	  $(not_zip_GaudiCoreSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiCoreSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiCoreSvc_python_modules.in -tag=$(tags) $(zip_GaudiCoreSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiCoreSvc_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules

zip_GaudiCoreSvc_python_modules :: $(zip_GaudiCoreSvc_python_modules_dependencies) $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) dirs zip_GaudiCoreSvc_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiCoreSvc_python_modules"
	@if test -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modules
	$(echo) "(constituents.make) zip_GaudiCoreSvc_python_modules done"

clean :: zip_GaudiCoreSvc_python_modulesclean ;

zip_GaudiCoreSvc_python_modulesclean :: $(zip_GaudiCoreSvc_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiCoreSvc_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiCoreSvc_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) zip_GaudiCoreSvc_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) $(bin)zip_GaudiCoreSvc_python_modules_dependencies.make

install :: zip_GaudiCoreSvc_python_modulesinstall ;

zip_GaudiCoreSvc_python_modulesinstall :: $(zip_GaudiCoreSvc_python_modules_dependencies) $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiCoreSvc_python_modulesuninstall

$(foreach d,$(zip_GaudiCoreSvc_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiCoreSvc_python_modulesuninstall))

zip_GaudiCoreSvc_python_modulesuninstall : $(zip_GaudiCoreSvc_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiCoreSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiCoreSvc_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiCoreSvc_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiCoreSvc_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiCoreSvc_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiCoreSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiCoreSvcConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcConfDbMerge.make
cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)setup_GaudiCoreSvcConfDbMerge.make
cmt_local_GaudiCoreSvcConfDbMerge_makefile = $(bin)GaudiCoreSvcConfDbMerge.make

GaudiCoreSvcConfDbMerge_extratags = -tag_add=target_GaudiCoreSvcConfDbMerge

else

cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)setup.make
cmt_local_GaudiCoreSvcConfDbMerge_makefile = $(bin)GaudiCoreSvcConfDbMerge.make

endif

not_GaudiCoreSvcConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiCoreSvcConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiCoreSvcConfDbMergedirs :
	@if test ! -d $(bin)GaudiCoreSvcConfDbMerge; then $(mkdir) -p $(bin)GaudiCoreSvcConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiCoreSvcConfDbMerge
else
GaudiCoreSvcConfDbMergedirs : ;
endif

ifdef cmt_GaudiCoreSvcConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) : $(GaudiCoreSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge
else
$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) : $(GaudiCoreSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcConfDbMerge) ] || \
	  $(not_GaudiCoreSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) : $(GaudiCoreSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiCoreSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcConfDbMerge.in -tag=$(tags) $(GaudiCoreSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge
else
$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) : $(GaudiCoreSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiCoreSvcConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiCoreSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiCoreSvcConfDbMerge) ] || \
	  $(not_GaudiCoreSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiCoreSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiCoreSvcConfDbMerge.in -tag=$(tags) $(GaudiCoreSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiCoreSvcConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge

GaudiCoreSvcConfDbMerge :: $(GaudiCoreSvcConfDbMerge_dependencies) $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) dirs GaudiCoreSvcConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiCoreSvcConfDbMerge"
	@if test -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMerge
	$(echo) "(constituents.make) GaudiCoreSvcConfDbMerge done"

clean :: GaudiCoreSvcConfDbMergeclean ;

GaudiCoreSvcConfDbMergeclean :: $(GaudiCoreSvcConfDbMergeclean_dependencies) ##$(cmt_local_GaudiCoreSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiCoreSvcConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiCoreSvcConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) GaudiCoreSvcConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) $(bin)GaudiCoreSvcConfDbMerge_dependencies.make

install :: GaudiCoreSvcConfDbMergeinstall ;

GaudiCoreSvcConfDbMergeinstall :: $(GaudiCoreSvcConfDbMerge_dependencies) $(cmt_local_GaudiCoreSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiCoreSvcConfDbMergeuninstall

$(foreach d,$(GaudiCoreSvcConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiCoreSvcConfDbMergeuninstall))

GaudiCoreSvcConfDbMergeuninstall : $(GaudiCoreSvcConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiCoreSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiCoreSvcConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiCoreSvcConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiCoreSvcConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiCoreSvcConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PackageVersionHeader_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PackageVersionHeader_has_target_tag

cmt_local_tagfile_PackageVersionHeader = $(bin)$(GaudiCoreSvc_tag)_PackageVersionHeader.make
cmt_final_setup_PackageVersionHeader = $(bin)setup_PackageVersionHeader.make
cmt_local_PackageVersionHeader_makefile = $(bin)PackageVersionHeader.make

PackageVersionHeader_extratags = -tag_add=target_PackageVersionHeader

else

cmt_local_tagfile_PackageVersionHeader = $(bin)$(GaudiCoreSvc_tag).make
cmt_final_setup_PackageVersionHeader = $(bin)setup.make
cmt_local_PackageVersionHeader_makefile = $(bin)PackageVersionHeader.make

endif

not_PackageVersionHeader_dependencies = { n=0; for p in $?; do m=0; for d in $(PackageVersionHeader_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PackageVersionHeaderdirs :
	@if test ! -d $(bin)PackageVersionHeader; then $(mkdir) -p $(bin)PackageVersionHeader; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PackageVersionHeader
else
PackageVersionHeaderdirs : ;
endif

ifdef cmt_PackageVersionHeader_has_target_tag

ifndef QUICK
$(cmt_local_PackageVersionHeader_makefile) : $(PackageVersionHeader_dependencies) build_library_links
	$(echo) "(constituents.make) Building PackageVersionHeader.make"; \
	  $(cmtexe) -tag=$(tags) $(PackageVersionHeader_extratags) build constituent_config -out=$(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader
else
$(cmt_local_PackageVersionHeader_makefile) : $(PackageVersionHeader_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PackageVersionHeader) ] || \
	  [ ! -f $(cmt_final_setup_PackageVersionHeader) ] || \
	  $(not_PackageVersionHeader_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PackageVersionHeader.make"; \
	  $(cmtexe) -tag=$(tags) $(PackageVersionHeader_extratags) build constituent_config -out=$(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PackageVersionHeader_makefile) : $(PackageVersionHeader_dependencies) build_library_links
	$(echo) "(constituents.make) Building PackageVersionHeader.make"; \
	  $(cmtexe) -f=$(bin)PackageVersionHeader.in -tag=$(tags) $(PackageVersionHeader_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader
else
$(cmt_local_PackageVersionHeader_makefile) : $(PackageVersionHeader_dependencies) $(cmt_build_library_linksstamp) $(bin)PackageVersionHeader.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PackageVersionHeader) ] || \
	  [ ! -f $(cmt_final_setup_PackageVersionHeader) ] || \
	  $(not_PackageVersionHeader_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PackageVersionHeader.make"; \
	  $(cmtexe) -f=$(bin)PackageVersionHeader.in -tag=$(tags) $(PackageVersionHeader_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PackageVersionHeader_extratags) build constituent_makefile -out=$(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader

PackageVersionHeader :: $(PackageVersionHeader_dependencies) $(cmt_local_PackageVersionHeader_makefile) dirs PackageVersionHeaderdirs
	$(echo) "(constituents.make) Starting PackageVersionHeader"
	@if test -f $(cmt_local_PackageVersionHeader_makefile); then \
	  $(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader; \
	  fi
#	@$(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) PackageVersionHeader
	$(echo) "(constituents.make) PackageVersionHeader done"

clean :: PackageVersionHeaderclean ;

PackageVersionHeaderclean :: $(PackageVersionHeaderclean_dependencies) ##$(cmt_local_PackageVersionHeader_makefile)
	$(echo) "(constituents.make) Starting PackageVersionHeaderclean"
	@-if test -f $(cmt_local_PackageVersionHeader_makefile); then \
	  $(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) PackageVersionHeaderclean; \
	fi
	$(echo) "(constituents.make) PackageVersionHeaderclean done"
#	@-$(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) PackageVersionHeaderclean

##	  /bin/rm -f $(cmt_local_PackageVersionHeader_makefile) $(bin)PackageVersionHeader_dependencies.make

install :: PackageVersionHeaderinstall ;

PackageVersionHeaderinstall :: $(PackageVersionHeader_dependencies) $(cmt_local_PackageVersionHeader_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PackageVersionHeader_makefile); then \
	  $(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PackageVersionHeaderuninstall

$(foreach d,$(PackageVersionHeader_dependencies),$(eval $(d)uninstall_dependencies += PackageVersionHeaderuninstall))

PackageVersionHeaderuninstall : $(PackageVersionHeaderuninstall_dependencies) ##$(cmt_local_PackageVersionHeader_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PackageVersionHeader_makefile); then \
	  $(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PackageVersionHeader_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PackageVersionHeaderuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PackageVersionHeader"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PackageVersionHeader done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiCoreSvc_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiCoreSvc_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiCoreSvc_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiCoreSvc_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiCoreSvc_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiCoreSvc_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiCoreSvc_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiCoreSvc_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiCoreSvc_tag).make
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
