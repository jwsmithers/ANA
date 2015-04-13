
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

SQLiteAccess_tag = $(tag)

#cmt_local_tagfile = $(SQLiteAccess_tag).make
cmt_local_tagfile = $(bin)$(SQLiteAccess_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)SQLiteAccesssetup.make
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

cmt_lcg_SQLiteAccess_has_no_target_tag = 1
cmt_lcg_SQLiteAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_SQLiteAccess_has_target_tag

cmt_local_tagfile_lcg_SQLiteAccess = $(bin)$(SQLiteAccess_tag)_lcg_SQLiteAccess.make
cmt_final_setup_lcg_SQLiteAccess = $(bin)setup_lcg_SQLiteAccess.make
cmt_local_lcg_SQLiteAccess_makefile = $(bin)lcg_SQLiteAccess.make

lcg_SQLiteAccess_extratags = -tag_add=target_lcg_SQLiteAccess

else

cmt_local_tagfile_lcg_SQLiteAccess = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_lcg_SQLiteAccess = $(bin)setup.make
cmt_local_lcg_SQLiteAccess_makefile = $(bin)lcg_SQLiteAccess.make

endif

not_lcg_SQLiteAccesscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_SQLiteAccesscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_SQLiteAccessdirs :
	@if test ! -d $(bin)lcg_SQLiteAccess; then $(mkdir) -p $(bin)lcg_SQLiteAccess; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_SQLiteAccess
else
lcg_SQLiteAccessdirs : ;
endif

ifdef cmt_lcg_SQLiteAccess_has_target_tag

