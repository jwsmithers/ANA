
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoolKernel_tag = $(tag)

#cmt_local_tagfile = $(CoolKernel_tag).make
cmt_local_tagfile = $(bin)$(CoolKernel_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoolKernelsetup.make
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

cmt_lcg_CoolKernel_has_no_target_tag = 1
cmt_lcg_CoolKernel_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoolKernel_has_target_tag

cmt_local_tagfile_lcg_CoolKernel = $(bin)$(CoolKernel_tag)_lcg_CoolKernel.make
cmt_final_setup_lcg_CoolKernel = $(bin)setup_lcg_CoolKernel.make
cmt_local_lcg_CoolKernel_makefile = $(bin)lcg_CoolKernel.make

lcg_CoolKernel_extratags = -tag_add=target_lcg_CoolKernel

else

cmt_local_tagfile_lcg_CoolKernel = $(bin)$(CoolKernel_tag).make
cmt_final_setup_lcg_CoolKernel = $(bin)setup.make
cmt_local_lcg_CoolKernel_makefile = $(bin)lcg_CoolKernel.make

endif

not_lcg_CoolKernelcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoolKernelcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoolKerneldirs :
	@if test ! -d $(bin)lcg_CoolKernel; then $(mkdir) -p $(bin)lcg_CoolKernel; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoolKernel
else
lcg_CoolKerneldirs : ;
endif

ifdef cmt_lcg_CoolKernel_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoolKernel_makefile) : $(lcg_CoolKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoolKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoolKernel_extratags) build constituent_config -out=$(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernel
else
$(cmt_local_lcg_CoolKernel_makefile) : $(lcg_CoolKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoolKernel) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoolKernel) ] || \
	  $(not_lcg_CoolKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoolKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoolKernel_extratags) build constituent_config -out=$(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernel; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoolKernel_makefile) : $(lcg_CoolKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoolKernel.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoolKernel.in -tag=$(tags) $(lcg_CoolKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernel
else
$(cmt_local_lcg_CoolKernel_makefile) : $(lcg_CoolKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoolKernel.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoolKernel) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoolKernel) ] || \
	  $(not_lcg_CoolKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoolKernel.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoolKernel.in -tag=$(tags) $(lcg_CoolKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernel; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoolKernel_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernel

lcg_CoolKernel :: lcg_CoolKernelcompile lcg_CoolKernelinstall ;

ifdef cmt_lcg_CoolKernel_has_prototypes

lcg_CoolKernelprototype : $(lcg_CoolKernelprototype_dependencies) $(cmt_local_lcg_CoolKernel_makefile) dirs lcg_CoolKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoolKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoolKernelcompile : lcg_CoolKernelprototype

endif

lcg_CoolKernelcompile : $(lcg_CoolKernelcompile_dependencies) $(cmt_local_lcg_CoolKernel_makefile) dirs lcg_CoolKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoolKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoolKernelclean ;

lcg_CoolKernelclean :: $(lcg_CoolKernelclean_dependencies) ##$(cmt_local_lcg_CoolKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoolKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) lcg_CoolKernelclean

##	  /bin/rm -f $(cmt_local_lcg_CoolKernel_makefile) $(bin)lcg_CoolKernel_dependencies.make

install :: lcg_CoolKernelinstall ;

lcg_CoolKernelinstall :: lcg_CoolKernelcompile $(lcg_CoolKernel_dependencies) $(cmt_local_lcg_CoolKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoolKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoolKerneluninstall

$(foreach d,$(lcg_CoolKernel_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoolKerneluninstall))

lcg_CoolKerneluninstall : $(lcg_CoolKerneluninstall_dependencies) ##$(cmt_local_lcg_CoolKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoolKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoolKernel_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoolKerneluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoolKernel"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoolKernel done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_CoolKernel_FolderSpec_has_no_target_tag = 1
cmt_test_CoolKernel_FolderSpec_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_CoolKernel_FolderSpec_has_target_tag

cmt_local_tagfile_test_CoolKernel_FolderSpec = $(bin)$(CoolKernel_tag)_test_CoolKernel_FolderSpec.make
cmt_final_setup_test_CoolKernel_FolderSpec = $(bin)setup_test_CoolKernel_FolderSpec.make
cmt_local_test_CoolKernel_FolderSpec_makefile = $(bin)test_CoolKernel_FolderSpec.make

test_CoolKernel_FolderSpec_extratags = -tag_add=target_test_CoolKernel_FolderSpec

else

cmt_local_tagfile_test_CoolKernel_FolderSpec = $(bin)$(CoolKernel_tag).make
cmt_final_setup_test_CoolKernel_FolderSpec = $(bin)setup.make
cmt_local_test_CoolKernel_FolderSpec_makefile = $(bin)test_CoolKernel_FolderSpec.make

endif

not_test_CoolKernel_FolderSpeccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_CoolKernel_FolderSpeccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_CoolKernel_FolderSpecdirs :
	@if test ! -d $(bin)test_CoolKernel_FolderSpec; then $(mkdir) -p $(bin)test_CoolKernel_FolderSpec; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_CoolKernel_FolderSpec
else
test_CoolKernel_FolderSpecdirs : ;
endif

ifdef cmt_test_CoolKernel_FolderSpec_has_target_tag

ifndef QUICK
$(cmt_local_test_CoolKernel_FolderSpec_makefile) : $(test_CoolKernel_FolderSpeccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_FolderSpec.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_FolderSpec_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpec
else
$(cmt_local_test_CoolKernel_FolderSpec_makefile) : $(test_CoolKernel_FolderSpeccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_FolderSpec) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_FolderSpec) ] || \
	  $(not_test_CoolKernel_FolderSpeccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_FolderSpec.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_FolderSpec_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpec; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_CoolKernel_FolderSpec_makefile) : $(test_CoolKernel_FolderSpeccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_FolderSpec.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_FolderSpec.in -tag=$(tags) $(test_CoolKernel_FolderSpec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpec
else
$(cmt_local_test_CoolKernel_FolderSpec_makefile) : $(test_CoolKernel_FolderSpeccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_CoolKernel_FolderSpec.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_FolderSpec) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_FolderSpec) ] || \
	  $(not_test_CoolKernel_FolderSpeccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_FolderSpec.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_FolderSpec.in -tag=$(tags) $(test_CoolKernel_FolderSpec_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpec; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_FolderSpec_extratags) build constituent_makefile -out=$(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpec

test_CoolKernel_FolderSpec :: test_CoolKernel_FolderSpeccompile test_CoolKernel_FolderSpecinstall ;

ifdef cmt_test_CoolKernel_FolderSpec_has_prototypes

test_CoolKernel_FolderSpecprototype : $(test_CoolKernel_FolderSpecprototype_dependencies) $(cmt_local_test_CoolKernel_FolderSpec_makefile) dirs test_CoolKernel_FolderSpecdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_FolderSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_CoolKernel_FolderSpeccompile : test_CoolKernel_FolderSpecprototype

endif

test_CoolKernel_FolderSpeccompile : $(test_CoolKernel_FolderSpeccompile_dependencies) $(cmt_local_test_CoolKernel_FolderSpec_makefile) dirs test_CoolKernel_FolderSpecdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_FolderSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_CoolKernel_FolderSpecclean ;

test_CoolKernel_FolderSpecclean :: $(test_CoolKernel_FolderSpecclean_dependencies) ##$(cmt_local_test_CoolKernel_FolderSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_FolderSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) test_CoolKernel_FolderSpecclean

##	  /bin/rm -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $(bin)test_CoolKernel_FolderSpec_dependencies.make

install :: test_CoolKernel_FolderSpecinstall ;

test_CoolKernel_FolderSpecinstall :: test_CoolKernel_FolderSpeccompile $(test_CoolKernel_FolderSpec_dependencies) $(cmt_local_test_CoolKernel_FolderSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_FolderSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_CoolKernel_FolderSpecuninstall

$(foreach d,$(test_CoolKernel_FolderSpec_dependencies),$(eval $(d)uninstall_dependencies += test_CoolKernel_FolderSpecuninstall))

test_CoolKernel_FolderSpecuninstall : $(test_CoolKernel_FolderSpecuninstall_dependencies) ##$(cmt_local_test_CoolKernel_FolderSpec_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_FolderSpec_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_FolderSpec_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_CoolKernel_FolderSpecuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_CoolKernel_FolderSpec"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_CoolKernel_FolderSpec done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_CoolKernel_Record_has_no_target_tag = 1
cmt_test_CoolKernel_Record_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_CoolKernel_Record_has_target_tag

cmt_local_tagfile_test_CoolKernel_Record = $(bin)$(CoolKernel_tag)_test_CoolKernel_Record.make
cmt_final_setup_test_CoolKernel_Record = $(bin)setup_test_CoolKernel_Record.make
cmt_local_test_CoolKernel_Record_makefile = $(bin)test_CoolKernel_Record.make

test_CoolKernel_Record_extratags = -tag_add=target_test_CoolKernel_Record

else

cmt_local_tagfile_test_CoolKernel_Record = $(bin)$(CoolKernel_tag).make
cmt_final_setup_test_CoolKernel_Record = $(bin)setup.make
cmt_local_test_CoolKernel_Record_makefile = $(bin)test_CoolKernel_Record.make

endif

not_test_CoolKernel_Recordcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_CoolKernel_Recordcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_CoolKernel_Recorddirs :
	@if test ! -d $(bin)test_CoolKernel_Record; then $(mkdir) -p $(bin)test_CoolKernel_Record; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_CoolKernel_Record
else
test_CoolKernel_Recorddirs : ;
endif

ifdef cmt_test_CoolKernel_Record_has_target_tag

ifndef QUICK
$(cmt_local_test_CoolKernel_Record_makefile) : $(test_CoolKernel_Recordcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_Record.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_Record_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Record
else
$(cmt_local_test_CoolKernel_Record_makefile) : $(test_CoolKernel_Recordcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_Record) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_Record) ] || \
	  $(not_test_CoolKernel_Recordcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_Record.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_Record_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Record; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_CoolKernel_Record_makefile) : $(test_CoolKernel_Recordcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_Record.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_Record.in -tag=$(tags) $(test_CoolKernel_Record_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Record
else
$(cmt_local_test_CoolKernel_Record_makefile) : $(test_CoolKernel_Recordcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_CoolKernel_Record.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_Record) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_Record) ] || \
	  $(not_test_CoolKernel_Recordcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_Record.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_Record.in -tag=$(tags) $(test_CoolKernel_Record_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Record; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_Record_extratags) build constituent_makefile -out=$(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Record

test_CoolKernel_Record :: test_CoolKernel_Recordcompile test_CoolKernel_Recordinstall ;

ifdef cmt_test_CoolKernel_Record_has_prototypes

test_CoolKernel_Recordprototype : $(test_CoolKernel_Recordprototype_dependencies) $(cmt_local_test_CoolKernel_Record_makefile) dirs test_CoolKernel_Recorddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_Record_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_CoolKernel_Recordcompile : test_CoolKernel_Recordprototype

endif

test_CoolKernel_Recordcompile : $(test_CoolKernel_Recordcompile_dependencies) $(cmt_local_test_CoolKernel_Record_makefile) dirs test_CoolKernel_Recorddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_Record_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_CoolKernel_Recordclean ;

test_CoolKernel_Recordclean :: $(test_CoolKernel_Recordclean_dependencies) ##$(cmt_local_test_CoolKernel_Record_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_Record_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) test_CoolKernel_Recordclean

##	  /bin/rm -f $(cmt_local_test_CoolKernel_Record_makefile) $(bin)test_CoolKernel_Record_dependencies.make

install :: test_CoolKernel_Recordinstall ;

test_CoolKernel_Recordinstall :: test_CoolKernel_Recordcompile $(test_CoolKernel_Record_dependencies) $(cmt_local_test_CoolKernel_Record_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_Record_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_CoolKernel_Recorduninstall

$(foreach d,$(test_CoolKernel_Record_dependencies),$(eval $(d)uninstall_dependencies += test_CoolKernel_Recorduninstall))

test_CoolKernel_Recorduninstall : $(test_CoolKernel_Recorduninstall_dependencies) ##$(cmt_local_test_CoolKernel_Record_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_Record_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_Record_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_CoolKernel_Recorduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_CoolKernel_Record"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_CoolKernel_Record done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_CoolKernel_RecordAdapter_has_no_target_tag = 1
cmt_test_CoolKernel_RecordAdapter_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_CoolKernel_RecordAdapter_has_target_tag

cmt_local_tagfile_test_CoolKernel_RecordAdapter = $(bin)$(CoolKernel_tag)_test_CoolKernel_RecordAdapter.make
cmt_final_setup_test_CoolKernel_RecordAdapter = $(bin)setup_test_CoolKernel_RecordAdapter.make
cmt_local_test_CoolKernel_RecordAdapter_makefile = $(bin)test_CoolKernel_RecordAdapter.make

test_CoolKernel_RecordAdapter_extratags = -tag_add=target_test_CoolKernel_RecordAdapter

else

cmt_local_tagfile_test_CoolKernel_RecordAdapter = $(bin)$(CoolKernel_tag).make
cmt_final_setup_test_CoolKernel_RecordAdapter = $(bin)setup.make
cmt_local_test_CoolKernel_RecordAdapter_makefile = $(bin)test_CoolKernel_RecordAdapter.make

endif

not_test_CoolKernel_RecordAdaptercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_CoolKernel_RecordAdaptercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_CoolKernel_RecordAdapterdirs :
	@if test ! -d $(bin)test_CoolKernel_RecordAdapter; then $(mkdir) -p $(bin)test_CoolKernel_RecordAdapter; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_CoolKernel_RecordAdapter
else
test_CoolKernel_RecordAdapterdirs : ;
endif

ifdef cmt_test_CoolKernel_RecordAdapter_has_target_tag

ifndef QUICK
$(cmt_local_test_CoolKernel_RecordAdapter_makefile) : $(test_CoolKernel_RecordAdaptercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_RecordAdapter.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordAdapter_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapter
else
$(cmt_local_test_CoolKernel_RecordAdapter_makefile) : $(test_CoolKernel_RecordAdaptercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_RecordAdapter) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_RecordAdapter) ] || \
	  $(not_test_CoolKernel_RecordAdaptercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_RecordAdapter.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordAdapter_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapter; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_CoolKernel_RecordAdapter_makefile) : $(test_CoolKernel_RecordAdaptercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_RecordAdapter.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_RecordAdapter.in -tag=$(tags) $(test_CoolKernel_RecordAdapter_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapter
else
$(cmt_local_test_CoolKernel_RecordAdapter_makefile) : $(test_CoolKernel_RecordAdaptercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_CoolKernel_RecordAdapter.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_RecordAdapter) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_RecordAdapter) ] || \
	  $(not_test_CoolKernel_RecordAdaptercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_RecordAdapter.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_RecordAdapter.in -tag=$(tags) $(test_CoolKernel_RecordAdapter_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapter; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordAdapter_extratags) build constituent_makefile -out=$(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapter

test_CoolKernel_RecordAdapter :: test_CoolKernel_RecordAdaptercompile test_CoolKernel_RecordAdapterinstall ;

ifdef cmt_test_CoolKernel_RecordAdapter_has_prototypes

test_CoolKernel_RecordAdapterprototype : $(test_CoolKernel_RecordAdapterprototype_dependencies) $(cmt_local_test_CoolKernel_RecordAdapter_makefile) dirs test_CoolKernel_RecordAdapterdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_CoolKernel_RecordAdaptercompile : test_CoolKernel_RecordAdapterprototype

endif

test_CoolKernel_RecordAdaptercompile : $(test_CoolKernel_RecordAdaptercompile_dependencies) $(cmt_local_test_CoolKernel_RecordAdapter_makefile) dirs test_CoolKernel_RecordAdapterdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_CoolKernel_RecordAdapterclean ;

test_CoolKernel_RecordAdapterclean :: $(test_CoolKernel_RecordAdapterclean_dependencies) ##$(cmt_local_test_CoolKernel_RecordAdapter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) test_CoolKernel_RecordAdapterclean

##	  /bin/rm -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $(bin)test_CoolKernel_RecordAdapter_dependencies.make

install :: test_CoolKernel_RecordAdapterinstall ;

test_CoolKernel_RecordAdapterinstall :: test_CoolKernel_RecordAdaptercompile $(test_CoolKernel_RecordAdapter_dependencies) $(cmt_local_test_CoolKernel_RecordAdapter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_CoolKernel_RecordAdapteruninstall

$(foreach d,$(test_CoolKernel_RecordAdapter_dependencies),$(eval $(d)uninstall_dependencies += test_CoolKernel_RecordAdapteruninstall))

test_CoolKernel_RecordAdapteruninstall : $(test_CoolKernel_RecordAdapteruninstall_dependencies) ##$(cmt_local_test_CoolKernel_RecordAdapter_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordAdapter_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_CoolKernel_RecordAdapteruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_CoolKernel_RecordAdapter"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_CoolKernel_RecordAdapter done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_CoolKernel_RecordSelection_has_no_target_tag = 1
cmt_test_CoolKernel_RecordSelection_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_CoolKernel_RecordSelection_has_target_tag

cmt_local_tagfile_test_CoolKernel_RecordSelection = $(bin)$(CoolKernel_tag)_test_CoolKernel_RecordSelection.make
cmt_final_setup_test_CoolKernel_RecordSelection = $(bin)setup_test_CoolKernel_RecordSelection.make
cmt_local_test_CoolKernel_RecordSelection_makefile = $(bin)test_CoolKernel_RecordSelection.make

test_CoolKernel_RecordSelection_extratags = -tag_add=target_test_CoolKernel_RecordSelection

else

cmt_local_tagfile_test_CoolKernel_RecordSelection = $(bin)$(CoolKernel_tag).make
cmt_final_setup_test_CoolKernel_RecordSelection = $(bin)setup.make
cmt_local_test_CoolKernel_RecordSelection_makefile = $(bin)test_CoolKernel_RecordSelection.make

endif

not_test_CoolKernel_RecordSelectioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_CoolKernel_RecordSelectioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_CoolKernel_RecordSelectiondirs :
	@if test ! -d $(bin)test_CoolKernel_RecordSelection; then $(mkdir) -p $(bin)test_CoolKernel_RecordSelection; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_CoolKernel_RecordSelection
else
test_CoolKernel_RecordSelectiondirs : ;
endif

ifdef cmt_test_CoolKernel_RecordSelection_has_target_tag

ifndef QUICK
$(cmt_local_test_CoolKernel_RecordSelection_makefile) : $(test_CoolKernel_RecordSelectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_RecordSelection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordSelection_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelection
else
$(cmt_local_test_CoolKernel_RecordSelection_makefile) : $(test_CoolKernel_RecordSelectioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_RecordSelection) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_RecordSelection) ] || \
	  $(not_test_CoolKernel_RecordSelectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_RecordSelection.make"; \
	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordSelection_extratags) build constituent_config -out=$(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelection; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_CoolKernel_RecordSelection_makefile) : $(test_CoolKernel_RecordSelectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_CoolKernel_RecordSelection.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_RecordSelection.in -tag=$(tags) $(test_CoolKernel_RecordSelection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelection
else
$(cmt_local_test_CoolKernel_RecordSelection_makefile) : $(test_CoolKernel_RecordSelectioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_CoolKernel_RecordSelection.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_CoolKernel_RecordSelection) ] || \
	  [ ! -f $(cmt_final_setup_test_CoolKernel_RecordSelection) ] || \
	  $(not_test_CoolKernel_RecordSelectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_CoolKernel_RecordSelection.make"; \
	  $(cmtexe) -f=$(bin)test_CoolKernel_RecordSelection.in -tag=$(tags) $(test_CoolKernel_RecordSelection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelection; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_CoolKernel_RecordSelection_extratags) build constituent_makefile -out=$(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelection

test_CoolKernel_RecordSelection :: test_CoolKernel_RecordSelectioncompile test_CoolKernel_RecordSelectioninstall ;

ifdef cmt_test_CoolKernel_RecordSelection_has_prototypes

test_CoolKernel_RecordSelectionprototype : $(test_CoolKernel_RecordSelectionprototype_dependencies) $(cmt_local_test_CoolKernel_RecordSelection_makefile) dirs test_CoolKernel_RecordSelectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_CoolKernel_RecordSelectioncompile : test_CoolKernel_RecordSelectionprototype

endif

test_CoolKernel_RecordSelectioncompile : $(test_CoolKernel_RecordSelectioncompile_dependencies) $(cmt_local_test_CoolKernel_RecordSelection_makefile) dirs test_CoolKernel_RecordSelectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_CoolKernel_RecordSelectionclean ;

test_CoolKernel_RecordSelectionclean :: $(test_CoolKernel_RecordSelectionclean_dependencies) ##$(cmt_local_test_CoolKernel_RecordSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_RecordSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) test_CoolKernel_RecordSelectionclean

##	  /bin/rm -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $(bin)test_CoolKernel_RecordSelection_dependencies.make

install :: test_CoolKernel_RecordSelectioninstall ;

test_CoolKernel_RecordSelectioninstall :: test_CoolKernel_RecordSelectioncompile $(test_CoolKernel_RecordSelection_dependencies) $(cmt_local_test_CoolKernel_RecordSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_CoolKernel_RecordSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_CoolKernel_RecordSelectionuninstall

$(foreach d,$(test_CoolKernel_RecordSelection_dependencies),$(eval $(d)uninstall_dependencies += test_CoolKernel_RecordSelectionuninstall))

test_CoolKernel_RecordSelectionuninstall : $(test_CoolKernel_RecordSelectionuninstall_dependencies) ##$(cmt_local_test_CoolKernel_RecordSelection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_CoolKernel_RecordSelection_makefile); then \
	  $(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_CoolKernel_RecordSelection_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_CoolKernel_RecordSelectionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_CoolKernel_RecordSelection"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_CoolKernel_RecordSelection done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoolKernel_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoolKernel_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoolKernel_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoolKernel_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoolKernel_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoolKernel_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoolKernel_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoolKernel_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(CoolKernel_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoolKernel_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoolKernel_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoolKernel_tag).make
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
