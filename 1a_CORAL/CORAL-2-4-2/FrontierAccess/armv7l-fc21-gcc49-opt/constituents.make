
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

FrontierAccess_tag = $(tag)

#cmt_local_tagfile = $(FrontierAccess_tag).make
cmt_local_tagfile = $(bin)$(FrontierAccess_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)FrontierAccesssetup.make
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

cmt_lcg_FrontierAccess_has_no_target_tag = 1
cmt_lcg_FrontierAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_FrontierAccess_has_target_tag

cmt_local_tagfile_lcg_FrontierAccess = $(bin)$(FrontierAccess_tag)_lcg_FrontierAccess.make
cmt_final_setup_lcg_FrontierAccess = $(bin)setup_lcg_FrontierAccess.make
cmt_local_lcg_FrontierAccess_makefile = $(bin)lcg_FrontierAccess.make

lcg_FrontierAccess_extratags = -tag_add=target_lcg_FrontierAccess

else

cmt_local_tagfile_lcg_FrontierAccess = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_lcg_FrontierAccess = $(bin)setup.make
cmt_local_lcg_FrontierAccess_makefile = $(bin)lcg_FrontierAccess.make

endif

not_lcg_FrontierAccesscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_FrontierAccesscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_FrontierAccessdirs :
	@if test ! -d $(bin)lcg_FrontierAccess; then $(mkdir) -p $(bin)lcg_FrontierAccess; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_FrontierAccess
else
lcg_FrontierAccessdirs : ;
endif

ifdef cmt_lcg_FrontierAccess_has_target_tag

