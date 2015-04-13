
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

RelationalCool_tag = $(tag)

#cmt_local_tagfile = $(RelationalCool_tag).make
cmt_local_tagfile = $(bin)$(RelationalCool_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)RelationalCoolsetup.make
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
#-- start of group ------

all_groups :: utilities

utilities :: $(utilities_dependencies)  $(utilities_pre_constituents) $(utilities_constituents)  $(utilities_post_constituents)
	$(echo) "utilities ok."

#	@/bin/echo " utilities ok."

clean :: allclean

utilitiesclean ::  $(utilities_constituentsclean)
	$(echo) $(utilities_constituentsclean)
	$(echo) "utilitiesclean ok."

#	@echo $(utilities_constituentsclean)
#	@/bin/echo " utilitiesclean ok."

#-- end of group ------
#-- start of constituent_app_lib ------

cmt_lcg_RelationalCool_has_no_target_tag = 1
cmt_lcg_RelationalCool_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_RelationalCool_has_target_tag

cmt_local_tagfile_lcg_RelationalCool = $(bin)$(RelationalCool_tag)_lcg_RelationalCool.make
cmt_final_setup_lcg_RelationalCool = $(bin)setup_lcg_RelationalCool.make
cmt_local_lcg_RelationalCool_makefile = $(bin)lcg_RelationalCool.make

lcg_RelationalCool_extratags = -tag_add=target_lcg_RelationalCool

else

cmt_local_tagfile_lcg_RelationalCool = $(bin)$(RelationalCool_tag).make
cmt_final_setup_lcg_RelationalCool = $(bin)setup.make
cmt_local_lcg_RelationalCool_makefile = $(bin)lcg_RelationalCool.make

endif

not_lcg_RelationalCoolcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_RelationalCoolcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_RelationalCooldirs :
	@if test ! -d $(bin)lcg_RelationalCool; then $(mkdir) -p $(bin)lcg_RelationalCool; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_RelationalCool
else
lcg_RelationalCooldirs : ;
endif

ifdef cmt_lcg_RelationalCool_has_target_tag

ifndef QUICK
$(cmt_local_lcg_RelationalCool_makefile) : $(lcg_RelationalCoolcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_RelationalCool.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_RelationalCool_extratags) build constituent_config -out=$(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCool
else
$(cmt_local_lcg_RelationalCool_makefile) : $(lcg_RelationalCoolcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_RelationalCool) ] || \
	  [ ! -f $(cmt_final_setup_lcg_RelationalCool) ] || \
	  $(not_lcg_RelationalCoolcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_RelationalCool.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_RelationalCool_extratags) build constituent_config -out=$(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCool; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_RelationalCool_makefile) : $(lcg_RelationalCoolcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_RelationalCool.make"; \
	  $(cmtexe) -f=$(bin)lcg_RelationalCool.in -tag=$(tags) $(lcg_RelationalCool_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCool
else
$(cmt_local_lcg_RelationalCool_makefile) : $(lcg_RelationalCoolcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_RelationalCool.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_RelationalCool) ] || \
	  [ ! -f $(cmt_final_setup_lcg_RelationalCool) ] || \
	  $(not_lcg_RelationalCoolcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_RelationalCool.make"; \
	  $(cmtexe) -f=$(bin)lcg_RelationalCool.in -tag=$(tags) $(lcg_RelationalCool_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCool; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_RelationalCool_extratags) build constituent_makefile -out=$(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCool

lcg_RelationalCool :: lcg_RelationalCoolcompile lcg_RelationalCoolinstall ;

ifdef cmt_lcg_RelationalCool_has_prototypes

lcg_RelationalCoolprototype : $(lcg_RelationalCoolprototype_dependencies) $(cmt_local_lcg_RelationalCool_makefile) dirs lcg_RelationalCooldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_RelationalCool_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_RelationalCoolcompile : lcg_RelationalCoolprototype

endif

lcg_RelationalCoolcompile : $(lcg_RelationalCoolcompile_dependencies) $(cmt_local_lcg_RelationalCool_makefile) dirs lcg_RelationalCooldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_RelationalCool_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_RelationalCoolclean ;

lcg_RelationalCoolclean :: $(lcg_RelationalCoolclean_dependencies) ##$(cmt_local_lcg_RelationalCool_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_RelationalCool_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) lcg_RelationalCoolclean

##	  /bin/rm -f $(cmt_local_lcg_RelationalCool_makefile) $(bin)lcg_RelationalCool_dependencies.make

install :: lcg_RelationalCoolinstall ;

lcg_RelationalCoolinstall :: lcg_RelationalCoolcompile $(lcg_RelationalCool_dependencies) $(cmt_local_lcg_RelationalCool_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_RelationalCool_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_RelationalCooluninstall

$(foreach d,$(lcg_RelationalCool_dependencies),$(eval $(d)uninstall_dependencies += lcg_RelationalCooluninstall))

lcg_RelationalCooluninstall : $(lcg_RelationalCooluninstall_dependencies) ##$(cmt_local_lcg_RelationalCool_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_RelationalCool_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_RelationalCool_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_RelationalCooluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_RelationalCool"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_RelationalCool done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_ChannelSelection_has_no_target_tag = 1
cmt_test_RelationalCool_ChannelSelection_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_ChannelSelection_has_target_tag

cmt_local_tagfile_test_RelationalCool_ChannelSelection = $(bin)$(RelationalCool_tag)_test_RelationalCool_ChannelSelection.make
cmt_final_setup_test_RelationalCool_ChannelSelection = $(bin)setup_test_RelationalCool_ChannelSelection.make
cmt_local_test_RelationalCool_ChannelSelection_makefile = $(bin)test_RelationalCool_ChannelSelection.make

test_RelationalCool_ChannelSelection_extratags = -tag_add=target_test_RelationalCool_ChannelSelection

else

cmt_local_tagfile_test_RelationalCool_ChannelSelection = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_ChannelSelection = $(bin)setup.make
cmt_local_test_RelationalCool_ChannelSelection_makefile = $(bin)test_RelationalCool_ChannelSelection.make

endif

not_test_RelationalCool_ChannelSelectioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_ChannelSelectioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_ChannelSelectiondirs :
	@if test ! -d $(bin)test_RelationalCool_ChannelSelection; then $(mkdir) -p $(bin)test_RelationalCool_ChannelSelection; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_ChannelSelection
else
test_RelationalCool_ChannelSelectiondirs : ;
endif

ifdef cmt_test_RelationalCool_ChannelSelection_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_ChannelSelection_makefile) : $(test_RelationalCool_ChannelSelectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_ChannelSelection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ChannelSelection_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelection
else
$(cmt_local_test_RelationalCool_ChannelSelection_makefile) : $(test_RelationalCool_ChannelSelectioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_ChannelSelection) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_ChannelSelection) ] || \
	  $(not_test_RelationalCool_ChannelSelectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_ChannelSelection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ChannelSelection_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelection; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_ChannelSelection_makefile) : $(test_RelationalCool_ChannelSelectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_ChannelSelection.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_ChannelSelection.in -tag=$(tags) $(test_RelationalCool_ChannelSelection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelection
else
$(cmt_local_test_RelationalCool_ChannelSelection_makefile) : $(test_RelationalCool_ChannelSelectioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_ChannelSelection.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_ChannelSelection) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_ChannelSelection) ] || \
	  $(not_test_RelationalCool_ChannelSelectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_ChannelSelection.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_ChannelSelection.in -tag=$(tags) $(test_RelationalCool_ChannelSelection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelection; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ChannelSelection_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelection

test_RelationalCool_ChannelSelection :: test_RelationalCool_ChannelSelectioncompile test_RelationalCool_ChannelSelectioninstall ;

ifdef cmt_test_RelationalCool_ChannelSelection_has_prototypes

test_RelationalCool_ChannelSelectionprototype : $(test_RelationalCool_ChannelSelectionprototype_dependencies) $(cmt_local_test_RelationalCool_ChannelSelection_makefile) dirs test_RelationalCool_ChannelSelectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_ChannelSelectioncompile : test_RelationalCool_ChannelSelectionprototype

endif

test_RelationalCool_ChannelSelectioncompile : $(test_RelationalCool_ChannelSelectioncompile_dependencies) $(cmt_local_test_RelationalCool_ChannelSelection_makefile) dirs test_RelationalCool_ChannelSelectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_ChannelSelectionclean ;

test_RelationalCool_ChannelSelectionclean :: $(test_RelationalCool_ChannelSelectionclean_dependencies) ##$(cmt_local_test_RelationalCool_ChannelSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) test_RelationalCool_ChannelSelectionclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $(bin)test_RelationalCool_ChannelSelection_dependencies.make

install :: test_RelationalCool_ChannelSelectioninstall ;

test_RelationalCool_ChannelSelectioninstall :: test_RelationalCool_ChannelSelectioncompile $(test_RelationalCool_ChannelSelection_dependencies) $(cmt_local_test_RelationalCool_ChannelSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_ChannelSelectionuninstall

$(foreach d,$(test_RelationalCool_ChannelSelection_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_ChannelSelectionuninstall))

test_RelationalCool_ChannelSelectionuninstall : $(test_RelationalCool_ChannelSelectionuninstall_dependencies) ##$(cmt_local_test_RelationalCool_ChannelSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ChannelSelection_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_ChannelSelectionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_ChannelSelection"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_ChannelSelection done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_PayloadSpecification_has_no_target_tag = 1
cmt_test_RelationalCool_PayloadSpecification_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_PayloadSpecification_has_target_tag

cmt_local_tagfile_test_RelationalCool_PayloadSpecification = $(bin)$(RelationalCool_tag)_test_RelationalCool_PayloadSpecification.make
cmt_final_setup_test_RelationalCool_PayloadSpecification = $(bin)setup_test_RelationalCool_PayloadSpecification.make
cmt_local_test_RelationalCool_PayloadSpecification_makefile = $(bin)test_RelationalCool_PayloadSpecification.make

test_RelationalCool_PayloadSpecification_extratags = -tag_add=target_test_RelationalCool_PayloadSpecification

else

cmt_local_tagfile_test_RelationalCool_PayloadSpecification = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_PayloadSpecification = $(bin)setup.make
cmt_local_test_RelationalCool_PayloadSpecification_makefile = $(bin)test_RelationalCool_PayloadSpecification.make

endif

not_test_RelationalCool_PayloadSpecificationcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_PayloadSpecificationcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_PayloadSpecificationdirs :
	@if test ! -d $(bin)test_RelationalCool_PayloadSpecification; then $(mkdir) -p $(bin)test_RelationalCool_PayloadSpecification; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_PayloadSpecification
else
test_RelationalCool_PayloadSpecificationdirs : ;
endif

ifdef cmt_test_RelationalCool_PayloadSpecification_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) : $(test_RelationalCool_PayloadSpecificationcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_PayloadSpecification.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_PayloadSpecification_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecification
else
$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) : $(test_RelationalCool_PayloadSpecificationcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_PayloadSpecification) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_PayloadSpecification) ] || \
	  $(not_test_RelationalCool_PayloadSpecificationcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_PayloadSpecification.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_PayloadSpecification_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecification; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) : $(test_RelationalCool_PayloadSpecificationcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_PayloadSpecification.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_PayloadSpecification.in -tag=$(tags) $(test_RelationalCool_PayloadSpecification_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecification
else
$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) : $(test_RelationalCool_PayloadSpecificationcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_PayloadSpecification.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_PayloadSpecification) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_PayloadSpecification) ] || \
	  $(not_test_RelationalCool_PayloadSpecificationcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_PayloadSpecification.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_PayloadSpecification.in -tag=$(tags) $(test_RelationalCool_PayloadSpecification_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecification; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_PayloadSpecification_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecification

test_RelationalCool_PayloadSpecification :: test_RelationalCool_PayloadSpecificationcompile test_RelationalCool_PayloadSpecificationinstall ;

ifdef cmt_test_RelationalCool_PayloadSpecification_has_prototypes

test_RelationalCool_PayloadSpecificationprototype : $(test_RelationalCool_PayloadSpecificationprototype_dependencies) $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) dirs test_RelationalCool_PayloadSpecificationdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_PayloadSpecificationcompile : test_RelationalCool_PayloadSpecificationprototype

endif

test_RelationalCool_PayloadSpecificationcompile : $(test_RelationalCool_PayloadSpecificationcompile_dependencies) $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) dirs test_RelationalCool_PayloadSpecificationdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_PayloadSpecificationclean ;

test_RelationalCool_PayloadSpecificationclean :: $(test_RelationalCool_PayloadSpecificationclean_dependencies) ##$(cmt_local_test_RelationalCool_PayloadSpecification_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) test_RelationalCool_PayloadSpecificationclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $(bin)test_RelationalCool_PayloadSpecification_dependencies.make

install :: test_RelationalCool_PayloadSpecificationinstall ;

