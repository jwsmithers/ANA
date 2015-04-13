
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

MySQLAccess_tag = $(tag)

#cmt_local_tagfile = $(MySQLAccess_tag).make
cmt_local_tagfile = $(bin)$(MySQLAccess_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)MySQLAccesssetup.make
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

cmt_lcg_MySQLAccess_has_no_target_tag = 1
cmt_lcg_MySQLAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_MySQLAccess_has_target_tag

cmt_local_tagfile_lcg_MySQLAccess = $(bin)$(MySQLAccess_tag)_lcg_MySQLAccess.make
cmt_final_setup_lcg_MySQLAccess = $(bin)setup_lcg_MySQLAccess.make
cmt_local_lcg_MySQLAccess_makefile = $(bin)lcg_MySQLAccess.make

lcg_MySQLAccess_extratags = -tag_add=target_lcg_MySQLAccess

else

cmt_local_tagfile_lcg_MySQLAccess = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_lcg_MySQLAccess = $(bin)setup.make
cmt_local_lcg_MySQLAccess_makefile = $(bin)lcg_MySQLAccess.make

endif

not_lcg_MySQLAccesscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_MySQLAccesscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_MySQLAccessdirs :
	@if test ! -d $(bin)lcg_MySQLAccess; then $(mkdir) -p $(bin)lcg_MySQLAccess; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_MySQLAccess
else
lcg_MySQLAccessdirs : ;
endif

ifdef cmt_lcg_MySQLAccess_has_target_tag

