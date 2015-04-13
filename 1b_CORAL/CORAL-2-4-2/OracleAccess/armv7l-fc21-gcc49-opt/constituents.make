
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

OracleAccess_tag = $(tag)

#cmt_local_tagfile = $(OracleAccess_tag).make
cmt_local_tagfile = $(bin)$(OracleAccess_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)OracleAccesssetup.make
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

cmt_lcg_OracleAccess_has_no_target_tag = 1
cmt_lcg_OracleAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_OracleAccess_has_target_tag

cmt_local_tagfile_lcg_OracleAccess = $(bin)$(OracleAccess_tag)_lcg_OracleAccess.make
cmt_final_setup_lcg_OracleAccess = $(bin)setup_lcg_OracleAccess.make
cmt_local_lcg_OracleAccess_makefile = $(bin)lcg_OracleAccess.make

lcg_OracleAccess_extratags = -tag_add=target_lcg_OracleAccess

else

cmt_local_tagfile_lcg_OracleAccess = $(bin)$(OracleAccess_tag).make
cmt_final_setup_lcg_OracleAccess = $(bin)setup.make
cmt_local_lcg_OracleAccess_makefile = $(bin)lcg_OracleAccess.make

endif

not_lcg_OracleAccesscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_OracleAccesscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_OracleAccessdirs :
	@if test ! -d $(bin)lcg_OracleAccess; then $(mkdir) -p $(bin)lcg_OracleAccess; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_OracleAccess
else
lcg_OracleAccessdirs : ;
endif

ifdef cmt_lcg_OracleAccess_has_target_tag

