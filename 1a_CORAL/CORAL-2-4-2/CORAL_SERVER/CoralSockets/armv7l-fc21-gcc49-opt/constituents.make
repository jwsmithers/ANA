
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralSockets_tag = $(tag)

#cmt_local_tagfile = $(CoralSockets_tag).make
cmt_local_tagfile = $(bin)$(CoralSockets_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralSocketssetup.make
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

cmt_lcg_CoralSockets_has_no_target_tag = 1
cmt_lcg_CoralSockets_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralSockets_has_target_tag

cmt_local_tagfile_lcg_CoralSockets = $(bin)$(CoralSockets_tag)_lcg_CoralSockets.make
cmt_final_setup_lcg_CoralSockets = $(bin)setup_lcg_CoralSockets.make
cmt_local_lcg_CoralSockets_makefile = $(bin)lcg_CoralSockets.make

lcg_CoralSockets_extratags = -tag_add=target_lcg_CoralSockets

else

cmt_local_tagfile_lcg_CoralSockets = $(bin)$(CoralSockets_tag).make
cmt_final_setup_lcg_CoralSockets = $(bin)setup.make
cmt_local_lcg_CoralSockets_makefile = $(bin)lcg_CoralSockets.make

endif

not_lcg_CoralSocketscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralSocketscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralSocketsdirs :
	@if test ! -d $(bin)lcg_CoralSockets; then $(mkdir) -p $(bin)lcg_CoralSockets; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralSockets
else
lcg_CoralSocketsdirs : ;
endif

ifdef cmt_lcg_CoralSockets_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralSockets_makefile) : $(lcg_CoralSocketscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralSockets.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralSockets_extratags) build constituent_config -out=$(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSockets
else
$(cmt_local_lcg_CoralSockets_makefile) : $(lcg_CoralSocketscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralSockets) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralSockets) ] || \
	  $(not_lcg_CoralSocketscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralSockets.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralSockets_extratags) build constituent_config -out=$(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSockets; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralSockets_makefile) : $(lcg_CoralSocketscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralSockets.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralSockets.in -tag=$(tags) $(lcg_CoralSockets_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSockets
else
$(cmt_local_lcg_CoralSockets_makefile) : $(lcg_CoralSocketscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralSockets.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralSockets) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralSockets) ] || \
	  $(not_lcg_CoralSocketscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralSockets.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralSockets.in -tag=$(tags) $(lcg_CoralSockets_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSockets; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralSockets_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSockets

lcg_CoralSockets :: lcg_CoralSocketscompile lcg_CoralSocketsinstall ;

ifdef cmt_lcg_CoralSockets_has_prototypes

lcg_CoralSocketsprototype : $(lcg_CoralSocketsprototype_dependencies) $(cmt_local_lcg_CoralSockets_makefile) dirs lcg_CoralSocketsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralSockets_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralSocketscompile : lcg_CoralSocketsprototype

endif

lcg_CoralSocketscompile : $(lcg_CoralSocketscompile_dependencies) $(cmt_local_lcg_CoralSockets_makefile) dirs lcg_CoralSocketsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralSockets_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralSocketsclean ;

lcg_CoralSocketsclean :: $(lcg_CoralSocketsclean_dependencies) ##$(cmt_local_lcg_CoralSockets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralSockets_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) lcg_CoralSocketsclean

##	  /bin/rm -f $(cmt_local_lcg_CoralSockets_makefile) $(bin)lcg_CoralSockets_dependencies.make

install :: lcg_CoralSocketsinstall ;

lcg_CoralSocketsinstall :: lcg_CoralSocketscompile $(lcg_CoralSockets_dependencies) $(cmt_local_lcg_CoralSockets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralSockets_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralSocketsuninstall

$(foreach d,$(lcg_CoralSockets_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralSocketsuninstall))

lcg_CoralSocketsuninstall : $(lcg_CoralSocketsuninstall_dependencies) ##$(cmt_local_lcg_CoralSockets_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralSockets_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralSockets_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralSocketsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralSockets"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralSockets done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_DummyRequestHandler_has_no_target_tag = 1
cmt_test_unit_CoralSockets_DummyRequestHandler_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_DummyRequestHandler_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_DummyRequestHandler = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_DummyRequestHandler.make
cmt_final_setup_test_unit_CoralSockets_DummyRequestHandler = $(bin)setup_test_unit_CoralSockets_DummyRequestHandler.make
cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile = $(bin)test_unit_CoralSockets_DummyRequestHandler.make

test_unit_CoralSockets_DummyRequestHandler_extratags = -tag_add=target_test_unit_CoralSockets_DummyRequestHandler

else

cmt_local_tagfile_test_unit_CoralSockets_DummyRequestHandler = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_DummyRequestHandler = $(bin)setup.make
cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile = $(bin)test_unit_CoralSockets_DummyRequestHandler.make

endif

not_test_unit_CoralSockets_DummyRequestHandlercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_DummyRequestHandlerdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_DummyRequestHandler; then $(mkdir) -p $(bin)test_unit_CoralSockets_DummyRequestHandler; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_DummyRequestHandler
else
test_unit_CoralSockets_DummyRequestHandlerdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_DummyRequestHandler_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) : $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_DummyRequestHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_DummyRequestHandler_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandler
else
$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) : $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_DummyRequestHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_DummyRequestHandler) ] || \
	  $(not_test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_DummyRequestHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_DummyRequestHandler_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandler; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) : $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_DummyRequestHandler.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_DummyRequestHandler.in -tag=$(tags) $(test_unit_CoralSockets_DummyRequestHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandler
else
$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) : $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_DummyRequestHandler.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_DummyRequestHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_DummyRequestHandler) ] || \
	  $(not_test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_DummyRequestHandler.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_DummyRequestHandler.in -tag=$(tags) $(test_unit_CoralSockets_DummyRequestHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandler; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_DummyRequestHandler_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandler

test_unit_CoralSockets_DummyRequestHandler :: test_unit_CoralSockets_DummyRequestHandlercompile test_unit_CoralSockets_DummyRequestHandlerinstall ;

ifdef cmt_test_unit_CoralSockets_DummyRequestHandler_has_prototypes

test_unit_CoralSockets_DummyRequestHandlerprototype : $(test_unit_CoralSockets_DummyRequestHandlerprototype_dependencies) $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) dirs test_unit_CoralSockets_DummyRequestHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_DummyRequestHandlercompile : test_unit_CoralSockets_DummyRequestHandlerprototype

endif

test_unit_CoralSockets_DummyRequestHandlercompile : $(test_unit_CoralSockets_DummyRequestHandlercompile_dependencies) $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) dirs test_unit_CoralSockets_DummyRequestHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_DummyRequestHandlerclean ;

test_unit_CoralSockets_DummyRequestHandlerclean :: $(test_unit_CoralSockets_DummyRequestHandlerclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) test_unit_CoralSockets_DummyRequestHandlerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $(bin)test_unit_CoralSockets_DummyRequestHandler_dependencies.make

install :: test_unit_CoralSockets_DummyRequestHandlerinstall ;

test_unit_CoralSockets_DummyRequestHandlerinstall :: test_unit_CoralSockets_DummyRequestHandlercompile $(test_unit_CoralSockets_DummyRequestHandler_dependencies) $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_DummyRequestHandleruninstall

$(foreach d,$(test_unit_CoralSockets_DummyRequestHandler_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_DummyRequestHandleruninstall))