ifndef QUICK
$(cmt_local_lcg_FrontierAccess_makefile) : $(lcg_FrontierAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_FrontierAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_FrontierAccess_extratags) build constituent_config -out=$(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccess
else
$(cmt_local_lcg_FrontierAccess_makefile) : $(lcg_FrontierAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_FrontierAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_FrontierAccess) ] || \
	  $(not_lcg_FrontierAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_FrontierAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_FrontierAccess_extratags) build constituent_config -out=$(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccess; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_FrontierAccess_makefile) : $(lcg_FrontierAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_FrontierAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_FrontierAccess.in -tag=$(tags) $(lcg_FrontierAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccess
else
$(cmt_local_lcg_FrontierAccess_makefile) : $(lcg_FrontierAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_FrontierAccess.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_FrontierAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_FrontierAccess) ] || \
	  $(not_lcg_FrontierAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_FrontierAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_FrontierAccess.in -tag=$(tags) $(lcg_FrontierAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccess; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_FrontierAccess_extratags) build constituent_makefile -out=$(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccess

lcg_FrontierAccess :: lcg_FrontierAccesscompile lcg_FrontierAccessinstall ;

ifdef cmt_lcg_FrontierAccess_has_prototypes

lcg_FrontierAccessprototype : $(lcg_FrontierAccessprototype_dependencies) $(cmt_local_lcg_FrontierAccess_makefile) dirs lcg_FrontierAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_FrontierAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_FrontierAccesscompile : lcg_FrontierAccessprototype

endif

lcg_FrontierAccesscompile : $(lcg_FrontierAccesscompile_dependencies) $(cmt_local_lcg_FrontierAccess_makefile) dirs lcg_FrontierAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_FrontierAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_FrontierAccessclean ;

lcg_FrontierAccessclean :: $(lcg_FrontierAccessclean_dependencies) ##$(cmt_local_lcg_FrontierAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_FrontierAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) lcg_FrontierAccessclean

##	  /bin/rm -f $(cmt_local_lcg_FrontierAccess_makefile) $(bin)lcg_FrontierAccess_dependencies.make

install :: lcg_FrontierAccessinstall ;

lcg_FrontierAccessinstall :: lcg_FrontierAccesscompile $(lcg_FrontierAccess_dependencies) $(cmt_local_lcg_FrontierAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_FrontierAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_FrontierAccessuninstall

$(foreach d,$(lcg_FrontierAccess_dependencies),$(eval $(d)uninstall_dependencies += lcg_FrontierAccessuninstall))

lcg_FrontierAccessuninstall : $(lcg_FrontierAccessuninstall_dependencies) ##$(cmt_local_lcg_FrontierAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_FrontierAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_FrontierAccess_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_FrontierAccessuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_FrontierAccess"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_FrontierAccess done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_CmsNewFrontier_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_CmsNewFrontier_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_CmsNewFrontier_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_CmsNewFrontier = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_CmsNewFrontier.make
cmt_final_setup_test_unit_FrontierAccess_CmsNewFrontier = $(bin)setup_test_unit_FrontierAccess_CmsNewFrontier.make
cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile = $(bin)test_unit_FrontierAccess_CmsNewFrontier.make

test_unit_FrontierAccess_CmsNewFrontier_extratags = -tag_add=target_test_unit_FrontierAccess_CmsNewFrontier

else

cmt_local_tagfile_test_unit_FrontierAccess_CmsNewFrontier = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_CmsNewFrontier = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile = $(bin)test_unit_FrontierAccess_CmsNewFrontier.make

endif

not_test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_CmsNewFrontierdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_CmsNewFrontier; then $(mkdir) -p $(bin)test_unit_FrontierAccess_CmsNewFrontier; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_CmsNewFrontier
else
test_unit_FrontierAccess_CmsNewFrontierdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_CmsNewFrontier_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) : $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_CmsNewFrontier.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_CmsNewFrontier_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontier
else
$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) : $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_CmsNewFrontier) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_CmsNewFrontier) ] || \
	  $(not_test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_CmsNewFrontier.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_CmsNewFrontier_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontier; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) : $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_CmsNewFrontier.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_CmsNewFrontier.in -tag=$(tags) $(test_unit_FrontierAccess_CmsNewFrontier_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontier
else
$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) : $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_CmsNewFrontier.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_CmsNewFrontier) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_CmsNewFrontier) ] || \
	  $(not_test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_CmsNewFrontier.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_CmsNewFrontier.in -tag=$(tags) $(test_unit_FrontierAccess_CmsNewFrontier_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontier; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_CmsNewFrontier_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontier

test_unit_FrontierAccess_CmsNewFrontier :: test_unit_FrontierAccess_CmsNewFrontiercompile test_unit_FrontierAccess_CmsNewFrontierinstall ;

ifdef cmt_test_unit_FrontierAccess_CmsNewFrontier_has_prototypes

test_unit_FrontierAccess_CmsNewFrontierprototype : $(test_unit_FrontierAccess_CmsNewFrontierprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) dirs test_unit_FrontierAccess_CmsNewFrontierdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_CmsNewFrontiercompile : test_unit_FrontierAccess_CmsNewFrontierprototype

endif

test_unit_FrontierAccess_CmsNewFrontiercompile : $(test_unit_FrontierAccess_CmsNewFrontiercompile_dependencies) $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) dirs test_unit_FrontierAccess_CmsNewFrontierdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_CmsNewFrontierclean ;

test_unit_FrontierAccess_CmsNewFrontierclean :: $(test_unit_FrontierAccess_CmsNewFrontierclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) test_unit_FrontierAccess_CmsNewFrontierclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $(bin)test_unit_FrontierAccess_CmsNewFrontier_dependencies.make

install :: test_unit_FrontierAccess_CmsNewFrontierinstall ;

test_unit_FrontierAccess_CmsNewFrontierinstall :: test_unit_FrontierAccess_CmsNewFrontiercompile $(test_unit_FrontierAccess_CmsNewFrontier_dependencies) $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_CmsNewFrontieruninstall

$(foreach d,$(test_unit_FrontierAccess_CmsNewFrontier_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_CmsNewFrontieruninstall))

test_unit_FrontierAccess_CmsNewFrontieruninstall : $(test_unit_FrontierAccess_CmsNewFrontieruninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_CmsNewFrontier_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_CmsNewFrontieruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_CmsNewFrontier"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_CmsNewFrontier done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_MonitorController_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_MonitorController_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_MonitorController_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_MonitorController = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_MonitorController.make
cmt_final_setup_test_unit_FrontierAccess_MonitorController = $(bin)setup_test_unit_FrontierAccess_MonitorController.make
cmt_local_test_unit_FrontierAccess_MonitorController_makefile = $(bin)test_unit_FrontierAccess_MonitorController.make

test_unit_FrontierAccess_MonitorController_extratags = -tag_add=target_test_unit_FrontierAccess_MonitorController

else

cmt_local_tagfile_test_unit_FrontierAccess_MonitorController = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_MonitorController = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_MonitorController_makefile = $(bin)test_unit_FrontierAccess_MonitorController.make

endif

not_test_unit_FrontierAccess_MonitorControllercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_MonitorControllercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_MonitorControllerdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_MonitorController; then $(mkdir) -p $(bin)test_unit_FrontierAccess_MonitorController; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_MonitorController
else
test_unit_FrontierAccess_MonitorControllerdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_MonitorController_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) : $(test_unit_FrontierAccess_MonitorControllercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_MonitorController.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MonitorController_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorController
else
$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) : $(test_unit_FrontierAccess_MonitorControllercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_MonitorController) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_MonitorController) ] || \
	  $(not_test_unit_FrontierAccess_MonitorControllercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_MonitorController.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MonitorController_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorController; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) : $(test_unit_FrontierAccess_MonitorControllercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_MonitorController.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_MonitorController.in -tag=$(tags) $(test_unit_FrontierAccess_MonitorController_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorController
else
$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) : $(test_unit_FrontierAccess_MonitorControllercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_MonitorController.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_MonitorController) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_MonitorController) ] || \
	  $(not_test_unit_FrontierAccess_MonitorControllercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_MonitorController.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_MonitorController.in -tag=$(tags) $(test_unit_FrontierAccess_MonitorController_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorController; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MonitorController_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorController

test_unit_FrontierAccess_MonitorController :: test_unit_FrontierAccess_MonitorControllercompile test_unit_FrontierAccess_MonitorControllerinstall ;

ifdef cmt_test_unit_FrontierAccess_MonitorController_has_prototypes

test_unit_FrontierAccess_MonitorControllerprototype : $(test_unit_FrontierAccess_MonitorControllerprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) dirs test_unit_FrontierAccess_MonitorControllerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_MonitorControllercompile : test_unit_FrontierAccess_MonitorControllerprototype

endif

test_unit_FrontierAccess_MonitorControllercompile : $(test_unit_FrontierAccess_MonitorControllercompile_dependencies) $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) dirs test_unit_FrontierAccess_MonitorControllerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_MonitorControllerclean ;

test_unit_FrontierAccess_MonitorControllerclean :: $(test_unit_FrontierAccess_MonitorControllerclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) test_unit_FrontierAccess_MonitorControllerclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $(bin)test_unit_FrontierAccess_MonitorController_dependencies.make

install :: test_unit_FrontierAccess_MonitorControllerinstall ;

test_unit_FrontierAccess_MonitorControllerinstall :: test_unit_FrontierAccess_MonitorControllercompile $(test_unit_FrontierAccess_MonitorController_dependencies) $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_MonitorControlleruninstall

$(foreach d,$(test_unit_FrontierAccess_MonitorController_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_MonitorControlleruninstall))

test_unit_FrontierAccess_MonitorControlleruninstall : $(test_unit_FrontierAccess_MonitorControlleruninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_MonitorController_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MonitorController_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_MonitorControlleruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_MonitorController"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_MonitorController done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_MultipleSchemas_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_MultipleSchemas_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_MultipleSchemas_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_MultipleSchemas = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_MultipleSchemas.make
cmt_final_setup_test_unit_FrontierAccess_MultipleSchemas = $(bin)setup_test_unit_FrontierAccess_MultipleSchemas.make
cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile = $(bin)test_unit_FrontierAccess_MultipleSchemas.make

test_unit_FrontierAccess_MultipleSchemas_extratags = -tag_add=target_test_unit_FrontierAccess_MultipleSchemas

else

cmt_local_tagfile_test_unit_FrontierAccess_MultipleSchemas = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_MultipleSchemas = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile = $(bin)test_unit_FrontierAccess_MultipleSchemas.make

endif

not_test_unit_FrontierAccess_MultipleSchemascompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_MultipleSchemasdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_MultipleSchemas; then $(mkdir) -p $(bin)test_unit_FrontierAccess_MultipleSchemas; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_MultipleSchemas
else
test_unit_FrontierAccess_MultipleSchemasdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_MultipleSchemas_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) : $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemas
else
$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) : $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_MultipleSchemas) ] || \
	  $(not_test_unit_FrontierAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemas; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) : $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_FrontierAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemas
