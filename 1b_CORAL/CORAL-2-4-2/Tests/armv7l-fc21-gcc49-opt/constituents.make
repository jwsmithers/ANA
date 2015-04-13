
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

Tests_tag = $(tag)

#cmt_local_tagfile = $(Tests_tag).make
cmt_local_tagfile = $(bin)$(Tests_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)Testssetup.make
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
#-- start of constituent ------

cmt_install_pytests_PyCoral_ImportPyCoral_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_pytests_PyCoral_ImportPyCoral_has_target_tag

cmt_local_tagfile_install_pytests_PyCoral_ImportPyCoral = $(bin)$(Tests_tag)_install_pytests_PyCoral_ImportPyCoral.make
cmt_final_setup_install_pytests_PyCoral_ImportPyCoral = $(bin)setup_install_pytests_PyCoral_ImportPyCoral.make
cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile = $(bin)install_pytests_PyCoral_ImportPyCoral.make

install_pytests_PyCoral_ImportPyCoral_extratags = -tag_add=target_install_pytests_PyCoral_ImportPyCoral

else

cmt_local_tagfile_install_pytests_PyCoral_ImportPyCoral = $(bin)$(Tests_tag).make
cmt_final_setup_install_pytests_PyCoral_ImportPyCoral = $(bin)setup.make
cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile = $(bin)install_pytests_PyCoral_ImportPyCoral.make

endif

not_install_pytests_PyCoral_ImportPyCoral_dependencies = { n=0; for p in $?; do m=0; for d in $(install_pytests_PyCoral_ImportPyCoral_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_pytests_PyCoral_ImportPyCoraldirs :
	@if test ! -d $(bin)install_pytests_PyCoral_ImportPyCoral; then $(mkdir) -p $(bin)install_pytests_PyCoral_ImportPyCoral; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_pytests_PyCoral_ImportPyCoral
else
install_pytests_PyCoral_ImportPyCoraldirs : ;
endif

ifdef cmt_install_pytests_PyCoral_ImportPyCoral_has_target_tag

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) : $(install_pytests_PyCoral_ImportPyCoral_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_ImportPyCoral.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_ImportPyCoral_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral
else
$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) : $(install_pytests_PyCoral_ImportPyCoral_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_ImportPyCoral) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_ImportPyCoral) ] || \
	  $(not_install_pytests_PyCoral_ImportPyCoral_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_ImportPyCoral.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_ImportPyCoral_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) : $(install_pytests_PyCoral_ImportPyCoral_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_ImportPyCoral.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_ImportPyCoral.in -tag=$(tags) $(install_pytests_PyCoral_ImportPyCoral_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral
else
$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) : $(install_pytests_PyCoral_ImportPyCoral_dependencies) $(cmt_build_library_linksstamp) $(bin)install_pytests_PyCoral_ImportPyCoral.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_ImportPyCoral) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_ImportPyCoral) ] || \
	  $(not_install_pytests_PyCoral_ImportPyCoral_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_ImportPyCoral.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_ImportPyCoral.in -tag=$(tags) $(install_pytests_PyCoral_ImportPyCoral_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_ImportPyCoral_extratags) build constituent_makefile -out=$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral

install_pytests_PyCoral_ImportPyCoral :: $(install_pytests_PyCoral_ImportPyCoral_dependencies) $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) dirs install_pytests_PyCoral_ImportPyCoraldirs
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_ImportPyCoral"
	@if test -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoral
	$(echo) "(constituents.make) install_pytests_PyCoral_ImportPyCoral done"

clean :: install_pytests_PyCoral_ImportPyCoralclean ;

install_pytests_PyCoral_ImportPyCoralclean :: $(install_pytests_PyCoral_ImportPyCoralclean_dependencies) ##$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile)
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_ImportPyCoralclean"
	@-if test -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoralclean; \
	fi
	$(echo) "(constituents.make) install_pytests_PyCoral_ImportPyCoralclean done"
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install_pytests_PyCoral_ImportPyCoralclean

##	  /bin/rm -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) $(bin)install_pytests_PyCoral_ImportPyCoral_dependencies.make

install :: install_pytests_PyCoral_ImportPyCoralinstall ;

install_pytests_PyCoral_ImportPyCoralinstall :: $(install_pytests_PyCoral_ImportPyCoral_dependencies) $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_pytests_PyCoral_ImportPyCoraluninstall

$(foreach d,$(install_pytests_PyCoral_ImportPyCoral_dependencies),$(eval $(d)uninstall_dependencies += install_pytests_PyCoral_ImportPyCoraluninstall))

install_pytests_PyCoral_ImportPyCoraluninstall : $(install_pytests_PyCoral_ImportPyCoraluninstall_dependencies) ##$(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_ImportPyCoral_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_pytests_PyCoral_ImportPyCoraluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_pytests_PyCoral_ImportPyCoral"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_pytests_PyCoral_ImportPyCoral done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_pytests_PyCoral_Basic_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_pytests_PyCoral_Basic_has_target_tag

cmt_local_tagfile_install_pytests_PyCoral_Basic = $(bin)$(Tests_tag)_install_pytests_PyCoral_Basic.make
cmt_final_setup_install_pytests_PyCoral_Basic = $(bin)setup_install_pytests_PyCoral_Basic.make
cmt_local_install_pytests_PyCoral_Basic_makefile = $(bin)install_pytests_PyCoral_Basic.make

install_pytests_PyCoral_Basic_extratags = -tag_add=target_install_pytests_PyCoral_Basic

else

cmt_local_tagfile_install_pytests_PyCoral_Basic = $(bin)$(Tests_tag).make
cmt_final_setup_install_pytests_PyCoral_Basic = $(bin)setup.make
cmt_local_install_pytests_PyCoral_Basic_makefile = $(bin)install_pytests_PyCoral_Basic.make

endif

not_install_pytests_PyCoral_Basic_dependencies = { n=0; for p in $?; do m=0; for d in $(install_pytests_PyCoral_Basic_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_pytests_PyCoral_Basicdirs :
	@if test ! -d $(bin)install_pytests_PyCoral_Basic; then $(mkdir) -p $(bin)install_pytests_PyCoral_Basic; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_pytests_PyCoral_Basic
else
install_pytests_PyCoral_Basicdirs : ;
endif

ifdef cmt_install_pytests_PyCoral_Basic_has_target_tag

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_Basic_makefile) : $(install_pytests_PyCoral_Basic_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_Basic.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_Basic_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic
else
$(cmt_local_install_pytests_PyCoral_Basic_makefile) : $(install_pytests_PyCoral_Basic_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_Basic) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_Basic) ] || \
	  $(not_install_pytests_PyCoral_Basic_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_Basic.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_Basic_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_Basic_makefile) : $(install_pytests_PyCoral_Basic_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_Basic.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_Basic.in -tag=$(tags) $(install_pytests_PyCoral_Basic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic
else
$(cmt_local_install_pytests_PyCoral_Basic_makefile) : $(install_pytests_PyCoral_Basic_dependencies) $(cmt_build_library_linksstamp) $(bin)install_pytests_PyCoral_Basic.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_Basic) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_Basic) ] || \
	  $(not_install_pytests_PyCoral_Basic_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_Basic.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_Basic.in -tag=$(tags) $(install_pytests_PyCoral_Basic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_Basic_extratags) build constituent_makefile -out=$(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic

install_pytests_PyCoral_Basic :: $(install_pytests_PyCoral_Basic_dependencies) $(cmt_local_install_pytests_PyCoral_Basic_makefile) dirs install_pytests_PyCoral_Basicdirs
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_Basic"
	@if test -f $(cmt_local_install_pytests_PyCoral_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basic
	$(echo) "(constituents.make) install_pytests_PyCoral_Basic done"

clean :: install_pytests_PyCoral_Basicclean ;

install_pytests_PyCoral_Basicclean :: $(install_pytests_PyCoral_Basicclean_dependencies) ##$(cmt_local_install_pytests_PyCoral_Basic_makefile)
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_Basicclean"
	@-if test -f $(cmt_local_install_pytests_PyCoral_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basicclean; \
	fi
	$(echo) "(constituents.make) install_pytests_PyCoral_Basicclean done"
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install_pytests_PyCoral_Basicclean

##	  /bin/rm -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) $(bin)install_pytests_PyCoral_Basic_dependencies.make

install :: install_pytests_PyCoral_Basicinstall ;

install_pytests_PyCoral_Basicinstall :: $(install_pytests_PyCoral_Basic_dependencies) $(cmt_local_install_pytests_PyCoral_Basic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_pytests_PyCoral_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_pytests_PyCoral_Basicuninstall

$(foreach d,$(install_pytests_PyCoral_Basic_dependencies),$(eval $(d)uninstall_dependencies += install_pytests_PyCoral_Basicuninstall))

install_pytests_PyCoral_Basicuninstall : $(install_pytests_PyCoral_Basicuninstall_dependencies) ##$(cmt_local_install_pytests_PyCoral_Basic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_pytests_PyCoral_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_Basic_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_pytests_PyCoral_Basicuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_pytests_PyCoral_Basic"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_pytests_PyCoral_Basic done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_pytests_PyCoral_MiscellaneousBugs_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_pytests_PyCoral_MiscellaneousBugs_has_target_tag

cmt_local_tagfile_install_pytests_PyCoral_MiscellaneousBugs = $(bin)$(Tests_tag)_install_pytests_PyCoral_MiscellaneousBugs.make
cmt_final_setup_install_pytests_PyCoral_MiscellaneousBugs = $(bin)setup_install_pytests_PyCoral_MiscellaneousBugs.make
cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile = $(bin)install_pytests_PyCoral_MiscellaneousBugs.make

install_pytests_PyCoral_MiscellaneousBugs_extratags = -tag_add=target_install_pytests_PyCoral_MiscellaneousBugs

else

cmt_local_tagfile_install_pytests_PyCoral_MiscellaneousBugs = $(bin)$(Tests_tag).make
cmt_final_setup_install_pytests_PyCoral_MiscellaneousBugs = $(bin)setup.make
cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile = $(bin)install_pytests_PyCoral_MiscellaneousBugs.make

endif

not_install_pytests_PyCoral_MiscellaneousBugs_dependencies = { n=0; for p in $?; do m=0; for d in $(install_pytests_PyCoral_MiscellaneousBugs_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_pytests_PyCoral_MiscellaneousBugsdirs :
	@if test ! -d $(bin)install_pytests_PyCoral_MiscellaneousBugs; then $(mkdir) -p $(bin)install_pytests_PyCoral_MiscellaneousBugs; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_pytests_PyCoral_MiscellaneousBugs
else
install_pytests_PyCoral_MiscellaneousBugsdirs : ;
endif

ifdef cmt_install_pytests_PyCoral_MiscellaneousBugs_has_target_tag

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) : $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_MiscellaneousBugs.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_MiscellaneousBugs_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs
else
$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) : $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_MiscellaneousBugs) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_MiscellaneousBugs) ] || \
	  $(not_install_pytests_PyCoral_MiscellaneousBugs_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_MiscellaneousBugs.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_MiscellaneousBugs_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) : $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_MiscellaneousBugs.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_MiscellaneousBugs.in -tag=$(tags) $(install_pytests_PyCoral_MiscellaneousBugs_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs
else
$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) : $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) $(cmt_build_library_linksstamp) $(bin)install_pytests_PyCoral_MiscellaneousBugs.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_MiscellaneousBugs) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_MiscellaneousBugs) ] || \
	  $(not_install_pytests_PyCoral_MiscellaneousBugs_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_MiscellaneousBugs.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_MiscellaneousBugs.in -tag=$(tags) $(install_pytests_PyCoral_MiscellaneousBugs_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_MiscellaneousBugs_extratags) build constituent_makefile -out=$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs

install_pytests_PyCoral_MiscellaneousBugs :: $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) dirs install_pytests_PyCoral_MiscellaneousBugsdirs
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_MiscellaneousBugs"
	@if test -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugs
	$(echo) "(constituents.make) install_pytests_PyCoral_MiscellaneousBugs done"