test_unit_CoralSockets_DummyRequestHandleruninstall : $(test_unit_CoralSockets_DummyRequestHandleruninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_DummyRequestHandler_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_DummyRequestHandleruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_DummyRequestHandler"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_DummyRequestHandler done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_PacketSocket_has_no_target_tag = 1
cmt_test_unit_CoralSockets_PacketSocket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_PacketSocket_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_PacketSocket = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_PacketSocket.make
cmt_final_setup_test_unit_CoralSockets_PacketSocket = $(bin)setup_test_unit_CoralSockets_PacketSocket.make
cmt_local_test_unit_CoralSockets_PacketSocket_makefile = $(bin)test_unit_CoralSockets_PacketSocket.make

test_unit_CoralSockets_PacketSocket_extratags = -tag_add=target_test_unit_CoralSockets_PacketSocket

else

cmt_local_tagfile_test_unit_CoralSockets_PacketSocket = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_PacketSocket = $(bin)setup.make
cmt_local_test_unit_CoralSockets_PacketSocket_makefile = $(bin)test_unit_CoralSockets_PacketSocket.make

endif

not_test_unit_CoralSockets_PacketSocketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_PacketSocketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_PacketSocketdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_PacketSocket; then $(mkdir) -p $(bin)test_unit_CoralSockets_PacketSocket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_PacketSocket
else
test_unit_CoralSockets_PacketSocketdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_PacketSocket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) : $(test_unit_CoralSockets_PacketSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_PacketSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_PacketSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocket
else
$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) : $(test_unit_CoralSockets_PacketSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_PacketSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_PacketSocket) ] || \
	  $(not_test_unit_CoralSockets_PacketSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_PacketSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_PacketSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) : $(test_unit_CoralSockets_PacketSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_PacketSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_PacketSocket.in -tag=$(tags) $(test_unit_CoralSockets_PacketSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocket
else
$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) : $(test_unit_CoralSockets_PacketSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_PacketSocket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_PacketSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_PacketSocket) ] || \
	  $(not_test_unit_CoralSockets_PacketSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_PacketSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_PacketSocket.in -tag=$(tags) $(test_unit_CoralSockets_PacketSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_PacketSocket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocket

test_unit_CoralSockets_PacketSocket :: test_unit_CoralSockets_PacketSocketcompile test_unit_CoralSockets_PacketSocketinstall ;

ifdef cmt_test_unit_CoralSockets_PacketSocket_has_prototypes

test_unit_CoralSockets_PacketSocketprototype : $(test_unit_CoralSockets_PacketSocketprototype_dependencies) $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) dirs test_unit_CoralSockets_PacketSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_PacketSocketcompile : test_unit_CoralSockets_PacketSocketprototype

endif

test_unit_CoralSockets_PacketSocketcompile : $(test_unit_CoralSockets_PacketSocketcompile_dependencies) $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) dirs test_unit_CoralSockets_PacketSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_PacketSocketclean ;

test_unit_CoralSockets_PacketSocketclean :: $(test_unit_CoralSockets_PacketSocketclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) test_unit_CoralSockets_PacketSocketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $(bin)test_unit_CoralSockets_PacketSocket_dependencies.make

install :: test_unit_CoralSockets_PacketSocketinstall ;

test_unit_CoralSockets_PacketSocketinstall :: test_unit_CoralSockets_PacketSocketcompile $(test_unit_CoralSockets_PacketSocket_dependencies) $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_PacketSocketuninstall

$(foreach d,$(test_unit_CoralSockets_PacketSocket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_PacketSocketuninstall))

test_unit_CoralSockets_PacketSocketuninstall : $(test_unit_CoralSockets_PacketSocketuninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_PacketSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_PacketSocket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_PacketSocketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_PacketSocket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_PacketSocket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_Poll_has_no_target_tag = 1
cmt_test_unit_CoralSockets_Poll_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_Poll_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_Poll = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_Poll.make
cmt_final_setup_test_unit_CoralSockets_Poll = $(bin)setup_test_unit_CoralSockets_Poll.make
cmt_local_test_unit_CoralSockets_Poll_makefile = $(bin)test_unit_CoralSockets_Poll.make

test_unit_CoralSockets_Poll_extratags = -tag_add=target_test_unit_CoralSockets_Poll

else

cmt_local_tagfile_test_unit_CoralSockets_Poll = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_Poll = $(bin)setup.make
cmt_local_test_unit_CoralSockets_Poll_makefile = $(bin)test_unit_CoralSockets_Poll.make

endif

not_test_unit_CoralSockets_Pollcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_Pollcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_Polldirs :
	@if test ! -d $(bin)test_unit_CoralSockets_Poll; then $(mkdir) -p $(bin)test_unit_CoralSockets_Poll; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_Poll
else
test_unit_CoralSockets_Polldirs : ;
endif

ifdef cmt_test_unit_CoralSockets_Poll_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_Poll_makefile) : $(test_unit_CoralSockets_Pollcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_Poll.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_Poll_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Poll
else
$(cmt_local_test_unit_CoralSockets_Poll_makefile) : $(test_unit_CoralSockets_Pollcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_Poll) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_Poll) ] || \
	  $(not_test_unit_CoralSockets_Pollcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_Poll.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_Poll_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Poll; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_Poll_makefile) : $(test_unit_CoralSockets_Pollcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_Poll.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_Poll.in -tag=$(tags) $(test_unit_CoralSockets_Poll_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Poll
else
$(cmt_local_test_unit_CoralSockets_Poll_makefile) : $(test_unit_CoralSockets_Pollcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_Poll.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_Poll) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_Poll) ] || \
	  $(not_test_unit_CoralSockets_Pollcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_Poll.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_Poll.in -tag=$(tags) $(test_unit_CoralSockets_Poll_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Poll; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_Poll_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Poll

test_unit_CoralSockets_Poll :: test_unit_CoralSockets_Pollcompile test_unit_CoralSockets_Pollinstall ;

ifdef cmt_test_unit_CoralSockets_Poll_has_prototypes

test_unit_CoralSockets_Pollprototype : $(test_unit_CoralSockets_Pollprototype_dependencies) $(cmt_local_test_unit_CoralSockets_Poll_makefile) dirs test_unit_CoralSockets_Polldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_Poll_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_Pollcompile : test_unit_CoralSockets_Pollprototype

endif

test_unit_CoralSockets_Pollcompile : $(test_unit_CoralSockets_Pollcompile_dependencies) $(cmt_local_test_unit_CoralSockets_Poll_makefile) dirs test_unit_CoralSockets_Polldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_Poll_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_Pollclean ;

test_unit_CoralSockets_Pollclean :: $(test_unit_CoralSockets_Pollclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_Poll_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_Poll_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) test_unit_CoralSockets_Pollclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $(bin)test_unit_CoralSockets_Poll_dependencies.make

install :: test_unit_CoralSockets_Pollinstall ;

test_unit_CoralSockets_Pollinstall :: test_unit_CoralSockets_Pollcompile $(test_unit_CoralSockets_Poll_dependencies) $(cmt_local_test_unit_CoralSockets_Poll_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_Poll_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_Polluninstall

$(foreach d,$(test_unit_CoralSockets_Poll_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_Polluninstall))

test_unit_CoralSockets_Polluninstall : $(test_unit_CoralSockets_Polluninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_Poll_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_Poll_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_Poll_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_Polluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_Poll"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_Poll done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_ReplyManager_has_no_target_tag = 1
cmt_test_unit_CoralSockets_ReplyManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_ReplyManager_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_ReplyManager = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_ReplyManager.make
cmt_final_setup_test_unit_CoralSockets_ReplyManager = $(bin)setup_test_unit_CoralSockets_ReplyManager.make
cmt_local_test_unit_CoralSockets_ReplyManager_makefile = $(bin)test_unit_CoralSockets_ReplyManager.make

test_unit_CoralSockets_ReplyManager_extratags = -tag_add=target_test_unit_CoralSockets_ReplyManager

else

cmt_local_tagfile_test_unit_CoralSockets_ReplyManager = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_ReplyManager = $(bin)setup.make
cmt_local_test_unit_CoralSockets_ReplyManager_makefile = $(bin)test_unit_CoralSockets_ReplyManager.make

endif

not_test_unit_CoralSockets_ReplyManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_ReplyManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_ReplyManagerdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_ReplyManager; then $(mkdir) -p $(bin)test_unit_CoralSockets_ReplyManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_ReplyManager
else
test_unit_CoralSockets_ReplyManagerdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_ReplyManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) : $(test_unit_CoralSockets_ReplyManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_ReplyManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ReplyManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManager
else
$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) : $(test_unit_CoralSockets_ReplyManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_ReplyManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_ReplyManager) ] || \
	  $(not_test_unit_CoralSockets_ReplyManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_ReplyManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ReplyManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) : $(test_unit_CoralSockets_ReplyManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_ReplyManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_ReplyManager.in -tag=$(tags) $(test_unit_CoralSockets_ReplyManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManager
else
$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) : $(test_unit_CoralSockets_ReplyManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_ReplyManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_ReplyManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_ReplyManager) ] || \
	  $(not_test_unit_CoralSockets_ReplyManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_ReplyManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_ReplyManager.in -tag=$(tags) $(test_unit_CoralSockets_ReplyManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ReplyManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManager

test_unit_CoralSockets_ReplyManager :: test_unit_CoralSockets_ReplyManagercompile test_unit_CoralSockets_ReplyManagerinstall ;

ifdef cmt_test_unit_CoralSockets_ReplyManager_has_prototypes

test_unit_CoralSockets_ReplyManagerprototype : $(test_unit_CoralSockets_ReplyManagerprototype_dependencies) $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) dirs test_unit_CoralSockets_ReplyManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_ReplyManagercompile : test_unit_CoralSockets_ReplyManagerprototype

endif

test_unit_CoralSockets_ReplyManagercompile : $(test_unit_CoralSockets_ReplyManagercompile_dependencies) $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) dirs test_unit_CoralSockets_ReplyManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_ReplyManagerclean ;

test_unit_CoralSockets_ReplyManagerclean :: $(test_unit_CoralSockets_ReplyManagerclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) test_unit_CoralSockets_ReplyManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $(bin)test_unit_CoralSockets_ReplyManager_dependencies.make

install :: test_unit_CoralSockets_ReplyManagerinstall ;

test_unit_CoralSockets_ReplyManagerinstall :: test_unit_CoralSockets_ReplyManagercompile $(test_unit_CoralSockets_ReplyManager_dependencies) $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_ReplyManageruninstall

$(foreach d,$(test_unit_CoralSockets_ReplyManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_ReplyManageruninstall))

test_unit_CoralSockets_ReplyManageruninstall : $(test_unit_CoralSockets_ReplyManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_ReplyManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ReplyManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_ReplyManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_ReplyManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_ReplyManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_RequestIterator_has_no_target_tag = 1
cmt_test_unit_CoralSockets_RequestIterator_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_RequestIterator_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_RequestIterator = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_RequestIterator.make
cmt_final_setup_test_unit_CoralSockets_RequestIterator = $(bin)setup_test_unit_CoralSockets_RequestIterator.make
cmt_local_test_unit_CoralSockets_RequestIterator_makefile = $(bin)test_unit_CoralSockets_RequestIterator.make

test_unit_CoralSockets_RequestIterator_extratags = -tag_add=target_test_unit_CoralSockets_RequestIterator

else

cmt_local_tagfile_test_unit_CoralSockets_RequestIterator = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_RequestIterator = $(bin)setup.make
cmt_local_test_unit_CoralSockets_RequestIterator_makefile = $(bin)test_unit_CoralSockets_RequestIterator.make

endif

not_test_unit_CoralSockets_RequestIteratorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_RequestIteratorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_RequestIteratordirs :
	@if test ! -d $(bin)test_unit_CoralSockets_RequestIterator; then $(mkdir) -p $(bin)test_unit_CoralSockets_RequestIterator; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_RequestIterator
else
test_unit_CoralSockets_RequestIteratordirs : ;
endif

ifdef cmt_test_unit_CoralSockets_RequestIterator_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) : $(test_unit_CoralSockets_RequestIteratorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_RequestIterator.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RequestIterator_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIterator
else
$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) : $(test_unit_CoralSockets_RequestIteratorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_RequestIterator) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_RequestIterator) ] || \
	  $(not_test_unit_CoralSockets_RequestIteratorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_RequestIterator.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RequestIterator_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIterator; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) : $(test_unit_CoralSockets_RequestIteratorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_RequestIterator.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_RequestIterator.in -tag=$(tags) $(test_unit_CoralSockets_RequestIterator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIterator
else
$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) : $(test_unit_CoralSockets_RequestIteratorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_RequestIterator.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_RequestIterator) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_RequestIterator) ] || \
	  $(not_test_unit_CoralSockets_RequestIteratorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_RequestIterator.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_RequestIterator.in -tag=$(tags) $(test_unit_CoralSockets_RequestIterator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIterator; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RequestIterator_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIterator

test_unit_CoralSockets_RequestIterator :: test_unit_CoralSockets_RequestIteratorcompile test_unit_CoralSockets_RequestIteratorinstall ;

ifdef cmt_test_unit_CoralSockets_RequestIterator_has_prototypes

test_unit_CoralSockets_RequestIteratorprototype : $(test_unit_CoralSockets_RequestIteratorprototype_dependencies) $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) dirs test_unit_CoralSockets_RequestIteratordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_RequestIteratorcompile : test_unit_CoralSockets_RequestIteratorprototype

endif

test_unit_CoralSockets_RequestIteratorcompile : $(test_unit_CoralSockets_RequestIteratorcompile_dependencies) $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) dirs test_unit_CoralSockets_RequestIteratordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_RequestIteratorclean ;