ifndef QUICK
$(cmt_local_lcg_MySQLAccess_makefile) : $(lcg_MySQLAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_MySQLAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_MySQLAccess_extratags) build constituent_config -out=$(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccess
else
$(cmt_local_lcg_MySQLAccess_makefile) : $(lcg_MySQLAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_MySQLAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_MySQLAccess) ] || \
	  $(not_lcg_MySQLAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_MySQLAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_MySQLAccess_extratags) build constituent_config -out=$(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccess; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_MySQLAccess_makefile) : $(lcg_MySQLAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_MySQLAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_MySQLAccess.in -tag=$(tags) $(lcg_MySQLAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccess
else
$(cmt_local_lcg_MySQLAccess_makefile) : $(lcg_MySQLAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_MySQLAccess.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_MySQLAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_MySQLAccess) ] || \
	  $(not_lcg_MySQLAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_MySQLAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_MySQLAccess.in -tag=$(tags) $(lcg_MySQLAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccess; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_MySQLAccess_extratags) build constituent_makefile -out=$(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccess

lcg_MySQLAccess :: lcg_MySQLAccesscompile lcg_MySQLAccessinstall ;

ifdef cmt_lcg_MySQLAccess_has_prototypes

lcg_MySQLAccessprototype : $(lcg_MySQLAccessprototype_dependencies) $(cmt_local_lcg_MySQLAccess_makefile) dirs lcg_MySQLAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_MySQLAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_MySQLAccesscompile : lcg_MySQLAccessprototype

endif

lcg_MySQLAccesscompile : $(lcg_MySQLAccesscompile_dependencies) $(cmt_local_lcg_MySQLAccess_makefile) dirs lcg_MySQLAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_MySQLAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_MySQLAccessclean ;

lcg_MySQLAccessclean :: $(lcg_MySQLAccessclean_dependencies) ##$(cmt_local_lcg_MySQLAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_MySQLAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) lcg_MySQLAccessclean

##	  /bin/rm -f $(cmt_local_lcg_MySQLAccess_makefile) $(bin)lcg_MySQLAccess_dependencies.make

install :: lcg_MySQLAccessinstall ;

lcg_MySQLAccessinstall :: lcg_MySQLAccesscompile $(lcg_MySQLAccess_dependencies) $(cmt_local_lcg_MySQLAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_MySQLAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_MySQLAccessuninstall

$(foreach d,$(lcg_MySQLAccess_dependencies),$(eval $(d)uninstall_dependencies += lcg_MySQLAccessuninstall))

lcg_MySQLAccessuninstall : $(lcg_MySQLAccessuninstall_dependencies) ##$(cmt_local_lcg_MySQLAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_MySQLAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_MySQLAccess_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_MySQLAccessuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_MySQLAccess"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_MySQLAccess done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_BulkInserts_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_BulkInserts_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_BulkInserts_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_BulkInserts = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_BulkInserts.make
cmt_final_setup_test_unit_MySQLAccess_BulkInserts = $(bin)setup_test_unit_MySQLAccess_BulkInserts.make
cmt_local_test_unit_MySQLAccess_BulkInserts_makefile = $(bin)test_unit_MySQLAccess_BulkInserts.make

test_unit_MySQLAccess_BulkInserts_extratags = -tag_add=target_test_unit_MySQLAccess_BulkInserts

else

cmt_local_tagfile_test_unit_MySQLAccess_BulkInserts = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_BulkInserts = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_BulkInserts_makefile = $(bin)test_unit_MySQLAccess_BulkInserts.make

endif

not_test_unit_MySQLAccess_BulkInsertscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_BulkInsertscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_BulkInsertsdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_BulkInserts; then $(mkdir) -p $(bin)test_unit_MySQLAccess_BulkInserts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_BulkInserts
else
test_unit_MySQLAccess_BulkInsertsdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_BulkInserts_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) : $(test_unit_MySQLAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInserts
else
$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) : $(test_unit_MySQLAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_BulkInserts) ] || \
	  $(not_test_unit_MySQLAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInserts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) : $(test_unit_MySQLAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_BulkInserts.in -tag=$(tags) $(test_unit_MySQLAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInserts
else
$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) : $(test_unit_MySQLAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_BulkInserts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_BulkInserts) ] || \
	  $(not_test_unit_MySQLAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_BulkInserts.in -tag=$(tags) $(test_unit_MySQLAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInserts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_BulkInserts_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInserts

test_unit_MySQLAccess_BulkInserts :: test_unit_MySQLAccess_BulkInsertscompile test_unit_MySQLAccess_BulkInsertsinstall ;

ifdef cmt_test_unit_MySQLAccess_BulkInserts_has_prototypes

test_unit_MySQLAccess_BulkInsertsprototype : $(test_unit_MySQLAccess_BulkInsertsprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) dirs test_unit_MySQLAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_BulkInsertscompile : test_unit_MySQLAccess_BulkInsertsprototype

endif

test_unit_MySQLAccess_BulkInsertscompile : $(test_unit_MySQLAccess_BulkInsertscompile_dependencies) $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) dirs test_unit_MySQLAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_BulkInsertsclean ;

test_unit_MySQLAccess_BulkInsertsclean :: $(test_unit_MySQLAccess_BulkInsertsclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) test_unit_MySQLAccess_BulkInsertsclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $(bin)test_unit_MySQLAccess_BulkInserts_dependencies.make

install :: test_unit_MySQLAccess_BulkInsertsinstall ;

test_unit_MySQLAccess_BulkInsertsinstall :: test_unit_MySQLAccess_BulkInsertscompile $(test_unit_MySQLAccess_BulkInserts_dependencies) $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_BulkInsertsuninstall

$(foreach d,$(test_unit_MySQLAccess_BulkInserts_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_BulkInsertsuninstall))

test_unit_MySQLAccess_BulkInsertsuninstall : $(test_unit_MySQLAccess_BulkInsertsuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_BulkInserts_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_BulkInsertsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_BulkInserts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_BulkInserts done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_DataEditor_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_DataEditor_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_DataEditor_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_DataEditor = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_DataEditor.make
cmt_final_setup_test_unit_MySQLAccess_DataEditor = $(bin)setup_test_unit_MySQLAccess_DataEditor.make
cmt_local_test_unit_MySQLAccess_DataEditor_makefile = $(bin)test_unit_MySQLAccess_DataEditor.make

test_unit_MySQLAccess_DataEditor_extratags = -tag_add=target_test_unit_MySQLAccess_DataEditor

else

cmt_local_tagfile_test_unit_MySQLAccess_DataEditor = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_DataEditor = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_DataEditor_makefile = $(bin)test_unit_MySQLAccess_DataEditor.make

endif

not_test_unit_MySQLAccess_DataEditorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_DataEditorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_DataEditordirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_DataEditor; then $(mkdir) -p $(bin)test_unit_MySQLAccess_DataEditor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_DataEditor
else
test_unit_MySQLAccess_DataEditordirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_DataEditor_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) : $(test_unit_MySQLAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditor
else
$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) : $(test_unit_MySQLAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_DataEditor) ] || \
	  $(not_test_unit_MySQLAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) : $(test_unit_MySQLAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_DataEditor.in -tag=$(tags) $(test_unit_MySQLAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditor
else
$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) : $(test_unit_MySQLAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_DataEditor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_DataEditor) ] || \
	  $(not_test_unit_MySQLAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_DataEditor.in -tag=$(tags) $(test_unit_MySQLAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_DataEditor_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditor

test_unit_MySQLAccess_DataEditor :: test_unit_MySQLAccess_DataEditorcompile test_unit_MySQLAccess_DataEditorinstall ;

ifdef cmt_test_unit_MySQLAccess_DataEditor_has_prototypes

test_unit_MySQLAccess_DataEditorprototype : $(test_unit_MySQLAccess_DataEditorprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) dirs test_unit_MySQLAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_DataEditorcompile : test_unit_MySQLAccess_DataEditorprototype

endif

test_unit_MySQLAccess_DataEditorcompile : $(test_unit_MySQLAccess_DataEditorcompile_dependencies) $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) dirs test_unit_MySQLAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_DataEditorclean ;

test_unit_MySQLAccess_DataEditorclean :: $(test_unit_MySQLAccess_DataEditorclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) test_unit_MySQLAccess_DataEditorclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $(bin)test_unit_MySQLAccess_DataEditor_dependencies.make

install :: test_unit_MySQLAccess_DataEditorinstall ;

test_unit_MySQLAccess_DataEditorinstall :: test_unit_MySQLAccess_DataEditorcompile $(test_unit_MySQLAccess_DataEditor_dependencies) $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_DataEditoruninstall

$(foreach d,$(test_unit_MySQLAccess_DataEditor_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_DataEditoruninstall))

test_unit_MySQLAccess_DataEditoruninstall : $(test_unit_MySQLAccess_DataEditoruninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_DataEditor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_DataEditoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_DataEditor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_DataEditor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_MultipleSchemas_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_MultipleSchemas_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_MultipleSchemas_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_MultipleSchemas = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_MultipleSchemas.make
cmt_final_setup_test_unit_MySQLAccess_MultipleSchemas = $(bin)setup_test_unit_MySQLAccess_MultipleSchemas.make
cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile = $(bin)test_unit_MySQLAccess_MultipleSchemas.make

test_unit_MySQLAccess_MultipleSchemas_extratags = -tag_add=target_test_unit_MySQLAccess_MultipleSchemas

else

cmt_local_tagfile_test_unit_MySQLAccess_MultipleSchemas = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_MultipleSchemas = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile = $(bin)test_unit_MySQLAccess_MultipleSchemas.make

endif

not_test_unit_MySQLAccess_MultipleSchemascompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_MultipleSchemasdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_MultipleSchemas; then $(mkdir) -p $(bin)test_unit_MySQLAccess_MultipleSchemas; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_MultipleSchemas
else
test_unit_MySQLAccess_MultipleSchemasdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_MultipleSchemas_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) : $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemas
else
$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) : $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_MultipleSchemas) ] || \
	  $(not_test_unit_MySQLAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemas; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) : $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_MySQLAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemas
