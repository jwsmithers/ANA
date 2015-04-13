
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralKernel_tag = $(tag)

#cmt_local_tagfile = $(CoralKernel_tag).make
cmt_local_tagfile = $(bin)$(CoralKernel_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralKernelsetup.make
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

cmt_lcg_CoralKernel_has_no_target_tag = 1
cmt_lcg_CoralKernel_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralKernel_has_target_tag

cmt_local_tagfile_lcg_CoralKernel = $(bin)$(CoralKernel_tag)_lcg_CoralKernel.make
cmt_final_setup_lcg_CoralKernel = $(bin)setup_lcg_CoralKernel.make
cmt_local_lcg_CoralKernel_makefile = $(bin)lcg_CoralKernel.make

lcg_CoralKernel_extratags = -tag_add=target_lcg_CoralKernel

else

cmt_local_tagfile_lcg_CoralKernel = $(bin)$(CoralKernel_tag).make
cmt_final_setup_lcg_CoralKernel = $(bin)setup.make
cmt_local_lcg_CoralKernel_makefile = $(bin)lcg_CoralKernel.make

endif

not_lcg_CoralKernelcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralKernelcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralKerneldirs :
	@if test ! -d $(bin)lcg_CoralKernel; then $(mkdir) -p $(bin)lcg_CoralKernel; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralKernel
else
lcg_CoralKerneldirs : ;
endif

ifdef cmt_lcg_CoralKernel_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralKernel_makefile) : $(lcg_CoralKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralKernel_extratags) build constituent_config -out=$(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernel
else
$(cmt_local_lcg_CoralKernel_makefile) : $(lcg_CoralKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralKernel) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralKernel) ] || \
	  $(not_lcg_CoralKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralKernel_extratags) build constituent_config -out=$(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernel; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralKernel_makefile) : $(lcg_CoralKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralKernel.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralKernel.in -tag=$(tags) $(lcg_CoralKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernel
else
$(cmt_local_lcg_CoralKernel_makefile) : $(lcg_CoralKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralKernel.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralKernel) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralKernel) ] || \
	  $(not_lcg_CoralKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralKernel.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralKernel.in -tag=$(tags) $(lcg_CoralKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernel; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralKernel_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernel

lcg_CoralKernel :: lcg_CoralKernelcompile lcg_CoralKernelinstall ;

ifdef cmt_lcg_CoralKernel_has_prototypes

lcg_CoralKernelprototype : $(lcg_CoralKernelprototype_dependencies) $(cmt_local_lcg_CoralKernel_makefile) dirs lcg_CoralKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralKernelcompile : lcg_CoralKernelprototype

endif

lcg_CoralKernelcompile : $(lcg_CoralKernelcompile_dependencies) $(cmt_local_lcg_CoralKernel_makefile) dirs lcg_CoralKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralKernelclean ;

lcg_CoralKernelclean :: $(lcg_CoralKernelclean_dependencies) ##$(cmt_local_lcg_CoralKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) lcg_CoralKernelclean

##	  /bin/rm -f $(cmt_local_lcg_CoralKernel_makefile) $(bin)lcg_CoralKernel_dependencies.make

install :: lcg_CoralKernelinstall ;

lcg_CoralKernelinstall :: lcg_CoralKernelcompile $(lcg_CoralKernel_dependencies) $(cmt_local_lcg_CoralKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralKerneluninstall

$(foreach d,$(lcg_CoralKernel_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralKerneluninstall))

lcg_CoralKerneluninstall : $(lcg_CoralKerneluninstall_dependencies) ##$(cmt_local_lcg_CoralKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralKernel_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralKerneluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralKernel"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralKernel done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralKernel_CoralKernelTest_has_no_target_tag = 1
cmt_test_unit_CoralKernel_CoralKernelTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralKernel_CoralKernelTest_has_target_tag

cmt_local_tagfile_test_unit_CoralKernel_CoralKernelTest = $(bin)$(CoralKernel_tag)_test_unit_CoralKernel_CoralKernelTest.make
cmt_final_setup_test_unit_CoralKernel_CoralKernelTest = $(bin)setup_test_unit_CoralKernel_CoralKernelTest.make
cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile = $(bin)test_unit_CoralKernel_CoralKernelTest.make

test_unit_CoralKernel_CoralKernelTest_extratags = -tag_add=target_test_unit_CoralKernel_CoralKernelTest

else

cmt_local_tagfile_test_unit_CoralKernel_CoralKernelTest = $(bin)$(CoralKernel_tag).make
cmt_final_setup_test_unit_CoralKernel_CoralKernelTest = $(bin)setup.make
cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile = $(bin)test_unit_CoralKernel_CoralKernelTest.make

endif

not_test_unit_CoralKernel_CoralKernelTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralKernel_CoralKernelTestdirs :
	@if test ! -d $(bin)test_unit_CoralKernel_CoralKernelTest; then $(mkdir) -p $(bin)test_unit_CoralKernel_CoralKernelTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralKernel_CoralKernelTest
else
test_unit_CoralKernel_CoralKernelTestdirs : ;
endif

ifdef cmt_test_unit_CoralKernel_CoralKernelTest_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) : $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_CoralKernelTest.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_CoralKernelTest_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTest
else
$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) : $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_CoralKernelTest) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_CoralKernelTest) ] || \
	  $(not_test_unit_CoralKernel_CoralKernelTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_CoralKernelTest.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_CoralKernelTest_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) : $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_CoralKernelTest.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_CoralKernelTest.in -tag=$(tags) $(test_unit_CoralKernel_CoralKernelTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTest
else
$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) : $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralKernel_CoralKernelTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_CoralKernelTest) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_CoralKernelTest) ] || \
	  $(not_test_unit_CoralKernel_CoralKernelTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_CoralKernelTest.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_CoralKernelTest.in -tag=$(tags) $(test_unit_CoralKernel_CoralKernelTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_CoralKernelTest_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTest

test_unit_CoralKernel_CoralKernelTest :: test_unit_CoralKernel_CoralKernelTestcompile test_unit_CoralKernel_CoralKernelTestinstall ;

ifdef cmt_test_unit_CoralKernel_CoralKernelTest_has_prototypes

test_unit_CoralKernel_CoralKernelTestprototype : $(test_unit_CoralKernel_CoralKernelTestprototype_dependencies) $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) dirs test_unit_CoralKernel_CoralKernelTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralKernel_CoralKernelTestcompile : test_unit_CoralKernel_CoralKernelTestprototype

endif

test_unit_CoralKernel_CoralKernelTestcompile : $(test_unit_CoralKernel_CoralKernelTestcompile_dependencies) $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) dirs test_unit_CoralKernel_CoralKernelTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralKernel_CoralKernelTestclean ;