ifndef QUICK
$(cmt_local_lcg_SQLiteAccess_makefile) : $(lcg_SQLiteAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_SQLiteAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_SQLiteAccess_extratags) build constituent_config -out=$(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccess
else
$(cmt_local_lcg_SQLiteAccess_makefile) : $(lcg_SQLiteAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_SQLiteAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_SQLiteAccess) ] || \
	  $(not_lcg_SQLiteAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_SQLiteAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_SQLiteAccess_extratags) build constituent_config -out=$(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccess; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_SQLiteAccess_makefile) : $(lcg_SQLiteAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_SQLiteAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_SQLiteAccess.in -tag=$(tags) $(lcg_SQLiteAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccess
else
$(cmt_local_lcg_SQLiteAccess_makefile) : $(lcg_SQLiteAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_SQLiteAccess.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_SQLiteAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_SQLiteAccess) ] || \
	  $(not_lcg_SQLiteAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_SQLiteAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_SQLiteAccess.in -tag=$(tags) $(lcg_SQLiteAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccess; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_SQLiteAccess_extratags) build constituent_makefile -out=$(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccess

lcg_SQLiteAccess :: lcg_SQLiteAccesscompile lcg_SQLiteAccessinstall ;

ifdef cmt_lcg_SQLiteAccess_has_prototypes

lcg_SQLiteAccessprototype : $(lcg_SQLiteAccessprototype_dependencies) $(cmt_local_lcg_SQLiteAccess_makefile) dirs lcg_SQLiteAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_SQLiteAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_SQLiteAccesscompile : lcg_SQLiteAccessprototype

endif

lcg_SQLiteAccesscompile : $(lcg_SQLiteAccesscompile_dependencies) $(cmt_local_lcg_SQLiteAccess_makefile) dirs lcg_SQLiteAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_SQLiteAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_SQLiteAccessclean ;

lcg_SQLiteAccessclean :: $(lcg_SQLiteAccessclean_dependencies) ##$(cmt_local_lcg_SQLiteAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_SQLiteAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) lcg_SQLiteAccessclean

##	  /bin/rm -f $(cmt_local_lcg_SQLiteAccess_makefile) $(bin)lcg_SQLiteAccess_dependencies.make

install :: lcg_SQLiteAccessinstall ;

lcg_SQLiteAccessinstall :: lcg_SQLiteAccesscompile $(lcg_SQLiteAccess_dependencies) $(cmt_local_lcg_SQLiteAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_SQLiteAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_SQLiteAccessuninstall

$(foreach d,$(lcg_SQLiteAccess_dependencies),$(eval $(d)uninstall_dependencies += lcg_SQLiteAccessuninstall))

lcg_SQLiteAccessuninstall : $(lcg_SQLiteAccessuninstall_dependencies) ##$(cmt_local_lcg_SQLiteAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_SQLiteAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_SQLiteAccess_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_SQLiteAccessuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_SQLiteAccess"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_SQLiteAccess done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_BulkInserts_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_BulkInserts_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_BulkInserts_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_BulkInserts = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_BulkInserts.make
cmt_final_setup_test_unit_SQLiteAccess_BulkInserts = $(bin)setup_test_unit_SQLiteAccess_BulkInserts.make
cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile = $(bin)test_unit_SQLiteAccess_BulkInserts.make

test_unit_SQLiteAccess_BulkInserts_extratags = -tag_add=target_test_unit_SQLiteAccess_BulkInserts

else

cmt_local_tagfile_test_unit_SQLiteAccess_BulkInserts = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_BulkInserts = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile = $(bin)test_unit_SQLiteAccess_BulkInserts.make

endif

not_test_unit_SQLiteAccess_BulkInsertscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_BulkInsertsdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_BulkInserts; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_BulkInserts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_BulkInserts
else
test_unit_SQLiteAccess_BulkInsertsdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_BulkInserts_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) : $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInserts
else
$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) : $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_BulkInserts) ] || \
	  $(not_test_unit_SQLiteAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInserts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) : $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_BulkInserts.in -tag=$(tags) $(test_unit_SQLiteAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInserts
else
$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) : $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_BulkInserts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_BulkInserts) ] || \
	  $(not_test_unit_SQLiteAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_BulkInserts.in -tag=$(tags) $(test_unit_SQLiteAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInserts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkInserts_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInserts

test_unit_SQLiteAccess_BulkInserts :: test_unit_SQLiteAccess_BulkInsertscompile test_unit_SQLiteAccess_BulkInsertsinstall ;

ifdef cmt_test_unit_SQLiteAccess_BulkInserts_has_prototypes

test_unit_SQLiteAccess_BulkInsertsprototype : $(test_unit_SQLiteAccess_BulkInsertsprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) dirs test_unit_SQLiteAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_BulkInsertscompile : test_unit_SQLiteAccess_BulkInsertsprototype

endif

test_unit_SQLiteAccess_BulkInsertscompile : $(test_unit_SQLiteAccess_BulkInsertscompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) dirs test_unit_SQLiteAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_BulkInsertsclean ;

test_unit_SQLiteAccess_BulkInsertsclean :: $(test_unit_SQLiteAccess_BulkInsertsclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) test_unit_SQLiteAccess_BulkInsertsclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $(bin)test_unit_SQLiteAccess_BulkInserts_dependencies.make

install :: test_unit_SQLiteAccess_BulkInsertsinstall ;

test_unit_SQLiteAccess_BulkInsertsinstall :: test_unit_SQLiteAccess_BulkInsertscompile $(test_unit_SQLiteAccess_BulkInserts_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_BulkInsertsuninstall

$(foreach d,$(test_unit_SQLiteAccess_BulkInserts_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_BulkInsertsuninstall))

test_unit_SQLiteAccess_BulkInsertsuninstall : $(test_unit_SQLiteAccess_BulkInsertsuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkInserts_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_BulkInsertsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_BulkInserts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_BulkInserts done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_BulkOperations_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_BulkOperations_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_BulkOperations_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_BulkOperations = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_BulkOperations.make
cmt_final_setup_test_unit_SQLiteAccess_BulkOperations = $(bin)setup_test_unit_SQLiteAccess_BulkOperations.make
cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile = $(bin)test_unit_SQLiteAccess_BulkOperations.make

test_unit_SQLiteAccess_BulkOperations_extratags = -tag_add=target_test_unit_SQLiteAccess_BulkOperations

else

cmt_local_tagfile_test_unit_SQLiteAccess_BulkOperations = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_BulkOperations = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile = $(bin)test_unit_SQLiteAccess_BulkOperations.make

endif

not_test_unit_SQLiteAccess_BulkOperationscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_BulkOperationsdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_BulkOperations; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_BulkOperations; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_BulkOperations
else
test_unit_SQLiteAccess_BulkOperationsdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_BulkOperations_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) : $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_BulkOperations.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkOperations_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperations
else
$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) : $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_BulkOperations) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_BulkOperations) ] || \
	  $(not_test_unit_SQLiteAccess_BulkOperationscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_BulkOperations.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkOperations_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperations; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) : $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_BulkOperations.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_BulkOperations.in -tag=$(tags) $(test_unit_SQLiteAccess_BulkOperations_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperations
else
$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) : $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_BulkOperations.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_BulkOperations) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_BulkOperations) ] || \
	  $(not_test_unit_SQLiteAccess_BulkOperationscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_BulkOperations.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_BulkOperations.in -tag=$(tags) $(test_unit_SQLiteAccess_BulkOperations_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperations; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_BulkOperations_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperations

test_unit_SQLiteAccess_BulkOperations :: test_unit_SQLiteAccess_BulkOperationscompile test_unit_SQLiteAccess_BulkOperationsinstall ;

ifdef cmt_test_unit_SQLiteAccess_BulkOperations_has_prototypes

test_unit_SQLiteAccess_BulkOperationsprototype : $(test_unit_SQLiteAccess_BulkOperationsprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) dirs test_unit_SQLiteAccess_BulkOperationsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_BulkOperationscompile : test_unit_SQLiteAccess_BulkOperationsprototype

endif

test_unit_SQLiteAccess_BulkOperationscompile : $(test_unit_SQLiteAccess_BulkOperationscompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) dirs test_unit_SQLiteAccess_BulkOperationsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_BulkOperationsclean ;

test_unit_SQLiteAccess_BulkOperationsclean :: $(test_unit_SQLiteAccess_BulkOperationsclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) test_unit_SQLiteAccess_BulkOperationsclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $(bin)test_unit_SQLiteAccess_BulkOperations_dependencies.make

install :: test_unit_SQLiteAccess_BulkOperationsinstall ;

test_unit_SQLiteAccess_BulkOperationsinstall :: test_unit_SQLiteAccess_BulkOperationscompile $(test_unit_SQLiteAccess_BulkOperations_dependencies) $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_BulkOperationsuninstall

$(foreach d,$(test_unit_SQLiteAccess_BulkOperations_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_BulkOperationsuninstall))

test_unit_SQLiteAccess_BulkOperationsuninstall : $(test_unit_SQLiteAccess_BulkOperationsuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_BulkOperations_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_BulkOperationsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_BulkOperations"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_BulkOperations done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_CreateListDrop_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_CreateListDrop_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_CreateListDrop_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_CreateListDrop = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_CreateListDrop.make
cmt_final_setup_test_unit_SQLiteAccess_CreateListDrop = $(bin)setup_test_unit_SQLiteAccess_CreateListDrop.make
cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile = $(bin)test_unit_SQLiteAccess_CreateListDrop.make

test_unit_SQLiteAccess_CreateListDrop_extratags = -tag_add=target_test_unit_SQLiteAccess_CreateListDrop

else

cmt_local_tagfile_test_unit_SQLiteAccess_CreateListDrop = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_CreateListDrop = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile = $(bin)test_unit_SQLiteAccess_CreateListDrop.make

endif

not_test_unit_SQLiteAccess_CreateListDropcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_CreateListDropdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_CreateListDrop; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_CreateListDrop; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_CreateListDrop
else
test_unit_SQLiteAccess_CreateListDropdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_CreateListDrop_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) : $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_CreateListDrop.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_CreateListDrop_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDrop
else
$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) : $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_CreateListDrop) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_CreateListDrop) ] || \
	  $(not_test_unit_SQLiteAccess_CreateListDropcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_CreateListDrop.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_CreateListDrop_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDrop; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) : $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_CreateListDrop.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_CreateListDrop.in -tag=$(tags) $(test_unit_SQLiteAccess_CreateListDrop_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDrop
else
$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) : $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_CreateListDrop.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_CreateListDrop) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_CreateListDrop) ] || \
	  $(not_test_unit_SQLiteAccess_CreateListDropcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_CreateListDrop.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_CreateListDrop.in -tag=$(tags) $(test_unit_SQLiteAccess_CreateListDrop_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDrop; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_CreateListDrop_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDrop

test_unit_SQLiteAccess_CreateListDrop :: test_unit_SQLiteAccess_CreateListDropcompile test_unit_SQLiteAccess_CreateListDropinstall ;

ifdef cmt_test_unit_SQLiteAccess_CreateListDrop_has_prototypes

test_unit_SQLiteAccess_CreateListDropprototype : $(test_unit_SQLiteAccess_CreateListDropprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) dirs test_unit_SQLiteAccess_CreateListDropdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_CreateListDropcompile : test_unit_SQLiteAccess_CreateListDropprototype

endif

test_unit_SQLiteAccess_CreateListDropcompile : $(test_unit_SQLiteAccess_CreateListDropcompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) dirs test_unit_SQLiteAccess_CreateListDropdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_CreateListDropclean ;

test_unit_SQLiteAccess_CreateListDropclean :: $(test_unit_SQLiteAccess_CreateListDropclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) test_unit_SQLiteAccess_CreateListDropclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $(bin)test_unit_SQLiteAccess_CreateListDrop_dependencies.make

install :: test_unit_SQLiteAccess_CreateListDropinstall ;

test_unit_SQLiteAccess_CreateListDropinstall :: test_unit_SQLiteAccess_CreateListDropcompile $(test_unit_SQLiteAccess_CreateListDrop_dependencies) $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_CreateListDropuninstall

$(foreach d,$(test_unit_SQLiteAccess_CreateListDrop_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_CreateListDropuninstall))

test_unit_SQLiteAccess_CreateListDropuninstall : $(test_unit_SQLiteAccess_CreateListDropuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_CreateListDrop_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_CreateListDropuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_CreateListDrop"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_CreateListDrop done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_DataEditor_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_DataEditor_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_DataEditor_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_DataEditor = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_DataEditor.make
cmt_final_setup_test_unit_SQLiteAccess_DataEditor = $(bin)setup_test_unit_SQLiteAccess_DataEditor.make
cmt_local_test_unit_SQLiteAccess_DataEditor_makefile = $(bin)test_unit_SQLiteAccess_DataEditor.make

test_unit_SQLiteAccess_DataEditor_extratags = -tag_add=target_test_unit_SQLiteAccess_DataEditor

else

cmt_local_tagfile_test_unit_SQLiteAccess_DataEditor = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_DataEditor = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_DataEditor_makefile = $(bin)test_unit_SQLiteAccess_DataEditor.make

endif

not_test_unit_SQLiteAccess_DataEditorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_DataEditorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_DataEditordirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_DataEditor; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_DataEditor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_DataEditor
else
test_unit_SQLiteAccess_DataEditordirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_DataEditor_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) : $(test_unit_SQLiteAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditor
else
$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) : $(test_unit_SQLiteAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DataEditor) ] || \
	  $(not_test_unit_SQLiteAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) : $(test_unit_SQLiteAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DataEditor.in -tag=$(tags) $(test_unit_SQLiteAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditor
else
$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) : $(test_unit_SQLiteAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_DataEditor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DataEditor) ] || \
	  $(not_test_unit_SQLiteAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DataEditor.in -tag=$(tags) $(test_unit_SQLiteAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DataEditor_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditor

test_unit_SQLiteAccess_DataEditor :: test_unit_SQLiteAccess_DataEditorcompile test_unit_SQLiteAccess_DataEditorinstall ;

ifdef cmt_test_unit_SQLiteAccess_DataEditor_has_prototypes

test_unit_SQLiteAccess_DataEditorprototype : $(test_unit_SQLiteAccess_DataEditorprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) dirs test_unit_SQLiteAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_DataEditorcompile : test_unit_SQLiteAccess_DataEditorprototype

endif

test_unit_SQLiteAccess_DataEditorcompile : $(test_unit_SQLiteAccess_DataEditorcompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) dirs test_unit_SQLiteAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_DataEditorclean ;

test_unit_SQLiteAccess_DataEditorclean :: $(test_unit_SQLiteAccess_DataEditorclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) test_unit_SQLiteAccess_DataEditorclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $(bin)test_unit_SQLiteAccess_DataEditor_dependencies.make

install :: test_unit_SQLiteAccess_DataEditorinstall ;

test_unit_SQLiteAccess_DataEditorinstall :: test_unit_SQLiteAccess_DataEditorcompile $(test_unit_SQLiteAccess_DataEditor_dependencies) $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_DataEditoruninstall

$(foreach d,$(test_unit_SQLiteAccess_DataEditor_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_DataEditoruninstall))

test_unit_SQLiteAccess_DataEditoruninstall : $(test_unit_SQLiteAccess_DataEditoruninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DataEditor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_DataEditoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_DataEditor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_DataEditor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_DateAndTime_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_DateAndTime_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_DateAndTime_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_DateAndTime = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_DateAndTime.make
cmt_final_setup_test_unit_SQLiteAccess_DateAndTime = $(bin)setup_test_unit_SQLiteAccess_DateAndTime.make
cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile = $(bin)test_unit_SQLiteAccess_DateAndTime.make

test_unit_SQLiteAccess_DateAndTime_extratags = -tag_add=target_test_unit_SQLiteAccess_DateAndTime

else

cmt_local_tagfile_test_unit_SQLiteAccess_DateAndTime = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_DateAndTime = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile = $(bin)test_unit_SQLiteAccess_DateAndTime.make

endif

not_test_unit_SQLiteAccess_DateAndTimecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_DateAndTimedirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_DateAndTime; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_DateAndTime; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_DateAndTime
else
test_unit_SQLiteAccess_DateAndTimedirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_DateAndTime_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) : $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DateAndTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DateAndTime_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTime
else
$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) : $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DateAndTime) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DateAndTime) ] || \
	  $(not_test_unit_SQLiteAccess_DateAndTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DateAndTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DateAndTime_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTime; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) : $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DateAndTime.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DateAndTime.in -tag=$(tags) $(test_unit_SQLiteAccess_DateAndTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTime
else
$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) : $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_DateAndTime.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DateAndTime) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DateAndTime) ] || \
	  $(not_test_unit_SQLiteAccess_DateAndTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DateAndTime.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DateAndTime.in -tag=$(tags) $(test_unit_SQLiteAccess_DateAndTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTime; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DateAndTime_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTime

test_unit_SQLiteAccess_DateAndTime :: test_unit_SQLiteAccess_DateAndTimecompile test_unit_SQLiteAccess_DateAndTimeinstall ;

ifdef cmt_test_unit_SQLiteAccess_DateAndTime_has_prototypes

test_unit_SQLiteAccess_DateAndTimeprototype : $(test_unit_SQLiteAccess_DateAndTimeprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) dirs test_unit_SQLiteAccess_DateAndTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_DateAndTimecompile : test_unit_SQLiteAccess_DateAndTimeprototype

endif

test_unit_SQLiteAccess_DateAndTimecompile : $(test_unit_SQLiteAccess_DateAndTimecompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) dirs test_unit_SQLiteAccess_DateAndTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_DateAndTimeclean ;

test_unit_SQLiteAccess_DateAndTimeclean :: $(test_unit_SQLiteAccess_DateAndTimeclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) test_unit_SQLiteAccess_DateAndTimeclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $(bin)test_unit_SQLiteAccess_DateAndTime_dependencies.make

install :: test_unit_SQLiteAccess_DateAndTimeinstall ;

test_unit_SQLiteAccess_DateAndTimeinstall :: test_unit_SQLiteAccess_DateAndTimecompile $(test_unit_SQLiteAccess_DateAndTime_dependencies) $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_DateAndTimeuninstall

$(foreach d,$(test_unit_SQLiteAccess_DateAndTime_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_DateAndTimeuninstall))

test_unit_SQLiteAccess_DateAndTimeuninstall : $(test_unit_SQLiteAccess_DateAndTimeuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DateAndTime_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_DateAndTimeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_DateAndTime"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_DateAndTime done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_DescribeTable_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_DescribeTable_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_DescribeTable_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_DescribeTable = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_DescribeTable.make
cmt_final_setup_test_unit_SQLiteAccess_DescribeTable = $(bin)setup_test_unit_SQLiteAccess_DescribeTable.make
cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile = $(bin)test_unit_SQLiteAccess_DescribeTable.make

test_unit_SQLiteAccess_DescribeTable_extratags = -tag_add=target_test_unit_SQLiteAccess_DescribeTable

else

cmt_local_tagfile_test_unit_SQLiteAccess_DescribeTable = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_DescribeTable = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile = $(bin)test_unit_SQLiteAccess_DescribeTable.make

endif

not_test_unit_SQLiteAccess_DescribeTablecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_DescribeTabledirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_DescribeTable; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_DescribeTable; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_DescribeTable
else
test_unit_SQLiteAccess_DescribeTabledirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_DescribeTable_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) : $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DescribeTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DescribeTable_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTable
else
$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) : $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DescribeTable) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DescribeTable) ] || \
	  $(not_test_unit_SQLiteAccess_DescribeTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DescribeTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DescribeTable_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTable; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) : $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_DescribeTable.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DescribeTable.in -tag=$(tags) $(test_unit_SQLiteAccess_DescribeTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTable
else
$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) : $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_DescribeTable.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_DescribeTable) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_DescribeTable) ] || \
	  $(not_test_unit_SQLiteAccess_DescribeTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_DescribeTable.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_DescribeTable.in -tag=$(tags) $(test_unit_SQLiteAccess_DescribeTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTable; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_DescribeTable_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTable

test_unit_SQLiteAccess_DescribeTable :: test_unit_SQLiteAccess_DescribeTablecompile test_unit_SQLiteAccess_DescribeTableinstall ;

ifdef cmt_test_unit_SQLiteAccess_DescribeTable_has_prototypes

test_unit_SQLiteAccess_DescribeTableprototype : $(test_unit_SQLiteAccess_DescribeTableprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) dirs test_unit_SQLiteAccess_DescribeTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_DescribeTablecompile : test_unit_SQLiteAccess_DescribeTableprototype

endif

test_unit_SQLiteAccess_DescribeTablecompile : $(test_unit_SQLiteAccess_DescribeTablecompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) dirs test_unit_SQLiteAccess_DescribeTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_DescribeTableclean ;

test_unit_SQLiteAccess_DescribeTableclean :: $(test_unit_SQLiteAccess_DescribeTableclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) test_unit_SQLiteAccess_DescribeTableclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $(bin)test_unit_SQLiteAccess_DescribeTable_dependencies.make

install :: test_unit_SQLiteAccess_DescribeTableinstall ;

test_unit_SQLiteAccess_DescribeTableinstall :: test_unit_SQLiteAccess_DescribeTablecompile $(test_unit_SQLiteAccess_DescribeTable_dependencies) $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_DescribeTableuninstall

$(foreach d,$(test_unit_SQLiteAccess_DescribeTable_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_DescribeTableuninstall))

test_unit_SQLiteAccess_DescribeTableuninstall : $(test_unit_SQLiteAccess_DescribeTableuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_DescribeTable_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_DescribeTableuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_DescribeTable"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_DescribeTable done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_QueriesInSingleTable_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_QueriesInSingleTable_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_QueriesInSingleTable_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_QueriesInSingleTable = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_QueriesInSingleTable.make
cmt_final_setup_test_unit_SQLiteAccess_QueriesInSingleTable = $(bin)setup_test_unit_SQLiteAccess_QueriesInSingleTable.make
cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile = $(bin)test_unit_SQLiteAccess_QueriesInSingleTable.make

test_unit_SQLiteAccess_QueriesInSingleTable_extratags = -tag_add=target_test_unit_SQLiteAccess_QueriesInSingleTable

else

cmt_local_tagfile_test_unit_SQLiteAccess_QueriesInSingleTable = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_QueriesInSingleTable = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile = $(bin)test_unit_SQLiteAccess_QueriesInSingleTable.make

endif

not_test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_QueriesInSingleTabledirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_QueriesInSingleTable; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_QueriesInSingleTable; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_QueriesInSingleTable
else
test_unit_SQLiteAccess_QueriesInSingleTabledirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_QueriesInSingleTable_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) : $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_QueriesInSingleTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesInSingleTable_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTable
else
$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) : $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_QueriesInSingleTable) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_QueriesInSingleTable) ] || \
	  $(not_test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_QueriesInSingleTable.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesInSingleTable_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTable; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) : $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_QueriesInSingleTable.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_QueriesInSingleTable.in -tag=$(tags) $(test_unit_SQLiteAccess_QueriesInSingleTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTable
else
$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) : $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_QueriesInSingleTable.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_QueriesInSingleTable) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_QueriesInSingleTable) ] || \
	  $(not_test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_QueriesInSingleTable.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_QueriesInSingleTable.in -tag=$(tags) $(test_unit_SQLiteAccess_QueriesInSingleTable_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTable; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesInSingleTable_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTable

test_unit_SQLiteAccess_QueriesInSingleTable :: test_unit_SQLiteAccess_QueriesInSingleTablecompile test_unit_SQLiteAccess_QueriesInSingleTableinstall ;

ifdef cmt_test_unit_SQLiteAccess_QueriesInSingleTable_has_prototypes

test_unit_SQLiteAccess_QueriesInSingleTableprototype : $(test_unit_SQLiteAccess_QueriesInSingleTableprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) dirs test_unit_SQLiteAccess_QueriesInSingleTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_QueriesInSingleTablecompile : test_unit_SQLiteAccess_QueriesInSingleTableprototype

endif

test_unit_SQLiteAccess_QueriesInSingleTablecompile : $(test_unit_SQLiteAccess_QueriesInSingleTablecompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) dirs test_unit_SQLiteAccess_QueriesInSingleTabledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_QueriesInSingleTableclean ;

test_unit_SQLiteAccess_QueriesInSingleTableclean :: $(test_unit_SQLiteAccess_QueriesInSingleTableclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) test_unit_SQLiteAccess_QueriesInSingleTableclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $(bin)test_unit_SQLiteAccess_QueriesInSingleTable_dependencies.make

install :: test_unit_SQLiteAccess_QueriesInSingleTableinstall ;

test_unit_SQLiteAccess_QueriesInSingleTableinstall :: test_unit_SQLiteAccess_QueriesInSingleTablecompile $(test_unit_SQLiteAccess_QueriesInSingleTable_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_QueriesInSingleTableuninstall

$(foreach d,$(test_unit_SQLiteAccess_QueriesInSingleTable_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_QueriesInSingleTableuninstall))

test_unit_SQLiteAccess_QueriesInSingleTableuninstall : $(test_unit_SQLiteAccess_QueriesInSingleTableuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesInSingleTable_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_QueriesInSingleTableuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_QueriesInSingleTable"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_QueriesInSingleTable done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_QueriesWithMultipleTables_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_QueriesWithMultipleTables_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_QueriesWithMultipleTables_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_QueriesWithMultipleTables = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_QueriesWithMultipleTables.make
cmt_final_setup_test_unit_SQLiteAccess_QueriesWithMultipleTables = $(bin)setup_test_unit_SQLiteAccess_QueriesWithMultipleTables.make
cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile = $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables.make

test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags = -tag_add=target_test_unit_SQLiteAccess_QueriesWithMultipleTables

else

cmt_local_tagfile_test_unit_SQLiteAccess_QueriesWithMultipleTables = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_QueriesWithMultipleTables = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile = $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables.make

endif

not_test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_QueriesWithMultipleTablesdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables
else
test_unit_SQLiteAccess_QueriesWithMultipleTablesdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_QueriesWithMultipleTables_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) : $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_QueriesWithMultipleTables.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTables
else
$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) : $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_QueriesWithMultipleTables) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_QueriesWithMultipleTables) ] || \
	  $(not_test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_QueriesWithMultipleTables.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTables; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) : $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_QueriesWithMultipleTables.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables.in -tag=$(tags) $(test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTables
else
$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) : $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_QueriesWithMultipleTables) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_QueriesWithMultipleTables) ] || \
	  $(not_test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_QueriesWithMultipleTables.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables.in -tag=$(tags) $(test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTables; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_QueriesWithMultipleTables_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTables

test_unit_SQLiteAccess_QueriesWithMultipleTables :: test_unit_SQLiteAccess_QueriesWithMultipleTablescompile test_unit_SQLiteAccess_QueriesWithMultipleTablesinstall ;

ifdef cmt_test_unit_SQLiteAccess_QueriesWithMultipleTables_has_prototypes

test_unit_SQLiteAccess_QueriesWithMultipleTablesprototype : $(test_unit_SQLiteAccess_QueriesWithMultipleTablesprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) dirs test_unit_SQLiteAccess_QueriesWithMultipleTablesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_QueriesWithMultipleTablescompile : test_unit_SQLiteAccess_QueriesWithMultipleTablesprototype

endif

test_unit_SQLiteAccess_QueriesWithMultipleTablescompile : $(test_unit_SQLiteAccess_QueriesWithMultipleTablescompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) dirs test_unit_SQLiteAccess_QueriesWithMultipleTablesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_QueriesWithMultipleTablesclean ;

test_unit_SQLiteAccess_QueriesWithMultipleTablesclean :: $(test_unit_SQLiteAccess_QueriesWithMultipleTablesclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) test_unit_SQLiteAccess_QueriesWithMultipleTablesclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $(bin)test_unit_SQLiteAccess_QueriesWithMultipleTables_dependencies.make

install :: test_unit_SQLiteAccess_QueriesWithMultipleTablesinstall ;

test_unit_SQLiteAccess_QueriesWithMultipleTablesinstall :: test_unit_SQLiteAccess_QueriesWithMultipleTablescompile $(test_unit_SQLiteAccess_QueriesWithMultipleTables_dependencies) $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_QueriesWithMultipleTablesuninstall

$(foreach d,$(test_unit_SQLiteAccess_QueriesWithMultipleTables_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_QueriesWithMultipleTablesuninstall))

test_unit_SQLiteAccess_QueriesWithMultipleTablesuninstall : $(test_unit_SQLiteAccess_QueriesWithMultipleTablesuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_QueriesWithMultipleTables_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_QueriesWithMultipleTablesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_QueriesWithMultipleTables"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_QueriesWithMultipleTables done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_SchemaEditor_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_SchemaEditor_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_SchemaEditor_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_SchemaEditor = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_SchemaEditor.make
cmt_final_setup_test_unit_SQLiteAccess_SchemaEditor = $(bin)setup_test_unit_SQLiteAccess_SchemaEditor.make
cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile = $(bin)test_unit_SQLiteAccess_SchemaEditor.make

test_unit_SQLiteAccess_SchemaEditor_extratags = -tag_add=target_test_unit_SQLiteAccess_SchemaEditor

else

cmt_local_tagfile_test_unit_SQLiteAccess_SchemaEditor = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_SchemaEditor = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile = $(bin)test_unit_SQLiteAccess_SchemaEditor.make

endif

not_test_unit_SQLiteAccess_SchemaEditorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_SchemaEditordirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_SchemaEditor; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_SchemaEditor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_SchemaEditor
else
test_unit_SQLiteAccess_SchemaEditordirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_SchemaEditor_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) : $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_SchemaEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_SchemaEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditor
else
$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) : $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_SchemaEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_SchemaEditor) ] || \
	  $(not_test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_SchemaEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_SchemaEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) : $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_SchemaEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_SchemaEditor.in -tag=$(tags) $(test_unit_SQLiteAccess_SchemaEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditor
else
$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) : $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_SchemaEditor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_SchemaEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_SchemaEditor) ] || \
	  $(not_test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_SchemaEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_SchemaEditor.in -tag=$(tags) $(test_unit_SQLiteAccess_SchemaEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_SchemaEditor_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditor

test_unit_SQLiteAccess_SchemaEditor :: test_unit_SQLiteAccess_SchemaEditorcompile test_unit_SQLiteAccess_SchemaEditorinstall ;

ifdef cmt_test_unit_SQLiteAccess_SchemaEditor_has_prototypes

test_unit_SQLiteAccess_SchemaEditorprototype : $(test_unit_SQLiteAccess_SchemaEditorprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) dirs test_unit_SQLiteAccess_SchemaEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_SchemaEditorcompile : test_unit_SQLiteAccess_SchemaEditorprototype

endif

test_unit_SQLiteAccess_SchemaEditorcompile : $(test_unit_SQLiteAccess_SchemaEditorcompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) dirs test_unit_SQLiteAccess_SchemaEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_SchemaEditorclean ;

test_unit_SQLiteAccess_SchemaEditorclean :: $(test_unit_SQLiteAccess_SchemaEditorclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) test_unit_SQLiteAccess_SchemaEditorclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $(bin)test_unit_SQLiteAccess_SchemaEditor_dependencies.make

install :: test_unit_SQLiteAccess_SchemaEditorinstall ;

test_unit_SQLiteAccess_SchemaEditorinstall :: test_unit_SQLiteAccess_SchemaEditorcompile $(test_unit_SQLiteAccess_SchemaEditor_dependencies) $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_SchemaEditoruninstall

$(foreach d,$(test_unit_SQLiteAccess_SchemaEditor_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_SchemaEditoruninstall))

test_unit_SQLiteAccess_SchemaEditoruninstall : $(test_unit_SQLiteAccess_SchemaEditoruninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_SchemaEditor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_SchemaEditoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_SchemaEditor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_SchemaEditor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_uInt32Order_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_uInt32Order_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_uInt32Order_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_uInt32Order = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_uInt32Order.make
cmt_final_setup_test_unit_SQLiteAccess_uInt32Order = $(bin)setup_test_unit_SQLiteAccess_uInt32Order.make
cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile = $(bin)test_unit_SQLiteAccess_uInt32Order.make

test_unit_SQLiteAccess_uInt32Order_extratags = -tag_add=target_test_unit_SQLiteAccess_uInt32Order

else

cmt_local_tagfile_test_unit_SQLiteAccess_uInt32Order = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_uInt32Order = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile = $(bin)test_unit_SQLiteAccess_uInt32Order.make

endif

not_test_unit_SQLiteAccess_uInt32Ordercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_uInt32Orderdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_uInt32Order; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_uInt32Order; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_uInt32Order
else
test_unit_SQLiteAccess_uInt32Orderdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_uInt32Order_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) : $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_uInt32Order.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_uInt32Order_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Order
else
$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) : $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_uInt32Order) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_uInt32Order) ] || \
	  $(not_test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_uInt32Order.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_uInt32Order_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Order; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) : $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_uInt32Order.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_uInt32Order.in -tag=$(tags) $(test_unit_SQLiteAccess_uInt32Order_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Order
else
$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) : $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_uInt32Order.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_uInt32Order) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_uInt32Order) ] || \
	  $(not_test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_uInt32Order.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_uInt32Order.in -tag=$(tags) $(test_unit_SQLiteAccess_uInt32Order_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Order; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_uInt32Order_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Order

test_unit_SQLiteAccess_uInt32Order :: test_unit_SQLiteAccess_uInt32Ordercompile test_unit_SQLiteAccess_uInt32Orderinstall ;

ifdef cmt_test_unit_SQLiteAccess_uInt32Order_has_prototypes

test_unit_SQLiteAccess_uInt32Orderprototype : $(test_unit_SQLiteAccess_uInt32Orderprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) dirs test_unit_SQLiteAccess_uInt32Orderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_uInt32Ordercompile : test_unit_SQLiteAccess_uInt32Orderprototype

endif

test_unit_SQLiteAccess_uInt32Ordercompile : $(test_unit_SQLiteAccess_uInt32Ordercompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) dirs test_unit_SQLiteAccess_uInt32Orderdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_uInt32Orderclean ;

test_unit_SQLiteAccess_uInt32Orderclean :: $(test_unit_SQLiteAccess_uInt32Orderclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) test_unit_SQLiteAccess_uInt32Orderclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $(bin)test_unit_SQLiteAccess_uInt32Order_dependencies.make

install :: test_unit_SQLiteAccess_uInt32Orderinstall ;

test_unit_SQLiteAccess_uInt32Orderinstall :: test_unit_SQLiteAccess_uInt32Ordercompile $(test_unit_SQLiteAccess_uInt32Order_dependencies) $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_uInt32Orderuninstall

$(foreach d,$(test_unit_SQLiteAccess_uInt32Order_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_uInt32Orderuninstall))

test_unit_SQLiteAccess_uInt32Orderuninstall : $(test_unit_SQLiteAccess_uInt32Orderuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_uInt32Order_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_uInt32Orderuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_uInt32Order"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_uInt32Order done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_Views_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_Views_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_Views_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_Views = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_Views.make
cmt_final_setup_test_unit_SQLiteAccess_Views = $(bin)setup_test_unit_SQLiteAccess_Views.make
cmt_local_test_unit_SQLiteAccess_Views_makefile = $(bin)test_unit_SQLiteAccess_Views.make

test_unit_SQLiteAccess_Views_extratags = -tag_add=target_test_unit_SQLiteAccess_Views

else

cmt_local_tagfile_test_unit_SQLiteAccess_Views = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_Views = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_Views_makefile = $(bin)test_unit_SQLiteAccess_Views.make

endif

not_test_unit_SQLiteAccess_Viewscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_Viewscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_Viewsdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_Views; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_Views; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_Views
else
test_unit_SQLiteAccess_Viewsdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_Views_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_Views_makefile) : $(test_unit_SQLiteAccess_Viewscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_Views.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_Views_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Views
else
$(cmt_local_test_unit_SQLiteAccess_Views_makefile) : $(test_unit_SQLiteAccess_Viewscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_Views) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_Views) ] || \
	  $(not_test_unit_SQLiteAccess_Viewscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_Views.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_Views_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Views; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_Views_makefile) : $(test_unit_SQLiteAccess_Viewscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_Views.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_Views.in -tag=$(tags) $(test_unit_SQLiteAccess_Views_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Views
else
$(cmt_local_test_unit_SQLiteAccess_Views_makefile) : $(test_unit_SQLiteAccess_Viewscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_Views.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_Views) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_Views) ] || \
	  $(not_test_unit_SQLiteAccess_Viewscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_Views.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_Views.in -tag=$(tags) $(test_unit_SQLiteAccess_Views_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Views; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_Views_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Views

test_unit_SQLiteAccess_Views :: test_unit_SQLiteAccess_Viewscompile test_unit_SQLiteAccess_Viewsinstall ;

ifdef cmt_test_unit_SQLiteAccess_Views_has_prototypes

test_unit_SQLiteAccess_Viewsprototype : $(test_unit_SQLiteAccess_Viewsprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_Views_makefile) dirs test_unit_SQLiteAccess_Viewsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_Viewscompile : test_unit_SQLiteAccess_Viewsprototype

endif

test_unit_SQLiteAccess_Viewscompile : $(test_unit_SQLiteAccess_Viewscompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_Views_makefile) dirs test_unit_SQLiteAccess_Viewsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_Viewsclean ;

test_unit_SQLiteAccess_Viewsclean :: $(test_unit_SQLiteAccess_Viewsclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) test_unit_SQLiteAccess_Viewsclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $(bin)test_unit_SQLiteAccess_Views_dependencies.make

install :: test_unit_SQLiteAccess_Viewsinstall ;

test_unit_SQLiteAccess_Viewsinstall :: test_unit_SQLiteAccess_Viewscompile $(test_unit_SQLiteAccess_Views_dependencies) $(cmt_local_test_unit_SQLiteAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_Viewsuninstall

$(foreach d,$(test_unit_SQLiteAccess_Views_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_Viewsuninstall))

test_unit_SQLiteAccess_Viewsuninstall : $(test_unit_SQLiteAccess_Viewsuninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_Views_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_Viewsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_Views"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_Views done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_SQLiteAccess_ExpressionParser_has_no_target_tag = 1
cmt_test_unit_SQLiteAccess_ExpressionParser_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_SQLiteAccess_ExpressionParser_has_target_tag

cmt_local_tagfile_test_unit_SQLiteAccess_ExpressionParser = $(bin)$(SQLiteAccess_tag)_test_unit_SQLiteAccess_ExpressionParser.make
cmt_final_setup_test_unit_SQLiteAccess_ExpressionParser = $(bin)setup_test_unit_SQLiteAccess_ExpressionParser.make
cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile = $(bin)test_unit_SQLiteAccess_ExpressionParser.make

test_unit_SQLiteAccess_ExpressionParser_extratags = -tag_add=target_test_unit_SQLiteAccess_ExpressionParser

else

cmt_local_tagfile_test_unit_SQLiteAccess_ExpressionParser = $(bin)$(SQLiteAccess_tag).make
cmt_final_setup_test_unit_SQLiteAccess_ExpressionParser = $(bin)setup.make
cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile = $(bin)test_unit_SQLiteAccess_ExpressionParser.make

endif

not_test_unit_SQLiteAccess_ExpressionParsercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_SQLiteAccess_ExpressionParserdirs :
	@if test ! -d $(bin)test_unit_SQLiteAccess_ExpressionParser; then $(mkdir) -p $(bin)test_unit_SQLiteAccess_ExpressionParser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_SQLiteAccess_ExpressionParser
else
test_unit_SQLiteAccess_ExpressionParserdirs : ;
endif

ifdef cmt_test_unit_SQLiteAccess_ExpressionParser_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) : $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_ExpressionParser.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_ExpressionParser_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParser
else
$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) : $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_ExpressionParser) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_ExpressionParser) ] || \
	  $(not_test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_ExpressionParser.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_ExpressionParser_extratags) build constituent_config -out=$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) : $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_SQLiteAccess_ExpressionParser.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_ExpressionParser.in -tag=$(tags) $(test_unit_SQLiteAccess_ExpressionParser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParser
else
$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) : $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_SQLiteAccess_ExpressionParser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_SQLiteAccess_ExpressionParser) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_SQLiteAccess_ExpressionParser) ] || \
	  $(not_test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_SQLiteAccess_ExpressionParser.make"; \
	  $(cmtexe) -f=$(bin)test_unit_SQLiteAccess_ExpressionParser.in -tag=$(tags) $(test_unit_SQLiteAccess_ExpressionParser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_SQLiteAccess_ExpressionParser_extratags) build constituent_makefile -out=$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParser

test_unit_SQLiteAccess_ExpressionParser :: test_unit_SQLiteAccess_ExpressionParsercompile test_unit_SQLiteAccess_ExpressionParserinstall ;

ifdef cmt_test_unit_SQLiteAccess_ExpressionParser_has_prototypes

test_unit_SQLiteAccess_ExpressionParserprototype : $(test_unit_SQLiteAccess_ExpressionParserprototype_dependencies) $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) dirs test_unit_SQLiteAccess_ExpressionParserdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_SQLiteAccess_ExpressionParsercompile : test_unit_SQLiteAccess_ExpressionParserprototype