else
$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) : $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_MultipleSchemas.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_MultipleSchemas) ] || \
	  $(not_test_unit_MySQLAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_MySQLAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemas; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_MultipleSchemas_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemas

test_unit_MySQLAccess_MultipleSchemas :: test_unit_MySQLAccess_MultipleSchemascompile test_unit_MySQLAccess_MultipleSchemasinstall ;

ifdef cmt_test_unit_MySQLAccess_MultipleSchemas_has_prototypes

test_unit_MySQLAccess_MultipleSchemasprototype : $(test_unit_MySQLAccess_MultipleSchemasprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) dirs test_unit_MySQLAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_MultipleSchemascompile : test_unit_MySQLAccess_MultipleSchemasprototype

endif

test_unit_MySQLAccess_MultipleSchemascompile : $(test_unit_MySQLAccess_MultipleSchemascompile_dependencies) $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) dirs test_unit_MySQLAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_MultipleSchemasclean ;

test_unit_MySQLAccess_MultipleSchemasclean :: $(test_unit_MySQLAccess_MultipleSchemasclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) test_unit_MySQLAccess_MultipleSchemasclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $(bin)test_unit_MySQLAccess_MultipleSchemas_dependencies.make

install :: test_unit_MySQLAccess_MultipleSchemasinstall ;

test_unit_MySQLAccess_MultipleSchemasinstall :: test_unit_MySQLAccess_MultipleSchemascompile $(test_unit_MySQLAccess_MultipleSchemas_dependencies) $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_MultipleSchemasuninstall

$(foreach d,$(test_unit_MySQLAccess_MultipleSchemas_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_MultipleSchemasuninstall))