test_unit_CoralSockets_RequestIteratorclean :: $(test_unit_CoralSockets_RequestIteratorclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) test_unit_CoralSockets_RequestIteratorclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $(bin)test_unit_CoralSockets_RequestIterator_dependencies.make

install :: test_unit_CoralSockets_RequestIteratorinstall ;

test_unit_CoralSockets_RequestIteratorinstall :: test_unit_CoralSockets_RequestIteratorcompile $(test_unit_CoralSockets_RequestIterator_dependencies) $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_RequestIteratoruninstall

$(foreach d,$(test_unit_CoralSockets_RequestIterator_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_RequestIteratoruninstall))

test_unit_CoralSockets_RequestIteratoruninstall : $(test_unit_CoralSockets_RequestIteratoruninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_RequestIterator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RequestIterator_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_RequestIteratoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_RequestIterator"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_RequestIterator done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_RingBufferSocket_has_no_target_tag = 1
cmt_test_unit_CoralSockets_RingBufferSocket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_RingBufferSocket_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_RingBufferSocket = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_RingBufferSocket.make
cmt_final_setup_test_unit_CoralSockets_RingBufferSocket = $(bin)setup_test_unit_CoralSockets_RingBufferSocket.make
cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile = $(bin)test_unit_CoralSockets_RingBufferSocket.make

test_unit_CoralSockets_RingBufferSocket_extratags = -tag_add=target_test_unit_CoralSockets_RingBufferSocket

else

cmt_local_tagfile_test_unit_CoralSockets_RingBufferSocket = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_RingBufferSocket = $(bin)setup.make
cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile = $(bin)test_unit_CoralSockets_RingBufferSocket.make

endif

not_test_unit_CoralSockets_RingBufferSocketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_RingBufferSocketdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_RingBufferSocket; then $(mkdir) -p $(bin)test_unit_CoralSockets_RingBufferSocket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_RingBufferSocket
else
test_unit_CoralSockets_RingBufferSocketdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_RingBufferSocket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) : $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_RingBufferSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RingBufferSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocket
else
$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) : $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_RingBufferSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_RingBufferSocket) ] || \
	  $(not_test_unit_CoralSockets_RingBufferSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_RingBufferSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RingBufferSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) : $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_RingBufferSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_RingBufferSocket.in -tag=$(tags) $(test_unit_CoralSockets_RingBufferSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocket
else
$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) : $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_RingBufferSocket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_RingBufferSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_RingBufferSocket) ] || \
	  $(not_test_unit_CoralSockets_RingBufferSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_RingBufferSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_RingBufferSocket.in -tag=$(tags) $(test_unit_CoralSockets_RingBufferSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_RingBufferSocket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocket

test_unit_CoralSockets_RingBufferSocket :: test_unit_CoralSockets_RingBufferSocketcompile test_unit_CoralSockets_RingBufferSocketinstall ;

ifdef cmt_test_unit_CoralSockets_RingBufferSocket_has_prototypes

test_unit_CoralSockets_RingBufferSocketprototype : $(test_unit_CoralSockets_RingBufferSocketprototype_dependencies) $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) dirs test_unit_CoralSockets_RingBufferSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_RingBufferSocketcompile : test_unit_CoralSockets_RingBufferSocketprototype

endif

test_unit_CoralSockets_RingBufferSocketcompile : $(test_unit_CoralSockets_RingBufferSocketcompile_dependencies) $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) dirs test_unit_CoralSockets_RingBufferSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_RingBufferSocketclean ;

test_unit_CoralSockets_RingBufferSocketclean :: $(test_unit_CoralSockets_RingBufferSocketclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) test_unit_CoralSockets_RingBufferSocketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $(bin)test_unit_CoralSockets_RingBufferSocket_dependencies.make

install :: test_unit_CoralSockets_RingBufferSocketinstall ;

test_unit_CoralSockets_RingBufferSocketinstall :: test_unit_CoralSockets_RingBufferSocketcompile $(test_unit_CoralSockets_RingBufferSocket_dependencies) $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_RingBufferSocketuninstall

$(foreach d,$(test_unit_CoralSockets_RingBufferSocket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_RingBufferSocketuninstall))

