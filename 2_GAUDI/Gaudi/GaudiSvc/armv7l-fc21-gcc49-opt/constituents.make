
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile = $(GaudiSvc_tag).make
cmt_local_tagfile = $(bin)$(GaudiSvc_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make
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

cmt_GaudiSvc_has_no_target_tag = 1
cmt_GaudiSvc_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiSvc_has_target_tag

cmt_local_tagfile_GaudiSvc = $(bin)$(GaudiSvc_tag)_GaudiSvc.make
cmt_final_setup_GaudiSvc = $(bin)setup_GaudiSvc.make
cmt_local_GaudiSvc_makefile = $(bin)GaudiSvc.make

GaudiSvc_extratags = -tag_add=target_GaudiSvc

else

cmt_local_tagfile_GaudiSvc = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvc = $(bin)setup.make
cmt_local_GaudiSvc_makefile = $(bin)GaudiSvc.make

endif

not_GaudiSvccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcdirs :
	@if test ! -d $(bin)GaudiSvc; then $(mkdir) -p $(bin)GaudiSvc; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvc
else
GaudiSvcdirs : ;
endif

ifdef cmt_GaudiSvc_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvc_makefile) : $(GaudiSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_makefile) GaudiSvc
else
$(cmt_local_GaudiSvc_makefile) : $(GaudiSvccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc) ] || \
	  $(not_GaudiSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_makefile) GaudiSvc; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvc_makefile) : $(GaudiSvccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc.in -tag=$(tags) $(GaudiSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_makefile) GaudiSvc
else
$(cmt_local_GaudiSvc_makefile) : $(GaudiSvccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvc.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc) ] || \
	  $(not_GaudiSvccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc.in -tag=$(tags) $(GaudiSvc_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_makefile) GaudiSvc; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvc_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvc_makefile) GaudiSvc

GaudiSvc :: GaudiSvccompile GaudiSvcinstall ;

ifdef cmt_GaudiSvc_has_prototypes

GaudiSvcprototype : $(GaudiSvcprototype_dependencies) $(cmt_local_GaudiSvc_makefile) dirs GaudiSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiSvccompile : GaudiSvcprototype

endif

GaudiSvccompile : $(GaudiSvccompile_dependencies) $(cmt_local_GaudiSvc_makefile) dirs GaudiSvcdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiSvcclean ;

GaudiSvcclean :: $(GaudiSvcclean_dependencies) ##$(cmt_local_GaudiSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvc_makefile) GaudiSvcclean

##	  /bin/rm -f $(cmt_local_GaudiSvc_makefile) $(bin)GaudiSvc_dependencies.make

install :: GaudiSvcinstall ;

GaudiSvcinstall :: GaudiSvccompile $(GaudiSvc_dependencies) $(cmt_local_GaudiSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcuninstall

$(foreach d,$(GaudiSvc_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcuninstall))

GaudiSvcuninstall : $(GaudiSvcuninstall_dependencies) ##$(cmt_local_GaudiSvc_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvc_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvc"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvc done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiSvcTest_has_no_target_tag = 1
cmt_GaudiSvcTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiSvcTest_has_target_tag

cmt_local_tagfile_GaudiSvcTest = $(bin)$(GaudiSvc_tag)_GaudiSvcTest.make
cmt_final_setup_GaudiSvcTest = $(bin)setup_GaudiSvcTest.make
cmt_local_GaudiSvcTest_makefile = $(bin)GaudiSvcTest.make

GaudiSvcTest_extratags = -tag_add=target_GaudiSvcTest

else

cmt_local_tagfile_GaudiSvcTest = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcTest = $(bin)setup.make
cmt_local_GaudiSvcTest_makefile = $(bin)GaudiSvcTest.make

endif

not_GaudiSvcTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcTestdirs :
	@if test ! -d $(bin)GaudiSvcTest; then $(mkdir) -p $(bin)GaudiSvcTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcTest
else
GaudiSvcTestdirs : ;
endif

ifdef cmt_GaudiSvcTest_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcTest_makefile) : $(GaudiSvcTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTest_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTest_makefile) GaudiSvcTest
else
$(cmt_local_GaudiSvcTest_makefile) : $(GaudiSvcTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTest) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTest) ] || \
	  $(not_GaudiSvcTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTest_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTest_makefile) GaudiSvcTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcTest_makefile) : $(GaudiSvcTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTest.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTest.in -tag=$(tags) $(GaudiSvcTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTest_makefile) GaudiSvcTest
else
$(cmt_local_GaudiSvcTest_makefile) : $(GaudiSvcTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTest) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTest) ] || \
	  $(not_GaudiSvcTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTest.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTest.in -tag=$(tags) $(GaudiSvcTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTest_makefile) GaudiSvcTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcTest_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcTest_makefile) GaudiSvcTest

GaudiSvcTest :: GaudiSvcTestcompile GaudiSvcTestinstall ;

ifdef cmt_GaudiSvcTest_has_prototypes

GaudiSvcTestprototype : $(GaudiSvcTestprototype_dependencies) $(cmt_local_GaudiSvcTest_makefile) dirs GaudiSvcTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiSvcTestcompile : GaudiSvcTestprototype

endif

GaudiSvcTestcompile : $(GaudiSvcTestcompile_dependencies) $(cmt_local_GaudiSvcTest_makefile) dirs GaudiSvcTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiSvcTestclean ;

GaudiSvcTestclean :: $(GaudiSvcTestclean_dependencies) ##$(cmt_local_GaudiSvcTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) GaudiSvcTestclean

##	  /bin/rm -f $(cmt_local_GaudiSvcTest_makefile) $(bin)GaudiSvcTest_dependencies.make

install :: GaudiSvcTestinstall ;