else
$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) : $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_MultipleSchemas.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_MultipleSchemas) ] || \
	  $(not_test_unit_FrontierAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_FrontierAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemas; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_MultipleSchemas_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemas

test_unit_FrontierAccess_MultipleSchemas :: test_unit_FrontierAccess_MultipleSchemascompile test_unit_FrontierAccess_MultipleSchemasinstall ;

ifdef cmt_test_unit_FrontierAccess_MultipleSchemas_has_prototypes

test_unit_FrontierAccess_MultipleSchemasprototype : $(test_unit_FrontierAccess_MultipleSchemasprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) dirs test_unit_FrontierAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_MultipleSchemascompile : test_unit_FrontierAccess_MultipleSchemasprototype

endif

test_unit_FrontierAccess_MultipleSchemascompile : $(test_unit_FrontierAccess_MultipleSchemascompile_dependencies) $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) dirs test_unit_FrontierAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_MultipleSchemasclean ;

test_unit_FrontierAccess_MultipleSchemasclean :: $(test_unit_FrontierAccess_MultipleSchemasclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) test_unit_FrontierAccess_MultipleSchemasclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $(bin)test_unit_FrontierAccess_MultipleSchemas_dependencies.make

install :: test_unit_FrontierAccess_MultipleSchemasinstall ;