test_unit_CoralSockets_RingBufferSocketuninstall : $(test_unit_CoralSockets_RingBufferSocketuninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_RingBufferSocket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_RingBufferSocketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_RingBufferSocket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_RingBufferSocket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_SocketContext_has_no_target_tag = 1
cmt_test_unit_CoralSockets_SocketContext_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_SocketContext_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_SocketContext = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_SocketContext.make
cmt_final_setup_test_unit_CoralSockets_SocketContext = $(bin)setup_test_unit_CoralSockets_SocketContext.make
cmt_local_test_unit_CoralSockets_SocketContext_makefile = $(bin)test_unit_CoralSockets_SocketContext.make

test_unit_CoralSockets_SocketContext_extratags = -tag_add=target_test_unit_CoralSockets_SocketContext

else

cmt_local_tagfile_test_unit_CoralSockets_SocketContext = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_SocketContext = $(bin)setup.make
cmt_local_test_unit_CoralSockets_SocketContext_makefile = $(bin)test_unit_CoralSockets_SocketContext.make

endif

not_test_unit_CoralSockets_SocketContextcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_SocketContextcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_SocketContextdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_SocketContext; then $(mkdir) -p $(bin)test_unit_CoralSockets_SocketContext; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_SocketContext
else
test_unit_CoralSockets_SocketContextdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_SocketContext_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) : $(test_unit_CoralSockets_SocketContextcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketContext.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketContext_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContext
else
$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) : $(test_unit_CoralSockets_SocketContextcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketContext) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketContext) ] || \
	  $(not_test_unit_CoralSockets_SocketContextcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketContext.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketContext_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContext; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) : $(test_unit_CoralSockets_SocketContextcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketContext.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketContext.in -tag=$(tags) $(test_unit_CoralSockets_SocketContext_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContext
else
$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) : $(test_unit_CoralSockets_SocketContextcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_SocketContext.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketContext) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketContext) ] || \
	  $(not_test_unit_CoralSockets_SocketContextcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketContext.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketContext.in -tag=$(tags) $(test_unit_CoralSockets_SocketContext_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContext; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketContext_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContext

test_unit_CoralSockets_SocketContext :: test_unit_CoralSockets_SocketContextcompile test_unit_CoralSockets_SocketContextinstall ;

ifdef cmt_test_unit_CoralSockets_SocketContext_has_prototypes

test_unit_CoralSockets_SocketContextprototype : $(test_unit_CoralSockets_SocketContextprototype_dependencies) $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) dirs test_unit_CoralSockets_SocketContextdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_SocketContextcompile : test_unit_CoralSockets_SocketContextprototype

endif

test_unit_CoralSockets_SocketContextcompile : $(test_unit_CoralSockets_SocketContextcompile_dependencies) $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) dirs test_unit_CoralSockets_SocketContextdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_SocketContextclean ;

test_unit_CoralSockets_SocketContextclean :: $(test_unit_CoralSockets_SocketContextclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketContext_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) test_unit_CoralSockets_SocketContextclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $(bin)test_unit_CoralSockets_SocketContext_dependencies.make

install :: test_unit_CoralSockets_SocketContextinstall ;

test_unit_CoralSockets_SocketContextinstall :: test_unit_CoralSockets_SocketContextcompile $(test_unit_CoralSockets_SocketContext_dependencies) $(cmt_local_test_unit_CoralSockets_SocketContext_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_SocketContextuninstall

$(foreach d,$(test_unit_CoralSockets_SocketContext_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_SocketContextuninstall))

test_unit_CoralSockets_SocketContextuninstall : $(test_unit_CoralSockets_SocketContextuninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketContext_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketContext_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_SocketContextuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_SocketContext"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_SocketContext done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_SocketRequestHandler_has_no_target_tag = 1
cmt_test_unit_CoralSockets_SocketRequestHandler_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_SocketRequestHandler_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_SocketRequestHandler = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_SocketRequestHandler.make
cmt_final_setup_test_unit_CoralSockets_SocketRequestHandler = $(bin)setup_test_unit_CoralSockets_SocketRequestHandler.make
cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile = $(bin)test_unit_CoralSockets_SocketRequestHandler.make

test_unit_CoralSockets_SocketRequestHandler_extratags = -tag_add=target_test_unit_CoralSockets_SocketRequestHandler

else

cmt_local_tagfile_test_unit_CoralSockets_SocketRequestHandler = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_SocketRequestHandler = $(bin)setup.make
cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile = $(bin)test_unit_CoralSockets_SocketRequestHandler.make

endif

not_test_unit_CoralSockets_SocketRequestHandlercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_SocketRequestHandlerdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_SocketRequestHandler; then $(mkdir) -p $(bin)test_unit_CoralSockets_SocketRequestHandler; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_SocketRequestHandler
else
test_unit_CoralSockets_SocketRequestHandlerdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_SocketRequestHandler_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) : $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketRequestHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketRequestHandler_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandler
else
$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) : $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketRequestHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketRequestHandler) ] || \
	  $(not_test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketRequestHandler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketRequestHandler_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandler; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) : $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketRequestHandler.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketRequestHandler.in -tag=$(tags) $(test_unit_CoralSockets_SocketRequestHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandler
else
$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) : $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_SocketRequestHandler.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketRequestHandler) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketRequestHandler) ] || \
	  $(not_test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketRequestHandler.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketRequestHandler.in -tag=$(tags) $(test_unit_CoralSockets_SocketRequestHandler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandler; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketRequestHandler_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandler

test_unit_CoralSockets_SocketRequestHandler :: test_unit_CoralSockets_SocketRequestHandlercompile test_unit_CoralSockets_SocketRequestHandlerinstall ;

ifdef cmt_test_unit_CoralSockets_SocketRequestHandler_has_prototypes

test_unit_CoralSockets_SocketRequestHandlerprototype : $(test_unit_CoralSockets_SocketRequestHandlerprototype_dependencies) $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) dirs test_unit_CoralSockets_SocketRequestHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_SocketRequestHandlercompile : test_unit_CoralSockets_SocketRequestHandlerprototype

endif

test_unit_CoralSockets_SocketRequestHandlercompile : $(test_unit_CoralSockets_SocketRequestHandlercompile_dependencies) $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) dirs test_unit_CoralSockets_SocketRequestHandlerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_SocketRequestHandlerclean ;

test_unit_CoralSockets_SocketRequestHandlerclean :: $(test_unit_CoralSockets_SocketRequestHandlerclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) test_unit_CoralSockets_SocketRequestHandlerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $(bin)test_unit_CoralSockets_SocketRequestHandler_dependencies.make

install :: test_unit_CoralSockets_SocketRequestHandlerinstall ;

test_unit_CoralSockets_SocketRequestHandlerinstall :: test_unit_CoralSockets_SocketRequestHandlercompile $(test_unit_CoralSockets_SocketRequestHandler_dependencies) $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_SocketRequestHandleruninstall

$(foreach d,$(test_unit_CoralSockets_SocketRequestHandler_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_SocketRequestHandleruninstall))

test_unit_CoralSockets_SocketRequestHandleruninstall : $(test_unit_CoralSockets_SocketRequestHandleruninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketRequestHandler_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_SocketRequestHandleruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_SocketRequestHandler"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_SocketRequestHandler done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_SocketThread_has_no_target_tag = 1
cmt_test_unit_CoralSockets_SocketThread_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_SocketThread_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_SocketThread = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_SocketThread.make
cmt_final_setup_test_unit_CoralSockets_SocketThread = $(bin)setup_test_unit_CoralSockets_SocketThread.make
cmt_local_test_unit_CoralSockets_SocketThread_makefile = $(bin)test_unit_CoralSockets_SocketThread.make

test_unit_CoralSockets_SocketThread_extratags = -tag_add=target_test_unit_CoralSockets_SocketThread

else

cmt_local_tagfile_test_unit_CoralSockets_SocketThread = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_SocketThread = $(bin)setup.make
cmt_local_test_unit_CoralSockets_SocketThread_makefile = $(bin)test_unit_CoralSockets_SocketThread.make

endif

not_test_unit_CoralSockets_SocketThreadcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_SocketThreadcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_SocketThreaddirs :
	@if test ! -d $(bin)test_unit_CoralSockets_SocketThread; then $(mkdir) -p $(bin)test_unit_CoralSockets_SocketThread; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_SocketThread
else
test_unit_CoralSockets_SocketThreaddirs : ;
endif

ifdef cmt_test_unit_CoralSockets_SocketThread_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) : $(test_unit_CoralSockets_SocketThreadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketThread.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketThread_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThread
else
$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) : $(test_unit_CoralSockets_SocketThreadcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketThread) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketThread) ] || \
	  $(not_test_unit_CoralSockets_SocketThreadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketThread.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketThread_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThread; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) : $(test_unit_CoralSockets_SocketThreadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SocketThread.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketThread.in -tag=$(tags) $(test_unit_CoralSockets_SocketThread_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThread
else
$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) : $(test_unit_CoralSockets_SocketThreadcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_SocketThread.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SocketThread) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SocketThread) ] || \
	  $(not_test_unit_CoralSockets_SocketThreadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SocketThread.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SocketThread.in -tag=$(tags) $(test_unit_CoralSockets_SocketThread_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThread; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SocketThread_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThread

test_unit_CoralSockets_SocketThread :: test_unit_CoralSockets_SocketThreadcompile test_unit_CoralSockets_SocketThreadinstall ;

ifdef cmt_test_unit_CoralSockets_SocketThread_has_prototypes

test_unit_CoralSockets_SocketThreadprototype : $(test_unit_CoralSockets_SocketThreadprototype_dependencies) $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) dirs test_unit_CoralSockets_SocketThreaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_SocketThreadcompile : test_unit_CoralSockets_SocketThreadprototype

endif

test_unit_CoralSockets_SocketThreadcompile : $(test_unit_CoralSockets_SocketThreadcompile_dependencies) $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) dirs test_unit_CoralSockets_SocketThreaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_SocketThreadclean ;