ifndef QUICK
$(cmt_local_lcg_OracleAccess_makefile) : $(lcg_OracleAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_OracleAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_OracleAccess_extratags) build constituent_config -out=$(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccess
else
$(cmt_local_lcg_OracleAccess_makefile) : $(lcg_OracleAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_OracleAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_OracleAccess) ] || \
	  $(not_lcg_OracleAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_OracleAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_OracleAccess_extratags) build constituent_config -out=$(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccess; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_OracleAccess_makefile) : $(lcg_OracleAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_OracleAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_OracleAccess.in -tag=$(tags) $(lcg_OracleAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccess
else
$(cmt_local_lcg_OracleAccess_makefile) : $(lcg_OracleAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_OracleAccess.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_OracleAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_OracleAccess) ] || \
	  $(not_lcg_OracleAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_OracleAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_OracleAccess.in -tag=$(tags) $(lcg_OracleAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccess; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_OracleAccess_extratags) build constituent_makefile -out=$(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccess

lcg_OracleAccess :: lcg_OracleAccesscompile lcg_OracleAccessinstall ;

ifdef cmt_lcg_OracleAccess_has_prototypes

lcg_OracleAccessprototype : $(lcg_OracleAccessprototype_dependencies) $(cmt_local_lcg_OracleAccess_makefile) dirs lcg_OracleAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_OracleAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_OracleAccesscompile : lcg_OracleAccessprototype

endif

lcg_OracleAccesscompile : $(lcg_OracleAccesscompile_dependencies) $(cmt_local_lcg_OracleAccess_makefile) dirs lcg_OracleAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_OracleAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_OracleAccessclean ;

lcg_OracleAccessclean :: $(lcg_OracleAccessclean_dependencies) ##$(cmt_local_lcg_OracleAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_OracleAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) lcg_OracleAccessclean

##	  /bin/rm -f $(cmt_local_lcg_OracleAccess_makefile) $(bin)lcg_OracleAccess_dependencies.make

install :: lcg_OracleAccessinstall ;

lcg_OracleAccessinstall :: lcg_OracleAccesscompile $(lcg_OracleAccess_dependencies) $(cmt_local_lcg_OracleAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_OracleAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_OracleAccessuninstall

$(foreach d,$(lcg_OracleAccess_dependencies),$(eval $(d)uninstall_dependencies += lcg_OracleAccessuninstall))

lcg_OracleAccessuninstall : $(lcg_OracleAccessuninstall_dependencies) ##$(cmt_local_lcg_OracleAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_OracleAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_OracleAccess_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_OracleAccessuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_OracleAccess"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_OracleAccess done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_BulkInserts_has_no_target_tag = 1
cmt_test_unit_OracleAccess_BulkInserts_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_BulkInserts_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_BulkInserts = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_BulkInserts.make
cmt_final_setup_test_unit_OracleAccess_BulkInserts = $(bin)setup_test_unit_OracleAccess_BulkInserts.make
cmt_local_test_unit_OracleAccess_BulkInserts_makefile = $(bin)test_unit_OracleAccess_BulkInserts.make

test_unit_OracleAccess_BulkInserts_extratags = -tag_add=target_test_unit_OracleAccess_BulkInserts

else

cmt_local_tagfile_test_unit_OracleAccess_BulkInserts = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_BulkInserts = $(bin)setup.make
cmt_local_test_unit_OracleAccess_BulkInserts_makefile = $(bin)test_unit_OracleAccess_BulkInserts.make

endif

not_test_unit_OracleAccess_BulkInsertscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_BulkInsertscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_BulkInsertsdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_BulkInserts; then $(mkdir) -p $(bin)test_unit_OracleAccess_BulkInserts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_BulkInserts
else
test_unit_OracleAccess_BulkInsertsdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_BulkInserts_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) : $(test_unit_OracleAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInserts
else
$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) : $(test_unit_OracleAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_BulkInserts) ] || \
	  $(not_test_unit_OracleAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_BulkInserts.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_BulkInserts_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInserts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) : $(test_unit_OracleAccess_BulkInsertscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_BulkInserts.in -tag=$(tags) $(test_unit_OracleAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInserts
else
$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) : $(test_unit_OracleAccess_BulkInsertscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_BulkInserts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_BulkInserts) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_BulkInserts) ] || \
	  $(not_test_unit_OracleAccess_BulkInsertscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_BulkInserts.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_BulkInserts.in -tag=$(tags) $(test_unit_OracleAccess_BulkInserts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInserts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_BulkInserts_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInserts

test_unit_OracleAccess_BulkInserts :: test_unit_OracleAccess_BulkInsertscompile test_unit_OracleAccess_BulkInsertsinstall ;

ifdef cmt_test_unit_OracleAccess_BulkInserts_has_prototypes

test_unit_OracleAccess_BulkInsertsprototype : $(test_unit_OracleAccess_BulkInsertsprototype_dependencies) $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) dirs test_unit_OracleAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_BulkInsertscompile : test_unit_OracleAccess_BulkInsertsprototype

endif

test_unit_OracleAccess_BulkInsertscompile : $(test_unit_OracleAccess_BulkInsertscompile_dependencies) $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) dirs test_unit_OracleAccess_BulkInsertsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_BulkInsertsclean ;

test_unit_OracleAccess_BulkInsertsclean :: $(test_unit_OracleAccess_BulkInsertsclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) test_unit_OracleAccess_BulkInsertsclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $(bin)test_unit_OracleAccess_BulkInserts_dependencies.make

install :: test_unit_OracleAccess_BulkInsertsinstall ;

test_unit_OracleAccess_BulkInsertsinstall :: test_unit_OracleAccess_BulkInsertscompile $(test_unit_OracleAccess_BulkInserts_dependencies) $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_BulkInsertsuninstall

$(foreach d,$(test_unit_OracleAccess_BulkInserts_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_BulkInsertsuninstall))

test_unit_OracleAccess_BulkInsertsuninstall : $(test_unit_OracleAccess_BulkInsertsuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_BulkInserts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_BulkInserts_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_BulkInsertsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_BulkInserts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_BulkInserts done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_Connection_has_no_target_tag = 1
cmt_test_unit_OracleAccess_Connection_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_Connection_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_Connection = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_Connection.make
cmt_final_setup_test_unit_OracleAccess_Connection = $(bin)setup_test_unit_OracleAccess_Connection.make
cmt_local_test_unit_OracleAccess_Connection_makefile = $(bin)test_unit_OracleAccess_Connection.make

test_unit_OracleAccess_Connection_extratags = -tag_add=target_test_unit_OracleAccess_Connection

else

cmt_local_tagfile_test_unit_OracleAccess_Connection = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_Connection = $(bin)setup.make
cmt_local_test_unit_OracleAccess_Connection_makefile = $(bin)test_unit_OracleAccess_Connection.make

endif

not_test_unit_OracleAccess_Connectioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_Connectioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_Connectiondirs :
	@if test ! -d $(bin)test_unit_OracleAccess_Connection; then $(mkdir) -p $(bin)test_unit_OracleAccess_Connection; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_Connection
else
test_unit_OracleAccess_Connectiondirs : ;
endif

ifdef cmt_test_unit_OracleAccess_Connection_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Connection_makefile) : $(test_unit_OracleAccess_Connectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Connection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Connection_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connection
else
$(cmt_local_test_unit_OracleAccess_Connection_makefile) : $(test_unit_OracleAccess_Connectioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Connection) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Connection) ] || \
	  $(not_test_unit_OracleAccess_Connectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Connection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Connection_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connection; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Connection_makefile) : $(test_unit_OracleAccess_Connectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Connection.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Connection.in -tag=$(tags) $(test_unit_OracleAccess_Connection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connection
else
$(cmt_local_test_unit_OracleAccess_Connection_makefile) : $(test_unit_OracleAccess_Connectioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_Connection.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Connection) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Connection) ] || \
	  $(not_test_unit_OracleAccess_Connectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Connection.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Connection.in -tag=$(tags) $(test_unit_OracleAccess_Connection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connection; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Connection_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connection

test_unit_OracleAccess_Connection :: test_unit_OracleAccess_Connectioncompile test_unit_OracleAccess_Connectioninstall ;

ifdef cmt_test_unit_OracleAccess_Connection_has_prototypes

test_unit_OracleAccess_Connectionprototype : $(test_unit_OracleAccess_Connectionprototype_dependencies) $(cmt_local_test_unit_OracleAccess_Connection_makefile) dirs test_unit_OracleAccess_Connectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_Connectioncompile : test_unit_OracleAccess_Connectionprototype

endif

test_unit_OracleAccess_Connectioncompile : $(test_unit_OracleAccess_Connectioncompile_dependencies) $(cmt_local_test_unit_OracleAccess_Connection_makefile) dirs test_unit_OracleAccess_Connectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_Connectionclean ;

test_unit_OracleAccess_Connectionclean :: $(test_unit_OracleAccess_Connectionclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) test_unit_OracleAccess_Connectionclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $(bin)test_unit_OracleAccess_Connection_dependencies.make

install :: test_unit_OracleAccess_Connectioninstall ;

test_unit_OracleAccess_Connectioninstall :: test_unit_OracleAccess_Connectioncompile $(test_unit_OracleAccess_Connection_dependencies) $(cmt_local_test_unit_OracleAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_Connectionuninstall

$(foreach d,$(test_unit_OracleAccess_Connection_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_Connectionuninstall))

test_unit_OracleAccess_Connectionuninstall : $(test_unit_OracleAccess_Connectionuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_Connection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Connection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Connection_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_Connectionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_Connection"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_Connection done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_DataEditor_has_no_target_tag = 1
cmt_test_unit_OracleAccess_DataEditor_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_DataEditor_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_DataEditor = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_DataEditor.make
cmt_final_setup_test_unit_OracleAccess_DataEditor = $(bin)setup_test_unit_OracleAccess_DataEditor.make
cmt_local_test_unit_OracleAccess_DataEditor_makefile = $(bin)test_unit_OracleAccess_DataEditor.make

test_unit_OracleAccess_DataEditor_extratags = -tag_add=target_test_unit_OracleAccess_DataEditor

else

cmt_local_tagfile_test_unit_OracleAccess_DataEditor = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_DataEditor = $(bin)setup.make
cmt_local_test_unit_OracleAccess_DataEditor_makefile = $(bin)test_unit_OracleAccess_DataEditor.make

endif

not_test_unit_OracleAccess_DataEditorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_DataEditorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_DataEditordirs :
	@if test ! -d $(bin)test_unit_OracleAccess_DataEditor; then $(mkdir) -p $(bin)test_unit_OracleAccess_DataEditor; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_DataEditor
else
test_unit_OracleAccess_DataEditordirs : ;
endif

ifdef cmt_test_unit_OracleAccess_DataEditor_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) : $(test_unit_OracleAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditor
else
$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) : $(test_unit_OracleAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DataEditor) ] || \
	  $(not_test_unit_OracleAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DataEditor.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataEditor_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditor; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) : $(test_unit_OracleAccess_DataEditorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DataEditor.in -tag=$(tags) $(test_unit_OracleAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditor
else
$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) : $(test_unit_OracleAccess_DataEditorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_DataEditor.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DataEditor) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DataEditor) ] || \
	  $(not_test_unit_OracleAccess_DataEditorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DataEditor.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DataEditor.in -tag=$(tags) $(test_unit_OracleAccess_DataEditor_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditor; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataEditor_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditor

test_unit_OracleAccess_DataEditor :: test_unit_OracleAccess_DataEditorcompile test_unit_OracleAccess_DataEditorinstall ;

ifdef cmt_test_unit_OracleAccess_DataEditor_has_prototypes

test_unit_OracleAccess_DataEditorprototype : $(test_unit_OracleAccess_DataEditorprototype_dependencies) $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) dirs test_unit_OracleAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_DataEditorcompile : test_unit_OracleAccess_DataEditorprototype

endif

test_unit_OracleAccess_DataEditorcompile : $(test_unit_OracleAccess_DataEditorcompile_dependencies) $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) dirs test_unit_OracleAccess_DataEditordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_DataEditorclean ;

test_unit_OracleAccess_DataEditorclean :: $(test_unit_OracleAccess_DataEditorclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) test_unit_OracleAccess_DataEditorclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $(bin)test_unit_OracleAccess_DataEditor_dependencies.make

install :: test_unit_OracleAccess_DataEditorinstall ;

test_unit_OracleAccess_DataEditorinstall :: test_unit_OracleAccess_DataEditorcompile $(test_unit_OracleAccess_DataEditor_dependencies) $(cmt_local_test_unit_OracleAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_DataEditoruninstall

$(foreach d,$(test_unit_OracleAccess_DataEditor_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_DataEditoruninstall))

test_unit_OracleAccess_DataEditoruninstall : $(test_unit_OracleAccess_DataEditoruninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_DataEditor_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataEditor_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_DataEditoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_DataEditor"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_DataEditor done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_DataDictionary_has_no_target_tag = 1
cmt_test_unit_OracleAccess_DataDictionary_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_DataDictionary_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_DataDictionary = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_DataDictionary.make
cmt_final_setup_test_unit_OracleAccess_DataDictionary = $(bin)setup_test_unit_OracleAccess_DataDictionary.make
cmt_local_test_unit_OracleAccess_DataDictionary_makefile = $(bin)test_unit_OracleAccess_DataDictionary.make

test_unit_OracleAccess_DataDictionary_extratags = -tag_add=target_test_unit_OracleAccess_DataDictionary

else

cmt_local_tagfile_test_unit_OracleAccess_DataDictionary = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_DataDictionary = $(bin)setup.make
cmt_local_test_unit_OracleAccess_DataDictionary_makefile = $(bin)test_unit_OracleAccess_DataDictionary.make

endif

not_test_unit_OracleAccess_DataDictionarycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_DataDictionarycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_DataDictionarydirs :
	@if test ! -d $(bin)test_unit_OracleAccess_DataDictionary; then $(mkdir) -p $(bin)test_unit_OracleAccess_DataDictionary; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_DataDictionary
else
test_unit_OracleAccess_DataDictionarydirs : ;
endif

ifdef cmt_test_unit_OracleAccess_DataDictionary_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) : $(test_unit_OracleAccess_DataDictionarycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DataDictionary.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataDictionary_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionary
else
$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) : $(test_unit_OracleAccess_DataDictionarycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DataDictionary) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DataDictionary) ] || \
	  $(not_test_unit_OracleAccess_DataDictionarycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DataDictionary.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataDictionary_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionary; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) : $(test_unit_OracleAccess_DataDictionarycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DataDictionary.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DataDictionary.in -tag=$(tags) $(test_unit_OracleAccess_DataDictionary_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionary
else
$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) : $(test_unit_OracleAccess_DataDictionarycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_DataDictionary.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DataDictionary) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DataDictionary) ] || \
	  $(not_test_unit_OracleAccess_DataDictionarycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DataDictionary.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DataDictionary.in -tag=$(tags) $(test_unit_OracleAccess_DataDictionary_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionary; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DataDictionary_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionary

test_unit_OracleAccess_DataDictionary :: test_unit_OracleAccess_DataDictionarycompile test_unit_OracleAccess_DataDictionaryinstall ;

ifdef cmt_test_unit_OracleAccess_DataDictionary_has_prototypes

test_unit_OracleAccess_DataDictionaryprototype : $(test_unit_OracleAccess_DataDictionaryprototype_dependencies) $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) dirs test_unit_OracleAccess_DataDictionarydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_DataDictionarycompile : test_unit_OracleAccess_DataDictionaryprototype

endif

test_unit_OracleAccess_DataDictionarycompile : $(test_unit_OracleAccess_DataDictionarycompile_dependencies) $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) dirs test_unit_OracleAccess_DataDictionarydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_DataDictionaryclean ;