GaudiSvcTestinstall :: GaudiSvcTestcompile $(GaudiSvcTest_dependencies) $(cmt_local_GaudiSvcTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcTestuninstall

$(foreach d,$(GaudiSvcTest_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcTestuninstall))

GaudiSvcTestuninstall : $(GaudiSvcTestuninstall_dependencies) ##$(cmt_local_GaudiSvcTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcTest done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiSvcComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcComponentsList_has_target_tag

cmt_local_tagfile_GaudiSvcComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcComponentsList.make
cmt_final_setup_GaudiSvcComponentsList = $(bin)setup_GaudiSvcComponentsList.make
cmt_local_GaudiSvcComponentsList_makefile = $(bin)GaudiSvcComponentsList.make

GaudiSvcComponentsList_extratags = -tag_add=target_GaudiSvcComponentsList

else

cmt_local_tagfile_GaudiSvcComponentsList = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcComponentsList = $(bin)setup.make
cmt_local_GaudiSvcComponentsList_makefile = $(bin)GaudiSvcComponentsList.make

endif

not_GaudiSvcComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcComponentsListdirs :
	@if test ! -d $(bin)GaudiSvcComponentsList; then $(mkdir) -p $(bin)GaudiSvcComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcComponentsList
else
GaudiSvcComponentsListdirs : ;
endif

ifdef cmt_GaudiSvcComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcComponentsList_makefile) : $(GaudiSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList
else
$(cmt_local_GaudiSvcComponentsList_makefile) : $(GaudiSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcComponentsList) ] || \
	  $(not_GaudiSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcComponentsList_makefile) : $(GaudiSvcComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcComponentsList.in -tag=$(tags) $(GaudiSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList
else
$(cmt_local_GaudiSvcComponentsList_makefile) : $(GaudiSvcComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcComponentsList) ] || \
	  $(not_GaudiSvcComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcComponentsList.in -tag=$(tags) $(GaudiSvcComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList

GaudiSvcComponentsList :: $(GaudiSvcComponentsList_dependencies) $(cmt_local_GaudiSvcComponentsList_makefile) dirs GaudiSvcComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiSvcComponentsList"
	@if test -f $(cmt_local_GaudiSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsList
	$(echo) "(constituents.make) GaudiSvcComponentsList done"

clean :: GaudiSvcComponentsListclean ;

GaudiSvcComponentsListclean :: $(GaudiSvcComponentsListclean_dependencies) ##$(cmt_local_GaudiSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcComponentsListclean"
	@-if test -f $(cmt_local_GaudiSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) GaudiSvcComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiSvcComponentsList_makefile) $(bin)GaudiSvcComponentsList_dependencies.make

install :: GaudiSvcComponentsListinstall ;

GaudiSvcComponentsListinstall :: $(GaudiSvcComponentsList_dependencies) $(cmt_local_GaudiSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcComponentsListuninstall

$(foreach d,$(GaudiSvcComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcComponentsListuninstall))

GaudiSvcComponentsListuninstall : $(GaudiSvcComponentsListuninstall_dependencies) ##$(cmt_local_GaudiSvcComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiSvcMergeComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcMergeComponentsList.make
cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)setup_GaudiSvcMergeComponentsList.make
cmt_local_GaudiSvcMergeComponentsList_makefile = $(bin)GaudiSvcMergeComponentsList.make

GaudiSvcMergeComponentsList_extratags = -tag_add=target_GaudiSvcMergeComponentsList

else

cmt_local_tagfile_GaudiSvcMergeComponentsList = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)setup.make
cmt_local_GaudiSvcMergeComponentsList_makefile = $(bin)GaudiSvcMergeComponentsList.make

endif

not_GaudiSvcMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiSvcMergeComponentsList; then $(mkdir) -p $(bin)GaudiSvcMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcMergeComponentsList
else
GaudiSvcMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiSvcMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcMergeComponentsList_makefile) : $(GaudiSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList
else
$(cmt_local_GaudiSvcMergeComponentsList_makefile) : $(GaudiSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcMergeComponentsList) ] || \
	  $(not_GaudiSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcMergeComponentsList_makefile) : $(GaudiSvcMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcMergeComponentsList.in -tag=$(tags) $(GaudiSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList
else
$(cmt_local_GaudiSvcMergeComponentsList_makefile) : $(GaudiSvcMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcMergeComponentsList) ] || \
	  $(not_GaudiSvcMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcMergeComponentsList.in -tag=$(tags) $(GaudiSvcMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList

GaudiSvcMergeComponentsList :: $(GaudiSvcMergeComponentsList_dependencies) $(cmt_local_GaudiSvcMergeComponentsList_makefile) dirs GaudiSvcMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiSvcMergeComponentsList"
	@if test -f $(cmt_local_GaudiSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsList
	$(echo) "(constituents.make) GaudiSvcMergeComponentsList done"

clean :: GaudiSvcMergeComponentsListclean ;

GaudiSvcMergeComponentsListclean :: $(GaudiSvcMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) GaudiSvcMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) $(bin)GaudiSvcMergeComponentsList_dependencies.make

install :: GaudiSvcMergeComponentsListinstall ;

GaudiSvcMergeComponentsListinstall :: $(GaudiSvcMergeComponentsList_dependencies) $(cmt_local_GaudiSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcMergeComponentsListuninstall

$(foreach d,$(GaudiSvcMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcMergeComponentsListuninstall))

GaudiSvcMergeComponentsListuninstall : $(GaudiSvcMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiSvcMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcConf_has_target_tag

cmt_local_tagfile_GaudiSvcConf = $(bin)$(GaudiSvc_tag)_GaudiSvcConf.make
cmt_final_setup_GaudiSvcConf = $(bin)setup_GaudiSvcConf.make
cmt_local_GaudiSvcConf_makefile = $(bin)GaudiSvcConf.make

GaudiSvcConf_extratags = -tag_add=target_GaudiSvcConf

else

cmt_local_tagfile_GaudiSvcConf = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcConf = $(bin)setup.make
cmt_local_GaudiSvcConf_makefile = $(bin)GaudiSvcConf.make

endif

not_GaudiSvcConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcConfdirs :
	@if test ! -d $(bin)GaudiSvcConf; then $(mkdir) -p $(bin)GaudiSvcConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcConf
else
GaudiSvcConfdirs : ;
endif

ifdef cmt_GaudiSvcConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcConf_makefile) : $(GaudiSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConf_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf
else
$(cmt_local_GaudiSvcConf_makefile) : $(GaudiSvcConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConf) ] || \
	  $(not_GaudiSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConf_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcConf_makefile) : $(GaudiSvcConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConf.in -tag=$(tags) $(GaudiSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf
else
$(cmt_local_GaudiSvcConf_makefile) : $(GaudiSvcConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConf) ] || \
	  $(not_GaudiSvcConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConf.in -tag=$(tags) $(GaudiSvcConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf

GaudiSvcConf :: $(GaudiSvcConf_dependencies) $(cmt_local_GaudiSvcConf_makefile) dirs GaudiSvcConfdirs
	$(echo) "(constituents.make) Starting GaudiSvcConf"
	@if test -f $(cmt_local_GaudiSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) GaudiSvcConf
	$(echo) "(constituents.make) GaudiSvcConf done"

clean :: GaudiSvcConfclean ;

GaudiSvcConfclean :: $(GaudiSvcConfclean_dependencies) ##$(cmt_local_GaudiSvcConf_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcConfclean"
	@-if test -f $(cmt_local_GaudiSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) GaudiSvcConfclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) GaudiSvcConfclean

##	  /bin/rm -f $(cmt_local_GaudiSvcConf_makefile) $(bin)GaudiSvcConf_dependencies.make

install :: GaudiSvcConfinstall ;

GaudiSvcConfinstall :: $(GaudiSvcConf_dependencies) $(cmt_local_GaudiSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcConfuninstall

$(foreach d,$(GaudiSvcConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcConfuninstall))

GaudiSvcConfuninstall : $(GaudiSvcConfuninstall_dependencies) ##$(cmt_local_GaudiSvcConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvc_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvc_python_init_has_target_tag

cmt_local_tagfile_GaudiSvc_python_init = $(bin)$(GaudiSvc_tag)_GaudiSvc_python_init.make
cmt_final_setup_GaudiSvc_python_init = $(bin)setup_GaudiSvc_python_init.make
cmt_local_GaudiSvc_python_init_makefile = $(bin)GaudiSvc_python_init.make

GaudiSvc_python_init_extratags = -tag_add=target_GaudiSvc_python_init

else

cmt_local_tagfile_GaudiSvc_python_init = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvc_python_init = $(bin)setup.make
cmt_local_GaudiSvc_python_init_makefile = $(bin)GaudiSvc_python_init.make

endif

not_GaudiSvc_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvc_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvc_python_initdirs :
	@if test ! -d $(bin)GaudiSvc_python_init; then $(mkdir) -p $(bin)GaudiSvc_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvc_python_init
else
GaudiSvc_python_initdirs : ;
endif

ifdef cmt_GaudiSvc_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvc_python_init_makefile) : $(GaudiSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init
else
$(cmt_local_GaudiSvc_python_init_makefile) : $(GaudiSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc_python_init) ] || \
	  $(not_GaudiSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvc_python_init_makefile) : $(GaudiSvc_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc_python_init.in -tag=$(tags) $(GaudiSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init
else
$(cmt_local_GaudiSvc_python_init_makefile) : $(GaudiSvc_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvc_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc_python_init) ] || \
	  $(not_GaudiSvc_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc_python_init.in -tag=$(tags) $(GaudiSvc_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init

GaudiSvc_python_init :: $(GaudiSvc_python_init_dependencies) $(cmt_local_GaudiSvc_python_init_makefile) dirs GaudiSvc_python_initdirs
	$(echo) "(constituents.make) Starting GaudiSvc_python_init"
	@if test -f $(cmt_local_GaudiSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_init
	$(echo) "(constituents.make) GaudiSvc_python_init done"

clean :: GaudiSvc_python_initclean ;

GaudiSvc_python_initclean :: $(GaudiSvc_python_initclean_dependencies) ##$(cmt_local_GaudiSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiSvc_python_initclean"
	@-if test -f $(cmt_local_GaudiSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiSvc_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) GaudiSvc_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiSvc_python_init_makefile) $(bin)GaudiSvc_python_init_dependencies.make

install :: GaudiSvc_python_initinstall ;

GaudiSvc_python_initinstall :: $(GaudiSvc_python_init_dependencies) $(cmt_local_GaudiSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvc_python_inituninstall

$(foreach d,$(GaudiSvc_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvc_python_inituninstall))

GaudiSvc_python_inituninstall : $(GaudiSvc_python_inituninstall_dependencies) ##$(cmt_local_GaudiSvc_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvc_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvc_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvc_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvc_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiSvc_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiSvc_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiSvc_python_modules = $(bin)$(GaudiSvc_tag)_zip_GaudiSvc_python_modules.make
cmt_final_setup_zip_GaudiSvc_python_modules = $(bin)setup_zip_GaudiSvc_python_modules.make
cmt_local_zip_GaudiSvc_python_modules_makefile = $(bin)zip_GaudiSvc_python_modules.make

zip_GaudiSvc_python_modules_extratags = -tag_add=target_zip_GaudiSvc_python_modules

else

cmt_local_tagfile_zip_GaudiSvc_python_modules = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_zip_GaudiSvc_python_modules = $(bin)setup.make
cmt_local_zip_GaudiSvc_python_modules_makefile = $(bin)zip_GaudiSvc_python_modules.make

endif

not_zip_GaudiSvc_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiSvc_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiSvc_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiSvc_python_modules; then $(mkdir) -p $(bin)zip_GaudiSvc_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiSvc_python_modules
else
zip_GaudiSvc_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiSvc_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiSvc_python_modules_makefile) : $(zip_GaudiSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules
else
$(cmt_local_zip_GaudiSvc_python_modules_makefile) : $(zip_GaudiSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiSvc_python_modules) ] || \
	  $(not_zip_GaudiSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiSvc_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiSvc_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiSvc_python_modules_makefile) : $(zip_GaudiSvc_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiSvc_python_modules.in -tag=$(tags) $(zip_GaudiSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules
else
$(cmt_local_zip_GaudiSvc_python_modules_makefile) : $(zip_GaudiSvc_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiSvc_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiSvc_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiSvc_python_modules) ] || \
	  $(not_zip_GaudiSvc_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiSvc_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiSvc_python_modules.in -tag=$(tags) $(zip_GaudiSvc_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiSvc_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules

zip_GaudiSvc_python_modules :: $(zip_GaudiSvc_python_modules_dependencies) $(cmt_local_zip_GaudiSvc_python_modules_makefile) dirs zip_GaudiSvc_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiSvc_python_modules"
	@if test -f $(cmt_local_zip_GaudiSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modules
	$(echo) "(constituents.make) zip_GaudiSvc_python_modules done"

clean :: zip_GaudiSvc_python_modulesclean ;

zip_GaudiSvc_python_modulesclean :: $(zip_GaudiSvc_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiSvc_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiSvc_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) zip_GaudiSvc_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) $(bin)zip_GaudiSvc_python_modules_dependencies.make

install :: zip_GaudiSvc_python_modulesinstall ;

zip_GaudiSvc_python_modulesinstall :: $(zip_GaudiSvc_python_modules_dependencies) $(cmt_local_zip_GaudiSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiSvc_python_modulesuninstall

$(foreach d,$(zip_GaudiSvc_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiSvc_python_modulesuninstall))

zip_GaudiSvc_python_modulesuninstall : $(zip_GaudiSvc_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiSvc_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiSvc_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiSvc_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiSvc_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiSvc_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiSvc_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiSvcConfDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcConfDbMerge.make
cmt_final_setup_GaudiSvcConfDbMerge = $(bin)setup_GaudiSvcConfDbMerge.make
cmt_local_GaudiSvcConfDbMerge_makefile = $(bin)GaudiSvcConfDbMerge.make

GaudiSvcConfDbMerge_extratags = -tag_add=target_GaudiSvcConfDbMerge

else

cmt_local_tagfile_GaudiSvcConfDbMerge = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcConfDbMerge = $(bin)setup.make
cmt_local_GaudiSvcConfDbMerge_makefile = $(bin)GaudiSvcConfDbMerge.make

endif

not_GaudiSvcConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcConfDbMergedirs :
	@if test ! -d $(bin)GaudiSvcConfDbMerge; then $(mkdir) -p $(bin)GaudiSvcConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcConfDbMerge
else
GaudiSvcConfDbMergedirs : ;
endif

ifdef cmt_GaudiSvcConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcConfDbMerge_makefile) : $(GaudiSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge
else
$(cmt_local_GaudiSvcConfDbMerge_makefile) : $(GaudiSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConfDbMerge) ] || \
	  $(not_GaudiSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcConfDbMerge_makefile) : $(GaudiSvcConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConfDbMerge.in -tag=$(tags) $(GaudiSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge
else
$(cmt_local_GaudiSvcConfDbMerge_makefile) : $(GaudiSvcConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConfDbMerge) ] || \
	  $(not_GaudiSvcConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConfDbMerge.in -tag=$(tags) $(GaudiSvcConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge

GaudiSvcConfDbMerge :: $(GaudiSvcConfDbMerge_dependencies) $(cmt_local_GaudiSvcConfDbMerge_makefile) dirs GaudiSvcConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiSvcConfDbMerge"
	@if test -f $(cmt_local_GaudiSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMerge
	$(echo) "(constituents.make) GaudiSvcConfDbMerge done"

clean :: GaudiSvcConfDbMergeclean ;

GaudiSvcConfDbMergeclean :: $(GaudiSvcConfDbMergeclean_dependencies) ##$(cmt_local_GaudiSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) GaudiSvcConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiSvcConfDbMerge_makefile) $(bin)GaudiSvcConfDbMerge_dependencies.make

install :: GaudiSvcConfDbMergeinstall ;

GaudiSvcConfDbMergeinstall :: $(GaudiSvcConfDbMerge_dependencies) $(cmt_local_GaudiSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcConfDbMergeuninstall

$(foreach d,$(GaudiSvcConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcConfDbMergeuninstall))

GaudiSvcConfDbMergeuninstall : $(GaudiSvcConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiSvcConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcTestComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcTestComponentsList_has_target_tag

cmt_local_tagfile_GaudiSvcTestComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcTestComponentsList.make
cmt_final_setup_GaudiSvcTestComponentsList = $(bin)setup_GaudiSvcTestComponentsList.make
cmt_local_GaudiSvcTestComponentsList_makefile = $(bin)GaudiSvcTestComponentsList.make

GaudiSvcTestComponentsList_extratags = -tag_add=target_GaudiSvcTestComponentsList

else

cmt_local_tagfile_GaudiSvcTestComponentsList = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcTestComponentsList = $(bin)setup.make
cmt_local_GaudiSvcTestComponentsList_makefile = $(bin)GaudiSvcTestComponentsList.make

endif

not_GaudiSvcTestComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcTestComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcTestComponentsListdirs :
	@if test ! -d $(bin)GaudiSvcTestComponentsList; then $(mkdir) -p $(bin)GaudiSvcTestComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcTestComponentsList
else
GaudiSvcTestComponentsListdirs : ;
endif

ifdef cmt_GaudiSvcTestComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcTestComponentsList_makefile) : $(GaudiSvcTestComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList
else
$(cmt_local_GaudiSvcTestComponentsList_makefile) : $(GaudiSvcTestComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestComponentsList) ] || \
	  $(not_GaudiSvcTestComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcTestComponentsList_makefile) : $(GaudiSvcTestComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestComponentsList.in -tag=$(tags) $(GaudiSvcTestComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList
else
$(cmt_local_GaudiSvcTestComponentsList_makefile) : $(GaudiSvcTestComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcTestComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestComponentsList) ] || \
	  $(not_GaudiSvcTestComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestComponentsList.in -tag=$(tags) $(GaudiSvcTestComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList

GaudiSvcTestComponentsList :: $(GaudiSvcTestComponentsList_dependencies) $(cmt_local_GaudiSvcTestComponentsList_makefile) dirs GaudiSvcTestComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiSvcTestComponentsList"
	@if test -f $(cmt_local_GaudiSvcTestComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsList
	$(echo) "(constituents.make) GaudiSvcTestComponentsList done"

clean :: GaudiSvcTestComponentsListclean ;

GaudiSvcTestComponentsListclean :: $(GaudiSvcTestComponentsListclean_dependencies) ##$(cmt_local_GaudiSvcTestComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcTestComponentsListclean"
	@-if test -f $(cmt_local_GaudiSvcTestComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcTestComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) GaudiSvcTestComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiSvcTestComponentsList_makefile) $(bin)GaudiSvcTestComponentsList_dependencies.make

install :: GaudiSvcTestComponentsListinstall ;

GaudiSvcTestComponentsListinstall :: $(GaudiSvcTestComponentsList_dependencies) $(cmt_local_GaudiSvcTestComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTestComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcTestComponentsListuninstall

$(foreach d,$(GaudiSvcTestComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcTestComponentsListuninstall))

GaudiSvcTestComponentsListuninstall : $(GaudiSvcTestComponentsListuninstall_dependencies) ##$(cmt_local_GaudiSvcTestComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTestComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcTestComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcTestComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcTestComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcTestMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcTestMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcTestMergeComponentsList.make
cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)setup_GaudiSvcTestMergeComponentsList.make
cmt_local_GaudiSvcTestMergeComponentsList_makefile = $(bin)GaudiSvcTestMergeComponentsList.make

GaudiSvcTestMergeComponentsList_extratags = -tag_add=target_GaudiSvcTestMergeComponentsList

else

cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)setup.make
cmt_local_GaudiSvcTestMergeComponentsList_makefile = $(bin)GaudiSvcTestMergeComponentsList.make

endif

not_GaudiSvcTestMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcTestMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcTestMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiSvcTestMergeComponentsList; then $(mkdir) -p $(bin)GaudiSvcTestMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcTestMergeComponentsList
else
GaudiSvcTestMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiSvcTestMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) : $(GaudiSvcTestMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList
else
$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) : $(GaudiSvcTestMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestMergeComponentsList) ] || \
	  $(not_GaudiSvcTestMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) : $(GaudiSvcTestMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestMergeComponentsList.in -tag=$(tags) $(GaudiSvcTestMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList
else
$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) : $(GaudiSvcTestMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcTestMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestMergeComponentsList) ] || \
	  $(not_GaudiSvcTestMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestMergeComponentsList.in -tag=$(tags) $(GaudiSvcTestMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList

GaudiSvcTestMergeComponentsList :: $(GaudiSvcTestMergeComponentsList_dependencies) $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) dirs GaudiSvcTestMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiSvcTestMergeComponentsList"
	@if test -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsList
	$(echo) "(constituents.make) GaudiSvcTestMergeComponentsList done"

clean :: GaudiSvcTestMergeComponentsListclean ;

GaudiSvcTestMergeComponentsListclean :: $(GaudiSvcTestMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiSvcTestMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcTestMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcTestMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) GaudiSvcTestMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) $(bin)GaudiSvcTestMergeComponentsList_dependencies.make

install :: GaudiSvcTestMergeComponentsListinstall ;

GaudiSvcTestMergeComponentsListinstall :: $(GaudiSvcTestMergeComponentsList_dependencies) $(cmt_local_GaudiSvcTestMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcTestMergeComponentsListuninstall

$(foreach d,$(GaudiSvcTestMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcTestMergeComponentsListuninstall))

GaudiSvcTestMergeComponentsListuninstall : $(GaudiSvcTestMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiSvcTestMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcTestMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcTestMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcTestMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcTestConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcTestConf_has_target_tag

cmt_local_tagfile_GaudiSvcTestConf = $(bin)$(GaudiSvc_tag)_GaudiSvcTestConf.make
cmt_final_setup_GaudiSvcTestConf = $(bin)setup_GaudiSvcTestConf.make
cmt_local_GaudiSvcTestConf_makefile = $(bin)GaudiSvcTestConf.make

GaudiSvcTestConf_extratags = -tag_add=target_GaudiSvcTestConf

else

cmt_local_tagfile_GaudiSvcTestConf = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcTestConf = $(bin)setup.make
cmt_local_GaudiSvcTestConf_makefile = $(bin)GaudiSvcTestConf.make

endif

not_GaudiSvcTestConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcTestConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcTestConfdirs :
	@if test ! -d $(bin)GaudiSvcTestConf; then $(mkdir) -p $(bin)GaudiSvcTestConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcTestConf
else
GaudiSvcTestConfdirs : ;
endif

ifdef cmt_GaudiSvcTestConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcTestConf_makefile) : $(GaudiSvcTestConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConf_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf
else
$(cmt_local_GaudiSvcTestConf_makefile) : $(GaudiSvcTestConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestConf) ] || \
	  $(not_GaudiSvcTestConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConf_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcTestConf_makefile) : $(GaudiSvcTestConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestConf.in -tag=$(tags) $(GaudiSvcTestConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf
else
$(cmt_local_GaudiSvcTestConf_makefile) : $(GaudiSvcTestConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcTestConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestConf) ] || \
	  $(not_GaudiSvcTestConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestConf.in -tag=$(tags) $(GaudiSvcTestConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf

GaudiSvcTestConf :: $(GaudiSvcTestConf_dependencies) $(cmt_local_GaudiSvcTestConf_makefile) dirs GaudiSvcTestConfdirs
	$(echo) "(constituents.make) Starting GaudiSvcTestConf"
	@if test -f $(cmt_local_GaudiSvcTestConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConf
	$(echo) "(constituents.make) GaudiSvcTestConf done"

clean :: GaudiSvcTestConfclean ;

GaudiSvcTestConfclean :: $(GaudiSvcTestConfclean_dependencies) ##$(cmt_local_GaudiSvcTestConf_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcTestConfclean"
	@-if test -f $(cmt_local_GaudiSvcTestConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConfclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcTestConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) GaudiSvcTestConfclean

##	  /bin/rm -f $(cmt_local_GaudiSvcTestConf_makefile) $(bin)GaudiSvcTestConf_dependencies.make

install :: GaudiSvcTestConfinstall ;

GaudiSvcTestConfinstall :: $(GaudiSvcTestConf_dependencies) $(cmt_local_GaudiSvcTestConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTestConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcTestConfuninstall

$(foreach d,$(GaudiSvcTestConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcTestConfuninstall))

GaudiSvcTestConfuninstall : $(GaudiSvcTestConfuninstall_dependencies) ##$(cmt_local_GaudiSvcTestConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTestConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcTestConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcTestConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcTestConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcTestConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcTestConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcTestConfDbMerge.make
cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)setup_GaudiSvcTestConfDbMerge.make
cmt_local_GaudiSvcTestConfDbMerge_makefile = $(bin)GaudiSvcTestConfDbMerge.make

GaudiSvcTestConfDbMerge_extratags = -tag_add=target_GaudiSvcTestConfDbMerge

else

cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)setup.make
cmt_local_GaudiSvcTestConfDbMerge_makefile = $(bin)GaudiSvcTestConfDbMerge.make

endif

not_GaudiSvcTestConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcTestConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcTestConfDbMergedirs :
	@if test ! -d $(bin)GaudiSvcTestConfDbMerge; then $(mkdir) -p $(bin)GaudiSvcTestConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcTestConfDbMerge
else
GaudiSvcTestConfDbMergedirs : ;
endif

ifdef cmt_GaudiSvcTestConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcTestConfDbMerge_makefile) : $(GaudiSvcTestConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge
else
$(cmt_local_GaudiSvcTestConfDbMerge_makefile) : $(GaudiSvcTestConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestConfDbMerge) ] || \
	  $(not_GaudiSvcTestConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcTestConfDbMerge_makefile) : $(GaudiSvcTestConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcTestConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestConfDbMerge.in -tag=$(tags) $(GaudiSvcTestConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge
else
$(cmt_local_GaudiSvcTestConfDbMerge_makefile) : $(GaudiSvcTestConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcTestConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcTestConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcTestConfDbMerge) ] || \
	  $(not_GaudiSvcTestConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcTestConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcTestConfDbMerge.in -tag=$(tags) $(GaudiSvcTestConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcTestConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge

GaudiSvcTestConfDbMerge :: $(GaudiSvcTestConfDbMerge_dependencies) $(cmt_local_GaudiSvcTestConfDbMerge_makefile) dirs GaudiSvcTestConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiSvcTestConfDbMerge"
	@if test -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMerge
	$(echo) "(constituents.make) GaudiSvcTestConfDbMerge done"

clean :: GaudiSvcTestConfDbMergeclean ;

GaudiSvcTestConfDbMergeclean :: $(GaudiSvcTestConfDbMergeclean_dependencies) ##$(cmt_local_GaudiSvcTestConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcTestConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcTestConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) GaudiSvcTestConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) $(bin)GaudiSvcTestConfDbMerge_dependencies.make

install :: GaudiSvcTestConfDbMergeinstall ;

GaudiSvcTestConfDbMergeinstall :: $(GaudiSvcTestConfDbMerge_dependencies) $(cmt_local_GaudiSvcTestConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcTestConfDbMergeuninstall

$(foreach d,$(GaudiSvcTestConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcTestConfDbMergeuninstall))

GaudiSvcTestConfDbMergeuninstall : $(GaudiSvcTestConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiSvcTestConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcTestConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcTestConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcTestConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcTestConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvc_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvc_python_has_target_tag

cmt_local_tagfile_GaudiSvc_python = $(bin)$(GaudiSvc_tag)_GaudiSvc_python.make
cmt_final_setup_GaudiSvc_python = $(bin)setup_GaudiSvc_python.make
cmt_local_GaudiSvc_python_makefile = $(bin)GaudiSvc_python.make

GaudiSvc_python_extratags = -tag_add=target_GaudiSvc_python

else

cmt_local_tagfile_GaudiSvc_python = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvc_python = $(bin)setup.make
cmt_local_GaudiSvc_python_makefile = $(bin)GaudiSvc_python.make

endif

not_GaudiSvc_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvc_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvc_pythondirs :
	@if test ! -d $(bin)GaudiSvc_python; then $(mkdir) -p $(bin)GaudiSvc_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvc_python
else
GaudiSvc_pythondirs : ;
endif

ifdef cmt_GaudiSvc_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvc_python_makefile) : $(GaudiSvc_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python
else
$(cmt_local_GaudiSvc_python_makefile) : $(GaudiSvc_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc_python) ] || \
	  $(not_GaudiSvc_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_extratags) build constituent_config -out=$(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvc_python_makefile) : $(GaudiSvc_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvc_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc_python.in -tag=$(tags) $(GaudiSvc_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python
else
$(cmt_local_GaudiSvc_python_makefile) : $(GaudiSvc_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvc_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvc_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvc_python) ] || \
	  $(not_GaudiSvc_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvc_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvc_python.in -tag=$(tags) $(GaudiSvc_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvc_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python

GaudiSvc_python :: $(GaudiSvc_python_dependencies) $(cmt_local_GaudiSvc_python_makefile) dirs GaudiSvc_pythondirs
	$(echo) "(constituents.make) Starting GaudiSvc_python"
	@if test -f $(cmt_local_GaudiSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) GaudiSvc_python
	$(echo) "(constituents.make) GaudiSvc_python done"

clean :: GaudiSvc_pythonclean ;

GaudiSvc_pythonclean :: $(GaudiSvc_pythonclean_dependencies) ##$(cmt_local_GaudiSvc_python_makefile)
	$(echo) "(constituents.make) Starting GaudiSvc_pythonclean"
	@-if test -f $(cmt_local_GaudiSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) GaudiSvc_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiSvc_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) GaudiSvc_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiSvc_python_makefile) $(bin)GaudiSvc_python_dependencies.make

install :: GaudiSvc_pythoninstall ;

GaudiSvc_pythoninstall :: $(GaudiSvc_python_dependencies) $(cmt_local_GaudiSvc_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvc_pythonuninstall

$(foreach d,$(GaudiSvc_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvc_pythonuninstall))

GaudiSvc_pythonuninstall : $(GaudiSvc_pythonuninstall_dependencies) ##$(cmt_local_GaudiSvc_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvc_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvc_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvc_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvc_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvc_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcGenConfUser_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcGenConfUser_has_target_tag

cmt_local_tagfile_GaudiSvcGenConfUser = $(bin)$(GaudiSvc_tag)_GaudiSvcGenConfUser.make
cmt_final_setup_GaudiSvcGenConfUser = $(bin)setup_GaudiSvcGenConfUser.make
cmt_local_GaudiSvcGenConfUser_makefile = $(bin)GaudiSvcGenConfUser.make

GaudiSvcGenConfUser_extratags = -tag_add=target_GaudiSvcGenConfUser

else

cmt_local_tagfile_GaudiSvcGenConfUser = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcGenConfUser = $(bin)setup.make
cmt_local_GaudiSvcGenConfUser_makefile = $(bin)GaudiSvcGenConfUser.make

endif

not_GaudiSvcGenConfUser_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcGenConfUser_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcGenConfUserdirs :
	@if test ! -d $(bin)GaudiSvcGenConfUser; then $(mkdir) -p $(bin)GaudiSvcGenConfUser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcGenConfUser
else
GaudiSvcGenConfUserdirs : ;
endif

ifdef cmt_GaudiSvcGenConfUser_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcGenConfUser_makefile) : $(GaudiSvcGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser
else
$(cmt_local_GaudiSvcGenConfUser_makefile) : $(GaudiSvcGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcGenConfUser) ] || \
	  $(not_GaudiSvcGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcGenConfUser_makefile) : $(GaudiSvcGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcGenConfUser.in -tag=$(tags) $(GaudiSvcGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser
else
$(cmt_local_GaudiSvcGenConfUser_makefile) : $(GaudiSvcGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcGenConfUser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcGenConfUser) ] || \
	  $(not_GaudiSvcGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcGenConfUser.in -tag=$(tags) $(GaudiSvcGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcGenConfUser_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser

GaudiSvcGenConfUser :: $(GaudiSvcGenConfUser_dependencies) $(cmt_local_GaudiSvcGenConfUser_makefile) dirs GaudiSvcGenConfUserdirs
	$(echo) "(constituents.make) Starting GaudiSvcGenConfUser"
	@if test -f $(cmt_local_GaudiSvcGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUser
	$(echo) "(constituents.make) GaudiSvcGenConfUser done"

clean :: GaudiSvcGenConfUserclean ;

GaudiSvcGenConfUserclean :: $(GaudiSvcGenConfUserclean_dependencies) ##$(cmt_local_GaudiSvcGenConfUser_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcGenConfUserclean"
	@-if test -f $(cmt_local_GaudiSvcGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUserclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcGenConfUserclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) GaudiSvcGenConfUserclean

##	  /bin/rm -f $(cmt_local_GaudiSvcGenConfUser_makefile) $(bin)GaudiSvcGenConfUser_dependencies.make

install :: GaudiSvcGenConfUserinstall ;

GaudiSvcGenConfUserinstall :: $(GaudiSvcGenConfUser_dependencies) $(cmt_local_GaudiSvcGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcGenConfUseruninstall

$(foreach d,$(GaudiSvcGenConfUser_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcGenConfUseruninstall))

GaudiSvcGenConfUseruninstall : $(GaudiSvcGenConfUseruninstall_dependencies) ##$(cmt_local_GaudiSvcGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcGenConfUser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcGenConfUseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcGenConfUser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcGenConfUser done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiSvcConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiSvcConfUserDbMerge_has_target_tag

cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcConfUserDbMerge.make
cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)setup_GaudiSvcConfUserDbMerge.make
cmt_local_GaudiSvcConfUserDbMerge_makefile = $(bin)GaudiSvcConfUserDbMerge.make

GaudiSvcConfUserDbMerge_extratags = -tag_add=target_GaudiSvcConfUserDbMerge

else

cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)setup.make
cmt_local_GaudiSvcConfUserDbMerge_makefile = $(bin)GaudiSvcConfUserDbMerge.make

endif

not_GaudiSvcConfUserDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiSvcConfUserDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiSvcConfUserDbMergedirs :
	@if test ! -d $(bin)GaudiSvcConfUserDbMerge; then $(mkdir) -p $(bin)GaudiSvcConfUserDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiSvcConfUserDbMerge
else
GaudiSvcConfUserDbMergedirs : ;
endif

ifdef cmt_GaudiSvcConfUserDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiSvcConfUserDbMerge_makefile) : $(GaudiSvcConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge
else
$(cmt_local_GaudiSvcConfUserDbMerge_makefile) : $(GaudiSvcConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConfUserDbMerge) ] || \
	  $(not_GaudiSvcConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiSvcConfUserDbMerge_makefile) : $(GaudiSvcConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiSvcConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConfUserDbMerge.in -tag=$(tags) $(GaudiSvcConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge
else
$(cmt_local_GaudiSvcConfUserDbMerge_makefile) : $(GaudiSvcConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiSvcConfUserDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiSvcConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiSvcConfUserDbMerge) ] || \
	  $(not_GaudiSvcConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiSvcConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiSvcConfUserDbMerge.in -tag=$(tags) $(GaudiSvcConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiSvcConfUserDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge

GaudiSvcConfUserDbMerge :: $(GaudiSvcConfUserDbMerge_dependencies) $(cmt_local_GaudiSvcConfUserDbMerge_makefile) dirs GaudiSvcConfUserDbMergedirs
	$(echo) "(constituents.make) Starting GaudiSvcConfUserDbMerge"
	@if test -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMerge
	$(echo) "(constituents.make) GaudiSvcConfUserDbMerge done"

clean :: GaudiSvcConfUserDbMergeclean ;

GaudiSvcConfUserDbMergeclean :: $(GaudiSvcConfUserDbMergeclean_dependencies) ##$(cmt_local_GaudiSvcConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiSvcConfUserDbMergeclean"
	@-if test -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiSvcConfUserDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) GaudiSvcConfUserDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) $(bin)GaudiSvcConfUserDbMerge_dependencies.make

install :: GaudiSvcConfUserDbMergeinstall ;

GaudiSvcConfUserDbMergeinstall :: $(GaudiSvcConfUserDbMerge_dependencies) $(cmt_local_GaudiSvcConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiSvcConfUserDbMergeuninstall

$(foreach d,$(GaudiSvcConfUserDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiSvcConfUserDbMergeuninstall))

GaudiSvcConfUserDbMergeuninstall : $(GaudiSvcConfUserDbMergeuninstall_dependencies) ##$(cmt_local_GaudiSvcConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiSvcConfUserDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiSvcConfUserDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiSvcConfUserDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiSvcConfUserDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiSvc_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiSvc_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiSvc_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiSvc_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiSvc_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiSvc_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiSvc_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiSvc_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiSvc_tag).make
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
#-- start of constituent ------

cmt_QMTestTestsDatabase_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_QMTestTestsDatabase_has_target_tag

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiSvc_tag)_QMTestTestsDatabase.make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup_QMTestTestsDatabase.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

QMTestTestsDatabase_extratags = -tag_add=target_QMTestTestsDatabase

else

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

endif

not_QMTestTestsDatabase_dependencies = { n=0; for p in $?; do m=0; for d in $(QMTestTestsDatabase_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
QMTestTestsDatabasedirs :
	@if test ! -d $(bin)QMTestTestsDatabase; then $(mkdir) -p $(bin)QMTestTestsDatabase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)QMTestTestsDatabase
else
QMTestTestsDatabasedirs : ;
endif

ifdef cmt_QMTestTestsDatabase_has_target_tag

ifndef QUICK
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_config -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
else
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestTestsDatabase) ] || \
	  [ ! -f $(cmt_final_setup_QMTestTestsDatabase) ] || \
	  $(not_QMTestTestsDatabase_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_config -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -f=$(bin)QMTestTestsDatabase.in -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
else
$(cmt_local_QMTestTestsDatabase_makefile) : $(QMTestTestsDatabase_dependencies) $(cmt_build_library_linksstamp) $(bin)QMTestTestsDatabase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestTestsDatabase) ] || \
	  [ ! -f $(cmt_final_setup_QMTestTestsDatabase) ] || \
	  $(not_QMTestTestsDatabase_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestTestsDatabase.make"; \
	  $(cmtexe) -f=$(bin)QMTestTestsDatabase.in -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(QMTestTestsDatabase_extratags) build constituent_makefile -out=$(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase

QMTestTestsDatabase :: $(QMTestTestsDatabase_dependencies) $(cmt_local_QMTestTestsDatabase_makefile) dirs QMTestTestsDatabasedirs
	$(echo) "(constituents.make) Starting QMTestTestsDatabase"
	@if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabase
	$(echo) "(constituents.make) QMTestTestsDatabase done"

clean :: QMTestTestsDatabaseclean ;

QMTestTestsDatabaseclean :: $(QMTestTestsDatabaseclean_dependencies) ##$(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting QMTestTestsDatabaseclean"
	@-if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabaseclean; \
	fi
	$(echo) "(constituents.make) QMTestTestsDatabaseclean done"
#	@-$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) QMTestTestsDatabaseclean

##	  /bin/rm -f $(cmt_local_QMTestTestsDatabase_makefile) $(bin)QMTestTestsDatabase_dependencies.make

install :: QMTestTestsDatabaseinstall ;

QMTestTestsDatabaseinstall :: $(QMTestTestsDatabase_dependencies) $(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : QMTestTestsDatabaseuninstall

$(foreach d,$(QMTestTestsDatabase_dependencies),$(eval $(d)uninstall_dependencies += QMTestTestsDatabaseuninstall))

QMTestTestsDatabaseuninstall : $(QMTestTestsDatabaseuninstall_dependencies) ##$(cmt_local_QMTestTestsDatabase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_QMTestTestsDatabase_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestTestsDatabase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: QMTestTestsDatabaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ QMTestTestsDatabase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ QMTestTestsDatabase done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_QMTestGUI_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_QMTestGUI_has_target_tag

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiSvc_tag)_QMTestGUI.make
cmt_final_setup_QMTestGUI = $(bin)setup_QMTestGUI.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

QMTestGUI_extratags = -tag_add=target_QMTestGUI

else

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiSvc_tag).make
cmt_final_setup_QMTestGUI = $(bin)setup.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

endif

not_QMTestGUI_dependencies = { n=0; for p in $?; do m=0; for d in $(QMTestGUI_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
QMTestGUIdirs :
	@if test ! -d $(bin)QMTestGUI; then $(mkdir) -p $(bin)QMTestGUI; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)QMTestGUI
else
QMTestGUIdirs : ;
endif

ifdef cmt_QMTestGUI_has_target_tag

ifndef QUICK
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_config -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI
else
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestGUI) ] || \
	  [ ! -f $(cmt_final_setup_QMTestGUI) ] || \
	  $(not_QMTestGUI_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_config -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) build_library_links
	$(echo) "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -f=$(bin)QMTestGUI.in -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI
else
$(cmt_local_QMTestGUI_makefile) : $(QMTestGUI_dependencies) $(cmt_build_library_linksstamp) $(bin)QMTestGUI.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_QMTestGUI) ] || \
	  [ ! -f $(cmt_final_setup_QMTestGUI) ] || \
	  $(not_QMTestGUI_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building QMTestGUI.make"; \
	  $(cmtexe) -f=$(bin)QMTestGUI.in -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(QMTestGUI_extratags) build constituent_makefile -out=$(cmt_local_QMTestGUI_makefile) QMTestGUI

QMTestGUI :: $(QMTestGUI_dependencies) $(cmt_local_QMTestGUI_makefile) dirs QMTestGUIdirs
	$(echo) "(constituents.make) Starting QMTestGUI"
	@if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUI; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUI
	$(echo) "(constituents.make) QMTestGUI done"

clean :: QMTestGUIclean ;

QMTestGUIclean :: $(QMTestGUIclean_dependencies) ##$(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting QMTestGUIclean"
	@-if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUIclean; \
	fi
	$(echo) "(constituents.make) QMTestGUIclean done"
#	@-$(MAKE) -f $(cmt_local_QMTestGUI_makefile) QMTestGUIclean

##	  /bin/rm -f $(cmt_local_QMTestGUI_makefile) $(bin)QMTestGUI_dependencies.make

install :: QMTestGUIinstall ;

QMTestGUIinstall :: $(QMTestGUI_dependencies) $(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_QMTestGUI_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : QMTestGUIuninstall

$(foreach d,$(QMTestGUI_dependencies),$(eval $(d)uninstall_dependencies += QMTestGUIuninstall))

QMTestGUIuninstall : $(QMTestGUIuninstall_dependencies) ##$(cmt_local_QMTestGUI_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_QMTestGUI_makefile); then \
	  $(MAKE) -f $(cmt_local_QMTestGUI_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_QMTestGUI_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: QMTestGUIuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ QMTestGUI"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ QMTestGUI done"
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