clean :: install_pytests_PyCoral_MiscellaneousBugsclean ;

install_pytests_PyCoral_MiscellaneousBugsclean :: $(install_pytests_PyCoral_MiscellaneousBugsclean_dependencies) ##$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_MiscellaneousBugsclean"
	@-if test -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugsclean; \
	fi
	$(echo) "(constituents.make) install_pytests_PyCoral_MiscellaneousBugsclean done"
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install_pytests_PyCoral_MiscellaneousBugsclean

##	  /bin/rm -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) $(bin)install_pytests_PyCoral_MiscellaneousBugs_dependencies.make

install :: install_pytests_PyCoral_MiscellaneousBugsinstall ;

install_pytests_PyCoral_MiscellaneousBugsinstall :: $(install_pytests_PyCoral_MiscellaneousBugs_dependencies) $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_pytests_PyCoral_MiscellaneousBugsuninstall

$(foreach d,$(install_pytests_PyCoral_MiscellaneousBugs_dependencies),$(eval $(d)uninstall_dependencies += install_pytests_PyCoral_MiscellaneousBugsuninstall))

install_pytests_PyCoral_MiscellaneousBugsuninstall : $(install_pytests_PyCoral_MiscellaneousBugsuninstall_dependencies) ##$(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_MiscellaneousBugs_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_pytests_PyCoral_MiscellaneousBugsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_pytests_PyCoral_MiscellaneousBugs"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_pytests_PyCoral_MiscellaneousBugs done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_pytests_PyCoral_NetworkGlitch_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_pytests_PyCoral_NetworkGlitch_has_target_tag

cmt_local_tagfile_install_pytests_PyCoral_NetworkGlitch = $(bin)$(Tests_tag)_install_pytests_PyCoral_NetworkGlitch.make
cmt_final_setup_install_pytests_PyCoral_NetworkGlitch = $(bin)setup_install_pytests_PyCoral_NetworkGlitch.make
cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile = $(bin)install_pytests_PyCoral_NetworkGlitch.make

install_pytests_PyCoral_NetworkGlitch_extratags = -tag_add=target_install_pytests_PyCoral_NetworkGlitch

else

cmt_local_tagfile_install_pytests_PyCoral_NetworkGlitch = $(bin)$(Tests_tag).make
cmt_final_setup_install_pytests_PyCoral_NetworkGlitch = $(bin)setup.make
cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile = $(bin)install_pytests_PyCoral_NetworkGlitch.make

endif

not_install_pytests_PyCoral_NetworkGlitch_dependencies = { n=0; for p in $?; do m=0; for d in $(install_pytests_PyCoral_NetworkGlitch_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_pytests_PyCoral_NetworkGlitchdirs :
	@if test ! -d $(bin)install_pytests_PyCoral_NetworkGlitch; then $(mkdir) -p $(bin)install_pytests_PyCoral_NetworkGlitch; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_pytests_PyCoral_NetworkGlitch
else
install_pytests_PyCoral_NetworkGlitchdirs : ;
endif

ifdef cmt_install_pytests_PyCoral_NetworkGlitch_has_target_tag

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) : $(install_pytests_PyCoral_NetworkGlitch_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_NetworkGlitch.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_NetworkGlitch_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch
else
$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) : $(install_pytests_PyCoral_NetworkGlitch_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_NetworkGlitch) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_NetworkGlitch) ] || \
	  $(not_install_pytests_PyCoral_NetworkGlitch_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_NetworkGlitch.make"; \
	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_NetworkGlitch_extratags) build constituent_config -out=$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) : $(install_pytests_PyCoral_NetworkGlitch_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_pytests_PyCoral_NetworkGlitch.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_NetworkGlitch.in -tag=$(tags) $(install_pytests_PyCoral_NetworkGlitch_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch
else
$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) : $(install_pytests_PyCoral_NetworkGlitch_dependencies) $(cmt_build_library_linksstamp) $(bin)install_pytests_PyCoral_NetworkGlitch.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_pytests_PyCoral_NetworkGlitch) ] || \
	  [ ! -f $(cmt_final_setup_install_pytests_PyCoral_NetworkGlitch) ] || \
	  $(not_install_pytests_PyCoral_NetworkGlitch_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_pytests_PyCoral_NetworkGlitch.make"; \
	  $(cmtexe) -f=$(bin)install_pytests_PyCoral_NetworkGlitch.in -tag=$(tags) $(install_pytests_PyCoral_NetworkGlitch_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_pytests_PyCoral_NetworkGlitch_extratags) build constituent_makefile -out=$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch

install_pytests_PyCoral_NetworkGlitch :: $(install_pytests_PyCoral_NetworkGlitch_dependencies) $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) dirs install_pytests_PyCoral_NetworkGlitchdirs
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_NetworkGlitch"
	@if test -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitch
	$(echo) "(constituents.make) install_pytests_PyCoral_NetworkGlitch done"

clean :: install_pytests_PyCoral_NetworkGlitchclean ;

install_pytests_PyCoral_NetworkGlitchclean :: $(install_pytests_PyCoral_NetworkGlitchclean_dependencies) ##$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile)
	$(echo) "(constituents.make) Starting install_pytests_PyCoral_NetworkGlitchclean"
	@-if test -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitchclean; \
	fi
	$(echo) "(constituents.make) install_pytests_PyCoral_NetworkGlitchclean done"
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install_pytests_PyCoral_NetworkGlitchclean

##	  /bin/rm -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) $(bin)install_pytests_PyCoral_NetworkGlitch_dependencies.make

install :: install_pytests_PyCoral_NetworkGlitchinstall ;

install_pytests_PyCoral_NetworkGlitchinstall :: $(install_pytests_PyCoral_NetworkGlitch_dependencies) $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_pytests_PyCoral_NetworkGlitchuninstall

$(foreach d,$(install_pytests_PyCoral_NetworkGlitch_dependencies),$(eval $(d)uninstall_dependencies += install_pytests_PyCoral_NetworkGlitchuninstall))