test_unit_OracleAccess_DataDictionaryclean :: $(test_unit_OracleAccess_DataDictionaryclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) test_unit_OracleAccess_DataDictionaryclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $(bin)test_unit_OracleAccess_DataDictionary_dependencies.make

install :: test_unit_OracleAccess_DataDictionaryinstall ;

test_unit_OracleAccess_DataDictionaryinstall :: test_unit_OracleAccess_DataDictionarycompile $(test_unit_OracleAccess_DataDictionary_dependencies) $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_DataDictionaryuninstall

$(foreach d,$(test_unit_OracleAccess_DataDictionary_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_DataDictionaryuninstall))

test_unit_OracleAccess_DataDictionaryuninstall : $(test_unit_OracleAccess_DataDictionaryuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_DataDictionary_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DataDictionary_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_DataDictionaryuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_DataDictionary"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_DataDictionary done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_DateAndTime_has_no_target_tag = 1
cmt_test_unit_OracleAccess_DateAndTime_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_DateAndTime_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_DateAndTime = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_DateAndTime.make
cmt_final_setup_test_unit_OracleAccess_DateAndTime = $(bin)setup_test_unit_OracleAccess_DateAndTime.make
cmt_local_test_unit_OracleAccess_DateAndTime_makefile = $(bin)test_unit_OracleAccess_DateAndTime.make

test_unit_OracleAccess_DateAndTime_extratags = -tag_add=target_test_unit_OracleAccess_DateAndTime

else

cmt_local_tagfile_test_unit_OracleAccess_DateAndTime = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_DateAndTime = $(bin)setup.make
cmt_local_test_unit_OracleAccess_DateAndTime_makefile = $(bin)test_unit_OracleAccess_DateAndTime.make

endif

not_test_unit_OracleAccess_DateAndTimecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_DateAndTimecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_DateAndTimedirs :
	@if test ! -d $(bin)test_unit_OracleAccess_DateAndTime; then $(mkdir) -p $(bin)test_unit_OracleAccess_DateAndTime; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_DateAndTime
else
test_unit_OracleAccess_DateAndTimedirs : ;
endif

ifdef cmt_test_unit_OracleAccess_DateAndTime_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) : $(test_unit_OracleAccess_DateAndTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DateAndTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DateAndTime_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTime
else
$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) : $(test_unit_OracleAccess_DateAndTimecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DateAndTime) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DateAndTime) ] || \
	  $(not_test_unit_OracleAccess_DateAndTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DateAndTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DateAndTime_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTime; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) : $(test_unit_OracleAccess_DateAndTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_DateAndTime.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DateAndTime.in -tag=$(tags) $(test_unit_OracleAccess_DateAndTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTime
else
$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) : $(test_unit_OracleAccess_DateAndTimecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_DateAndTime.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_DateAndTime) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_DateAndTime) ] || \
	  $(not_test_unit_OracleAccess_DateAndTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_DateAndTime.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_DateAndTime.in -tag=$(tags) $(test_unit_OracleAccess_DateAndTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTime; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_DateAndTime_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTime

test_unit_OracleAccess_DateAndTime :: test_unit_OracleAccess_DateAndTimecompile test_unit_OracleAccess_DateAndTimeinstall ;

ifdef cmt_test_unit_OracleAccess_DateAndTime_has_prototypes

test_unit_OracleAccess_DateAndTimeprototype : $(test_unit_OracleAccess_DateAndTimeprototype_dependencies) $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) dirs test_unit_OracleAccess_DateAndTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_DateAndTimecompile : test_unit_OracleAccess_DateAndTimeprototype

endif

test_unit_OracleAccess_DateAndTimecompile : $(test_unit_OracleAccess_DateAndTimecompile_dependencies) $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) dirs test_unit_OracleAccess_DateAndTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_DateAndTimeclean ;

