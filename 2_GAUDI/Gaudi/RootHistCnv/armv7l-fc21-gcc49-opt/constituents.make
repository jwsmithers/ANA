
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile = $(RootHistCnv_tag).make
cmt_local_tagfile = $(bin)$(RootHistCnv_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make
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

cmt_RootHistCnv_has_no_target_tag = 1
cmt_RootHistCnv_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootHistCnv_has_target_tag

cmt_local_tagfile_RootHistCnv = $(bin)$(RootHistCnv_tag)_RootHistCnv.make
cmt_final_setup_RootHistCnv = $(bin)setup_RootHistCnv.make
cmt_local_RootHistCnv_makefile = $(bin)RootHistCnv.make

RootHistCnv_extratags = -tag_add=target_RootHistCnv

else

cmt_local_tagfile_RootHistCnv = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnv = $(bin)setup.make
cmt_local_RootHistCnv_makefile = $(bin)RootHistCnv.make

endif

not_RootHistCnvcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnvcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnvdirs :
	@if test ! -d $(bin)RootHistCnv; then $(mkdir) -p $(bin)RootHistCnv; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnv
else
RootHistCnvdirs : ;
endif

ifdef cmt_RootHistCnv_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnv_makefile) : $(RootHistCnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnv.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnv_extratags) build constituent_config -out=$(cmt_local_RootHistCnv_makefile) RootHistCnv
else
$(cmt_local_RootHistCnv_makefile) : $(RootHistCnvcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnv) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnv) ] || \
	  $(not_RootHistCnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnv.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnv_extratags) build constituent_config -out=$(cmt_local_RootHistCnv_makefile) RootHistCnv; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnv_makefile) : $(RootHistCnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnv.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnv.in -tag=$(tags) $(RootHistCnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnv_makefile) RootHistCnv
else
$(cmt_local_RootHistCnv_makefile) : $(RootHistCnvcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnv.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnv) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnv) ] || \
	  $(not_RootHistCnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnv.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnv.in -tag=$(tags) $(RootHistCnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnv_makefile) RootHistCnv; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnv_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnv_makefile) RootHistCnv

RootHistCnv :: RootHistCnvcompile RootHistCnvinstall ;

ifdef cmt_RootHistCnv_has_prototypes

RootHistCnvprototype : $(RootHistCnvprototype_dependencies) $(cmt_local_RootHistCnv_makefile) dirs RootHistCnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

RootHistCnvcompile : RootHistCnvprototype

endif

RootHistCnvcompile : $(RootHistCnvcompile_dependencies) $(cmt_local_RootHistCnv_makefile) dirs RootHistCnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: RootHistCnvclean ;

RootHistCnvclean :: $(RootHistCnvclean_dependencies) ##$(cmt_local_RootHistCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnv_makefile) RootHistCnvclean

##	  /bin/rm -f $(cmt_local_RootHistCnv_makefile) $(bin)RootHistCnv_dependencies.make

install :: RootHistCnvinstall ;