test_unit_CoralSockets_SocketThreadclean :: $(test_unit_CoralSockets_SocketThreadclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketThread_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) test_unit_CoralSockets_SocketThreadclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $(bin)test_unit_CoralSockets_SocketThread_dependencies.make

install :: test_unit_CoralSockets_SocketThreadinstall ;

test_unit_CoralSockets_SocketThreadinstall :: test_unit_CoralSockets_SocketThreadcompile $(test_unit_CoralSockets_SocketThread_dependencies) $(cmt_local_test_unit_CoralSockets_SocketThread_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_SocketThreaduninstall

$(foreach d,$(test_unit_CoralSockets_SocketThread_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_SocketThreaduninstall))

test_unit_CoralSockets_SocketThreaduninstall : $(test_unit_CoralSockets_SocketThreaduninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_SocketThread_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SocketThread_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_SocketThreaduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_SocketThread"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_SocketThread done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_SslSocket_has_no_target_tag = 1
cmt_test_unit_CoralSockets_SslSocket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_SslSocket_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_SslSocket = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_SslSocket.make
cmt_final_setup_test_unit_CoralSockets_SslSocket = $(bin)setup_test_unit_CoralSockets_SslSocket.make
cmt_local_test_unit_CoralSockets_SslSocket_makefile = $(bin)test_unit_CoralSockets_SslSocket.make

test_unit_CoralSockets_SslSocket_extratags = -tag_add=target_test_unit_CoralSockets_SslSocket

else

cmt_local_tagfile_test_unit_CoralSockets_SslSocket = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_SslSocket = $(bin)setup.make
cmt_local_test_unit_CoralSockets_SslSocket_makefile = $(bin)test_unit_CoralSockets_SslSocket.make

endif

not_test_unit_CoralSockets_SslSocketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_SslSocketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_SslSocketdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_SslSocket; then $(mkdir) -p $(bin)test_unit_CoralSockets_SslSocket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_SslSocket
else
test_unit_CoralSockets_SslSocketdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_SslSocket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) : $(test_unit_CoralSockets_SslSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SslSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SslSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocket
else
$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) : $(test_unit_CoralSockets_SslSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SslSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SslSocket) ] || \
	  $(not_test_unit_CoralSockets_SslSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SslSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SslSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) : $(test_unit_CoralSockets_SslSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_SslSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SslSocket.in -tag=$(tags) $(test_unit_CoralSockets_SslSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocket
else
$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) : $(test_unit_CoralSockets_SslSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_SslSocket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_SslSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_SslSocket) ] || \
	  $(not_test_unit_CoralSockets_SslSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_SslSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_SslSocket.in -tag=$(tags) $(test_unit_CoralSockets_SslSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_SslSocket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocket

test_unit_CoralSockets_SslSocket :: test_unit_CoralSockets_SslSocketcompile test_unit_CoralSockets_SslSocketinstall ;

ifdef cmt_test_unit_CoralSockets_SslSocket_has_prototypes

test_unit_CoralSockets_SslSocketprototype : $(test_unit_CoralSockets_SslSocketprototype_dependencies) $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) dirs test_unit_CoralSockets_SslSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_SslSocketcompile : test_unit_CoralSockets_SslSocketprototype

endif

test_unit_CoralSockets_SslSocketcompile : $(test_unit_CoralSockets_SslSocketcompile_dependencies) $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) dirs test_unit_CoralSockets_SslSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_SslSocketclean ;

test_unit_CoralSockets_SslSocketclean :: $(test_unit_CoralSockets_SslSocketclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_SslSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) test_unit_CoralSockets_SslSocketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $(bin)test_unit_CoralSockets_SslSocket_dependencies.make

install :: test_unit_CoralSockets_SslSocketinstall ;

test_unit_CoralSockets_SslSocketinstall :: test_unit_CoralSockets_SslSocketcompile $(test_unit_CoralSockets_SslSocket_dependencies) $(cmt_local_test_unit_CoralSockets_SslSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_SslSocketuninstall

$(foreach d,$(test_unit_CoralSockets_SslSocket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_SslSocketuninstall))

test_unit_CoralSockets_SslSocketuninstall : $(test_unit_CoralSockets_SslSocketuninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_SslSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_SslSocket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_SslSocketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_SslSocket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_SslSocket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_TcpSocket_has_no_target_tag = 1
cmt_test_unit_CoralSockets_TcpSocket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_TcpSocket_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_TcpSocket = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_TcpSocket.make
cmt_final_setup_test_unit_CoralSockets_TcpSocket = $(bin)setup_test_unit_CoralSockets_TcpSocket.make
cmt_local_test_unit_CoralSockets_TcpSocket_makefile = $(bin)test_unit_CoralSockets_TcpSocket.make

test_unit_CoralSockets_TcpSocket_extratags = -tag_add=target_test_unit_CoralSockets_TcpSocket

else

cmt_local_tagfile_test_unit_CoralSockets_TcpSocket = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_TcpSocket = $(bin)setup.make
cmt_local_test_unit_CoralSockets_TcpSocket_makefile = $(bin)test_unit_CoralSockets_TcpSocket.make

endif

not_test_unit_CoralSockets_TcpSocketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_TcpSocketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_TcpSocketdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_TcpSocket; then $(mkdir) -p $(bin)test_unit_CoralSockets_TcpSocket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_TcpSocket
else
test_unit_CoralSockets_TcpSocketdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_TcpSocket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) : $(test_unit_CoralSockets_TcpSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_TcpSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_TcpSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocket
else
$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) : $(test_unit_CoralSockets_TcpSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_TcpSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_TcpSocket) ] || \
	  $(not_test_unit_CoralSockets_TcpSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_TcpSocket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_TcpSocket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) : $(test_unit_CoralSockets_TcpSocketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_TcpSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_TcpSocket.in -tag=$(tags) $(test_unit_CoralSockets_TcpSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocket
else
$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) : $(test_unit_CoralSockets_TcpSocketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_TcpSocket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_TcpSocket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_TcpSocket) ] || \
	  $(not_test_unit_CoralSockets_TcpSocketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_TcpSocket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_TcpSocket.in -tag=$(tags) $(test_unit_CoralSockets_TcpSocket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_TcpSocket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocket

test_unit_CoralSockets_TcpSocket :: test_unit_CoralSockets_TcpSocketcompile test_unit_CoralSockets_TcpSocketinstall ;

ifdef cmt_test_unit_CoralSockets_TcpSocket_has_prototypes

test_unit_CoralSockets_TcpSocketprototype : $(test_unit_CoralSockets_TcpSocketprototype_dependencies) $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) dirs test_unit_CoralSockets_TcpSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_TcpSocketcompile : test_unit_CoralSockets_TcpSocketprototype

endif

test_unit_CoralSockets_TcpSocketcompile : $(test_unit_CoralSockets_TcpSocketcompile_dependencies) $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) dirs test_unit_CoralSockets_TcpSocketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_TcpSocketclean ;

test_unit_CoralSockets_TcpSocketclean :: $(test_unit_CoralSockets_TcpSocketclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) test_unit_CoralSockets_TcpSocketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $(bin)test_unit_CoralSockets_TcpSocket_dependencies.make

install :: test_unit_CoralSockets_TcpSocketinstall ;

test_unit_CoralSockets_TcpSocketinstall :: test_unit_CoralSockets_TcpSocketcompile $(test_unit_CoralSockets_TcpSocket_dependencies) $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_TcpSocketuninstall

$(foreach d,$(test_unit_CoralSockets_TcpSocket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_TcpSocketuninstall))