test_unit_MySQLAccess_MultipleSchemasuninstall : $(test_unit_MySQLAccess_MultipleSchemasuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_MultipleSchemas_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_MultipleSchemasuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_MultipleSchemas"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_MultipleSchemas done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_Schema_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_Schema_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_Schema_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_Schema = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_Schema.make
cmt_final_setup_test_unit_MySQLAccess_Schema = $(bin)setup_test_unit_MySQLAccess_Schema.make
cmt_local_test_unit_MySQLAccess_Schema_makefile = $(bin)test_unit_MySQLAccess_Schema.make

test_unit_MySQLAccess_Schema_extratags = -tag_add=target_test_unit_MySQLAccess_Schema

else

cmt_local_tagfile_test_unit_MySQLAccess_Schema = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_Schema = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_Schema_makefile = $(bin)test_unit_MySQLAccess_Schema.make

endif

not_test_unit_MySQLAccess_Schemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_Schemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_Schemadirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_Schema; then $(mkdir) -p $(bin)test_unit_MySQLAccess_Schema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_Schema
else
test_unit_MySQLAccess_Schemadirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_Schema_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Schema_makefile) : $(test_unit_MySQLAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schema
else
$(cmt_local_test_unit_MySQLAccess_Schema_makefile) : $(test_unit_MySQLAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Schema) ] || \
	  $(not_test_unit_MySQLAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Schema_makefile) : $(test_unit_MySQLAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Schema.in -tag=$(tags) $(test_unit_MySQLAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schema
else
$(cmt_local_test_unit_MySQLAccess_Schema_makefile) : $(test_unit_MySQLAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_Schema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Schema) ] || \
	  $(not_test_unit_MySQLAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Schema.in -tag=$(tags) $(test_unit_MySQLAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Schema_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schema

test_unit_MySQLAccess_Schema :: test_unit_MySQLAccess_Schemacompile test_unit_MySQLAccess_Schemainstall ;

ifdef cmt_test_unit_MySQLAccess_Schema_has_prototypes

test_unit_MySQLAccess_Schemaprototype : $(test_unit_MySQLAccess_Schemaprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_Schema_makefile) dirs test_unit_MySQLAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_Schemacompile : test_unit_MySQLAccess_Schemaprototype

endif

test_unit_MySQLAccess_Schemacompile : $(test_unit_MySQLAccess_Schemacompile_dependencies) $(cmt_local_test_unit_MySQLAccess_Schema_makefile) dirs test_unit_MySQLAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_Schemaclean ;

test_unit_MySQLAccess_Schemaclean :: $(test_unit_MySQLAccess_Schemaclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) test_unit_MySQLAccess_Schemaclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $(bin)test_unit_MySQLAccess_Schema_dependencies.make

install :: test_unit_MySQLAccess_Schemainstall ;

test_unit_MySQLAccess_Schemainstall :: test_unit_MySQLAccess_Schemacompile $(test_unit_MySQLAccess_Schema_dependencies) $(cmt_local_test_unit_MySQLAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_Schemauninstall

$(foreach d,$(test_unit_MySQLAccess_Schema_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_Schemauninstall))

test_unit_MySQLAccess_Schemauninstall : $(test_unit_MySQLAccess_Schemauninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Schema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_Schemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_Schema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_Schema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_SchemaCopy_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_SchemaCopy_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_SchemaCopy_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_SchemaCopy = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_SchemaCopy.make
cmt_final_setup_test_unit_MySQLAccess_SchemaCopy = $(bin)setup_test_unit_MySQLAccess_SchemaCopy.make
cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile = $(bin)test_unit_MySQLAccess_SchemaCopy.make

test_unit_MySQLAccess_SchemaCopy_extratags = -tag_add=target_test_unit_MySQLAccess_SchemaCopy

else

cmt_local_tagfile_test_unit_MySQLAccess_SchemaCopy = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_SchemaCopy = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile = $(bin)test_unit_MySQLAccess_SchemaCopy.make

endif

not_test_unit_MySQLAccess_SchemaCopycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_SchemaCopycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_SchemaCopydirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_SchemaCopy; then $(mkdir) -p $(bin)test_unit_MySQLAccess_SchemaCopy; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_SchemaCopy
else
test_unit_MySQLAccess_SchemaCopydirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_SchemaCopy_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) : $(test_unit_MySQLAccess_SchemaCopycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SchemaCopy.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SchemaCopy_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopy
else
$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) : $(test_unit_MySQLAccess_SchemaCopycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SchemaCopy) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SchemaCopy) ] || \
	  $(not_test_unit_MySQLAccess_SchemaCopycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SchemaCopy.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SchemaCopy_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopy; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) : $(test_unit_MySQLAccess_SchemaCopycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SchemaCopy.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SchemaCopy.in -tag=$(tags) $(test_unit_MySQLAccess_SchemaCopy_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopy
else
$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) : $(test_unit_MySQLAccess_SchemaCopycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_SchemaCopy.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SchemaCopy) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SchemaCopy) ] || \
	  $(not_test_unit_MySQLAccess_SchemaCopycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SchemaCopy.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SchemaCopy.in -tag=$(tags) $(test_unit_MySQLAccess_SchemaCopy_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopy; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SchemaCopy_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopy

test_unit_MySQLAccess_SchemaCopy :: test_unit_MySQLAccess_SchemaCopycompile test_unit_MySQLAccess_SchemaCopyinstall ;

ifdef cmt_test_unit_MySQLAccess_SchemaCopy_has_prototypes

test_unit_MySQLAccess_SchemaCopyprototype : $(test_unit_MySQLAccess_SchemaCopyprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) dirs test_unit_MySQLAccess_SchemaCopydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_SchemaCopycompile : test_unit_MySQLAccess_SchemaCopyprototype

endif

test_unit_MySQLAccess_SchemaCopycompile : $(test_unit_MySQLAccess_SchemaCopycompile_dependencies) $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) dirs test_unit_MySQLAccess_SchemaCopydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_SchemaCopyclean ;

test_unit_MySQLAccess_SchemaCopyclean :: $(test_unit_MySQLAccess_SchemaCopyclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) test_unit_MySQLAccess_SchemaCopyclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $(bin)test_unit_MySQLAccess_SchemaCopy_dependencies.make

install :: test_unit_MySQLAccess_SchemaCopyinstall ;

test_unit_MySQLAccess_SchemaCopyinstall :: test_unit_MySQLAccess_SchemaCopycompile $(test_unit_MySQLAccess_SchemaCopy_dependencies) $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_SchemaCopyuninstall

$(foreach d,$(test_unit_MySQLAccess_SchemaCopy_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_SchemaCopyuninstall))

test_unit_MySQLAccess_SchemaCopyuninstall : $(test_unit_MySQLAccess_SchemaCopyuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SchemaCopy_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_SchemaCopyuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_SchemaCopy"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_SchemaCopy done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_SegFault_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_SegFault_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_SegFault_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_SegFault = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_SegFault.make
cmt_final_setup_test_unit_MySQLAccess_SegFault = $(bin)setup_test_unit_MySQLAccess_SegFault.make
cmt_local_test_unit_MySQLAccess_SegFault_makefile = $(bin)test_unit_MySQLAccess_SegFault.make

test_unit_MySQLAccess_SegFault_extratags = -tag_add=target_test_unit_MySQLAccess_SegFault

else

cmt_local_tagfile_test_unit_MySQLAccess_SegFault = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_SegFault = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_SegFault_makefile = $(bin)test_unit_MySQLAccess_SegFault.make

endif

not_test_unit_MySQLAccess_SegFaultcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_SegFaultcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_SegFaultdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_SegFault; then $(mkdir) -p $(bin)test_unit_MySQLAccess_SegFault; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_SegFault
else
test_unit_MySQLAccess_SegFaultdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_SegFault_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) : $(test_unit_MySQLAccess_SegFaultcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SegFault.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SegFault_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFault
else
$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) : $(test_unit_MySQLAccess_SegFaultcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SegFault) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SegFault) ] || \
	  $(not_test_unit_MySQLAccess_SegFaultcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SegFault.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SegFault_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFault; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) : $(test_unit_MySQLAccess_SegFaultcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SegFault.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SegFault.in -tag=$(tags) $(test_unit_MySQLAccess_SegFault_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFault
else
$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) : $(test_unit_MySQLAccess_SegFaultcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_SegFault.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SegFault) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SegFault) ] || \
	  $(not_test_unit_MySQLAccess_SegFaultcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SegFault.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SegFault.in -tag=$(tags) $(test_unit_MySQLAccess_SegFault_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFault; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SegFault_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFault

test_unit_MySQLAccess_SegFault :: test_unit_MySQLAccess_SegFaultcompile test_unit_MySQLAccess_SegFaultinstall ;

ifdef cmt_test_unit_MySQLAccess_SegFault_has_prototypes

test_unit_MySQLAccess_SegFaultprototype : $(test_unit_MySQLAccess_SegFaultprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) dirs test_unit_MySQLAccess_SegFaultdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_SegFaultcompile : test_unit_MySQLAccess_SegFaultprototype

endif

test_unit_MySQLAccess_SegFaultcompile : $(test_unit_MySQLAccess_SegFaultcompile_dependencies) $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) dirs test_unit_MySQLAccess_SegFaultdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_SegFaultclean ;

test_unit_MySQLAccess_SegFaultclean :: $(test_unit_MySQLAccess_SegFaultclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) test_unit_MySQLAccess_SegFaultclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $(bin)test_unit_MySQLAccess_SegFault_dependencies.make

install :: test_unit_MySQLAccess_SegFaultinstall ;

test_unit_MySQLAccess_SegFaultinstall :: test_unit_MySQLAccess_SegFaultcompile $(test_unit_MySQLAccess_SegFault_dependencies) $(cmt_local_test_unit_MySQLAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_SegFaultuninstall

$(foreach d,$(test_unit_MySQLAccess_SegFault_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_SegFaultuninstall))

test_unit_MySQLAccess_SegFaultuninstall : $(test_unit_MySQLAccess_SegFaultuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SegFault_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SegFault_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_SegFaultuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_SegFault"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_SegFault done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_ShowCreateTableParser_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_ShowCreateTableParser_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_ShowCreateTableParser_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_ShowCreateTableParser = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_ShowCreateTableParser.make
cmt_final_setup_test_unit_MySQLAccess_ShowCreateTableParser = $(bin)setup_test_unit_MySQLAccess_ShowCreateTableParser.make
cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile = $(bin)test_unit_MySQLAccess_ShowCreateTableParser.make

test_unit_MySQLAccess_ShowCreateTableParser_extratags = -tag_add=target_test_unit_MySQLAccess_ShowCreateTableParser

else

cmt_local_tagfile_test_unit_MySQLAccess_ShowCreateTableParser = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_ShowCreateTableParser = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile = $(bin)test_unit_MySQLAccess_ShowCreateTableParser.make

endif

not_test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_ShowCreateTableParserdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_ShowCreateTableParser; then $(mkdir) -p $(bin)test_unit_MySQLAccess_ShowCreateTableParser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_ShowCreateTableParser
else
test_unit_MySQLAccess_ShowCreateTableParserdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_ShowCreateTableParser_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) : $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_ShowCreateTableParser.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_ShowCreateTableParser_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParser
else
$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) : $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_ShowCreateTableParser) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_ShowCreateTableParser) ] || \
	  $(not_test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_ShowCreateTableParser.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_ShowCreateTableParser_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) : $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_ShowCreateTableParser.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_ShowCreateTableParser.in -tag=$(tags) $(test_unit_MySQLAccess_ShowCreateTableParser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParser
else
$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) : $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_ShowCreateTableParser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_ShowCreateTableParser) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_ShowCreateTableParser) ] || \
	  $(not_test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_ShowCreateTableParser.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_ShowCreateTableParser.in -tag=$(tags) $(test_unit_MySQLAccess_ShowCreateTableParser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_ShowCreateTableParser_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParser

test_unit_MySQLAccess_ShowCreateTableParser :: test_unit_MySQLAccess_ShowCreateTableParsercompile test_unit_MySQLAccess_ShowCreateTableParserinstall ;

ifdef cmt_test_unit_MySQLAccess_ShowCreateTableParser_has_prototypes

test_unit_MySQLAccess_ShowCreateTableParserprototype : $(test_unit_MySQLAccess_ShowCreateTableParserprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) dirs test_unit_MySQLAccess_ShowCreateTableParserdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_ShowCreateTableParsercompile : test_unit_MySQLAccess_ShowCreateTableParserprototype

endif

test_unit_MySQLAccess_ShowCreateTableParsercompile : $(test_unit_MySQLAccess_ShowCreateTableParsercompile_dependencies) $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) dirs test_unit_MySQLAccess_ShowCreateTableParserdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_ShowCreateTableParserclean ;

test_unit_MySQLAccess_ShowCreateTableParserclean :: $(test_unit_MySQLAccess_ShowCreateTableParserclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) test_unit_MySQLAccess_ShowCreateTableParserclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $(bin)test_unit_MySQLAccess_ShowCreateTableParser_dependencies.make

install :: test_unit_MySQLAccess_ShowCreateTableParserinstall ;

test_unit_MySQLAccess_ShowCreateTableParserinstall :: test_unit_MySQLAccess_ShowCreateTableParsercompile $(test_unit_MySQLAccess_ShowCreateTableParser_dependencies) $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_ShowCreateTableParseruninstall

$(foreach d,$(test_unit_MySQLAccess_ShowCreateTableParser_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_ShowCreateTableParseruninstall))

test_unit_MySQLAccess_ShowCreateTableParseruninstall : $(test_unit_MySQLAccess_ShowCreateTableParseruninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_ShowCreateTableParser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_ShowCreateTableParseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_ShowCreateTableParser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_ShowCreateTableParser done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_SimpleQueries_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_SimpleQueries_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_SimpleQueries_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_SimpleQueries = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_SimpleQueries.make
cmt_final_setup_test_unit_MySQLAccess_SimpleQueries = $(bin)setup_test_unit_MySQLAccess_SimpleQueries.make
cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile = $(bin)test_unit_MySQLAccess_SimpleQueries.make

test_unit_MySQLAccess_SimpleQueries_extratags = -tag_add=target_test_unit_MySQLAccess_SimpleQueries

else

cmt_local_tagfile_test_unit_MySQLAccess_SimpleQueries = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_SimpleQueries = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile = $(bin)test_unit_MySQLAccess_SimpleQueries.make

endif

not_test_unit_MySQLAccess_SimpleQueriescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_SimpleQueriesdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_SimpleQueries; then $(mkdir) -p $(bin)test_unit_MySQLAccess_SimpleQueries; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_SimpleQueries
else
test_unit_MySQLAccess_SimpleQueriesdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_SimpleQueries_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) : $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueries
else
$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) : $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SimpleQueries) ] || \
	  $(not_test_unit_MySQLAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueries; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) : $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SimpleQueries.in -tag=$(tags) $(test_unit_MySQLAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueries
else
$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) : $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_SimpleQueries.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_SimpleQueries) ] || \
	  $(not_test_unit_MySQLAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_SimpleQueries.in -tag=$(tags) $(test_unit_MySQLAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueries; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_SimpleQueries_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueries

test_unit_MySQLAccess_SimpleQueries :: test_unit_MySQLAccess_SimpleQueriescompile test_unit_MySQLAccess_SimpleQueriesinstall ;

ifdef cmt_test_unit_MySQLAccess_SimpleQueries_has_prototypes

test_unit_MySQLAccess_SimpleQueriesprototype : $(test_unit_MySQLAccess_SimpleQueriesprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) dirs test_unit_MySQLAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_SimpleQueriescompile : test_unit_MySQLAccess_SimpleQueriesprototype

endif

test_unit_MySQLAccess_SimpleQueriescompile : $(test_unit_MySQLAccess_SimpleQueriescompile_dependencies) $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) dirs test_unit_MySQLAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_SimpleQueriesclean ;

test_unit_MySQLAccess_SimpleQueriesclean :: $(test_unit_MySQLAccess_SimpleQueriesclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) test_unit_MySQLAccess_SimpleQueriesclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $(bin)test_unit_MySQLAccess_SimpleQueries_dependencies.make

install :: test_unit_MySQLAccess_SimpleQueriesinstall ;

test_unit_MySQLAccess_SimpleQueriesinstall :: test_unit_MySQLAccess_SimpleQueriescompile $(test_unit_MySQLAccess_SimpleQueries_dependencies) $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_SimpleQueriesuninstall

$(foreach d,$(test_unit_MySQLAccess_SimpleQueries_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_SimpleQueriesuninstall))

test_unit_MySQLAccess_SimpleQueriesuninstall : $(test_unit_MySQLAccess_SimpleQueriesuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_SimpleQueries_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_SimpleQueriesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_SimpleQueries"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_SimpleQueries done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_TestAlias_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_TestAlias_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_TestAlias_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_TestAlias = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_TestAlias.make
cmt_final_setup_test_unit_MySQLAccess_TestAlias = $(bin)setup_test_unit_MySQLAccess_TestAlias.make
cmt_local_test_unit_MySQLAccess_TestAlias_makefile = $(bin)test_unit_MySQLAccess_TestAlias.make

test_unit_MySQLAccess_TestAlias_extratags = -tag_add=target_test_unit_MySQLAccess_TestAlias

else

cmt_local_tagfile_test_unit_MySQLAccess_TestAlias = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_TestAlias = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_TestAlias_makefile = $(bin)test_unit_MySQLAccess_TestAlias.make

endif

not_test_unit_MySQLAccess_TestAliascompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_TestAliascompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_TestAliasdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_TestAlias; then $(mkdir) -p $(bin)test_unit_MySQLAccess_TestAlias; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_TestAlias
else
test_unit_MySQLAccess_TestAliasdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_TestAlias_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) : $(test_unit_MySQLAccess_TestAliascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_TestAlias.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_TestAlias_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAlias
else
$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) : $(test_unit_MySQLAccess_TestAliascompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_TestAlias) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_TestAlias) ] || \
	  $(not_test_unit_MySQLAccess_TestAliascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_TestAlias.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_TestAlias_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAlias; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) : $(test_unit_MySQLAccess_TestAliascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_TestAlias.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_TestAlias.in -tag=$(tags) $(test_unit_MySQLAccess_TestAlias_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAlias
else
$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) : $(test_unit_MySQLAccess_TestAliascompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_TestAlias.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_TestAlias) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_TestAlias) ] || \
	  $(not_test_unit_MySQLAccess_TestAliascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_TestAlias.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_TestAlias.in -tag=$(tags) $(test_unit_MySQLAccess_TestAlias_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAlias; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_TestAlias_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAlias

test_unit_MySQLAccess_TestAlias :: test_unit_MySQLAccess_TestAliascompile test_unit_MySQLAccess_TestAliasinstall ;

ifdef cmt_test_unit_MySQLAccess_TestAlias_has_prototypes

test_unit_MySQLAccess_TestAliasprototype : $(test_unit_MySQLAccess_TestAliasprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) dirs test_unit_MySQLAccess_TestAliasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_TestAliascompile : test_unit_MySQLAccess_TestAliasprototype

endif

test_unit_MySQLAccess_TestAliascompile : $(test_unit_MySQLAccess_TestAliascompile_dependencies) $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) dirs test_unit_MySQLAccess_TestAliasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_TestAliasclean ;

test_unit_MySQLAccess_TestAliasclean :: $(test_unit_MySQLAccess_TestAliasclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) test_unit_MySQLAccess_TestAliasclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $(bin)test_unit_MySQLAccess_TestAlias_dependencies.make

install :: test_unit_MySQLAccess_TestAliasinstall ;

test_unit_MySQLAccess_TestAliasinstall :: test_unit_MySQLAccess_TestAliascompile $(test_unit_MySQLAccess_TestAlias_dependencies) $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_TestAliasuninstall

$(foreach d,$(test_unit_MySQLAccess_TestAlias_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_TestAliasuninstall))

test_unit_MySQLAccess_TestAliasuninstall : $(test_unit_MySQLAccess_TestAliasuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_TestAlias_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_TestAlias_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_TestAliasuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_TestAlias"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_TestAlias done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_Test40_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_Test40_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_Test40_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_Test40 = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_Test40.make
cmt_final_setup_test_unit_MySQLAccess_Test40 = $(bin)setup_test_unit_MySQLAccess_Test40.make
cmt_local_test_unit_MySQLAccess_Test40_makefile = $(bin)test_unit_MySQLAccess_Test40.make

test_unit_MySQLAccess_Test40_extratags = -tag_add=target_test_unit_MySQLAccess_Test40

else

cmt_local_tagfile_test_unit_MySQLAccess_Test40 = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_Test40 = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_Test40_makefile = $(bin)test_unit_MySQLAccess_Test40.make

endif

not_test_unit_MySQLAccess_Test40compile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_Test40compile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_Test40dirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_Test40; then $(mkdir) -p $(bin)test_unit_MySQLAccess_Test40; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_Test40
else
test_unit_MySQLAccess_Test40dirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_Test40_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Test40_makefile) : $(test_unit_MySQLAccess_Test40compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Test40.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Test40_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40
else
$(cmt_local_test_unit_MySQLAccess_Test40_makefile) : $(test_unit_MySQLAccess_Test40compile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Test40) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Test40) ] || \
	  $(not_test_unit_MySQLAccess_Test40compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Test40.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Test40_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Test40_makefile) : $(test_unit_MySQLAccess_Test40compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Test40.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Test40.in -tag=$(tags) $(test_unit_MySQLAccess_Test40_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40
else
$(cmt_local_test_unit_MySQLAccess_Test40_makefile) : $(test_unit_MySQLAccess_Test40compile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_Test40.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Test40) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Test40) ] || \
	  $(not_test_unit_MySQLAccess_Test40compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Test40.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Test40.in -tag=$(tags) $(test_unit_MySQLAccess_Test40_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Test40_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40

test_unit_MySQLAccess_Test40 :: test_unit_MySQLAccess_Test40compile test_unit_MySQLAccess_Test40install ;

ifdef cmt_test_unit_MySQLAccess_Test40_has_prototypes

test_unit_MySQLAccess_Test40prototype : $(test_unit_MySQLAccess_Test40prototype_dependencies) $(cmt_local_test_unit_MySQLAccess_Test40_makefile) dirs test_unit_MySQLAccess_Test40dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_Test40compile : test_unit_MySQLAccess_Test40prototype

endif

test_unit_MySQLAccess_Test40compile : $(test_unit_MySQLAccess_Test40compile_dependencies) $(cmt_local_test_unit_MySQLAccess_Test40_makefile) dirs test_unit_MySQLAccess_Test40dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_Test40clean ;

test_unit_MySQLAccess_Test40clean :: $(test_unit_MySQLAccess_Test40clean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Test40_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) test_unit_MySQLAccess_Test40clean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $(bin)test_unit_MySQLAccess_Test40_dependencies.make

install :: test_unit_MySQLAccess_Test40install ;

test_unit_MySQLAccess_Test40install :: test_unit_MySQLAccess_Test40compile $(test_unit_MySQLAccess_Test40_dependencies) $(cmt_local_test_unit_MySQLAccess_Test40_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_Test40uninstall

$(foreach d,$(test_unit_MySQLAccess_Test40_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_Test40uninstall))

test_unit_MySQLAccess_Test40uninstall : $(test_unit_MySQLAccess_Test40uninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Test40_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Test40_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_Test40uninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_Test40"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_Test40 done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_Connection_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_Connection_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_Connection_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_Connection = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_Connection.make
cmt_final_setup_test_unit_MySQLAccess_Connection = $(bin)setup_test_unit_MySQLAccess_Connection.make
cmt_local_test_unit_MySQLAccess_Connection_makefile = $(bin)test_unit_MySQLAccess_Connection.make

test_unit_MySQLAccess_Connection_extratags = -tag_add=target_test_unit_MySQLAccess_Connection

else

cmt_local_tagfile_test_unit_MySQLAccess_Connection = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_Connection = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_Connection_makefile = $(bin)test_unit_MySQLAccess_Connection.make

endif

not_test_unit_MySQLAccess_Connectioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_Connectioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_Connectiondirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_Connection; then $(mkdir) -p $(bin)test_unit_MySQLAccess_Connection; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_Connection
else
test_unit_MySQLAccess_Connectiondirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_Connection_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Connection_makefile) : $(test_unit_MySQLAccess_Connectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Connection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Connection_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connection
else
$(cmt_local_test_unit_MySQLAccess_Connection_makefile) : $(test_unit_MySQLAccess_Connectioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Connection) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Connection) ] || \
	  $(not_test_unit_MySQLAccess_Connectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Connection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Connection_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connection; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_Connection_makefile) : $(test_unit_MySQLAccess_Connectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_Connection.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Connection.in -tag=$(tags) $(test_unit_MySQLAccess_Connection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connection
else
$(cmt_local_test_unit_MySQLAccess_Connection_makefile) : $(test_unit_MySQLAccess_Connectioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_Connection.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_Connection) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_Connection) ] || \
	  $(not_test_unit_MySQLAccess_Connectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_Connection.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_Connection.in -tag=$(tags) $(test_unit_MySQLAccess_Connection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connection; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_Connection_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connection

test_unit_MySQLAccess_Connection :: test_unit_MySQLAccess_Connectioncompile test_unit_MySQLAccess_Connectioninstall ;

ifdef cmt_test_unit_MySQLAccess_Connection_has_prototypes

test_unit_MySQLAccess_Connectionprototype : $(test_unit_MySQLAccess_Connectionprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_Connection_makefile) dirs test_unit_MySQLAccess_Connectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_Connectioncompile : test_unit_MySQLAccess_Connectionprototype

endif

test_unit_MySQLAccess_Connectioncompile : $(test_unit_MySQLAccess_Connectioncompile_dependencies) $(cmt_local_test_unit_MySQLAccess_Connection_makefile) dirs test_unit_MySQLAccess_Connectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_Connectionclean ;

test_unit_MySQLAccess_Connectionclean :: $(test_unit_MySQLAccess_Connectionclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) test_unit_MySQLAccess_Connectionclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $(bin)test_unit_MySQLAccess_Connection_dependencies.make

install :: test_unit_MySQLAccess_Connectioninstall ;

test_unit_MySQLAccess_Connectioninstall :: test_unit_MySQLAccess_Connectioncompile $(test_unit_MySQLAccess_Connection_dependencies) $(cmt_local_test_unit_MySQLAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_Connectionuninstall

$(foreach d,$(test_unit_MySQLAccess_Connection_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_Connectionuninstall))

test_unit_MySQLAccess_Connectionuninstall : $(test_unit_MySQLAccess_Connectionuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_Connection_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_Connectionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_Connection"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_Connection done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_MySQLAccess_NIPP_has_no_target_tag = 1
cmt_test_unit_MySQLAccess_NIPP_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_MySQLAccess_NIPP_has_target_tag

cmt_local_tagfile_test_unit_MySQLAccess_NIPP = $(bin)$(MySQLAccess_tag)_test_unit_MySQLAccess_NIPP.make
cmt_final_setup_test_unit_MySQLAccess_NIPP = $(bin)setup_test_unit_MySQLAccess_NIPP.make
cmt_local_test_unit_MySQLAccess_NIPP_makefile = $(bin)test_unit_MySQLAccess_NIPP.make

test_unit_MySQLAccess_NIPP_extratags = -tag_add=target_test_unit_MySQLAccess_NIPP

else

cmt_local_tagfile_test_unit_MySQLAccess_NIPP = $(bin)$(MySQLAccess_tag).make
cmt_final_setup_test_unit_MySQLAccess_NIPP = $(bin)setup.make
cmt_local_test_unit_MySQLAccess_NIPP_makefile = $(bin)test_unit_MySQLAccess_NIPP.make

endif

not_test_unit_MySQLAccess_NIPPcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_MySQLAccess_NIPPcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_MySQLAccess_NIPPdirs :
	@if test ! -d $(bin)test_unit_MySQLAccess_NIPP; then $(mkdir) -p $(bin)test_unit_MySQLAccess_NIPP; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_MySQLAccess_NIPP
else
test_unit_MySQLAccess_NIPPdirs : ;
endif

ifdef cmt_test_unit_MySQLAccess_NIPP_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) : $(test_unit_MySQLAccess_NIPPcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_NIPP.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_NIPP_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPP
else
$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) : $(test_unit_MySQLAccess_NIPPcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_NIPP) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_NIPP) ] || \
	  $(not_test_unit_MySQLAccess_NIPPcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_NIPP.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_NIPP_extratags) build constituent_config -out=$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPP; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) : $(test_unit_MySQLAccess_NIPPcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_MySQLAccess_NIPP.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_NIPP.in -tag=$(tags) $(test_unit_MySQLAccess_NIPP_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPP
else
$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) : $(test_unit_MySQLAccess_NIPPcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_MySQLAccess_NIPP.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_MySQLAccess_NIPP) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_MySQLAccess_NIPP) ] || \
	  $(not_test_unit_MySQLAccess_NIPPcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_MySQLAccess_NIPP.make"; \
	  $(cmtexe) -f=$(bin)test_unit_MySQLAccess_NIPP.in -tag=$(tags) $(test_unit_MySQLAccess_NIPP_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPP; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_MySQLAccess_NIPP_extratags) build constituent_makefile -out=$(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPP

test_unit_MySQLAccess_NIPP :: test_unit_MySQLAccess_NIPPcompile test_unit_MySQLAccess_NIPPinstall ;

ifdef cmt_test_unit_MySQLAccess_NIPP_has_prototypes

test_unit_MySQLAccess_NIPPprototype : $(test_unit_MySQLAccess_NIPPprototype_dependencies) $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) dirs test_unit_MySQLAccess_NIPPdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_MySQLAccess_NIPPcompile : test_unit_MySQLAccess_NIPPprototype

endif

test_unit_MySQLAccess_NIPPcompile : $(test_unit_MySQLAccess_NIPPcompile_dependencies) $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) dirs test_unit_MySQLAccess_NIPPdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_MySQLAccess_NIPPclean ;