RootHistCnvinstall :: RootHistCnvcompile $(RootHistCnv_dependencies) $(cmt_local_RootHistCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnvuninstall

$(foreach d,$(RootHistCnv_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnvuninstall))

RootHistCnvuninstall : $(RootHistCnvuninstall_dependencies) ##$(cmt_local_RootHistCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnvuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnv"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnv done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_RootHistCnvComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootHistCnvComponentsList_has_target_tag

cmt_local_tagfile_RootHistCnvComponentsList = $(bin)$(RootHistCnv_tag)_RootHistCnvComponentsList.make
cmt_final_setup_RootHistCnvComponentsList = $(bin)setup_RootHistCnvComponentsList.make
cmt_local_RootHistCnvComponentsList_makefile = $(bin)RootHistCnvComponentsList.make

RootHistCnvComponentsList_extratags = -tag_add=target_RootHistCnvComponentsList

else

cmt_local_tagfile_RootHistCnvComponentsList = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnvComponentsList = $(bin)setup.make
cmt_local_RootHistCnvComponentsList_makefile = $(bin)RootHistCnvComponentsList.make

endif

not_RootHistCnvComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnvComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnvComponentsListdirs :
	@if test ! -d $(bin)RootHistCnvComponentsList; then $(mkdir) -p $(bin)RootHistCnvComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnvComponentsList
else
RootHistCnvComponentsListdirs : ;
endif

ifdef cmt_RootHistCnvComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnvComponentsList_makefile) : $(RootHistCnvComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvComponentsList_extratags) build constituent_config -out=$(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList
else
$(cmt_local_RootHistCnvComponentsList_makefile) : $(RootHistCnvComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvComponentsList) ] || \
	  $(not_RootHistCnvComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvComponentsList_extratags) build constituent_config -out=$(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnvComponentsList_makefile) : $(RootHistCnvComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvComponentsList.in -tag=$(tags) $(RootHistCnvComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList
else
$(cmt_local_RootHistCnvComponentsList_makefile) : $(RootHistCnvComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnvComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvComponentsList) ] || \
	  $(not_RootHistCnvComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvComponentsList.in -tag=$(tags) $(RootHistCnvComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnvComponentsList_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList

RootHistCnvComponentsList :: $(RootHistCnvComponentsList_dependencies) $(cmt_local_RootHistCnvComponentsList_makefile) dirs RootHistCnvComponentsListdirs
	$(echo) "(constituents.make) Starting RootHistCnvComponentsList"
	@if test -f $(cmt_local_RootHistCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsList
	$(echo) "(constituents.make) RootHistCnvComponentsList done"

clean :: RootHistCnvComponentsListclean ;

RootHistCnvComponentsListclean :: $(RootHistCnvComponentsListclean_dependencies) ##$(cmt_local_RootHistCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting RootHistCnvComponentsListclean"
	@-if test -f $(cmt_local_RootHistCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsListclean; \
	fi
	$(echo) "(constituents.make) RootHistCnvComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) RootHistCnvComponentsListclean

##	  /bin/rm -f $(cmt_local_RootHistCnvComponentsList_makefile) $(bin)RootHistCnvComponentsList_dependencies.make

install :: RootHistCnvComponentsListinstall ;

RootHistCnvComponentsListinstall :: $(RootHistCnvComponentsList_dependencies) $(cmt_local_RootHistCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnvComponentsListuninstall

$(foreach d,$(RootHistCnvComponentsList_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnvComponentsListuninstall))

RootHistCnvComponentsListuninstall : $(RootHistCnvComponentsListuninstall_dependencies) ##$(cmt_local_RootHistCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnvComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnvComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnvComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootHistCnvMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootHistCnvMergeComponentsList_has_target_tag

cmt_local_tagfile_RootHistCnvMergeComponentsList = $(bin)$(RootHistCnv_tag)_RootHistCnvMergeComponentsList.make
cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)setup_RootHistCnvMergeComponentsList.make
cmt_local_RootHistCnvMergeComponentsList_makefile = $(bin)RootHistCnvMergeComponentsList.make

RootHistCnvMergeComponentsList_extratags = -tag_add=target_RootHistCnvMergeComponentsList

else

cmt_local_tagfile_RootHistCnvMergeComponentsList = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)setup.make
cmt_local_RootHistCnvMergeComponentsList_makefile = $(bin)RootHistCnvMergeComponentsList.make

endif

not_RootHistCnvMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnvMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnvMergeComponentsListdirs :
	@if test ! -d $(bin)RootHistCnvMergeComponentsList; then $(mkdir) -p $(bin)RootHistCnvMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnvMergeComponentsList
else
RootHistCnvMergeComponentsListdirs : ;
endif

ifdef cmt_RootHistCnvMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnvMergeComponentsList_makefile) : $(RootHistCnvMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList
else
$(cmt_local_RootHistCnvMergeComponentsList_makefile) : $(RootHistCnvMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvMergeComponentsList) ] || \
	  $(not_RootHistCnvMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnvMergeComponentsList_makefile) : $(RootHistCnvMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvMergeComponentsList.in -tag=$(tags) $(RootHistCnvMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList
else
$(cmt_local_RootHistCnvMergeComponentsList_makefile) : $(RootHistCnvMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnvMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvMergeComponentsList) ] || \
	  $(not_RootHistCnvMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvMergeComponentsList.in -tag=$(tags) $(RootHistCnvMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnvMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList

RootHistCnvMergeComponentsList :: $(RootHistCnvMergeComponentsList_dependencies) $(cmt_local_RootHistCnvMergeComponentsList_makefile) dirs RootHistCnvMergeComponentsListdirs
	$(echo) "(constituents.make) Starting RootHistCnvMergeComponentsList"
	@if test -f $(cmt_local_RootHistCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsList
	$(echo) "(constituents.make) RootHistCnvMergeComponentsList done"

clean :: RootHistCnvMergeComponentsListclean ;

RootHistCnvMergeComponentsListclean :: $(RootHistCnvMergeComponentsListclean_dependencies) ##$(cmt_local_RootHistCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting RootHistCnvMergeComponentsListclean"
	@-if test -f $(cmt_local_RootHistCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) RootHistCnvMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) RootHistCnvMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) $(bin)RootHistCnvMergeComponentsList_dependencies.make

install :: RootHistCnvMergeComponentsListinstall ;

RootHistCnvMergeComponentsListinstall :: $(RootHistCnvMergeComponentsList_dependencies) $(cmt_local_RootHistCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnvMergeComponentsListuninstall

$(foreach d,$(RootHistCnvMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnvMergeComponentsListuninstall))

RootHistCnvMergeComponentsListuninstall : $(RootHistCnvMergeComponentsListuninstall_dependencies) ##$(cmt_local_RootHistCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnvMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnvMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnvMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootHistCnvConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootHistCnvConf_has_target_tag

cmt_local_tagfile_RootHistCnvConf = $(bin)$(RootHistCnv_tag)_RootHistCnvConf.make
cmt_final_setup_RootHistCnvConf = $(bin)setup_RootHistCnvConf.make
cmt_local_RootHistCnvConf_makefile = $(bin)RootHistCnvConf.make

RootHistCnvConf_extratags = -tag_add=target_RootHistCnvConf

else

cmt_local_tagfile_RootHistCnvConf = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnvConf = $(bin)setup.make
cmt_local_RootHistCnvConf_makefile = $(bin)RootHistCnvConf.make

endif

not_RootHistCnvConf_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnvConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnvConfdirs :
	@if test ! -d $(bin)RootHistCnvConf; then $(mkdir) -p $(bin)RootHistCnvConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnvConf
else
RootHistCnvConfdirs : ;
endif

ifdef cmt_RootHistCnvConf_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnvConf_makefile) : $(RootHistCnvConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvConf.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvConf_extratags) build constituent_config -out=$(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf
else
$(cmt_local_RootHistCnvConf_makefile) : $(RootHistCnvConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvConf) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvConf) ] || \
	  $(not_RootHistCnvConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvConf.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvConf_extratags) build constituent_config -out=$(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnvConf_makefile) : $(RootHistCnvConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvConf.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvConf.in -tag=$(tags) $(RootHistCnvConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf
else
$(cmt_local_RootHistCnvConf_makefile) : $(RootHistCnvConf_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnvConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvConf) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvConf) ] || \
	  $(not_RootHistCnvConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvConf.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvConf.in -tag=$(tags) $(RootHistCnvConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnvConf_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf

RootHistCnvConf :: $(RootHistCnvConf_dependencies) $(cmt_local_RootHistCnvConf_makefile) dirs RootHistCnvConfdirs
	$(echo) "(constituents.make) Starting RootHistCnvConf"
	@if test -f $(cmt_local_RootHistCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) RootHistCnvConf
	$(echo) "(constituents.make) RootHistCnvConf done"

clean :: RootHistCnvConfclean ;

RootHistCnvConfclean :: $(RootHistCnvConfclean_dependencies) ##$(cmt_local_RootHistCnvConf_makefile)
	$(echo) "(constituents.make) Starting RootHistCnvConfclean"
	@-if test -f $(cmt_local_RootHistCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) RootHistCnvConfclean; \
	fi
	$(echo) "(constituents.make) RootHistCnvConfclean done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) RootHistCnvConfclean

##	  /bin/rm -f $(cmt_local_RootHistCnvConf_makefile) $(bin)RootHistCnvConf_dependencies.make

install :: RootHistCnvConfinstall ;

RootHistCnvConfinstall :: $(RootHistCnvConf_dependencies) $(cmt_local_RootHistCnvConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnvConfuninstall

$(foreach d,$(RootHistCnvConf_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnvConfuninstall))

RootHistCnvConfuninstall : $(RootHistCnvConfuninstall_dependencies) ##$(cmt_local_RootHistCnvConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnvConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnvConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnvConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootHistCnv_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootHistCnv_python_init_has_target_tag

cmt_local_tagfile_RootHistCnv_python_init = $(bin)$(RootHistCnv_tag)_RootHistCnv_python_init.make
cmt_final_setup_RootHistCnv_python_init = $(bin)setup_RootHistCnv_python_init.make
cmt_local_RootHistCnv_python_init_makefile = $(bin)RootHistCnv_python_init.make

RootHistCnv_python_init_extratags = -tag_add=target_RootHistCnv_python_init

else

cmt_local_tagfile_RootHistCnv_python_init = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnv_python_init = $(bin)setup.make
cmt_local_RootHistCnv_python_init_makefile = $(bin)RootHistCnv_python_init.make

endif

not_RootHistCnv_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnv_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnv_python_initdirs :
	@if test ! -d $(bin)RootHistCnv_python_init; then $(mkdir) -p $(bin)RootHistCnv_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnv_python_init
else
RootHistCnv_python_initdirs : ;
endif

ifdef cmt_RootHistCnv_python_init_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnv_python_init_makefile) : $(RootHistCnv_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnv_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnv_python_init_extratags) build constituent_config -out=$(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init
else
$(cmt_local_RootHistCnv_python_init_makefile) : $(RootHistCnv_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnv_python_init) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnv_python_init) ] || \
	  $(not_RootHistCnv_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnv_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnv_python_init_extratags) build constituent_config -out=$(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnv_python_init_makefile) : $(RootHistCnv_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnv_python_init.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnv_python_init.in -tag=$(tags) $(RootHistCnv_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init
else
$(cmt_local_RootHistCnv_python_init_makefile) : $(RootHistCnv_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnv_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnv_python_init) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnv_python_init) ] || \
	  $(not_RootHistCnv_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnv_python_init.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnv_python_init.in -tag=$(tags) $(RootHistCnv_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnv_python_init_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init

RootHistCnv_python_init :: $(RootHistCnv_python_init_dependencies) $(cmt_local_RootHistCnv_python_init_makefile) dirs RootHistCnv_python_initdirs
	$(echo) "(constituents.make) Starting RootHistCnv_python_init"
	@if test -f $(cmt_local_RootHistCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_init
	$(echo) "(constituents.make) RootHistCnv_python_init done"

clean :: RootHistCnv_python_initclean ;

RootHistCnv_python_initclean :: $(RootHistCnv_python_initclean_dependencies) ##$(cmt_local_RootHistCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting RootHistCnv_python_initclean"
	@-if test -f $(cmt_local_RootHistCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_initclean; \
	fi
	$(echo) "(constituents.make) RootHistCnv_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) RootHistCnv_python_initclean

##	  /bin/rm -f $(cmt_local_RootHistCnv_python_init_makefile) $(bin)RootHistCnv_python_init_dependencies.make

install :: RootHistCnv_python_initinstall ;

RootHistCnv_python_initinstall :: $(RootHistCnv_python_init_dependencies) $(cmt_local_RootHistCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnv_python_inituninstall

$(foreach d,$(RootHistCnv_python_init_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnv_python_inituninstall))

RootHistCnv_python_inituninstall : $(RootHistCnv_python_inituninstall_dependencies) ##$(cmt_local_RootHistCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnv_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnv_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnv_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnv_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_RootHistCnv_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_RootHistCnv_python_modules_has_target_tag

cmt_local_tagfile_zip_RootHistCnv_python_modules = $(bin)$(RootHistCnv_tag)_zip_RootHistCnv_python_modules.make
cmt_final_setup_zip_RootHistCnv_python_modules = $(bin)setup_zip_RootHistCnv_python_modules.make
cmt_local_zip_RootHistCnv_python_modules_makefile = $(bin)zip_RootHistCnv_python_modules.make

zip_RootHistCnv_python_modules_extratags = -tag_add=target_zip_RootHistCnv_python_modules

else

cmt_local_tagfile_zip_RootHistCnv_python_modules = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_zip_RootHistCnv_python_modules = $(bin)setup.make
cmt_local_zip_RootHistCnv_python_modules_makefile = $(bin)zip_RootHistCnv_python_modules.make

endif

not_zip_RootHistCnv_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_RootHistCnv_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_RootHistCnv_python_modulesdirs :
	@if test ! -d $(bin)zip_RootHistCnv_python_modules; then $(mkdir) -p $(bin)zip_RootHistCnv_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_RootHistCnv_python_modules
else
zip_RootHistCnv_python_modulesdirs : ;
endif

ifdef cmt_zip_RootHistCnv_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_RootHistCnv_python_modules_makefile) : $(zip_RootHistCnv_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_RootHistCnv_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_RootHistCnv_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules
else
$(cmt_local_zip_RootHistCnv_python_modules_makefile) : $(zip_RootHistCnv_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_RootHistCnv_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_RootHistCnv_python_modules) ] || \
	  $(not_zip_RootHistCnv_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_RootHistCnv_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_RootHistCnv_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_RootHistCnv_python_modules_makefile) : $(zip_RootHistCnv_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_RootHistCnv_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_RootHistCnv_python_modules.in -tag=$(tags) $(zip_RootHistCnv_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules
else
$(cmt_local_zip_RootHistCnv_python_modules_makefile) : $(zip_RootHistCnv_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_RootHistCnv_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_RootHistCnv_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_RootHistCnv_python_modules) ] || \
	  $(not_zip_RootHistCnv_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_RootHistCnv_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_RootHistCnv_python_modules.in -tag=$(tags) $(zip_RootHistCnv_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_RootHistCnv_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules

zip_RootHistCnv_python_modules :: $(zip_RootHistCnv_python_modules_dependencies) $(cmt_local_zip_RootHistCnv_python_modules_makefile) dirs zip_RootHistCnv_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_RootHistCnv_python_modules"
	@if test -f $(cmt_local_zip_RootHistCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modules
	$(echo) "(constituents.make) zip_RootHistCnv_python_modules done"

clean :: zip_RootHistCnv_python_modulesclean ;

zip_RootHistCnv_python_modulesclean :: $(zip_RootHistCnv_python_modulesclean_dependencies) ##$(cmt_local_zip_RootHistCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_RootHistCnv_python_modulesclean"
	@-if test -f $(cmt_local_zip_RootHistCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_RootHistCnv_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) zip_RootHistCnv_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) $(bin)zip_RootHistCnv_python_modules_dependencies.make

install :: zip_RootHistCnv_python_modulesinstall ;

zip_RootHistCnv_python_modulesinstall :: $(zip_RootHistCnv_python_modules_dependencies) $(cmt_local_zip_RootHistCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_RootHistCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_RootHistCnv_python_modulesuninstall

$(foreach d,$(zip_RootHistCnv_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_RootHistCnv_python_modulesuninstall))

zip_RootHistCnv_python_modulesuninstall : $(zip_RootHistCnv_python_modulesuninstall_dependencies) ##$(cmt_local_zip_RootHistCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_RootHistCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_RootHistCnv_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_RootHistCnv_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_RootHistCnv_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_RootHistCnv_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootHistCnvConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootHistCnvConfDbMerge_has_target_tag

cmt_local_tagfile_RootHistCnvConfDbMerge = $(bin)$(RootHistCnv_tag)_RootHistCnvConfDbMerge.make
cmt_final_setup_RootHistCnvConfDbMerge = $(bin)setup_RootHistCnvConfDbMerge.make
cmt_local_RootHistCnvConfDbMerge_makefile = $(bin)RootHistCnvConfDbMerge.make

RootHistCnvConfDbMerge_extratags = -tag_add=target_RootHistCnvConfDbMerge

else

cmt_local_tagfile_RootHistCnvConfDbMerge = $(bin)$(RootHistCnv_tag).make
cmt_final_setup_RootHistCnvConfDbMerge = $(bin)setup.make
cmt_local_RootHistCnvConfDbMerge_makefile = $(bin)RootHistCnvConfDbMerge.make

endif

not_RootHistCnvConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(RootHistCnvConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootHistCnvConfDbMergedirs :
	@if test ! -d $(bin)RootHistCnvConfDbMerge; then $(mkdir) -p $(bin)RootHistCnvConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootHistCnvConfDbMerge
else
RootHistCnvConfDbMergedirs : ;
endif

ifdef cmt_RootHistCnvConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_RootHistCnvConfDbMerge_makefile) : $(RootHistCnvConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvConfDbMerge_extratags) build constituent_config -out=$(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge
else
$(cmt_local_RootHistCnvConfDbMerge_makefile) : $(RootHistCnvConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvConfDbMerge) ] || \
	  $(not_RootHistCnvConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(RootHistCnvConfDbMerge_extratags) build constituent_config -out=$(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootHistCnvConfDbMerge_makefile) : $(RootHistCnvConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootHistCnvConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvConfDbMerge.in -tag=$(tags) $(RootHistCnvConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge
else
$(cmt_local_RootHistCnvConfDbMerge_makefile) : $(RootHistCnvConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)RootHistCnvConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootHistCnvConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_RootHistCnvConfDbMerge) ] || \
	  $(not_RootHistCnvConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootHistCnvConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)RootHistCnvConfDbMerge.in -tag=$(tags) $(RootHistCnvConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootHistCnvConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge

RootHistCnvConfDbMerge :: $(RootHistCnvConfDbMerge_dependencies) $(cmt_local_RootHistCnvConfDbMerge_makefile) dirs RootHistCnvConfDbMergedirs
	$(echo) "(constituents.make) Starting RootHistCnvConfDbMerge"
	@if test -f $(cmt_local_RootHistCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMerge
	$(echo) "(constituents.make) RootHistCnvConfDbMerge done"

clean :: RootHistCnvConfDbMergeclean ;

RootHistCnvConfDbMergeclean :: $(RootHistCnvConfDbMergeclean_dependencies) ##$(cmt_local_RootHistCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting RootHistCnvConfDbMergeclean"
	@-if test -f $(cmt_local_RootHistCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) RootHistCnvConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) RootHistCnvConfDbMergeclean

##	  /bin/rm -f $(cmt_local_RootHistCnvConfDbMerge_makefile) $(bin)RootHistCnvConfDbMerge_dependencies.make

install :: RootHistCnvConfDbMergeinstall ;

RootHistCnvConfDbMergeinstall :: $(RootHistCnvConfDbMerge_dependencies) $(cmt_local_RootHistCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootHistCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootHistCnvConfDbMergeuninstall

$(foreach d,$(RootHistCnvConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += RootHistCnvConfDbMergeuninstall))

RootHistCnvConfDbMergeuninstall : $(RootHistCnvConfDbMergeuninstall_dependencies) ##$(cmt_local_RootHistCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootHistCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootHistCnvConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootHistCnvConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootHistCnvConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootHistCnvConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(RootHistCnv_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(RootHistCnv_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(RootHistCnv_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(RootHistCnv_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(RootHistCnv_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(RootHistCnv_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(RootHistCnv_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(RootHistCnv_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(RootHistCnv_tag).make
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