test_unit_FrontierAccess_MultipleSchemasinstall :: test_unit_FrontierAccess_MultipleSchemascompile $(test_unit_FrontierAccess_MultipleSchemas_dependencies) $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_MultipleSchemasuninstall

$(foreach d,$(test_unit_FrontierAccess_MultipleSchemas_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_MultipleSchemasuninstall))

test_unit_FrontierAccess_MultipleSchemasuninstall : $(test_unit_FrontierAccess_MultipleSchemasuninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_MultipleSchemas_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_MultipleSchemasuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_MultipleSchemas"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_MultipleSchemas done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_Schema_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_Schema_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_Schema_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_Schema = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_Schema.make
cmt_final_setup_test_unit_FrontierAccess_Schema = $(bin)setup_test_unit_FrontierAccess_Schema.make
cmt_local_test_unit_FrontierAccess_Schema_makefile = $(bin)test_unit_FrontierAccess_Schema.make

test_unit_FrontierAccess_Schema_extratags = -tag_add=target_test_unit_FrontierAccess_Schema

else

cmt_local_tagfile_test_unit_FrontierAccess_Schema = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_Schema = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_Schema_makefile = $(bin)test_unit_FrontierAccess_Schema.make

endif

not_test_unit_FrontierAccess_Schemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_Schemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_Schemadirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_Schema; then $(mkdir) -p $(bin)test_unit_FrontierAccess_Schema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_Schema
else
test_unit_FrontierAccess_Schemadirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_Schema_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_Schema_makefile) : $(test_unit_FrontierAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schema
else
$(cmt_local_test_unit_FrontierAccess_Schema_makefile) : $(test_unit_FrontierAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_Schema) ] || \
	  $(not_test_unit_FrontierAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_Schema_makefile) : $(test_unit_FrontierAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_Schema.in -tag=$(tags) $(test_unit_FrontierAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schema
else
$(cmt_local_test_unit_FrontierAccess_Schema_makefile) : $(test_unit_FrontierAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_Schema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_Schema) ] || \
	  $(not_test_unit_FrontierAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_Schema.in -tag=$(tags) $(test_unit_FrontierAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_Schema_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schema

test_unit_FrontierAccess_Schema :: test_unit_FrontierAccess_Schemacompile test_unit_FrontierAccess_Schemainstall ;

ifdef cmt_test_unit_FrontierAccess_Schema_has_prototypes

test_unit_FrontierAccess_Schemaprototype : $(test_unit_FrontierAccess_Schemaprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_Schema_makefile) dirs test_unit_FrontierAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_Schemacompile : test_unit_FrontierAccess_Schemaprototype

endif

test_unit_FrontierAccess_Schemacompile : $(test_unit_FrontierAccess_Schemacompile_dependencies) $(cmt_local_test_unit_FrontierAccess_Schema_makefile) dirs test_unit_FrontierAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_Schemaclean ;

test_unit_FrontierAccess_Schemaclean :: $(test_unit_FrontierAccess_Schemaclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) test_unit_FrontierAccess_Schemaclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $(bin)test_unit_FrontierAccess_Schema_dependencies.make

install :: test_unit_FrontierAccess_Schemainstall ;

test_unit_FrontierAccess_Schemainstall :: test_unit_FrontierAccess_Schemacompile $(test_unit_FrontierAccess_Schema_dependencies) $(cmt_local_test_unit_FrontierAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_Schemauninstall

$(foreach d,$(test_unit_FrontierAccess_Schema_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_Schemauninstall))

test_unit_FrontierAccess_Schemauninstall : $(test_unit_FrontierAccess_Schemauninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_Schema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_Schemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_Schema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_Schema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_SegFault_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_SegFault_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_SegFault_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_SegFault = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_SegFault.make
cmt_final_setup_test_unit_FrontierAccess_SegFault = $(bin)setup_test_unit_FrontierAccess_SegFault.make
cmt_local_test_unit_FrontierAccess_SegFault_makefile = $(bin)test_unit_FrontierAccess_SegFault.make

test_unit_FrontierAccess_SegFault_extratags = -tag_add=target_test_unit_FrontierAccess_SegFault

else

cmt_local_tagfile_test_unit_FrontierAccess_SegFault = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_SegFault = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_SegFault_makefile = $(bin)test_unit_FrontierAccess_SegFault.make

endif

not_test_unit_FrontierAccess_SegFaultcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_SegFaultcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_SegFaultdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_SegFault; then $(mkdir) -p $(bin)test_unit_FrontierAccess_SegFault; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_SegFault
else
test_unit_FrontierAccess_SegFaultdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_SegFault_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) : $(test_unit_FrontierAccess_SegFaultcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_SegFault.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SegFault_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFault
else
$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) : $(test_unit_FrontierAccess_SegFaultcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_SegFault) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_SegFault) ] || \
	  $(not_test_unit_FrontierAccess_SegFaultcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_SegFault.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SegFault_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFault; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) : $(test_unit_FrontierAccess_SegFaultcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_SegFault.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_SegFault.in -tag=$(tags) $(test_unit_FrontierAccess_SegFault_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFault
else
$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) : $(test_unit_FrontierAccess_SegFaultcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_SegFault.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_SegFault) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_SegFault) ] || \
	  $(not_test_unit_FrontierAccess_SegFaultcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_SegFault.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_SegFault.in -tag=$(tags) $(test_unit_FrontierAccess_SegFault_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFault; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SegFault_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFault

test_unit_FrontierAccess_SegFault :: test_unit_FrontierAccess_SegFaultcompile test_unit_FrontierAccess_SegFaultinstall ;

ifdef cmt_test_unit_FrontierAccess_SegFault_has_prototypes

test_unit_FrontierAccess_SegFaultprototype : $(test_unit_FrontierAccess_SegFaultprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) dirs test_unit_FrontierAccess_SegFaultdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_SegFaultcompile : test_unit_FrontierAccess_SegFaultprototype

endif

test_unit_FrontierAccess_SegFaultcompile : $(test_unit_FrontierAccess_SegFaultcompile_dependencies) $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) dirs test_unit_FrontierAccess_SegFaultdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_SegFaultclean ;

test_unit_FrontierAccess_SegFaultclean :: $(test_unit_FrontierAccess_SegFaultclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) test_unit_FrontierAccess_SegFaultclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $(bin)test_unit_FrontierAccess_SegFault_dependencies.make

install :: test_unit_FrontierAccess_SegFaultinstall ;

test_unit_FrontierAccess_SegFaultinstall :: test_unit_FrontierAccess_SegFaultcompile $(test_unit_FrontierAccess_SegFault_dependencies) $(cmt_local_test_unit_FrontierAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_SegFaultuninstall

$(foreach d,$(test_unit_FrontierAccess_SegFault_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_SegFaultuninstall))

test_unit_FrontierAccess_SegFaultuninstall : $(test_unit_FrontierAccess_SegFaultuninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SegFault_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_SegFaultuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_SegFault"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_SegFault done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_SimpleQueries_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_SimpleQueries_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_SimpleQueries_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_SimpleQueries = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_SimpleQueries.make
cmt_final_setup_test_unit_FrontierAccess_SimpleQueries = $(bin)setup_test_unit_FrontierAccess_SimpleQueries.make
cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile = $(bin)test_unit_FrontierAccess_SimpleQueries.make

test_unit_FrontierAccess_SimpleQueries_extratags = -tag_add=target_test_unit_FrontierAccess_SimpleQueries

else

cmt_local_tagfile_test_unit_FrontierAccess_SimpleQueries = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_SimpleQueries = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile = $(bin)test_unit_FrontierAccess_SimpleQueries.make

endif

not_test_unit_FrontierAccess_SimpleQueriescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_SimpleQueriesdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_SimpleQueries; then $(mkdir) -p $(bin)test_unit_FrontierAccess_SimpleQueries; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_SimpleQueries
else
test_unit_FrontierAccess_SimpleQueriesdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_SimpleQueries_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) : $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueries
else
$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) : $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_SimpleQueries) ] || \
	  $(not_test_unit_FrontierAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueries; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) : $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_SimpleQueries.in -tag=$(tags) $(test_unit_FrontierAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueries
else
$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) : $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_SimpleQueries.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_SimpleQueries) ] || \
	  $(not_test_unit_FrontierAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_SimpleQueries.in -tag=$(tags) $(test_unit_FrontierAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueries; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_SimpleQueries_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueries

test_unit_FrontierAccess_SimpleQueries :: test_unit_FrontierAccess_SimpleQueriescompile test_unit_FrontierAccess_SimpleQueriesinstall ;

ifdef cmt_test_unit_FrontierAccess_SimpleQueries_has_prototypes

test_unit_FrontierAccess_SimpleQueriesprototype : $(test_unit_FrontierAccess_SimpleQueriesprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) dirs test_unit_FrontierAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_SimpleQueriescompile : test_unit_FrontierAccess_SimpleQueriesprototype

endif

test_unit_FrontierAccess_SimpleQueriescompile : $(test_unit_FrontierAccess_SimpleQueriescompile_dependencies) $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) dirs test_unit_FrontierAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_SimpleQueriesclean ;

test_unit_FrontierAccess_SimpleQueriesclean :: $(test_unit_FrontierAccess_SimpleQueriesclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) test_unit_FrontierAccess_SimpleQueriesclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $(bin)test_unit_FrontierAccess_SimpleQueries_dependencies.make

install :: test_unit_FrontierAccess_SimpleQueriesinstall ;

test_unit_FrontierAccess_SimpleQueriesinstall :: test_unit_FrontierAccess_SimpleQueriescompile $(test_unit_FrontierAccess_SimpleQueries_dependencies) $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_SimpleQueriesuninstall

$(foreach d,$(test_unit_FrontierAccess_SimpleQueries_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_SimpleQueriesuninstall))

test_unit_FrontierAccess_SimpleQueriesuninstall : $(test_unit_FrontierAccess_SimpleQueriesuninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_SimpleQueries_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_SimpleQueriesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_SimpleQueries"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_SimpleQueries done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_FrontierAccess_TestAlias_has_no_target_tag = 1
cmt_test_unit_FrontierAccess_TestAlias_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_FrontierAccess_TestAlias_has_target_tag

cmt_local_tagfile_test_unit_FrontierAccess_TestAlias = $(bin)$(FrontierAccess_tag)_test_unit_FrontierAccess_TestAlias.make
cmt_final_setup_test_unit_FrontierAccess_TestAlias = $(bin)setup_test_unit_FrontierAccess_TestAlias.make
cmt_local_test_unit_FrontierAccess_TestAlias_makefile = $(bin)test_unit_FrontierAccess_TestAlias.make

test_unit_FrontierAccess_TestAlias_extratags = -tag_add=target_test_unit_FrontierAccess_TestAlias

else

cmt_local_tagfile_test_unit_FrontierAccess_TestAlias = $(bin)$(FrontierAccess_tag).make
cmt_final_setup_test_unit_FrontierAccess_TestAlias = $(bin)setup.make
cmt_local_test_unit_FrontierAccess_TestAlias_makefile = $(bin)test_unit_FrontierAccess_TestAlias.make

endif

not_test_unit_FrontierAccess_TestAliascompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_FrontierAccess_TestAliascompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_FrontierAccess_TestAliasdirs :
	@if test ! -d $(bin)test_unit_FrontierAccess_TestAlias; then $(mkdir) -p $(bin)test_unit_FrontierAccess_TestAlias; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_FrontierAccess_TestAlias
else
test_unit_FrontierAccess_TestAliasdirs : ;
endif

ifdef cmt_test_unit_FrontierAccess_TestAlias_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) : $(test_unit_FrontierAccess_TestAliascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_TestAlias.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_TestAlias_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAlias
else
$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) : $(test_unit_FrontierAccess_TestAliascompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_TestAlias) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_TestAlias) ] || \
	  $(not_test_unit_FrontierAccess_TestAliascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_TestAlias.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_TestAlias_extratags) build constituent_config -out=$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAlias; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) : $(test_unit_FrontierAccess_TestAliascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_FrontierAccess_TestAlias.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_TestAlias.in -tag=$(tags) $(test_unit_FrontierAccess_TestAlias_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAlias
else
$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) : $(test_unit_FrontierAccess_TestAliascompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_FrontierAccess_TestAlias.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_FrontierAccess_TestAlias) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_FrontierAccess_TestAlias) ] || \
	  $(not_test_unit_FrontierAccess_TestAliascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_FrontierAccess_TestAlias.make"; \
	  $(cmtexe) -f=$(bin)test_unit_FrontierAccess_TestAlias.in -tag=$(tags) $(test_unit_FrontierAccess_TestAlias_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAlias; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_FrontierAccess_TestAlias_extratags) build constituent_makefile -out=$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAlias

test_unit_FrontierAccess_TestAlias :: test_unit_FrontierAccess_TestAliascompile test_unit_FrontierAccess_TestAliasinstall ;

ifdef cmt_test_unit_FrontierAccess_TestAlias_has_prototypes

test_unit_FrontierAccess_TestAliasprototype : $(test_unit_FrontierAccess_TestAliasprototype_dependencies) $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) dirs test_unit_FrontierAccess_TestAliasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_FrontierAccess_TestAliascompile : test_unit_FrontierAccess_TestAliasprototype