test_unit_MySQLAccess_NIPPclean :: $(test_unit_MySQLAccess_NIPPclean_dependencies) ##$(cmt_local_test_unit_MySQLAccess_NIPP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) test_unit_MySQLAccess_NIPPclean

##	  /bin/rm -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $(bin)test_unit_MySQLAccess_NIPP_dependencies.make

install :: test_unit_MySQLAccess_NIPPinstall ;

test_unit_MySQLAccess_NIPPinstall :: test_unit_MySQLAccess_NIPPcompile $(test_unit_MySQLAccess_NIPP_dependencies) $(cmt_local_test_unit_MySQLAccess_NIPP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_MySQLAccess_NIPPuninstall

$(foreach d,$(test_unit_MySQLAccess_NIPP_dependencies),$(eval $(d)uninstall_dependencies += test_unit_MySQLAccess_NIPPuninstall))

test_unit_MySQLAccess_NIPPuninstall : $(test_unit_MySQLAccess_NIPPuninstall_dependencies) ##$(cmt_local_test_unit_MySQLAccess_NIPP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_MySQLAccess_NIPP_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_MySQLAccess_NIPPuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_MySQLAccess_NIPP"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_MySQLAccess_NIPP done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(MySQLAccess_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(MySQLAccess_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(MySQLAccess_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(MySQLAccess_tag).make
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

cmt_local_tagfile_make = $(bin)$(MySQLAccess_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(MySQLAccess_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(MySQLAccess_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(MySQLAccess_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(MySQLAccess_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(MySQLAccess_tag).make
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

cmt_local_tagfile_examples = $(bin)$(MySQLAccess_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(MySQLAccess_tag).make
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
