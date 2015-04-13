
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

Examples_tag = $(tag)

#cmt_local_tagfile = $(Examples_tag).make
cmt_local_tagfile = $(bin)$(Examples_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)Examplessetup.make
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

all_groups :: examples

examples :: $(examples_dependencies)  $(examples_pre_constituents) $(examples_constituents)  $(examples_post_constituents)
	$(echo) "examples ok."

#	@/bin/echo " examples ok."

clean :: allclean

examplesclean ::  $(examples_constituentsclean)
	$(echo) $(examples_constituentsclean)
	$(echo) "examplesclean ok."

#	@echo $(examples_constituentsclean)
#	@/bin/echo " examplesclean ok."

#-- end of group ------
#-- start of constituent_app_lib ------

cmt_example_ExampleBase_has_no_target_tag = 1
cmt_example_ExampleBase_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_ExampleBase_has_target_tag

cmt_local_tagfile_example_ExampleBase = $(bin)$(Examples_tag)_example_ExampleBase.make
cmt_final_setup_example_ExampleBase = $(bin)setup_example_ExampleBase.make
cmt_local_example_ExampleBase_makefile = $(bin)example_ExampleBase.make

example_ExampleBase_extratags = -tag_add=target_example_ExampleBase

else

cmt_local_tagfile_example_ExampleBase = $(bin)$(Examples_tag).make
cmt_final_setup_example_ExampleBase = $(bin)setup.make
cmt_local_example_ExampleBase_makefile = $(bin)example_ExampleBase.make

endif

not_example_ExampleBasecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_ExampleBasecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_ExampleBasedirs :
	@if test ! -d $(bin)example_ExampleBase; then $(mkdir) -p $(bin)example_ExampleBase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_ExampleBase
else
example_ExampleBasedirs : ;
endif

ifdef cmt_example_ExampleBase_has_target_tag

