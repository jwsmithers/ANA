
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralAuthenticationService_tag = $(tag)

#cmt_local_tagfile = $(CoralAuthenticationService_tag).make
cmt_local_tagfile = $(bin)$(CoralAuthenticationService_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralAuthenticationServicesetup.make
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

cmt_lcg_CoralAuthenticationService_has_no_target_tag = 1
cmt_lcg_CoralAuthenticationService_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralAuthenticationService_has_target_tag

cmt_local_tagfile_lcg_CoralAuthenticationService = $(bin)$(CoralAuthenticationService_tag)_lcg_CoralAuthenticationService.make
cmt_final_setup_lcg_CoralAuthenticationService = $(bin)setup_lcg_CoralAuthenticationService.make
cmt_local_lcg_CoralAuthenticationService_makefile = $(bin)lcg_CoralAuthenticationService.make

lcg_CoralAuthenticationService_extratags = -tag_add=target_lcg_CoralAuthenticationService

else

cmt_local_tagfile_lcg_CoralAuthenticationService = $(bin)$(CoralAuthenticationService_tag).make
cmt_final_setup_lcg_CoralAuthenticationService = $(bin)setup.make
cmt_local_lcg_CoralAuthenticationService_makefile = $(bin)lcg_CoralAuthenticationService.make

endif

not_lcg_CoralAuthenticationServicecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralAuthenticationServicecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralAuthenticationServicedirs :
	@if test ! -d $(bin)lcg_CoralAuthenticationService; then $(mkdir) -p $(bin)lcg_CoralAuthenticationService; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralAuthenticationService
else
lcg_CoralAuthenticationServicedirs : ;
endif

ifdef cmt_lcg_CoralAuthenticationService_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralAuthenticationService_makefile) : $(lcg_CoralAuthenticationServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralAuthenticationService.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralAuthenticationService_extratags) build constituent_config -out=$(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationService
else
$(cmt_local_lcg_CoralAuthenticationService_makefile) : $(lcg_CoralAuthenticationServicecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralAuthenticationService) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralAuthenticationService) ] || \
	  $(not_lcg_CoralAuthenticationServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralAuthenticationService.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralAuthenticationService_extratags) build constituent_config -out=$(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationService; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralAuthenticationService_makefile) : $(lcg_CoralAuthenticationServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralAuthenticationService.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralAuthenticationService.in -tag=$(tags) $(lcg_CoralAuthenticationService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationService
else
$(cmt_local_lcg_CoralAuthenticationService_makefile) : $(lcg_CoralAuthenticationServicecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralAuthenticationService.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralAuthenticationService) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralAuthenticationService) ] || \
	  $(not_lcg_CoralAuthenticationServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralAuthenticationService.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralAuthenticationService.in -tag=$(tags) $(lcg_CoralAuthenticationService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationService; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralAuthenticationService_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationService

lcg_CoralAuthenticationService :: lcg_CoralAuthenticationServicecompile lcg_CoralAuthenticationServiceinstall ;

ifdef cmt_lcg_CoralAuthenticationService_has_prototypes

lcg_CoralAuthenticationServiceprototype : $(lcg_CoralAuthenticationServiceprototype_dependencies) $(cmt_local_lcg_CoralAuthenticationService_makefile) dirs lcg_CoralAuthenticationServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAuthenticationService_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralAuthenticationServicecompile : lcg_CoralAuthenticationServiceprototype

endif

lcg_CoralAuthenticationServicecompile : $(lcg_CoralAuthenticationServicecompile_dependencies) $(cmt_local_lcg_CoralAuthenticationService_makefile) dirs lcg_CoralAuthenticationServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAuthenticationService_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralAuthenticationServiceclean ;

lcg_CoralAuthenticationServiceclean :: $(lcg_CoralAuthenticationServiceclean_dependencies) ##$(cmt_local_lcg_CoralAuthenticationService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralAuthenticationService_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) lcg_CoralAuthenticationServiceclean

##	  /bin/rm -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $(bin)lcg_CoralAuthenticationService_dependencies.make

install :: lcg_CoralAuthenticationServiceinstall ;

lcg_CoralAuthenticationServiceinstall :: lcg_CoralAuthenticationServicecompile $(lcg_CoralAuthenticationService_dependencies) $(cmt_local_lcg_CoralAuthenticationService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAuthenticationService_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralAuthenticationServiceuninstall

$(foreach d,$(lcg_CoralAuthenticationService_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralAuthenticationServiceuninstall))

lcg_CoralAuthenticationServiceuninstall : $(lcg_CoralAuthenticationServiceuninstall_dependencies) ##$(cmt_local_lcg_CoralAuthenticationService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralAuthenticationService_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAuthenticationService_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralAuthenticationServiceuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralAuthenticationService"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralAuthenticationService done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralAuthenticationService_OpenSSLCipher_has_no_target_tag = 1
cmt_test_unit_CoralAuthenticationService_OpenSSLCipher_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralAuthenticationService_OpenSSLCipher_has_target_tag

cmt_local_tagfile_test_unit_CoralAuthenticationService_OpenSSLCipher = $(bin)$(CoralAuthenticationService_tag)_test_unit_CoralAuthenticationService_OpenSSLCipher.make
cmt_final_setup_test_unit_CoralAuthenticationService_OpenSSLCipher = $(bin)setup_test_unit_CoralAuthenticationService_OpenSSLCipher.make
cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile = $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher.make

test_unit_CoralAuthenticationService_OpenSSLCipher_extratags = -tag_add=target_test_unit_CoralAuthenticationService_OpenSSLCipher

else

cmt_local_tagfile_test_unit_CoralAuthenticationService_OpenSSLCipher = $(bin)$(CoralAuthenticationService_tag).make
cmt_final_setup_test_unit_CoralAuthenticationService_OpenSSLCipher = $(bin)setup.make
cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile = $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher.make

endif

not_test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralAuthenticationService_OpenSSLCipherdirs :
	@if test ! -d $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher; then $(mkdir) -p $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralAuthenticationService_OpenSSLCipher
else
test_unit_CoralAuthenticationService_OpenSSLCipherdirs : ;
endif

ifdef cmt_test_unit_CoralAuthenticationService_OpenSSLCipher_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) : $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralAuthenticationService_OpenSSLCipher.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_OpenSSLCipher_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipher
else
$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) : $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralAuthenticationService_OpenSSLCipher) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralAuthenticationService_OpenSSLCipher) ] || \
	  $(not_test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralAuthenticationService_OpenSSLCipher.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_OpenSSLCipher_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipher; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) : $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralAuthenticationService_OpenSSLCipher.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralAuthenticationService_OpenSSLCipher.in -tag=$(tags) $(test_unit_CoralAuthenticationService_OpenSSLCipher_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipher
else
$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) : $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralAuthenticationService_OpenSSLCipher) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralAuthenticationService_OpenSSLCipher) ] || \
	  $(not_test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralAuthenticationService_OpenSSLCipher.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralAuthenticationService_OpenSSLCipher.in -tag=$(tags) $(test_unit_CoralAuthenticationService_OpenSSLCipher_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipher; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_OpenSSLCipher_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipher

test_unit_CoralAuthenticationService_OpenSSLCipher :: test_unit_CoralAuthenticationService_OpenSSLCiphercompile test_unit_CoralAuthenticationService_OpenSSLCipherinstall ;

ifdef cmt_test_unit_CoralAuthenticationService_OpenSSLCipher_has_prototypes

test_unit_CoralAuthenticationService_OpenSSLCipherprototype : $(test_unit_CoralAuthenticationService_OpenSSLCipherprototype_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) dirs test_unit_CoralAuthenticationService_OpenSSLCipherdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralAuthenticationService_OpenSSLCiphercompile : test_unit_CoralAuthenticationService_OpenSSLCipherprototype

endif

test_unit_CoralAuthenticationService_OpenSSLCiphercompile : $(test_unit_CoralAuthenticationService_OpenSSLCiphercompile_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) dirs test_unit_CoralAuthenticationService_OpenSSLCipherdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralAuthenticationService_OpenSSLCipherclean ;

test_unit_CoralAuthenticationService_OpenSSLCipherclean :: $(test_unit_CoralAuthenticationService_OpenSSLCipherclean_dependencies) ##$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) test_unit_CoralAuthenticationService_OpenSSLCipherclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $(bin)test_unit_CoralAuthenticationService_OpenSSLCipher_dependencies.make

install :: test_unit_CoralAuthenticationService_OpenSSLCipherinstall ;

test_unit_CoralAuthenticationService_OpenSSLCipherinstall :: test_unit_CoralAuthenticationService_OpenSSLCiphercompile $(test_unit_CoralAuthenticationService_OpenSSLCipher_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralAuthenticationService_OpenSSLCipheruninstall

$(foreach d,$(test_unit_CoralAuthenticationService_OpenSSLCipher_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralAuthenticationService_OpenSSLCipheruninstall))

test_unit_CoralAuthenticationService_OpenSSLCipheruninstall : $(test_unit_CoralAuthenticationService_OpenSSLCipheruninstall_dependencies) ##$(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_OpenSSLCipher_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralAuthenticationService_OpenSSLCipheruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralAuthenticationService_OpenSSLCipher"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralAuthenticationService_OpenSSLCipher done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralAuthenticationService_QueryMgr_has_no_target_tag = 1
cmt_test_unit_CoralAuthenticationService_QueryMgr_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralAuthenticationService_QueryMgr_has_target_tag

cmt_local_tagfile_test_unit_CoralAuthenticationService_QueryMgr = $(bin)$(CoralAuthenticationService_tag)_test_unit_CoralAuthenticationService_QueryMgr.make
cmt_final_setup_test_unit_CoralAuthenticationService_QueryMgr = $(bin)setup_test_unit_CoralAuthenticationService_QueryMgr.make
cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile = $(bin)test_unit_CoralAuthenticationService_QueryMgr.make

test_unit_CoralAuthenticationService_QueryMgr_extratags = -tag_add=target_test_unit_CoralAuthenticationService_QueryMgr

else

cmt_local_tagfile_test_unit_CoralAuthenticationService_QueryMgr = $(bin)$(CoralAuthenticationService_tag).make
cmt_final_setup_test_unit_CoralAuthenticationService_QueryMgr = $(bin)setup.make
cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile = $(bin)test_unit_CoralAuthenticationService_QueryMgr.make

endif

not_test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralAuthenticationService_QueryMgrdirs :
	@if test ! -d $(bin)test_unit_CoralAuthenticationService_QueryMgr; then $(mkdir) -p $(bin)test_unit_CoralAuthenticationService_QueryMgr; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralAuthenticationService_QueryMgr
else
test_unit_CoralAuthenticationService_QueryMgrdirs : ;
endif

ifdef cmt_test_unit_CoralAuthenticationService_QueryMgr_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) : $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralAuthenticationService_QueryMgr.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_QueryMgr_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgr
else
$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) : $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralAuthenticationService_QueryMgr) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralAuthenticationService_QueryMgr) ] || \
	  $(not_test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralAuthenticationService_QueryMgr.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_QueryMgr_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgr; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) : $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralAuthenticationService_QueryMgr.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralAuthenticationService_QueryMgr.in -tag=$(tags) $(test_unit_CoralAuthenticationService_QueryMgr_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgr
else
$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) : $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralAuthenticationService_QueryMgr.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralAuthenticationService_QueryMgr) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralAuthenticationService_QueryMgr) ] || \
	  $(not_test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralAuthenticationService_QueryMgr.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralAuthenticationService_QueryMgr.in -tag=$(tags) $(test_unit_CoralAuthenticationService_QueryMgr_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgr; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralAuthenticationService_QueryMgr_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgr

test_unit_CoralAuthenticationService_QueryMgr :: test_unit_CoralAuthenticationService_QueryMgrcompile test_unit_CoralAuthenticationService_QueryMgrinstall ;

ifdef cmt_test_unit_CoralAuthenticationService_QueryMgr_has_prototypes

test_unit_CoralAuthenticationService_QueryMgrprototype : $(test_unit_CoralAuthenticationService_QueryMgrprototype_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) dirs test_unit_CoralAuthenticationService_QueryMgrdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralAuthenticationService_QueryMgrcompile : test_unit_CoralAuthenticationService_QueryMgrprototype

endif

test_unit_CoralAuthenticationService_QueryMgrcompile : $(test_unit_CoralAuthenticationService_QueryMgrcompile_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) dirs test_unit_CoralAuthenticationService_QueryMgrdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralAuthenticationService_QueryMgrclean ;

test_unit_CoralAuthenticationService_QueryMgrclean :: $(test_unit_CoralAuthenticationService_QueryMgrclean_dependencies) ##$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) test_unit_CoralAuthenticationService_QueryMgrclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $(bin)test_unit_CoralAuthenticationService_QueryMgr_dependencies.make

install :: test_unit_CoralAuthenticationService_QueryMgrinstall ;

test_unit_CoralAuthenticationService_QueryMgrinstall :: test_unit_CoralAuthenticationService_QueryMgrcompile $(test_unit_CoralAuthenticationService_QueryMgr_dependencies) $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralAuthenticationService_QueryMgruninstall

$(foreach d,$(test_unit_CoralAuthenticationService_QueryMgr_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralAuthenticationService_QueryMgruninstall))

test_unit_CoralAuthenticationService_QueryMgruninstall : $(test_unit_CoralAuthenticationService_QueryMgruninstall_dependencies) ##$(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralAuthenticationService_QueryMgr_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralAuthenticationService_QueryMgruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralAuthenticationService_QueryMgr"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralAuthenticationService_QueryMgr done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralDemo_has_no_target_tag = 1
cmt_coralDemo_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralDemo_has_target_tag

cmt_local_tagfile_coralDemo = $(bin)$(CoralAuthenticationService_tag)_coralDemo.make
cmt_final_setup_coralDemo = $(bin)setup_coralDemo.make
cmt_local_coralDemo_makefile = $(bin)coralDemo.make

coralDemo_extratags = -tag_add=target_coralDemo

else

cmt_local_tagfile_coralDemo = $(bin)$(CoralAuthenticationService_tag).make
cmt_final_setup_coralDemo = $(bin)setup.make
cmt_local_coralDemo_makefile = $(bin)coralDemo.make

endif

not_coralDemocompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralDemocompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralDemodirs :
	@if test ! -d $(bin)coralDemo; then $(mkdir) -p $(bin)coralDemo; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralDemo
else
coralDemodirs : ;
endif

ifdef cmt_coralDemo_has_target_tag

ifndef QUICK
$(cmt_local_coralDemo_makefile) : $(coralDemocompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDemo.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDemo_extratags) build constituent_config -out=$(cmt_local_coralDemo_makefile) coralDemo
else
$(cmt_local_coralDemo_makefile) : $(coralDemocompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDemo) ] || \
	  [ ! -f $(cmt_final_setup_coralDemo) ] || \
	  $(not_coralDemocompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDemo.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDemo_extratags) build constituent_config -out=$(cmt_local_coralDemo_makefile) coralDemo; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralDemo_makefile) : $(coralDemocompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDemo.make"; \
	  $(cmtexe) -f=$(bin)coralDemo.in -tag=$(tags) $(coralDemo_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDemo_makefile) coralDemo
else
$(cmt_local_coralDemo_makefile) : $(coralDemocompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralDemo.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDemo) ] || \
	  [ ! -f $(cmt_final_setup_coralDemo) ] || \
	  $(not_coralDemocompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDemo.make"; \
	  $(cmtexe) -f=$(bin)coralDemo.in -tag=$(tags) $(coralDemo_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDemo_makefile) coralDemo; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralDemo_extratags) build constituent_makefile -out=$(cmt_local_coralDemo_makefile) coralDemo

coralDemo :: coralDemocompile coralDemoinstall ;

ifdef cmt_coralDemo_has_prototypes

coralDemoprototype : $(coralDemoprototype_dependencies) $(cmt_local_coralDemo_makefile) dirs coralDemodirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDemo_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDemo_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDemo_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralDemocompile : coralDemoprototype

endif

coralDemocompile : $(coralDemocompile_dependencies) $(cmt_local_coralDemo_makefile) dirs coralDemodirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDemo_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDemo_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDemo_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralDemoclean ;

coralDemoclean :: $(coralDemoclean_dependencies) ##$(cmt_local_coralDemo_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDemo_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDemo_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralDemo_makefile) coralDemoclean

##	  /bin/rm -f $(cmt_local_coralDemo_makefile) $(bin)coralDemo_dependencies.make

install :: coralDemoinstall ;

coralDemoinstall :: coralDemocompile $(coralDemo_dependencies) $(cmt_local_coralDemo_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDemo_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDemo_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDemo_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralDemouninstall

$(foreach d,$(coralDemo_dependencies),$(eval $(d)uninstall_dependencies += coralDemouninstall))

coralDemouninstall : $(coralDemouninstall_dependencies) ##$(cmt_local_coralDemo_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDemo_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDemo_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDemo_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralDemouninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralDemo"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralDemo done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralCredentialsManager_has_no_target_tag = 1
cmt_coralCredentialsManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralCredentialsManager_has_target_tag

cmt_local_tagfile_coralCredentialsManager = $(bin)$(CoralAuthenticationService_tag)_coralCredentialsManager.make
cmt_final_setup_coralCredentialsManager = $(bin)setup_coralCredentialsManager.make
cmt_local_coralCredentialsManager_makefile = $(bin)coralCredentialsManager.make

coralCredentialsManager_extratags = -tag_add=target_coralCredentialsManager

else

cmt_local_tagfile_coralCredentialsManager = $(bin)$(CoralAuthenticationService_tag).make
cmt_final_setup_coralCredentialsManager = $(bin)setup.make
cmt_local_coralCredentialsManager_makefile = $(bin)coralCredentialsManager.make

endif

not_coralCredentialsManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralCredentialsManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralCredentialsManagerdirs :
	@if test ! -d $(bin)coralCredentialsManager; then $(mkdir) -p $(bin)coralCredentialsManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralCredentialsManager
else
coralCredentialsManagerdirs : ;
endif

ifdef cmt_coralCredentialsManager_has_target_tag

ifndef QUICK
$(cmt_local_coralCredentialsManager_makefile) : $(coralCredentialsManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralCredentialsManager.make"; \
	  $(cmtexe) -tag=$(tags) $(coralCredentialsManager_extratags) build constituent_config -out=$(cmt_local_coralCredentialsManager_makefile) coralCredentialsManager
else
$(cmt_local_coralCredentialsManager_makefile) : $(coralCredentialsManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralCredentialsManager) ] || \
	  [ ! -f $(cmt_final_setup_coralCredentialsManager) ] || \
	  $(not_coralCredentialsManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralCredentialsManager.make"; \
	  $(cmtexe) -tag=$(tags) $(coralCredentialsManager_extratags) build constituent_config -out=$(cmt_local_coralCredentialsManager_makefile) coralCredentialsManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralCredentialsManager_makefile) : $(coralCredentialsManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralCredentialsManager.make"; \
	  $(cmtexe) -f=$(bin)coralCredentialsManager.in -tag=$(tags) $(coralCredentialsManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralCredentialsManager_makefile) coralCredentialsManager
else
$(cmt_local_coralCredentialsManager_makefile) : $(coralCredentialsManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralCredentialsManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralCredentialsManager) ] || \
	  [ ! -f $(cmt_final_setup_coralCredentialsManager) ] || \
	  $(not_coralCredentialsManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralCredentialsManager.make"; \
	  $(cmtexe) -f=$(bin)coralCredentialsManager.in -tag=$(tags) $(coralCredentialsManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralCredentialsManager_makefile) coralCredentialsManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralCredentialsManager_extratags) build constituent_makefile -out=$(cmt_local_coralCredentialsManager_makefile) coralCredentialsManager

coralCredentialsManager :: coralCredentialsManagercompile coralCredentialsManagerinstall ;

ifdef cmt_coralCredentialsManager_has_prototypes

coralCredentialsManagerprototype : $(coralCredentialsManagerprototype_dependencies) $(cmt_local_coralCredentialsManager_makefile) dirs coralCredentialsManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralCredentialsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralCredentialsManagercompile : coralCredentialsManagerprototype

endif

coralCredentialsManagercompile : $(coralCredentialsManagercompile_dependencies) $(cmt_local_coralCredentialsManager_makefile) dirs coralCredentialsManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralCredentialsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralCredentialsManagerclean ;

coralCredentialsManagerclean :: $(coralCredentialsManagerclean_dependencies) ##$(cmt_local_coralCredentialsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralCredentialsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) coralCredentialsManagerclean

##	  /bin/rm -f $(cmt_local_coralCredentialsManager_makefile) $(bin)coralCredentialsManager_dependencies.make

install :: coralCredentialsManagerinstall ;

coralCredentialsManagerinstall :: coralCredentialsManagercompile $(coralCredentialsManager_dependencies) $(cmt_local_coralCredentialsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralCredentialsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralCredentialsManageruninstall

$(foreach d,$(coralCredentialsManager_dependencies),$(eval $(d)uninstall_dependencies += coralCredentialsManageruninstall))

coralCredentialsManageruninstall : $(coralCredentialsManageruninstall_dependencies) ##$(cmt_local_coralCredentialsManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralCredentialsManager_makefile); then \
	  $(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralCredentialsManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralCredentialsManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralCredentialsManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralCredentialsManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralAuthenticationService_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralAuthenticationService_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralAuthenticationService_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralAuthenticationService_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralAuthenticationService_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralAuthenticationService_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralAuthenticationService_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralAuthenticationService_tag).make
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

cmt_examples_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_examples_has_target_tag

cmt_local_tagfile_examples = $(bin)$(CoralAuthenticationService_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralAuthenticationService_tag).make
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