install_pytests_PyCoral_NetworkGlitchuninstall : $(install_pytests_PyCoral_NetworkGlitchuninstall_dependencies) ##$(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile); then \
	  $(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_pytests_PyCoral_NetworkGlitch_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_pytests_PyCoral_NetworkGlitchuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_pytests_PyCoral_NetworkGlitch"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_pytests_PyCoral_NetworkGlitch done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_test_TestEnv_has_no_target_tag = 1
cmt_test_TestEnv_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_TestEnv_has_target_tag

cmt_local_tagfile_test_TestEnv = $(bin)$(Tests_tag)_test_TestEnv.make
cmt_final_setup_test_TestEnv = $(bin)setup_test_TestEnv.make
cmt_local_test_TestEnv_makefile = $(bin)test_TestEnv.make

test_TestEnv_extratags = -tag_add=target_test_TestEnv

else

cmt_local_tagfile_test_TestEnv = $(bin)$(Tests_tag).make
cmt_final_setup_test_TestEnv = $(bin)setup.make
cmt_local_test_TestEnv_makefile = $(bin)test_TestEnv.make

endif

not_test_TestEnvcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_TestEnvcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_TestEnvdirs :
	@if test ! -d $(bin)test_TestEnv; then $(mkdir) -p $(bin)test_TestEnv; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_TestEnv
else
test_TestEnvdirs : ;
endif

ifdef cmt_test_TestEnv_has_target_tag

ifndef QUICK
$(cmt_local_test_TestEnv_makefile) : $(test_TestEnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_TestEnv.make"; \
	  $(cmtexe) -tag=$(tags) $(test_TestEnv_extratags) build constituent_config -out=$(cmt_local_test_TestEnv_makefile) test_TestEnv
else
$(cmt_local_test_TestEnv_makefile) : $(test_TestEnvcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_TestEnv) ] || \
	  [ ! -f $(cmt_final_setup_test_TestEnv) ] || \
	  $(not_test_TestEnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_TestEnv.make"; \
	  $(cmtexe) -tag=$(tags) $(test_TestEnv_extratags) build constituent_config -out=$(cmt_local_test_TestEnv_makefile) test_TestEnv; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_TestEnv_makefile) : $(test_TestEnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_TestEnv.make"; \
	  $(cmtexe) -f=$(bin)test_TestEnv.in -tag=$(tags) $(test_TestEnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_TestEnv_makefile) test_TestEnv
else
$(cmt_local_test_TestEnv_makefile) : $(test_TestEnvcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_TestEnv.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_TestEnv) ] || \
	  [ ! -f $(cmt_final_setup_test_TestEnv) ] || \
	  $(not_test_TestEnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_TestEnv.make"; \
	  $(cmtexe) -f=$(bin)test_TestEnv.in -tag=$(tags) $(test_TestEnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_TestEnv_makefile) test_TestEnv; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_TestEnv_extratags) build constituent_makefile -out=$(cmt_local_test_TestEnv_makefile) test_TestEnv

test_TestEnv :: test_TestEnvcompile test_TestEnvinstall ;

ifdef cmt_test_TestEnv_has_prototypes

test_TestEnvprototype : $(test_TestEnvprototype_dependencies) $(cmt_local_test_TestEnv_makefile) dirs test_TestEnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_TestEnv_makefile); then \
	  $(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_TestEnvcompile : test_TestEnvprototype

endif

test_TestEnvcompile : $(test_TestEnvcompile_dependencies) $(cmt_local_test_TestEnv_makefile) dirs test_TestEnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_TestEnv_makefile); then \
	  $(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_TestEnvclean ;

test_TestEnvclean :: $(test_TestEnvclean_dependencies) ##$(cmt_local_test_TestEnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_TestEnv_makefile); then \
	  $(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_TestEnv_makefile) test_TestEnvclean

##	  /bin/rm -f $(cmt_local_test_TestEnv_makefile) $(bin)test_TestEnv_dependencies.make

install :: test_TestEnvinstall ;

test_TestEnvinstall :: test_TestEnvcompile $(test_TestEnv_dependencies) $(cmt_local_test_TestEnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_TestEnv_makefile); then \
	  $(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_TestEnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_TestEnvuninstall

$(foreach d,$(test_TestEnv_dependencies),$(eval $(d)uninstall_dependencies += test_TestEnvuninstall))

test_TestEnvuninstall : $(test_TestEnvuninstall_dependencies) ##$(cmt_local_test_TestEnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_TestEnv_makefile); then \
	  $(MAKE) -f $(cmt_local_test_TestEnv_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_TestEnv_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_TestEnvuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_TestEnv"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_TestEnv done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_AliasesSynonyms_has_no_target_tag = 1
cmt_test_Integration_AliasesSynonyms_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_AliasesSynonyms_has_target_tag

cmt_local_tagfile_test_Integration_AliasesSynonyms = $(bin)$(Tests_tag)_test_Integration_AliasesSynonyms.make
cmt_final_setup_test_Integration_AliasesSynonyms = $(bin)setup_test_Integration_AliasesSynonyms.make
cmt_local_test_Integration_AliasesSynonyms_makefile = $(bin)test_Integration_AliasesSynonyms.make

test_Integration_AliasesSynonyms_extratags = -tag_add=target_test_Integration_AliasesSynonyms

else

cmt_local_tagfile_test_Integration_AliasesSynonyms = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_AliasesSynonyms = $(bin)setup.make
cmt_local_test_Integration_AliasesSynonyms_makefile = $(bin)test_Integration_AliasesSynonyms.make

endif

not_test_Integration_AliasesSynonymscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_AliasesSynonymscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_AliasesSynonymsdirs :
	@if test ! -d $(bin)test_Integration_AliasesSynonyms; then $(mkdir) -p $(bin)test_Integration_AliasesSynonyms; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_AliasesSynonyms
else
test_Integration_AliasesSynonymsdirs : ;
endif

ifdef cmt_test_Integration_AliasesSynonyms_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_AliasesSynonyms_makefile) : $(test_Integration_AliasesSynonymscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_AliasesSynonyms.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_AliasesSynonyms_extratags) build constituent_config -out=$(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonyms
else
$(cmt_local_test_Integration_AliasesSynonyms_makefile) : $(test_Integration_AliasesSynonymscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_AliasesSynonyms) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_AliasesSynonyms) ] || \
	  $(not_test_Integration_AliasesSynonymscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_AliasesSynonyms.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_AliasesSynonyms_extratags) build constituent_config -out=$(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonyms; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_AliasesSynonyms_makefile) : $(test_Integration_AliasesSynonymscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_AliasesSynonyms.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_AliasesSynonyms.in -tag=$(tags) $(test_Integration_AliasesSynonyms_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonyms
else
$(cmt_local_test_Integration_AliasesSynonyms_makefile) : $(test_Integration_AliasesSynonymscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_AliasesSynonyms.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_AliasesSynonyms) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_AliasesSynonyms) ] || \
	  $(not_test_Integration_AliasesSynonymscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_AliasesSynonyms.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_AliasesSynonyms.in -tag=$(tags) $(test_Integration_AliasesSynonyms_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonyms; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_AliasesSynonyms_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonyms

test_Integration_AliasesSynonyms :: test_Integration_AliasesSynonymscompile test_Integration_AliasesSynonymsinstall ;

ifdef cmt_test_Integration_AliasesSynonyms_has_prototypes

test_Integration_AliasesSynonymsprototype : $(test_Integration_AliasesSynonymsprototype_dependencies) $(cmt_local_test_Integration_AliasesSynonyms_makefile) dirs test_Integration_AliasesSynonymsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_AliasesSynonyms_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_AliasesSynonymscompile : test_Integration_AliasesSynonymsprototype

endif

test_Integration_AliasesSynonymscompile : $(test_Integration_AliasesSynonymscompile_dependencies) $(cmt_local_test_Integration_AliasesSynonyms_makefile) dirs test_Integration_AliasesSynonymsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_AliasesSynonyms_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_AliasesSynonymsclean ;

test_Integration_AliasesSynonymsclean :: $(test_Integration_AliasesSynonymsclean_dependencies) ##$(cmt_local_test_Integration_AliasesSynonyms_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_AliasesSynonyms_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) test_Integration_AliasesSynonymsclean

##	  /bin/rm -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $(bin)test_Integration_AliasesSynonyms_dependencies.make

install :: test_Integration_AliasesSynonymsinstall ;

test_Integration_AliasesSynonymsinstall :: test_Integration_AliasesSynonymscompile $(test_Integration_AliasesSynonyms_dependencies) $(cmt_local_test_Integration_AliasesSynonyms_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_AliasesSynonyms_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_AliasesSynonymsuninstall

$(foreach d,$(test_Integration_AliasesSynonyms_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_AliasesSynonymsuninstall))

test_Integration_AliasesSynonymsuninstall : $(test_Integration_AliasesSynonymsuninstall_dependencies) ##$(cmt_local_test_Integration_AliasesSynonyms_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_AliasesSynonyms_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_AliasesSynonyms_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_AliasesSynonymsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_AliasesSynonyms"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_AliasesSynonyms done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_Basic_has_no_target_tag = 1
cmt_test_Integration_Basic_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_Basic_has_target_tag

cmt_local_tagfile_test_Integration_Basic = $(bin)$(Tests_tag)_test_Integration_Basic.make
cmt_final_setup_test_Integration_Basic = $(bin)setup_test_Integration_Basic.make
cmt_local_test_Integration_Basic_makefile = $(bin)test_Integration_Basic.make

test_Integration_Basic_extratags = -tag_add=target_test_Integration_Basic

else

cmt_local_tagfile_test_Integration_Basic = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_Basic = $(bin)setup.make
cmt_local_test_Integration_Basic_makefile = $(bin)test_Integration_Basic.make

endif

not_test_Integration_Basiccompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_Basiccompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_Basicdirs :
	@if test ! -d $(bin)test_Integration_Basic; then $(mkdir) -p $(bin)test_Integration_Basic; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_Basic
else
test_Integration_Basicdirs : ;
endif

ifdef cmt_test_Integration_Basic_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_Basic_makefile) : $(test_Integration_Basiccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Basic.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Basic_extratags) build constituent_config -out=$(cmt_local_test_Integration_Basic_makefile) test_Integration_Basic
else
$(cmt_local_test_Integration_Basic_makefile) : $(test_Integration_Basiccompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Basic) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Basic) ] || \
	  $(not_test_Integration_Basiccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Basic.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Basic_extratags) build constituent_config -out=$(cmt_local_test_Integration_Basic_makefile) test_Integration_Basic; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_Basic_makefile) : $(test_Integration_Basiccompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Basic.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Basic.in -tag=$(tags) $(test_Integration_Basic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Basic_makefile) test_Integration_Basic
else
$(cmt_local_test_Integration_Basic_makefile) : $(test_Integration_Basiccompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_Basic.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Basic) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Basic) ] || \
	  $(not_test_Integration_Basiccompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Basic.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Basic.in -tag=$(tags) $(test_Integration_Basic_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Basic_makefile) test_Integration_Basic; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_Basic_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_Basic_makefile) test_Integration_Basic

test_Integration_Basic :: test_Integration_Basiccompile test_Integration_Basicinstall ;

ifdef cmt_test_Integration_Basic_has_prototypes

test_Integration_Basicprototype : $(test_Integration_Basicprototype_dependencies) $(cmt_local_test_Integration_Basic_makefile) dirs test_Integration_Basicdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_Basiccompile : test_Integration_Basicprototype

endif

test_Integration_Basiccompile : $(test_Integration_Basiccompile_dependencies) $(cmt_local_test_Integration_Basic_makefile) dirs test_Integration_Basicdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_Basicclean ;

test_Integration_Basicclean :: $(test_Integration_Basicclean_dependencies) ##$(cmt_local_test_Integration_Basic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) test_Integration_Basicclean

##	  /bin/rm -f $(cmt_local_test_Integration_Basic_makefile) $(bin)test_Integration_Basic_dependencies.make

install :: test_Integration_Basicinstall ;