test_unit_CoralKernel_CoralKernelTestclean :: $(test_unit_CoralKernel_CoralKernelTestclean_dependencies) ##$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) test_unit_CoralKernel_CoralKernelTestclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $(bin)test_unit_CoralKernel_CoralKernelTest_dependencies.make

install :: test_unit_CoralKernel_CoralKernelTestinstall ;

test_unit_CoralKernel_CoralKernelTestinstall :: test_unit_CoralKernel_CoralKernelTestcompile $(test_unit_CoralKernel_CoralKernelTest_dependencies) $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralKernel_CoralKernelTestuninstall

$(foreach d,$(test_unit_CoralKernel_CoralKernelTest_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralKernel_CoralKernelTestuninstall))

test_unit_CoralKernel_CoralKernelTestuninstall : $(test_unit_CoralKernel_CoralKernelTestuninstall_dependencies) ##$(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_CoralKernelTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralKernel_CoralKernelTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralKernel_CoralKernelTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralKernel_CoralKernelTest done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralKernel_ExternalPluginManager_has_no_target_tag = 1
cmt_test_unit_CoralKernel_ExternalPluginManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralKernel_ExternalPluginManager_has_target_tag

cmt_local_tagfile_test_unit_CoralKernel_ExternalPluginManager = $(bin)$(CoralKernel_tag)_test_unit_CoralKernel_ExternalPluginManager.make
cmt_final_setup_test_unit_CoralKernel_ExternalPluginManager = $(bin)setup_test_unit_CoralKernel_ExternalPluginManager.make
cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile = $(bin)test_unit_CoralKernel_ExternalPluginManager.make