endif

test_unit_SQLiteAccess_ExpressionParsercompile : $(test_unit_SQLiteAccess_ExpressionParsercompile_dependencies) $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) dirs test_unit_SQLiteAccess_ExpressionParserdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_SQLiteAccess_ExpressionParserclean ;

test_unit_SQLiteAccess_ExpressionParserclean :: $(test_unit_SQLiteAccess_ExpressionParserclean_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) test_unit_SQLiteAccess_ExpressionParserclean

##	  /bin/rm -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $(bin)test_unit_SQLiteAccess_ExpressionParser_dependencies.make

install :: test_unit_SQLiteAccess_ExpressionParserinstall ;

test_unit_SQLiteAccess_ExpressionParserinstall :: test_unit_SQLiteAccess_ExpressionParsercompile $(test_unit_SQLiteAccess_ExpressionParser_dependencies) $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_SQLiteAccess_ExpressionParseruninstall

$(foreach d,$(test_unit_SQLiteAccess_ExpressionParser_dependencies),$(eval $(d)uninstall_dependencies += test_unit_SQLiteAccess_ExpressionParseruninstall))

test_unit_SQLiteAccess_ExpressionParseruninstall : $(test_unit_SQLiteAccess_ExpressionParseruninstall_dependencies) ##$(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_SQLiteAccess_ExpressionParser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_SQLiteAccess_ExpressionParseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_SQLiteAccess_ExpressionParser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_SQLiteAccess_ExpressionParser done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(SQLiteAccess_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(SQLiteAccess_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(SQLiteAccess_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(SQLiteAccess_tag).make
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

cmt_local_tagfile_make = $(bin)$(SQLiteAccess_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(SQLiteAccess_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(SQLiteAccess_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(SQLiteAccess_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(SQLiteAccess_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(SQLiteAccess_tag).make
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

cmt_local_tagfile_examples = $(bin)$(SQLiteAccess_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(SQLiteAccess_tag).make
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