test_unit_OracleAccess_DateAndTimeclean :: $(test_unit_OracleAccess_DateAndTimeclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) test_unit_OracleAccess_DateAndTimeclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $(bin)test_unit_OracleAccess_DateAndTime_dependencies.make

install :: test_unit_OracleAccess_DateAndTimeinstall ;

test_unit_OracleAccess_DateAndTimeinstall :: test_unit_OracleAccess_DateAndTimecompile $(test_unit_OracleAccess_DateAndTime_dependencies) $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_DateAndTimeuninstall

$(foreach d,$(test_unit_OracleAccess_DateAndTime_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_DateAndTimeuninstall))

test_unit_OracleAccess_DateAndTimeuninstall : $(test_unit_OracleAccess_DateAndTimeuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_DateAndTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_DateAndTime_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_DateAndTimeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_DateAndTime"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_DateAndTime done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_Dual_has_no_target_tag = 1
cmt_test_unit_OracleAccess_Dual_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_Dual_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_Dual = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_Dual.make
cmt_final_setup_test_unit_OracleAccess_Dual = $(bin)setup_test_unit_OracleAccess_Dual.make
cmt_local_test_unit_OracleAccess_Dual_makefile = $(bin)test_unit_OracleAccess_Dual.make

test_unit_OracleAccess_Dual_extratags = -tag_add=target_test_unit_OracleAccess_Dual

else

cmt_local_tagfile_test_unit_OracleAccess_Dual = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_Dual = $(bin)setup.make
cmt_local_test_unit_OracleAccess_Dual_makefile = $(bin)test_unit_OracleAccess_Dual.make

endif

not_test_unit_OracleAccess_Dualcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_Dualcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_Dualdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_Dual; then $(mkdir) -p $(bin)test_unit_OracleAccess_Dual; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_Dual
else
test_unit_OracleAccess_Dualdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_Dual_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Dual_makefile) : $(test_unit_OracleAccess_Dualcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Dual.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Dual_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dual
else
$(cmt_local_test_unit_OracleAccess_Dual_makefile) : $(test_unit_OracleAccess_Dualcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Dual) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Dual) ] || \
	  $(not_test_unit_OracleAccess_Dualcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Dual.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Dual_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dual; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Dual_makefile) : $(test_unit_OracleAccess_Dualcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Dual.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Dual.in -tag=$(tags) $(test_unit_OracleAccess_Dual_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dual
else
$(cmt_local_test_unit_OracleAccess_Dual_makefile) : $(test_unit_OracleAccess_Dualcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_Dual.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Dual) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Dual) ] || \
	  $(not_test_unit_OracleAccess_Dualcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Dual.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Dual.in -tag=$(tags) $(test_unit_OracleAccess_Dual_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dual; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Dual_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dual

test_unit_OracleAccess_Dual :: test_unit_OracleAccess_Dualcompile test_unit_OracleAccess_Dualinstall ;

ifdef cmt_test_unit_OracleAccess_Dual_has_prototypes

test_unit_OracleAccess_Dualprototype : $(test_unit_OracleAccess_Dualprototype_dependencies) $(cmt_local_test_unit_OracleAccess_Dual_makefile) dirs test_unit_OracleAccess_Dualdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Dual_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_Dualcompile : test_unit_OracleAccess_Dualprototype

endif

test_unit_OracleAccess_Dualcompile : $(test_unit_OracleAccess_Dualcompile_dependencies) $(cmt_local_test_unit_OracleAccess_Dual_makefile) dirs test_unit_OracleAccess_Dualdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Dual_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_Dualclean ;

test_unit_OracleAccess_Dualclean :: $(test_unit_OracleAccess_Dualclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_Dual_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Dual_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) test_unit_OracleAccess_Dualclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $(bin)test_unit_OracleAccess_Dual_dependencies.make

install :: test_unit_OracleAccess_Dualinstall ;

test_unit_OracleAccess_Dualinstall :: test_unit_OracleAccess_Dualcompile $(test_unit_OracleAccess_Dual_dependencies) $(cmt_local_test_unit_OracleAccess_Dual_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Dual_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_Dualuninstall

$(foreach d,$(test_unit_OracleAccess_Dual_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_Dualuninstall))

test_unit_OracleAccess_Dualuninstall : $(test_unit_OracleAccess_Dualuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_Dual_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Dual_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Dual_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_Dualuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_Dual"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_Dual done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_GroupBy_has_no_target_tag = 1
cmt_test_unit_OracleAccess_GroupBy_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_GroupBy_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_GroupBy = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_GroupBy.make
cmt_final_setup_test_unit_OracleAccess_GroupBy = $(bin)setup_test_unit_OracleAccess_GroupBy.make
cmt_local_test_unit_OracleAccess_GroupBy_makefile = $(bin)test_unit_OracleAccess_GroupBy.make

test_unit_OracleAccess_GroupBy_extratags = -tag_add=target_test_unit_OracleAccess_GroupBy

else

cmt_local_tagfile_test_unit_OracleAccess_GroupBy = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_GroupBy = $(bin)setup.make
cmt_local_test_unit_OracleAccess_GroupBy_makefile = $(bin)test_unit_OracleAccess_GroupBy.make

endif

not_test_unit_OracleAccess_GroupBycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_GroupBycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_GroupBydirs :
	@if test ! -d $(bin)test_unit_OracleAccess_GroupBy; then $(mkdir) -p $(bin)test_unit_OracleAccess_GroupBy; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_GroupBy
else
test_unit_OracleAccess_GroupBydirs : ;
endif

ifdef cmt_test_unit_OracleAccess_GroupBy_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) : $(test_unit_OracleAccess_GroupBycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_GroupBy.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_GroupBy_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupBy
else
$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) : $(test_unit_OracleAccess_GroupBycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_GroupBy) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_GroupBy) ] || \
	  $(not_test_unit_OracleAccess_GroupBycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_GroupBy.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_GroupBy_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupBy; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) : $(test_unit_OracleAccess_GroupBycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_GroupBy.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_GroupBy.in -tag=$(tags) $(test_unit_OracleAccess_GroupBy_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupBy
else
$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) : $(test_unit_OracleAccess_GroupBycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_GroupBy.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_GroupBy) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_GroupBy) ] || \
	  $(not_test_unit_OracleAccess_GroupBycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_GroupBy.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_GroupBy.in -tag=$(tags) $(test_unit_OracleAccess_GroupBy_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupBy; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_GroupBy_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupBy

test_unit_OracleAccess_GroupBy :: test_unit_OracleAccess_GroupBycompile test_unit_OracleAccess_GroupByinstall ;

ifdef cmt_test_unit_OracleAccess_GroupBy_has_prototypes

test_unit_OracleAccess_GroupByprototype : $(test_unit_OracleAccess_GroupByprototype_dependencies) $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) dirs test_unit_OracleAccess_GroupBydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_GroupBycompile : test_unit_OracleAccess_GroupByprototype

endif

test_unit_OracleAccess_GroupBycompile : $(test_unit_OracleAccess_GroupBycompile_dependencies) $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) dirs test_unit_OracleAccess_GroupBydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_GroupByclean ;