test_Integration_Basicinstall :: test_Integration_Basiccompile $(test_Integration_Basic_dependencies) $(cmt_local_test_Integration_Basic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_Basicuninstall

$(foreach d,$(test_Integration_Basic_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_Basicuninstall))

test_Integration_Basicuninstall : $(test_Integration_Basicuninstall_dependencies) ##$(cmt_local_test_Integration_Basic_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Basic_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Basic_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_Basicuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_Basic"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_Basic done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_InputOutput_has_no_target_tag = 1
cmt_test_Integration_InputOutput_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_InputOutput_has_target_tag

cmt_local_tagfile_test_Integration_InputOutput = $(bin)$(Tests_tag)_test_Integration_InputOutput.make
cmt_final_setup_test_Integration_InputOutput = $(bin)setup_test_Integration_InputOutput.make
cmt_local_test_Integration_InputOutput_makefile = $(bin)test_Integration_InputOutput.make

test_Integration_InputOutput_extratags = -tag_add=target_test_Integration_InputOutput

else

cmt_local_tagfile_test_Integration_InputOutput = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_InputOutput = $(bin)setup.make
cmt_local_test_Integration_InputOutput_makefile = $(bin)test_Integration_InputOutput.make

endif

not_test_Integration_InputOutputcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_InputOutputcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_InputOutputdirs :
	@if test ! -d $(bin)test_Integration_InputOutput; then $(mkdir) -p $(bin)test_Integration_InputOutput; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_InputOutput
else
test_Integration_InputOutputdirs : ;
endif

ifdef cmt_test_Integration_InputOutput_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_InputOutput_makefile) : $(test_Integration_InputOutputcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_InputOutput.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_InputOutput_extratags) build constituent_config -out=$(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutput
else
$(cmt_local_test_Integration_InputOutput_makefile) : $(test_Integration_InputOutputcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_InputOutput) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_InputOutput) ] || \
	  $(not_test_Integration_InputOutputcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_InputOutput.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_InputOutput_extratags) build constituent_config -out=$(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutput; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_InputOutput_makefile) : $(test_Integration_InputOutputcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_InputOutput.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_InputOutput.in -tag=$(tags) $(test_Integration_InputOutput_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutput
else
$(cmt_local_test_Integration_InputOutput_makefile) : $(test_Integration_InputOutputcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_InputOutput.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_InputOutput) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_InputOutput) ] || \
	  $(not_test_Integration_InputOutputcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_InputOutput.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_InputOutput.in -tag=$(tags) $(test_Integration_InputOutput_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutput; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_InputOutput_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutput

test_Integration_InputOutput :: test_Integration_InputOutputcompile test_Integration_InputOutputinstall ;

ifdef cmt_test_Integration_InputOutput_has_prototypes

test_Integration_InputOutputprototype : $(test_Integration_InputOutputprototype_dependencies) $(cmt_local_test_Integration_InputOutput_makefile) dirs test_Integration_InputOutputdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InputOutput_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_InputOutputcompile : test_Integration_InputOutputprototype

endif

test_Integration_InputOutputcompile : $(test_Integration_InputOutputcompile_dependencies) $(cmt_local_test_Integration_InputOutput_makefile) dirs test_Integration_InputOutputdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InputOutput_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_InputOutputclean ;

test_Integration_InputOutputclean :: $(test_Integration_InputOutputclean_dependencies) ##$(cmt_local_test_Integration_InputOutput_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_InputOutput_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) test_Integration_InputOutputclean

##	  /bin/rm -f $(cmt_local_test_Integration_InputOutput_makefile) $(bin)test_Integration_InputOutput_dependencies.make

install :: test_Integration_InputOutputinstall ;

test_Integration_InputOutputinstall :: test_Integration_InputOutputcompile $(test_Integration_InputOutput_dependencies) $(cmt_local_test_Integration_InputOutput_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InputOutput_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_InputOutputuninstall

$(foreach d,$(test_Integration_InputOutput_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_InputOutputuninstall))

test_Integration_InputOutputuninstall : $(test_Integration_InputOutputuninstall_dependencies) ##$(cmt_local_test_Integration_InputOutput_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_InputOutput_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InputOutput_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_InputOutputuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_InputOutput"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_InputOutput done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_InvalidReferences_has_no_target_tag = 1
cmt_test_Integration_InvalidReferences_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_InvalidReferences_has_target_tag

cmt_local_tagfile_test_Integration_InvalidReferences = $(bin)$(Tests_tag)_test_Integration_InvalidReferences.make
cmt_final_setup_test_Integration_InvalidReferences = $(bin)setup_test_Integration_InvalidReferences.make
cmt_local_test_Integration_InvalidReferences_makefile = $(bin)test_Integration_InvalidReferences.make

test_Integration_InvalidReferences_extratags = -tag_add=target_test_Integration_InvalidReferences

else

cmt_local_tagfile_test_Integration_InvalidReferences = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_InvalidReferences = $(bin)setup.make
cmt_local_test_Integration_InvalidReferences_makefile = $(bin)test_Integration_InvalidReferences.make

endif

not_test_Integration_InvalidReferencescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_InvalidReferencescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_InvalidReferencesdirs :
	@if test ! -d $(bin)test_Integration_InvalidReferences; then $(mkdir) -p $(bin)test_Integration_InvalidReferences; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_InvalidReferences
else
test_Integration_InvalidReferencesdirs : ;
endif

ifdef cmt_test_Integration_InvalidReferences_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_InvalidReferences_makefile) : $(test_Integration_InvalidReferencescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_InvalidReferences.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_InvalidReferences_extratags) build constituent_config -out=$(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferences
else
$(cmt_local_test_Integration_InvalidReferences_makefile) : $(test_Integration_InvalidReferencescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_InvalidReferences) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_InvalidReferences) ] || \
	  $(not_test_Integration_InvalidReferencescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_InvalidReferences.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_InvalidReferences_extratags) build constituent_config -out=$(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferences; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_InvalidReferences_makefile) : $(test_Integration_InvalidReferencescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_InvalidReferences.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_InvalidReferences.in -tag=$(tags) $(test_Integration_InvalidReferences_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferences
else
$(cmt_local_test_Integration_InvalidReferences_makefile) : $(test_Integration_InvalidReferencescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_InvalidReferences.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_InvalidReferences) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_InvalidReferences) ] || \
	  $(not_test_Integration_InvalidReferencescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_InvalidReferences.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_InvalidReferences.in -tag=$(tags) $(test_Integration_InvalidReferences_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferences; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_InvalidReferences_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferences

test_Integration_InvalidReferences :: test_Integration_InvalidReferencescompile test_Integration_InvalidReferencesinstall ;

ifdef cmt_test_Integration_InvalidReferences_has_prototypes

test_Integration_InvalidReferencesprototype : $(test_Integration_InvalidReferencesprototype_dependencies) $(cmt_local_test_Integration_InvalidReferences_makefile) dirs test_Integration_InvalidReferencesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InvalidReferences_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_InvalidReferencescompile : test_Integration_InvalidReferencesprototype

endif

test_Integration_InvalidReferencescompile : $(test_Integration_InvalidReferencescompile_dependencies) $(cmt_local_test_Integration_InvalidReferences_makefile) dirs test_Integration_InvalidReferencesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InvalidReferences_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_InvalidReferencesclean ;

test_Integration_InvalidReferencesclean :: $(test_Integration_InvalidReferencesclean_dependencies) ##$(cmt_local_test_Integration_InvalidReferences_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_InvalidReferences_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) test_Integration_InvalidReferencesclean

##	  /bin/rm -f $(cmt_local_test_Integration_InvalidReferences_makefile) $(bin)test_Integration_InvalidReferences_dependencies.make

install :: test_Integration_InvalidReferencesinstall ;

test_Integration_InvalidReferencesinstall :: test_Integration_InvalidReferencescompile $(test_Integration_InvalidReferences_dependencies) $(cmt_local_test_Integration_InvalidReferences_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_InvalidReferences_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_InvalidReferencesuninstall

$(foreach d,$(test_Integration_InvalidReferences_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_InvalidReferencesuninstall))

test_Integration_InvalidReferencesuninstall : $(test_Integration_InvalidReferencesuninstall_dependencies) ##$(cmt_local_test_Integration_InvalidReferences_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_InvalidReferences_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_InvalidReferences_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_InvalidReferencesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_InvalidReferences"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_InvalidReferences done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_LookupService_has_no_target_tag = 1
cmt_test_Integration_LookupService_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_LookupService_has_target_tag

cmt_local_tagfile_test_Integration_LookupService = $(bin)$(Tests_tag)_test_Integration_LookupService.make
cmt_final_setup_test_Integration_LookupService = $(bin)setup_test_Integration_LookupService.make
cmt_local_test_Integration_LookupService_makefile = $(bin)test_Integration_LookupService.make

test_Integration_LookupService_extratags = -tag_add=target_test_Integration_LookupService

else

cmt_local_tagfile_test_Integration_LookupService = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_LookupService = $(bin)setup.make
cmt_local_test_Integration_LookupService_makefile = $(bin)test_Integration_LookupService.make

endif

not_test_Integration_LookupServicecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_LookupServicecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_LookupServicedirs :
	@if test ! -d $(bin)test_Integration_LookupService; then $(mkdir) -p $(bin)test_Integration_LookupService; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_LookupService
else
test_Integration_LookupServicedirs : ;
endif

ifdef cmt_test_Integration_LookupService_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_LookupService_makefile) : $(test_Integration_LookupServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_LookupService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_LookupService_extratags) build constituent_config -out=$(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupService
else
$(cmt_local_test_Integration_LookupService_makefile) : $(test_Integration_LookupServicecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_LookupService) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_LookupService) ] || \
	  $(not_test_Integration_LookupServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_LookupService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_LookupService_extratags) build constituent_config -out=$(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupService; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_LookupService_makefile) : $(test_Integration_LookupServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_LookupService.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_LookupService.in -tag=$(tags) $(test_Integration_LookupService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupService
else
$(cmt_local_test_Integration_LookupService_makefile) : $(test_Integration_LookupServicecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_LookupService.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_LookupService) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_LookupService) ] || \
	  $(not_test_Integration_LookupServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_LookupService.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_LookupService.in -tag=$(tags) $(test_Integration_LookupService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupService; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_LookupService_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupService

test_Integration_LookupService :: test_Integration_LookupServicecompile test_Integration_LookupServiceinstall ;

ifdef cmt_test_Integration_LookupService_has_prototypes

test_Integration_LookupServiceprototype : $(test_Integration_LookupServiceprototype_dependencies) $(cmt_local_test_Integration_LookupService_makefile) dirs test_Integration_LookupServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_LookupService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_LookupServicecompile : test_Integration_LookupServiceprototype

endif

test_Integration_LookupServicecompile : $(test_Integration_LookupServicecompile_dependencies) $(cmt_local_test_Integration_LookupService_makefile) dirs test_Integration_LookupServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_LookupService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_LookupServiceclean ;

test_Integration_LookupServiceclean :: $(test_Integration_LookupServiceclean_dependencies) ##$(cmt_local_test_Integration_LookupService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_LookupService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) test_Integration_LookupServiceclean

##	  /bin/rm -f $(cmt_local_test_Integration_LookupService_makefile) $(bin)test_Integration_LookupService_dependencies.make

install :: test_Integration_LookupServiceinstall ;

test_Integration_LookupServiceinstall :: test_Integration_LookupServicecompile $(test_Integration_LookupService_dependencies) $(cmt_local_test_Integration_LookupService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_LookupService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_LookupServiceuninstall

$(foreach d,$(test_Integration_LookupService_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_LookupServiceuninstall))

test_Integration_LookupServiceuninstall : $(test_Integration_LookupServiceuninstall_dependencies) ##$(cmt_local_test_Integration_LookupService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_LookupService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_LookupService_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_LookupServiceuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_LookupService"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_LookupService done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_MiscellaneousBugs_has_no_target_tag = 1
cmt_test_Integration_MiscellaneousBugs_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_MiscellaneousBugs_has_target_tag

cmt_local_tagfile_test_Integration_MiscellaneousBugs = $(bin)$(Tests_tag)_test_Integration_MiscellaneousBugs.make
cmt_final_setup_test_Integration_MiscellaneousBugs = $(bin)setup_test_Integration_MiscellaneousBugs.make
cmt_local_test_Integration_MiscellaneousBugs_makefile = $(bin)test_Integration_MiscellaneousBugs.make

test_Integration_MiscellaneousBugs_extratags = -tag_add=target_test_Integration_MiscellaneousBugs

else

cmt_local_tagfile_test_Integration_MiscellaneousBugs = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_MiscellaneousBugs = $(bin)setup.make
cmt_local_test_Integration_MiscellaneousBugs_makefile = $(bin)test_Integration_MiscellaneousBugs.make

endif

not_test_Integration_MiscellaneousBugscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_MiscellaneousBugscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_MiscellaneousBugsdirs :
	@if test ! -d $(bin)test_Integration_MiscellaneousBugs; then $(mkdir) -p $(bin)test_Integration_MiscellaneousBugs; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_MiscellaneousBugs
else
test_Integration_MiscellaneousBugsdirs : ;
endif

ifdef cmt_test_Integration_MiscellaneousBugs_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_MiscellaneousBugs_makefile) : $(test_Integration_MiscellaneousBugscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MiscellaneousBugs.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MiscellaneousBugs_extratags) build constituent_config -out=$(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugs
else
$(cmt_local_test_Integration_MiscellaneousBugs_makefile) : $(test_Integration_MiscellaneousBugscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MiscellaneousBugs) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MiscellaneousBugs) ] || \
	  $(not_test_Integration_MiscellaneousBugscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MiscellaneousBugs.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MiscellaneousBugs_extratags) build constituent_config -out=$(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugs; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_MiscellaneousBugs_makefile) : $(test_Integration_MiscellaneousBugscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MiscellaneousBugs.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MiscellaneousBugs.in -tag=$(tags) $(test_Integration_MiscellaneousBugs_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugs
else
$(cmt_local_test_Integration_MiscellaneousBugs_makefile) : $(test_Integration_MiscellaneousBugscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_MiscellaneousBugs.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MiscellaneousBugs) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MiscellaneousBugs) ] || \
	  $(not_test_Integration_MiscellaneousBugscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MiscellaneousBugs.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MiscellaneousBugs.in -tag=$(tags) $(test_Integration_MiscellaneousBugs_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugs; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_MiscellaneousBugs_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugs

test_Integration_MiscellaneousBugs :: test_Integration_MiscellaneousBugscompile test_Integration_MiscellaneousBugsinstall ;

ifdef cmt_test_Integration_MiscellaneousBugs_has_prototypes

test_Integration_MiscellaneousBugsprototype : $(test_Integration_MiscellaneousBugsprototype_dependencies) $(cmt_local_test_Integration_MiscellaneousBugs_makefile) dirs test_Integration_MiscellaneousBugsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_MiscellaneousBugscompile : test_Integration_MiscellaneousBugsprototype

endif

test_Integration_MiscellaneousBugscompile : $(test_Integration_MiscellaneousBugscompile_dependencies) $(cmt_local_test_Integration_MiscellaneousBugs_makefile) dirs test_Integration_MiscellaneousBugsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_MiscellaneousBugsclean ;

test_Integration_MiscellaneousBugsclean :: $(test_Integration_MiscellaneousBugsclean_dependencies) ##$(cmt_local_test_Integration_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) test_Integration_MiscellaneousBugsclean

##	  /bin/rm -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $(bin)test_Integration_MiscellaneousBugs_dependencies.make

install :: test_Integration_MiscellaneousBugsinstall ;

test_Integration_MiscellaneousBugsinstall :: test_Integration_MiscellaneousBugscompile $(test_Integration_MiscellaneousBugs_dependencies) $(cmt_local_test_Integration_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_MiscellaneousBugsuninstall

$(foreach d,$(test_Integration_MiscellaneousBugs_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_MiscellaneousBugsuninstall))

test_Integration_MiscellaneousBugsuninstall : $(test_Integration_MiscellaneousBugsuninstall_dependencies) ##$(cmt_local_test_Integration_MiscellaneousBugs_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MiscellaneousBugs_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_MiscellaneousBugsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_MiscellaneousBugs"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_MiscellaneousBugs done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_Monitoring_has_no_target_tag = 1
cmt_test_Integration_Monitoring_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_Monitoring_has_target_tag

cmt_local_tagfile_test_Integration_Monitoring = $(bin)$(Tests_tag)_test_Integration_Monitoring.make
cmt_final_setup_test_Integration_Monitoring = $(bin)setup_test_Integration_Monitoring.make
cmt_local_test_Integration_Monitoring_makefile = $(bin)test_Integration_Monitoring.make

test_Integration_Monitoring_extratags = -tag_add=target_test_Integration_Monitoring

else

cmt_local_tagfile_test_Integration_Monitoring = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_Monitoring = $(bin)setup.make
cmt_local_test_Integration_Monitoring_makefile = $(bin)test_Integration_Monitoring.make

endif

not_test_Integration_Monitoringcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_Monitoringcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_Monitoringdirs :
	@if test ! -d $(bin)test_Integration_Monitoring; then $(mkdir) -p $(bin)test_Integration_Monitoring; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_Monitoring
else
test_Integration_Monitoringdirs : ;
endif

ifdef cmt_test_Integration_Monitoring_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_Monitoring_makefile) : $(test_Integration_Monitoringcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Monitoring.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Monitoring_extratags) build constituent_config -out=$(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoring
else
$(cmt_local_test_Integration_Monitoring_makefile) : $(test_Integration_Monitoringcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Monitoring) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Monitoring) ] || \
	  $(not_test_Integration_Monitoringcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Monitoring.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Monitoring_extratags) build constituent_config -out=$(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoring; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_Monitoring_makefile) : $(test_Integration_Monitoringcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Monitoring.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Monitoring.in -tag=$(tags) $(test_Integration_Monitoring_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoring
else
$(cmt_local_test_Integration_Monitoring_makefile) : $(test_Integration_Monitoringcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_Monitoring.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Monitoring) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Monitoring) ] || \
	  $(not_test_Integration_Monitoringcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Monitoring.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Monitoring.in -tag=$(tags) $(test_Integration_Monitoring_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoring; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_Monitoring_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoring

test_Integration_Monitoring :: test_Integration_Monitoringcompile test_Integration_Monitoringinstall ;

ifdef cmt_test_Integration_Monitoring_has_prototypes

test_Integration_Monitoringprototype : $(test_Integration_Monitoringprototype_dependencies) $(cmt_local_test_Integration_Monitoring_makefile) dirs test_Integration_Monitoringdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Monitoring_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_Monitoringcompile : test_Integration_Monitoringprototype

endif

test_Integration_Monitoringcompile : $(test_Integration_Monitoringcompile_dependencies) $(cmt_local_test_Integration_Monitoring_makefile) dirs test_Integration_Monitoringdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Monitoring_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_Monitoringclean ;

test_Integration_Monitoringclean :: $(test_Integration_Monitoringclean_dependencies) ##$(cmt_local_test_Integration_Monitoring_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Monitoring_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) test_Integration_Monitoringclean

##	  /bin/rm -f $(cmt_local_test_Integration_Monitoring_makefile) $(bin)test_Integration_Monitoring_dependencies.make

install :: test_Integration_Monitoringinstall ;

test_Integration_Monitoringinstall :: test_Integration_Monitoringcompile $(test_Integration_Monitoring_dependencies) $(cmt_local_test_Integration_Monitoring_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Monitoring_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_Monitoringuninstall

$(foreach d,$(test_Integration_Monitoring_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_Monitoringuninstall))

test_Integration_Monitoringuninstall : $(test_Integration_Monitoringuninstall_dependencies) ##$(cmt_local_test_Integration_Monitoring_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Monitoring_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Monitoring_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_Monitoringuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_Monitoring"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_Monitoring done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_MonitoringService_has_no_target_tag = 1
cmt_test_Integration_MonitoringService_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_MonitoringService_has_target_tag

cmt_local_tagfile_test_Integration_MonitoringService = $(bin)$(Tests_tag)_test_Integration_MonitoringService.make
cmt_final_setup_test_Integration_MonitoringService = $(bin)setup_test_Integration_MonitoringService.make
cmt_local_test_Integration_MonitoringService_makefile = $(bin)test_Integration_MonitoringService.make

test_Integration_MonitoringService_extratags = -tag_add=target_test_Integration_MonitoringService

else

cmt_local_tagfile_test_Integration_MonitoringService = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_MonitoringService = $(bin)setup.make
cmt_local_test_Integration_MonitoringService_makefile = $(bin)test_Integration_MonitoringService.make

endif

not_test_Integration_MonitoringServicecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_MonitoringServicecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_MonitoringServicedirs :
	@if test ! -d $(bin)test_Integration_MonitoringService; then $(mkdir) -p $(bin)test_Integration_MonitoringService; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_MonitoringService
else
test_Integration_MonitoringServicedirs : ;
endif

ifdef cmt_test_Integration_MonitoringService_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_MonitoringService_makefile) : $(test_Integration_MonitoringServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MonitoringService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MonitoringService_extratags) build constituent_config -out=$(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringService
else
$(cmt_local_test_Integration_MonitoringService_makefile) : $(test_Integration_MonitoringServicecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MonitoringService) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MonitoringService) ] || \
	  $(not_test_Integration_MonitoringServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MonitoringService.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MonitoringService_extratags) build constituent_config -out=$(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringService; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_MonitoringService_makefile) : $(test_Integration_MonitoringServicecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MonitoringService.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MonitoringService.in -tag=$(tags) $(test_Integration_MonitoringService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringService
else
$(cmt_local_test_Integration_MonitoringService_makefile) : $(test_Integration_MonitoringServicecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_MonitoringService.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MonitoringService) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MonitoringService) ] || \
	  $(not_test_Integration_MonitoringServicecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MonitoringService.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MonitoringService.in -tag=$(tags) $(test_Integration_MonitoringService_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringService; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_MonitoringService_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringService

test_Integration_MonitoringService :: test_Integration_MonitoringServicecompile test_Integration_MonitoringServiceinstall ;

ifdef cmt_test_Integration_MonitoringService_has_prototypes

test_Integration_MonitoringServiceprototype : $(test_Integration_MonitoringServiceprototype_dependencies) $(cmt_local_test_Integration_MonitoringService_makefile) dirs test_Integration_MonitoringServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MonitoringService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_MonitoringServicecompile : test_Integration_MonitoringServiceprototype

endif

test_Integration_MonitoringServicecompile : $(test_Integration_MonitoringServicecompile_dependencies) $(cmt_local_test_Integration_MonitoringService_makefile) dirs test_Integration_MonitoringServicedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MonitoringService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_MonitoringServiceclean ;

test_Integration_MonitoringServiceclean :: $(test_Integration_MonitoringServiceclean_dependencies) ##$(cmt_local_test_Integration_MonitoringService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MonitoringService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) test_Integration_MonitoringServiceclean

##	  /bin/rm -f $(cmt_local_test_Integration_MonitoringService_makefile) $(bin)test_Integration_MonitoringService_dependencies.make

install :: test_Integration_MonitoringServiceinstall ;

test_Integration_MonitoringServiceinstall :: test_Integration_MonitoringServicecompile $(test_Integration_MonitoringService_dependencies) $(cmt_local_test_Integration_MonitoringService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MonitoringService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_MonitoringServiceuninstall

$(foreach d,$(test_Integration_MonitoringService_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_MonitoringServiceuninstall))

test_Integration_MonitoringServiceuninstall : $(test_Integration_MonitoringServiceuninstall_dependencies) ##$(cmt_local_test_Integration_MonitoringService_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MonitoringService_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MonitoringService_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_MonitoringServiceuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_MonitoringService"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_MonitoringService done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_MultiThreading_has_no_target_tag = 1
cmt_test_Integration_MultiThreading_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_MultiThreading_has_target_tag

cmt_local_tagfile_test_Integration_MultiThreading = $(bin)$(Tests_tag)_test_Integration_MultiThreading.make
cmt_final_setup_test_Integration_MultiThreading = $(bin)setup_test_Integration_MultiThreading.make
cmt_local_test_Integration_MultiThreading_makefile = $(bin)test_Integration_MultiThreading.make

test_Integration_MultiThreading_extratags = -tag_add=target_test_Integration_MultiThreading

else

cmt_local_tagfile_test_Integration_MultiThreading = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_MultiThreading = $(bin)setup.make
cmt_local_test_Integration_MultiThreading_makefile = $(bin)test_Integration_MultiThreading.make

endif

not_test_Integration_MultiThreadingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_MultiThreadingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_MultiThreadingdirs :
	@if test ! -d $(bin)test_Integration_MultiThreading; then $(mkdir) -p $(bin)test_Integration_MultiThreading; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_MultiThreading
else
test_Integration_MultiThreadingdirs : ;
endif

ifdef cmt_test_Integration_MultiThreading_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_MultiThreading_makefile) : $(test_Integration_MultiThreadingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MultiThreading.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MultiThreading_extratags) build constituent_config -out=$(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreading
else
$(cmt_local_test_Integration_MultiThreading_makefile) : $(test_Integration_MultiThreadingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MultiThreading) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MultiThreading) ] || \
	  $(not_test_Integration_MultiThreadingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MultiThreading.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_MultiThreading_extratags) build constituent_config -out=$(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreading; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_MultiThreading_makefile) : $(test_Integration_MultiThreadingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_MultiThreading.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MultiThreading.in -tag=$(tags) $(test_Integration_MultiThreading_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreading
else
$(cmt_local_test_Integration_MultiThreading_makefile) : $(test_Integration_MultiThreadingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_MultiThreading.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_MultiThreading) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_MultiThreading) ] || \
	  $(not_test_Integration_MultiThreadingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_MultiThreading.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_MultiThreading.in -tag=$(tags) $(test_Integration_MultiThreading_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreading; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_MultiThreading_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreading

test_Integration_MultiThreading :: test_Integration_MultiThreadingcompile test_Integration_MultiThreadinginstall ;

ifdef cmt_test_Integration_MultiThreading_has_prototypes

test_Integration_MultiThreadingprototype : $(test_Integration_MultiThreadingprototype_dependencies) $(cmt_local_test_Integration_MultiThreading_makefile) dirs test_Integration_MultiThreadingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_MultiThreadingcompile : test_Integration_MultiThreadingprototype

endif

test_Integration_MultiThreadingcompile : $(test_Integration_MultiThreadingcompile_dependencies) $(cmt_local_test_Integration_MultiThreading_makefile) dirs test_Integration_MultiThreadingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_MultiThreadingclean ;

test_Integration_MultiThreadingclean :: $(test_Integration_MultiThreadingclean_dependencies) ##$(cmt_local_test_Integration_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) test_Integration_MultiThreadingclean

##	  /bin/rm -f $(cmt_local_test_Integration_MultiThreading_makefile) $(bin)test_Integration_MultiThreading_dependencies.make

install :: test_Integration_MultiThreadinginstall ;

test_Integration_MultiThreadinginstall :: test_Integration_MultiThreadingcompile $(test_Integration_MultiThreading_dependencies) $(cmt_local_test_Integration_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_MultiThreadinguninstall

$(foreach d,$(test_Integration_MultiThreading_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_MultiThreadinguninstall))

test_Integration_MultiThreadinguninstall : $(test_Integration_MultiThreadinguninstall_dependencies) ##$(cmt_local_test_Integration_MultiThreading_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_MultiThreading_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_MultiThreading_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_MultiThreadinguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_MultiThreading"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_MultiThreading done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_ObjectConsistency_has_no_target_tag = 1
cmt_test_Integration_ObjectConsistency_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_ObjectConsistency_has_target_tag

cmt_local_tagfile_test_Integration_ObjectConsistency = $(bin)$(Tests_tag)_test_Integration_ObjectConsistency.make
cmt_final_setup_test_Integration_ObjectConsistency = $(bin)setup_test_Integration_ObjectConsistency.make
cmt_local_test_Integration_ObjectConsistency_makefile = $(bin)test_Integration_ObjectConsistency.make

test_Integration_ObjectConsistency_extratags = -tag_add=target_test_Integration_ObjectConsistency

else

cmt_local_tagfile_test_Integration_ObjectConsistency = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_ObjectConsistency = $(bin)setup.make
cmt_local_test_Integration_ObjectConsistency_makefile = $(bin)test_Integration_ObjectConsistency.make

endif

not_test_Integration_ObjectConsistencycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_ObjectConsistencycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_ObjectConsistencydirs :
	@if test ! -d $(bin)test_Integration_ObjectConsistency; then $(mkdir) -p $(bin)test_Integration_ObjectConsistency; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_ObjectConsistency
else
test_Integration_ObjectConsistencydirs : ;
endif

ifdef cmt_test_Integration_ObjectConsistency_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_ObjectConsistency_makefile) : $(test_Integration_ObjectConsistencycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_ObjectConsistency.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_ObjectConsistency_extratags) build constituent_config -out=$(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistency
else
$(cmt_local_test_Integration_ObjectConsistency_makefile) : $(test_Integration_ObjectConsistencycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_ObjectConsistency) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_ObjectConsistency) ] || \
	  $(not_test_Integration_ObjectConsistencycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_ObjectConsistency.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_ObjectConsistency_extratags) build constituent_config -out=$(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistency; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_ObjectConsistency_makefile) : $(test_Integration_ObjectConsistencycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_ObjectConsistency.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_ObjectConsistency.in -tag=$(tags) $(test_Integration_ObjectConsistency_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistency
else
$(cmt_local_test_Integration_ObjectConsistency_makefile) : $(test_Integration_ObjectConsistencycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_ObjectConsistency.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_ObjectConsistency) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_ObjectConsistency) ] || \
	  $(not_test_Integration_ObjectConsistencycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_ObjectConsistency.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_ObjectConsistency.in -tag=$(tags) $(test_Integration_ObjectConsistency_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistency; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_ObjectConsistency_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistency

test_Integration_ObjectConsistency :: test_Integration_ObjectConsistencycompile test_Integration_ObjectConsistencyinstall ;

ifdef cmt_test_Integration_ObjectConsistency_has_prototypes

test_Integration_ObjectConsistencyprototype : $(test_Integration_ObjectConsistencyprototype_dependencies) $(cmt_local_test_Integration_ObjectConsistency_makefile) dirs test_Integration_ObjectConsistencydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_ObjectConsistency_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_ObjectConsistencycompile : test_Integration_ObjectConsistencyprototype

endif

test_Integration_ObjectConsistencycompile : $(test_Integration_ObjectConsistencycompile_dependencies) $(cmt_local_test_Integration_ObjectConsistency_makefile) dirs test_Integration_ObjectConsistencydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_ObjectConsistency_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_ObjectConsistencyclean ;

test_Integration_ObjectConsistencyclean :: $(test_Integration_ObjectConsistencyclean_dependencies) ##$(cmt_local_test_Integration_ObjectConsistency_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_ObjectConsistency_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) test_Integration_ObjectConsistencyclean

##	  /bin/rm -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $(bin)test_Integration_ObjectConsistency_dependencies.make

install :: test_Integration_ObjectConsistencyinstall ;

test_Integration_ObjectConsistencyinstall :: test_Integration_ObjectConsistencycompile $(test_Integration_ObjectConsistency_dependencies) $(cmt_local_test_Integration_ObjectConsistency_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_ObjectConsistency_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_ObjectConsistencyuninstall

$(foreach d,$(test_Integration_ObjectConsistency_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_ObjectConsistencyuninstall))

test_Integration_ObjectConsistencyuninstall : $(test_Integration_ObjectConsistencyuninstall_dependencies) ##$(cmt_local_test_Integration_ObjectConsistency_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_ObjectConsistency_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_ObjectConsistency_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_ObjectConsistencyuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_ObjectConsistency"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_ObjectConsistency done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_Quotes_has_no_target_tag = 1
cmt_test_Integration_Quotes_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_Quotes_has_target_tag

cmt_local_tagfile_test_Integration_Quotes = $(bin)$(Tests_tag)_test_Integration_Quotes.make
cmt_final_setup_test_Integration_Quotes = $(bin)setup_test_Integration_Quotes.make
cmt_local_test_Integration_Quotes_makefile = $(bin)test_Integration_Quotes.make

test_Integration_Quotes_extratags = -tag_add=target_test_Integration_Quotes

else

cmt_local_tagfile_test_Integration_Quotes = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_Quotes = $(bin)setup.make
cmt_local_test_Integration_Quotes_makefile = $(bin)test_Integration_Quotes.make

endif

not_test_Integration_Quotescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_Quotescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_Quotesdirs :
	@if test ! -d $(bin)test_Integration_Quotes; then $(mkdir) -p $(bin)test_Integration_Quotes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_Quotes
else
test_Integration_Quotesdirs : ;
endif

ifdef cmt_test_Integration_Quotes_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_Quotes_makefile) : $(test_Integration_Quotescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Quotes.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Quotes_extratags) build constituent_config -out=$(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotes
else
$(cmt_local_test_Integration_Quotes_makefile) : $(test_Integration_Quotescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Quotes) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Quotes) ] || \
	  $(not_test_Integration_Quotescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Quotes.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_Quotes_extratags) build constituent_config -out=$(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_Quotes_makefile) : $(test_Integration_Quotescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_Quotes.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Quotes.in -tag=$(tags) $(test_Integration_Quotes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotes
else
$(cmt_local_test_Integration_Quotes_makefile) : $(test_Integration_Quotescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_Quotes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_Quotes) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_Quotes) ] || \
	  $(not_test_Integration_Quotescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_Quotes.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_Quotes.in -tag=$(tags) $(test_Integration_Quotes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_Quotes_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotes

test_Integration_Quotes :: test_Integration_Quotescompile test_Integration_Quotesinstall ;

ifdef cmt_test_Integration_Quotes_has_prototypes

test_Integration_Quotesprototype : $(test_Integration_Quotesprototype_dependencies) $(cmt_local_test_Integration_Quotes_makefile) dirs test_Integration_Quotesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Quotes_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_Quotescompile : test_Integration_Quotesprototype

endif

test_Integration_Quotescompile : $(test_Integration_Quotescompile_dependencies) $(cmt_local_test_Integration_Quotes_makefile) dirs test_Integration_Quotesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Quotes_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_Quotesclean ;

test_Integration_Quotesclean :: $(test_Integration_Quotesclean_dependencies) ##$(cmt_local_test_Integration_Quotes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Quotes_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) test_Integration_Quotesclean

##	  /bin/rm -f $(cmt_local_test_Integration_Quotes_makefile) $(bin)test_Integration_Quotes_dependencies.make

install :: test_Integration_Quotesinstall ;

test_Integration_Quotesinstall :: test_Integration_Quotescompile $(test_Integration_Quotes_dependencies) $(cmt_local_test_Integration_Quotes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_Quotes_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_Quotesuninstall

$(foreach d,$(test_Integration_Quotes_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_Quotesuninstall))

test_Integration_Quotesuninstall : $(test_Integration_Quotesuninstall_dependencies) ##$(cmt_local_test_Integration_Quotes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_Quotes_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_Quotes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_Quotesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_Quotes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_Quotes done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_RandomCycler_has_no_target_tag = 1
cmt_test_Integration_RandomCycler_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_RandomCycler_has_target_tag

cmt_local_tagfile_test_Integration_RandomCycler = $(bin)$(Tests_tag)_test_Integration_RandomCycler.make
cmt_final_setup_test_Integration_RandomCycler = $(bin)setup_test_Integration_RandomCycler.make
cmt_local_test_Integration_RandomCycler_makefile = $(bin)test_Integration_RandomCycler.make

test_Integration_RandomCycler_extratags = -tag_add=target_test_Integration_RandomCycler

else

cmt_local_tagfile_test_Integration_RandomCycler = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_RandomCycler = $(bin)setup.make
cmt_local_test_Integration_RandomCycler_makefile = $(bin)test_Integration_RandomCycler.make

endif

not_test_Integration_RandomCyclercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_RandomCyclercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_RandomCyclerdirs :
	@if test ! -d $(bin)test_Integration_RandomCycler; then $(mkdir) -p $(bin)test_Integration_RandomCycler; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_RandomCycler
else
test_Integration_RandomCyclerdirs : ;
endif

ifdef cmt_test_Integration_RandomCycler_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_RandomCycler_makefile) : $(test_Integration_RandomCyclercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_RandomCycler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_RandomCycler_extratags) build constituent_config -out=$(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCycler
else
$(cmt_local_test_Integration_RandomCycler_makefile) : $(test_Integration_RandomCyclercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_RandomCycler) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_RandomCycler) ] || \
	  $(not_test_Integration_RandomCyclercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_RandomCycler.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_RandomCycler_extratags) build constituent_config -out=$(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCycler; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_RandomCycler_makefile) : $(test_Integration_RandomCyclercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_RandomCycler.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_RandomCycler.in -tag=$(tags) $(test_Integration_RandomCycler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCycler
else
$(cmt_local_test_Integration_RandomCycler_makefile) : $(test_Integration_RandomCyclercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_RandomCycler.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_RandomCycler) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_RandomCycler) ] || \
	  $(not_test_Integration_RandomCyclercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_RandomCycler.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_RandomCycler.in -tag=$(tags) $(test_Integration_RandomCycler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCycler; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_RandomCycler_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCycler

test_Integration_RandomCycler :: test_Integration_RandomCyclercompile test_Integration_RandomCyclerinstall ;

ifdef cmt_test_Integration_RandomCycler_has_prototypes

test_Integration_RandomCyclerprototype : $(test_Integration_RandomCyclerprototype_dependencies) $(cmt_local_test_Integration_RandomCycler_makefile) dirs test_Integration_RandomCyclerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_RandomCycler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_RandomCyclercompile : test_Integration_RandomCyclerprototype

endif

test_Integration_RandomCyclercompile : $(test_Integration_RandomCyclercompile_dependencies) $(cmt_local_test_Integration_RandomCycler_makefile) dirs test_Integration_RandomCyclerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_RandomCycler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_RandomCyclerclean ;

test_Integration_RandomCyclerclean :: $(test_Integration_RandomCyclerclean_dependencies) ##$(cmt_local_test_Integration_RandomCycler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_RandomCycler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) test_Integration_RandomCyclerclean

##	  /bin/rm -f $(cmt_local_test_Integration_RandomCycler_makefile) $(bin)test_Integration_RandomCycler_dependencies.make

install :: test_Integration_RandomCyclerinstall ;

test_Integration_RandomCyclerinstall :: test_Integration_RandomCyclercompile $(test_Integration_RandomCycler_dependencies) $(cmt_local_test_Integration_RandomCycler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_RandomCycler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_RandomCycleruninstall

$(foreach d,$(test_Integration_RandomCycler_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_RandomCycleruninstall))

test_Integration_RandomCycleruninstall : $(test_Integration_RandomCycleruninstall_dependencies) ##$(cmt_local_test_Integration_RandomCycler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_RandomCycler_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_RandomCycler_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_RandomCycleruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_RandomCycler"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_RandomCycler done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_SpecificFrontier_has_no_target_tag = 1
cmt_test_Integration_SpecificFrontier_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_SpecificFrontier_has_target_tag

cmt_local_tagfile_test_Integration_SpecificFrontier = $(bin)$(Tests_tag)_test_Integration_SpecificFrontier.make
cmt_final_setup_test_Integration_SpecificFrontier = $(bin)setup_test_Integration_SpecificFrontier.make
cmt_local_test_Integration_SpecificFrontier_makefile = $(bin)test_Integration_SpecificFrontier.make

test_Integration_SpecificFrontier_extratags = -tag_add=target_test_Integration_SpecificFrontier

else

cmt_local_tagfile_test_Integration_SpecificFrontier = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_SpecificFrontier = $(bin)setup.make
cmt_local_test_Integration_SpecificFrontier_makefile = $(bin)test_Integration_SpecificFrontier.make

endif

not_test_Integration_SpecificFrontiercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_SpecificFrontiercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_SpecificFrontierdirs :
	@if test ! -d $(bin)test_Integration_SpecificFrontier; then $(mkdir) -p $(bin)test_Integration_SpecificFrontier; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_SpecificFrontier
else
test_Integration_SpecificFrontierdirs : ;
endif

ifdef cmt_test_Integration_SpecificFrontier_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_SpecificFrontier_makefile) : $(test_Integration_SpecificFrontiercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_SpecificFrontier.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_SpecificFrontier_extratags) build constituent_config -out=$(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontier
else
$(cmt_local_test_Integration_SpecificFrontier_makefile) : $(test_Integration_SpecificFrontiercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_SpecificFrontier) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_SpecificFrontier) ] || \
	  $(not_test_Integration_SpecificFrontiercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_SpecificFrontier.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_SpecificFrontier_extratags) build constituent_config -out=$(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontier; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_SpecificFrontier_makefile) : $(test_Integration_SpecificFrontiercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_SpecificFrontier.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_SpecificFrontier.in -tag=$(tags) $(test_Integration_SpecificFrontier_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontier
else
$(cmt_local_test_Integration_SpecificFrontier_makefile) : $(test_Integration_SpecificFrontiercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_SpecificFrontier.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_SpecificFrontier) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_SpecificFrontier) ] || \
	  $(not_test_Integration_SpecificFrontiercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_SpecificFrontier.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_SpecificFrontier.in -tag=$(tags) $(test_Integration_SpecificFrontier_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontier; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_SpecificFrontier_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontier

test_Integration_SpecificFrontier :: test_Integration_SpecificFrontiercompile test_Integration_SpecificFrontierinstall ;

ifdef cmt_test_Integration_SpecificFrontier_has_prototypes

test_Integration_SpecificFrontierprototype : $(test_Integration_SpecificFrontierprototype_dependencies) $(cmt_local_test_Integration_SpecificFrontier_makefile) dirs test_Integration_SpecificFrontierdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_SpecificFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_SpecificFrontiercompile : test_Integration_SpecificFrontierprototype

endif

test_Integration_SpecificFrontiercompile : $(test_Integration_SpecificFrontiercompile_dependencies) $(cmt_local_test_Integration_SpecificFrontier_makefile) dirs test_Integration_SpecificFrontierdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_SpecificFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_SpecificFrontierclean ;

test_Integration_SpecificFrontierclean :: $(test_Integration_SpecificFrontierclean_dependencies) ##$(cmt_local_test_Integration_SpecificFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_SpecificFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) test_Integration_SpecificFrontierclean

##	  /bin/rm -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $(bin)test_Integration_SpecificFrontier_dependencies.make

install :: test_Integration_SpecificFrontierinstall ;

test_Integration_SpecificFrontierinstall :: test_Integration_SpecificFrontiercompile $(test_Integration_SpecificFrontier_dependencies) $(cmt_local_test_Integration_SpecificFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_SpecificFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_SpecificFrontieruninstall

$(foreach d,$(test_Integration_SpecificFrontier_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_SpecificFrontieruninstall))

test_Integration_SpecificFrontieruninstall : $(test_Integration_SpecificFrontieruninstall_dependencies) ##$(cmt_local_test_Integration_SpecificFrontier_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_SpecificFrontier_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_SpecificFrontier_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_SpecificFrontieruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_SpecificFrontier"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_SpecificFrontier done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_StoredProcedures_has_no_target_tag = 1
cmt_test_Integration_StoredProcedures_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_StoredProcedures_has_target_tag

cmt_local_tagfile_test_Integration_StoredProcedures = $(bin)$(Tests_tag)_test_Integration_StoredProcedures.make
cmt_final_setup_test_Integration_StoredProcedures = $(bin)setup_test_Integration_StoredProcedures.make
cmt_local_test_Integration_StoredProcedures_makefile = $(bin)test_Integration_StoredProcedures.make

test_Integration_StoredProcedures_extratags = -tag_add=target_test_Integration_StoredProcedures

else

cmt_local_tagfile_test_Integration_StoredProcedures = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_StoredProcedures = $(bin)setup.make
cmt_local_test_Integration_StoredProcedures_makefile = $(bin)test_Integration_StoredProcedures.make

endif

not_test_Integration_StoredProcedurescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_StoredProcedurescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_StoredProceduresdirs :
	@if test ! -d $(bin)test_Integration_StoredProcedures; then $(mkdir) -p $(bin)test_Integration_StoredProcedures; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_StoredProcedures
else
test_Integration_StoredProceduresdirs : ;
endif

ifdef cmt_test_Integration_StoredProcedures_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_StoredProcedures_makefile) : $(test_Integration_StoredProcedurescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_StoredProcedures.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_StoredProcedures_extratags) build constituent_config -out=$(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProcedures
else
$(cmt_local_test_Integration_StoredProcedures_makefile) : $(test_Integration_StoredProcedurescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_StoredProcedures) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_StoredProcedures) ] || \
	  $(not_test_Integration_StoredProcedurescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_StoredProcedures.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_StoredProcedures_extratags) build constituent_config -out=$(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProcedures; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_StoredProcedures_makefile) : $(test_Integration_StoredProcedurescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_StoredProcedures.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_StoredProcedures.in -tag=$(tags) $(test_Integration_StoredProcedures_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProcedures
else
$(cmt_local_test_Integration_StoredProcedures_makefile) : $(test_Integration_StoredProcedurescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_StoredProcedures.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_StoredProcedures) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_StoredProcedures) ] || \
	  $(not_test_Integration_StoredProcedurescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_StoredProcedures.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_StoredProcedures.in -tag=$(tags) $(test_Integration_StoredProcedures_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProcedures; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_StoredProcedures_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProcedures

test_Integration_StoredProcedures :: test_Integration_StoredProcedurescompile test_Integration_StoredProceduresinstall ;

ifdef cmt_test_Integration_StoredProcedures_has_prototypes

test_Integration_StoredProceduresprototype : $(test_Integration_StoredProceduresprototype_dependencies) $(cmt_local_test_Integration_StoredProcedures_makefile) dirs test_Integration_StoredProceduresdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_StoredProcedures_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_StoredProcedurescompile : test_Integration_StoredProceduresprototype

endif

test_Integration_StoredProcedurescompile : $(test_Integration_StoredProcedurescompile_dependencies) $(cmt_local_test_Integration_StoredProcedures_makefile) dirs test_Integration_StoredProceduresdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_StoredProcedures_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_StoredProceduresclean ;

test_Integration_StoredProceduresclean :: $(test_Integration_StoredProceduresclean_dependencies) ##$(cmt_local_test_Integration_StoredProcedures_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_StoredProcedures_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) test_Integration_StoredProceduresclean

##	  /bin/rm -f $(cmt_local_test_Integration_StoredProcedures_makefile) $(bin)test_Integration_StoredProcedures_dependencies.make

install :: test_Integration_StoredProceduresinstall ;

test_Integration_StoredProceduresinstall :: test_Integration_StoredProcedurescompile $(test_Integration_StoredProcedures_dependencies) $(cmt_local_test_Integration_StoredProcedures_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_StoredProcedures_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_StoredProceduresuninstall

$(foreach d,$(test_Integration_StoredProcedures_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_StoredProceduresuninstall))

test_Integration_StoredProceduresuninstall : $(test_Integration_StoredProceduresuninstall_dependencies) ##$(cmt_local_test_Integration_StoredProcedures_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_StoredProcedures_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_StoredProcedures_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_StoredProceduresuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_StoredProcedures"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_StoredProcedures done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_Integration_WriteRead_has_no_target_tag = 1
cmt_test_Integration_WriteRead_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_Integration_WriteRead_has_target_tag

cmt_local_tagfile_test_Integration_WriteRead = $(bin)$(Tests_tag)_test_Integration_WriteRead.make
cmt_final_setup_test_Integration_WriteRead = $(bin)setup_test_Integration_WriteRead.make
cmt_local_test_Integration_WriteRead_makefile = $(bin)test_Integration_WriteRead.make

test_Integration_WriteRead_extratags = -tag_add=target_test_Integration_WriteRead

else

cmt_local_tagfile_test_Integration_WriteRead = $(bin)$(Tests_tag).make
cmt_final_setup_test_Integration_WriteRead = $(bin)setup.make
cmt_local_test_Integration_WriteRead_makefile = $(bin)test_Integration_WriteRead.make

endif

not_test_Integration_WriteReadcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_Integration_WriteReadcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_Integration_WriteReaddirs :
	@if test ! -d $(bin)test_Integration_WriteRead; then $(mkdir) -p $(bin)test_Integration_WriteRead; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_Integration_WriteRead
else
test_Integration_WriteReaddirs : ;
endif

ifdef cmt_test_Integration_WriteRead_has_target_tag

ifndef QUICK
$(cmt_local_test_Integration_WriteRead_makefile) : $(test_Integration_WriteReadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_WriteRead.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_WriteRead_extratags) build constituent_config -out=$(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteRead
else
$(cmt_local_test_Integration_WriteRead_makefile) : $(test_Integration_WriteReadcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_WriteRead) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_WriteRead) ] || \
	  $(not_test_Integration_WriteReadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_WriteRead.make"; \
	  $(cmtexe) -tag=$(tags) $(test_Integration_WriteRead_extratags) build constituent_config -out=$(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteRead; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_Integration_WriteRead_makefile) : $(test_Integration_WriteReadcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_Integration_WriteRead.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_WriteRead.in -tag=$(tags) $(test_Integration_WriteRead_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteRead
else
$(cmt_local_test_Integration_WriteRead_makefile) : $(test_Integration_WriteReadcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_Integration_WriteRead.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_Integration_WriteRead) ] || \
	  [ ! -f $(cmt_final_setup_test_Integration_WriteRead) ] || \
	  $(not_test_Integration_WriteReadcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_Integration_WriteRead.make"; \
	  $(cmtexe) -f=$(bin)test_Integration_WriteRead.in -tag=$(tags) $(test_Integration_WriteRead_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteRead; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_Integration_WriteRead_extratags) build constituent_makefile -out=$(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteRead

test_Integration_WriteRead :: test_Integration_WriteReadcompile test_Integration_WriteReadinstall ;

ifdef cmt_test_Integration_WriteRead_has_prototypes

test_Integration_WriteReadprototype : $(test_Integration_WriteReadprototype_dependencies) $(cmt_local_test_Integration_WriteRead_makefile) dirs test_Integration_WriteReaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_WriteRead_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_Integration_WriteReadcompile : test_Integration_WriteReadprototype

endif

test_Integration_WriteReadcompile : $(test_Integration_WriteReadcompile_dependencies) $(cmt_local_test_Integration_WriteRead_makefile) dirs test_Integration_WriteReaddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_WriteRead_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_Integration_WriteReadclean ;

test_Integration_WriteReadclean :: $(test_Integration_WriteReadclean_dependencies) ##$(cmt_local_test_Integration_WriteRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_WriteRead_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) test_Integration_WriteReadclean

##	  /bin/rm -f $(cmt_local_test_Integration_WriteRead_makefile) $(bin)test_Integration_WriteRead_dependencies.make

install :: test_Integration_WriteReadinstall ;

test_Integration_WriteReadinstall :: test_Integration_WriteReadcompile $(test_Integration_WriteRead_dependencies) $(cmt_local_test_Integration_WriteRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_Integration_WriteRead_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_Integration_WriteReaduninstall

$(foreach d,$(test_Integration_WriteRead_dependencies),$(eval $(d)uninstall_dependencies += test_Integration_WriteReaduninstall))

test_Integration_WriteReaduninstall : $(test_Integration_WriteReaduninstall_dependencies) ##$(cmt_local_test_Integration_WriteRead_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_Integration_WriteRead_makefile); then \
	  $(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_Integration_WriteRead_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_Integration_WriteReaduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_Integration_WriteRead"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_Integration_WriteRead done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(Tests_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(Tests_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(Tests_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(Tests_tag).make
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

cmt_local_tagfile_make = $(bin)$(Tests_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(Tests_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(Tests_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(Tests_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(Tests_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(Tests_tag).make
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

cmt_local_tagfile_examples = $(bin)$(Tests_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(Tests_tag).make
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