test_RelationalCool_PayloadSpecificationinstall :: test_RelationalCool_PayloadSpecificationcompile $(test_RelationalCool_PayloadSpecification_dependencies) $(cmt_local_test_RelationalCool_PayloadSpecification_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_PayloadSpecificationuninstall

$(foreach d,$(test_RelationalCool_PayloadSpecification_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_PayloadSpecificationuninstall))

test_RelationalCool_PayloadSpecificationuninstall : $(test_RelationalCool_PayloadSpecificationuninstall_dependencies) ##$(cmt_local_test_RelationalCool_PayloadSpecification_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_PayloadSpecification_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_PayloadSpecificationuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_PayloadSpecification"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_PayloadSpecification done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_VersionNumber_has_no_target_tag = 1
cmt_test_RelationalCool_VersionNumber_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_VersionNumber_has_target_tag

cmt_local_tagfile_test_RelationalCool_VersionNumber = $(bin)$(RelationalCool_tag)_test_RelationalCool_VersionNumber.make
cmt_final_setup_test_RelationalCool_VersionNumber = $(bin)setup_test_RelationalCool_VersionNumber.make
cmt_local_test_RelationalCool_VersionNumber_makefile = $(bin)test_RelationalCool_VersionNumber.make

test_RelationalCool_VersionNumber_extratags = -tag_add=target_test_RelationalCool_VersionNumber

else

cmt_local_tagfile_test_RelationalCool_VersionNumber = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_VersionNumber = $(bin)setup.make
cmt_local_test_RelationalCool_VersionNumber_makefile = $(bin)test_RelationalCool_VersionNumber.make

endif

not_test_RelationalCool_VersionNumbercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_VersionNumbercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_VersionNumberdirs :
	@if test ! -d $(bin)test_RelationalCool_VersionNumber; then $(mkdir) -p $(bin)test_RelationalCool_VersionNumber; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_VersionNumber
else
test_RelationalCool_VersionNumberdirs : ;
endif

ifdef cmt_test_RelationalCool_VersionNumber_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_VersionNumber_makefile) : $(test_RelationalCool_VersionNumbercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_VersionNumber.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_VersionNumber_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumber
else
$(cmt_local_test_RelationalCool_VersionNumber_makefile) : $(test_RelationalCool_VersionNumbercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_VersionNumber) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_VersionNumber) ] || \
	  $(not_test_RelationalCool_VersionNumbercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_VersionNumber.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_VersionNumber_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumber; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_VersionNumber_makefile) : $(test_RelationalCool_VersionNumbercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_VersionNumber.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_VersionNumber.in -tag=$(tags) $(test_RelationalCool_VersionNumber_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumber
else
$(cmt_local_test_RelationalCool_VersionNumber_makefile) : $(test_RelationalCool_VersionNumbercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_VersionNumber.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_VersionNumber) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_VersionNumber) ] || \
	  $(not_test_RelationalCool_VersionNumbercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_VersionNumber.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_VersionNumber.in -tag=$(tags) $(test_RelationalCool_VersionNumber_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumber; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_VersionNumber_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumber

test_RelationalCool_VersionNumber :: test_RelationalCool_VersionNumbercompile test_RelationalCool_VersionNumberinstall ;

ifdef cmt_test_RelationalCool_VersionNumber_has_prototypes

test_RelationalCool_VersionNumberprototype : $(test_RelationalCool_VersionNumberprototype_dependencies) $(cmt_local_test_RelationalCool_VersionNumber_makefile) dirs test_RelationalCool_VersionNumberdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_VersionNumber_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_VersionNumbercompile : test_RelationalCool_VersionNumberprototype

endif

test_RelationalCool_VersionNumbercompile : $(test_RelationalCool_VersionNumbercompile_dependencies) $(cmt_local_test_RelationalCool_VersionNumber_makefile) dirs test_RelationalCool_VersionNumberdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_VersionNumber_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_VersionNumberclean ;

test_RelationalCool_VersionNumberclean :: $(test_RelationalCool_VersionNumberclean_dependencies) ##$(cmt_local_test_RelationalCool_VersionNumber_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_VersionNumber_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) test_RelationalCool_VersionNumberclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $(bin)test_RelationalCool_VersionNumber_dependencies.make

install :: test_RelationalCool_VersionNumberinstall ;

test_RelationalCool_VersionNumberinstall :: test_RelationalCool_VersionNumbercompile $(test_RelationalCool_VersionNumber_dependencies) $(cmt_local_test_RelationalCool_VersionNumber_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_VersionNumber_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_VersionNumberuninstall

$(foreach d,$(test_RelationalCool_VersionNumber_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_VersionNumberuninstall))

test_RelationalCool_VersionNumberuninstall : $(test_RelationalCool_VersionNumberuninstall_dependencies) ##$(cmt_local_test_RelationalCool_VersionNumber_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_VersionNumber_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_VersionNumber_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_VersionNumberuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_VersionNumber"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_VersionNumber done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_HvsPathHandler_has_no_target_tag = 1
cmt_test_RelationalCool_HvsPathHandler_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_HvsPathHandler_has_target_tag

cmt_local_tagfile_test_RelationalCool_HvsPathHandler = $(bin)$(RelationalCool_tag)_test_RelationalCool_HvsPathHandler.make
cmt_final_setup_test_RelationalCool_HvsPathHandler = $(bin)setup_test_RelationalCool_HvsPathHandler.make
cmt_local_test_RelationalCool_HvsPathHandler_makefile = $(bin)test_RelationalCool_HvsPathHandler.make

test_RelationalCool_HvsPathHandler_extratags = -tag_add=target_test_RelationalCool_HvsPathHandler

else

cmt_local_tagfile_test_RelationalCool_HvsPathHandler = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_HvsPathHandler = $(bin)setup.make
cmt_local_test_RelationalCool_HvsPathHandler_makefile = $(bin)test_RelationalCool_HvsPathHandler.make

endif

not_test_RelationalCool_HvsPathHandlercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_HvsPathHandlercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_HvsPathHandlerdirs :
	@if test ! -d $(bin)test_RelationalCool_HvsPathHandler; then $(mkdir) -p $(bin)test_RelationalCool_HvsPathHandler; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_HvsPathHandler
else
test_RelationalCool_HvsPathHandlerdirs : ;
endif

ifdef cmt_test_RelationalCool_HvsPathHandler_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) : $(test_RelationalCool_HvsPathHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_HvsPathHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsPathHandler_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandler
else
$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) : $(test_RelationalCool_HvsPathHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_HvsPathHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_HvsPathHandler) ] || \
	  $(not_test_RelationalCool_HvsPathHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_HvsPathHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsPathHandler_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandler; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) : $(test_RelationalCool_HvsPathHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_HvsPathHandler.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_HvsPathHandler.in -tag=$(tags) $(test_RelationalCool_HvsPathHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandler
else
$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) : $(test_RelationalCool_HvsPathHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_HvsPathHandler.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_HvsPathHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_HvsPathHandler) ] || \
	  $(not_test_RelationalCool_HvsPathHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_HvsPathHandler.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_HvsPathHandler.in -tag=$(tags) $(test_RelationalCool_HvsPathHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandler; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsPathHandler_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandler

test_RelationalCool_HvsPathHandler :: test_RelationalCool_HvsPathHandlercompile test_RelationalCool_HvsPathHandlerinstall ;

ifdef cmt_test_RelationalCool_HvsPathHandler_has_prototypes

test_RelationalCool_HvsPathHandlerprototype : $(test_RelationalCool_HvsPathHandlerprototype_dependencies) $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) dirs test_RelationalCool_HvsPathHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_HvsPathHandlercompile : test_RelationalCool_HvsPathHandlerprototype

endif

test_RelationalCool_HvsPathHandlercompile : $(test_RelationalCool_HvsPathHandlercompile_dependencies) $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) dirs test_RelationalCool_HvsPathHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_HvsPathHandlerclean ;

test_RelationalCool_HvsPathHandlerclean :: $(test_RelationalCool_HvsPathHandlerclean_dependencies) ##$(cmt_local_test_RelationalCool_HvsPathHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) test_RelationalCool_HvsPathHandlerclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $(bin)test_RelationalCool_HvsPathHandler_dependencies.make

install :: test_RelationalCool_HvsPathHandlerinstall ;

test_RelationalCool_HvsPathHandlerinstall :: test_RelationalCool_HvsPathHandlercompile $(test_RelationalCool_HvsPathHandler_dependencies) $(cmt_local_test_RelationalCool_HvsPathHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_HvsPathHandleruninstall

$(foreach d,$(test_RelationalCool_HvsPathHandler_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_HvsPathHandleruninstall))

test_RelationalCool_HvsPathHandleruninstall : $(test_RelationalCool_HvsPathHandleruninstall_dependencies) ##$(cmt_local_test_RelationalCool_HvsPathHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsPathHandler_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_HvsPathHandleruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_HvsPathHandler"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_HvsPathHandler done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalDatabaseId_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalDatabaseId_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalDatabaseId_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalDatabaseId = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalDatabaseId.make
cmt_final_setup_test_RelationalCool_RelationalDatabaseId = $(bin)setup_test_RelationalCool_RelationalDatabaseId.make
cmt_local_test_RelationalCool_RelationalDatabaseId_makefile = $(bin)test_RelationalCool_RelationalDatabaseId.make

test_RelationalCool_RelationalDatabaseId_extratags = -tag_add=target_test_RelationalCool_RelationalDatabaseId

else

cmt_local_tagfile_test_RelationalCool_RelationalDatabaseId = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalDatabaseId = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalDatabaseId_makefile = $(bin)test_RelationalCool_RelationalDatabaseId.make

endif

not_test_RelationalCool_RelationalDatabaseIdcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalDatabaseIddirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalDatabaseId; then $(mkdir) -p $(bin)test_RelationalCool_RelationalDatabaseId; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalDatabaseId
else
test_RelationalCool_RelationalDatabaseIddirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalDatabaseId_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) : $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalDatabaseId.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalDatabaseId_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseId
else
$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) : $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalDatabaseId) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalDatabaseId) ] || \
	  $(not_test_RelationalCool_RelationalDatabaseIdcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalDatabaseId.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalDatabaseId_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseId; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) : $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalDatabaseId.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalDatabaseId.in -tag=$(tags) $(test_RelationalCool_RelationalDatabaseId_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseId
else
$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) : $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalDatabaseId.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalDatabaseId) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalDatabaseId) ] || \
	  $(not_test_RelationalCool_RelationalDatabaseIdcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalDatabaseId.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalDatabaseId.in -tag=$(tags) $(test_RelationalCool_RelationalDatabaseId_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseId; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalDatabaseId_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseId

test_RelationalCool_RelationalDatabaseId :: test_RelationalCool_RelationalDatabaseIdcompile test_RelationalCool_RelationalDatabaseIdinstall ;

ifdef cmt_test_RelationalCool_RelationalDatabaseId_has_prototypes

test_RelationalCool_RelationalDatabaseIdprototype : $(test_RelationalCool_RelationalDatabaseIdprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) dirs test_RelationalCool_RelationalDatabaseIddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalDatabaseIdcompile : test_RelationalCool_RelationalDatabaseIdprototype

endif

test_RelationalCool_RelationalDatabaseIdcompile : $(test_RelationalCool_RelationalDatabaseIdcompile_dependencies) $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) dirs test_RelationalCool_RelationalDatabaseIddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalDatabaseIdclean ;

test_RelationalCool_RelationalDatabaseIdclean :: $(test_RelationalCool_RelationalDatabaseIdclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) test_RelationalCool_RelationalDatabaseIdclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $(bin)test_RelationalCool_RelationalDatabaseId_dependencies.make

install :: test_RelationalCool_RelationalDatabaseIdinstall ;

test_RelationalCool_RelationalDatabaseIdinstall :: test_RelationalCool_RelationalDatabaseIdcompile $(test_RelationalCool_RelationalDatabaseId_dependencies) $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalDatabaseIduninstall

$(foreach d,$(test_RelationalCool_RelationalDatabaseId_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalDatabaseIduninstall))

test_RelationalCool_RelationalDatabaseIduninstall : $(test_RelationalCool_RelationalDatabaseIduninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalDatabaseId_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalDatabaseIduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalDatabaseId"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalDatabaseId done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_ObjectId_has_no_target_tag = 1
cmt_test_RelationalCool_ObjectId_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_ObjectId_has_target_tag

cmt_local_tagfile_test_RelationalCool_ObjectId = $(bin)$(RelationalCool_tag)_test_RelationalCool_ObjectId.make
cmt_final_setup_test_RelationalCool_ObjectId = $(bin)setup_test_RelationalCool_ObjectId.make
cmt_local_test_RelationalCool_ObjectId_makefile = $(bin)test_RelationalCool_ObjectId.make

test_RelationalCool_ObjectId_extratags = -tag_add=target_test_RelationalCool_ObjectId

else

cmt_local_tagfile_test_RelationalCool_ObjectId = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_ObjectId = $(bin)setup.make
cmt_local_test_RelationalCool_ObjectId_makefile = $(bin)test_RelationalCool_ObjectId.make

endif

not_test_RelationalCool_ObjectIdcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_ObjectIdcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_ObjectIddirs :
	@if test ! -d $(bin)test_RelationalCool_ObjectId; then $(mkdir) -p $(bin)test_RelationalCool_ObjectId; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_ObjectId
else
test_RelationalCool_ObjectIddirs : ;
endif

ifdef cmt_test_RelationalCool_ObjectId_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_ObjectId_makefile) : $(test_RelationalCool_ObjectIdcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_ObjectId.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ObjectId_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectId
else
$(cmt_local_test_RelationalCool_ObjectId_makefile) : $(test_RelationalCool_ObjectIdcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_ObjectId) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_ObjectId) ] || \
	  $(not_test_RelationalCool_ObjectIdcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_ObjectId.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ObjectId_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectId; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_ObjectId_makefile) : $(test_RelationalCool_ObjectIdcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_ObjectId.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_ObjectId.in -tag=$(tags) $(test_RelationalCool_ObjectId_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectId
else
$(cmt_local_test_RelationalCool_ObjectId_makefile) : $(test_RelationalCool_ObjectIdcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_ObjectId.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_ObjectId) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_ObjectId) ] || \
	  $(not_test_RelationalCool_ObjectIdcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_ObjectId.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_ObjectId.in -tag=$(tags) $(test_RelationalCool_ObjectId_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectId; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_ObjectId_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectId

test_RelationalCool_ObjectId :: test_RelationalCool_ObjectIdcompile test_RelationalCool_ObjectIdinstall ;

ifdef cmt_test_RelationalCool_ObjectId_has_prototypes

test_RelationalCool_ObjectIdprototype : $(test_RelationalCool_ObjectIdprototype_dependencies) $(cmt_local_test_RelationalCool_ObjectId_makefile) dirs test_RelationalCool_ObjectIddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ObjectId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_ObjectIdcompile : test_RelationalCool_ObjectIdprototype

endif

test_RelationalCool_ObjectIdcompile : $(test_RelationalCool_ObjectIdcompile_dependencies) $(cmt_local_test_RelationalCool_ObjectId_makefile) dirs test_RelationalCool_ObjectIddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ObjectId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_ObjectIdclean ;

test_RelationalCool_ObjectIdclean :: $(test_RelationalCool_ObjectIdclean_dependencies) ##$(cmt_local_test_RelationalCool_ObjectId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_ObjectId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) test_RelationalCool_ObjectIdclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $(bin)test_RelationalCool_ObjectId_dependencies.make

install :: test_RelationalCool_ObjectIdinstall ;

test_RelationalCool_ObjectIdinstall :: test_RelationalCool_ObjectIdcompile $(test_RelationalCool_ObjectId_dependencies) $(cmt_local_test_RelationalCool_ObjectId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_ObjectId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_ObjectIduninstall

$(foreach d,$(test_RelationalCool_ObjectId_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_ObjectIduninstall))

test_RelationalCool_ObjectIduninstall : $(test_RelationalCool_ObjectIduninstall_dependencies) ##$(cmt_local_test_RelationalCool_ObjectId_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_ObjectId_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_ObjectId_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_ObjectIduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_ObjectId"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_ObjectId done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_utility_methods_has_no_target_tag = 1
cmt_test_RelationalCool_utility_methods_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_utility_methods_has_target_tag

cmt_local_tagfile_test_RelationalCool_utility_methods = $(bin)$(RelationalCool_tag)_test_RelationalCool_utility_methods.make
cmt_final_setup_test_RelationalCool_utility_methods = $(bin)setup_test_RelationalCool_utility_methods.make
cmt_local_test_RelationalCool_utility_methods_makefile = $(bin)test_RelationalCool_utility_methods.make

test_RelationalCool_utility_methods_extratags = -tag_add=target_test_RelationalCool_utility_methods

else

cmt_local_tagfile_test_RelationalCool_utility_methods = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_utility_methods = $(bin)setup.make
cmt_local_test_RelationalCool_utility_methods_makefile = $(bin)test_RelationalCool_utility_methods.make

endif

not_test_RelationalCool_utility_methodscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_utility_methodscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_utility_methodsdirs :
	@if test ! -d $(bin)test_RelationalCool_utility_methods; then $(mkdir) -p $(bin)test_RelationalCool_utility_methods; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_utility_methods
else
test_RelationalCool_utility_methodsdirs : ;
endif

ifdef cmt_test_RelationalCool_utility_methods_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_utility_methods_makefile) : $(test_RelationalCool_utility_methodscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_utility_methods.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_utility_methods_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methods
else
$(cmt_local_test_RelationalCool_utility_methods_makefile) : $(test_RelationalCool_utility_methodscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_utility_methods) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_utility_methods) ] || \
	  $(not_test_RelationalCool_utility_methodscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_utility_methods.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_utility_methods_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methods; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_utility_methods_makefile) : $(test_RelationalCool_utility_methodscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_utility_methods.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_utility_methods.in -tag=$(tags) $(test_RelationalCool_utility_methods_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methods
else
$(cmt_local_test_RelationalCool_utility_methods_makefile) : $(test_RelationalCool_utility_methodscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_utility_methods.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_utility_methods) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_utility_methods) ] || \
	  $(not_test_RelationalCool_utility_methodscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_utility_methods.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_utility_methods.in -tag=$(tags) $(test_RelationalCool_utility_methods_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methods; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_utility_methods_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methods

test_RelationalCool_utility_methods :: test_RelationalCool_utility_methodscompile test_RelationalCool_utility_methodsinstall ;

ifdef cmt_test_RelationalCool_utility_methods_has_prototypes

test_RelationalCool_utility_methodsprototype : $(test_RelationalCool_utility_methodsprototype_dependencies) $(cmt_local_test_RelationalCool_utility_methods_makefile) dirs test_RelationalCool_utility_methodsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_utility_methods_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_utility_methodscompile : test_RelationalCool_utility_methodsprototype

endif

test_RelationalCool_utility_methodscompile : $(test_RelationalCool_utility_methodscompile_dependencies) $(cmt_local_test_RelationalCool_utility_methods_makefile) dirs test_RelationalCool_utility_methodsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_utility_methods_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_utility_methodsclean ;

test_RelationalCool_utility_methodsclean :: $(test_RelationalCool_utility_methodsclean_dependencies) ##$(cmt_local_test_RelationalCool_utility_methods_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_utility_methods_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) test_RelationalCool_utility_methodsclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $(bin)test_RelationalCool_utility_methods_dependencies.make

install :: test_RelationalCool_utility_methodsinstall ;

test_RelationalCool_utility_methodsinstall :: test_RelationalCool_utility_methodscompile $(test_RelationalCool_utility_methods_dependencies) $(cmt_local_test_RelationalCool_utility_methods_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_utility_methods_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_utility_methodsuninstall

$(foreach d,$(test_RelationalCool_utility_methods_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_utility_methodsuninstall))

test_RelationalCool_utility_methodsuninstall : $(test_RelationalCool_utility_methodsuninstall_dependencies) ##$(cmt_local_test_RelationalCool_utility_methods_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_utility_methods_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_utility_methods_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_utility_methodsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_utility_methods"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_utility_methods done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_Channels_has_no_target_tag = 1
cmt_test_RelationalCool_Channels_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_Channels_has_target_tag

cmt_local_tagfile_test_RelationalCool_Channels = $(bin)$(RelationalCool_tag)_test_RelationalCool_Channels.make
cmt_final_setup_test_RelationalCool_Channels = $(bin)setup_test_RelationalCool_Channels.make
cmt_local_test_RelationalCool_Channels_makefile = $(bin)test_RelationalCool_Channels.make

test_RelationalCool_Channels_extratags = -tag_add=target_test_RelationalCool_Channels

else

cmt_local_tagfile_test_RelationalCool_Channels = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_Channels = $(bin)setup.make
cmt_local_test_RelationalCool_Channels_makefile = $(bin)test_RelationalCool_Channels.make

endif

not_test_RelationalCool_Channelscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_Channelscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_Channelsdirs :
	@if test ! -d $(bin)test_RelationalCool_Channels; then $(mkdir) -p $(bin)test_RelationalCool_Channels; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_Channels
else
test_RelationalCool_Channelsdirs : ;
endif

ifdef cmt_test_RelationalCool_Channels_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_Channels_makefile) : $(test_RelationalCool_Channelscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_Channels.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_Channels_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channels
else
$(cmt_local_test_RelationalCool_Channels_makefile) : $(test_RelationalCool_Channelscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_Channels) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_Channels) ] || \
	  $(not_test_RelationalCool_Channelscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_Channels.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_Channels_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channels; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_Channels_makefile) : $(test_RelationalCool_Channelscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_Channels.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_Channels.in -tag=$(tags) $(test_RelationalCool_Channels_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channels
else
$(cmt_local_test_RelationalCool_Channels_makefile) : $(test_RelationalCool_Channelscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_Channels.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_Channels) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_Channels) ] || \
	  $(not_test_RelationalCool_Channelscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_Channels.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_Channels.in -tag=$(tags) $(test_RelationalCool_Channels_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channels; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_Channels_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channels

test_RelationalCool_Channels :: test_RelationalCool_Channelscompile test_RelationalCool_Channelsinstall ;

ifdef cmt_test_RelationalCool_Channels_has_prototypes

test_RelationalCool_Channelsprototype : $(test_RelationalCool_Channelsprototype_dependencies) $(cmt_local_test_RelationalCool_Channels_makefile) dirs test_RelationalCool_Channelsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_Channels_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_Channelscompile : test_RelationalCool_Channelsprototype

endif

test_RelationalCool_Channelscompile : $(test_RelationalCool_Channelscompile_dependencies) $(cmt_local_test_RelationalCool_Channels_makefile) dirs test_RelationalCool_Channelsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_Channels_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_Channelsclean ;

test_RelationalCool_Channelsclean :: $(test_RelationalCool_Channelsclean_dependencies) ##$(cmt_local_test_RelationalCool_Channels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_Channels_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) test_RelationalCool_Channelsclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_Channels_makefile) $(bin)test_RelationalCool_Channels_dependencies.make

install :: test_RelationalCool_Channelsinstall ;

test_RelationalCool_Channelsinstall :: test_RelationalCool_Channelscompile $(test_RelationalCool_Channels_dependencies) $(cmt_local_test_RelationalCool_Channels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_Channels_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_Channelsuninstall

$(foreach d,$(test_RelationalCool_Channels_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_Channelsuninstall))

test_RelationalCool_Channelsuninstall : $(test_RelationalCool_Channelsuninstall_dependencies) ##$(cmt_local_test_RelationalCool_Channels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_Channels_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_Channels_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_Channelsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_Channels"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_Channels done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_HvsTags_has_no_target_tag = 1
cmt_test_RelationalCool_HvsTags_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_HvsTags_has_target_tag

cmt_local_tagfile_test_RelationalCool_HvsTags = $(bin)$(RelationalCool_tag)_test_RelationalCool_HvsTags.make
cmt_final_setup_test_RelationalCool_HvsTags = $(bin)setup_test_RelationalCool_HvsTags.make
cmt_local_test_RelationalCool_HvsTags_makefile = $(bin)test_RelationalCool_HvsTags.make

test_RelationalCool_HvsTags_extratags = -tag_add=target_test_RelationalCool_HvsTags

else

cmt_local_tagfile_test_RelationalCool_HvsTags = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_HvsTags = $(bin)setup.make
cmt_local_test_RelationalCool_HvsTags_makefile = $(bin)test_RelationalCool_HvsTags.make

endif

not_test_RelationalCool_HvsTagscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_HvsTagscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_HvsTagsdirs :
	@if test ! -d $(bin)test_RelationalCool_HvsTags; then $(mkdir) -p $(bin)test_RelationalCool_HvsTags; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_HvsTags
else
test_RelationalCool_HvsTagsdirs : ;
endif

ifdef cmt_test_RelationalCool_HvsTags_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_HvsTags_makefile) : $(test_RelationalCool_HvsTagscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_HvsTags.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsTags_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTags
else
$(cmt_local_test_RelationalCool_HvsTags_makefile) : $(test_RelationalCool_HvsTagscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_HvsTags) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_HvsTags) ] || \
	  $(not_test_RelationalCool_HvsTagscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_HvsTags.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsTags_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTags; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_HvsTags_makefile) : $(test_RelationalCool_HvsTagscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_HvsTags.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_HvsTags.in -tag=$(tags) $(test_RelationalCool_HvsTags_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTags
else
$(cmt_local_test_RelationalCool_HvsTags_makefile) : $(test_RelationalCool_HvsTagscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_HvsTags.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_HvsTags) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_HvsTags) ] || \
	  $(not_test_RelationalCool_HvsTagscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_HvsTags.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_HvsTags.in -tag=$(tags) $(test_RelationalCool_HvsTags_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTags; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_HvsTags_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTags

test_RelationalCool_HvsTags :: test_RelationalCool_HvsTagscompile test_RelationalCool_HvsTagsinstall ;

ifdef cmt_test_RelationalCool_HvsTags_has_prototypes

test_RelationalCool_HvsTagsprototype : $(test_RelationalCool_HvsTagsprototype_dependencies) $(cmt_local_test_RelationalCool_HvsTags_makefile) dirs test_RelationalCool_HvsTagsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsTags_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_HvsTagscompile : test_RelationalCool_HvsTagsprototype

endif

test_RelationalCool_HvsTagscompile : $(test_RelationalCool_HvsTagscompile_dependencies) $(cmt_local_test_RelationalCool_HvsTags_makefile) dirs test_RelationalCool_HvsTagsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsTags_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_HvsTagsclean ;

test_RelationalCool_HvsTagsclean :: $(test_RelationalCool_HvsTagsclean_dependencies) ##$(cmt_local_test_RelationalCool_HvsTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_HvsTags_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) test_RelationalCool_HvsTagsclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $(bin)test_RelationalCool_HvsTags_dependencies.make

install :: test_RelationalCool_HvsTagsinstall ;

test_RelationalCool_HvsTagsinstall :: test_RelationalCool_HvsTagscompile $(test_RelationalCool_HvsTags_dependencies) $(cmt_local_test_RelationalCool_HvsTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_HvsTags_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_HvsTagsuninstall

$(foreach d,$(test_RelationalCool_HvsTags_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_HvsTagsuninstall))

test_RelationalCool_HvsTagsuninstall : $(test_RelationalCool_HvsTagsuninstall_dependencies) ##$(cmt_local_test_RelationalCool_HvsTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_HvsTags_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_HvsTags_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_HvsTagsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_HvsTags"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_HvsTags done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RalDatabase_has_no_target_tag = 1
cmt_test_RelationalCool_RalDatabase_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RalDatabase_has_target_tag

cmt_local_tagfile_test_RelationalCool_RalDatabase = $(bin)$(RelationalCool_tag)_test_RelationalCool_RalDatabase.make
cmt_final_setup_test_RelationalCool_RalDatabase = $(bin)setup_test_RelationalCool_RalDatabase.make
cmt_local_test_RelationalCool_RalDatabase_makefile = $(bin)test_RelationalCool_RalDatabase.make

test_RelationalCool_RalDatabase_extratags = -tag_add=target_test_RelationalCool_RalDatabase

else

cmt_local_tagfile_test_RelationalCool_RalDatabase = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RalDatabase = $(bin)setup.make
cmt_local_test_RelationalCool_RalDatabase_makefile = $(bin)test_RelationalCool_RalDatabase.make

endif

not_test_RelationalCool_RalDatabasecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RalDatabasecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RalDatabasedirs :
	@if test ! -d $(bin)test_RelationalCool_RalDatabase; then $(mkdir) -p $(bin)test_RelationalCool_RalDatabase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RalDatabase
else
test_RelationalCool_RalDatabasedirs : ;
endif

ifdef cmt_test_RelationalCool_RalDatabase_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabase_makefile) : $(test_RelationalCool_RalDatabasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabase
else
$(cmt_local_test_RelationalCool_RalDatabase_makefile) : $(test_RelationalCool_RalDatabasecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabase) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabase) ] || \
	  $(not_test_RelationalCool_RalDatabasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabase_makefile) : $(test_RelationalCool_RalDatabasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabase.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabase.in -tag=$(tags) $(test_RelationalCool_RalDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabase
else
$(cmt_local_test_RelationalCool_RalDatabase_makefile) : $(test_RelationalCool_RalDatabasecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RalDatabase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabase) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabase) ] || \
	  $(not_test_RelationalCool_RalDatabasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabase.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabase.in -tag=$(tags) $(test_RelationalCool_RalDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabase

test_RelationalCool_RalDatabase :: test_RelationalCool_RalDatabasecompile test_RelationalCool_RalDatabaseinstall ;

ifdef cmt_test_RelationalCool_RalDatabase_has_prototypes

test_RelationalCool_RalDatabaseprototype : $(test_RelationalCool_RalDatabaseprototype_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_makefile) dirs test_RelationalCool_RalDatabasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RalDatabasecompile : test_RelationalCool_RalDatabaseprototype

endif

test_RelationalCool_RalDatabasecompile : $(test_RelationalCool_RalDatabasecompile_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_makefile) dirs test_RelationalCool_RalDatabasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RalDatabaseclean ;

test_RelationalCool_RalDatabaseclean :: $(test_RelationalCool_RalDatabaseclean_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) test_RelationalCool_RalDatabaseclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $(bin)test_RelationalCool_RalDatabase_dependencies.make

install :: test_RelationalCool_RalDatabaseinstall ;

test_RelationalCool_RalDatabaseinstall :: test_RelationalCool_RalDatabasecompile $(test_RelationalCool_RalDatabase_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RalDatabaseuninstall

$(foreach d,$(test_RelationalCool_RalDatabase_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RalDatabaseuninstall))

test_RelationalCool_RalDatabaseuninstall : $(test_RelationalCool_RalDatabaseuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RalDatabaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RalDatabase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RalDatabase done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RalDatabase_extendedSpec_has_no_target_tag = 1
cmt_test_RelationalCool_RalDatabase_extendedSpec_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RalDatabase_extendedSpec_has_target_tag

cmt_local_tagfile_test_RelationalCool_RalDatabase_extendedSpec = $(bin)$(RelationalCool_tag)_test_RelationalCool_RalDatabase_extendedSpec.make
cmt_final_setup_test_RelationalCool_RalDatabase_extendedSpec = $(bin)setup_test_RelationalCool_RalDatabase_extendedSpec.make
cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile = $(bin)test_RelationalCool_RalDatabase_extendedSpec.make

test_RelationalCool_RalDatabase_extendedSpec_extratags = -tag_add=target_test_RelationalCool_RalDatabase_extendedSpec

else

cmt_local_tagfile_test_RelationalCool_RalDatabase_extendedSpec = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RalDatabase_extendedSpec = $(bin)setup.make
cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile = $(bin)test_RelationalCool_RalDatabase_extendedSpec.make

endif

not_test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RalDatabase_extendedSpecdirs :
	@if test ! -d $(bin)test_RelationalCool_RalDatabase_extendedSpec; then $(mkdir) -p $(bin)test_RelationalCool_RalDatabase_extendedSpec; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RalDatabase_extendedSpec
else
test_RelationalCool_RalDatabase_extendedSpecdirs : ;
endif

ifdef cmt_test_RelationalCool_RalDatabase_extendedSpec_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) : $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabase_extendedSpec.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extendedSpec_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpec
else
$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) : $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabase_extendedSpec) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabase_extendedSpec) ] || \
	  $(not_test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabase_extendedSpec.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extendedSpec_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpec; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) : $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabase_extendedSpec.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabase_extendedSpec.in -tag=$(tags) $(test_RelationalCool_RalDatabase_extendedSpec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpec
else
$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) : $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RalDatabase_extendedSpec.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabase_extendedSpec) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabase_extendedSpec) ] || \
	  $(not_test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabase_extendedSpec.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabase_extendedSpec.in -tag=$(tags) $(test_RelationalCool_RalDatabase_extendedSpec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpec; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabase_extendedSpec_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpec

test_RelationalCool_RalDatabase_extendedSpec :: test_RelationalCool_RalDatabase_extendedSpeccompile test_RelationalCool_RalDatabase_extendedSpecinstall ;

ifdef cmt_test_RelationalCool_RalDatabase_extendedSpec_has_prototypes

test_RelationalCool_RalDatabase_extendedSpecprototype : $(test_RelationalCool_RalDatabase_extendedSpecprototype_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) dirs test_RelationalCool_RalDatabase_extendedSpecdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RalDatabase_extendedSpeccompile : test_RelationalCool_RalDatabase_extendedSpecprototype

endif

test_RelationalCool_RalDatabase_extendedSpeccompile : $(test_RelationalCool_RalDatabase_extendedSpeccompile_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) dirs test_RelationalCool_RalDatabase_extendedSpecdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RalDatabase_extendedSpecclean ;

test_RelationalCool_RalDatabase_extendedSpecclean :: $(test_RelationalCool_RalDatabase_extendedSpecclean_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) test_RelationalCool_RalDatabase_extendedSpecclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $(bin)test_RelationalCool_RalDatabase_extendedSpec_dependencies.make

install :: test_RelationalCool_RalDatabase_extendedSpecinstall ;

test_RelationalCool_RalDatabase_extendedSpecinstall :: test_RelationalCool_RalDatabase_extendedSpeccompile $(test_RelationalCool_RalDatabase_extendedSpec_dependencies) $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RalDatabase_extendedSpecuninstall

$(foreach d,$(test_RelationalCool_RalDatabase_extendedSpec_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RalDatabase_extendedSpecuninstall))

test_RelationalCool_RalDatabase_extendedSpecuninstall : $(test_RelationalCool_RalDatabase_extendedSpecuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabase_extendedSpec_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RalDatabase_extendedSpecuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RalDatabase_extendedSpec"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RalDatabase_extendedSpec done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RalDatabaseSvc_has_no_target_tag = 1
cmt_test_RelationalCool_RalDatabaseSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RalDatabaseSvc_has_target_tag

cmt_local_tagfile_test_RelationalCool_RalDatabaseSvc = $(bin)$(RelationalCool_tag)_test_RelationalCool_RalDatabaseSvc.make
cmt_final_setup_test_RelationalCool_RalDatabaseSvc = $(bin)setup_test_RelationalCool_RalDatabaseSvc.make
cmt_local_test_RelationalCool_RalDatabaseSvc_makefile = $(bin)test_RelationalCool_RalDatabaseSvc.make

test_RelationalCool_RalDatabaseSvc_extratags = -tag_add=target_test_RelationalCool_RalDatabaseSvc

else

cmt_local_tagfile_test_RelationalCool_RalDatabaseSvc = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RalDatabaseSvc = $(bin)setup.make
cmt_local_test_RelationalCool_RalDatabaseSvc_makefile = $(bin)test_RelationalCool_RalDatabaseSvc.make

endif

not_test_RelationalCool_RalDatabaseSvccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RalDatabaseSvccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RalDatabaseSvcdirs :
	@if test ! -d $(bin)test_RelationalCool_RalDatabaseSvc; then $(mkdir) -p $(bin)test_RelationalCool_RalDatabaseSvc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RalDatabaseSvc
else
test_RelationalCool_RalDatabaseSvcdirs : ;
endif

ifdef cmt_test_RelationalCool_RalDatabaseSvc_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) : $(test_RelationalCool_RalDatabaseSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabaseSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabaseSvc_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvc
else
$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) : $(test_RelationalCool_RalDatabaseSvccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabaseSvc) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabaseSvc) ] || \
	  $(not_test_RelationalCool_RalDatabaseSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabaseSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabaseSvc_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) : $(test_RelationalCool_RalDatabaseSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalDatabaseSvc.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabaseSvc.in -tag=$(tags) $(test_RelationalCool_RalDatabaseSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvc
else
$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) : $(test_RelationalCool_RalDatabaseSvccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RalDatabaseSvc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalDatabaseSvc) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalDatabaseSvc) ] || \
	  $(not_test_RelationalCool_RalDatabaseSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalDatabaseSvc.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalDatabaseSvc.in -tag=$(tags) $(test_RelationalCool_RalDatabaseSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalDatabaseSvc_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvc

test_RelationalCool_RalDatabaseSvc :: test_RelationalCool_RalDatabaseSvccompile test_RelationalCool_RalDatabaseSvcinstall ;

ifdef cmt_test_RelationalCool_RalDatabaseSvc_has_prototypes

test_RelationalCool_RalDatabaseSvcprototype : $(test_RelationalCool_RalDatabaseSvcprototype_dependencies) $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) dirs test_RelationalCool_RalDatabaseSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RalDatabaseSvccompile : test_RelationalCool_RalDatabaseSvcprototype

endif

test_RelationalCool_RalDatabaseSvccompile : $(test_RelationalCool_RalDatabaseSvccompile_dependencies) $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) dirs test_RelationalCool_RalDatabaseSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RalDatabaseSvcclean ;