test_unit_OracleAccess_GroupByclean :: $(test_unit_OracleAccess_GroupByclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_GroupBy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) test_unit_OracleAccess_GroupByclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $(bin)test_unit_OracleAccess_GroupBy_dependencies.make

install :: test_unit_OracleAccess_GroupByinstall ;

test_unit_OracleAccess_GroupByinstall :: test_unit_OracleAccess_GroupBycompile $(test_unit_OracleAccess_GroupBy_dependencies) $(cmt_local_test_unit_OracleAccess_GroupBy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_GroupByuninstall

$(foreach d,$(test_unit_OracleAccess_GroupBy_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_GroupByuninstall))

test_unit_OracleAccess_GroupByuninstall : $(test_unit_OracleAccess_GroupByuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_GroupBy_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_GroupBy_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_GroupByuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_GroupBy"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_GroupBy done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_MultipleSchemas_has_no_target_tag = 1
cmt_test_unit_OracleAccess_MultipleSchemas_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_MultipleSchemas_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_MultipleSchemas = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_MultipleSchemas.make
cmt_final_setup_test_unit_OracleAccess_MultipleSchemas = $(bin)setup_test_unit_OracleAccess_MultipleSchemas.make
cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile = $(bin)test_unit_OracleAccess_MultipleSchemas.make

test_unit_OracleAccess_MultipleSchemas_extratags = -tag_add=target_test_unit_OracleAccess_MultipleSchemas

else

cmt_local_tagfile_test_unit_OracleAccess_MultipleSchemas = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_MultipleSchemas = $(bin)setup.make
cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile = $(bin)test_unit_OracleAccess_MultipleSchemas.make

endif

not_test_unit_OracleAccess_MultipleSchemascompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_MultipleSchemascompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_MultipleSchemasdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_MultipleSchemas; then $(mkdir) -p $(bin)test_unit_OracleAccess_MultipleSchemas; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_MultipleSchemas
else
test_unit_OracleAccess_MultipleSchemasdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_MultipleSchemas_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) : $(test_unit_OracleAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemas
else
$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) : $(test_unit_OracleAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultipleSchemas) ] || \
	  $(not_test_unit_OracleAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultipleSchemas.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSchemas_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemas; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) : $(test_unit_OracleAccess_MultipleSchemascompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_OracleAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemas
else
$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) : $(test_unit_OracleAccess_MultipleSchemascompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_MultipleSchemas.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultipleSchemas) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultipleSchemas) ] || \
	  $(not_test_unit_OracleAccess_MultipleSchemascompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultipleSchemas.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultipleSchemas.in -tag=$(tags) $(test_unit_OracleAccess_MultipleSchemas_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemas; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSchemas_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemas

test_unit_OracleAccess_MultipleSchemas :: test_unit_OracleAccess_MultipleSchemascompile test_unit_OracleAccess_MultipleSchemasinstall ;

ifdef cmt_test_unit_OracleAccess_MultipleSchemas_has_prototypes

test_unit_OracleAccess_MultipleSchemasprototype : $(test_unit_OracleAccess_MultipleSchemasprototype_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) dirs test_unit_OracleAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_MultipleSchemascompile : test_unit_OracleAccess_MultipleSchemasprototype

endif

test_unit_OracleAccess_MultipleSchemascompile : $(test_unit_OracleAccess_MultipleSchemascompile_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) dirs test_unit_OracleAccess_MultipleSchemasdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_MultipleSchemasclean ;

test_unit_OracleAccess_MultipleSchemasclean :: $(test_unit_OracleAccess_MultipleSchemasclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) test_unit_OracleAccess_MultipleSchemasclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $(bin)test_unit_OracleAccess_MultipleSchemas_dependencies.make

install :: test_unit_OracleAccess_MultipleSchemasinstall ;

test_unit_OracleAccess_MultipleSchemasinstall :: test_unit_OracleAccess_MultipleSchemascompile $(test_unit_OracleAccess_MultipleSchemas_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_MultipleSchemasuninstall

$(foreach d,$(test_unit_OracleAccess_MultipleSchemas_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_MultipleSchemasuninstall))

test_unit_OracleAccess_MultipleSchemasuninstall : $(test_unit_OracleAccess_MultipleSchemasuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSchemas_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_MultipleSchemasuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_MultipleSchemas"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_MultipleSchemas done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_MultipleSessions_has_no_target_tag = 1
cmt_test_unit_OracleAccess_MultipleSessions_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_MultipleSessions_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_MultipleSessions = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_MultipleSessions.make
cmt_final_setup_test_unit_OracleAccess_MultipleSessions = $(bin)setup_test_unit_OracleAccess_MultipleSessions.make
cmt_local_test_unit_OracleAccess_MultipleSessions_makefile = $(bin)test_unit_OracleAccess_MultipleSessions.make

test_unit_OracleAccess_MultipleSessions_extratags = -tag_add=target_test_unit_OracleAccess_MultipleSessions

else

cmt_local_tagfile_test_unit_OracleAccess_MultipleSessions = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_MultipleSessions = $(bin)setup.make
cmt_local_test_unit_OracleAccess_MultipleSessions_makefile = $(bin)test_unit_OracleAccess_MultipleSessions.make

endif

not_test_unit_OracleAccess_MultipleSessionscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_MultipleSessionscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_MultipleSessionsdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_MultipleSessions; then $(mkdir) -p $(bin)test_unit_OracleAccess_MultipleSessions; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_MultipleSessions
else
test_unit_OracleAccess_MultipleSessionsdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_MultipleSessions_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) : $(test_unit_OracleAccess_MultipleSessionscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultipleSessions.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSessions_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessions
else
$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) : $(test_unit_OracleAccess_MultipleSessionscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultipleSessions) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultipleSessions) ] || \
	  $(not_test_unit_OracleAccess_MultipleSessionscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultipleSessions.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSessions_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessions; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) : $(test_unit_OracleAccess_MultipleSessionscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultipleSessions.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultipleSessions.in -tag=$(tags) $(test_unit_OracleAccess_MultipleSessions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessions
else
$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) : $(test_unit_OracleAccess_MultipleSessionscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_MultipleSessions.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultipleSessions) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultipleSessions) ] || \
	  $(not_test_unit_OracleAccess_MultipleSessionscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultipleSessions.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultipleSessions.in -tag=$(tags) $(test_unit_OracleAccess_MultipleSessions_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessions; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultipleSessions_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessions

test_unit_OracleAccess_MultipleSessions :: test_unit_OracleAccess_MultipleSessionscompile test_unit_OracleAccess_MultipleSessionsinstall ;

ifdef cmt_test_unit_OracleAccess_MultipleSessions_has_prototypes

test_unit_OracleAccess_MultipleSessionsprototype : $(test_unit_OracleAccess_MultipleSessionsprototype_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) dirs test_unit_OracleAccess_MultipleSessionsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_MultipleSessionscompile : test_unit_OracleAccess_MultipleSessionsprototype

endif

test_unit_OracleAccess_MultipleSessionscompile : $(test_unit_OracleAccess_MultipleSessionscompile_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) dirs test_unit_OracleAccess_MultipleSessionsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_MultipleSessionsclean ;

test_unit_OracleAccess_MultipleSessionsclean :: $(test_unit_OracleAccess_MultipleSessionsclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) test_unit_OracleAccess_MultipleSessionsclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $(bin)test_unit_OracleAccess_MultipleSessions_dependencies.make

install :: test_unit_OracleAccess_MultipleSessionsinstall ;

test_unit_OracleAccess_MultipleSessionsinstall :: test_unit_OracleAccess_MultipleSessionscompile $(test_unit_OracleAccess_MultipleSessions_dependencies) $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_MultipleSessionsuninstall

$(foreach d,$(test_unit_OracleAccess_MultipleSessions_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_MultipleSessionsuninstall))

test_unit_OracleAccess_MultipleSessionsuninstall : $(test_unit_OracleAccess_MultipleSessionsuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultipleSessions_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_MultipleSessionsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_MultipleSessions"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_MultipleSessions done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_MultiThreading_has_no_target_tag = 1
cmt_test_unit_OracleAccess_MultiThreading_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_MultiThreading_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_MultiThreading = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_MultiThreading.make
cmt_final_setup_test_unit_OracleAccess_MultiThreading = $(bin)setup_test_unit_OracleAccess_MultiThreading.make
cmt_local_test_unit_OracleAccess_MultiThreading_makefile = $(bin)test_unit_OracleAccess_MultiThreading.make

test_unit_OracleAccess_MultiThreading_extratags = -tag_add=target_test_unit_OracleAccess_MultiThreading

else

cmt_local_tagfile_test_unit_OracleAccess_MultiThreading = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_MultiThreading = $(bin)setup.make
cmt_local_test_unit_OracleAccess_MultiThreading_makefile = $(bin)test_unit_OracleAccess_MultiThreading.make

endif

not_test_unit_OracleAccess_MultiThreadingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_MultiThreadingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_MultiThreadingdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_MultiThreading; then $(mkdir) -p $(bin)test_unit_OracleAccess_MultiThreading; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_MultiThreading
else
test_unit_OracleAccess_MultiThreadingdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_MultiThreading_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) : $(test_unit_OracleAccess_MultiThreadingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultiThreading.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultiThreading_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreading
else
$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) : $(test_unit_OracleAccess_MultiThreadingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultiThreading) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultiThreading) ] || \
	  $(not_test_unit_OracleAccess_MultiThreadingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultiThreading.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultiThreading_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreading; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) : $(test_unit_OracleAccess_MultiThreadingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_MultiThreading.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultiThreading.in -tag=$(tags) $(test_unit_OracleAccess_MultiThreading_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreading
else
$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) : $(test_unit_OracleAccess_MultiThreadingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_MultiThreading.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_MultiThreading) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_MultiThreading) ] || \
	  $(not_test_unit_OracleAccess_MultiThreadingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_MultiThreading.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_MultiThreading.in -tag=$(tags) $(test_unit_OracleAccess_MultiThreading_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreading; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_MultiThreading_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreading

test_unit_OracleAccess_MultiThreading :: test_unit_OracleAccess_MultiThreadingcompile test_unit_OracleAccess_MultiThreadinginstall ;

ifdef cmt_test_unit_OracleAccess_MultiThreading_has_prototypes

test_unit_OracleAccess_MultiThreadingprototype : $(test_unit_OracleAccess_MultiThreadingprototype_dependencies) $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) dirs test_unit_OracleAccess_MultiThreadingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_MultiThreadingcompile : test_unit_OracleAccess_MultiThreadingprototype

endif

test_unit_OracleAccess_MultiThreadingcompile : $(test_unit_OracleAccess_MultiThreadingcompile_dependencies) $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) dirs test_unit_OracleAccess_MultiThreadingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_MultiThreadingclean ;

