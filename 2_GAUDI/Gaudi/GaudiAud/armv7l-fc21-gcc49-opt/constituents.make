
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAud_tag = $(tag)

#cmt_local_tagfile = $(GaudiAud_tag).make
cmt_local_tagfile = $(bin)$(GaudiAud_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiAudsetup.make
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

cmt_GaudiAud_has_no_target_tag = 1
cmt_GaudiAud_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAud_has_target_tag

cmt_local_tagfile_GaudiAud = $(bin)$(GaudiAud_tag)_GaudiAud.make
cmt_final_setup_GaudiAud = $(bin)setup_GaudiAud.make
cmt_local_GaudiAud_makefile = $(bin)GaudiAud.make

GaudiAud_extratags = -tag_add=target_GaudiAud

else

cmt_local_tagfile_GaudiAud = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAud = $(bin)setup.make
cmt_local_GaudiAud_makefile = $(bin)GaudiAud.make

endif

not_GaudiAudcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAudcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAuddirs :
	@if test ! -d $(bin)GaudiAud; then $(mkdir) -p $(bin)GaudiAud; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAud
else
GaudiAuddirs : ;
endif

ifdef cmt_GaudiAud_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAud_makefile) : $(GaudiAudcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAud.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAud_extratags) build constituent_config -out=$(cmt_local_GaudiAud_makefile) GaudiAud
else
$(cmt_local_GaudiAud_makefile) : $(GaudiAudcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAud) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAud) ] || \
	  $(not_GaudiAudcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAud.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAud_extratags) build constituent_config -out=$(cmt_local_GaudiAud_makefile) GaudiAud; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAud_makefile) : $(GaudiAudcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAud.make"; \
	  $(cmtexe) -f=$(bin)GaudiAud.in -tag=$(tags) $(GaudiAud_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAud_makefile) GaudiAud
else
$(cmt_local_GaudiAud_makefile) : $(GaudiAudcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAud.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAud) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAud) ] || \
	  $(not_GaudiAudcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAud.make"; \
	  $(cmtexe) -f=$(bin)GaudiAud.in -tag=$(tags) $(GaudiAud_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAud_makefile) GaudiAud; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAud_extratags) build constituent_makefile -out=$(cmt_local_GaudiAud_makefile) GaudiAud

GaudiAud :: GaudiAudcompile GaudiAudinstall ;

ifdef cmt_GaudiAud_has_prototypes

GaudiAudprototype : $(GaudiAudprototype_dependencies) $(cmt_local_GaudiAud_makefile) dirs GaudiAuddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAud_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiAudcompile : GaudiAudprototype

endif

GaudiAudcompile : $(GaudiAudcompile_dependencies) $(cmt_local_GaudiAud_makefile) dirs GaudiAuddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAud_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiAudclean ;

GaudiAudclean :: $(GaudiAudclean_dependencies) ##$(cmt_local_GaudiAud_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAud_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiAud_makefile) GaudiAudclean

##	  /bin/rm -f $(cmt_local_GaudiAud_makefile) $(bin)GaudiAud_dependencies.make

install :: GaudiAudinstall ;

GaudiAudinstall :: GaudiAudcompile $(GaudiAud_dependencies) $(cmt_local_GaudiAud_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAud_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAuduninstall

$(foreach d,$(GaudiAud_dependencies),$(eval $(d)uninstall_dependencies += GaudiAuduninstall))

GaudiAuduninstall : $(GaudiAuduninstall_dependencies) ##$(cmt_local_GaudiAud_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAud_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAuduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAud"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAud done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiAudComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAudComponentsList_has_target_tag

cmt_local_tagfile_GaudiAudComponentsList = $(bin)$(GaudiAud_tag)_GaudiAudComponentsList.make
cmt_final_setup_GaudiAudComponentsList = $(bin)setup_GaudiAudComponentsList.make
cmt_local_GaudiAudComponentsList_makefile = $(bin)GaudiAudComponentsList.make

GaudiAudComponentsList_extratags = -tag_add=target_GaudiAudComponentsList

else

cmt_local_tagfile_GaudiAudComponentsList = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAudComponentsList = $(bin)setup.make
cmt_local_GaudiAudComponentsList_makefile = $(bin)GaudiAudComponentsList.make

endif

not_GaudiAudComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAudComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAudComponentsListdirs :
	@if test ! -d $(bin)GaudiAudComponentsList; then $(mkdir) -p $(bin)GaudiAudComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAudComponentsList
else
GaudiAudComponentsListdirs : ;
endif

ifdef cmt_GaudiAudComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAudComponentsList_makefile) : $(GaudiAudComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList
else
$(cmt_local_GaudiAudComponentsList_makefile) : $(GaudiAudComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudComponentsList) ] || \
	  $(not_GaudiAudComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAudComponentsList_makefile) : $(GaudiAudComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudComponentsList.in -tag=$(tags) $(GaudiAudComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList
else
$(cmt_local_GaudiAudComponentsList_makefile) : $(GaudiAudComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAudComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudComponentsList) ] || \
	  $(not_GaudiAudComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudComponentsList.in -tag=$(tags) $(GaudiAudComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAudComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList

GaudiAudComponentsList :: $(GaudiAudComponentsList_dependencies) $(cmt_local_GaudiAudComponentsList_makefile) dirs GaudiAudComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiAudComponentsList"
	@if test -f $(cmt_local_GaudiAudComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsList
	$(echo) "(constituents.make) GaudiAudComponentsList done"

clean :: GaudiAudComponentsListclean ;

GaudiAudComponentsListclean :: $(GaudiAudComponentsListclean_dependencies) ##$(cmt_local_GaudiAudComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiAudComponentsListclean"
	@-if test -f $(cmt_local_GaudiAudComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiAudComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) GaudiAudComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiAudComponentsList_makefile) $(bin)GaudiAudComponentsList_dependencies.make

install :: GaudiAudComponentsListinstall ;

GaudiAudComponentsListinstall :: $(GaudiAudComponentsList_dependencies) $(cmt_local_GaudiAudComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAudComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAudComponentsListuninstall

$(foreach d,$(GaudiAudComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiAudComponentsListuninstall))

GaudiAudComponentsListuninstall : $(GaudiAudComponentsListuninstall_dependencies) ##$(cmt_local_GaudiAudComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAudComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAudComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAudComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAudComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAudMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAudMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiAudMergeComponentsList = $(bin)$(GaudiAud_tag)_GaudiAudMergeComponentsList.make
cmt_final_setup_GaudiAudMergeComponentsList = $(bin)setup_GaudiAudMergeComponentsList.make
cmt_local_GaudiAudMergeComponentsList_makefile = $(bin)GaudiAudMergeComponentsList.make

GaudiAudMergeComponentsList_extratags = -tag_add=target_GaudiAudMergeComponentsList

else

cmt_local_tagfile_GaudiAudMergeComponentsList = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAudMergeComponentsList = $(bin)setup.make
cmt_local_GaudiAudMergeComponentsList_makefile = $(bin)GaudiAudMergeComponentsList.make

endif

not_GaudiAudMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAudMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAudMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiAudMergeComponentsList; then $(mkdir) -p $(bin)GaudiAudMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAudMergeComponentsList
else
GaudiAudMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiAudMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAudMergeComponentsList_makefile) : $(GaudiAudMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList
else
$(cmt_local_GaudiAudMergeComponentsList_makefile) : $(GaudiAudMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudMergeComponentsList) ] || \
	  $(not_GaudiAudMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAudMergeComponentsList_makefile) : $(GaudiAudMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudMergeComponentsList.in -tag=$(tags) $(GaudiAudMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList
else
$(cmt_local_GaudiAudMergeComponentsList_makefile) : $(GaudiAudMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAudMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudMergeComponentsList) ] || \
	  $(not_GaudiAudMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudMergeComponentsList.in -tag=$(tags) $(GaudiAudMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAudMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList

GaudiAudMergeComponentsList :: $(GaudiAudMergeComponentsList_dependencies) $(cmt_local_GaudiAudMergeComponentsList_makefile) dirs GaudiAudMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiAudMergeComponentsList"
	@if test -f $(cmt_local_GaudiAudMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsList
	$(echo) "(constituents.make) GaudiAudMergeComponentsList done"

clean :: GaudiAudMergeComponentsListclean ;

GaudiAudMergeComponentsListclean :: $(GaudiAudMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiAudMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiAudMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiAudMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiAudMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) GaudiAudMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiAudMergeComponentsList_makefile) $(bin)GaudiAudMergeComponentsList_dependencies.make

install :: GaudiAudMergeComponentsListinstall ;

GaudiAudMergeComponentsListinstall :: $(GaudiAudMergeComponentsList_dependencies) $(cmt_local_GaudiAudMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAudMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAudMergeComponentsListuninstall

$(foreach d,$(GaudiAudMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiAudMergeComponentsListuninstall))

GaudiAudMergeComponentsListuninstall : $(GaudiAudMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiAudMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAudMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAudMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAudMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAudMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAudConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAudConf_has_target_tag

cmt_local_tagfile_GaudiAudConf = $(bin)$(GaudiAud_tag)_GaudiAudConf.make
cmt_final_setup_GaudiAudConf = $(bin)setup_GaudiAudConf.make
cmt_local_GaudiAudConf_makefile = $(bin)GaudiAudConf.make

GaudiAudConf_extratags = -tag_add=target_GaudiAudConf

else

cmt_local_tagfile_GaudiAudConf = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAudConf = $(bin)setup.make
cmt_local_GaudiAudConf_makefile = $(bin)GaudiAudConf.make

endif

not_GaudiAudConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAudConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAudConfdirs :
	@if test ! -d $(bin)GaudiAudConf; then $(mkdir) -p $(bin)GaudiAudConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAudConf
else
GaudiAudConfdirs : ;
endif

ifdef cmt_GaudiAudConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAudConf_makefile) : $(GaudiAudConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudConf_extratags) build constituent_config -out=$(cmt_local_GaudiAudConf_makefile) GaudiAudConf
else
$(cmt_local_GaudiAudConf_makefile) : $(GaudiAudConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudConf) ] || \
	  $(not_GaudiAudConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudConf_extratags) build constituent_config -out=$(cmt_local_GaudiAudConf_makefile) GaudiAudConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAudConf_makefile) : $(GaudiAudConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudConf.in -tag=$(tags) $(GaudiAudConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudConf_makefile) GaudiAudConf
else
$(cmt_local_GaudiAudConf_makefile) : $(GaudiAudConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAudConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudConf) ] || \
	  $(not_GaudiAudConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudConf.in -tag=$(tags) $(GaudiAudConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudConf_makefile) GaudiAudConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAudConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiAudConf_makefile) GaudiAudConf

GaudiAudConf :: $(GaudiAudConf_dependencies) $(cmt_local_GaudiAudConf_makefile) dirs GaudiAudConfdirs
	$(echo) "(constituents.make) Starting GaudiAudConf"
	@if test -f $(cmt_local_GaudiAudConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConf_makefile) GaudiAudConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudConf_makefile) GaudiAudConf
	$(echo) "(constituents.make) GaudiAudConf done"

clean :: GaudiAudConfclean ;

GaudiAudConfclean :: $(GaudiAudConfclean_dependencies) ##$(cmt_local_GaudiAudConf_makefile)
	$(echo) "(constituents.make) Starting GaudiAudConfclean"
	@-if test -f $(cmt_local_GaudiAudConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConf_makefile) GaudiAudConfclean; \
	fi
	$(echo) "(constituents.make) GaudiAudConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAudConf_makefile) GaudiAudConfclean

##	  /bin/rm -f $(cmt_local_GaudiAudConf_makefile) $(bin)GaudiAudConf_dependencies.make

install :: GaudiAudConfinstall ;

GaudiAudConfinstall :: $(GaudiAudConf_dependencies) $(cmt_local_GaudiAudConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAudConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAudConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAudConfuninstall

$(foreach d,$(GaudiAudConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiAudConfuninstall))

GaudiAudConfuninstall : $(GaudiAudConfuninstall_dependencies) ##$(cmt_local_GaudiAudConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAudConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAudConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAudConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAudConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAud_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAud_python_init_has_target_tag

cmt_local_tagfile_GaudiAud_python_init = $(bin)$(GaudiAud_tag)_GaudiAud_python_init.make
cmt_final_setup_GaudiAud_python_init = $(bin)setup_GaudiAud_python_init.make
cmt_local_GaudiAud_python_init_makefile = $(bin)GaudiAud_python_init.make

GaudiAud_python_init_extratags = -tag_add=target_GaudiAud_python_init

else

cmt_local_tagfile_GaudiAud_python_init = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAud_python_init = $(bin)setup.make
cmt_local_GaudiAud_python_init_makefile = $(bin)GaudiAud_python_init.make

endif

not_GaudiAud_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAud_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAud_python_initdirs :
	@if test ! -d $(bin)GaudiAud_python_init; then $(mkdir) -p $(bin)GaudiAud_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAud_python_init
else
GaudiAud_python_initdirs : ;
endif

ifdef cmt_GaudiAud_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAud_python_init_makefile) : $(GaudiAud_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAud_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAud_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init
else
$(cmt_local_GaudiAud_python_init_makefile) : $(GaudiAud_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAud_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAud_python_init) ] || \
	  $(not_GaudiAud_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAud_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAud_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAud_python_init_makefile) : $(GaudiAud_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAud_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiAud_python_init.in -tag=$(tags) $(GaudiAud_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init
else
$(cmt_local_GaudiAud_python_init_makefile) : $(GaudiAud_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAud_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAud_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAud_python_init) ] || \
	  $(not_GaudiAud_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAud_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiAud_python_init.in -tag=$(tags) $(GaudiAud_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAud_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init

GaudiAud_python_init :: $(GaudiAud_python_init_dependencies) $(cmt_local_GaudiAud_python_init_makefile) dirs GaudiAud_python_initdirs
	$(echo) "(constituents.make) Starting GaudiAud_python_init"
	@if test -f $(cmt_local_GaudiAud_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_init
	$(echo) "(constituents.make) GaudiAud_python_init done"

clean :: GaudiAud_python_initclean ;

GaudiAud_python_initclean :: $(GaudiAud_python_initclean_dependencies) ##$(cmt_local_GaudiAud_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiAud_python_initclean"
	@-if test -f $(cmt_local_GaudiAud_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiAud_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) GaudiAud_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiAud_python_init_makefile) $(bin)GaudiAud_python_init_dependencies.make

install :: GaudiAud_python_initinstall ;

GaudiAud_python_initinstall :: $(GaudiAud_python_init_dependencies) $(cmt_local_GaudiAud_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAud_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAud_python_inituninstall

$(foreach d,$(GaudiAud_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiAud_python_inituninstall))

GaudiAud_python_inituninstall : $(GaudiAud_python_inituninstall_dependencies) ##$(cmt_local_GaudiAud_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAud_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAud_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAud_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAud_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAud_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiAud_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiAud_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiAud_python_modules = $(bin)$(GaudiAud_tag)_zip_GaudiAud_python_modules.make
cmt_final_setup_zip_GaudiAud_python_modules = $(bin)setup_zip_GaudiAud_python_modules.make
cmt_local_zip_GaudiAud_python_modules_makefile = $(bin)zip_GaudiAud_python_modules.make

zip_GaudiAud_python_modules_extratags = -tag_add=target_zip_GaudiAud_python_modules

else

cmt_local_tagfile_zip_GaudiAud_python_modules = $(bin)$(GaudiAud_tag).make
cmt_final_setup_zip_GaudiAud_python_modules = $(bin)setup.make
cmt_local_zip_GaudiAud_python_modules_makefile = $(bin)zip_GaudiAud_python_modules.make

endif

not_zip_GaudiAud_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiAud_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiAud_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiAud_python_modules; then $(mkdir) -p $(bin)zip_GaudiAud_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiAud_python_modules
else
zip_GaudiAud_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiAud_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiAud_python_modules_makefile) : $(zip_GaudiAud_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiAud_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiAud_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules
else
$(cmt_local_zip_GaudiAud_python_modules_makefile) : $(zip_GaudiAud_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiAud_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiAud_python_modules) ] || \
	  $(not_zip_GaudiAud_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiAud_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiAud_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiAud_python_modules_makefile) : $(zip_GaudiAud_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiAud_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiAud_python_modules.in -tag=$(tags) $(zip_GaudiAud_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules
else
$(cmt_local_zip_GaudiAud_python_modules_makefile) : $(zip_GaudiAud_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiAud_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiAud_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiAud_python_modules) ] || \
	  $(not_zip_GaudiAud_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiAud_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiAud_python_modules.in -tag=$(tags) $(zip_GaudiAud_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiAud_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules

zip_GaudiAud_python_modules :: $(zip_GaudiAud_python_modules_dependencies) $(cmt_local_zip_GaudiAud_python_modules_makefile) dirs zip_GaudiAud_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiAud_python_modules"
	@if test -f $(cmt_local_zip_GaudiAud_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modules
	$(echo) "(constituents.make) zip_GaudiAud_python_modules done"

clean :: zip_GaudiAud_python_modulesclean ;

zip_GaudiAud_python_modulesclean :: $(zip_GaudiAud_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiAud_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiAud_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiAud_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiAud_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) zip_GaudiAud_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiAud_python_modules_makefile) $(bin)zip_GaudiAud_python_modules_dependencies.make

install :: zip_GaudiAud_python_modulesinstall ;

zip_GaudiAud_python_modulesinstall :: $(zip_GaudiAud_python_modules_dependencies) $(cmt_local_zip_GaudiAud_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiAud_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiAud_python_modulesuninstall

$(foreach d,$(zip_GaudiAud_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiAud_python_modulesuninstall))

zip_GaudiAud_python_modulesuninstall : $(zip_GaudiAud_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiAud_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiAud_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiAud_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiAud_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiAud_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiAud_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAudConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAudConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiAudConfDbMerge = $(bin)$(GaudiAud_tag)_GaudiAudConfDbMerge.make
cmt_final_setup_GaudiAudConfDbMerge = $(bin)setup_GaudiAudConfDbMerge.make
cmt_local_GaudiAudConfDbMerge_makefile = $(bin)GaudiAudConfDbMerge.make

GaudiAudConfDbMerge_extratags = -tag_add=target_GaudiAudConfDbMerge

else

cmt_local_tagfile_GaudiAudConfDbMerge = $(bin)$(GaudiAud_tag).make
cmt_final_setup_GaudiAudConfDbMerge = $(bin)setup.make
cmt_local_GaudiAudConfDbMerge_makefile = $(bin)GaudiAudConfDbMerge.make

endif

not_GaudiAudConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAudConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAudConfDbMergedirs :
	@if test ! -d $(bin)GaudiAudConfDbMerge; then $(mkdir) -p $(bin)GaudiAudConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAudConfDbMerge
else
GaudiAudConfDbMergedirs : ;
endif

ifdef cmt_GaudiAudConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAudConfDbMerge_makefile) : $(GaudiAudConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge
else
$(cmt_local_GaudiAudConfDbMerge_makefile) : $(GaudiAudConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudConfDbMerge) ] || \
	  $(not_GaudiAudConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAudConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAudConfDbMerge_makefile) : $(GaudiAudConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAudConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudConfDbMerge.in -tag=$(tags) $(GaudiAudConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge
else
$(cmt_local_GaudiAudConfDbMerge_makefile) : $(GaudiAudConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAudConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAudConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAudConfDbMerge) ] || \
	  $(not_GaudiAudConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAudConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiAudConfDbMerge.in -tag=$(tags) $(GaudiAudConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAudConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge

GaudiAudConfDbMerge :: $(GaudiAudConfDbMerge_dependencies) $(cmt_local_GaudiAudConfDbMerge_makefile) dirs GaudiAudConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiAudConfDbMerge"
	@if test -f $(cmt_local_GaudiAudConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMerge
	$(echo) "(constituents.make) GaudiAudConfDbMerge done"

clean :: GaudiAudConfDbMergeclean ;

GaudiAudConfDbMergeclean :: $(GaudiAudConfDbMergeclean_dependencies) ##$(cmt_local_GaudiAudConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiAudConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiAudConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiAudConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) GaudiAudConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiAudConfDbMerge_makefile) $(bin)GaudiAudConfDbMerge_dependencies.make

install :: GaudiAudConfDbMergeinstall ;

GaudiAudConfDbMergeinstall :: $(GaudiAudConfDbMerge_dependencies) $(cmt_local_GaudiAudConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAudConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAudConfDbMergeuninstall

$(foreach d,$(GaudiAudConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiAudConfDbMergeuninstall))

GaudiAudConfDbMergeuninstall : $(GaudiAudConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiAudConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAudConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAudConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAudConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAudConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAudConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiAud_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiAud_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiAud_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiAud_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiAud_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiAud_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiAud_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiAud_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiAud_tag).make
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
#-- start of constituent ------

cmt_QMTestTestsDatabase_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_QMTestTestsDatabase_has_target_tag

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiAud_tag)_QMTestTestsDatabase.make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup_QMTestTestsDatabase.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

QMTestTestsDatabase_extratags = -tag_add=target_QMTestTestsDatabase

else

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiAud_tag).make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

endif

not_QMTestTestsDatabase_dependencies = { n=0; for p in $?; do m=0; for d in $(QMTestTestsDatabase_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
QMTestTestsDatabasedirs :
	@if test ! -d $(bin)QMTestTestsDatabase; then $(mkdir) -p $(bin)QMTestTestsDatabase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)QMTestTestsDatabase
else
QMTestTestsDatabasedirs : ;
endif

ifdef cmt_QMTestTestsDatabase_has_target_tag

ifndef QUICK
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_config -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
else
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestTestsDatabase) ] || \
	  [ ! -f $(cmt_final_setup_QMTestTestsDatabase) ] || \
	  $(not_QMTestTestsDatabase_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_config -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -f=$(bin)QMTestTestsDatabase.in -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
else
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) $(cmt_build_library_linksstamp) $(bin)QMTestTestsDatabase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestTestsDatabase) ] || \
	  [ ! -f $(cmt_final_setup_QMTestTestsDatabase) ] || \
	  $(not_QMTestTestsDatabase_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -f=$(bin)QMTestTestsDatabase.in -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase

QMTestTestsDatabase :: $(QMTestTestsDatabase_dependencies) $(cmt_local_QMTestTestsDatabase_makefile) dirs QMTestTestsDatabasedirs
	$(echo) "(constituents.make) Starting QMTestTestsDatabase"
	@if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
	$(echo) "(constituents.make) QMTestTestsDatabase done"

clean :: QMTestTestsDatabaseclean ;

QMTestTestsDatabaseclean :: $(QMTestTestsDatabaseclean_dependencies) ##$(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting QMTestTestsDatabaseclean"
	@-if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabaseclean; \
	fi
	$(echo) "(constituents.make) QMTestTestsDatabaseclean done"
#	@-$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabaseclean

##	  /bin/rm -f $(cmt_local_QMTestTestsDatabase_makefile) $(bin)QMTestTestsDatabase_dependencies.make

install :: QMTestTestsDatabaseinstall ;

QMTestTestsDatabaseinstall :: $(QMTestTestsDatabase_dependencies) $(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : QMTestTestsDatabaseuninstall

$(foreach d,$(QMTestTestsDatabase_dependencies),$(eval $(d)uninstall_dependencies += QMTestTestsDatabaseuninstall))

QMTestTestsDatabaseuninstall : $(QMTestTestsDatabaseuninstall_dependencies) ##$(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: QMTestTestsDatabaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ QMTestTestsDatabase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ QMTestTestsDatabase done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_QMTestGUI_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_QMTestGUI_has_target_tag

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiAud_tag)_QMTestGUI.make
cmt_final_setup_QMTestGUI = $(bin)setup_QMTestGUI.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

QMTestGUI_extratags = -tag_add=target_QMTestGUI

else

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiAud_tag).make
cmt_final_setup_QMTestGUI = $(bin)setup.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

endif

not_QMTestGUI_dependencies = { n=0; for p in $?; do m=0; for d in $(QMTestGUI_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
QMTestGUIdirs :
	@if test ! -d $(bin)QMTestGUI; then $(mkdir) -p $(bin)QMTestGUI; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)QMTestGUI
else
QMTestGUIdirs : ;
endif

ifdef cmt_QMTestGUI_has_target_tag

ifndef QUICK
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_config -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI
else
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestGUI) ] || \
	  [ ! -f $(cmt_final_setup_QMTestGUI) ] || \
	  $(not_QMTestGUI_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_config -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -f=$(bin)QMTestGUI.in -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI
else
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) $(cmt_build_library_linksstamp) $(bin)QMTestGUI.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestGUI) ] || \
	  [ ! -f $(cmt_final_setup_QMTestGUI) ] || \
	  $(not_QMTestGUI_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -f=$(bin)QMTestGUI.in -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI

QMTestGUI :: $(QMTestGUI_dependencies) $(cmt_local_QMTestGUI_makefile) dirs QMTestGUIdirs
	$(echo) "(constituents.make) Starting QMTestGUI"
	@if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUI
	$(echo) "(constituents.make) QMTestGUI done"

clean :: QMTestGUIclean ;

QMTestGUIclean :: $(QMTestGUIclean_dependencies) ##$(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting QMTestGUIclean"
	@-if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUIclean; \
	fi
	$(echo) "(constituents.make) QMTestGUIclean done"
#	@-$(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUIclean

##	  /bin/rm -f $(cmt_local_QMTestGUI_makefile) $(bin)QMTestGUI_dependencies.make

install :: QMTestGUIinstall ;

QMTestGUIinstall :: $(QMTestGUI_dependencies) $(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_QMTestGUI_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : QMTestGUIuninstall

$(foreach d,$(QMTestGUI_dependencies),$(eval $(d)uninstall_dependencies += QMTestGUIuninstall))

QMTestGUIuninstall : $(QMTestGUIuninstall_dependencies) ##$(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestGUI_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: QMTestGUIuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ QMTestGUI"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ QMTestGUI done"
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