test_RelationalCool_RalDatabaseSvcclean :: $(test_RelationalCool_RalDatabaseSvcclean_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) test_RelationalCool_RalDatabaseSvcclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $(bin)test_RelationalCool_RalDatabaseSvc_dependencies.make

install :: test_RelationalCool_RalDatabaseSvcinstall ;

test_RelationalCool_RalDatabaseSvcinstall :: test_RelationalCool_RalDatabaseSvccompile $(test_RelationalCool_RalDatabaseSvc_dependencies) $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RalDatabaseSvcuninstall

$(foreach d,$(test_RelationalCool_RalDatabaseSvc_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RalDatabaseSvcuninstall))

test_RelationalCool_RalDatabaseSvcuninstall : $(test_RelationalCool_RalDatabaseSvcuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalDatabaseSvc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RalDatabaseSvcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RalDatabaseSvc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RalDatabaseSvc done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RalSequence_has_no_target_tag = 1
cmt_test_RelationalCool_RalSequence_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RalSequence_has_target_tag

cmt_local_tagfile_test_RelationalCool_RalSequence = $(bin)$(RelationalCool_tag)_test_RelationalCool_RalSequence.make
cmt_final_setup_test_RelationalCool_RalSequence = $(bin)setup_test_RelationalCool_RalSequence.make
cmt_local_test_RelationalCool_RalSequence_makefile = $(bin)test_RelationalCool_RalSequence.make

test_RelationalCool_RalSequence_extratags = -tag_add=target_test_RelationalCool_RalSequence

else

cmt_local_tagfile_test_RelationalCool_RalSequence = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RalSequence = $(bin)setup.make
cmt_local_test_RelationalCool_RalSequence_makefile = $(bin)test_RelationalCool_RalSequence.make

endif

not_test_RelationalCool_RalSequencecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RalSequencecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RalSequencedirs :
	@if test ! -d $(bin)test_RelationalCool_RalSequence; then $(mkdir) -p $(bin)test_RelationalCool_RalSequence; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RalSequence
else
test_RelationalCool_RalSequencedirs : ;
endif

ifdef cmt_test_RelationalCool_RalSequence_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RalSequence_makefile) : $(test_RelationalCool_RalSequencecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalSequence.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalSequence_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequence
else
$(cmt_local_test_RelationalCool_RalSequence_makefile) : $(test_RelationalCool_RalSequencecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalSequence) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalSequence) ] || \
	  $(not_test_RelationalCool_RalSequencecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalSequence.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalSequence_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequence; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RalSequence_makefile) : $(test_RelationalCool_RalSequencecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RalSequence.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalSequence.in -tag=$(tags) $(test_RelationalCool_RalSequence_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequence
else
$(cmt_local_test_RelationalCool_RalSequence_makefile) : $(test_RelationalCool_RalSequencecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RalSequence.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RalSequence) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RalSequence) ] || \
	  $(not_test_RelationalCool_RalSequencecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RalSequence.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RalSequence.in -tag=$(tags) $(test_RelationalCool_RalSequence_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequence; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RalSequence_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequence

test_RelationalCool_RalSequence :: test_RelationalCool_RalSequencecompile test_RelationalCool_RalSequenceinstall ;

ifdef cmt_test_RelationalCool_RalSequence_has_prototypes

test_RelationalCool_RalSequenceprototype : $(test_RelationalCool_RalSequenceprototype_dependencies) $(cmt_local_test_RelationalCool_RalSequence_makefile) dirs test_RelationalCool_RalSequencedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalSequence_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RalSequencecompile : test_RelationalCool_RalSequenceprototype

endif

test_RelationalCool_RalSequencecompile : $(test_RelationalCool_RalSequencecompile_dependencies) $(cmt_local_test_RelationalCool_RalSequence_makefile) dirs test_RelationalCool_RalSequencedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalSequence_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RalSequenceclean ;

test_RelationalCool_RalSequenceclean :: $(test_RelationalCool_RalSequenceclean_dependencies) ##$(cmt_local_test_RelationalCool_RalSequence_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalSequence_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) test_RelationalCool_RalSequenceclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $(bin)test_RelationalCool_RalSequence_dependencies.make

install :: test_RelationalCool_RalSequenceinstall ;

test_RelationalCool_RalSequenceinstall :: test_RelationalCool_RalSequencecompile $(test_RelationalCool_RalSequence_dependencies) $(cmt_local_test_RelationalCool_RalSequence_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RalSequence_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RalSequenceuninstall

$(foreach d,$(test_RelationalCool_RalSequence_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RalSequenceuninstall))

test_RelationalCool_RalSequenceuninstall : $(test_RelationalCool_RalSequenceuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RalSequence_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RalSequence_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RalSequence_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RalSequenceuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RalSequence"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RalSequence done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalFolder_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalFolder_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalFolder_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalFolder = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalFolder.make
cmt_final_setup_test_RelationalCool_RelationalFolder = $(bin)setup_test_RelationalCool_RelationalFolder.make
cmt_local_test_RelationalCool_RelationalFolder_makefile = $(bin)test_RelationalCool_RelationalFolder.make

test_RelationalCool_RelationalFolder_extratags = -tag_add=target_test_RelationalCool_RelationalFolder

else

cmt_local_tagfile_test_RelationalCool_RelationalFolder = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalFolder = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalFolder_makefile = $(bin)test_RelationalCool_RelationalFolder.make

endif

not_test_RelationalCool_RelationalFoldercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalFoldercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalFolderdirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalFolder; then $(mkdir) -p $(bin)test_RelationalCool_RelationalFolder; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalFolder
else
test_RelationalCool_RelationalFolderdirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalFolder_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalFolder_makefile) : $(test_RelationalCool_RelationalFoldercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalFolder.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolder_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolder
else
$(cmt_local_test_RelationalCool_RelationalFolder_makefile) : $(test_RelationalCool_RelationalFoldercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalFolder) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalFolder) ] || \
	  $(not_test_RelationalCool_RelationalFoldercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalFolder.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolder_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolder; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalFolder_makefile) : $(test_RelationalCool_RelationalFoldercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalFolder.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalFolder.in -tag=$(tags) $(test_RelationalCool_RelationalFolder_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolder
else
$(cmt_local_test_RelationalCool_RelationalFolder_makefile) : $(test_RelationalCool_RelationalFoldercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalFolder.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalFolder) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalFolder) ] || \
	  $(not_test_RelationalCool_RelationalFoldercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalFolder.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalFolder.in -tag=$(tags) $(test_RelationalCool_RelationalFolder_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolder; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolder_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolder

test_RelationalCool_RelationalFolder :: test_RelationalCool_RelationalFoldercompile test_RelationalCool_RelationalFolderinstall ;

ifdef cmt_test_RelationalCool_RelationalFolder_has_prototypes

test_RelationalCool_RelationalFolderprototype : $(test_RelationalCool_RelationalFolderprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalFolder_makefile) dirs test_RelationalCool_RelationalFolderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalFoldercompile : test_RelationalCool_RelationalFolderprototype

endif

test_RelationalCool_RelationalFoldercompile : $(test_RelationalCool_RelationalFoldercompile_dependencies) $(cmt_local_test_RelationalCool_RelationalFolder_makefile) dirs test_RelationalCool_RelationalFolderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalFolderclean ;

test_RelationalCool_RelationalFolderclean :: $(test_RelationalCool_RelationalFolderclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalFolder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) test_RelationalCool_RelationalFolderclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $(bin)test_RelationalCool_RelationalFolder_dependencies.make

install :: test_RelationalCool_RelationalFolderinstall ;

test_RelationalCool_RelationalFolderinstall :: test_RelationalCool_RelationalFoldercompile $(test_RelationalCool_RelationalFolder_dependencies) $(cmt_local_test_RelationalCool_RelationalFolder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalFolderuninstall

$(foreach d,$(test_RelationalCool_RelationalFolder_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalFolderuninstall))

test_RelationalCool_RelationalFolderuninstall : $(test_RelationalCool_RelationalFolderuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalFolder_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolder_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalFolderuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalFolder"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalFolder done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalFolderSet_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalFolderSet_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalFolderSet_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalFolderSet = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalFolderSet.make
cmt_final_setup_test_RelationalCool_RelationalFolderSet = $(bin)setup_test_RelationalCool_RelationalFolderSet.make
cmt_local_test_RelationalCool_RelationalFolderSet_makefile = $(bin)test_RelationalCool_RelationalFolderSet.make

test_RelationalCool_RelationalFolderSet_extratags = -tag_add=target_test_RelationalCool_RelationalFolderSet

else

cmt_local_tagfile_test_RelationalCool_RelationalFolderSet = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalFolderSet = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalFolderSet_makefile = $(bin)test_RelationalCool_RelationalFolderSet.make

endif

not_test_RelationalCool_RelationalFolderSetcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalFolderSetcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalFolderSetdirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalFolderSet; then $(mkdir) -p $(bin)test_RelationalCool_RelationalFolderSet; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalFolderSet
else
test_RelationalCool_RelationalFolderSetdirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalFolderSet_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) : $(test_RelationalCool_RelationalFolderSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalFolderSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolderSet_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSet
else
$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) : $(test_RelationalCool_RelationalFolderSetcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalFolderSet) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalFolderSet) ] || \
	  $(not_test_RelationalCool_RelationalFolderSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalFolderSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolderSet_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSet; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) : $(test_RelationalCool_RelationalFolderSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalFolderSet.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalFolderSet.in -tag=$(tags) $(test_RelationalCool_RelationalFolderSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSet
else
$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) : $(test_RelationalCool_RelationalFolderSetcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalFolderSet.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalFolderSet) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalFolderSet) ] || \
	  $(not_test_RelationalCool_RelationalFolderSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalFolderSet.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalFolderSet.in -tag=$(tags) $(test_RelationalCool_RelationalFolderSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSet; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalFolderSet_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSet

test_RelationalCool_RelationalFolderSet :: test_RelationalCool_RelationalFolderSetcompile test_RelationalCool_RelationalFolderSetinstall ;

ifdef cmt_test_RelationalCool_RelationalFolderSet_has_prototypes

test_RelationalCool_RelationalFolderSetprototype : $(test_RelationalCool_RelationalFolderSetprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) dirs test_RelationalCool_RelationalFolderSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalFolderSetcompile : test_RelationalCool_RelationalFolderSetprototype

endif

test_RelationalCool_RelationalFolderSetcompile : $(test_RelationalCool_RelationalFolderSetcompile_dependencies) $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) dirs test_RelationalCool_RelationalFolderSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalFolderSetclean ;

test_RelationalCool_RelationalFolderSetclean :: $(test_RelationalCool_RelationalFolderSetclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) test_RelationalCool_RelationalFolderSetclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $(bin)test_RelationalCool_RelationalFolderSet_dependencies.make

install :: test_RelationalCool_RelationalFolderSetinstall ;

test_RelationalCool_RelationalFolderSetinstall :: test_RelationalCool_RelationalFolderSetcompile $(test_RelationalCool_RelationalFolderSet_dependencies) $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalFolderSetuninstall

$(foreach d,$(test_RelationalCool_RelationalFolderSet_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalFolderSetuninstall))

test_RelationalCool_RelationalFolderSetuninstall : $(test_RelationalCool_RelationalFolderSetuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalFolderSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalFolderSet_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalFolderSetuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalFolderSet"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalFolderSet done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalObjectIterator_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalObjectIterator_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalObjectIterator_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalObjectIterator = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalObjectIterator.make
cmt_final_setup_test_RelationalCool_RelationalObjectIterator = $(bin)setup_test_RelationalCool_RelationalObjectIterator.make
cmt_local_test_RelationalCool_RelationalObjectIterator_makefile = $(bin)test_RelationalCool_RelationalObjectIterator.make

test_RelationalCool_RelationalObjectIterator_extratags = -tag_add=target_test_RelationalCool_RelationalObjectIterator

else

cmt_local_tagfile_test_RelationalCool_RelationalObjectIterator = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalObjectIterator = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalObjectIterator_makefile = $(bin)test_RelationalCool_RelationalObjectIterator.make

endif

not_test_RelationalCool_RelationalObjectIteratorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalObjectIteratordirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalObjectIterator; then $(mkdir) -p $(bin)test_RelationalCool_RelationalObjectIterator; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalObjectIterator
else
test_RelationalCool_RelationalObjectIteratordirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalObjectIterator_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) : $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectIterator.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectIterator_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIterator
else
$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) : $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectIterator) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectIterator) ] || \
	  $(not_test_RelationalCool_RelationalObjectIteratorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectIterator.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectIterator_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIterator; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) : $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectIterator.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectIterator.in -tag=$(tags) $(test_RelationalCool_RelationalObjectIterator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIterator
else
$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) : $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalObjectIterator.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectIterator) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectIterator) ] || \
	  $(not_test_RelationalCool_RelationalObjectIteratorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectIterator.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectIterator.in -tag=$(tags) $(test_RelationalCool_RelationalObjectIterator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIterator; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectIterator_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIterator

test_RelationalCool_RelationalObjectIterator :: test_RelationalCool_RelationalObjectIteratorcompile test_RelationalCool_RelationalObjectIteratorinstall ;

ifdef cmt_test_RelationalCool_RelationalObjectIterator_has_prototypes

test_RelationalCool_RelationalObjectIteratorprototype : $(test_RelationalCool_RelationalObjectIteratorprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) dirs test_RelationalCool_RelationalObjectIteratordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalObjectIteratorcompile : test_RelationalCool_RelationalObjectIteratorprototype

endif

test_RelationalCool_RelationalObjectIteratorcompile : $(test_RelationalCool_RelationalObjectIteratorcompile_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) dirs test_RelationalCool_RelationalObjectIteratordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalObjectIteratorclean ;

test_RelationalCool_RelationalObjectIteratorclean :: $(test_RelationalCool_RelationalObjectIteratorclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) test_RelationalCool_RelationalObjectIteratorclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $(bin)test_RelationalCool_RelationalObjectIterator_dependencies.make

install :: test_RelationalCool_RelationalObjectIteratorinstall ;

test_RelationalCool_RelationalObjectIteratorinstall :: test_RelationalCool_RelationalObjectIteratorcompile $(test_RelationalCool_RelationalObjectIterator_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalObjectIteratoruninstall

$(foreach d,$(test_RelationalCool_RelationalObjectIterator_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalObjectIteratoruninstall))

test_RelationalCool_RelationalObjectIteratoruninstall : $(test_RelationalCool_RelationalObjectIteratoruninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectIterator_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalObjectIteratoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalObjectIterator"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalObjectIterator done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalObjectMgr_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalObjectMgr_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalObjectMgr_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalObjectMgr = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalObjectMgr.make
cmt_final_setup_test_RelationalCool_RelationalObjectMgr = $(bin)setup_test_RelationalCool_RelationalObjectMgr.make
cmt_local_test_RelationalCool_RelationalObjectMgr_makefile = $(bin)test_RelationalCool_RelationalObjectMgr.make

test_RelationalCool_RelationalObjectMgr_extratags = -tag_add=target_test_RelationalCool_RelationalObjectMgr

else

cmt_local_tagfile_test_RelationalCool_RelationalObjectMgr = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalObjectMgr = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalObjectMgr_makefile = $(bin)test_RelationalCool_RelationalObjectMgr.make

endif

not_test_RelationalCool_RelationalObjectMgrcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalObjectMgrcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalObjectMgrdirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalObjectMgr; then $(mkdir) -p $(bin)test_RelationalCool_RelationalObjectMgr; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalObjectMgr
else
test_RelationalCool_RelationalObjectMgrdirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalObjectMgr_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) : $(test_RelationalCool_RelationalObjectMgrcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectMgr.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectMgr_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgr
else
$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) : $(test_RelationalCool_RelationalObjectMgrcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectMgr) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectMgr) ] || \
	  $(not_test_RelationalCool_RelationalObjectMgrcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectMgr.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectMgr_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgr; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) : $(test_RelationalCool_RelationalObjectMgrcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectMgr.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectMgr.in -tag=$(tags) $(test_RelationalCool_RelationalObjectMgr_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgr
else
$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) : $(test_RelationalCool_RelationalObjectMgrcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalObjectMgr.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectMgr) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectMgr) ] || \
	  $(not_test_RelationalCool_RelationalObjectMgrcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectMgr.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectMgr.in -tag=$(tags) $(test_RelationalCool_RelationalObjectMgr_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgr; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectMgr_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgr

test_RelationalCool_RelationalObjectMgr :: test_RelationalCool_RelationalObjectMgrcompile test_RelationalCool_RelationalObjectMgrinstall ;

ifdef cmt_test_RelationalCool_RelationalObjectMgr_has_prototypes

test_RelationalCool_RelationalObjectMgrprototype : $(test_RelationalCool_RelationalObjectMgrprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) dirs test_RelationalCool_RelationalObjectMgrdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalObjectMgrcompile : test_RelationalCool_RelationalObjectMgrprototype

endif

test_RelationalCool_RelationalObjectMgrcompile : $(test_RelationalCool_RelationalObjectMgrcompile_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) dirs test_RelationalCool_RelationalObjectMgrdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalObjectMgrclean ;

test_RelationalCool_RelationalObjectMgrclean :: $(test_RelationalCool_RelationalObjectMgrclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) test_RelationalCool_RelationalObjectMgrclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $(bin)test_RelationalCool_RelationalObjectMgr_dependencies.make

install :: test_RelationalCool_RelationalObjectMgrinstall ;

test_RelationalCool_RelationalObjectMgrinstall :: test_RelationalCool_RelationalObjectMgrcompile $(test_RelationalCool_RelationalObjectMgr_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalObjectMgruninstall

$(foreach d,$(test_RelationalCool_RelationalObjectMgr_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalObjectMgruninstall))

test_RelationalCool_RelationalObjectMgruninstall : $(test_RelationalCool_RelationalObjectMgruninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectMgr_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalObjectMgruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalObjectMgr"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalObjectMgr done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalObjectSet_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalObjectSet_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalObjectSet_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalObjectSet = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalObjectSet.make
cmt_final_setup_test_RelationalCool_RelationalObjectSet = $(bin)setup_test_RelationalCool_RelationalObjectSet.make
cmt_local_test_RelationalCool_RelationalObjectSet_makefile = $(bin)test_RelationalCool_RelationalObjectSet.make

test_RelationalCool_RelationalObjectSet_extratags = -tag_add=target_test_RelationalCool_RelationalObjectSet

else

cmt_local_tagfile_test_RelationalCool_RelationalObjectSet = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalObjectSet = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalObjectSet_makefile = $(bin)test_RelationalCool_RelationalObjectSet.make

endif

not_test_RelationalCool_RelationalObjectSetcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalObjectSetcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalObjectSetdirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalObjectSet; then $(mkdir) -p $(bin)test_RelationalCool_RelationalObjectSet; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalObjectSet
else
test_RelationalCool_RelationalObjectSetdirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalObjectSet_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) : $(test_RelationalCool_RelationalObjectSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectSet_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSet
else
$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) : $(test_RelationalCool_RelationalObjectSetcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectSet) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectSet) ] || \
	  $(not_test_RelationalCool_RelationalObjectSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectSet.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectSet_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSet; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) : $(test_RelationalCool_RelationalObjectSetcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectSet.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectSet.in -tag=$(tags) $(test_RelationalCool_RelationalObjectSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSet
else
$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) : $(test_RelationalCool_RelationalObjectSetcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalObjectSet.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectSet) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectSet) ] || \
	  $(not_test_RelationalCool_RelationalObjectSetcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectSet.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectSet.in -tag=$(tags) $(test_RelationalCool_RelationalObjectSet_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSet; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectSet_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSet

test_RelationalCool_RelationalObjectSet :: test_RelationalCool_RelationalObjectSetcompile test_RelationalCool_RelationalObjectSetinstall ;

ifdef cmt_test_RelationalCool_RelationalObjectSet_has_prototypes

test_RelationalCool_RelationalObjectSetprototype : $(test_RelationalCool_RelationalObjectSetprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) dirs test_RelationalCool_RelationalObjectSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalObjectSetcompile : test_RelationalCool_RelationalObjectSetprototype

endif

test_RelationalCool_RelationalObjectSetcompile : $(test_RelationalCool_RelationalObjectSetcompile_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) dirs test_RelationalCool_RelationalObjectSetdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalObjectSetclean ;

test_RelationalCool_RelationalObjectSetclean :: $(test_RelationalCool_RelationalObjectSetclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) test_RelationalCool_RelationalObjectSetclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $(bin)test_RelationalCool_RelationalObjectSet_dependencies.make

install :: test_RelationalCool_RelationalObjectSetinstall ;

test_RelationalCool_RelationalObjectSetinstall :: test_RelationalCool_RelationalObjectSetcompile $(test_RelationalCool_RelationalObjectSet_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalObjectSetuninstall

$(foreach d,$(test_RelationalCool_RelationalObjectSet_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalObjectSetuninstall))

test_RelationalCool_RelationalObjectSetuninstall : $(test_RelationalCool_RelationalObjectSetuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectSet_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectSet_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalObjectSetuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalObjectSet"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalObjectSet done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_RelationalCool_RelationalObjectTable_has_no_target_tag = 1
cmt_test_RelationalCool_RelationalObjectTable_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_RelationalCool_RelationalObjectTable_has_target_tag

cmt_local_tagfile_test_RelationalCool_RelationalObjectTable = $(bin)$(RelationalCool_tag)_test_RelationalCool_RelationalObjectTable.make
cmt_final_setup_test_RelationalCool_RelationalObjectTable = $(bin)setup_test_RelationalCool_RelationalObjectTable.make
cmt_local_test_RelationalCool_RelationalObjectTable_makefile = $(bin)test_RelationalCool_RelationalObjectTable.make

test_RelationalCool_RelationalObjectTable_extratags = -tag_add=target_test_RelationalCool_RelationalObjectTable

else

cmt_local_tagfile_test_RelationalCool_RelationalObjectTable = $(bin)$(RelationalCool_tag).make
cmt_final_setup_test_RelationalCool_RelationalObjectTable = $(bin)setup.make
cmt_local_test_RelationalCool_RelationalObjectTable_makefile = $(bin)test_RelationalCool_RelationalObjectTable.make

endif

not_test_RelationalCool_RelationalObjectTablecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_RelationalCool_RelationalObjectTablecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_RelationalCool_RelationalObjectTabledirs :
	@if test ! -d $(bin)test_RelationalCool_RelationalObjectTable; then $(mkdir) -p $(bin)test_RelationalCool_RelationalObjectTable; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_RelationalCool_RelationalObjectTable
else
test_RelationalCool_RelationalObjectTabledirs : ;
endif

ifdef cmt_test_RelationalCool_RelationalObjectTable_has_target_tag

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) : $(test_RelationalCool_RelationalObjectTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectTable_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTable
else
$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) : $(test_RelationalCool_RelationalObjectTablecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectTable) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectTable) ] || \
	  $(not_test_RelationalCool_RelationalObjectTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectTable_extratags) build constituent_config -out=$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTable; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) : $(test_RelationalCool_RelationalObjectTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_RelationalCool_RelationalObjectTable.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectTable.in -tag=$(tags) $(test_RelationalCool_RelationalObjectTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTable
else
$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) : $(test_RelationalCool_RelationalObjectTablecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_RelationalCool_RelationalObjectTable.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_RelationalCool_RelationalObjectTable) ] || \
	  [ ! -f $(cmt_final_setup_test_RelationalCool_RelationalObjectTable) ] || \
	  $(not_test_RelationalCool_RelationalObjectTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_RelationalCool_RelationalObjectTable.make"; \
	  $(cmtexe) -f=$(bin)test_RelationalCool_RelationalObjectTable.in -tag=$(tags) $(test_RelationalCool_RelationalObjectTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTable; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_RelationalCool_RelationalObjectTable_extratags) build constituent_makefile -out=$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTable

test_RelationalCool_RelationalObjectTable :: test_RelationalCool_RelationalObjectTablecompile test_RelationalCool_RelationalObjectTableinstall ;

ifdef cmt_test_RelationalCool_RelationalObjectTable_has_prototypes

test_RelationalCool_RelationalObjectTableprototype : $(test_RelationalCool_RelationalObjectTableprototype_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) dirs test_RelationalCool_RelationalObjectTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_RelationalCool_RelationalObjectTablecompile : test_RelationalCool_RelationalObjectTableprototype

endif

test_RelationalCool_RelationalObjectTablecompile : $(test_RelationalCool_RelationalObjectTablecompile_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) dirs test_RelationalCool_RelationalObjectTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_RelationalCool_RelationalObjectTableclean ;

test_RelationalCool_RelationalObjectTableclean :: $(test_RelationalCool_RelationalObjectTableclean_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) test_RelationalCool_RelationalObjectTableclean

##	  /bin/rm -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $(bin)test_RelationalCool_RelationalObjectTable_dependencies.make

install :: test_RelationalCool_RelationalObjectTableinstall ;

test_RelationalCool_RelationalObjectTableinstall :: test_RelationalCool_RelationalObjectTablecompile $(test_RelationalCool_RelationalObjectTable_dependencies) $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_RelationalCool_RelationalObjectTableuninstall

$(foreach d,$(test_RelationalCool_RelationalObjectTable_dependencies),$(eval $(d)uninstall_dependencies += test_RelationalCool_RelationalObjectTableuninstall))

test_RelationalCool_RelationalObjectTableuninstall : $(test_RelationalCool_RelationalObjectTableuninstall_dependencies) ##$(cmt_local_test_RelationalCool_RelationalObjectTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_RelationalCool_RelationalObjectTable_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_RelationalCool_RelationalObjectTableuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_RelationalCool_RelationalObjectTable"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_RelationalCool_RelationalObjectTable done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolAuthentication_has_no_target_tag = 1
cmt_coolAuthentication_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolAuthentication_has_target_tag

cmt_local_tagfile_coolAuthentication = $(bin)$(RelationalCool_tag)_coolAuthentication.make
cmt_final_setup_coolAuthentication = $(bin)setup_coolAuthentication.make
cmt_local_coolAuthentication_makefile = $(bin)coolAuthentication.make

coolAuthentication_extratags = -tag_add=target_coolAuthentication

else

cmt_local_tagfile_coolAuthentication = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolAuthentication = $(bin)setup.make
cmt_local_coolAuthentication_makefile = $(bin)coolAuthentication.make

endif

not_coolAuthenticationcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolAuthenticationcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolAuthenticationdirs :
	@if test ! -d $(bin)coolAuthentication; then $(mkdir) -p $(bin)coolAuthentication; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolAuthentication
else
coolAuthenticationdirs : ;
endif

ifdef cmt_coolAuthentication_has_target_tag

ifndef QUICK
$(cmt_local_coolAuthentication_makefile) : $(coolAuthenticationcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolAuthentication.make"; \
	  $(cmtexe) -tag=$(tags) $(coolAuthentication_extratags) build constituent_config -out=$(cmt_local_coolAuthentication_makefile) coolAuthentication
else
$(cmt_local_coolAuthentication_makefile) : $(coolAuthenticationcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolAuthentication) ] || \
	  [ ! -f $(cmt_final_setup_coolAuthentication) ] || \
	  $(not_coolAuthenticationcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolAuthentication.make"; \
	  $(cmtexe) -tag=$(tags) $(coolAuthentication_extratags) build constituent_config -out=$(cmt_local_coolAuthentication_makefile) coolAuthentication; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolAuthentication_makefile) : $(coolAuthenticationcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolAuthentication.make"; \
	  $(cmtexe) -f=$(bin)coolAuthentication.in -tag=$(tags) $(coolAuthentication_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolAuthentication_makefile) coolAuthentication
else
$(cmt_local_coolAuthentication_makefile) : $(coolAuthenticationcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolAuthentication.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolAuthentication) ] || \
	  [ ! -f $(cmt_final_setup_coolAuthentication) ] || \
	  $(not_coolAuthenticationcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolAuthentication.make"; \
	  $(cmtexe) -f=$(bin)coolAuthentication.in -tag=$(tags) $(coolAuthentication_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolAuthentication_makefile) coolAuthentication; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolAuthentication_extratags) build constituent_makefile -out=$(cmt_local_coolAuthentication_makefile) coolAuthentication

coolAuthentication :: coolAuthenticationcompile coolAuthenticationinstall ;

ifdef cmt_coolAuthentication_has_prototypes

coolAuthenticationprototype : $(coolAuthenticationprototype_dependencies) $(cmt_local_coolAuthentication_makefile) dirs coolAuthenticationdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolAuthentication_makefile); then \
	  $(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolAuthenticationcompile : coolAuthenticationprototype

endif

coolAuthenticationcompile : $(coolAuthenticationcompile_dependencies) $(cmt_local_coolAuthentication_makefile) dirs coolAuthenticationdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolAuthentication_makefile); then \
	  $(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolAuthenticationclean ;

coolAuthenticationclean :: $(coolAuthenticationclean_dependencies) ##$(cmt_local_coolAuthentication_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolAuthentication_makefile); then \
	  $(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolAuthentication_makefile) coolAuthenticationclean

##	  /bin/rm -f $(cmt_local_coolAuthentication_makefile) $(bin)coolAuthentication_dependencies.make

install :: coolAuthenticationinstall ;

coolAuthenticationinstall :: coolAuthenticationcompile $(coolAuthentication_dependencies) $(cmt_local_coolAuthentication_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolAuthentication_makefile); then \
	  $(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolAuthentication_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolAuthenticationuninstall

$(foreach d,$(coolAuthentication_dependencies),$(eval $(d)uninstall_dependencies += coolAuthenticationuninstall))

coolAuthenticationuninstall : $(coolAuthenticationuninstall_dependencies) ##$(cmt_local_coolAuthentication_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolAuthentication_makefile); then \
	  $(MAKE) -f $(cmt_local_coolAuthentication_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolAuthentication_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolAuthenticationuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolAuthentication"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolAuthentication done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolDropDB_has_no_target_tag = 1
cmt_coolDropDB_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolDropDB_has_target_tag

cmt_local_tagfile_coolDropDB = $(bin)$(RelationalCool_tag)_coolDropDB.make
cmt_final_setup_coolDropDB = $(bin)setup_coolDropDB.make
cmt_local_coolDropDB_makefile = $(bin)coolDropDB.make

coolDropDB_extratags = -tag_add=target_coolDropDB

else

cmt_local_tagfile_coolDropDB = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolDropDB = $(bin)setup.make
cmt_local_coolDropDB_makefile = $(bin)coolDropDB.make

endif

not_coolDropDBcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolDropDBcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolDropDBdirs :
	@if test ! -d $(bin)coolDropDB; then $(mkdir) -p $(bin)coolDropDB; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolDropDB
else
coolDropDBdirs : ;
endif

ifdef cmt_coolDropDB_has_target_tag

ifndef QUICK
$(cmt_local_coolDropDB_makefile) : $(coolDropDBcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolDropDB.make"; \
	  $(cmtexe) -tag=$(tags) $(coolDropDB_extratags) build constituent_config -out=$(cmt_local_coolDropDB_makefile) coolDropDB
else
$(cmt_local_coolDropDB_makefile) : $(coolDropDBcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolDropDB) ] || \
	  [ ! -f $(cmt_final_setup_coolDropDB) ] || \
	  $(not_coolDropDBcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolDropDB.make"; \
	  $(cmtexe) -tag=$(tags) $(coolDropDB_extratags) build constituent_config -out=$(cmt_local_coolDropDB_makefile) coolDropDB; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolDropDB_makefile) : $(coolDropDBcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolDropDB.make"; \
	  $(cmtexe) -f=$(bin)coolDropDB.in -tag=$(tags) $(coolDropDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolDropDB_makefile) coolDropDB
else
$(cmt_local_coolDropDB_makefile) : $(coolDropDBcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolDropDB.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolDropDB) ] || \
	  [ ! -f $(cmt_final_setup_coolDropDB) ] || \
	  $(not_coolDropDBcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolDropDB.make"; \
	  $(cmtexe) -f=$(bin)coolDropDB.in -tag=$(tags) $(coolDropDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolDropDB_makefile) coolDropDB; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolDropDB_extratags) build constituent_makefile -out=$(cmt_local_coolDropDB_makefile) coolDropDB

coolDropDB :: coolDropDBcompile coolDropDBinstall ;

ifdef cmt_coolDropDB_has_prototypes

coolDropDBprototype : $(coolDropDBprototype_dependencies) $(cmt_local_coolDropDB_makefile) dirs coolDropDBdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDropDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDropDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDropDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolDropDBcompile : coolDropDBprototype

endif

coolDropDBcompile : $(coolDropDBcompile_dependencies) $(cmt_local_coolDropDB_makefile) dirs coolDropDBdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDropDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDropDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDropDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolDropDBclean ;

coolDropDBclean :: $(coolDropDBclean_dependencies) ##$(cmt_local_coolDropDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolDropDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDropDB_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolDropDB_makefile) coolDropDBclean

##	  /bin/rm -f $(cmt_local_coolDropDB_makefile) $(bin)coolDropDB_dependencies.make

install :: coolDropDBinstall ;

coolDropDBinstall :: coolDropDBcompile $(coolDropDB_dependencies) $(cmt_local_coolDropDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDropDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDropDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDropDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolDropDBuninstall

$(foreach d,$(coolDropDB_dependencies),$(eval $(d)uninstall_dependencies += coolDropDBuninstall))

coolDropDBuninstall : $(coolDropDBuninstall_dependencies) ##$(cmt_local_coolDropDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolDropDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDropDB_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDropDB_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolDropDBuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolDropDB"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolDropDB done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolDumpSchema_has_no_target_tag = 1
cmt_coolDumpSchema_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolDumpSchema_has_target_tag

cmt_local_tagfile_coolDumpSchema = $(bin)$(RelationalCool_tag)_coolDumpSchema.make
cmt_final_setup_coolDumpSchema = $(bin)setup_coolDumpSchema.make
cmt_local_coolDumpSchema_makefile = $(bin)coolDumpSchema.make

coolDumpSchema_extratags = -tag_add=target_coolDumpSchema

else

cmt_local_tagfile_coolDumpSchema = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolDumpSchema = $(bin)setup.make
cmt_local_coolDumpSchema_makefile = $(bin)coolDumpSchema.make

endif

not_coolDumpSchemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolDumpSchemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolDumpSchemadirs :
	@if test ! -d $(bin)coolDumpSchema; then $(mkdir) -p $(bin)coolDumpSchema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolDumpSchema
else
coolDumpSchemadirs : ;
endif

ifdef cmt_coolDumpSchema_has_target_tag

ifndef QUICK
$(cmt_local_coolDumpSchema_makefile) : $(coolDumpSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolDumpSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolDumpSchema_extratags) build constituent_config -out=$(cmt_local_coolDumpSchema_makefile) coolDumpSchema
else
$(cmt_local_coolDumpSchema_makefile) : $(coolDumpSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolDumpSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolDumpSchema) ] || \
	  $(not_coolDumpSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolDumpSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolDumpSchema_extratags) build constituent_config -out=$(cmt_local_coolDumpSchema_makefile) coolDumpSchema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolDumpSchema_makefile) : $(coolDumpSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolDumpSchema.make"; \
	  $(cmtexe) -f=$(bin)coolDumpSchema.in -tag=$(tags) $(coolDumpSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolDumpSchema_makefile) coolDumpSchema
else
$(cmt_local_coolDumpSchema_makefile) : $(coolDumpSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolDumpSchema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolDumpSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolDumpSchema) ] || \
	  $(not_coolDumpSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolDumpSchema.make"; \
	  $(cmtexe) -f=$(bin)coolDumpSchema.in -tag=$(tags) $(coolDumpSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolDumpSchema_makefile) coolDumpSchema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolDumpSchema_extratags) build constituent_makefile -out=$(cmt_local_coolDumpSchema_makefile) coolDumpSchema

coolDumpSchema :: coolDumpSchemacompile coolDumpSchemainstall ;

ifdef cmt_coolDumpSchema_has_prototypes

coolDumpSchemaprototype : $(coolDumpSchemaprototype_dependencies) $(cmt_local_coolDumpSchema_makefile) dirs coolDumpSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDumpSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolDumpSchemacompile : coolDumpSchemaprototype

endif

coolDumpSchemacompile : $(coolDumpSchemacompile_dependencies) $(cmt_local_coolDumpSchema_makefile) dirs coolDumpSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDumpSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolDumpSchemaclean ;

coolDumpSchemaclean :: $(coolDumpSchemaclean_dependencies) ##$(cmt_local_coolDumpSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolDumpSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolDumpSchema_makefile) coolDumpSchemaclean

##	  /bin/rm -f $(cmt_local_coolDumpSchema_makefile) $(bin)coolDumpSchema_dependencies.make

install :: coolDumpSchemainstall ;

coolDumpSchemainstall :: coolDumpSchemacompile $(coolDumpSchema_dependencies) $(cmt_local_coolDumpSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolDumpSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDumpSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolDumpSchemauninstall

$(foreach d,$(coolDumpSchema_dependencies),$(eval $(d)uninstall_dependencies += coolDumpSchemauninstall))

coolDumpSchemauninstall : $(coolDumpSchemauninstall_dependencies) ##$(cmt_local_coolDumpSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolDumpSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolDumpSchema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolDumpSchema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolDumpSchemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolDumpSchema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolDumpSchema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolEvolveSchema_has_no_target_tag = 1
cmt_coolEvolveSchema_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolEvolveSchema_has_target_tag

cmt_local_tagfile_coolEvolveSchema = $(bin)$(RelationalCool_tag)_coolEvolveSchema.make
cmt_final_setup_coolEvolveSchema = $(bin)setup_coolEvolveSchema.make
cmt_local_coolEvolveSchema_makefile = $(bin)coolEvolveSchema.make

coolEvolveSchema_extratags = -tag_add=target_coolEvolveSchema

else

cmt_local_tagfile_coolEvolveSchema = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolEvolveSchema = $(bin)setup.make
cmt_local_coolEvolveSchema_makefile = $(bin)coolEvolveSchema.make

endif

not_coolEvolveSchemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolEvolveSchemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolEvolveSchemadirs :
	@if test ! -d $(bin)coolEvolveSchema; then $(mkdir) -p $(bin)coolEvolveSchema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolEvolveSchema
else
coolEvolveSchemadirs : ;
endif

ifdef cmt_coolEvolveSchema_has_target_tag

ifndef QUICK
$(cmt_local_coolEvolveSchema_makefile) : $(coolEvolveSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolEvolveSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolEvolveSchema_extratags) build constituent_config -out=$(cmt_local_coolEvolveSchema_makefile) coolEvolveSchema
else
$(cmt_local_coolEvolveSchema_makefile) : $(coolEvolveSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolEvolveSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolEvolveSchema) ] || \
	  $(not_coolEvolveSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolEvolveSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolEvolveSchema_extratags) build constituent_config -out=$(cmt_local_coolEvolveSchema_makefile) coolEvolveSchema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolEvolveSchema_makefile) : $(coolEvolveSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolEvolveSchema.make"; \
	  $(cmtexe) -f=$(bin)coolEvolveSchema.in -tag=$(tags) $(coolEvolveSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolEvolveSchema_makefile) coolEvolveSchema
else
$(cmt_local_coolEvolveSchema_makefile) : $(coolEvolveSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolEvolveSchema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolEvolveSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolEvolveSchema) ] || \
	  $(not_coolEvolveSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolEvolveSchema.make"; \
	  $(cmtexe) -f=$(bin)coolEvolveSchema.in -tag=$(tags) $(coolEvolveSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolEvolveSchema_makefile) coolEvolveSchema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolEvolveSchema_extratags) build constituent_makefile -out=$(cmt_local_coolEvolveSchema_makefile) coolEvolveSchema

coolEvolveSchema :: coolEvolveSchemacompile coolEvolveSchemainstall ;

ifdef cmt_coolEvolveSchema_has_prototypes

coolEvolveSchemaprototype : $(coolEvolveSchemaprototype_dependencies) $(cmt_local_coolEvolveSchema_makefile) dirs coolEvolveSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolEvolveSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolEvolveSchemacompile : coolEvolveSchemaprototype

endif

coolEvolveSchemacompile : $(coolEvolveSchemacompile_dependencies) $(cmt_local_coolEvolveSchema_makefile) dirs coolEvolveSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolEvolveSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolEvolveSchemaclean ;

coolEvolveSchemaclean :: $(coolEvolveSchemaclean_dependencies) ##$(cmt_local_coolEvolveSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolEvolveSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) coolEvolveSchemaclean

##	  /bin/rm -f $(cmt_local_coolEvolveSchema_makefile) $(bin)coolEvolveSchema_dependencies.make

install :: coolEvolveSchemainstall ;

coolEvolveSchemainstall :: coolEvolveSchemacompile $(coolEvolveSchema_dependencies) $(cmt_local_coolEvolveSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolEvolveSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolEvolveSchemauninstall

$(foreach d,$(coolEvolveSchema_dependencies),$(eval $(d)uninstall_dependencies += coolEvolveSchemauninstall))

coolEvolveSchemauninstall : $(coolEvolveSchemauninstall_dependencies) ##$(cmt_local_coolEvolveSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolEvolveSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolEvolveSchema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolEvolveSchemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolEvolveSchema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolEvolveSchema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolPrivileges_has_no_target_tag = 1
cmt_coolPrivileges_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolPrivileges_has_target_tag

cmt_local_tagfile_coolPrivileges = $(bin)$(RelationalCool_tag)_coolPrivileges.make
cmt_final_setup_coolPrivileges = $(bin)setup_coolPrivileges.make
cmt_local_coolPrivileges_makefile = $(bin)coolPrivileges.make

coolPrivileges_extratags = -tag_add=target_coolPrivileges

else

cmt_local_tagfile_coolPrivileges = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolPrivileges = $(bin)setup.make
cmt_local_coolPrivileges_makefile = $(bin)coolPrivileges.make

endif

not_coolPrivilegescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolPrivilegescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolPrivilegesdirs :
	@if test ! -d $(bin)coolPrivileges; then $(mkdir) -p $(bin)coolPrivileges; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolPrivileges
else
coolPrivilegesdirs : ;
endif

ifdef cmt_coolPrivileges_has_target_tag

ifndef QUICK
$(cmt_local_coolPrivileges_makefile) : $(coolPrivilegescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolPrivileges.make"; \
	  $(cmtexe) -tag=$(tags) $(coolPrivileges_extratags) build constituent_config -out=$(cmt_local_coolPrivileges_makefile) coolPrivileges
else
$(cmt_local_coolPrivileges_makefile) : $(coolPrivilegescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolPrivileges) ] || \
	  [ ! -f $(cmt_final_setup_coolPrivileges) ] || \
	  $(not_coolPrivilegescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolPrivileges.make"; \
	  $(cmtexe) -tag=$(tags) $(coolPrivileges_extratags) build constituent_config -out=$(cmt_local_coolPrivileges_makefile) coolPrivileges; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolPrivileges_makefile) : $(coolPrivilegescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolPrivileges.make"; \
	  $(cmtexe) -f=$(bin)coolPrivileges.in -tag=$(tags) $(coolPrivileges_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolPrivileges_makefile) coolPrivileges
else
$(cmt_local_coolPrivileges_makefile) : $(coolPrivilegescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolPrivileges.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolPrivileges) ] || \
	  [ ! -f $(cmt_final_setup_coolPrivileges) ] || \
	  $(not_coolPrivilegescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolPrivileges.make"; \
	  $(cmtexe) -f=$(bin)coolPrivileges.in -tag=$(tags) $(coolPrivileges_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolPrivileges_makefile) coolPrivileges; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolPrivileges_extratags) build constituent_makefile -out=$(cmt_local_coolPrivileges_makefile) coolPrivileges

coolPrivileges :: coolPrivilegescompile coolPrivilegesinstall ;

ifdef cmt_coolPrivileges_has_prototypes

coolPrivilegesprototype : $(coolPrivilegesprototype_dependencies) $(cmt_local_coolPrivileges_makefile) dirs coolPrivilegesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolPrivileges_makefile); then \
	  $(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolPrivilegescompile : coolPrivilegesprototype

endif

coolPrivilegescompile : $(coolPrivilegescompile_dependencies) $(cmt_local_coolPrivileges_makefile) dirs coolPrivilegesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolPrivileges_makefile); then \
	  $(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolPrivilegesclean ;

coolPrivilegesclean :: $(coolPrivilegesclean_dependencies) ##$(cmt_local_coolPrivileges_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolPrivileges_makefile); then \
	  $(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolPrivileges_makefile) coolPrivilegesclean

##	  /bin/rm -f $(cmt_local_coolPrivileges_makefile) $(bin)coolPrivileges_dependencies.make

install :: coolPrivilegesinstall ;

coolPrivilegesinstall :: coolPrivilegescompile $(coolPrivileges_dependencies) $(cmt_local_coolPrivileges_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolPrivileges_makefile); then \
	  $(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolPrivileges_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolPrivilegesuninstall

$(foreach d,$(coolPrivileges_dependencies),$(eval $(d)uninstall_dependencies += coolPrivilegesuninstall))

coolPrivilegesuninstall : $(coolPrivilegesuninstall_dependencies) ##$(cmt_local_coolPrivileges_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolPrivileges_makefile); then \
	  $(MAKE) -f $(cmt_local_coolPrivileges_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolPrivileges_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolPrivilegesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolPrivileges"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolPrivileges done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolReplicateDB_has_no_target_tag = 1
cmt_coolReplicateDB_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolReplicateDB_has_target_tag

cmt_local_tagfile_coolReplicateDB = $(bin)$(RelationalCool_tag)_coolReplicateDB.make
cmt_final_setup_coolReplicateDB = $(bin)setup_coolReplicateDB.make
cmt_local_coolReplicateDB_makefile = $(bin)coolReplicateDB.make

coolReplicateDB_extratags = -tag_add=target_coolReplicateDB

else

cmt_local_tagfile_coolReplicateDB = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolReplicateDB = $(bin)setup.make
cmt_local_coolReplicateDB_makefile = $(bin)coolReplicateDB.make

endif

not_coolReplicateDBcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolReplicateDBcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolReplicateDBdirs :
	@if test ! -d $(bin)coolReplicateDB; then $(mkdir) -p $(bin)coolReplicateDB; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolReplicateDB
else
coolReplicateDBdirs : ;
endif

ifdef cmt_coolReplicateDB_has_target_tag

ifndef QUICK
$(cmt_local_coolReplicateDB_makefile) : $(coolReplicateDBcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolReplicateDB.make"; \
	  $(cmtexe) -tag=$(tags) $(coolReplicateDB_extratags) build constituent_config -out=$(cmt_local_coolReplicateDB_makefile) coolReplicateDB
else
$(cmt_local_coolReplicateDB_makefile) : $(coolReplicateDBcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolReplicateDB) ] || \
	  [ ! -f $(cmt_final_setup_coolReplicateDB) ] || \
	  $(not_coolReplicateDBcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolReplicateDB.make"; \
	  $(cmtexe) -tag=$(tags) $(coolReplicateDB_extratags) build constituent_config -out=$(cmt_local_coolReplicateDB_makefile) coolReplicateDB; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolReplicateDB_makefile) : $(coolReplicateDBcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolReplicateDB.make"; \
	  $(cmtexe) -f=$(bin)coolReplicateDB.in -tag=$(tags) $(coolReplicateDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolReplicateDB_makefile) coolReplicateDB
else
$(cmt_local_coolReplicateDB_makefile) : $(coolReplicateDBcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolReplicateDB.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolReplicateDB) ] || \
	  [ ! -f $(cmt_final_setup_coolReplicateDB) ] || \
	  $(not_coolReplicateDBcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolReplicateDB.make"; \
	  $(cmtexe) -f=$(bin)coolReplicateDB.in -tag=$(tags) $(coolReplicateDB_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolReplicateDB_makefile) coolReplicateDB; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolReplicateDB_extratags) build constituent_makefile -out=$(cmt_local_coolReplicateDB_makefile) coolReplicateDB

coolReplicateDB :: coolReplicateDBcompile coolReplicateDBinstall ;

ifdef cmt_coolReplicateDB_has_prototypes

coolReplicateDBprototype : $(coolReplicateDBprototype_dependencies) $(cmt_local_coolReplicateDB_makefile) dirs coolReplicateDBdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolReplicateDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolReplicateDBcompile : coolReplicateDBprototype

endif

coolReplicateDBcompile : $(coolReplicateDBcompile_dependencies) $(cmt_local_coolReplicateDB_makefile) dirs coolReplicateDBdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolReplicateDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolReplicateDBclean ;

coolReplicateDBclean :: $(coolReplicateDBclean_dependencies) ##$(cmt_local_coolReplicateDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolReplicateDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolReplicateDB_makefile) coolReplicateDBclean

##	  /bin/rm -f $(cmt_local_coolReplicateDB_makefile) $(bin)coolReplicateDB_dependencies.make

install :: coolReplicateDBinstall ;

coolReplicateDBinstall :: coolReplicateDBcompile $(coolReplicateDB_dependencies) $(cmt_local_coolReplicateDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolReplicateDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolReplicateDB_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolReplicateDBuninstall

$(foreach d,$(coolReplicateDB_dependencies),$(eval $(d)uninstall_dependencies += coolReplicateDBuninstall))

coolReplicateDBuninstall : $(coolReplicateDBuninstall_dependencies) ##$(cmt_local_coolReplicateDB_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolReplicateDB_makefile); then \
	  $(MAKE) -f $(cmt_local_coolReplicateDB_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolReplicateDB_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolReplicateDBuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolReplicateDB"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolReplicateDB done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolStat_has_no_target_tag = 1
cmt_coolStat_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolStat_has_target_tag

cmt_local_tagfile_coolStat = $(bin)$(RelationalCool_tag)_coolStat.make
cmt_final_setup_coolStat = $(bin)setup_coolStat.make
cmt_local_coolStat_makefile = $(bin)coolStat.make

coolStat_extratags = -tag_add=target_coolStat

else

cmt_local_tagfile_coolStat = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolStat = $(bin)setup.make
cmt_local_coolStat_makefile = $(bin)coolStat.make

endif

not_coolStatcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolStatcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolStatdirs :
	@if test ! -d $(bin)coolStat; then $(mkdir) -p $(bin)coolStat; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolStat
else
coolStatdirs : ;
endif

ifdef cmt_coolStat_has_target_tag

ifndef QUICK
$(cmt_local_coolStat_makefile) : $(coolStatcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolStat.make"; \
	  $(cmtexe) -tag=$(tags) $(coolStat_extratags) build constituent_config -out=$(cmt_local_coolStat_makefile) coolStat
else
$(cmt_local_coolStat_makefile) : $(coolStatcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolStat) ] || \
	  [ ! -f $(cmt_final_setup_coolStat) ] || \
	  $(not_coolStatcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolStat.make"; \
	  $(cmtexe) -tag=$(tags) $(coolStat_extratags) build constituent_config -out=$(cmt_local_coolStat_makefile) coolStat; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolStat_makefile) : $(coolStatcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolStat.make"; \
	  $(cmtexe) -f=$(bin)coolStat.in -tag=$(tags) $(coolStat_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolStat_makefile) coolStat
else
$(cmt_local_coolStat_makefile) : $(coolStatcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolStat.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolStat) ] || \
	  [ ! -f $(cmt_final_setup_coolStat) ] || \
	  $(not_coolStatcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolStat.make"; \
	  $(cmtexe) -f=$(bin)coolStat.in -tag=$(tags) $(coolStat_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolStat_makefile) coolStat; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolStat_extratags) build constituent_makefile -out=$(cmt_local_coolStat_makefile) coolStat

coolStat :: coolStatcompile coolStatinstall ;

ifdef cmt_coolStat_has_prototypes

coolStatprototype : $(coolStatprototype_dependencies) $(cmt_local_coolStat_makefile) dirs coolStatdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolStat_makefile); then \
	  $(MAKE) -f $(cmt_local_coolStat_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolStat_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolStatcompile : coolStatprototype

endif

coolStatcompile : $(coolStatcompile_dependencies) $(cmt_local_coolStat_makefile) dirs coolStatdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolStat_makefile); then \
	  $(MAKE) -f $(cmt_local_coolStat_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolStat_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolStatclean ;

coolStatclean :: $(coolStatclean_dependencies) ##$(cmt_local_coolStat_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolStat_makefile); then \
	  $(MAKE) -f $(cmt_local_coolStat_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolStat_makefile) coolStatclean

##	  /bin/rm -f $(cmt_local_coolStat_makefile) $(bin)coolStat_dependencies.make

install :: coolStatinstall ;

coolStatinstall :: coolStatcompile $(coolStat_dependencies) $(cmt_local_coolStat_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolStat_makefile); then \
	  $(MAKE) -f $(cmt_local_coolStat_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolStat_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolStatuninstall

$(foreach d,$(coolStat_dependencies),$(eval $(d)uninstall_dependencies += coolStatuninstall))

coolStatuninstall : $(coolStatuninstall_dependencies) ##$(cmt_local_coolStat_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolStat_makefile); then \
	  $(MAKE) -f $(cmt_local_coolStat_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolStat_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolStatuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolStat"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolStat done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coolValidateSchema_has_no_target_tag = 1
cmt_coolValidateSchema_has_prototypes = 1

#--------------------------------------

ifdef cmt_coolValidateSchema_has_target_tag

cmt_local_tagfile_coolValidateSchema = $(bin)$(RelationalCool_tag)_coolValidateSchema.make
cmt_final_setup_coolValidateSchema = $(bin)setup_coolValidateSchema.make
cmt_local_coolValidateSchema_makefile = $(bin)coolValidateSchema.make

coolValidateSchema_extratags = -tag_add=target_coolValidateSchema

else

cmt_local_tagfile_coolValidateSchema = $(bin)$(RelationalCool_tag).make
cmt_final_setup_coolValidateSchema = $(bin)setup.make
cmt_local_coolValidateSchema_makefile = $(bin)coolValidateSchema.make

endif

not_coolValidateSchemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coolValidateSchemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coolValidateSchemadirs :
	@if test ! -d $(bin)coolValidateSchema; then $(mkdir) -p $(bin)coolValidateSchema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coolValidateSchema
else
coolValidateSchemadirs : ;
endif

ifdef cmt_coolValidateSchema_has_target_tag

ifndef QUICK
$(cmt_local_coolValidateSchema_makefile) : $(coolValidateSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolValidateSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolValidateSchema_extratags) build constituent_config -out=$(cmt_local_coolValidateSchema_makefile) coolValidateSchema
else
$(cmt_local_coolValidateSchema_makefile) : $(coolValidateSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolValidateSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolValidateSchema) ] || \
	  $(not_coolValidateSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolValidateSchema.make"; \
	  $(cmtexe) -tag=$(tags) $(coolValidateSchema_extratags) build constituent_config -out=$(cmt_local_coolValidateSchema_makefile) coolValidateSchema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coolValidateSchema_makefile) : $(coolValidateSchemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coolValidateSchema.make"; \
	  $(cmtexe) -f=$(bin)coolValidateSchema.in -tag=$(tags) $(coolValidateSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolValidateSchema_makefile) coolValidateSchema
else
$(cmt_local_coolValidateSchema_makefile) : $(coolValidateSchemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coolValidateSchema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coolValidateSchema) ] || \
	  [ ! -f $(cmt_final_setup_coolValidateSchema) ] || \
	  $(not_coolValidateSchemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coolValidateSchema.make"; \
	  $(cmtexe) -f=$(bin)coolValidateSchema.in -tag=$(tags) $(coolValidateSchema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coolValidateSchema_makefile) coolValidateSchema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coolValidateSchema_extratags) build constituent_makefile -out=$(cmt_local_coolValidateSchema_makefile) coolValidateSchema

coolValidateSchema :: coolValidateSchemacompile coolValidateSchemainstall ;

ifdef cmt_coolValidateSchema_has_prototypes

coolValidateSchemaprototype : $(coolValidateSchemaprototype_dependencies) $(cmt_local_coolValidateSchema_makefile) dirs coolValidateSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolValidateSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

coolValidateSchemacompile : coolValidateSchemaprototype

endif

coolValidateSchemacompile : $(coolValidateSchemacompile_dependencies) $(cmt_local_coolValidateSchema_makefile) dirs coolValidateSchemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolValidateSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coolValidateSchemaclean ;

coolValidateSchemaclean :: $(coolValidateSchemaclean_dependencies) ##$(cmt_local_coolValidateSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolValidateSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coolValidateSchema_makefile) coolValidateSchemaclean

##	  /bin/rm -f $(cmt_local_coolValidateSchema_makefile) $(bin)coolValidateSchema_dependencies.make

install :: coolValidateSchemainstall ;

coolValidateSchemainstall :: coolValidateSchemacompile $(coolValidateSchema_dependencies) $(cmt_local_coolValidateSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coolValidateSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolValidateSchema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coolValidateSchemauninstall

$(foreach d,$(coolValidateSchema_dependencies),$(eval $(d)uninstall_dependencies += coolValidateSchemauninstall))

coolValidateSchemauninstall : $(coolValidateSchemauninstall_dependencies) ##$(cmt_local_coolValidateSchema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coolValidateSchema_makefile); then \
	  $(MAKE) -f $(cmt_local_coolValidateSchema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coolValidateSchema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coolValidateSchemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coolValidateSchema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coolValidateSchema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(RelationalCool_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(RelationalCool_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(RelationalCool_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(RelationalCool_tag).make
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

cmt_local_tagfile_make = $(bin)$(RelationalCool_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(RelationalCool_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(RelationalCool_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(RelationalCool_tag).make
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

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_scripts_has_target_tag

cmt_local_tagfile_install_scripts = $(bin)$(RelationalCool_tag)_install_scripts.make
cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

install_scripts_extratags = -tag_add=target_install_scripts

else

cmt_local_tagfile_install_scripts = $(bin)$(RelationalCool_tag).make
cmt_final_setup_install_scripts = $(bin)setup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

endif

not_install_scripts_dependencies = { n=0; for p in $?; do m=0; for d in $(install_scripts_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_scriptsdirs :
	@if test ! -d $(bin)install_scripts; then $(mkdir) -p $(bin)install_scripts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_scripts
else
install_scriptsdirs : ;
endif

ifdef cmt_install_scripts_has_target_tag

ifndef QUICK
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_config -out=$(cmt_local_install_scripts_makefile) install_scripts
else
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_install_scripts) ] || \
	  $(not_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_config -out=$(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -f=$(bin)install_scripts.in -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_scripts_makefile) install_scripts
else
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) $(cmt_build_library_linksstamp) $(bin)install_scripts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_install_scripts) ] || \
	  $(not_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -f=$(bin)install_scripts.in -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -out=$(cmt_local_install_scripts_makefile) install_scripts

install_scripts :: $(install_scripts_dependencies) $(cmt_local_install_scripts_makefile) dirs install_scriptsdirs
	$(echo) "(constituents.make) Starting install_scripts"
	@if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_scripts_makefile) install_scripts
	$(echo) "(constituents.make) install_scripts done"

clean :: install_scriptsclean ;

install_scriptsclean :: $(install_scriptsclean_dependencies) ##$(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting install_scriptsclean"
	@-if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install_scriptsclean; \
	fi
	$(echo) "(constituents.make) install_scriptsclean done"
#	@-$(MAKE) -f $(cmt_local_install_scripts_makefile) install_scriptsclean

##	  /bin/rm -f $(cmt_local_install_scripts_makefile) $(bin)install_scripts_dependencies.make

install :: install_scriptsinstall ;

install_scriptsinstall :: $(install_scripts_dependencies) $(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_scripts_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_scriptsuninstall

$(foreach d,$(install_scripts_dependencies),$(eval $(d)uninstall_dependencies += install_scriptsuninstall))

install_scriptsuninstall : $(install_scriptsuninstall_dependencies) ##$(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_scripts_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_scriptsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_scripts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_scripts done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_examples_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_examples_has_target_tag

cmt_local_tagfile_examples = $(bin)$(RelationalCool_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(RelationalCool_tag).make
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
