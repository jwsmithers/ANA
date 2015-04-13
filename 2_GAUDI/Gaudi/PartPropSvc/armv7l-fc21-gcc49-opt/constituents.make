
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile = $(PartPropSvc_tag).make
cmt_local_tagfile = $(bin)$(PartPropSvc_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make
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
#-- start of constituent ------

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(PartPropSvc_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_install_more_includes = $(bin)setup.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

endif

not_install_more_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_more_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_more_includesdirs :
	@if test ! -d $(bin)install_more_includes; then $(mkdir) -p $(bin)install_more_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_more_includes
else
install_more_includesdirs : ;
endif

ifdef cmt_install_more_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_more_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -out=$(cmt_local_install_more_includes_makefile) install_more_includes

install_more_includes :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile) dirs install_more_includesdirs
	$(echo) "(constituents.make) Starting install_more_includes"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes
	$(echo) "(constituents.make) install_more_includes done"

clean :: install_more_includesclean ;

install_more_includesclean :: $(install_more_includesclean_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting install_more_includesclean"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean; \
	fi
	$(echo) "(constituents.make) install_more_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean

##	  /bin/rm -f $(cmt_local_install_more_includes_makefile) $(bin)install_more_includes_dependencies.make

install :: install_more_includesinstall ;

install_more_includesinstall :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_more_includesuninstall

$(foreach d,$(install_more_includes_dependencies),$(eval $(d)uninstall_dependencies += install_more_includesuninstall))

install_more_includesuninstall : $(install_more_includesuninstall_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_more_includesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_more_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_more_includes done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_PartPropSvc_has_no_target_tag = 1
cmt_PartPropSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_PartPropSvc_has_target_tag

cmt_local_tagfile_PartPropSvc = $(bin)$(PartPropSvc_tag)_PartPropSvc.make
cmt_final_setup_PartPropSvc = $(bin)setup_PartPropSvc.make
cmt_local_PartPropSvc_makefile = $(bin)PartPropSvc.make

PartPropSvc_extratags = -tag_add=target_PartPropSvc

else

cmt_local_tagfile_PartPropSvc = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvc = $(bin)setup.make
cmt_local_PartPropSvc_makefile = $(bin)PartPropSvc.make

endif

not_PartPropSvccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvcdirs :
	@if test ! -d $(bin)PartPropSvc; then $(mkdir) -p $(bin)PartPropSvc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvc
else
PartPropSvcdirs : ;
endif

ifdef cmt_PartPropSvc_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvc_makefile) : $(PartPropSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvc_extratags) build constituent_config -out=$(cmt_local_PartPropSvc_makefile) PartPropSvc
else
$(cmt_local_PartPropSvc_makefile) : $(PartPropSvccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvc) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvc) ] || \
	  $(not_PartPropSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvc_extratags) build constituent_config -out=$(cmt_local_PartPropSvc_makefile) PartPropSvc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvc_makefile) : $(PartPropSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvc.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvc.in -tag=$(tags) $(PartPropSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvc_makefile) PartPropSvc
else
$(cmt_local_PartPropSvc_makefile) : $(PartPropSvccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvc) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvc) ] || \
	  $(not_PartPropSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvc.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvc.in -tag=$(tags) $(PartPropSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvc_makefile) PartPropSvc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvc_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvc_makefile) PartPropSvc

PartPropSvc :: PartPropSvccompile PartPropSvcinstall ;

ifdef cmt_PartPropSvc_has_prototypes

PartPropSvcprototype : $(PartPropSvcprototype_dependencies) $(cmt_local_PartPropSvc_makefile) dirs PartPropSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

PartPropSvccompile : PartPropSvcprototype

endif

PartPropSvccompile : $(PartPropSvccompile_dependencies) $(cmt_local_PartPropSvc_makefile) dirs PartPropSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PartPropSvcclean ;

PartPropSvcclean :: $(PartPropSvcclean_dependencies) ##$(cmt_local_PartPropSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvc_makefile) PartPropSvcclean

