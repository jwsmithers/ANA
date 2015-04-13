
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

PyCool_tag = $(tag)

#cmt_local_tagfile = $(PyCool_tag).make
cmt_local_tagfile = $(bin)$(PyCool_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)PyCoolsetup.make
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
#-- start of constituent ------

cmt_lcg_PyCoolGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_lcg_PyCoolGen_has_target_tag

cmt_local_tagfile_lcg_PyCoolGen = $(bin)$(PyCool_tag)_lcg_PyCoolGen.make
cmt_final_setup_lcg_PyCoolGen = $(bin)setup_lcg_PyCoolGen.make
cmt_local_lcg_PyCoolGen_makefile = $(bin)lcg_PyCoolGen.make

lcg_PyCoolGen_extratags = -tag_add=target_lcg_PyCoolGen

else

cmt_local_tagfile_lcg_PyCoolGen = $(bin)$(PyCool_tag).make
cmt_final_setup_lcg_PyCoolGen = $(bin)setup.make
cmt_local_lcg_PyCoolGen_makefile = $(bin)lcg_PyCoolGen.make

endif

not_lcg_PyCoolGen_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_PyCoolGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_PyCoolGendirs :
	@if test ! -d $(bin)lcg_PyCoolGen; then $(mkdir) -p $(bin)lcg_PyCoolGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_PyCoolGen
else
lcg_PyCoolGendirs : ;
endif

ifdef cmt_lcg_PyCoolGen_has_target_tag