test_unit_CoralKernel_ExternalPluginManager_extratags = -tag_add=target_test_unit_CoralKernel_ExternalPluginManager

else

cmt_local_tagfile_test_unit_CoralKernel_ExternalPluginManager = $(bin)$(CoralKernel_tag).make
cmt_final_setup_test_unit_CoralKernel_ExternalPluginManager = $(bin)setup.make
cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile = $(bin)test_unit_CoralKernel_ExternalPluginManager.make

endif

not_test_unit_CoralKernel_ExternalPluginManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralKernel_ExternalPluginManagerdirs :
	@if test ! -d $(bin)test_unit_CoralKernel_ExternalPluginManager; then $(mkdir) -p $(bin)test_unit_CoralKernel_ExternalPluginManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralKernel_ExternalPluginManager
else
test_unit_CoralKernel_ExternalPluginManagerdirs : ;
endif

ifdef cmt_test_unit_CoralKernel_ExternalPluginManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) : $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_ExternalPluginManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_ExternalPluginManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManager
else
$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) : $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_ExternalPluginManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_ExternalPluginManager) ] || \
	  $(not_test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_ExternalPluginManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_ExternalPluginManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) : $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_ExternalPluginManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_ExternalPluginManager.in -tag=$(tags) $(test_unit_CoralKernel_ExternalPluginManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManager
else
$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) : $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralKernel_ExternalPluginManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_ExternalPluginManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_ExternalPluginManager) ] || \
	  $(not_test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_ExternalPluginManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_ExternalPluginManager.in -tag=$(tags) $(test_unit_CoralKernel_ExternalPluginManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_ExternalPluginManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManager

test_unit_CoralKernel_ExternalPluginManager :: test_unit_CoralKernel_ExternalPluginManagercompile test_unit_CoralKernel_ExternalPluginManagerinstall ;

ifdef cmt_test_unit_CoralKernel_ExternalPluginManager_has_prototypes

test_unit_CoralKernel_ExternalPluginManagerprototype : $(test_unit_CoralKernel_ExternalPluginManagerprototype_dependencies) $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) dirs test_unit_CoralKernel_ExternalPluginManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralKernel_ExternalPluginManagercompile : test_unit_CoralKernel_ExternalPluginManagerprototype

endif

test_unit_CoralKernel_ExternalPluginManagercompile : $(test_unit_CoralKernel_ExternalPluginManagercompile_dependencies) $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) dirs test_unit_CoralKernel_ExternalPluginManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralKernel_ExternalPluginManagerclean ;

test_unit_CoralKernel_ExternalPluginManagerclean :: $(test_unit_CoralKernel_ExternalPluginManagerclean_dependencies) ##$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) test_unit_CoralKernel_ExternalPluginManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $(bin)test_unit_CoralKernel_ExternalPluginManager_dependencies.make

install :: test_unit_CoralKernel_ExternalPluginManagerinstall ;

test_unit_CoralKernel_ExternalPluginManagerinstall :: test_unit_CoralKernel_ExternalPluginManagercompile $(test_unit_CoralKernel_ExternalPluginManager_dependencies) $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralKernel_ExternalPluginManageruninstall

$(foreach d,$(test_unit_CoralKernel_ExternalPluginManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralKernel_ExternalPluginManageruninstall))