##	  /bin/rm -f $(cmt_local_PartPropSvc_makefile) $(bin)PartPropSvc_dependencies.make

install :: PartPropSvcinstall ;

PartPropSvcinstall :: PartPropSvccompile $(PartPropSvc_dependencies) $(cmt_local_PartPropSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvcuninstall

$(foreach d,$(PartPropSvc_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvcuninstall))

PartPropSvcuninstall : $(PartPropSvcuninstall_dependencies) ##$(cmt_local_PartPropSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvc done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_PartPropSvcComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PartPropSvcComponentsList_has_target_tag

cmt_local_tagfile_PartPropSvcComponentsList = $(bin)$(PartPropSvc_tag)_PartPropSvcComponentsList.make
cmt_final_setup_PartPropSvcComponentsList = $(bin)setup_PartPropSvcComponentsList.make
cmt_local_PartPropSvcComponentsList_makefile = $(bin)PartPropSvcComponentsList.make

PartPropSvcComponentsList_extratags = -tag_add=target_PartPropSvcComponentsList

else

cmt_local_tagfile_PartPropSvcComponentsList = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvcComponentsList = $(bin)setup.make
cmt_local_PartPropSvcComponentsList_makefile = $(bin)PartPropSvcComponentsList.make

endif

not_PartPropSvcComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvcComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvcComponentsListdirs :
	@if test ! -d $(bin)PartPropSvcComponentsList; then $(mkdir) -p $(bin)PartPropSvcComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvcComponentsList
else
PartPropSvcComponentsListdirs : ;
endif

ifdef cmt_PartPropSvcComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvcComponentsList_makefile) : $(PartPropSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList
else
$(cmt_local_PartPropSvcComponentsList_makefile) : $(PartPropSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcComponentsList) ] || \
	  $(not_PartPropSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvcComponentsList_makefile) : $(PartPropSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcComponentsList.in -tag=$(tags) $(PartPropSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList
else
$(cmt_local_PartPropSvcComponentsList_makefile) : $(PartPropSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvcComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcComponentsList) ] || \
	  $(not_PartPropSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcComponentsList.in -tag=$(tags) $(PartPropSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvcComponentsList_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList

PartPropSvcComponentsList :: $(PartPropSvcComponentsList_dependencies) $(cmt_local_PartPropSvcComponentsList_makefile) dirs PartPropSvcComponentsListdirs
	$(echo) "(constituents.make) Starting PartPropSvcComponentsList"
	@if test -f $(cmt_local_PartPropSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsList
	$(echo) "(constituents.make) PartPropSvcComponentsList done"

clean :: PartPropSvcComponentsListclean ;

PartPropSvcComponentsListclean :: $(PartPropSvcComponentsListclean_dependencies) ##$(cmt_local_PartPropSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting PartPropSvcComponentsListclean"
	@-if test -f $(cmt_local_PartPropSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsListclean; \
	fi
	$(echo) "(constituents.make) PartPropSvcComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) PartPropSvcComponentsListclean

##	  /bin/rm -f $(cmt_local_PartPropSvcComponentsList_makefile) $(bin)PartPropSvcComponentsList_dependencies.make

install :: PartPropSvcComponentsListinstall ;

PartPropSvcComponentsListinstall :: $(PartPropSvcComponentsList_dependencies) $(cmt_local_PartPropSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvcComponentsListuninstall

$(foreach d,$(PartPropSvcComponentsList_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvcComponentsListuninstall))

PartPropSvcComponentsListuninstall : $(PartPropSvcComponentsListuninstall_dependencies) ##$(cmt_local_PartPropSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvcComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvcComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvcComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PartPropSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PartPropSvcMergeComponentsList_has_target_tag

cmt_local_tagfile_PartPropSvcMergeComponentsList = $(bin)$(PartPropSvc_tag)_PartPropSvcMergeComponentsList.make
cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)setup_PartPropSvcMergeComponentsList.make
cmt_local_PartPropSvcMergeComponentsList_makefile = $(bin)PartPropSvcMergeComponentsList.make

PartPropSvcMergeComponentsList_extratags = -tag_add=target_PartPropSvcMergeComponentsList

else

cmt_local_tagfile_PartPropSvcMergeComponentsList = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)setup.make
cmt_local_PartPropSvcMergeComponentsList_makefile = $(bin)PartPropSvcMergeComponentsList.make

endif

not_PartPropSvcMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvcMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvcMergeComponentsListdirs :
	@if test ! -d $(bin)PartPropSvcMergeComponentsList; then $(mkdir) -p $(bin)PartPropSvcMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvcMergeComponentsList
else
PartPropSvcMergeComponentsListdirs : ;
endif

ifdef cmt_PartPropSvcMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvcMergeComponentsList_makefile) : $(PartPropSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList
else
$(cmt_local_PartPropSvcMergeComponentsList_makefile) : $(PartPropSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcMergeComponentsList) ] || \
	  $(not_PartPropSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvcMergeComponentsList_makefile) : $(PartPropSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcMergeComponentsList.in -tag=$(tags) $(PartPropSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList
else
$(cmt_local_PartPropSvcMergeComponentsList_makefile) : $(PartPropSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvcMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcMergeComponentsList) ] || \
	  $(not_PartPropSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcMergeComponentsList.in -tag=$(tags) $(PartPropSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvcMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList

PartPropSvcMergeComponentsList :: $(PartPropSvcMergeComponentsList_dependencies) $(cmt_local_PartPropSvcMergeComponentsList_makefile) dirs PartPropSvcMergeComponentsListdirs
	$(echo) "(constituents.make) Starting PartPropSvcMergeComponentsList"
	@if test -f $(cmt_local_PartPropSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsList
	$(echo) "(constituents.make) PartPropSvcMergeComponentsList done"

clean :: PartPropSvcMergeComponentsListclean ;

PartPropSvcMergeComponentsListclean :: $(PartPropSvcMergeComponentsListclean_dependencies) ##$(cmt_local_PartPropSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting PartPropSvcMergeComponentsListclean"
	@-if test -f $(cmt_local_PartPropSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) PartPropSvcMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) PartPropSvcMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) $(bin)PartPropSvcMergeComponentsList_dependencies.make

install :: PartPropSvcMergeComponentsListinstall ;

PartPropSvcMergeComponentsListinstall :: $(PartPropSvcMergeComponentsList_dependencies) $(cmt_local_PartPropSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvcMergeComponentsListuninstall

$(foreach d,$(PartPropSvcMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvcMergeComponentsListuninstall))

PartPropSvcMergeComponentsListuninstall : $(PartPropSvcMergeComponentsListuninstall_dependencies) ##$(cmt_local_PartPropSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvcMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvcMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvcMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PartPropSvcConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PartPropSvcConf_has_target_tag

cmt_local_tagfile_PartPropSvcConf = $(bin)$(PartPropSvc_tag)_PartPropSvcConf.make
cmt_final_setup_PartPropSvcConf = $(bin)setup_PartPropSvcConf.make
cmt_local_PartPropSvcConf_makefile = $(bin)PartPropSvcConf.make

PartPropSvcConf_extratags = -tag_add=target_PartPropSvcConf

else

cmt_local_tagfile_PartPropSvcConf = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvcConf = $(bin)setup.make
cmt_local_PartPropSvcConf_makefile = $(bin)PartPropSvcConf.make

endif

not_PartPropSvcConf_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvcConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvcConfdirs :
	@if test ! -d $(bin)PartPropSvcConf; then $(mkdir) -p $(bin)PartPropSvcConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvcConf
else
PartPropSvcConfdirs : ;
endif

ifdef cmt_PartPropSvcConf_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvcConf_makefile) : $(PartPropSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcConf_extratags) build constituent_config -out=$(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf
else
$(cmt_local_PartPropSvcConf_makefile) : $(PartPropSvcConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcConf) ] || \
	  $(not_PartPropSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcConf_extratags) build constituent_config -out=$(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvcConf_makefile) : $(PartPropSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcConf.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcConf.in -tag=$(tags) $(PartPropSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf
else
$(cmt_local_PartPropSvcConf_makefile) : $(PartPropSvcConf_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvcConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcConf) ] || \
	  $(not_PartPropSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcConf.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcConf.in -tag=$(tags) $(PartPropSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvcConf_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf

PartPropSvcConf :: $(PartPropSvcConf_dependencies) $(cmt_local_PartPropSvcConf_makefile) dirs PartPropSvcConfdirs
	$(echo) "(constituents.make) Starting PartPropSvcConf"
	@if test -f $(cmt_local_PartPropSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) PartPropSvcConf
	$(echo) "(constituents.make) PartPropSvcConf done"

clean :: PartPropSvcConfclean ;

PartPropSvcConfclean :: $(PartPropSvcConfclean_dependencies) ##$(cmt_local_PartPropSvcConf_makefile)
	$(echo) "(constituents.make) Starting PartPropSvcConfclean"
	@-if test -f $(cmt_local_PartPropSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) PartPropSvcConfclean; \
	fi
	$(echo) "(constituents.make) PartPropSvcConfclean done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) PartPropSvcConfclean

##	  /bin/rm -f $(cmt_local_PartPropSvcConf_makefile) $(bin)PartPropSvcConf_dependencies.make

install :: PartPropSvcConfinstall ;

PartPropSvcConfinstall :: $(PartPropSvcConf_dependencies) $(cmt_local_PartPropSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvcConfuninstall

$(foreach d,$(PartPropSvcConf_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvcConfuninstall))

PartPropSvcConfuninstall : $(PartPropSvcConfuninstall_dependencies) ##$(cmt_local_PartPropSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvcConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvcConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvcConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PartPropSvc_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PartPropSvc_python_init_has_target_tag

cmt_local_tagfile_PartPropSvc_python_init = $(bin)$(PartPropSvc_tag)_PartPropSvc_python_init.make
cmt_final_setup_PartPropSvc_python_init = $(bin)setup_PartPropSvc_python_init.make
cmt_local_PartPropSvc_python_init_makefile = $(bin)PartPropSvc_python_init.make

PartPropSvc_python_init_extratags = -tag_add=target_PartPropSvc_python_init

else

cmt_local_tagfile_PartPropSvc_python_init = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvc_python_init = $(bin)setup.make
cmt_local_PartPropSvc_python_init_makefile = $(bin)PartPropSvc_python_init.make

endif

not_PartPropSvc_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvc_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvc_python_initdirs :
	@if test ! -d $(bin)PartPropSvc_python_init; then $(mkdir) -p $(bin)PartPropSvc_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvc_python_init
else
PartPropSvc_python_initdirs : ;
endif

ifdef cmt_PartPropSvc_python_init_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvc_python_init_makefile) : $(PartPropSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvc_python_init_extratags) build constituent_config -out=$(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init
else
$(cmt_local_PartPropSvc_python_init_makefile) : $(PartPropSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvc_python_init) ] || \
	  $(not_PartPropSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvc_python_init_extratags) build constituent_config -out=$(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvc_python_init_makefile) : $(PartPropSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvc_python_init.in -tag=$(tags) $(PartPropSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init
else
$(cmt_local_PartPropSvc_python_init_makefile) : $(PartPropSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvc_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvc_python_init) ] || \
	  $(not_PartPropSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvc_python_init.in -tag=$(tags) $(PartPropSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvc_python_init_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init

PartPropSvc_python_init :: $(PartPropSvc_python_init_dependencies) $(cmt_local_PartPropSvc_python_init_makefile) dirs PartPropSvc_python_initdirs
	$(echo) "(constituents.make) Starting PartPropSvc_python_init"
	@if test -f $(cmt_local_PartPropSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_init
	$(echo) "(constituents.make) PartPropSvc_python_init done"

clean :: PartPropSvc_python_initclean ;

PartPropSvc_python_initclean :: $(PartPropSvc_python_initclean_dependencies) ##$(cmt_local_PartPropSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting PartPropSvc_python_initclean"
	@-if test -f $(cmt_local_PartPropSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_initclean; \
	fi
	$(echo) "(constituents.make) PartPropSvc_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) PartPropSvc_python_initclean

##	  /bin/rm -f $(cmt_local_PartPropSvc_python_init_makefile) $(bin)PartPropSvc_python_init_dependencies.make

install :: PartPropSvc_python_initinstall ;

PartPropSvc_python_initinstall :: $(PartPropSvc_python_init_dependencies) $(cmt_local_PartPropSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvc_python_inituninstall

$(foreach d,$(PartPropSvc_python_init_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvc_python_inituninstall))

PartPropSvc_python_inituninstall : $(PartPropSvc_python_inituninstall_dependencies) ##$(cmt_local_PartPropSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvc_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvc_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvc_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvc_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_PartPropSvc_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_PartPropSvc_python_modules_has_target_tag

cmt_local_tagfile_zip_PartPropSvc_python_modules = $(bin)$(PartPropSvc_tag)_zip_PartPropSvc_python_modules.make
cmt_final_setup_zip_PartPropSvc_python_modules = $(bin)setup_zip_PartPropSvc_python_modules.make
cmt_local_zip_PartPropSvc_python_modules_makefile = $(bin)zip_PartPropSvc_python_modules.make

zip_PartPropSvc_python_modules_extratags = -tag_add=target_zip_PartPropSvc_python_modules

else

cmt_local_tagfile_zip_PartPropSvc_python_modules = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_zip_PartPropSvc_python_modules = $(bin)setup.make
cmt_local_zip_PartPropSvc_python_modules_makefile = $(bin)zip_PartPropSvc_python_modules.make

endif

not_zip_PartPropSvc_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_PartPropSvc_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_PartPropSvc_python_modulesdirs :
	@if test ! -d $(bin)zip_PartPropSvc_python_modules; then $(mkdir) -p $(bin)zip_PartPropSvc_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_PartPropSvc_python_modules
else
zip_PartPropSvc_python_modulesdirs : ;
endif

ifdef cmt_zip_PartPropSvc_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_PartPropSvc_python_modules_makefile) : $(zip_PartPropSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_PartPropSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_PartPropSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules
else
$(cmt_local_zip_PartPropSvc_python_modules_makefile) : $(zip_PartPropSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_PartPropSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_PartPropSvc_python_modules) ] || \
	  $(not_zip_PartPropSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_PartPropSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_PartPropSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_PartPropSvc_python_modules_makefile) : $(zip_PartPropSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_PartPropSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_PartPropSvc_python_modules.in -tag=$(tags) $(zip_PartPropSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules
else
$(cmt_local_zip_PartPropSvc_python_modules_makefile) : $(zip_PartPropSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_PartPropSvc_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_PartPropSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_PartPropSvc_python_modules) ] || \
	  $(not_zip_PartPropSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_PartPropSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_PartPropSvc_python_modules.in -tag=$(tags) $(zip_PartPropSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_PartPropSvc_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules

zip_PartPropSvc_python_modules :: $(zip_PartPropSvc_python_modules_dependencies) $(cmt_local_zip_PartPropSvc_python_modules_makefile) dirs zip_PartPropSvc_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_PartPropSvc_python_modules"
	@if test -f $(cmt_local_zip_PartPropSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modules
	$(echo) "(constituents.make) zip_PartPropSvc_python_modules done"

clean :: zip_PartPropSvc_python_modulesclean ;

zip_PartPropSvc_python_modulesclean :: $(zip_PartPropSvc_python_modulesclean_dependencies) ##$(cmt_local_zip_PartPropSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_PartPropSvc_python_modulesclean"
	@-if test -f $(cmt_local_zip_PartPropSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_PartPropSvc_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) zip_PartPropSvc_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) $(bin)zip_PartPropSvc_python_modules_dependencies.make

install :: zip_PartPropSvc_python_modulesinstall ;

zip_PartPropSvc_python_modulesinstall :: $(zip_PartPropSvc_python_modules_dependencies) $(cmt_local_zip_PartPropSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_PartPropSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_PartPropSvc_python_modulesuninstall

$(foreach d,$(zip_PartPropSvc_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_PartPropSvc_python_modulesuninstall))

zip_PartPropSvc_python_modulesuninstall : $(zip_PartPropSvc_python_modulesuninstall_dependencies) ##$(cmt_local_zip_PartPropSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_PartPropSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_PartPropSvc_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_PartPropSvc_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_PartPropSvc_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_PartPropSvc_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_PartPropSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_PartPropSvcConfDbMerge_has_target_tag

cmt_local_tagfile_PartPropSvcConfDbMerge = $(bin)$(PartPropSvc_tag)_PartPropSvcConfDbMerge.make
cmt_final_setup_PartPropSvcConfDbMerge = $(bin)setup_PartPropSvcConfDbMerge.make
cmt_local_PartPropSvcConfDbMerge_makefile = $(bin)PartPropSvcConfDbMerge.make

PartPropSvcConfDbMerge_extratags = -tag_add=target_PartPropSvcConfDbMerge

else

cmt_local_tagfile_PartPropSvcConfDbMerge = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_PartPropSvcConfDbMerge = $(bin)setup.make
cmt_local_PartPropSvcConfDbMerge_makefile = $(bin)PartPropSvcConfDbMerge.make

endif

not_PartPropSvcConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(PartPropSvcConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PartPropSvcConfDbMergedirs :
	@if test ! -d $(bin)PartPropSvcConfDbMerge; then $(mkdir) -p $(bin)PartPropSvcConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PartPropSvcConfDbMerge
else
PartPropSvcConfDbMergedirs : ;
endif

ifdef cmt_PartPropSvcConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_PartPropSvcConfDbMerge_makefile) : $(PartPropSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge
else
$(cmt_local_PartPropSvcConfDbMerge_makefile) : $(PartPropSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcConfDbMerge) ] || \
	  $(not_PartPropSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(PartPropSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PartPropSvcConfDbMerge_makefile) : $(PartPropSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building PartPropSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcConfDbMerge.in -tag=$(tags) $(PartPropSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge
else
$(cmt_local_PartPropSvcConfDbMerge_makefile) : $(PartPropSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)PartPropSvcConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PartPropSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_PartPropSvcConfDbMerge) ] || \
	  $(not_PartPropSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PartPropSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)PartPropSvcConfDbMerge.in -tag=$(tags) $(PartPropSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PartPropSvcConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge

PartPropSvcConfDbMerge :: $(PartPropSvcConfDbMerge_dependencies) $(cmt_local_PartPropSvcConfDbMerge_makefile) dirs PartPropSvcConfDbMergedirs
	$(echo) "(constituents.make) Starting PartPropSvcConfDbMerge"
	@if test -f $(cmt_local_PartPropSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMerge
	$(echo) "(constituents.make) PartPropSvcConfDbMerge done"

clean :: PartPropSvcConfDbMergeclean ;

PartPropSvcConfDbMergeclean :: $(PartPropSvcConfDbMergeclean_dependencies) ##$(cmt_local_PartPropSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting PartPropSvcConfDbMergeclean"
	@-if test -f $(cmt_local_PartPropSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) PartPropSvcConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) PartPropSvcConfDbMergeclean

##	  /bin/rm -f $(cmt_local_PartPropSvcConfDbMerge_makefile) $(bin)PartPropSvcConfDbMerge_dependencies.make

install :: PartPropSvcConfDbMergeinstall ;

PartPropSvcConfDbMergeinstall :: $(PartPropSvcConfDbMerge_dependencies) $(cmt_local_PartPropSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PartPropSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : PartPropSvcConfDbMergeuninstall

$(foreach d,$(PartPropSvcConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += PartPropSvcConfDbMergeuninstall))

PartPropSvcConfDbMergeuninstall : $(PartPropSvcConfDbMergeuninstall_dependencies) ##$(cmt_local_PartPropSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PartPropSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PartPropSvcConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PartPropSvcConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PartPropSvcConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PartPropSvcConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_joboptions_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_joboptions_has_target_tag

cmt_local_tagfile_install_joboptions = $(bin)$(PartPropSvc_tag)_install_joboptions.make
cmt_final_setup_install_joboptions = $(bin)setup_install_joboptions.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

install_joboptions_extratags = -tag_add=target_install_joboptions

else

cmt_local_tagfile_install_joboptions = $(bin)$(PartPropSvc_tag).make
cmt_final_setup_install_joboptions = $(bin)setup.make
cmt_local_install_joboptions_makefile = $(bin)install_joboptions.make

endif

not_install_joboptions_dependencies = { n=0; for p in $?; do m=0; for d in $(install_joboptions_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_joboptionsdirs :
	@if test ! -d $(bin)install_joboptions; then $(mkdir) -p $(bin)install_joboptions; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_joboptions
else
install_joboptionsdirs : ;
endif

ifdef cmt_install_joboptions_has_target_tag

ifndef QUICK
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_config -out=$(cmt_local_install_joboptions_makefile) install_joboptions
else
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_install_joboptions) ] || \
	  $(not_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_config -out=$(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)install_joboptions.in -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_joboptions_makefile) install_joboptions
else
$(cmt_local_install_joboptions_makefile) : $(install_joboptions_dependencies) $(cmt_build_library_linksstamp) $(bin)install_joboptions.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_joboptions) ] || \
	  [ ! -f $(cmt_final_setup_install_joboptions) ] || \
	  $(not_install_joboptions_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_joboptions.make"; \
	  $(cmtexe) -f=$(bin)install_joboptions.in -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_joboptions_extratags) build constituent_makefile -out=$(cmt_local_install_joboptions_makefile) install_joboptions

install_joboptions :: $(install_joboptions_dependencies) $(cmt_local_install_joboptions_makefile) dirs install_joboptionsdirs
	$(echo) "(constituents.make) Starting install_joboptions"
	@if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptions; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptions
	$(echo) "(constituents.make) install_joboptions done"

clean :: install_joboptionsclean ;

install_joboptionsclean :: $(install_joboptionsclean_dependencies) ##$(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting install_joboptionsclean"
	@-if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptionsclean; \
	fi
	$(echo) "(constituents.make) install_joboptionsclean done"
#	@-$(MAKE) -f $(cmt_local_install_joboptions_makefile) install_joboptionsclean

##	  /bin/rm -f $(cmt_local_install_joboptions_makefile) $(bin)install_joboptions_dependencies.make

install :: install_joboptionsinstall ;

install_joboptionsinstall :: $(install_joboptions_dependencies) $(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_joboptions_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_joboptionsuninstall

$(foreach d,$(install_joboptions_dependencies),$(eval $(d)uninstall_dependencies += install_joboptionsuninstall))

install_joboptionsuninstall : $(install_joboptionsuninstall_dependencies) ##$(cmt_local_install_joboptions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_joboptions_makefile); then \
	  $(MAKE) -f $(cmt_local_install_joboptions_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_joboptions_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_joboptionsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_joboptions"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_joboptions done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(PartPropSvc_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(PartPropSvc_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(PartPropSvc_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(PartPropSvc_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(PartPropSvc_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(PartPropSvc_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(PartPropSvc_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(PartPropSvc_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(PartPropSvc_tag).make
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