ifndef QUICK
$(cmt_local_lcg_PyCoolGen_makefile) : $(lcg_PyCoolGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_PyCoolGen.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolGen_extratags) build constituent_config -out=$(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen
else
$(cmt_local_lcg_PyCoolGen_makefile) : $(lcg_PyCoolGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_PyCoolGen) ] || \
	  [ ! -f $(cmt_final_setup_lcg_PyCoolGen) ] || \
	  $(not_lcg_PyCoolGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_PyCoolGen.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolGen_extratags) build constituent_config -out=$(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_PyCoolGen_makefile) : $(lcg_PyCoolGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_PyCoolGen.make"; \
	  $(cmtexe) -f=$(bin)lcg_PyCoolGen.in -tag=$(tags) $(lcg_PyCoolGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen
else
$(cmt_local_lcg_PyCoolGen_makefile) : $(lcg_PyCoolGen_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_PyCoolGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_PyCoolGen) ] || \
	  [ ! -f $(cmt_final_setup_lcg_PyCoolGen) ] || \
	  $(not_lcg_PyCoolGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_PyCoolGen.make"; \
	  $(cmtexe) -f=$(bin)lcg_PyCoolGen.in -tag=$(tags) $(lcg_PyCoolGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolGen_extratags) build constituent_makefile -out=$(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen

lcg_PyCoolGen :: $(lcg_PyCoolGen_dependencies) $(cmt_local_lcg_PyCoolGen_makefile) dirs lcg_PyCoolGendirs
	$(echo) "(constituents.make) Starting lcg_PyCoolGen"
	@if test -f $(cmt_local_lcg_PyCoolGen_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGen
	$(echo) "(constituents.make) lcg_PyCoolGen done"

clean :: lcg_PyCoolGenclean ;

lcg_PyCoolGenclean :: $(lcg_PyCoolGenclean_dependencies) ##$(cmt_local_lcg_PyCoolGen_makefile)
	$(echo) "(constituents.make) Starting lcg_PyCoolGenclean"
	@-if test -f $(cmt_local_lcg_PyCoolGen_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGenclean; \
	fi
	$(echo) "(constituents.make) lcg_PyCoolGenclean done"
#	@-$(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) lcg_PyCoolGenclean

##	  /bin/rm -f $(cmt_local_lcg_PyCoolGen_makefile) $(bin)lcg_PyCoolGen_dependencies.make

install :: lcg_PyCoolGeninstall ;

lcg_PyCoolGeninstall :: $(lcg_PyCoolGen_dependencies) $(cmt_local_lcg_PyCoolGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_PyCoolGen_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_PyCoolGenuninstall

$(foreach d,$(lcg_PyCoolGen_dependencies),$(eval $(d)uninstall_dependencies += lcg_PyCoolGenuninstall))

lcg_PyCoolGenuninstall : $(lcg_PyCoolGenuninstall_dependencies) ##$(cmt_local_lcg_PyCoolGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_PyCoolGen_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_PyCoolGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_PyCoolGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_PyCoolGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_lcg_PyCoolDict_has_no_target_tag = 1
cmt_lcg_PyCoolDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_PyCoolDict_has_target_tag

cmt_local_tagfile_lcg_PyCoolDict = $(bin)$(PyCool_tag)_lcg_PyCoolDict.make
cmt_final_setup_lcg_PyCoolDict = $(bin)setup_lcg_PyCoolDict.make
cmt_local_lcg_PyCoolDict_makefile = $(bin)lcg_PyCoolDict.make

lcg_PyCoolDict_extratags = -tag_add=target_lcg_PyCoolDict

else

cmt_local_tagfile_lcg_PyCoolDict = $(bin)$(PyCool_tag).make
cmt_final_setup_lcg_PyCoolDict = $(bin)setup.make
cmt_local_lcg_PyCoolDict_makefile = $(bin)lcg_PyCoolDict.make

endif

not_lcg_PyCoolDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_PyCoolDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_PyCoolDictdirs :
	@if test ! -d $(bin)lcg_PyCoolDict; then $(mkdir) -p $(bin)lcg_PyCoolDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_PyCoolDict
else
lcg_PyCoolDictdirs : ;
endif

ifdef cmt_lcg_PyCoolDict_has_target_tag

ifndef QUICK
$(cmt_local_lcg_PyCoolDict_makefile) : $(lcg_PyCoolDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_PyCoolDict.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolDict_extratags) build constituent_config -out=$(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDict
else
$(cmt_local_lcg_PyCoolDict_makefile) : $(lcg_PyCoolDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_PyCoolDict) ] || \
	  [ ! -f $(cmt_final_setup_lcg_PyCoolDict) ] || \
	  $(not_lcg_PyCoolDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_PyCoolDict.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolDict_extratags) build constituent_config -out=$(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_PyCoolDict_makefile) : $(lcg_PyCoolDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_PyCoolDict.make"; \
	  $(cmtexe) -f=$(bin)lcg_PyCoolDict.in -tag=$(tags) $(lcg_PyCoolDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDict
else
$(cmt_local_lcg_PyCoolDict_makefile) : $(lcg_PyCoolDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_PyCoolDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_PyCoolDict) ] || \
	  [ ! -f $(cmt_final_setup_lcg_PyCoolDict) ] || \
	  $(not_lcg_PyCoolDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_PyCoolDict.make"; \
	  $(cmtexe) -f=$(bin)lcg_PyCoolDict.in -tag=$(tags) $(lcg_PyCoolDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_PyCoolDict_extratags) build constituent_makefile -out=$(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDict

lcg_PyCoolDict :: lcg_PyCoolDictcompile lcg_PyCoolDictinstall ;

ifdef cmt_lcg_PyCoolDict_has_prototypes

lcg_PyCoolDictprototype : $(lcg_PyCoolDictprototype_dependencies) $(cmt_local_lcg_PyCoolDict_makefile) dirs lcg_PyCoolDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_PyCoolDict_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_PyCoolDictcompile : lcg_PyCoolDictprototype

endif

lcg_PyCoolDictcompile : $(lcg_PyCoolDictcompile_dependencies) $(cmt_local_lcg_PyCoolDict_makefile) dirs lcg_PyCoolDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_PyCoolDict_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_PyCoolDictclean ;

lcg_PyCoolDictclean :: $(lcg_PyCoolDictclean_dependencies) ##$(cmt_local_lcg_PyCoolDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_PyCoolDict_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) lcg_PyCoolDictclean

##	  /bin/rm -f $(cmt_local_lcg_PyCoolDict_makefile) $(bin)lcg_PyCoolDict_dependencies.make

install :: lcg_PyCoolDictinstall ;

lcg_PyCoolDictinstall :: lcg_PyCoolDictcompile $(lcg_PyCoolDict_dependencies) $(cmt_local_lcg_PyCoolDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_PyCoolDict_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_PyCoolDictuninstall

$(foreach d,$(lcg_PyCoolDict_dependencies),$(eval $(d)uninstall_dependencies += lcg_PyCoolDictuninstall))

lcg_PyCoolDictuninstall : $(lcg_PyCoolDictuninstall_dependencies) ##$(cmt_local_lcg_PyCoolDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_PyCoolDict_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_PyCoolDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_PyCoolDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_PyCoolDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_PyCoolDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(PyCool_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(PyCool_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(PyCool_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(PyCool_tag).make
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

cmt_local_tagfile_make = $(bin)$(PyCool_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(PyCool_tag).make
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

cmt_new_rootsys_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_new_rootsys_has_target_tag

cmt_local_tagfile_new_rootsys = $(bin)$(PyCool_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(PyCool_tag).make
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

cmt_concatenate_headers_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_concatenate_headers_has_target_tag

cmt_local_tagfile_concatenate_headers = $(bin)$(PyCool_tag)_concatenate_headers.make
cmt_final_setup_concatenate_headers = $(bin)setup_concatenate_headers.make
cmt_local_concatenate_headers_makefile = $(bin)concatenate_headers.make

concatenate_headers_extratags = -tag_add=target_concatenate_headers

else

cmt_local_tagfile_concatenate_headers = $(bin)$(PyCool_tag).make
cmt_final_setup_concatenate_headers = $(bin)setup.make
cmt_local_concatenate_headers_makefile = $(bin)concatenate_headers.make

endif

not_concatenate_headers_dependencies = { n=0; for p in $?; do m=0; for d in $(concatenate_headers_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
concatenate_headersdirs :
	@if test ! -d $(bin)concatenate_headers; then $(mkdir) -p $(bin)concatenate_headers; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)concatenate_headers
else
concatenate_headersdirs : ;
endif

ifdef cmt_concatenate_headers_has_target_tag

ifndef QUICK
$(cmt_local_concatenate_headers_makefile) : $(concatenate_headers_dependencies) build_library_links
	$(echo) "(constituents.make) Building concatenate_headers.make"; \
	  $(cmtexe) -tag=$(tags) $(concatenate_headers_extratags) build constituent_config -out=$(cmt_local_concatenate_headers_makefile) concatenate_headers
else
$(cmt_local_concatenate_headers_makefile) : $(concatenate_headers_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_concatenate_headers) ] || \
	  [ ! -f $(cmt_final_setup_concatenate_headers) ] || \
	  $(not_concatenate_headers_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building concatenate_headers.make"; \
	  $(cmtexe) -tag=$(tags) $(concatenate_headers_extratags) build constituent_config -out=$(cmt_local_concatenate_headers_makefile) concatenate_headers; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_concatenate_headers_makefile) : $(concatenate_headers_dependencies) build_library_links
	$(echo) "(constituents.make) Building concatenate_headers.make"; \
	  $(cmtexe) -f=$(bin)concatenate_headers.in -tag=$(tags) $(concatenate_headers_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_concatenate_headers_makefile) concatenate_headers
else
$(cmt_local_concatenate_headers_makefile) : $(concatenate_headers_dependencies) $(cmt_build_library_linksstamp) $(bin)concatenate_headers.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_concatenate_headers) ] || \
	  [ ! -f $(cmt_final_setup_concatenate_headers) ] || \
	  $(not_concatenate_headers_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building concatenate_headers.make"; \
	  $(cmtexe) -f=$(bin)concatenate_headers.in -tag=$(tags) $(concatenate_headers_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_concatenate_headers_makefile) concatenate_headers; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(concatenate_headers_extratags) build constituent_makefile -out=$(cmt_local_concatenate_headers_makefile) concatenate_headers

concatenate_headers :: $(concatenate_headers_dependencies) $(cmt_local_concatenate_headers_makefile) dirs concatenate_headersdirs
	$(echo) "(constituents.make) Starting concatenate_headers"
	@if test -f $(cmt_local_concatenate_headers_makefile); then \
	  $(MAKE) -f $(cmt_local_concatenate_headers_makefile) concatenate_headers; \
	  fi
#	@$(MAKE) -f $(cmt_local_concatenate_headers_makefile) concatenate_headers
	$(echo) "(constituents.make) concatenate_headers done"

clean :: concatenate_headersclean ;

concatenate_headersclean :: $(concatenate_headersclean_dependencies) ##$(cmt_local_concatenate_headers_makefile)
	$(echo) "(constituents.make) Starting concatenate_headersclean"
	@-if test -f $(cmt_local_concatenate_headers_makefile); then \
	  $(MAKE) -f $(cmt_local_concatenate_headers_makefile) concatenate_headersclean; \
	fi
	$(echo) "(constituents.make) concatenate_headersclean done"
#	@-$(MAKE) -f $(cmt_local_concatenate_headers_makefile) concatenate_headersclean

##	  /bin/rm -f $(cmt_local_concatenate_headers_makefile) $(bin)concatenate_headers_dependencies.make

install :: concatenate_headersinstall ;

concatenate_headersinstall :: $(concatenate_headers_dependencies) $(cmt_local_concatenate_headers_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_concatenate_headers_makefile); then \
	  $(MAKE) -f $(cmt_local_concatenate_headers_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_concatenate_headers_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : concatenate_headersuninstall

$(foreach d,$(concatenate_headers_dependencies),$(eval $(d)uninstall_dependencies += concatenate_headersuninstall))

concatenate_headersuninstall : $(concatenate_headersuninstall_dependencies) ##$(cmt_local_concatenate_headers_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_concatenate_headers_makefile); then \
	  $(MAKE) -f $(cmt_local_concatenate_headers_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_concatenate_headers_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: concatenate_headersuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ concatenate_headers"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ concatenate_headers done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_tmpdict_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_tmpdict_has_target_tag

cmt_local_tagfile_install_tmpdict = $(bin)$(PyCool_tag)_install_tmpdict.make
cmt_final_setup_install_tmpdict = $(bin)setup_install_tmpdict.make
cmt_local_install_tmpdict_makefile = $(bin)install_tmpdict.make

install_tmpdict_extratags = -tag_add=target_install_tmpdict

else

cmt_local_tagfile_install_tmpdict = $(bin)$(PyCool_tag).make
cmt_final_setup_install_tmpdict = $(bin)setup.make
cmt_local_install_tmpdict_makefile = $(bin)install_tmpdict.make

endif

not_install_tmpdict_dependencies = { n=0; for p in $?; do m=0; for d in $(install_tmpdict_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_tmpdictdirs :
	@if test ! -d $(bin)install_tmpdict; then $(mkdir) -p $(bin)install_tmpdict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_tmpdict
else
install_tmpdictdirs : ;
endif

ifdef cmt_install_tmpdict_has_target_tag

ifndef QUICK
$(cmt_local_install_tmpdict_makefile) : $(install_tmpdict_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_tmpdict.make"; \
	  $(cmtexe) -tag=$(tags) $(install_tmpdict_extratags) build constituent_config -out=$(cmt_local_install_tmpdict_makefile) install_tmpdict
else
$(cmt_local_install_tmpdict_makefile) : $(install_tmpdict_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_tmpdict) ] || \
	  [ ! -f $(cmt_final_setup_install_tmpdict) ] || \
	  $(not_install_tmpdict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_tmpdict.make"; \
	  $(cmtexe) -tag=$(tags) $(install_tmpdict_extratags) build constituent_config -out=$(cmt_local_install_tmpdict_makefile) install_tmpdict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_tmpdict_makefile) : $(install_tmpdict_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_tmpdict.make"; \
	  $(cmtexe) -f=$(bin)install_tmpdict.in -tag=$(tags) $(install_tmpdict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_tmpdict_makefile) install_tmpdict
else
$(cmt_local_install_tmpdict_makefile) : $(install_tmpdict_dependencies) $(cmt_build_library_linksstamp) $(bin)install_tmpdict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_tmpdict) ] || \
	  [ ! -f $(cmt_final_setup_install_tmpdict) ] || \
	  $(not_install_tmpdict_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_tmpdict.make"; \
	  $(cmtexe) -f=$(bin)install_tmpdict.in -tag=$(tags) $(install_tmpdict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_tmpdict_makefile) install_tmpdict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_tmpdict_extratags) build constituent_makefile -out=$(cmt_local_install_tmpdict_makefile) install_tmpdict

install_tmpdict :: $(install_tmpdict_dependencies) $(cmt_local_install_tmpdict_makefile) dirs install_tmpdictdirs
	$(echo) "(constituents.make) Starting install_tmpdict"
	@if test -f $(cmt_local_install_tmpdict_makefile); then \
	  $(MAKE) -f $(cmt_local_install_tmpdict_makefile) install_tmpdict; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_tmpdict_makefile) install_tmpdict
	$(echo) "(constituents.make) install_tmpdict done"

clean :: install_tmpdictclean ;

install_tmpdictclean :: $(install_tmpdictclean_dependencies) ##$(cmt_local_install_tmpdict_makefile)
	$(echo) "(constituents.make) Starting install_tmpdictclean"
	@-if test -f $(cmt_local_install_tmpdict_makefile); then \
	  $(MAKE) -f $(cmt_local_install_tmpdict_makefile) install_tmpdictclean; \
	fi
	$(echo) "(constituents.make) install_tmpdictclean done"
#	@-$(MAKE) -f $(cmt_local_install_tmpdict_makefile) install_tmpdictclean

##	  /bin/rm -f $(cmt_local_install_tmpdict_makefile) $(bin)install_tmpdict_dependencies.make

install :: install_tmpdictinstall ;

install_tmpdictinstall :: $(install_tmpdict_dependencies) $(cmt_local_install_tmpdict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_tmpdict_makefile); then \
	  $(MAKE) -f $(cmt_local_install_tmpdict_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_tmpdict_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_tmpdictuninstall

$(foreach d,$(install_tmpdict_dependencies),$(eval $(d)uninstall_dependencies += install_tmpdictuninstall))

install_tmpdictuninstall : $(install_tmpdictuninstall_dependencies) ##$(cmt_local_install_tmpdict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_tmpdict_makefile); then \
	  $(MAKE) -f $(cmt_local_install_tmpdict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_tmpdict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_tmpdictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_tmpdict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_tmpdict done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_tests_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_tests_has_target_tag

cmt_local_tagfile_tests = $(bin)$(PyCool_tag)_tests.make
cmt_final_setup_tests = $(bin)setup_tests.make
cmt_local_tests_makefile = $(bin)tests.make

tests_extratags = -tag_add=target_tests

else

cmt_local_tagfile_tests = $(bin)$(PyCool_tag).make
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

cmt_lcg_mkdir_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_lcg_mkdir_has_target_tag

cmt_local_tagfile_lcg_mkdir = $(bin)$(PyCool_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(PyCool_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(PyCool_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(PyCool_tag).make
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

cmt_local_tagfile_examples = $(bin)$(PyCool_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(PyCool_tag).make
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
