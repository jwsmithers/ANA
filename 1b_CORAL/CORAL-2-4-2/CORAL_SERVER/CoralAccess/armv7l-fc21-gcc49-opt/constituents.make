
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralAccess_tag = $(tag)

#cmt_local_tagfile = $(CoralAccess_tag).make
cmt_local_tagfile = $(bin)$(CoralAccess_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralAccesssetup.make
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
#-- start of constituent_app_lib ------

cmt_lcg_CoralAccess_has_no_target_tag = 1
cmt_lcg_CoralAccess_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralAccess_has_target_tag

cmt_local_tagfile_lcg_CoralAccess = $(bin)$(CoralAccess_tag)_lcg_CoralAccess.make
cmt_final_setup_lcg_CoralAccess = $(bin)setup_lcg_CoralAccess.make
cmt_local_lcg_CoralAccess_makefile = $(bin)lcg_CoralAccess.make

lcg_CoralAccess_extratags = -tag_add=target_lcg_CoralAccess

else

cmt_local_tagfile_lcg_CoralAccess = $(bin)$(CoralAccess_tag).make
cmt_final_setup_lcg_CoralAccess = $(bin)setup.make
cmt_local_lcg_CoralAccess_makefile = $(bin)lcg_CoralAccess.make

endif

not_lcg_CoralAccesscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralAccesscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralAccessdirs :
	@if test ! -d $(bin)lcg_CoralAccess; then $(mkdir) -p $(bin)lcg_CoralAccess; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralAccess
else
lcg_CoralAccessdirs : ;
endif

ifdef cmt_lcg_CoralAccess_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralAccess_makefile) : $(lcg_CoralAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralAccess_extratags) build constituent_config -out=$(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccess
else
$(cmt_local_lcg_CoralAccess_makefile) : $(lcg_CoralAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralAccess) ] || \
	  $(not_lcg_CoralAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralAccess.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralAccess_extratags) build constituent_config -out=$(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccess; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralAccess_makefile) : $(lcg_CoralAccesscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralAccess.in -tag=$(tags) $(lcg_CoralAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccess
else
$(cmt_local_lcg_CoralAccess_makefile) : $(lcg_CoralAccesscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralAccess.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralAccess) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralAccess) ] || \
	  $(not_lcg_CoralAccesscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralAccess.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralAccess.in -tag=$(tags) $(lcg_CoralAccess_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccess; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralAccess_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccess

lcg_CoralAccess :: lcg_CoralAccesscompile lcg_CoralAccessinstall ;

ifdef cmt_lcg_CoralAccess_has_prototypes

lcg_CoralAccessprototype : $(lcg_CoralAccessprototype_dependencies) $(cmt_local_lcg_CoralAccess_makefile) dirs lcg_CoralAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralAccesscompile : lcg_CoralAccessprototype

endif

lcg_CoralAccesscompile : $(lcg_CoralAccesscompile_dependencies) $(cmt_local_lcg_CoralAccess_makefile) dirs lcg_CoralAccessdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralAccessclean ;

lcg_CoralAccessclean :: $(lcg_CoralAccessclean_dependencies) ##$(cmt_local_lcg_CoralAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) lcg_CoralAccessclean

##	  /bin/rm -f $(cmt_local_lcg_CoralAccess_makefile) $(bin)lcg_CoralAccess_dependencies.make

install :: lcg_CoralAccessinstall ;

lcg_CoralAccessinstall :: lcg_CoralAccesscompile $(lcg_CoralAccess_dependencies) $(cmt_local_lcg_CoralAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralAccessuninstall

$(foreach d,$(lcg_CoralAccess_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralAccessuninstall))

lcg_CoralAccessuninstall : $(lcg_CoralAccessuninstall_dependencies) ##$(cmt_local_lcg_CoralAccess_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralAccess_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralAccess_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralAccessuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralAccess"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralAccess done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralAccess_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralAccess_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralAccess_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralAccess_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralAccess_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralAccess_tag).make
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

cmt_tests_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_tests_has_target_tag

cmt_local_tagfile_tests = $(bin)$(CoralAccess_tag)_tests.make
cmt_final_setup_tests = $(bin)setup_tests.make
cmt_local_tests_makefile = $(bin)tests.make

tests_extratags = -tag_add=target_tests

else

cmt_local_tagfile_tests = $(bin)$(CoralAccess_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(CoralAccess_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoralAccess_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoralAccess_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralAccess_tag).make
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