endif

test_unit_FrontierAccess_TestAliascompile : $(test_unit_FrontierAccess_TestAliascompile_dependencies) $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) dirs test_unit_FrontierAccess_TestAliasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_FrontierAccess_TestAliasclean ;

test_unit_FrontierAccess_TestAliasclean :: $(test_unit_FrontierAccess_TestAliasclean_dependencies) ##$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) test_unit_FrontierAccess_TestAliasclean

##	  /bin/rm -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $(bin)test_unit_FrontierAccess_TestAlias_dependencies.make

install :: test_unit_FrontierAccess_TestAliasinstall ;

test_unit_FrontierAccess_TestAliasinstall :: test_unit_FrontierAccess_TestAliascompile $(test_unit_FrontierAccess_TestAlias_dependencies) $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_FrontierAccess_TestAliasuninstall

$(foreach d,$(test_unit_FrontierAccess_TestAlias_dependencies),$(eval $(d)uninstall_dependencies += test_unit_FrontierAccess_TestAliasuninstall))

test_unit_FrontierAccess_TestAliasuninstall : $(test_unit_FrontierAccess_TestAliasuninstall_dependencies) ##$(cmt_local_test_unit_FrontierAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_FrontierAccess_TestAlias_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_FrontierAccess_TestAliasuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_FrontierAccess_TestAlias"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_FrontierAccess_TestAlias done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(FrontierAccess_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(FrontierAccess_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(FrontierAccess_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(FrontierAccess_tag).make
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

cmt_local_tagfile_make = $(bin)$(FrontierAccess_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(FrontierAccess_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(FrontierAccess_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(FrontierAccess_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(FrontierAccess_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(FrontierAccess_tag).make
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

cmt_local_tagfile_examples = $(bin)$(FrontierAccess_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(FrontierAccess_tag).make
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