test_unit_CoralKernel_ExternalPluginManageruninstall : $(test_unit_CoralKernel_ExternalPluginManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_ExternalPluginManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralKernel_ExternalPluginManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralKernel_ExternalPluginManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralKernel_ExternalPluginManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralKernel_PluginList_has_no_target_tag = 1
cmt_test_unit_CoralKernel_PluginList_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralKernel_PluginList_has_target_tag

cmt_local_tagfile_test_unit_CoralKernel_PluginList = $(bin)$(CoralKernel_tag)_test_unit_CoralKernel_PluginList.make
cmt_final_setup_test_unit_CoralKernel_PluginList = $(bin)setup_test_unit_CoralKernel_PluginList.make
cmt_local_test_unit_CoralKernel_PluginList_makefile = $(bin)test_unit_CoralKernel_PluginList.make

test_unit_CoralKernel_PluginList_extratags = -tag_add=target_test_unit_CoralKernel_PluginList

else

cmt_local_tagfile_test_unit_CoralKernel_PluginList = $(bin)$(CoralKernel_tag).make
cmt_final_setup_test_unit_CoralKernel_PluginList = $(bin)setup.make
cmt_local_test_unit_CoralKernel_PluginList_makefile = $(bin)test_unit_CoralKernel_PluginList.make

endif

not_test_unit_CoralKernel_PluginListcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralKernel_PluginListcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralKernel_PluginListdirs :
	@if test ! -d $(bin)test_unit_CoralKernel_PluginList; then $(mkdir) -p $(bin)test_unit_CoralKernel_PluginList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralKernel_PluginList
else
test_unit_CoralKernel_PluginListdirs : ;
endif

ifdef cmt_test_unit_CoralKernel_PluginList_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PluginList_makefile) : $(test_unit_CoralKernel_PluginListcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PluginList.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginList_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginList
else
$(cmt_local_test_unit_CoralKernel_PluginList_makefile) : $(test_unit_CoralKernel_PluginListcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PluginList) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PluginList) ] || \
	  $(not_test_unit_CoralKernel_PluginListcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PluginList.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginList_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PluginList_makefile) : $(test_unit_CoralKernel_PluginListcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PluginList.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PluginList.in -tag=$(tags) $(test_unit_CoralKernel_PluginList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginList
else
$(cmt_local_test_unit_CoralKernel_PluginList_makefile) : $(test_unit_CoralKernel_PluginListcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralKernel_PluginList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PluginList) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PluginList) ] || \
	  $(not_test_unit_CoralKernel_PluginListcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PluginList.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PluginList.in -tag=$(tags) $(test_unit_CoralKernel_PluginList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginList_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginList

test_unit_CoralKernel_PluginList :: test_unit_CoralKernel_PluginListcompile test_unit_CoralKernel_PluginListinstall ;

ifdef cmt_test_unit_CoralKernel_PluginList_has_prototypes

test_unit_CoralKernel_PluginListprototype : $(test_unit_CoralKernel_PluginListprototype_dependencies) $(cmt_local_test_unit_CoralKernel_PluginList_makefile) dirs test_unit_CoralKernel_PluginListdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralKernel_PluginListcompile : test_unit_CoralKernel_PluginListprototype

endif

test_unit_CoralKernel_PluginListcompile : $(test_unit_CoralKernel_PluginListcompile_dependencies) $(cmt_local_test_unit_CoralKernel_PluginList_makefile) dirs test_unit_CoralKernel_PluginListdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralKernel_PluginListclean ;

test_unit_CoralKernel_PluginListclean :: $(test_unit_CoralKernel_PluginListclean_dependencies) ##$(cmt_local_test_unit_CoralKernel_PluginList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) test_unit_CoralKernel_PluginListclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $(bin)test_unit_CoralKernel_PluginList_dependencies.make

install :: test_unit_CoralKernel_PluginListinstall ;

test_unit_CoralKernel_PluginListinstall :: test_unit_CoralKernel_PluginListcompile $(test_unit_CoralKernel_PluginList_dependencies) $(cmt_local_test_unit_CoralKernel_PluginList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralKernel_PluginListuninstall

$(foreach d,$(test_unit_CoralKernel_PluginList_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralKernel_PluginListuninstall))

test_unit_CoralKernel_PluginListuninstall : $(test_unit_CoralKernel_PluginListuninstall_dependencies) ##$(cmt_local_test_unit_CoralKernel_PluginList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralKernel_PluginListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralKernel_PluginList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralKernel_PluginList done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralKernel_PluginManager_has_no_target_tag = 1
cmt_test_unit_CoralKernel_PluginManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralKernel_PluginManager_has_target_tag

cmt_local_tagfile_test_unit_CoralKernel_PluginManager = $(bin)$(CoralKernel_tag)_test_unit_CoralKernel_PluginManager.make
cmt_final_setup_test_unit_CoralKernel_PluginManager = $(bin)setup_test_unit_CoralKernel_PluginManager.make
cmt_local_test_unit_CoralKernel_PluginManager_makefile = $(bin)test_unit_CoralKernel_PluginManager.make

test_unit_CoralKernel_PluginManager_extratags = -tag_add=target_test_unit_CoralKernel_PluginManager

else

cmt_local_tagfile_test_unit_CoralKernel_PluginManager = $(bin)$(CoralKernel_tag).make
cmt_final_setup_test_unit_CoralKernel_PluginManager = $(bin)setup.make
cmt_local_test_unit_CoralKernel_PluginManager_makefile = $(bin)test_unit_CoralKernel_PluginManager.make

endif

not_test_unit_CoralKernel_PluginManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralKernel_PluginManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralKernel_PluginManagerdirs :
	@if test ! -d $(bin)test_unit_CoralKernel_PluginManager; then $(mkdir) -p $(bin)test_unit_CoralKernel_PluginManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralKernel_PluginManager
else
test_unit_CoralKernel_PluginManagerdirs : ;
endif

ifdef cmt_test_unit_CoralKernel_PluginManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) : $(test_unit_CoralKernel_PluginManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PluginManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManager
else
$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) : $(test_unit_CoralKernel_PluginManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PluginManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PluginManager) ] || \
	  $(not_test_unit_CoralKernel_PluginManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PluginManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) : $(test_unit_CoralKernel_PluginManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PluginManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PluginManager.in -tag=$(tags) $(test_unit_CoralKernel_PluginManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManager
else
$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) : $(test_unit_CoralKernel_PluginManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralKernel_PluginManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PluginManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PluginManager) ] || \
	  $(not_test_unit_CoralKernel_PluginManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PluginManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PluginManager.in -tag=$(tags) $(test_unit_CoralKernel_PluginManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PluginManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManager

test_unit_CoralKernel_PluginManager :: test_unit_CoralKernel_PluginManagercompile test_unit_CoralKernel_PluginManagerinstall ;

ifdef cmt_test_unit_CoralKernel_PluginManager_has_prototypes

test_unit_CoralKernel_PluginManagerprototype : $(test_unit_CoralKernel_PluginManagerprototype_dependencies) $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) dirs test_unit_CoralKernel_PluginManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralKernel_PluginManagercompile : test_unit_CoralKernel_PluginManagerprototype

endif

test_unit_CoralKernel_PluginManagercompile : $(test_unit_CoralKernel_PluginManagercompile_dependencies) $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) dirs test_unit_CoralKernel_PluginManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralKernel_PluginManagerclean ;

test_unit_CoralKernel_PluginManagerclean :: $(test_unit_CoralKernel_PluginManagerclean_dependencies) ##$(cmt_local_test_unit_CoralKernel_PluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) test_unit_CoralKernel_PluginManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $(bin)test_unit_CoralKernel_PluginManager_dependencies.make

install :: test_unit_CoralKernel_PluginManagerinstall ;

test_unit_CoralKernel_PluginManagerinstall :: test_unit_CoralKernel_PluginManagercompile $(test_unit_CoralKernel_PluginManager_dependencies) $(cmt_local_test_unit_CoralKernel_PluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralKernel_PluginManageruninstall

$(foreach d,$(test_unit_CoralKernel_PluginManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralKernel_PluginManageruninstall))

test_unit_CoralKernel_PluginManageruninstall : $(test_unit_CoralKernel_PluginManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralKernel_PluginManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PluginManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralKernel_PluginManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralKernel_PluginManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralKernel_PluginManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralKernel_PropertyManager_has_no_target_tag = 1
cmt_test_unit_CoralKernel_PropertyManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralKernel_PropertyManager_has_target_tag

cmt_local_tagfile_test_unit_CoralKernel_PropertyManager = $(bin)$(CoralKernel_tag)_test_unit_CoralKernel_PropertyManager.make
cmt_final_setup_test_unit_CoralKernel_PropertyManager = $(bin)setup_test_unit_CoralKernel_PropertyManager.make
cmt_local_test_unit_CoralKernel_PropertyManager_makefile = $(bin)test_unit_CoralKernel_PropertyManager.make

test_unit_CoralKernel_PropertyManager_extratags = -tag_add=target_test_unit_CoralKernel_PropertyManager

else

cmt_local_tagfile_test_unit_CoralKernel_PropertyManager = $(bin)$(CoralKernel_tag).make
cmt_final_setup_test_unit_CoralKernel_PropertyManager = $(bin)setup.make
cmt_local_test_unit_CoralKernel_PropertyManager_makefile = $(bin)test_unit_CoralKernel_PropertyManager.make

endif

not_test_unit_CoralKernel_PropertyManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralKernel_PropertyManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralKernel_PropertyManagerdirs :
	@if test ! -d $(bin)test_unit_CoralKernel_PropertyManager; then $(mkdir) -p $(bin)test_unit_CoralKernel_PropertyManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralKernel_PropertyManager
else
test_unit_CoralKernel_PropertyManagerdirs : ;
endif

ifdef cmt_test_unit_CoralKernel_PropertyManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) : $(test_unit_CoralKernel_PropertyManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PropertyManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PropertyManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManager
else
$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) : $(test_unit_CoralKernel_PropertyManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PropertyManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PropertyManager) ] || \
	  $(not_test_unit_CoralKernel_PropertyManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PropertyManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PropertyManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) : $(test_unit_CoralKernel_PropertyManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralKernel_PropertyManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PropertyManager.in -tag=$(tags) $(test_unit_CoralKernel_PropertyManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManager
else
$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) : $(test_unit_CoralKernel_PropertyManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralKernel_PropertyManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralKernel_PropertyManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralKernel_PropertyManager) ] || \
	  $(not_test_unit_CoralKernel_PropertyManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralKernel_PropertyManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralKernel_PropertyManager.in -tag=$(tags) $(test_unit_CoralKernel_PropertyManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralKernel_PropertyManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManager

test_unit_CoralKernel_PropertyManager :: test_unit_CoralKernel_PropertyManagercompile test_unit_CoralKernel_PropertyManagerinstall ;

ifdef cmt_test_unit_CoralKernel_PropertyManager_has_prototypes

test_unit_CoralKernel_PropertyManagerprototype : $(test_unit_CoralKernel_PropertyManagerprototype_dependencies) $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) dirs test_unit_CoralKernel_PropertyManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralKernel_PropertyManagercompile : test_unit_CoralKernel_PropertyManagerprototype

endif

test_unit_CoralKernel_PropertyManagercompile : $(test_unit_CoralKernel_PropertyManagercompile_dependencies) $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) dirs test_unit_CoralKernel_PropertyManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralKernel_PropertyManagerclean ;

test_unit_CoralKernel_PropertyManagerclean :: $(test_unit_CoralKernel_PropertyManagerclean_dependencies) ##$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) test_unit_CoralKernel_PropertyManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $(bin)test_unit_CoralKernel_PropertyManager_dependencies.make

install :: test_unit_CoralKernel_PropertyManagerinstall ;

test_unit_CoralKernel_PropertyManagerinstall :: test_unit_CoralKernel_PropertyManagercompile $(test_unit_CoralKernel_PropertyManager_dependencies) $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralKernel_PropertyManageruninstall

$(foreach d,$(test_unit_CoralKernel_PropertyManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralKernel_PropertyManageruninstall))

test_unit_CoralKernel_PropertyManageruninstall : $(test_unit_CoralKernel_PropertyManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralKernel_PropertyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralKernel_PropertyManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralKernel_PropertyManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralKernel_PropertyManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralKernel_PropertyManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralKernel_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralKernel_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralKernel_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralKernel_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralKernel_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralKernel_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralKernel_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralKernel_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(CoralKernel_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoralKernel_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoralKernel_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralKernel_tag).make
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