test_unit_OracleAccess_MultiThreadingclean :: $(test_unit_OracleAccess_MultiThreadingclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) test_unit_OracleAccess_MultiThreadingclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $(bin)test_unit_OracleAccess_MultiThreading_dependencies.make

install :: test_unit_OracleAccess_MultiThreadinginstall ;

test_unit_OracleAccess_MultiThreadinginstall :: test_unit_OracleAccess_MultiThreadingcompile $(test_unit_OracleAccess_MultiThreading_dependencies) $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_MultiThreadinguninstall

$(foreach d,$(test_unit_OracleAccess_MultiThreading_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_MultiThreadinguninstall))

test_unit_OracleAccess_MultiThreadinguninstall : $(test_unit_OracleAccess_MultiThreadinguninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_MultiThreading_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_MultiThreadinguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_MultiThreading"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_MultiThreading done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_Schema_has_no_target_tag = 1
cmt_test_unit_OracleAccess_Schema_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_Schema_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_Schema = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_Schema.make
cmt_final_setup_test_unit_OracleAccess_Schema = $(bin)setup_test_unit_OracleAccess_Schema.make
cmt_local_test_unit_OracleAccess_Schema_makefile = $(bin)test_unit_OracleAccess_Schema.make

test_unit_OracleAccess_Schema_extratags = -tag_add=target_test_unit_OracleAccess_Schema

else

cmt_local_tagfile_test_unit_OracleAccess_Schema = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_Schema = $(bin)setup.make
cmt_local_test_unit_OracleAccess_Schema_makefile = $(bin)test_unit_OracleAccess_Schema.make

endif

not_test_unit_OracleAccess_Schemacompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_Schemacompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_Schemadirs :
	@if test ! -d $(bin)test_unit_OracleAccess_Schema; then $(mkdir) -p $(bin)test_unit_OracleAccess_Schema; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_Schema
else
test_unit_OracleAccess_Schemadirs : ;
endif

ifdef cmt_test_unit_OracleAccess_Schema_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Schema_makefile) : $(test_unit_OracleAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schema
else
$(cmt_local_test_unit_OracleAccess_Schema_makefile) : $(test_unit_OracleAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Schema) ] || \
	  $(not_test_unit_OracleAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Schema.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Schema_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schema; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Schema_makefile) : $(test_unit_OracleAccess_Schemacompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Schema.in -tag=$(tags) $(test_unit_OracleAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schema
else
$(cmt_local_test_unit_OracleAccess_Schema_makefile) : $(test_unit_OracleAccess_Schemacompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_Schema.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Schema) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Schema) ] || \
	  $(not_test_unit_OracleAccess_Schemacompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Schema.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Schema.in -tag=$(tags) $(test_unit_OracleAccess_Schema_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schema; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Schema_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schema

test_unit_OracleAccess_Schema :: test_unit_OracleAccess_Schemacompile test_unit_OracleAccess_Schemainstall ;

ifdef cmt_test_unit_OracleAccess_Schema_has_prototypes

test_unit_OracleAccess_Schemaprototype : $(test_unit_OracleAccess_Schemaprototype_dependencies) $(cmt_local_test_unit_OracleAccess_Schema_makefile) dirs test_unit_OracleAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_Schemacompile : test_unit_OracleAccess_Schemaprototype

endif

test_unit_OracleAccess_Schemacompile : $(test_unit_OracleAccess_Schemacompile_dependencies) $(cmt_local_test_unit_OracleAccess_Schema_makefile) dirs test_unit_OracleAccess_Schemadirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_Schemaclean ;

test_unit_OracleAccess_Schemaclean :: $(test_unit_OracleAccess_Schemaclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) test_unit_OracleAccess_Schemaclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $(bin)test_unit_OracleAccess_Schema_dependencies.make

install :: test_unit_OracleAccess_Schemainstall ;

test_unit_OracleAccess_Schemainstall :: test_unit_OracleAccess_Schemacompile $(test_unit_OracleAccess_Schema_dependencies) $(cmt_local_test_unit_OracleAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_Schemauninstall

$(foreach d,$(test_unit_OracleAccess_Schema_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_Schemauninstall))

test_unit_OracleAccess_Schemauninstall : $(test_unit_OracleAccess_Schemauninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_Schema_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Schema_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Schema_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_Schemauninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_Schema"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_Schema done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_SimpleQueries_has_no_target_tag = 1
cmt_test_unit_OracleAccess_SimpleQueries_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_SimpleQueries_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_SimpleQueries = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_SimpleQueries.make
cmt_final_setup_test_unit_OracleAccess_SimpleQueries = $(bin)setup_test_unit_OracleAccess_SimpleQueries.make
cmt_local_test_unit_OracleAccess_SimpleQueries_makefile = $(bin)test_unit_OracleAccess_SimpleQueries.make

test_unit_OracleAccess_SimpleQueries_extratags = -tag_add=target_test_unit_OracleAccess_SimpleQueries

else

cmt_local_tagfile_test_unit_OracleAccess_SimpleQueries = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_SimpleQueries = $(bin)setup.make
cmt_local_test_unit_OracleAccess_SimpleQueries_makefile = $(bin)test_unit_OracleAccess_SimpleQueries.make

endif

not_test_unit_OracleAccess_SimpleQueriescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_SimpleQueriescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_SimpleQueriesdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_SimpleQueries; then $(mkdir) -p $(bin)test_unit_OracleAccess_SimpleQueries; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_SimpleQueries
else
test_unit_OracleAccess_SimpleQueriesdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_SimpleQueries_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) : $(test_unit_OracleAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueries
else
$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) : $(test_unit_OracleAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_SimpleQueries) ] || \
	  $(not_test_unit_OracleAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_SimpleQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_SimpleQueries_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueries; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) : $(test_unit_OracleAccess_SimpleQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_SimpleQueries.in -tag=$(tags) $(test_unit_OracleAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueries
else
$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) : $(test_unit_OracleAccess_SimpleQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_SimpleQueries.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_SimpleQueries) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_SimpleQueries) ] || \
	  $(not_test_unit_OracleAccess_SimpleQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_SimpleQueries.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_SimpleQueries.in -tag=$(tags) $(test_unit_OracleAccess_SimpleQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueries; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_SimpleQueries_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueries

test_unit_OracleAccess_SimpleQueries :: test_unit_OracleAccess_SimpleQueriescompile test_unit_OracleAccess_SimpleQueriesinstall ;

ifdef cmt_test_unit_OracleAccess_SimpleQueries_has_prototypes

test_unit_OracleAccess_SimpleQueriesprototype : $(test_unit_OracleAccess_SimpleQueriesprototype_dependencies) $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) dirs test_unit_OracleAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_SimpleQueriescompile : test_unit_OracleAccess_SimpleQueriesprototype

endif

test_unit_OracleAccess_SimpleQueriescompile : $(test_unit_OracleAccess_SimpleQueriescompile_dependencies) $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) dirs test_unit_OracleAccess_SimpleQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_SimpleQueriesclean ;

test_unit_OracleAccess_SimpleQueriesclean :: $(test_unit_OracleAccess_SimpleQueriesclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) test_unit_OracleAccess_SimpleQueriesclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $(bin)test_unit_OracleAccess_SimpleQueries_dependencies.make

install :: test_unit_OracleAccess_SimpleQueriesinstall ;

test_unit_OracleAccess_SimpleQueriesinstall :: test_unit_OracleAccess_SimpleQueriescompile $(test_unit_OracleAccess_SimpleQueries_dependencies) $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_SimpleQueriesuninstall

$(foreach d,$(test_unit_OracleAccess_SimpleQueries_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_SimpleQueriesuninstall))

test_unit_OracleAccess_SimpleQueriesuninstall : $(test_unit_OracleAccess_SimpleQueriesuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_SimpleQueries_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_SimpleQueriesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_SimpleQueries"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_SimpleQueries done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_OracleAccess_Views_has_no_target_tag = 1
cmt_test_unit_OracleAccess_Views_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_OracleAccess_Views_has_target_tag

cmt_local_tagfile_test_unit_OracleAccess_Views = $(bin)$(OracleAccess_tag)_test_unit_OracleAccess_Views.make
cmt_final_setup_test_unit_OracleAccess_Views = $(bin)setup_test_unit_OracleAccess_Views.make
cmt_local_test_unit_OracleAccess_Views_makefile = $(bin)test_unit_OracleAccess_Views.make

test_unit_OracleAccess_Views_extratags = -tag_add=target_test_unit_OracleAccess_Views

else

cmt_local_tagfile_test_unit_OracleAccess_Views = $(bin)$(OracleAccess_tag).make
cmt_final_setup_test_unit_OracleAccess_Views = $(bin)setup.make
cmt_local_test_unit_OracleAccess_Views_makefile = $(bin)test_unit_OracleAccess_Views.make

endif

not_test_unit_OracleAccess_Viewscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_OracleAccess_Viewscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_OracleAccess_Viewsdirs :
	@if test ! -d $(bin)test_unit_OracleAccess_Views; then $(mkdir) -p $(bin)test_unit_OracleAccess_Views; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_OracleAccess_Views
else
test_unit_OracleAccess_Viewsdirs : ;
endif

ifdef cmt_test_unit_OracleAccess_Views_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Views_makefile) : $(test_unit_OracleAccess_Viewscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Views.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Views_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Views
else
$(cmt_local_test_unit_OracleAccess_Views_makefile) : $(test_unit_OracleAccess_Viewscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Views) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Views) ] || \
	  $(not_test_unit_OracleAccess_Viewscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Views.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Views_extratags) build constituent_config -out=$(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Views; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_OracleAccess_Views_makefile) : $(test_unit_OracleAccess_Viewscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_OracleAccess_Views.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Views.in -tag=$(tags) $(test_unit_OracleAccess_Views_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Views
else
$(cmt_local_test_unit_OracleAccess_Views_makefile) : $(test_unit_OracleAccess_Viewscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_OracleAccess_Views.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_OracleAccess_Views) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_OracleAccess_Views) ] || \
	  $(not_test_unit_OracleAccess_Viewscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_OracleAccess_Views.make"; \
	  $(cmtexe) -f=$(bin)test_unit_OracleAccess_Views.in -tag=$(tags) $(test_unit_OracleAccess_Views_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Views; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_OracleAccess_Views_extratags) build constituent_makefile -out=$(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Views

test_unit_OracleAccess_Views :: test_unit_OracleAccess_Viewscompile test_unit_OracleAccess_Viewsinstall ;

ifdef cmt_test_unit_OracleAccess_Views_has_prototypes

test_unit_OracleAccess_Viewsprototype : $(test_unit_OracleAccess_Viewsprototype_dependencies) $(cmt_local_test_unit_OracleAccess_Views_makefile) dirs test_unit_OracleAccess_Viewsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_OracleAccess_Viewscompile : test_unit_OracleAccess_Viewsprototype

endif

test_unit_OracleAccess_Viewscompile : $(test_unit_OracleAccess_Viewscompile_dependencies) $(cmt_local_test_unit_OracleAccess_Views_makefile) dirs test_unit_OracleAccess_Viewsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_OracleAccess_Viewsclean ;

test_unit_OracleAccess_Viewsclean :: $(test_unit_OracleAccess_Viewsclean_dependencies) ##$(cmt_local_test_unit_OracleAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) test_unit_OracleAccess_Viewsclean

##	  /bin/rm -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $(bin)test_unit_OracleAccess_Views_dependencies.make

install :: test_unit_OracleAccess_Viewsinstall ;

test_unit_OracleAccess_Viewsinstall :: test_unit_OracleAccess_Viewscompile $(test_unit_OracleAccess_Views_dependencies) $(cmt_local_test_unit_OracleAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_OracleAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_OracleAccess_Viewsuninstall

$(foreach d,$(test_unit_OracleAccess_Views_dependencies),$(eval $(d)uninstall_dependencies += test_unit_OracleAccess_Viewsuninstall))

test_unit_OracleAccess_Viewsuninstall : $(test_unit_OracleAccess_Viewsuninstall_dependencies) ##$(cmt_local_test_unit_OracleAccess_Views_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_OracleAccess_Views_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_OracleAccess_Views_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_OracleAccess_Viewsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_OracleAccess_Views"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_OracleAccess_Views done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(OracleAccess_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(OracleAccess_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(OracleAccess_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(OracleAccess_tag).make
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

cmt_local_tagfile_make = $(bin)$(OracleAccess_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(OracleAccess_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(OracleAccess_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(OracleAccess_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(OracleAccess_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(OracleAccess_tag).make
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

cmt_local_tagfile_examples = $(bin)$(OracleAccess_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(OracleAccess_tag).make
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