ifndef QUICK
$(cmt_local_example_ExampleBase_makefile) : $(example_ExampleBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_ExampleBase.make"; \
	  $(cmtexe) -tag=$(tags) $(example_ExampleBase_extratags) build constituent_config -out=$(cmt_local_example_ExampleBase_makefile) example_ExampleBase
else
$(cmt_local_example_ExampleBase_makefile) : $(example_ExampleBasecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_ExampleBase) ] || \
	  [ ! -f $(cmt_final_setup_example_ExampleBase) ] || \
	  $(not_example_ExampleBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_ExampleBase.make"; \
	  $(cmtexe) -tag=$(tags) $(example_ExampleBase_extratags) build constituent_config -out=$(cmt_local_example_ExampleBase_makefile) example_ExampleBase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_ExampleBase_makefile) : $(example_ExampleBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_ExampleBase.make"; \
	  $(cmtexe) -f=$(bin)example_ExampleBase.in -tag=$(tags) $(example_ExampleBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_ExampleBase_makefile) example_ExampleBase
else
$(cmt_local_example_ExampleBase_makefile) : $(example_ExampleBasecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_ExampleBase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_ExampleBase) ] || \
	  [ ! -f $(cmt_final_setup_example_ExampleBase) ] || \
	  $(not_example_ExampleBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_ExampleBase.make"; \
	  $(cmtexe) -f=$(bin)example_ExampleBase.in -tag=$(tags) $(example_ExampleBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_ExampleBase_makefile) example_ExampleBase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_ExampleBase_extratags) build constituent_makefile -out=$(cmt_local_example_ExampleBase_makefile) example_ExampleBase

example_ExampleBase :: example_ExampleBasecompile example_ExampleBaseinstall ;

ifdef cmt_example_ExampleBase_has_prototypes

example_ExampleBaseprototype : $(example_ExampleBaseprototype_dependencies) $(cmt_local_example_ExampleBase_makefile) dirs example_ExampleBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_ExampleBase_makefile); then \
	  $(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_ExampleBasecompile : example_ExampleBaseprototype

endif

example_ExampleBasecompile : $(example_ExampleBasecompile_dependencies) $(cmt_local_example_ExampleBase_makefile) dirs example_ExampleBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_ExampleBase_makefile); then \
	  $(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_ExampleBaseclean ;

example_ExampleBaseclean :: $(example_ExampleBaseclean_dependencies) ##$(cmt_local_example_ExampleBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_ExampleBase_makefile); then \
	  $(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_ExampleBase_makefile) example_ExampleBaseclean

##	  /bin/rm -f $(cmt_local_example_ExampleBase_makefile) $(bin)example_ExampleBase_dependencies.make

install :: example_ExampleBaseinstall ;

example_ExampleBaseinstall :: example_ExampleBasecompile $(example_ExampleBase_dependencies) $(cmt_local_example_ExampleBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_ExampleBase_makefile); then \
	  $(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_ExampleBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_ExampleBaseuninstall

$(foreach d,$(example_ExampleBase_dependencies),$(eval $(d)uninstall_dependencies += example_ExampleBaseuninstall))

example_ExampleBaseuninstall : $(example_ExampleBaseuninstall_dependencies) ##$(cmt_local_example_ExampleBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_ExampleBase_makefile); then \
	  $(MAKE) -f $(cmt_local_example_ExampleBase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_ExampleBase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_ExampleBaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_ExampleBase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_ExampleBase done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_DBAliases_has_no_target_tag = 1
cmt_example_Cool_DBAliases_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_DBAliases_has_target_tag

cmt_local_tagfile_example_Cool_DBAliases = $(bin)$(Examples_tag)_example_Cool_DBAliases.make
cmt_final_setup_example_Cool_DBAliases = $(bin)setup_example_Cool_DBAliases.make
cmt_local_example_Cool_DBAliases_makefile = $(bin)example_Cool_DBAliases.make

example_Cool_DBAliases_extratags = -tag_add=target_example_Cool_DBAliases

else

cmt_local_tagfile_example_Cool_DBAliases = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_DBAliases = $(bin)setup.make
cmt_local_example_Cool_DBAliases_makefile = $(bin)example_Cool_DBAliases.make

endif

not_example_Cool_DBAliasescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_DBAliasescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_DBAliasesdirs :
	@if test ! -d $(bin)example_Cool_DBAliases; then $(mkdir) -p $(bin)example_Cool_DBAliases; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_DBAliases
else
example_Cool_DBAliasesdirs : ;
endif

ifdef cmt_example_Cool_DBAliases_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_DBAliases_makefile) : $(example_Cool_DBAliasescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_DBAliases.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_DBAliases_extratags) build constituent_config -out=$(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliases
else
$(cmt_local_example_Cool_DBAliases_makefile) : $(example_Cool_DBAliasescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_DBAliases) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_DBAliases) ] || \
	  $(not_example_Cool_DBAliasescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_DBAliases.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_DBAliases_extratags) build constituent_config -out=$(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliases; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_DBAliases_makefile) : $(example_Cool_DBAliasescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_DBAliases.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_DBAliases.in -tag=$(tags) $(example_Cool_DBAliases_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliases
else
$(cmt_local_example_Cool_DBAliases_makefile) : $(example_Cool_DBAliasescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_DBAliases.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_DBAliases) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_DBAliases) ] || \
	  $(not_example_Cool_DBAliasescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_DBAliases.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_DBAliases.in -tag=$(tags) $(example_Cool_DBAliases_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliases; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_DBAliases_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliases

example_Cool_DBAliases :: example_Cool_DBAliasescompile example_Cool_DBAliasesinstall ;

ifdef cmt_example_Cool_DBAliases_has_prototypes

example_Cool_DBAliasesprototype : $(example_Cool_DBAliasesprototype_dependencies) $(cmt_local_example_Cool_DBAliases_makefile) dirs example_Cool_DBAliasesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_DBAliases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_DBAliasescompile : example_Cool_DBAliasesprototype

endif

example_Cool_DBAliasescompile : $(example_Cool_DBAliasescompile_dependencies) $(cmt_local_example_Cool_DBAliases_makefile) dirs example_Cool_DBAliasesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_DBAliases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_DBAliasesclean ;

example_Cool_DBAliasesclean :: $(example_Cool_DBAliasesclean_dependencies) ##$(cmt_local_example_Cool_DBAliases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_DBAliases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) example_Cool_DBAliasesclean

##	  /bin/rm -f $(cmt_local_example_Cool_DBAliases_makefile) $(bin)example_Cool_DBAliases_dependencies.make

install :: example_Cool_DBAliasesinstall ;

example_Cool_DBAliasesinstall :: example_Cool_DBAliasescompile $(example_Cool_DBAliases_dependencies) $(cmt_local_example_Cool_DBAliases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_DBAliases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_DBAliasesuninstall

$(foreach d,$(example_Cool_DBAliases_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_DBAliasesuninstall))

example_Cool_DBAliasesuninstall : $(example_Cool_DBAliasesuninstall_dependencies) ##$(cmt_local_example_Cool_DBAliases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_DBAliases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_DBAliases_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_DBAliasesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_DBAliases"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_DBAliases done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_MCBulkRetrieval_has_no_target_tag = 1
cmt_example_Cool_MCBulkRetrieval_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_MCBulkRetrieval_has_target_tag

cmt_local_tagfile_example_Cool_MCBulkRetrieval = $(bin)$(Examples_tag)_example_Cool_MCBulkRetrieval.make
cmt_final_setup_example_Cool_MCBulkRetrieval = $(bin)setup_example_Cool_MCBulkRetrieval.make
cmt_local_example_Cool_MCBulkRetrieval_makefile = $(bin)example_Cool_MCBulkRetrieval.make

example_Cool_MCBulkRetrieval_extratags = -tag_add=target_example_Cool_MCBulkRetrieval

else

cmt_local_tagfile_example_Cool_MCBulkRetrieval = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_MCBulkRetrieval = $(bin)setup.make
cmt_local_example_Cool_MCBulkRetrieval_makefile = $(bin)example_Cool_MCBulkRetrieval.make

endif

not_example_Cool_MCBulkRetrievalcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_MCBulkRetrievalcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_MCBulkRetrievaldirs :
	@if test ! -d $(bin)example_Cool_MCBulkRetrieval; then $(mkdir) -p $(bin)example_Cool_MCBulkRetrieval; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_MCBulkRetrieval
else
example_Cool_MCBulkRetrievaldirs : ;
endif

ifdef cmt_example_Cool_MCBulkRetrieval_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_MCBulkRetrieval_makefile) : $(example_Cool_MCBulkRetrievalcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_MCBulkRetrieval.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_MCBulkRetrieval_extratags) build constituent_config -out=$(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrieval
else
$(cmt_local_example_Cool_MCBulkRetrieval_makefile) : $(example_Cool_MCBulkRetrievalcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_MCBulkRetrieval) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_MCBulkRetrieval) ] || \
	  $(not_example_Cool_MCBulkRetrievalcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_MCBulkRetrieval.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_MCBulkRetrieval_extratags) build constituent_config -out=$(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrieval; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_MCBulkRetrieval_makefile) : $(example_Cool_MCBulkRetrievalcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_MCBulkRetrieval.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_MCBulkRetrieval.in -tag=$(tags) $(example_Cool_MCBulkRetrieval_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrieval
else
$(cmt_local_example_Cool_MCBulkRetrieval_makefile) : $(example_Cool_MCBulkRetrievalcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_MCBulkRetrieval.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_MCBulkRetrieval) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_MCBulkRetrieval) ] || \
	  $(not_example_Cool_MCBulkRetrievalcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_MCBulkRetrieval.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_MCBulkRetrieval.in -tag=$(tags) $(example_Cool_MCBulkRetrieval_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrieval; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_MCBulkRetrieval_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrieval

example_Cool_MCBulkRetrieval :: example_Cool_MCBulkRetrievalcompile example_Cool_MCBulkRetrievalinstall ;

ifdef cmt_example_Cool_MCBulkRetrieval_has_prototypes

example_Cool_MCBulkRetrievalprototype : $(example_Cool_MCBulkRetrievalprototype_dependencies) $(cmt_local_example_Cool_MCBulkRetrieval_makefile) dirs example_Cool_MCBulkRetrievaldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_MCBulkRetrievalcompile : example_Cool_MCBulkRetrievalprototype

endif

example_Cool_MCBulkRetrievalcompile : $(example_Cool_MCBulkRetrievalcompile_dependencies) $(cmt_local_example_Cool_MCBulkRetrieval_makefile) dirs example_Cool_MCBulkRetrievaldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_MCBulkRetrievalclean ;

example_Cool_MCBulkRetrievalclean :: $(example_Cool_MCBulkRetrievalclean_dependencies) ##$(cmt_local_example_Cool_MCBulkRetrieval_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) example_Cool_MCBulkRetrievalclean

##	  /bin/rm -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $(bin)example_Cool_MCBulkRetrieval_dependencies.make

install :: example_Cool_MCBulkRetrievalinstall ;

example_Cool_MCBulkRetrievalinstall :: example_Cool_MCBulkRetrievalcompile $(example_Cool_MCBulkRetrieval_dependencies) $(cmt_local_example_Cool_MCBulkRetrieval_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_MCBulkRetrievaluninstall

$(foreach d,$(example_Cool_MCBulkRetrieval_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_MCBulkRetrievaluninstall))

example_Cool_MCBulkRetrievaluninstall : $(example_Cool_MCBulkRetrievaluninstall_dependencies) ##$(cmt_local_example_Cool_MCBulkRetrieval_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MCBulkRetrieval_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_MCBulkRetrievaluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_MCBulkRetrieval"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_MCBulkRetrieval done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_MVstorage_has_no_target_tag = 1
cmt_example_Cool_MVstorage_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_MVstorage_has_target_tag

cmt_local_tagfile_example_Cool_MVstorage = $(bin)$(Examples_tag)_example_Cool_MVstorage.make
cmt_final_setup_example_Cool_MVstorage = $(bin)setup_example_Cool_MVstorage.make
cmt_local_example_Cool_MVstorage_makefile = $(bin)example_Cool_MVstorage.make

example_Cool_MVstorage_extratags = -tag_add=target_example_Cool_MVstorage

else

cmt_local_tagfile_example_Cool_MVstorage = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_MVstorage = $(bin)setup.make
cmt_local_example_Cool_MVstorage_makefile = $(bin)example_Cool_MVstorage.make

endif

not_example_Cool_MVstoragecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_MVstoragecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_MVstoragedirs :
	@if test ! -d $(bin)example_Cool_MVstorage; then $(mkdir) -p $(bin)example_Cool_MVstorage; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_MVstorage
else
example_Cool_MVstoragedirs : ;
endif

ifdef cmt_example_Cool_MVstorage_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_MVstorage_makefile) : $(example_Cool_MVstoragecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_MVstorage.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_MVstorage_extratags) build constituent_config -out=$(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorage
else
$(cmt_local_example_Cool_MVstorage_makefile) : $(example_Cool_MVstoragecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_MVstorage) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_MVstorage) ] || \
	  $(not_example_Cool_MVstoragecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_MVstorage.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_MVstorage_extratags) build constituent_config -out=$(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorage; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_MVstorage_makefile) : $(example_Cool_MVstoragecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_MVstorage.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_MVstorage.in -tag=$(tags) $(example_Cool_MVstorage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorage
else
$(cmt_local_example_Cool_MVstorage_makefile) : $(example_Cool_MVstoragecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_MVstorage.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_MVstorage) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_MVstorage) ] || \
	  $(not_example_Cool_MVstoragecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_MVstorage.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_MVstorage.in -tag=$(tags) $(example_Cool_MVstorage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorage; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_MVstorage_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorage

example_Cool_MVstorage :: example_Cool_MVstoragecompile example_Cool_MVstorageinstall ;

ifdef cmt_example_Cool_MVstorage_has_prototypes

example_Cool_MVstorageprototype : $(example_Cool_MVstorageprototype_dependencies) $(cmt_local_example_Cool_MVstorage_makefile) dirs example_Cool_MVstoragedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_MVstoragecompile : example_Cool_MVstorageprototype

endif

example_Cool_MVstoragecompile : $(example_Cool_MVstoragecompile_dependencies) $(cmt_local_example_Cool_MVstorage_makefile) dirs example_Cool_MVstoragedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_MVstorageclean ;

example_Cool_MVstorageclean :: $(example_Cool_MVstorageclean_dependencies) ##$(cmt_local_example_Cool_MVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_MVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) example_Cool_MVstorageclean

##	  /bin/rm -f $(cmt_local_example_Cool_MVstorage_makefile) $(bin)example_Cool_MVstorage_dependencies.make

install :: example_Cool_MVstorageinstall ;

example_Cool_MVstorageinstall :: example_Cool_MVstoragecompile $(example_Cool_MVstorage_dependencies) $(cmt_local_example_Cool_MVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_MVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_MVstorageuninstall

$(foreach d,$(example_Cool_MVstorage_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_MVstorageuninstall))

example_Cool_MVstorageuninstall : $(example_Cool_MVstorageuninstall_dependencies) ##$(cmt_local_example_Cool_MVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_MVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_MVstorage_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_MVstorageuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_MVstorage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_MVstorage done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_ReTag_has_no_target_tag = 1
cmt_example_Cool_ReTag_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_ReTag_has_target_tag

cmt_local_tagfile_example_Cool_ReTag = $(bin)$(Examples_tag)_example_Cool_ReTag.make
cmt_final_setup_example_Cool_ReTag = $(bin)setup_example_Cool_ReTag.make
cmt_local_example_Cool_ReTag_makefile = $(bin)example_Cool_ReTag.make

example_Cool_ReTag_extratags = -tag_add=target_example_Cool_ReTag

else

cmt_local_tagfile_example_Cool_ReTag = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_ReTag = $(bin)setup.make
cmt_local_example_Cool_ReTag_makefile = $(bin)example_Cool_ReTag.make

endif

not_example_Cool_ReTagcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_ReTagcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_ReTagdirs :
	@if test ! -d $(bin)example_Cool_ReTag; then $(mkdir) -p $(bin)example_Cool_ReTag; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_ReTag
else
example_Cool_ReTagdirs : ;
endif

ifdef cmt_example_Cool_ReTag_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_ReTag_makefile) : $(example_Cool_ReTagcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_ReTag.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_ReTag_extratags) build constituent_config -out=$(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTag
else
$(cmt_local_example_Cool_ReTag_makefile) : $(example_Cool_ReTagcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_ReTag) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_ReTag) ] || \
	  $(not_example_Cool_ReTagcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_ReTag.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_ReTag_extratags) build constituent_config -out=$(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTag; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_ReTag_makefile) : $(example_Cool_ReTagcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_ReTag.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_ReTag.in -tag=$(tags) $(example_Cool_ReTag_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTag
else
$(cmt_local_example_Cool_ReTag_makefile) : $(example_Cool_ReTagcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_ReTag.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_ReTag) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_ReTag) ] || \
	  $(not_example_Cool_ReTagcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_ReTag.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_ReTag.in -tag=$(tags) $(example_Cool_ReTag_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTag; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_ReTag_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTag

example_Cool_ReTag :: example_Cool_ReTagcompile example_Cool_ReTaginstall ;

ifdef cmt_example_Cool_ReTag_has_prototypes

example_Cool_ReTagprototype : $(example_Cool_ReTagprototype_dependencies) $(cmt_local_example_Cool_ReTag_makefile) dirs example_Cool_ReTagdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_ReTag_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_ReTagcompile : example_Cool_ReTagprototype

endif

example_Cool_ReTagcompile : $(example_Cool_ReTagcompile_dependencies) $(cmt_local_example_Cool_ReTag_makefile) dirs example_Cool_ReTagdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_ReTag_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_ReTagclean ;

example_Cool_ReTagclean :: $(example_Cool_ReTagclean_dependencies) ##$(cmt_local_example_Cool_ReTag_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_ReTag_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) example_Cool_ReTagclean

##	  /bin/rm -f $(cmt_local_example_Cool_ReTag_makefile) $(bin)example_Cool_ReTag_dependencies.make

install :: example_Cool_ReTaginstall ;

example_Cool_ReTaginstall :: example_Cool_ReTagcompile $(example_Cool_ReTag_dependencies) $(cmt_local_example_Cool_ReTag_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_ReTag_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_ReTaguninstall

$(foreach d,$(example_Cool_ReTag_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_ReTaguninstall))

example_Cool_ReTaguninstall : $(example_Cool_ReTaguninstall_dependencies) ##$(cmt_local_example_Cool_ReTag_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_ReTag_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_ReTag_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_ReTaguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_ReTag"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_ReTag done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_SharedConnection_has_no_target_tag = 1
cmt_example_Cool_SharedConnection_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_SharedConnection_has_target_tag

cmt_local_tagfile_example_Cool_SharedConnection = $(bin)$(Examples_tag)_example_Cool_SharedConnection.make
cmt_final_setup_example_Cool_SharedConnection = $(bin)setup_example_Cool_SharedConnection.make
cmt_local_example_Cool_SharedConnection_makefile = $(bin)example_Cool_SharedConnection.make

example_Cool_SharedConnection_extratags = -tag_add=target_example_Cool_SharedConnection

else

cmt_local_tagfile_example_Cool_SharedConnection = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_SharedConnection = $(bin)setup.make
cmt_local_example_Cool_SharedConnection_makefile = $(bin)example_Cool_SharedConnection.make

endif

not_example_Cool_SharedConnectioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_SharedConnectioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_SharedConnectiondirs :
	@if test ! -d $(bin)example_Cool_SharedConnection; then $(mkdir) -p $(bin)example_Cool_SharedConnection; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_SharedConnection
else
example_Cool_SharedConnectiondirs : ;
endif

ifdef cmt_example_Cool_SharedConnection_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_SharedConnection_makefile) : $(example_Cool_SharedConnectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SharedConnection.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection_extratags) build constituent_config -out=$(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnection
else
$(cmt_local_example_Cool_SharedConnection_makefile) : $(example_Cool_SharedConnectioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SharedConnection) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SharedConnection) ] || \
	  $(not_example_Cool_SharedConnectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SharedConnection.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection_extratags) build constituent_config -out=$(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnection; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_SharedConnection_makefile) : $(example_Cool_SharedConnectioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SharedConnection.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SharedConnection.in -tag=$(tags) $(example_Cool_SharedConnection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnection
else
$(cmt_local_example_Cool_SharedConnection_makefile) : $(example_Cool_SharedConnectioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_SharedConnection.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SharedConnection) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SharedConnection) ] || \
	  $(not_example_Cool_SharedConnectioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SharedConnection.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SharedConnection.in -tag=$(tags) $(example_Cool_SharedConnection_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnection; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnection

example_Cool_SharedConnection :: example_Cool_SharedConnectioncompile example_Cool_SharedConnectioninstall ;

ifdef cmt_example_Cool_SharedConnection_has_prototypes

example_Cool_SharedConnectionprototype : $(example_Cool_SharedConnectionprototype_dependencies) $(cmt_local_example_Cool_SharedConnection_makefile) dirs example_Cool_SharedConnectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_SharedConnectioncompile : example_Cool_SharedConnectionprototype

endif

example_Cool_SharedConnectioncompile : $(example_Cool_SharedConnectioncompile_dependencies) $(cmt_local_example_Cool_SharedConnection_makefile) dirs example_Cool_SharedConnectiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_SharedConnectionclean ;

example_Cool_SharedConnectionclean :: $(example_Cool_SharedConnectionclean_dependencies) ##$(cmt_local_example_Cool_SharedConnection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SharedConnection_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) example_Cool_SharedConnectionclean

##	  /bin/rm -f $(cmt_local_example_Cool_SharedConnection_makefile) $(bin)example_Cool_SharedConnection_dependencies.make

install :: example_Cool_SharedConnectioninstall ;

example_Cool_SharedConnectioninstall :: example_Cool_SharedConnectioncompile $(example_Cool_SharedConnection_dependencies) $(cmt_local_example_Cool_SharedConnection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_SharedConnectionuninstall

$(foreach d,$(example_Cool_SharedConnection_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_SharedConnectionuninstall))

example_Cool_SharedConnectionuninstall : $(example_Cool_SharedConnectionuninstall_dependencies) ##$(cmt_local_example_Cool_SharedConnection_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SharedConnection_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_SharedConnectionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_SharedConnection"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_SharedConnection done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_SharedConnection2_has_no_target_tag = 1
cmt_example_Cool_SharedConnection2_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_SharedConnection2_has_target_tag

cmt_local_tagfile_example_Cool_SharedConnection2 = $(bin)$(Examples_tag)_example_Cool_SharedConnection2.make
cmt_final_setup_example_Cool_SharedConnection2 = $(bin)setup_example_Cool_SharedConnection2.make
cmt_local_example_Cool_SharedConnection2_makefile = $(bin)example_Cool_SharedConnection2.make

example_Cool_SharedConnection2_extratags = -tag_add=target_example_Cool_SharedConnection2

else

cmt_local_tagfile_example_Cool_SharedConnection2 = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_SharedConnection2 = $(bin)setup.make
cmt_local_example_Cool_SharedConnection2_makefile = $(bin)example_Cool_SharedConnection2.make

endif

not_example_Cool_SharedConnection2compile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_SharedConnection2compile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_SharedConnection2dirs :
	@if test ! -d $(bin)example_Cool_SharedConnection2; then $(mkdir) -p $(bin)example_Cool_SharedConnection2; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_SharedConnection2
else
example_Cool_SharedConnection2dirs : ;
endif

ifdef cmt_example_Cool_SharedConnection2_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_SharedConnection2_makefile) : $(example_Cool_SharedConnection2compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SharedConnection2.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection2_extratags) build constituent_config -out=$(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2
else
$(cmt_local_example_Cool_SharedConnection2_makefile) : $(example_Cool_SharedConnection2compile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SharedConnection2) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SharedConnection2) ] || \
	  $(not_example_Cool_SharedConnection2compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SharedConnection2.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection2_extratags) build constituent_config -out=$(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_SharedConnection2_makefile) : $(example_Cool_SharedConnection2compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SharedConnection2.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SharedConnection2.in -tag=$(tags) $(example_Cool_SharedConnection2_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2
else
$(cmt_local_example_Cool_SharedConnection2_makefile) : $(example_Cool_SharedConnection2compile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_SharedConnection2.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SharedConnection2) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SharedConnection2) ] || \
	  $(not_example_Cool_SharedConnection2compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SharedConnection2.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SharedConnection2.in -tag=$(tags) $(example_Cool_SharedConnection2_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_SharedConnection2_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2

example_Cool_SharedConnection2 :: example_Cool_SharedConnection2compile example_Cool_SharedConnection2install ;

ifdef cmt_example_Cool_SharedConnection2_has_prototypes

example_Cool_SharedConnection2prototype : $(example_Cool_SharedConnection2prototype_dependencies) $(cmt_local_example_Cool_SharedConnection2_makefile) dirs example_Cool_SharedConnection2dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection2_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_SharedConnection2compile : example_Cool_SharedConnection2prototype

endif

example_Cool_SharedConnection2compile : $(example_Cool_SharedConnection2compile_dependencies) $(cmt_local_example_Cool_SharedConnection2_makefile) dirs example_Cool_SharedConnection2dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection2_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_SharedConnection2clean ;

example_Cool_SharedConnection2clean :: $(example_Cool_SharedConnection2clean_dependencies) ##$(cmt_local_example_Cool_SharedConnection2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SharedConnection2_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) example_Cool_SharedConnection2clean

##	  /bin/rm -f $(cmt_local_example_Cool_SharedConnection2_makefile) $(bin)example_Cool_SharedConnection2_dependencies.make

install :: example_Cool_SharedConnection2install ;

example_Cool_SharedConnection2install :: example_Cool_SharedConnection2compile $(example_Cool_SharedConnection2_dependencies) $(cmt_local_example_Cool_SharedConnection2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SharedConnection2_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_SharedConnection2uninstall

$(foreach d,$(example_Cool_SharedConnection2_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_SharedConnection2uninstall))

example_Cool_SharedConnection2uninstall : $(example_Cool_SharedConnection2uninstall_dependencies) ##$(cmt_local_example_Cool_SharedConnection2_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SharedConnection2_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SharedConnection2_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_SharedConnection2uninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_SharedConnection2"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_SharedConnection2 done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_SimpleRead_has_no_target_tag = 1
cmt_example_Cool_SimpleRead_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_SimpleRead_has_target_tag

cmt_local_tagfile_example_Cool_SimpleRead = $(bin)$(Examples_tag)_example_Cool_SimpleRead.make
cmt_final_setup_example_Cool_SimpleRead = $(bin)setup_example_Cool_SimpleRead.make
cmt_local_example_Cool_SimpleRead_makefile = $(bin)example_Cool_SimpleRead.make

example_Cool_SimpleRead_extratags = -tag_add=target_example_Cool_SimpleRead

else

cmt_local_tagfile_example_Cool_SimpleRead = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_SimpleRead = $(bin)setup.make
cmt_local_example_Cool_SimpleRead_makefile = $(bin)example_Cool_SimpleRead.make

endif

not_example_Cool_SimpleReadcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_SimpleReadcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_SimpleReaddirs :
	@if test ! -d $(bin)example_Cool_SimpleRead; then $(mkdir) -p $(bin)example_Cool_SimpleRead; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_SimpleRead
else
example_Cool_SimpleReaddirs : ;
endif

ifdef cmt_example_Cool_SimpleRead_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_SimpleRead_makefile) : $(example_Cool_SimpleReadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SimpleRead.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleRead_extratags) build constituent_config -out=$(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleRead
else
$(cmt_local_example_Cool_SimpleRead_makefile) : $(example_Cool_SimpleReadcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SimpleRead) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SimpleRead) ] || \
	  $(not_example_Cool_SimpleReadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SimpleRead.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleRead_extratags) build constituent_config -out=$(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleRead; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_SimpleRead_makefile) : $(example_Cool_SimpleReadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SimpleRead.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SimpleRead.in -tag=$(tags) $(example_Cool_SimpleRead_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleRead
else
$(cmt_local_example_Cool_SimpleRead_makefile) : $(example_Cool_SimpleReadcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_SimpleRead.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SimpleRead) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SimpleRead) ] || \
	  $(not_example_Cool_SimpleReadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SimpleRead.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SimpleRead.in -tag=$(tags) $(example_Cool_SimpleRead_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleRead; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleRead_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleRead

example_Cool_SimpleRead :: example_Cool_SimpleReadcompile example_Cool_SimpleReadinstall ;

ifdef cmt_example_Cool_SimpleRead_has_prototypes

example_Cool_SimpleReadprototype : $(example_Cool_SimpleReadprototype_dependencies) $(cmt_local_example_Cool_SimpleRead_makefile) dirs example_Cool_SimpleReaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleRead_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_SimpleReadcompile : example_Cool_SimpleReadprototype

endif

example_Cool_SimpleReadcompile : $(example_Cool_SimpleReadcompile_dependencies) $(cmt_local_example_Cool_SimpleRead_makefile) dirs example_Cool_SimpleReaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleRead_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_SimpleReadclean ;

example_Cool_SimpleReadclean :: $(example_Cool_SimpleReadclean_dependencies) ##$(cmt_local_example_Cool_SimpleRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SimpleRead_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) example_Cool_SimpleReadclean

##	  /bin/rm -f $(cmt_local_example_Cool_SimpleRead_makefile) $(bin)example_Cool_SimpleRead_dependencies.make

install :: example_Cool_SimpleReadinstall ;

example_Cool_SimpleReadinstall :: example_Cool_SimpleReadcompile $(example_Cool_SimpleRead_dependencies) $(cmt_local_example_Cool_SimpleRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleRead_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_SimpleReaduninstall

$(foreach d,$(example_Cool_SimpleRead_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_SimpleReaduninstall))

example_Cool_SimpleReaduninstall : $(example_Cool_SimpleReaduninstall_dependencies) ##$(cmt_local_example_Cool_SimpleRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SimpleRead_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleRead_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_SimpleReaduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_SimpleRead"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_SimpleRead done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_SimpleWrite_has_no_target_tag = 1
cmt_example_Cool_SimpleWrite_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_SimpleWrite_has_target_tag

cmt_local_tagfile_example_Cool_SimpleWrite = $(bin)$(Examples_tag)_example_Cool_SimpleWrite.make
cmt_final_setup_example_Cool_SimpleWrite = $(bin)setup_example_Cool_SimpleWrite.make
cmt_local_example_Cool_SimpleWrite_makefile = $(bin)example_Cool_SimpleWrite.make

example_Cool_SimpleWrite_extratags = -tag_add=target_example_Cool_SimpleWrite

else

cmt_local_tagfile_example_Cool_SimpleWrite = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_SimpleWrite = $(bin)setup.make
cmt_local_example_Cool_SimpleWrite_makefile = $(bin)example_Cool_SimpleWrite.make

endif

not_example_Cool_SimpleWritecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_SimpleWritecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_SimpleWritedirs :
	@if test ! -d $(bin)example_Cool_SimpleWrite; then $(mkdir) -p $(bin)example_Cool_SimpleWrite; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_SimpleWrite
else
example_Cool_SimpleWritedirs : ;
endif

ifdef cmt_example_Cool_SimpleWrite_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_SimpleWrite_makefile) : $(example_Cool_SimpleWritecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SimpleWrite.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleWrite_extratags) build constituent_config -out=$(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWrite
else
$(cmt_local_example_Cool_SimpleWrite_makefile) : $(example_Cool_SimpleWritecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SimpleWrite) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SimpleWrite) ] || \
	  $(not_example_Cool_SimpleWritecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SimpleWrite.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleWrite_extratags) build constituent_config -out=$(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWrite; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_SimpleWrite_makefile) : $(example_Cool_SimpleWritecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SimpleWrite.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SimpleWrite.in -tag=$(tags) $(example_Cool_SimpleWrite_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWrite
else
$(cmt_local_example_Cool_SimpleWrite_makefile) : $(example_Cool_SimpleWritecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_SimpleWrite.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SimpleWrite) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SimpleWrite) ] || \
	  $(not_example_Cool_SimpleWritecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SimpleWrite.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SimpleWrite.in -tag=$(tags) $(example_Cool_SimpleWrite_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWrite; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_SimpleWrite_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWrite

example_Cool_SimpleWrite :: example_Cool_SimpleWritecompile example_Cool_SimpleWriteinstall ;

ifdef cmt_example_Cool_SimpleWrite_has_prototypes

example_Cool_SimpleWriteprototype : $(example_Cool_SimpleWriteprototype_dependencies) $(cmt_local_example_Cool_SimpleWrite_makefile) dirs example_Cool_SimpleWritedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_SimpleWritecompile : example_Cool_SimpleWriteprototype

endif

example_Cool_SimpleWritecompile : $(example_Cool_SimpleWritecompile_dependencies) $(cmt_local_example_Cool_SimpleWrite_makefile) dirs example_Cool_SimpleWritedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_SimpleWriteclean ;

example_Cool_SimpleWriteclean :: $(example_Cool_SimpleWriteclean_dependencies) ##$(cmt_local_example_Cool_SimpleWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SimpleWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) example_Cool_SimpleWriteclean

##	  /bin/rm -f $(cmt_local_example_Cool_SimpleWrite_makefile) $(bin)example_Cool_SimpleWrite_dependencies.make

install :: example_Cool_SimpleWriteinstall ;

example_Cool_SimpleWriteinstall :: example_Cool_SimpleWritecompile $(example_Cool_SimpleWrite_dependencies) $(cmt_local_example_Cool_SimpleWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SimpleWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_SimpleWriteuninstall

$(foreach d,$(example_Cool_SimpleWrite_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_SimpleWriteuninstall))

example_Cool_SimpleWriteuninstall : $(example_Cool_SimpleWriteuninstall_dependencies) ##$(cmt_local_example_Cool_SimpleWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SimpleWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SimpleWrite_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_SimpleWriteuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_SimpleWrite"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_SimpleWrite done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_SVstorage_has_no_target_tag = 1
cmt_example_Cool_SVstorage_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_SVstorage_has_target_tag

cmt_local_tagfile_example_Cool_SVstorage = $(bin)$(Examples_tag)_example_Cool_SVstorage.make
cmt_final_setup_example_Cool_SVstorage = $(bin)setup_example_Cool_SVstorage.make
cmt_local_example_Cool_SVstorage_makefile = $(bin)example_Cool_SVstorage.make

example_Cool_SVstorage_extratags = -tag_add=target_example_Cool_SVstorage

else

cmt_local_tagfile_example_Cool_SVstorage = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_SVstorage = $(bin)setup.make
cmt_local_example_Cool_SVstorage_makefile = $(bin)example_Cool_SVstorage.make

endif

not_example_Cool_SVstoragecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_SVstoragecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_SVstoragedirs :
	@if test ! -d $(bin)example_Cool_SVstorage; then $(mkdir) -p $(bin)example_Cool_SVstorage; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_SVstorage
else
example_Cool_SVstoragedirs : ;
endif

ifdef cmt_example_Cool_SVstorage_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_SVstorage_makefile) : $(example_Cool_SVstoragecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SVstorage.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SVstorage_extratags) build constituent_config -out=$(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorage
else
$(cmt_local_example_Cool_SVstorage_makefile) : $(example_Cool_SVstoragecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SVstorage) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SVstorage) ] || \
	  $(not_example_Cool_SVstoragecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SVstorage.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_SVstorage_extratags) build constituent_config -out=$(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorage; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_SVstorage_makefile) : $(example_Cool_SVstoragecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_SVstorage.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SVstorage.in -tag=$(tags) $(example_Cool_SVstorage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorage
else
$(cmt_local_example_Cool_SVstorage_makefile) : $(example_Cool_SVstoragecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_SVstorage.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_SVstorage) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_SVstorage) ] || \
	  $(not_example_Cool_SVstoragecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_SVstorage.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_SVstorage.in -tag=$(tags) $(example_Cool_SVstorage_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorage; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_SVstorage_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorage

example_Cool_SVstorage :: example_Cool_SVstoragecompile example_Cool_SVstorageinstall ;

ifdef cmt_example_Cool_SVstorage_has_prototypes

example_Cool_SVstorageprototype : $(example_Cool_SVstorageprototype_dependencies) $(cmt_local_example_Cool_SVstorage_makefile) dirs example_Cool_SVstoragedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_SVstoragecompile : example_Cool_SVstorageprototype

endif

example_Cool_SVstoragecompile : $(example_Cool_SVstoragecompile_dependencies) $(cmt_local_example_Cool_SVstorage_makefile) dirs example_Cool_SVstoragedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_SVstorageclean ;

example_Cool_SVstorageclean :: $(example_Cool_SVstorageclean_dependencies) ##$(cmt_local_example_Cool_SVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) example_Cool_SVstorageclean

##	  /bin/rm -f $(cmt_local_example_Cool_SVstorage_makefile) $(bin)example_Cool_SVstorage_dependencies.make

install :: example_Cool_SVstorageinstall ;

example_Cool_SVstorageinstall :: example_Cool_SVstoragecompile $(example_Cool_SVstorage_dependencies) $(cmt_local_example_Cool_SVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_SVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_SVstorageuninstall

$(foreach d,$(example_Cool_SVstorage_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_SVstorageuninstall))

example_Cool_SVstorageuninstall : $(example_Cool_SVstorageuninstall_dependencies) ##$(cmt_local_example_Cool_SVstorage_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_SVstorage_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_SVstorage_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_SVstorageuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_SVstorage"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_SVstorage done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseCases_has_no_target_tag = 1
cmt_example_Cool_UseCases_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseCases_has_target_tag

cmt_local_tagfile_example_Cool_UseCases = $(bin)$(Examples_tag)_example_Cool_UseCases.make
cmt_final_setup_example_Cool_UseCases = $(bin)setup_example_Cool_UseCases.make
cmt_local_example_Cool_UseCases_makefile = $(bin)example_Cool_UseCases.make

example_Cool_UseCases_extratags = -tag_add=target_example_Cool_UseCases

else

cmt_local_tagfile_example_Cool_UseCases = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseCases = $(bin)setup.make
cmt_local_example_Cool_UseCases_makefile = $(bin)example_Cool_UseCases.make

endif

not_example_Cool_UseCasescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseCasescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseCasesdirs :
	@if test ! -d $(bin)example_Cool_UseCases; then $(mkdir) -p $(bin)example_Cool_UseCases; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseCases
else
example_Cool_UseCasesdirs : ;
endif

ifdef cmt_example_Cool_UseCases_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseCases_makefile) : $(example_Cool_UseCasescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseCases.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseCases_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCases
else
$(cmt_local_example_Cool_UseCases_makefile) : $(example_Cool_UseCasescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseCases) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseCases) ] || \
	  $(not_example_Cool_UseCasescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseCases.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseCases_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCases; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseCases_makefile) : $(example_Cool_UseCasescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseCases.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseCases.in -tag=$(tags) $(example_Cool_UseCases_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCases
else
$(cmt_local_example_Cool_UseCases_makefile) : $(example_Cool_UseCasescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseCases.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseCases) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseCases) ] || \
	  $(not_example_Cool_UseCasescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseCases.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseCases.in -tag=$(tags) $(example_Cool_UseCases_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCases; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseCases_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCases

example_Cool_UseCases :: example_Cool_UseCasescompile example_Cool_UseCasesinstall ;

ifdef cmt_example_Cool_UseCases_has_prototypes

example_Cool_UseCasesprototype : $(example_Cool_UseCasesprototype_dependencies) $(cmt_local_example_Cool_UseCases_makefile) dirs example_Cool_UseCasesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseCases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseCasescompile : example_Cool_UseCasesprototype

endif

example_Cool_UseCasescompile : $(example_Cool_UseCasescompile_dependencies) $(cmt_local_example_Cool_UseCases_makefile) dirs example_Cool_UseCasesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseCases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseCasesclean ;

example_Cool_UseCasesclean :: $(example_Cool_UseCasesclean_dependencies) ##$(cmt_local_example_Cool_UseCases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseCases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) example_Cool_UseCasesclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseCases_makefile) $(bin)example_Cool_UseCases_dependencies.make

install :: example_Cool_UseCasesinstall ;

example_Cool_UseCasesinstall :: example_Cool_UseCasescompile $(example_Cool_UseCases_dependencies) $(cmt_local_example_Cool_UseCases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseCases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseCasesuninstall

$(foreach d,$(example_Cool_UseCases_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseCasesuninstall))

example_Cool_UseCasesuninstall : $(example_Cool_UseCasesuninstall_dependencies) ##$(cmt_local_example_Cool_UseCases_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseCases_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseCases_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseCasesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseCases"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseCases done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseChannels_has_no_target_tag = 1
cmt_example_Cool_UseChannels_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseChannels_has_target_tag

cmt_local_tagfile_example_Cool_UseChannels = $(bin)$(Examples_tag)_example_Cool_UseChannels.make
cmt_final_setup_example_Cool_UseChannels = $(bin)setup_example_Cool_UseChannels.make
cmt_local_example_Cool_UseChannels_makefile = $(bin)example_Cool_UseChannels.make

example_Cool_UseChannels_extratags = -tag_add=target_example_Cool_UseChannels

else

cmt_local_tagfile_example_Cool_UseChannels = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseChannels = $(bin)setup.make
cmt_local_example_Cool_UseChannels_makefile = $(bin)example_Cool_UseChannels.make

endif

not_example_Cool_UseChannelscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseChannelscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseChannelsdirs :
	@if test ! -d $(bin)example_Cool_UseChannels; then $(mkdir) -p $(bin)example_Cool_UseChannels; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseChannels
else
example_Cool_UseChannelsdirs : ;
endif

ifdef cmt_example_Cool_UseChannels_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseChannels_makefile) : $(example_Cool_UseChannelscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseChannels.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseChannels_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannels
else
$(cmt_local_example_Cool_UseChannels_makefile) : $(example_Cool_UseChannelscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseChannels) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseChannels) ] || \
	  $(not_example_Cool_UseChannelscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseChannels.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseChannels_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannels; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseChannels_makefile) : $(example_Cool_UseChannelscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseChannels.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseChannels.in -tag=$(tags) $(example_Cool_UseChannels_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannels
else
$(cmt_local_example_Cool_UseChannels_makefile) : $(example_Cool_UseChannelscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseChannels.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseChannels) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseChannels) ] || \
	  $(not_example_Cool_UseChannelscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseChannels.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseChannels.in -tag=$(tags) $(example_Cool_UseChannels_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannels; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseChannels_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannels

example_Cool_UseChannels :: example_Cool_UseChannelscompile example_Cool_UseChannelsinstall ;

ifdef cmt_example_Cool_UseChannels_has_prototypes

example_Cool_UseChannelsprototype : $(example_Cool_UseChannelsprototype_dependencies) $(cmt_local_example_Cool_UseChannels_makefile) dirs example_Cool_UseChannelsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseChannels_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseChannelscompile : example_Cool_UseChannelsprototype

endif

example_Cool_UseChannelscompile : $(example_Cool_UseChannelscompile_dependencies) $(cmt_local_example_Cool_UseChannels_makefile) dirs example_Cool_UseChannelsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseChannels_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseChannelsclean ;

example_Cool_UseChannelsclean :: $(example_Cool_UseChannelsclean_dependencies) ##$(cmt_local_example_Cool_UseChannels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseChannels_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) example_Cool_UseChannelsclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseChannels_makefile) $(bin)example_Cool_UseChannels_dependencies.make

install :: example_Cool_UseChannelsinstall ;

example_Cool_UseChannelsinstall :: example_Cool_UseChannelscompile $(example_Cool_UseChannels_dependencies) $(cmt_local_example_Cool_UseChannels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseChannels_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseChannelsuninstall

$(foreach d,$(example_Cool_UseChannels_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseChannelsuninstall))

example_Cool_UseChannelsuninstall : $(example_Cool_UseChannelsuninstall_dependencies) ##$(cmt_local_example_Cool_UseChannels_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseChannels_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseChannels_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseChannelsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseChannels"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseChannels done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseClob_has_no_target_tag = 1
cmt_example_Cool_UseClob_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseClob_has_target_tag

cmt_local_tagfile_example_Cool_UseClob = $(bin)$(Examples_tag)_example_Cool_UseClob.make
cmt_final_setup_example_Cool_UseClob = $(bin)setup_example_Cool_UseClob.make
cmt_local_example_Cool_UseClob_makefile = $(bin)example_Cool_UseClob.make

example_Cool_UseClob_extratags = -tag_add=target_example_Cool_UseClob

else

cmt_local_tagfile_example_Cool_UseClob = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseClob = $(bin)setup.make
cmt_local_example_Cool_UseClob_makefile = $(bin)example_Cool_UseClob.make

endif

not_example_Cool_UseClobcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseClobcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseClobdirs :
	@if test ! -d $(bin)example_Cool_UseClob; then $(mkdir) -p $(bin)example_Cool_UseClob; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseClob
else
example_Cool_UseClobdirs : ;
endif

ifdef cmt_example_Cool_UseClob_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseClob_makefile) : $(example_Cool_UseClobcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseClob.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseClob_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClob
else
$(cmt_local_example_Cool_UseClob_makefile) : $(example_Cool_UseClobcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseClob) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseClob) ] || \
	  $(not_example_Cool_UseClobcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseClob.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseClob_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClob; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseClob_makefile) : $(example_Cool_UseClobcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseClob.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseClob.in -tag=$(tags) $(example_Cool_UseClob_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClob
else
$(cmt_local_example_Cool_UseClob_makefile) : $(example_Cool_UseClobcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseClob.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseClob) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseClob) ] || \
	  $(not_example_Cool_UseClobcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseClob.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseClob.in -tag=$(tags) $(example_Cool_UseClob_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClob; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseClob_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClob

example_Cool_UseClob :: example_Cool_UseClobcompile example_Cool_UseClobinstall ;

ifdef cmt_example_Cool_UseClob_has_prototypes

example_Cool_UseClobprototype : $(example_Cool_UseClobprototype_dependencies) $(cmt_local_example_Cool_UseClob_makefile) dirs example_Cool_UseClobdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseClob_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseClobcompile : example_Cool_UseClobprototype

endif

example_Cool_UseClobcompile : $(example_Cool_UseClobcompile_dependencies) $(cmt_local_example_Cool_UseClob_makefile) dirs example_Cool_UseClobdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseClob_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseClobclean ;

example_Cool_UseClobclean :: $(example_Cool_UseClobclean_dependencies) ##$(cmt_local_example_Cool_UseClob_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseClob_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) example_Cool_UseClobclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseClob_makefile) $(bin)example_Cool_UseClob_dependencies.make

install :: example_Cool_UseClobinstall ;

example_Cool_UseClobinstall :: example_Cool_UseClobcompile $(example_Cool_UseClob_dependencies) $(cmt_local_example_Cool_UseClob_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseClob_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseClobuninstall

$(foreach d,$(example_Cool_UseClob_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseClobuninstall))

example_Cool_UseClobuninstall : $(example_Cool_UseClobuninstall_dependencies) ##$(cmt_local_example_Cool_UseClob_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseClob_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseClob_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseClobuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseClob"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseClob done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseFolderSets_has_no_target_tag = 1
cmt_example_Cool_UseFolderSets_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseFolderSets_has_target_tag

cmt_local_tagfile_example_Cool_UseFolderSets = $(bin)$(Examples_tag)_example_Cool_UseFolderSets.make
cmt_final_setup_example_Cool_UseFolderSets = $(bin)setup_example_Cool_UseFolderSets.make
cmt_local_example_Cool_UseFolderSets_makefile = $(bin)example_Cool_UseFolderSets.make

example_Cool_UseFolderSets_extratags = -tag_add=target_example_Cool_UseFolderSets

else

cmt_local_tagfile_example_Cool_UseFolderSets = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseFolderSets = $(bin)setup.make
cmt_local_example_Cool_UseFolderSets_makefile = $(bin)example_Cool_UseFolderSets.make

endif

not_example_Cool_UseFolderSetscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseFolderSetscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseFolderSetsdirs :
	@if test ! -d $(bin)example_Cool_UseFolderSets; then $(mkdir) -p $(bin)example_Cool_UseFolderSets; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseFolderSets
else
example_Cool_UseFolderSetsdirs : ;
endif

ifdef cmt_example_Cool_UseFolderSets_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseFolderSets_makefile) : $(example_Cool_UseFolderSetscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseFolderSets.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseFolderSets_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSets
else
$(cmt_local_example_Cool_UseFolderSets_makefile) : $(example_Cool_UseFolderSetscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseFolderSets) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseFolderSets) ] || \
	  $(not_example_Cool_UseFolderSetscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseFolderSets.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseFolderSets_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSets; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseFolderSets_makefile) : $(example_Cool_UseFolderSetscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseFolderSets.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseFolderSets.in -tag=$(tags) $(example_Cool_UseFolderSets_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSets
else
$(cmt_local_example_Cool_UseFolderSets_makefile) : $(example_Cool_UseFolderSetscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseFolderSets.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseFolderSets) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseFolderSets) ] || \
	  $(not_example_Cool_UseFolderSetscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseFolderSets.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseFolderSets.in -tag=$(tags) $(example_Cool_UseFolderSets_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSets; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseFolderSets_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSets

example_Cool_UseFolderSets :: example_Cool_UseFolderSetscompile example_Cool_UseFolderSetsinstall ;

ifdef cmt_example_Cool_UseFolderSets_has_prototypes

example_Cool_UseFolderSetsprototype : $(example_Cool_UseFolderSetsprototype_dependencies) $(cmt_local_example_Cool_UseFolderSets_makefile) dirs example_Cool_UseFolderSetsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseFolderSets_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseFolderSetscompile : example_Cool_UseFolderSetsprototype

endif

example_Cool_UseFolderSetscompile : $(example_Cool_UseFolderSetscompile_dependencies) $(cmt_local_example_Cool_UseFolderSets_makefile) dirs example_Cool_UseFolderSetsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseFolderSets_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseFolderSetsclean ;

example_Cool_UseFolderSetsclean :: $(example_Cool_UseFolderSetsclean_dependencies) ##$(cmt_local_example_Cool_UseFolderSets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseFolderSets_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) example_Cool_UseFolderSetsclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseFolderSets_makefile) $(bin)example_Cool_UseFolderSets_dependencies.make

install :: example_Cool_UseFolderSetsinstall ;

example_Cool_UseFolderSetsinstall :: example_Cool_UseFolderSetscompile $(example_Cool_UseFolderSets_dependencies) $(cmt_local_example_Cool_UseFolderSets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseFolderSets_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseFolderSetsuninstall

$(foreach d,$(example_Cool_UseFolderSets_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseFolderSetsuninstall))

example_Cool_UseFolderSetsuninstall : $(example_Cool_UseFolderSetsuninstall_dependencies) ##$(cmt_local_example_Cool_UseFolderSets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseFolderSets_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseFolderSets_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseFolderSetsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseFolderSets"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseFolderSets done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseLFCLookup_has_no_target_tag = 1
cmt_example_Cool_UseLFCLookup_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseLFCLookup_has_target_tag

cmt_local_tagfile_example_Cool_UseLFCLookup = $(bin)$(Examples_tag)_example_Cool_UseLFCLookup.make
cmt_final_setup_example_Cool_UseLFCLookup = $(bin)setup_example_Cool_UseLFCLookup.make
cmt_local_example_Cool_UseLFCLookup_makefile = $(bin)example_Cool_UseLFCLookup.make

example_Cool_UseLFCLookup_extratags = -tag_add=target_example_Cool_UseLFCLookup

else

cmt_local_tagfile_example_Cool_UseLFCLookup = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseLFCLookup = $(bin)setup.make
cmt_local_example_Cool_UseLFCLookup_makefile = $(bin)example_Cool_UseLFCLookup.make

endif

not_example_Cool_UseLFCLookupcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseLFCLookupcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseLFCLookupdirs :
	@if test ! -d $(bin)example_Cool_UseLFCLookup; then $(mkdir) -p $(bin)example_Cool_UseLFCLookup; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseLFCLookup
else
example_Cool_UseLFCLookupdirs : ;
endif

ifdef cmt_example_Cool_UseLFCLookup_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseLFCLookup_makefile) : $(example_Cool_UseLFCLookupcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseLFCLookup.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseLFCLookup_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookup
else
$(cmt_local_example_Cool_UseLFCLookup_makefile) : $(example_Cool_UseLFCLookupcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseLFCLookup) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseLFCLookup) ] || \
	  $(not_example_Cool_UseLFCLookupcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseLFCLookup.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseLFCLookup_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookup; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseLFCLookup_makefile) : $(example_Cool_UseLFCLookupcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseLFCLookup.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseLFCLookup.in -tag=$(tags) $(example_Cool_UseLFCLookup_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookup
else
$(cmt_local_example_Cool_UseLFCLookup_makefile) : $(example_Cool_UseLFCLookupcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseLFCLookup.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseLFCLookup) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseLFCLookup) ] || \
	  $(not_example_Cool_UseLFCLookupcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseLFCLookup.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseLFCLookup.in -tag=$(tags) $(example_Cool_UseLFCLookup_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookup; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseLFCLookup_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookup

example_Cool_UseLFCLookup :: example_Cool_UseLFCLookupcompile example_Cool_UseLFCLookupinstall ;

ifdef cmt_example_Cool_UseLFCLookup_has_prototypes

example_Cool_UseLFCLookupprototype : $(example_Cool_UseLFCLookupprototype_dependencies) $(cmt_local_example_Cool_UseLFCLookup_makefile) dirs example_Cool_UseLFCLookupdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseLFCLookup_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseLFCLookupcompile : example_Cool_UseLFCLookupprototype

endif

example_Cool_UseLFCLookupcompile : $(example_Cool_UseLFCLookupcompile_dependencies) $(cmt_local_example_Cool_UseLFCLookup_makefile) dirs example_Cool_UseLFCLookupdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseLFCLookup_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseLFCLookupclean ;

example_Cool_UseLFCLookupclean :: $(example_Cool_UseLFCLookupclean_dependencies) ##$(cmt_local_example_Cool_UseLFCLookup_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseLFCLookup_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) example_Cool_UseLFCLookupclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $(bin)example_Cool_UseLFCLookup_dependencies.make

install :: example_Cool_UseLFCLookupinstall ;

example_Cool_UseLFCLookupinstall :: example_Cool_UseLFCLookupcompile $(example_Cool_UseLFCLookup_dependencies) $(cmt_local_example_Cool_UseLFCLookup_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseLFCLookup_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseLFCLookupuninstall

$(foreach d,$(example_Cool_UseLFCLookup_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseLFCLookupuninstall))

example_Cool_UseLFCLookupuninstall : $(example_Cool_UseLFCLookupuninstall_dependencies) ##$(cmt_local_example_Cool_UseLFCLookup_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseLFCLookup_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseLFCLookup_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseLFCLookupuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseLFCLookup"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseLFCLookup done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UsePayloadQueries_has_no_target_tag = 1
cmt_example_Cool_UsePayloadQueries_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UsePayloadQueries_has_target_tag

cmt_local_tagfile_example_Cool_UsePayloadQueries = $(bin)$(Examples_tag)_example_Cool_UsePayloadQueries.make
cmt_final_setup_example_Cool_UsePayloadQueries = $(bin)setup_example_Cool_UsePayloadQueries.make
cmt_local_example_Cool_UsePayloadQueries_makefile = $(bin)example_Cool_UsePayloadQueries.make

example_Cool_UsePayloadQueries_extratags = -tag_add=target_example_Cool_UsePayloadQueries

else

cmt_local_tagfile_example_Cool_UsePayloadQueries = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UsePayloadQueries = $(bin)setup.make
cmt_local_example_Cool_UsePayloadQueries_makefile = $(bin)example_Cool_UsePayloadQueries.make

endif

not_example_Cool_UsePayloadQueriescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UsePayloadQueriescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UsePayloadQueriesdirs :
	@if test ! -d $(bin)example_Cool_UsePayloadQueries; then $(mkdir) -p $(bin)example_Cool_UsePayloadQueries; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UsePayloadQueries
else
example_Cool_UsePayloadQueriesdirs : ;
endif

ifdef cmt_example_Cool_UsePayloadQueries_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UsePayloadQueries_makefile) : $(example_Cool_UsePayloadQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UsePayloadQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UsePayloadQueries_extratags) build constituent_config -out=$(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueries
else
$(cmt_local_example_Cool_UsePayloadQueries_makefile) : $(example_Cool_UsePayloadQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UsePayloadQueries) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UsePayloadQueries) ] || \
	  $(not_example_Cool_UsePayloadQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UsePayloadQueries.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UsePayloadQueries_extratags) build constituent_config -out=$(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueries; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UsePayloadQueries_makefile) : $(example_Cool_UsePayloadQueriescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UsePayloadQueries.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UsePayloadQueries.in -tag=$(tags) $(example_Cool_UsePayloadQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueries
else
$(cmt_local_example_Cool_UsePayloadQueries_makefile) : $(example_Cool_UsePayloadQueriescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UsePayloadQueries.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UsePayloadQueries) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UsePayloadQueries) ] || \
	  $(not_example_Cool_UsePayloadQueriescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UsePayloadQueries.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UsePayloadQueries.in -tag=$(tags) $(example_Cool_UsePayloadQueries_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueries; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UsePayloadQueries_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueries

example_Cool_UsePayloadQueries :: example_Cool_UsePayloadQueriescompile example_Cool_UsePayloadQueriesinstall ;

ifdef cmt_example_Cool_UsePayloadQueries_has_prototypes

example_Cool_UsePayloadQueriesprototype : $(example_Cool_UsePayloadQueriesprototype_dependencies) $(cmt_local_example_Cool_UsePayloadQueries_makefile) dirs example_Cool_UsePayloadQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UsePayloadQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UsePayloadQueriescompile : example_Cool_UsePayloadQueriesprototype

endif

example_Cool_UsePayloadQueriescompile : $(example_Cool_UsePayloadQueriescompile_dependencies) $(cmt_local_example_Cool_UsePayloadQueries_makefile) dirs example_Cool_UsePayloadQueriesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UsePayloadQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UsePayloadQueriesclean ;

example_Cool_UsePayloadQueriesclean :: $(example_Cool_UsePayloadQueriesclean_dependencies) ##$(cmt_local_example_Cool_UsePayloadQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UsePayloadQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) example_Cool_UsePayloadQueriesclean

##	  /bin/rm -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $(bin)example_Cool_UsePayloadQueries_dependencies.make

install :: example_Cool_UsePayloadQueriesinstall ;

example_Cool_UsePayloadQueriesinstall :: example_Cool_UsePayloadQueriescompile $(example_Cool_UsePayloadQueries_dependencies) $(cmt_local_example_Cool_UsePayloadQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UsePayloadQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UsePayloadQueriesuninstall

$(foreach d,$(example_Cool_UsePayloadQueries_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UsePayloadQueriesuninstall))

example_Cool_UsePayloadQueriesuninstall : $(example_Cool_UsePayloadQueriesuninstall_dependencies) ##$(cmt_local_example_Cool_UsePayloadQueries_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UsePayloadQueries_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UsePayloadQueries_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UsePayloadQueriesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UsePayloadQueries"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UsePayloadQueries done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_example_Cool_UseTags_has_no_target_tag = 1
cmt_example_Cool_UseTags_has_prototypes = 1

#--------------------------------------

ifdef cmt_example_Cool_UseTags_has_target_tag

cmt_local_tagfile_example_Cool_UseTags = $(bin)$(Examples_tag)_example_Cool_UseTags.make
cmt_final_setup_example_Cool_UseTags = $(bin)setup_example_Cool_UseTags.make
cmt_local_example_Cool_UseTags_makefile = $(bin)example_Cool_UseTags.make

example_Cool_UseTags_extratags = -tag_add=target_example_Cool_UseTags

else

cmt_local_tagfile_example_Cool_UseTags = $(bin)$(Examples_tag).make
cmt_final_setup_example_Cool_UseTags = $(bin)setup.make
cmt_local_example_Cool_UseTags_makefile = $(bin)example_Cool_UseTags.make

endif

not_example_Cool_UseTagscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(example_Cool_UseTagscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
example_Cool_UseTagsdirs :
	@if test ! -d $(bin)example_Cool_UseTags; then $(mkdir) -p $(bin)example_Cool_UseTags; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)example_Cool_UseTags
else
example_Cool_UseTagsdirs : ;
endif

ifdef cmt_example_Cool_UseTags_has_target_tag

ifndef QUICK
$(cmt_local_example_Cool_UseTags_makefile) : $(example_Cool_UseTagscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseTags.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseTags_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTags
else
$(cmt_local_example_Cool_UseTags_makefile) : $(example_Cool_UseTagscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseTags) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseTags) ] || \
	  $(not_example_Cool_UseTagscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseTags.make"; \
	  $(cmtexe) -tag=$(tags) $(example_Cool_UseTags_extratags) build constituent_config -out=$(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTags; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_example_Cool_UseTags_makefile) : $(example_Cool_UseTagscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building example_Cool_UseTags.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseTags.in -tag=$(tags) $(example_Cool_UseTags_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTags
else
$(cmt_local_example_Cool_UseTags_makefile) : $(example_Cool_UseTagscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)example_Cool_UseTags.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_example_Cool_UseTags) ] || \
	  [ ! -f $(cmt_final_setup_example_Cool_UseTags) ] || \
	  $(not_example_Cool_UseTagscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building example_Cool_UseTags.make"; \
	  $(cmtexe) -f=$(bin)example_Cool_UseTags.in -tag=$(tags) $(example_Cool_UseTags_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTags; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(example_Cool_UseTags_extratags) build constituent_makefile -out=$(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTags

example_Cool_UseTags :: example_Cool_UseTagscompile example_Cool_UseTagsinstall ;

ifdef cmt_example_Cool_UseTags_has_prototypes

example_Cool_UseTagsprototype : $(example_Cool_UseTagsprototype_dependencies) $(cmt_local_example_Cool_UseTags_makefile) dirs example_Cool_UseTagsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseTags_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

example_Cool_UseTagscompile : example_Cool_UseTagsprototype

endif

example_Cool_UseTagscompile : $(example_Cool_UseTagscompile_dependencies) $(cmt_local_example_Cool_UseTags_makefile) dirs example_Cool_UseTagsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseTags_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: example_Cool_UseTagsclean ;

example_Cool_UseTagsclean :: $(example_Cool_UseTagsclean_dependencies) ##$(cmt_local_example_Cool_UseTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseTags_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) example_Cool_UseTagsclean

##	  /bin/rm -f $(cmt_local_example_Cool_UseTags_makefile) $(bin)example_Cool_UseTags_dependencies.make

install :: example_Cool_UseTagsinstall ;

example_Cool_UseTagsinstall :: example_Cool_UseTagscompile $(example_Cool_UseTags_dependencies) $(cmt_local_example_Cool_UseTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_example_Cool_UseTags_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : example_Cool_UseTagsuninstall

$(foreach d,$(example_Cool_UseTags_dependencies),$(eval $(d)uninstall_dependencies += example_Cool_UseTagsuninstall))

example_Cool_UseTagsuninstall : $(example_Cool_UseTagsuninstall_dependencies) ##$(cmt_local_example_Cool_UseTags_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_example_Cool_UseTags_makefile); then \
	  $(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_example_Cool_UseTags_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: example_Cool_UseTagsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ example_Cool_UseTags"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ example_Cool_UseTags done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(Examples_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(Examples_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(Examples_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(Examples_tag).make
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

cmt_local_tagfile_make = $(bin)$(Examples_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(Examples_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(Examples_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(Examples_tag).make
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

cmt_tests_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_tests_has_target_tag

cmt_local_tagfile_tests = $(bin)$(Examples_tag)_tests.make
cmt_final_setup_tests = $(bin)setup_tests.make
cmt_local_tests_makefile = $(bin)tests.make

tests_extratags = -tag_add=target_tests

else

cmt_local_tagfile_tests = $(bin)$(Examples_tag).make
cmt_final_setup_tests = $(bin)setup.make
cmt_local_tests_makefile = $(bin)tests.make

endif

not_tests_dependencies = { n=0; for p in $?; do m=0; for d in $(tests_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
testsdirs :
	@if test ! -d $(bin)tests; then $(mkdir) -p $(bin)tests; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)tests
else
testsdirs : ;
endif

ifdef cmt_tests_has_target_tag

ifndef QUICK
$(cmt_local_tests_makefile) : $(tests_dependencies) build_library_links
	$(echo) "(constituents.make) Building tests.make"; \
	  $(cmtexe) -tag=$(tags) $(tests_extratags) build constituent_config -out=$(cmt_local_tests_makefile) tests
else
$(cmt_local_tests_makefile) : $(tests_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_tests) ] || \
	  [ ! -f $(cmt_final_setup_tests) ] || \
	  $(not_tests_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building tests.make"; \
	  $(cmtexe) -tag=$(tags) $(tests_extratags) build constituent_config -out=$(cmt_local_tests_makefile) tests; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_tests_makefile) : $(tests_dependencies) build_library_links
	$(echo) "(constituents.make) Building tests.make"; \
	  $(cmtexe) -f=$(bin)tests.in -tag=$(tags) $(tests_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_tests_makefile) tests
else
$(cmt_local_tests_makefile) : $(tests_dependencies) $(cmt_build_library_linksstamp) $(bin)tests.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_tests) ] || \
	  [ ! -f $(cmt_final_setup_tests) ] || \
	  $(not_tests_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building tests.make"; \
	  $(cmtexe) -f=$(bin)tests.in -tag=$(tags) $(tests_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_tests_makefile) tests; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(tests_extratags) build constituent_makefile -out=$(cmt_local_tests_makefile) tests

tests :: $(tests_dependencies) $(cmt_local_tests_makefile) dirs testsdirs
	$(echo) "(constituents.make) Starting tests"
	@if test -f $(cmt_local_tests_makefile); then \
	  $(MAKE) -f $(cmt_local_tests_makefile) tests; \
	  fi
#	@$(MAKE) -f $(cmt_local_tests_makefile) tests
	$(echo) "(constituents.make) tests done"

clean :: testsclean ;

testsclean :: $(testsclean_dependencies) ##$(cmt_local_tests_makefile)
	$(echo) "(constituents.make) Starting testsclean"
	@-if test -f $(cmt_local_tests_makefile); then \
	  $(MAKE) -f $(cmt_local_tests_makefile) testsclean; \
	fi
	$(echo) "(constituents.make) testsclean done"
#	@-$(MAKE) -f $(cmt_local_tests_makefile) testsclean

##	  /bin/rm -f $(cmt_local_tests_makefile) $(bin)tests_dependencies.make

install :: testsinstall ;

testsinstall :: $(tests_dependencies) $(cmt_local_tests_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_tests_makefile); then \
	  $(MAKE) -f $(cmt_local_tests_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_tests_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : testsuninstall

$(foreach d,$(tests_dependencies),$(eval $(d)uninstall_dependencies += testsuninstall))

testsuninstall : $(testsuninstall_dependencies) ##$(cmt_local_tests_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_tests_makefile); then \
	  $(MAKE) -f $(cmt_local_tests_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_tests_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: testsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ tests"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ tests done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_utilities_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_utilities_has_target_tag

cmt_local_tagfile_utilities = $(bin)$(Examples_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(Examples_tag).make
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