test_unit_CoralSockets_TcpSocketuninstall : $(test_unit_CoralSockets_TcpSocketuninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_TcpSocket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_TcpSocket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_TcpSocketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_TcpSocket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_TcpSocket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralSockets_ThreadManager_has_no_target_tag = 1
cmt_test_unit_CoralSockets_ThreadManager_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralSockets_ThreadManager_has_target_tag

cmt_local_tagfile_test_unit_CoralSockets_ThreadManager = $(bin)$(CoralSockets_tag)_test_unit_CoralSockets_ThreadManager.make
cmt_final_setup_test_unit_CoralSockets_ThreadManager = $(bin)setup_test_unit_CoralSockets_ThreadManager.make
cmt_local_test_unit_CoralSockets_ThreadManager_makefile = $(bin)test_unit_CoralSockets_ThreadManager.make

test_unit_CoralSockets_ThreadManager_extratags = -tag_add=target_test_unit_CoralSockets_ThreadManager

else

cmt_local_tagfile_test_unit_CoralSockets_ThreadManager = $(bin)$(CoralSockets_tag).make
cmt_final_setup_test_unit_CoralSockets_ThreadManager = $(bin)setup.make
cmt_local_test_unit_CoralSockets_ThreadManager_makefile = $(bin)test_unit_CoralSockets_ThreadManager.make

endif

not_test_unit_CoralSockets_ThreadManagercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralSockets_ThreadManagercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralSockets_ThreadManagerdirs :
	@if test ! -d $(bin)test_unit_CoralSockets_ThreadManager; then $(mkdir) -p $(bin)test_unit_CoralSockets_ThreadManager; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralSockets_ThreadManager
else
test_unit_CoralSockets_ThreadManagerdirs : ;
endif

ifdef cmt_test_unit_CoralSockets_ThreadManager_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) : $(test_unit_CoralSockets_ThreadManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_ThreadManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ThreadManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManager
else
$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) : $(test_unit_CoralSockets_ThreadManagercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_ThreadManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_ThreadManager) ] || \
	  $(not_test_unit_CoralSockets_ThreadManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_ThreadManager.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ThreadManager_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManager; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) : $(test_unit_CoralSockets_ThreadManagercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralSockets_ThreadManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_ThreadManager.in -tag=$(tags) $(test_unit_CoralSockets_ThreadManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManager
else
$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) : $(test_unit_CoralSockets_ThreadManagercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralSockets_ThreadManager.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralSockets_ThreadManager) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralSockets_ThreadManager) ] || \
	  $(not_test_unit_CoralSockets_ThreadManagercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralSockets_ThreadManager.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralSockets_ThreadManager.in -tag=$(tags) $(test_unit_CoralSockets_ThreadManager_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManager; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralSockets_ThreadManager_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManager

test_unit_CoralSockets_ThreadManager :: test_unit_CoralSockets_ThreadManagercompile test_unit_CoralSockets_ThreadManagerinstall ;

ifdef cmt_test_unit_CoralSockets_ThreadManager_has_prototypes

test_unit_CoralSockets_ThreadManagerprototype : $(test_unit_CoralSockets_ThreadManagerprototype_dependencies) $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) dirs test_unit_CoralSockets_ThreadManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralSockets_ThreadManagercompile : test_unit_CoralSockets_ThreadManagerprototype

endif

test_unit_CoralSockets_ThreadManagercompile : $(test_unit_CoralSockets_ThreadManagercompile_dependencies) $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) dirs test_unit_CoralSockets_ThreadManagerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralSockets_ThreadManagerclean ;

test_unit_CoralSockets_ThreadManagerclean :: $(test_unit_CoralSockets_ThreadManagerclean_dependencies) ##$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) test_unit_CoralSockets_ThreadManagerclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $(bin)test_unit_CoralSockets_ThreadManager_dependencies.make

install :: test_unit_CoralSockets_ThreadManagerinstall ;

test_unit_CoralSockets_ThreadManagerinstall :: test_unit_CoralSockets_ThreadManagercompile $(test_unit_CoralSockets_ThreadManager_dependencies) $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralSockets_ThreadManageruninstall

$(foreach d,$(test_unit_CoralSockets_ThreadManager_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralSockets_ThreadManageruninstall))

test_unit_CoralSockets_ThreadManageruninstall : $(test_unit_CoralSockets_ThreadManageruninstall_dependencies) ##$(cmt_local_test_unit_CoralSockets_ThreadManager_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralSockets_ThreadManager_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralSockets_ThreadManageruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralSockets_ThreadManager"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralSockets_ThreadManager done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralDummyPollServer_has_no_target_tag = 1
cmt_coralDummyPollServer_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralDummyPollServer_has_target_tag

cmt_local_tagfile_coralDummyPollServer = $(bin)$(CoralSockets_tag)_coralDummyPollServer.make
cmt_final_setup_coralDummyPollServer = $(bin)setup_coralDummyPollServer.make
cmt_local_coralDummyPollServer_makefile = $(bin)coralDummyPollServer.make

coralDummyPollServer_extratags = -tag_add=target_coralDummyPollServer

else

cmt_local_tagfile_coralDummyPollServer = $(bin)$(CoralSockets_tag).make
cmt_final_setup_coralDummyPollServer = $(bin)setup.make
cmt_local_coralDummyPollServer_makefile = $(bin)coralDummyPollServer.make

endif

not_coralDummyPollServercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralDummyPollServercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralDummyPollServerdirs :
	@if test ! -d $(bin)coralDummyPollServer; then $(mkdir) -p $(bin)coralDummyPollServer; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralDummyPollServer
else
coralDummyPollServerdirs : ;
endif

ifdef cmt_coralDummyPollServer_has_target_tag

ifndef QUICK
$(cmt_local_coralDummyPollServer_makefile) : $(coralDummyPollServercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummyPollServer.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummyPollServer_extratags) build constituent_config -out=$(cmt_local_coralDummyPollServer_makefile) coralDummyPollServer
else
$(cmt_local_coralDummyPollServer_makefile) : $(coralDummyPollServercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummyPollServer) ] || \
	  [ ! -f $(cmt_final_setup_coralDummyPollServer) ] || \
	  $(not_coralDummyPollServercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummyPollServer.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummyPollServer_extratags) build constituent_config -out=$(cmt_local_coralDummyPollServer_makefile) coralDummyPollServer; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralDummyPollServer_makefile) : $(coralDummyPollServercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummyPollServer.make"; \
	  $(cmtexe) -f=$(bin)coralDummyPollServer.in -tag=$(tags) $(coralDummyPollServer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummyPollServer_makefile) coralDummyPollServer
else
$(cmt_local_coralDummyPollServer_makefile) : $(coralDummyPollServercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralDummyPollServer.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummyPollServer) ] || \
	  [ ! -f $(cmt_final_setup_coralDummyPollServer) ] || \
	  $(not_coralDummyPollServercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummyPollServer.make"; \
	  $(cmtexe) -f=$(bin)coralDummyPollServer.in -tag=$(tags) $(coralDummyPollServer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummyPollServer_makefile) coralDummyPollServer; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralDummyPollServer_extratags) build constituent_makefile -out=$(cmt_local_coralDummyPollServer_makefile) coralDummyPollServer

coralDummyPollServer :: coralDummyPollServercompile coralDummyPollServerinstall ;

ifdef cmt_coralDummyPollServer_has_prototypes

coralDummyPollServerprototype : $(coralDummyPollServerprototype_dependencies) $(cmt_local_coralDummyPollServer_makefile) dirs coralDummyPollServerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummyPollServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralDummyPollServercompile : coralDummyPollServerprototype

endif

coralDummyPollServercompile : $(coralDummyPollServercompile_dependencies) $(cmt_local_coralDummyPollServer_makefile) dirs coralDummyPollServerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummyPollServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralDummyPollServerclean ;

coralDummyPollServerclean :: $(coralDummyPollServerclean_dependencies) ##$(cmt_local_coralDummyPollServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummyPollServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) coralDummyPollServerclean

##	  /bin/rm -f $(cmt_local_coralDummyPollServer_makefile) $(bin)coralDummyPollServer_dependencies.make

install :: coralDummyPollServerinstall ;

coralDummyPollServerinstall :: coralDummyPollServercompile $(coralDummyPollServer_dependencies) $(cmt_local_coralDummyPollServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummyPollServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralDummyPollServeruninstall

$(foreach d,$(coralDummyPollServer_dependencies),$(eval $(d)uninstall_dependencies += coralDummyPollServeruninstall))

coralDummyPollServeruninstall : $(coralDummyPollServeruninstall_dependencies) ##$(cmt_local_coralDummyPollServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummyPollServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummyPollServer_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralDummyPollServeruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralDummyPollServer"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralDummyPollServer done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralDummySocketClient_has_no_target_tag = 1
cmt_coralDummySocketClient_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralDummySocketClient_has_target_tag

cmt_local_tagfile_coralDummySocketClient = $(bin)$(CoralSockets_tag)_coralDummySocketClient.make
cmt_final_setup_coralDummySocketClient = $(bin)setup_coralDummySocketClient.make
cmt_local_coralDummySocketClient_makefile = $(bin)coralDummySocketClient.make

coralDummySocketClient_extratags = -tag_add=target_coralDummySocketClient

else

cmt_local_tagfile_coralDummySocketClient = $(bin)$(CoralSockets_tag).make
cmt_final_setup_coralDummySocketClient = $(bin)setup.make
cmt_local_coralDummySocketClient_makefile = $(bin)coralDummySocketClient.make

endif

not_coralDummySocketClientcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralDummySocketClientcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralDummySocketClientdirs :
	@if test ! -d $(bin)coralDummySocketClient; then $(mkdir) -p $(bin)coralDummySocketClient; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralDummySocketClient
else
coralDummySocketClientdirs : ;
endif

ifdef cmt_coralDummySocketClient_has_target_tag

ifndef QUICK
$(cmt_local_coralDummySocketClient_makefile) : $(coralDummySocketClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummySocketClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummySocketClient_extratags) build constituent_config -out=$(cmt_local_coralDummySocketClient_makefile) coralDummySocketClient
else
$(cmt_local_coralDummySocketClient_makefile) : $(coralDummySocketClientcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummySocketClient) ] || \
	  [ ! -f $(cmt_final_setup_coralDummySocketClient) ] || \
	  $(not_coralDummySocketClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummySocketClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummySocketClient_extratags) build constituent_config -out=$(cmt_local_coralDummySocketClient_makefile) coralDummySocketClient; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralDummySocketClient_makefile) : $(coralDummySocketClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummySocketClient.make"; \
	  $(cmtexe) -f=$(bin)coralDummySocketClient.in -tag=$(tags) $(coralDummySocketClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummySocketClient_makefile) coralDummySocketClient
else
$(cmt_local_coralDummySocketClient_makefile) : $(coralDummySocketClientcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralDummySocketClient.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummySocketClient) ] || \
	  [ ! -f $(cmt_final_setup_coralDummySocketClient) ] || \
	  $(not_coralDummySocketClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummySocketClient.make"; \
	  $(cmtexe) -f=$(bin)coralDummySocketClient.in -tag=$(tags) $(coralDummySocketClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummySocketClient_makefile) coralDummySocketClient; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralDummySocketClient_extratags) build constituent_makefile -out=$(cmt_local_coralDummySocketClient_makefile) coralDummySocketClient

coralDummySocketClient :: coralDummySocketClientcompile coralDummySocketClientinstall ;

ifdef cmt_coralDummySocketClient_has_prototypes

coralDummySocketClientprototype : $(coralDummySocketClientprototype_dependencies) $(cmt_local_coralDummySocketClient_makefile) dirs coralDummySocketClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralDummySocketClientcompile : coralDummySocketClientprototype

endif

coralDummySocketClientcompile : $(coralDummySocketClientcompile_dependencies) $(cmt_local_coralDummySocketClient_makefile) dirs coralDummySocketClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralDummySocketClientclean ;

coralDummySocketClientclean :: $(coralDummySocketClientclean_dependencies) ##$(cmt_local_coralDummySocketClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummySocketClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) coralDummySocketClientclean

##	  /bin/rm -f $(cmt_local_coralDummySocketClient_makefile) $(bin)coralDummySocketClient_dependencies.make

install :: coralDummySocketClientinstall ;

coralDummySocketClientinstall :: coralDummySocketClientcompile $(coralDummySocketClient_dependencies) $(cmt_local_coralDummySocketClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralDummySocketClientuninstall

$(foreach d,$(coralDummySocketClient_dependencies),$(eval $(d)uninstall_dependencies += coralDummySocketClientuninstall))

coralDummySocketClientuninstall : $(coralDummySocketClientuninstall_dependencies) ##$(cmt_local_coralDummySocketClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummySocketClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketClient_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralDummySocketClientuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralDummySocketClient"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralDummySocketClient done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralDummySocketServer_has_no_target_tag = 1
cmt_coralDummySocketServer_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralDummySocketServer_has_target_tag

cmt_local_tagfile_coralDummySocketServer = $(bin)$(CoralSockets_tag)_coralDummySocketServer.make
cmt_final_setup_coralDummySocketServer = $(bin)setup_coralDummySocketServer.make
cmt_local_coralDummySocketServer_makefile = $(bin)coralDummySocketServer.make

coralDummySocketServer_extratags = -tag_add=target_coralDummySocketServer

else

cmt_local_tagfile_coralDummySocketServer = $(bin)$(CoralSockets_tag).make
cmt_final_setup_coralDummySocketServer = $(bin)setup.make
cmt_local_coralDummySocketServer_makefile = $(bin)coralDummySocketServer.make

endif

not_coralDummySocketServercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralDummySocketServercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralDummySocketServerdirs :
	@if test ! -d $(bin)coralDummySocketServer; then $(mkdir) -p $(bin)coralDummySocketServer; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralDummySocketServer
else
coralDummySocketServerdirs : ;
endif

ifdef cmt_coralDummySocketServer_has_target_tag

ifndef QUICK
$(cmt_local_coralDummySocketServer_makefile) : $(coralDummySocketServercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummySocketServer.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummySocketServer_extratags) build constituent_config -out=$(cmt_local_coralDummySocketServer_makefile) coralDummySocketServer
else
$(cmt_local_coralDummySocketServer_makefile) : $(coralDummySocketServercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummySocketServer) ] || \
	  [ ! -f $(cmt_final_setup_coralDummySocketServer) ] || \
	  $(not_coralDummySocketServercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummySocketServer.make"; \
	  $(cmtexe) -tag=$(tags) $(coralDummySocketServer_extratags) build constituent_config -out=$(cmt_local_coralDummySocketServer_makefile) coralDummySocketServer; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralDummySocketServer_makefile) : $(coralDummySocketServercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralDummySocketServer.make"; \
	  $(cmtexe) -f=$(bin)coralDummySocketServer.in -tag=$(tags) $(coralDummySocketServer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummySocketServer_makefile) coralDummySocketServer
else
$(cmt_local_coralDummySocketServer_makefile) : $(coralDummySocketServercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralDummySocketServer.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralDummySocketServer) ] || \
	  [ ! -f $(cmt_final_setup_coralDummySocketServer) ] || \
	  $(not_coralDummySocketServercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralDummySocketServer.make"; \
	  $(cmtexe) -f=$(bin)coralDummySocketServer.in -tag=$(tags) $(coralDummySocketServer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralDummySocketServer_makefile) coralDummySocketServer; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralDummySocketServer_extratags) build constituent_makefile -out=$(cmt_local_coralDummySocketServer_makefile) coralDummySocketServer

coralDummySocketServer :: coralDummySocketServercompile coralDummySocketServerinstall ;

ifdef cmt_coralDummySocketServer_has_prototypes

coralDummySocketServerprototype : $(coralDummySocketServerprototype_dependencies) $(cmt_local_coralDummySocketServer_makefile) dirs coralDummySocketServerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralDummySocketServercompile : coralDummySocketServerprototype

endif

coralDummySocketServercompile : $(coralDummySocketServercompile_dependencies) $(cmt_local_coralDummySocketServer_makefile) dirs coralDummySocketServerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralDummySocketServerclean ;

coralDummySocketServerclean :: $(coralDummySocketServerclean_dependencies) ##$(cmt_local_coralDummySocketServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummySocketServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) coralDummySocketServerclean

##	  /bin/rm -f $(cmt_local_coralDummySocketServer_makefile) $(bin)coralDummySocketServer_dependencies.make

install :: coralDummySocketServerinstall ;

coralDummySocketServerinstall :: coralDummySocketServercompile $(coralDummySocketServer_dependencies) $(cmt_local_coralDummySocketServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralDummySocketServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralDummySocketServeruninstall

$(foreach d,$(coralDummySocketServer_dependencies),$(eval $(d)uninstall_dependencies += coralDummySocketServeruninstall))

coralDummySocketServeruninstall : $(coralDummySocketServeruninstall_dependencies) ##$(cmt_local_coralDummySocketServer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralDummySocketServer_makefile); then \
	  $(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralDummySocketServer_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralDummySocketServeruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralDummySocketServer"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralDummySocketServer done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralReplayClient_has_no_target_tag = 1
cmt_coralReplayClient_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralReplayClient_has_target_tag

cmt_local_tagfile_coralReplayClient = $(bin)$(CoralSockets_tag)_coralReplayClient.make
cmt_final_setup_coralReplayClient = $(bin)setup_coralReplayClient.make
cmt_local_coralReplayClient_makefile = $(bin)coralReplayClient.make

coralReplayClient_extratags = -tag_add=target_coralReplayClient

else

cmt_local_tagfile_coralReplayClient = $(bin)$(CoralSockets_tag).make
cmt_final_setup_coralReplayClient = $(bin)setup.make
cmt_local_coralReplayClient_makefile = $(bin)coralReplayClient.make

endif

not_coralReplayClientcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralReplayClientcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralReplayClientdirs :
	@if test ! -d $(bin)coralReplayClient; then $(mkdir) -p $(bin)coralReplayClient; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralReplayClient
else
coralReplayClientdirs : ;
endif

ifdef cmt_coralReplayClient_has_target_tag

ifndef QUICK
$(cmt_local_coralReplayClient_makefile) : $(coralReplayClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralReplayClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralReplayClient_extratags) build constituent_config -out=$(cmt_local_coralReplayClient_makefile) coralReplayClient
else
$(cmt_local_coralReplayClient_makefile) : $(coralReplayClientcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralReplayClient) ] || \
	  [ ! -f $(cmt_final_setup_coralReplayClient) ] || \
	  $(not_coralReplayClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralReplayClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralReplayClient_extratags) build constituent_config -out=$(cmt_local_coralReplayClient_makefile) coralReplayClient; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralReplayClient_makefile) : $(coralReplayClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralReplayClient.make"; \
	  $(cmtexe) -f=$(bin)coralReplayClient.in -tag=$(tags) $(coralReplayClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralReplayClient_makefile) coralReplayClient
else
$(cmt_local_coralReplayClient_makefile) : $(coralReplayClientcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralReplayClient.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralReplayClient) ] || \
	  [ ! -f $(cmt_final_setup_coralReplayClient) ] || \
	  $(not_coralReplayClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralReplayClient.make"; \
	  $(cmtexe) -f=$(bin)coralReplayClient.in -tag=$(tags) $(coralReplayClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralReplayClient_makefile) coralReplayClient; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralReplayClient_extratags) build constituent_makefile -out=$(cmt_local_coralReplayClient_makefile) coralReplayClient

coralReplayClient :: coralReplayClientcompile coralReplayClientinstall ;

ifdef cmt_coralReplayClient_has_prototypes

coralReplayClientprototype : $(coralReplayClientprototype_dependencies) $(cmt_local_coralReplayClient_makefile) dirs coralReplayClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralReplayClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralReplayClientcompile : coralReplayClientprototype

endif

coralReplayClientcompile : $(coralReplayClientcompile_dependencies) $(cmt_local_coralReplayClient_makefile) dirs coralReplayClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralReplayClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralReplayClientclean ;

coralReplayClientclean :: $(coralReplayClientclean_dependencies) ##$(cmt_local_coralReplayClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralReplayClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralReplayClient_makefile) coralReplayClientclean

##	  /bin/rm -f $(cmt_local_coralReplayClient_makefile) $(bin)coralReplayClient_dependencies.make

install :: coralReplayClientinstall ;

coralReplayClientinstall :: coralReplayClientcompile $(coralReplayClient_dependencies) $(cmt_local_coralReplayClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralReplayClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralReplayClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralReplayClientuninstall

$(foreach d,$(coralReplayClient_dependencies),$(eval $(d)uninstall_dependencies += coralReplayClientuninstall))

coralReplayClientuninstall : $(coralReplayClientuninstall_dependencies) ##$(cmt_local_coralReplayClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralReplayClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralReplayClient_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralReplayClient_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralReplayClientuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralReplayClient"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralReplayClient done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_coralServerStressClient_has_no_target_tag = 1
cmt_coralServerStressClient_has_prototypes = 1

#--------------------------------------

ifdef cmt_coralServerStressClient_has_target_tag

cmt_local_tagfile_coralServerStressClient = $(bin)$(CoralSockets_tag)_coralServerStressClient.make
cmt_final_setup_coralServerStressClient = $(bin)setup_coralServerStressClient.make
cmt_local_coralServerStressClient_makefile = $(bin)coralServerStressClient.make

coralServerStressClient_extratags = -tag_add=target_coralServerStressClient

else

cmt_local_tagfile_coralServerStressClient = $(bin)$(CoralSockets_tag).make
cmt_final_setup_coralServerStressClient = $(bin)setup.make
cmt_local_coralServerStressClient_makefile = $(bin)coralServerStressClient.make

endif

not_coralServerStressClientcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(coralServerStressClientcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
coralServerStressClientdirs :
	@if test ! -d $(bin)coralServerStressClient; then $(mkdir) -p $(bin)coralServerStressClient; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)coralServerStressClient
else
coralServerStressClientdirs : ;
endif

ifdef cmt_coralServerStressClient_has_target_tag

ifndef QUICK
$(cmt_local_coralServerStressClient_makefile) : $(coralServerStressClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralServerStressClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralServerStressClient_extratags) build constituent_config -out=$(cmt_local_coralServerStressClient_makefile) coralServerStressClient
else
$(cmt_local_coralServerStressClient_makefile) : $(coralServerStressClientcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralServerStressClient) ] || \
	  [ ! -f $(cmt_final_setup_coralServerStressClient) ] || \
	  $(not_coralServerStressClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralServerStressClient.make"; \
	  $(cmtexe) -tag=$(tags) $(coralServerStressClient_extratags) build constituent_config -out=$(cmt_local_coralServerStressClient_makefile) coralServerStressClient; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_coralServerStressClient_makefile) : $(coralServerStressClientcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building coralServerStressClient.make"; \
	  $(cmtexe) -f=$(bin)coralServerStressClient.in -tag=$(tags) $(coralServerStressClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralServerStressClient_makefile) coralServerStressClient
else
$(cmt_local_coralServerStressClient_makefile) : $(coralServerStressClientcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)coralServerStressClient.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_coralServerStressClient) ] || \
	  [ ! -f $(cmt_final_setup_coralServerStressClient) ] || \
	  $(not_coralServerStressClientcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building coralServerStressClient.make"; \
	  $(cmtexe) -f=$(bin)coralServerStressClient.in -tag=$(tags) $(coralServerStressClient_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_coralServerStressClient_makefile) coralServerStressClient; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(coralServerStressClient_extratags) build constituent_makefile -out=$(cmt_local_coralServerStressClient_makefile) coralServerStressClient

coralServerStressClient :: coralServerStressClientcompile coralServerStressClientinstall ;

ifdef cmt_coralServerStressClient_has_prototypes

coralServerStressClientprototype : $(coralServerStressClientprototype_dependencies) $(cmt_local_coralServerStressClient_makefile) dirs coralServerStressClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralServerStressClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

coralServerStressClientcompile : coralServerStressClientprototype

endif

coralServerStressClientcompile : $(coralServerStressClientcompile_dependencies) $(cmt_local_coralServerStressClient_makefile) dirs coralServerStressClientdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralServerStressClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: coralServerStressClientclean ;

coralServerStressClientclean :: $(coralServerStressClientclean_dependencies) ##$(cmt_local_coralServerStressClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralServerStressClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_coralServerStressClient_makefile) coralServerStressClientclean

##	  /bin/rm -f $(cmt_local_coralServerStressClient_makefile) $(bin)coralServerStressClient_dependencies.make

install :: coralServerStressClientinstall ;

coralServerStressClientinstall :: coralServerStressClientcompile $(coralServerStressClient_dependencies) $(cmt_local_coralServerStressClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_coralServerStressClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralServerStressClient_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : coralServerStressClientuninstall

$(foreach d,$(coralServerStressClient_dependencies),$(eval $(d)uninstall_dependencies += coralServerStressClientuninstall))

coralServerStressClientuninstall : $(coralServerStressClientuninstall_dependencies) ##$(cmt_local_coralServerStressClient_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_coralServerStressClient_makefile); then \
	  $(MAKE) -f $(cmt_local_coralServerStressClient_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_coralServerStressClient_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: coralServerStressClientuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ coralServerStressClient"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ coralServerStressClient done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralSockets_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralSockets_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralSockets_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralSockets_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralSockets_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralSockets_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralSockets_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralSockets_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoralSockets_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralSockets_tag).make
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
