
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile = $(RootCnv_tag).make
cmt_local_tagfile = $(bin)$(RootCnv_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)RootCnvsetup.make
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

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(RootCnv_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(RootCnv_tag).make
cmt_final_setup_install_more_includes = $(bin)setup.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

endif

not_install_more_includes_dependencies = { n=0; for p in $?; do m=0; for d in $(install_more_includes_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_more_includesdirs :
	@if test ! -d $(bin)install_more_includes; then $(mkdir) -p $(bin)install_more_includes; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_more_includes
else
install_more_includesdirs : ;
endif

ifdef cmt_install_more_includes_has_target_tag

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_config -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes
else
$(cmt_local_install_more_includes_makefile) : $(install_more_includes_dependencies) $(cmt_build_library_linksstamp) $(bin)install_more_includes.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_more_includes) ] || \
	  [ ! -f $(cmt_final_setup_install_more_includes) ] || \
	  $(not_install_more_includes_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_more_includes.make"; \
	  $(cmtexe) -f=$(bin)install_more_includes.in -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_more_includes_extratags) build constituent_makefile -out=$(cmt_local_install_more_includes_makefile) install_more_includes

install_more_includes :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile) dirs install_more_includesdirs
	$(echo) "(constituents.make) Starting install_more_includes"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includes
	$(echo) "(constituents.make) install_more_includes done"

clean :: install_more_includesclean ;

install_more_includesclean :: $(install_more_includesclean_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting install_more_includesclean"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean; \
	fi
	$(echo) "(constituents.make) install_more_includesclean done"
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install_more_includesclean

##	  /bin/rm -f $(cmt_local_install_more_includes_makefile) $(bin)install_more_includes_dependencies.make

install :: install_more_includesinstall ;

install_more_includesinstall :: $(install_more_includes_dependencies) $(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_more_includes_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_more_includesuninstall

$(foreach d,$(install_more_includes_dependencies),$(eval $(d)uninstall_dependencies += install_more_includesuninstall))

install_more_includesuninstall : $(install_more_includesuninstall_dependencies) ##$(cmt_local_install_more_includes_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_more_includes_makefile); then \
	  $(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_more_includes_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_more_includesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_more_includes"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_more_includes done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootCnvGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnvGen_has_target_tag

cmt_local_tagfile_RootCnvGen = $(bin)$(RootCnv_tag)_RootCnvGen.make
cmt_final_setup_RootCnvGen = $(bin)setup_RootCnvGen.make
cmt_local_RootCnvGen_makefile = $(bin)RootCnvGen.make

RootCnvGen_extratags = -tag_add=target_RootCnvGen

else

cmt_local_tagfile_RootCnvGen = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvGen = $(bin)setup.make
cmt_local_RootCnvGen_makefile = $(bin)RootCnvGen.make

endif

not_RootCnvGen_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvGendirs :
	@if test ! -d $(bin)RootCnvGen; then $(mkdir) -p $(bin)RootCnvGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvGen
else
RootCnvGendirs : ;
endif

ifdef cmt_RootCnvGen_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvGen_makefile) : $(RootCnvGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvGen.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvGen_extratags) build constituent_config -out=$(cmt_local_RootCnvGen_makefile) RootCnvGen
else
$(cmt_local_RootCnvGen_makefile) : $(RootCnvGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvGen) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvGen) ] || \
	  $(not_RootCnvGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvGen.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvGen_extratags) build constituent_config -out=$(cmt_local_RootCnvGen_makefile) RootCnvGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvGen_makefile) : $(RootCnvGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvGen.make"; \
	  $(cmtexe) -f=$(bin)RootCnvGen.in -tag=$(tags) $(RootCnvGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvGen_makefile) RootCnvGen
else
$(cmt_local_RootCnvGen_makefile) : $(RootCnvGen_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvGen) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvGen) ] || \
	  $(not_RootCnvGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvGen.make"; \
	  $(cmtexe) -f=$(bin)RootCnvGen.in -tag=$(tags) $(RootCnvGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvGen_makefile) RootCnvGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvGen_extratags) build constituent_makefile -out=$(cmt_local_RootCnvGen_makefile) RootCnvGen

RootCnvGen :: $(RootCnvGen_dependencies) $(cmt_local_RootCnvGen_makefile) dirs RootCnvGendirs
	$(echo) "(constituents.make) Starting RootCnvGen"
	@if test -f $(cmt_local_RootCnvGen_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvGen_makefile) RootCnvGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvGen_makefile) RootCnvGen
	$(echo) "(constituents.make) RootCnvGen done"

clean :: RootCnvGenclean ;

RootCnvGenclean :: $(RootCnvGenclean_dependencies) ##$(cmt_local_RootCnvGen_makefile)
	$(echo) "(constituents.make) Starting RootCnvGenclean"
	@-if test -f $(cmt_local_RootCnvGen_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvGen_makefile) RootCnvGenclean; \
	fi
	$(echo) "(constituents.make) RootCnvGenclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnvGen_makefile) RootCnvGenclean

##	  /bin/rm -f $(cmt_local_RootCnvGen_makefile) $(bin)RootCnvGen_dependencies.make

install :: RootCnvGeninstall ;

RootCnvGeninstall :: $(RootCnvGen_dependencies) $(cmt_local_RootCnvGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvGen_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnvGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvGenuninstall

$(foreach d,$(RootCnvGen_dependencies),$(eval $(d)uninstall_dependencies += RootCnvGenuninstall))

RootCnvGenuninstall : $(RootCnvGenuninstall_dependencies) ##$(cmt_local_RootCnvGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvGen_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_RootCnvDict_has_no_target_tag = 1
cmt_RootCnvDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnvDict_has_target_tag

cmt_local_tagfile_RootCnvDict = $(bin)$(RootCnv_tag)_RootCnvDict.make
cmt_final_setup_RootCnvDict = $(bin)setup_RootCnvDict.make
cmt_local_RootCnvDict_makefile = $(bin)RootCnvDict.make

RootCnvDict_extratags = -tag_add=target_RootCnvDict

else

cmt_local_tagfile_RootCnvDict = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvDict = $(bin)setup.make
cmt_local_RootCnvDict_makefile = $(bin)RootCnvDict.make

endif

not_RootCnvDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvDictdirs :
	@if test ! -d $(bin)RootCnvDict; then $(mkdir) -p $(bin)RootCnvDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvDict
else
RootCnvDictdirs : ;
endif

ifdef cmt_RootCnvDict_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvDict_makefile) : $(RootCnvDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvDict.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvDict_extratags) build constituent_config -out=$(cmt_local_RootCnvDict_makefile) RootCnvDict
else
$(cmt_local_RootCnvDict_makefile) : $(RootCnvDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvDict) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvDict) ] || \
	  $(not_RootCnvDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvDict.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvDict_extratags) build constituent_config -out=$(cmt_local_RootCnvDict_makefile) RootCnvDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvDict_makefile) : $(RootCnvDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvDict.make"; \
	  $(cmtexe) -f=$(bin)RootCnvDict.in -tag=$(tags) $(RootCnvDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvDict_makefile) RootCnvDict
else
$(cmt_local_RootCnvDict_makefile) : $(RootCnvDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvDict) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvDict) ] || \
	  $(not_RootCnvDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvDict.make"; \
	  $(cmtexe) -f=$(bin)RootCnvDict.in -tag=$(tags) $(RootCnvDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvDict_makefile) RootCnvDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvDict_extratags) build constituent_makefile -out=$(cmt_local_RootCnvDict_makefile) RootCnvDict

RootCnvDict :: RootCnvDictcompile RootCnvDictinstall ;

ifdef cmt_RootCnvDict_has_prototypes

RootCnvDictprototype : $(RootCnvDictprototype_dependencies) $(cmt_local_RootCnvDict_makefile) dirs RootCnvDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

RootCnvDictcompile : RootCnvDictprototype

endif

RootCnvDictcompile : $(RootCnvDictcompile_dependencies) $(cmt_local_RootCnvDict_makefile) dirs RootCnvDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: RootCnvDictclean ;

RootCnvDictclean :: $(RootCnvDictclean_dependencies) ##$(cmt_local_RootCnvDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_RootCnvDict_makefile) RootCnvDictclean

##	  /bin/rm -f $(cmt_local_RootCnvDict_makefile) $(bin)RootCnvDict_dependencies.make

install :: RootCnvDictinstall ;

RootCnvDictinstall :: RootCnvDictcompile $(RootCnvDict_dependencies) $(cmt_local_RootCnvDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvDictuninstall

$(foreach d,$(RootCnvDict_dependencies),$(eval $(d)uninstall_dependencies += RootCnvDictuninstall))

RootCnvDictuninstall : $(RootCnvDictuninstall_dependencies) ##$(cmt_local_RootCnvDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvDict_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_RootCnvLib_has_no_target_tag = 1
cmt_RootCnvLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnvLib_has_target_tag

cmt_local_tagfile_RootCnvLib = $(bin)$(RootCnv_tag)_RootCnvLib.make
cmt_final_setup_RootCnvLib = $(bin)setup_RootCnvLib.make
cmt_local_RootCnvLib_makefile = $(bin)RootCnvLib.make

RootCnvLib_extratags = -tag_add=target_RootCnvLib

else

cmt_local_tagfile_RootCnvLib = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvLib = $(bin)setup.make
cmt_local_RootCnvLib_makefile = $(bin)RootCnvLib.make

endif

not_RootCnvLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvLibdirs :
	@if test ! -d $(bin)RootCnvLib; then $(mkdir) -p $(bin)RootCnvLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvLib
else
RootCnvLibdirs : ;
endif

ifdef cmt_RootCnvLib_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvLib_makefile) : $(RootCnvLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvLib.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvLib_extratags) build constituent_config -out=$(cmt_local_RootCnvLib_makefile) RootCnvLib
else
$(cmt_local_RootCnvLib_makefile) : $(RootCnvLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvLib) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvLib) ] || \
	  $(not_RootCnvLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvLib.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvLib_extratags) build constituent_config -out=$(cmt_local_RootCnvLib_makefile) RootCnvLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvLib_makefile) : $(RootCnvLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvLib.make"; \
	  $(cmtexe) -f=$(bin)RootCnvLib.in -tag=$(tags) $(RootCnvLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvLib_makefile) RootCnvLib
else
$(cmt_local_RootCnvLib_makefile) : $(RootCnvLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvLib) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvLib) ] || \
	  $(not_RootCnvLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvLib.make"; \
	  $(cmtexe) -f=$(bin)RootCnvLib.in -tag=$(tags) $(RootCnvLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvLib_makefile) RootCnvLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvLib_extratags) build constituent_makefile -out=$(cmt_local_RootCnvLib_makefile) RootCnvLib

RootCnvLib :: RootCnvLibcompile RootCnvLibinstall ;

ifdef cmt_RootCnvLib_has_prototypes

RootCnvLibprototype : $(RootCnvLibprototype_dependencies) $(cmt_local_RootCnvLib_makefile) dirs RootCnvLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvLib_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

RootCnvLibcompile : RootCnvLibprototype

endif

RootCnvLibcompile : $(RootCnvLibcompile_dependencies) $(cmt_local_RootCnvLib_makefile) dirs RootCnvLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvLib_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: RootCnvLibclean ;

RootCnvLibclean :: $(RootCnvLibclean_dependencies) ##$(cmt_local_RootCnvLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvLib_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_RootCnvLib_makefile) RootCnvLibclean

##	  /bin/rm -f $(cmt_local_RootCnvLib_makefile) $(bin)RootCnvLib_dependencies.make

install :: RootCnvLibinstall ;

RootCnvLibinstall :: RootCnvLibcompile $(RootCnvLib_dependencies) $(cmt_local_RootCnvLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvLib_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvLibuninstall

$(foreach d,$(RootCnvLib_dependencies),$(eval $(d)uninstall_dependencies += RootCnvLibuninstall))

RootCnvLibuninstall : $(RootCnvLibuninstall_dependencies) ##$(cmt_local_RootCnvLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvLib_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_RootCnv_has_no_target_tag = 1
cmt_RootCnv_has_prototypes = 1

#--------------------------------------

ifdef cmt_RootCnv_has_target_tag

cmt_local_tagfile_RootCnv = $(bin)$(RootCnv_tag)_RootCnv.make
cmt_final_setup_RootCnv = $(bin)setup_RootCnv.make
cmt_local_RootCnv_makefile = $(bin)RootCnv.make

RootCnv_extratags = -tag_add=target_RootCnv

else

cmt_local_tagfile_RootCnv = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnv = $(bin)setup.make
cmt_local_RootCnv_makefile = $(bin)RootCnv.make

endif

not_RootCnvcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvdirs :
	@if test ! -d $(bin)RootCnv; then $(mkdir) -p $(bin)RootCnv; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnv
else
RootCnvdirs : ;
endif

ifdef cmt_RootCnv_has_target_tag

ifndef QUICK
$(cmt_local_RootCnv_makefile) : $(RootCnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnv.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnv_extratags) build constituent_config -out=$(cmt_local_RootCnv_makefile) RootCnv
else
$(cmt_local_RootCnv_makefile) : $(RootCnvcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnv) ] || \
	  [ ! -f $(cmt_final_setup_RootCnv) ] || \
	  $(not_RootCnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnv.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnv_extratags) build constituent_config -out=$(cmt_local_RootCnv_makefile) RootCnv; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnv_makefile) : $(RootCnvcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnv.make"; \
	  $(cmtexe) -f=$(bin)RootCnv.in -tag=$(tags) $(RootCnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnv_makefile) RootCnv
else
$(cmt_local_RootCnv_makefile) : $(RootCnvcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnv.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnv) ] || \
	  [ ! -f $(cmt_final_setup_RootCnv) ] || \
	  $(not_RootCnvcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnv.make"; \
	  $(cmtexe) -f=$(bin)RootCnv.in -tag=$(tags) $(RootCnv_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnv_makefile) RootCnv; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnv_extratags) build constituent_makefile -out=$(cmt_local_RootCnv_makefile) RootCnv

RootCnv :: RootCnvcompile RootCnvinstall ;

ifdef cmt_RootCnv_has_prototypes

RootCnvprototype : $(RootCnvprototype_dependencies) $(cmt_local_RootCnv_makefile) dirs RootCnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

RootCnvcompile : RootCnvprototype

endif

RootCnvcompile : $(RootCnvcompile_dependencies) $(cmt_local_RootCnv_makefile) dirs RootCnvdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: RootCnvclean ;

RootCnvclean :: $(RootCnvclean_dependencies) ##$(cmt_local_RootCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_RootCnv_makefile) RootCnvclean

##	  /bin/rm -f $(cmt_local_RootCnv_makefile) $(bin)RootCnv_dependencies.make

install :: RootCnvinstall ;

RootCnvinstall :: RootCnvcompile $(RootCnv_dependencies) $(cmt_local_RootCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvuninstall

$(foreach d,$(RootCnv_dependencies),$(eval $(d)uninstall_dependencies += RootCnvuninstall))

RootCnvuninstall : $(RootCnvuninstall_dependencies) ##$(cmt_local_RootCnv_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnv_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnv"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnv done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_RootCnvComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnvComponentsList_has_target_tag

cmt_local_tagfile_RootCnvComponentsList = $(bin)$(RootCnv_tag)_RootCnvComponentsList.make
cmt_final_setup_RootCnvComponentsList = $(bin)setup_RootCnvComponentsList.make
cmt_local_RootCnvComponentsList_makefile = $(bin)RootCnvComponentsList.make

RootCnvComponentsList_extratags = -tag_add=target_RootCnvComponentsList

else

cmt_local_tagfile_RootCnvComponentsList = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvComponentsList = $(bin)setup.make
cmt_local_RootCnvComponentsList_makefile = $(bin)RootCnvComponentsList.make

endif

not_RootCnvComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvComponentsListdirs :
	@if test ! -d $(bin)RootCnvComponentsList; then $(mkdir) -p $(bin)RootCnvComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvComponentsList
else
RootCnvComponentsListdirs : ;
endif

ifdef cmt_RootCnvComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvComponentsList_makefile) : $(RootCnvComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvComponentsList_extratags) build constituent_config -out=$(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList
else
$(cmt_local_RootCnvComponentsList_makefile) : $(RootCnvComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvComponentsList) ] || \
	  $(not_RootCnvComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvComponentsList_extratags) build constituent_config -out=$(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvComponentsList_makefile) : $(RootCnvComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootCnvComponentsList.in -tag=$(tags) $(RootCnvComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList
else
$(cmt_local_RootCnvComponentsList_makefile) : $(RootCnvComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvComponentsList) ] || \
	  $(not_RootCnvComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootCnvComponentsList.in -tag=$(tags) $(RootCnvComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvComponentsList_extratags) build constituent_makefile -out=$(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList

RootCnvComponentsList :: $(RootCnvComponentsList_dependencies) $(cmt_local_RootCnvComponentsList_makefile) dirs RootCnvComponentsListdirs
	$(echo) "(constituents.make) Starting RootCnvComponentsList"
	@if test -f $(cmt_local_RootCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsList
	$(echo) "(constituents.make) RootCnvComponentsList done"

clean :: RootCnvComponentsListclean ;

RootCnvComponentsListclean :: $(RootCnvComponentsListclean_dependencies) ##$(cmt_local_RootCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting RootCnvComponentsListclean"
	@-if test -f $(cmt_local_RootCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsListclean; \
	fi
	$(echo) "(constituents.make) RootCnvComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) RootCnvComponentsListclean

##	  /bin/rm -f $(cmt_local_RootCnvComponentsList_makefile) $(bin)RootCnvComponentsList_dependencies.make

install :: RootCnvComponentsListinstall ;

RootCnvComponentsListinstall :: $(RootCnvComponentsList_dependencies) $(cmt_local_RootCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvComponentsListuninstall

$(foreach d,$(RootCnvComponentsList_dependencies),$(eval $(d)uninstall_dependencies += RootCnvComponentsListuninstall))

RootCnvComponentsListuninstall : $(RootCnvComponentsListuninstall_dependencies) ##$(cmt_local_RootCnvComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootCnvMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnvMergeComponentsList_has_target_tag

cmt_local_tagfile_RootCnvMergeComponentsList = $(bin)$(RootCnv_tag)_RootCnvMergeComponentsList.make
cmt_final_setup_RootCnvMergeComponentsList = $(bin)setup_RootCnvMergeComponentsList.make
cmt_local_RootCnvMergeComponentsList_makefile = $(bin)RootCnvMergeComponentsList.make

RootCnvMergeComponentsList_extratags = -tag_add=target_RootCnvMergeComponentsList

else

cmt_local_tagfile_RootCnvMergeComponentsList = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvMergeComponentsList = $(bin)setup.make
cmt_local_RootCnvMergeComponentsList_makefile = $(bin)RootCnvMergeComponentsList.make

endif

not_RootCnvMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvMergeComponentsListdirs :
	@if test ! -d $(bin)RootCnvMergeComponentsList; then $(mkdir) -p $(bin)RootCnvMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvMergeComponentsList
else
RootCnvMergeComponentsListdirs : ;
endif

ifdef cmt_RootCnvMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvMergeComponentsList_makefile) : $(RootCnvMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList
else
$(cmt_local_RootCnvMergeComponentsList_makefile) : $(RootCnvMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvMergeComponentsList) ] || \
	  $(not_RootCnvMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvMergeComponentsList_makefile) : $(RootCnvMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootCnvMergeComponentsList.in -tag=$(tags) $(RootCnvMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList
else
$(cmt_local_RootCnvMergeComponentsList_makefile) : $(RootCnvMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvMergeComponentsList) ] || \
	  $(not_RootCnvMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)RootCnvMergeComponentsList.in -tag=$(tags) $(RootCnvMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList

RootCnvMergeComponentsList :: $(RootCnvMergeComponentsList_dependencies) $(cmt_local_RootCnvMergeComponentsList_makefile) dirs RootCnvMergeComponentsListdirs
	$(echo) "(constituents.make) Starting RootCnvMergeComponentsList"
	@if test -f $(cmt_local_RootCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsList
	$(echo) "(constituents.make) RootCnvMergeComponentsList done"

clean :: RootCnvMergeComponentsListclean ;

RootCnvMergeComponentsListclean :: $(RootCnvMergeComponentsListclean_dependencies) ##$(cmt_local_RootCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting RootCnvMergeComponentsListclean"
	@-if test -f $(cmt_local_RootCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) RootCnvMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) RootCnvMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_RootCnvMergeComponentsList_makefile) $(bin)RootCnvMergeComponentsList_dependencies.make

install :: RootCnvMergeComponentsListinstall ;

RootCnvMergeComponentsListinstall :: $(RootCnvMergeComponentsList_dependencies) $(cmt_local_RootCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvMergeComponentsListuninstall

$(foreach d,$(RootCnvMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += RootCnvMergeComponentsListuninstall))

RootCnvMergeComponentsListuninstall : $(RootCnvMergeComponentsListuninstall_dependencies) ##$(cmt_local_RootCnvMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootCnvConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnvConf_has_target_tag

cmt_local_tagfile_RootCnvConf = $(bin)$(RootCnv_tag)_RootCnvConf.make
cmt_final_setup_RootCnvConf = $(bin)setup_RootCnvConf.make
cmt_local_RootCnvConf_makefile = $(bin)RootCnvConf.make

RootCnvConf_extratags = -tag_add=target_RootCnvConf

else

cmt_local_tagfile_RootCnvConf = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvConf = $(bin)setup.make
cmt_local_RootCnvConf_makefile = $(bin)RootCnvConf.make

endif

not_RootCnvConf_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvConfdirs :
	@if test ! -d $(bin)RootCnvConf; then $(mkdir) -p $(bin)RootCnvConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvConf
else
RootCnvConfdirs : ;
endif

ifdef cmt_RootCnvConf_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvConf_makefile) : $(RootCnvConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvConf.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvConf_extratags) build constituent_config -out=$(cmt_local_RootCnvConf_makefile) RootCnvConf
else
$(cmt_local_RootCnvConf_makefile) : $(RootCnvConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvConf) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvConf) ] || \
	  $(not_RootCnvConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvConf.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvConf_extratags) build constituent_config -out=$(cmt_local_RootCnvConf_makefile) RootCnvConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvConf_makefile) : $(RootCnvConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvConf.make"; \
	  $(cmtexe) -f=$(bin)RootCnvConf.in -tag=$(tags) $(RootCnvConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvConf_makefile) RootCnvConf
else
$(cmt_local_RootCnvConf_makefile) : $(RootCnvConf_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvConf) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvConf) ] || \
	  $(not_RootCnvConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvConf.make"; \
	  $(cmtexe) -f=$(bin)RootCnvConf.in -tag=$(tags) $(RootCnvConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvConf_makefile) RootCnvConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvConf_extratags) build constituent_makefile -out=$(cmt_local_RootCnvConf_makefile) RootCnvConf

RootCnvConf :: $(RootCnvConf_dependencies) $(cmt_local_RootCnvConf_makefile) dirs RootCnvConfdirs
	$(echo) "(constituents.make) Starting RootCnvConf"
	@if test -f $(cmt_local_RootCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConf_makefile) RootCnvConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvConf_makefile) RootCnvConf
	$(echo) "(constituents.make) RootCnvConf done"

clean :: RootCnvConfclean ;

RootCnvConfclean :: $(RootCnvConfclean_dependencies) ##$(cmt_local_RootCnvConf_makefile)
	$(echo) "(constituents.make) Starting RootCnvConfclean"
	@-if test -f $(cmt_local_RootCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConf_makefile) RootCnvConfclean; \
	fi
	$(echo) "(constituents.make) RootCnvConfclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnvConf_makefile) RootCnvConfclean

##	  /bin/rm -f $(cmt_local_RootCnvConf_makefile) $(bin)RootCnvConf_dependencies.make

install :: RootCnvConfinstall ;

RootCnvConfinstall :: $(RootCnvConf_dependencies) $(cmt_local_RootCnvConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnvConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvConfuninstall

$(foreach d,$(RootCnvConf_dependencies),$(eval $(d)uninstall_dependencies += RootCnvConfuninstall))

RootCnvConfuninstall : $(RootCnvConfuninstall_dependencies) ##$(cmt_local_RootCnvConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvConf_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootCnv_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnv_python_init_has_target_tag

cmt_local_tagfile_RootCnv_python_init = $(bin)$(RootCnv_tag)_RootCnv_python_init.make
cmt_final_setup_RootCnv_python_init = $(bin)setup_RootCnv_python_init.make
cmt_local_RootCnv_python_init_makefile = $(bin)RootCnv_python_init.make

RootCnv_python_init_extratags = -tag_add=target_RootCnv_python_init

else

cmt_local_tagfile_RootCnv_python_init = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnv_python_init = $(bin)setup.make
cmt_local_RootCnv_python_init_makefile = $(bin)RootCnv_python_init.make

endif

not_RootCnv_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnv_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnv_python_initdirs :
	@if test ! -d $(bin)RootCnv_python_init; then $(mkdir) -p $(bin)RootCnv_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnv_python_init
else
RootCnv_python_initdirs : ;
endif

ifdef cmt_RootCnv_python_init_has_target_tag

ifndef QUICK
$(cmt_local_RootCnv_python_init_makefile) : $(RootCnv_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnv_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnv_python_init_extratags) build constituent_config -out=$(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init
else
$(cmt_local_RootCnv_python_init_makefile) : $(RootCnv_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnv_python_init) ] || \
	  [ ! -f $(cmt_final_setup_RootCnv_python_init) ] || \
	  $(not_RootCnv_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnv_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnv_python_init_extratags) build constituent_config -out=$(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnv_python_init_makefile) : $(RootCnv_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnv_python_init.make"; \
	  $(cmtexe) -f=$(bin)RootCnv_python_init.in -tag=$(tags) $(RootCnv_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init
else
$(cmt_local_RootCnv_python_init_makefile) : $(RootCnv_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnv_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnv_python_init) ] || \
	  [ ! -f $(cmt_final_setup_RootCnv_python_init) ] || \
	  $(not_RootCnv_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnv_python_init.make"; \
	  $(cmtexe) -f=$(bin)RootCnv_python_init.in -tag=$(tags) $(RootCnv_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnv_python_init_extratags) build constituent_makefile -out=$(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init

RootCnv_python_init :: $(RootCnv_python_init_dependencies) $(cmt_local_RootCnv_python_init_makefile) dirs RootCnv_python_initdirs
	$(echo) "(constituents.make) Starting RootCnv_python_init"
	@if test -f $(cmt_local_RootCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) RootCnv_python_init
	$(echo) "(constituents.make) RootCnv_python_init done"

clean :: RootCnv_python_initclean ;

RootCnv_python_initclean :: $(RootCnv_python_initclean_dependencies) ##$(cmt_local_RootCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting RootCnv_python_initclean"
	@-if test -f $(cmt_local_RootCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) RootCnv_python_initclean; \
	fi
	$(echo) "(constituents.make) RootCnv_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) RootCnv_python_initclean

##	  /bin/rm -f $(cmt_local_RootCnv_python_init_makefile) $(bin)RootCnv_python_init_dependencies.make

install :: RootCnv_python_initinstall ;

RootCnv_python_initinstall :: $(RootCnv_python_init_dependencies) $(cmt_local_RootCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnv_python_inituninstall

$(foreach d,$(RootCnv_python_init_dependencies),$(eval $(d)uninstall_dependencies += RootCnv_python_inituninstall))

RootCnv_python_inituninstall : $(RootCnv_python_inituninstall_dependencies) ##$(cmt_local_RootCnv_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnv_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnv_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnv_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnv_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnv_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_RootCnv_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_RootCnv_python_modules_has_target_tag

cmt_local_tagfile_zip_RootCnv_python_modules = $(bin)$(RootCnv_tag)_zip_RootCnv_python_modules.make
cmt_final_setup_zip_RootCnv_python_modules = $(bin)setup_zip_RootCnv_python_modules.make
cmt_local_zip_RootCnv_python_modules_makefile = $(bin)zip_RootCnv_python_modules.make

zip_RootCnv_python_modules_extratags = -tag_add=target_zip_RootCnv_python_modules

else

cmt_local_tagfile_zip_RootCnv_python_modules = $(bin)$(RootCnv_tag).make
cmt_final_setup_zip_RootCnv_python_modules = $(bin)setup.make
cmt_local_zip_RootCnv_python_modules_makefile = $(bin)zip_RootCnv_python_modules.make

endif

not_zip_RootCnv_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_RootCnv_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_RootCnv_python_modulesdirs :
	@if test ! -d $(bin)zip_RootCnv_python_modules; then $(mkdir) -p $(bin)zip_RootCnv_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_RootCnv_python_modules
else
zip_RootCnv_python_modulesdirs : ;
endif

ifdef cmt_zip_RootCnv_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_RootCnv_python_modules_makefile) : $(zip_RootCnv_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_RootCnv_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_RootCnv_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules
else
$(cmt_local_zip_RootCnv_python_modules_makefile) : $(zip_RootCnv_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_RootCnv_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_RootCnv_python_modules) ] || \
	  $(not_zip_RootCnv_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_RootCnv_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_RootCnv_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_RootCnv_python_modules_makefile) : $(zip_RootCnv_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_RootCnv_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_RootCnv_python_modules.in -tag=$(tags) $(zip_RootCnv_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules
else
$(cmt_local_zip_RootCnv_python_modules_makefile) : $(zip_RootCnv_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_RootCnv_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_RootCnv_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_RootCnv_python_modules) ] || \
	  $(not_zip_RootCnv_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_RootCnv_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_RootCnv_python_modules.in -tag=$(tags) $(zip_RootCnv_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_RootCnv_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules

zip_RootCnv_python_modules :: $(zip_RootCnv_python_modules_dependencies) $(cmt_local_zip_RootCnv_python_modules_makefile) dirs zip_RootCnv_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_RootCnv_python_modules"
	@if test -f $(cmt_local_zip_RootCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modules
	$(echo) "(constituents.make) zip_RootCnv_python_modules done"

clean :: zip_RootCnv_python_modulesclean ;

zip_RootCnv_python_modulesclean :: $(zip_RootCnv_python_modulesclean_dependencies) ##$(cmt_local_zip_RootCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_RootCnv_python_modulesclean"
	@-if test -f $(cmt_local_zip_RootCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_RootCnv_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) zip_RootCnv_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_RootCnv_python_modules_makefile) $(bin)zip_RootCnv_python_modules_dependencies.make

install :: zip_RootCnv_python_modulesinstall ;

zip_RootCnv_python_modulesinstall :: $(zip_RootCnv_python_modules_dependencies) $(cmt_local_zip_RootCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_RootCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_RootCnv_python_modulesuninstall

$(foreach d,$(zip_RootCnv_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_RootCnv_python_modulesuninstall))

zip_RootCnv_python_modulesuninstall : $(zip_RootCnv_python_modulesuninstall_dependencies) ##$(cmt_local_zip_RootCnv_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_RootCnv_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_RootCnv_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_RootCnv_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_RootCnv_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_RootCnv_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_RootCnvConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_RootCnvConfDbMerge_has_target_tag

cmt_local_tagfile_RootCnvConfDbMerge = $(bin)$(RootCnv_tag)_RootCnvConfDbMerge.make
cmt_final_setup_RootCnvConfDbMerge = $(bin)setup_RootCnvConfDbMerge.make
cmt_local_RootCnvConfDbMerge_makefile = $(bin)RootCnvConfDbMerge.make

RootCnvConfDbMerge_extratags = -tag_add=target_RootCnvConfDbMerge

else

cmt_local_tagfile_RootCnvConfDbMerge = $(bin)$(RootCnv_tag).make
cmt_final_setup_RootCnvConfDbMerge = $(bin)setup.make
cmt_local_RootCnvConfDbMerge_makefile = $(bin)RootCnvConfDbMerge.make

endif

not_RootCnvConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(RootCnvConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
RootCnvConfDbMergedirs :
	@if test ! -d $(bin)RootCnvConfDbMerge; then $(mkdir) -p $(bin)RootCnvConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)RootCnvConfDbMerge
else
RootCnvConfDbMergedirs : ;
endif

ifdef cmt_RootCnvConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_RootCnvConfDbMerge_makefile) : $(RootCnvConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvConfDbMerge_extratags) build constituent_config -out=$(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge
else
$(cmt_local_RootCnvConfDbMerge_makefile) : $(RootCnvConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvConfDbMerge) ] || \
	  $(not_RootCnvConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(RootCnvConfDbMerge_extratags) build constituent_config -out=$(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_RootCnvConfDbMerge_makefile) : $(RootCnvConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building RootCnvConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)RootCnvConfDbMerge.in -tag=$(tags) $(RootCnvConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge
else
$(cmt_local_RootCnvConfDbMerge_makefile) : $(RootCnvConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)RootCnvConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_RootCnvConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_RootCnvConfDbMerge) ] || \
	  $(not_RootCnvConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building RootCnvConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)RootCnvConfDbMerge.in -tag=$(tags) $(RootCnvConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(RootCnvConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge

RootCnvConfDbMerge :: $(RootCnvConfDbMerge_dependencies) $(cmt_local_RootCnvConfDbMerge_makefile) dirs RootCnvConfDbMergedirs
	$(echo) "(constituents.make) Starting RootCnvConfDbMerge"
	@if test -f $(cmt_local_RootCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMerge
	$(echo) "(constituents.make) RootCnvConfDbMerge done"

clean :: RootCnvConfDbMergeclean ;

RootCnvConfDbMergeclean :: $(RootCnvConfDbMergeclean_dependencies) ##$(cmt_local_RootCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting RootCnvConfDbMergeclean"
	@-if test -f $(cmt_local_RootCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) RootCnvConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) RootCnvConfDbMergeclean

##	  /bin/rm -f $(cmt_local_RootCnvConfDbMerge_makefile) $(bin)RootCnvConfDbMerge_dependencies.make

install :: RootCnvConfDbMergeinstall ;

RootCnvConfDbMergeinstall :: $(RootCnvConfDbMerge_dependencies) $(cmt_local_RootCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_RootCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : RootCnvConfDbMergeuninstall

$(foreach d,$(RootCnvConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += RootCnvConfDbMergeuninstall))

RootCnvConfDbMergeuninstall : $(RootCnvConfDbMergeuninstall_dependencies) ##$(cmt_local_RootCnvConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_RootCnvConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_RootCnvConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: RootCnvConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ RootCnvConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ RootCnvConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_gaudi_merge_has_no_target_tag = 1
cmt_gaudi_merge_has_prototypes = 1

#--------------------------------------

ifdef cmt_gaudi_merge_has_target_tag

cmt_local_tagfile_gaudi_merge = $(bin)$(RootCnv_tag)_gaudi_merge.make
cmt_final_setup_gaudi_merge = $(bin)setup_gaudi_merge.make
cmt_local_gaudi_merge_makefile = $(bin)gaudi_merge.make

gaudi_merge_extratags = -tag_add=target_gaudi_merge

else

cmt_local_tagfile_gaudi_merge = $(bin)$(RootCnv_tag).make
cmt_final_setup_gaudi_merge = $(bin)setup.make
cmt_local_gaudi_merge_makefile = $(bin)gaudi_merge.make

endif

not_gaudi_mergecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(gaudi_mergecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
gaudi_mergedirs :
	@if test ! -d $(bin)gaudi_merge; then $(mkdir) -p $(bin)gaudi_merge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)gaudi_merge
else
gaudi_mergedirs : ;
endif

ifdef cmt_gaudi_merge_has_target_tag

ifndef QUICK
$(cmt_local_gaudi_merge_makefile) : $(gaudi_mergecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building gaudi_merge.make"; \
	  $(cmtexe) -tag=$(tags) $(gaudi_merge_extratags) build constituent_config -out=$(cmt_local_gaudi_merge_makefile) gaudi_merge
else
$(cmt_local_gaudi_merge_makefile) : $(gaudi_mergecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_gaudi_merge) ] || \
	  [ ! -f $(cmt_final_setup_gaudi_merge) ] || \
	  $(not_gaudi_mergecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building gaudi_merge.make"; \
	  $(cmtexe) -tag=$(tags) $(gaudi_merge_extratags) build constituent_config -out=$(cmt_local_gaudi_merge_makefile) gaudi_merge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_gaudi_merge_makefile) : $(gaudi_mergecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building gaudi_merge.make"; \
	  $(cmtexe) -f=$(bin)gaudi_merge.in -tag=$(tags) $(gaudi_merge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_gaudi_merge_makefile) gaudi_merge
else
$(cmt_local_gaudi_merge_makefile) : $(gaudi_mergecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)gaudi_merge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_gaudi_merge) ] || \
	  [ ! -f $(cmt_final_setup_gaudi_merge) ] || \
	  $(not_gaudi_mergecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building gaudi_merge.make"; \
	  $(cmtexe) -f=$(bin)gaudi_merge.in -tag=$(tags) $(gaudi_merge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_gaudi_merge_makefile) gaudi_merge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(gaudi_merge_extratags) build constituent_makefile -out=$(cmt_local_gaudi_merge_makefile) gaudi_merge

gaudi_merge :: gaudi_mergecompile gaudi_mergeinstall ;

ifdef cmt_gaudi_merge_has_prototypes

gaudi_mergeprototype : $(gaudi_mergeprototype_dependencies) $(cmt_local_gaudi_merge_makefile) dirs gaudi_mergedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_gaudi_merge_makefile); then \
	  $(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@
	$(echo) "(constituents.make) $@ done"

gaudi_mergecompile : gaudi_mergeprototype

endif

gaudi_mergecompile : $(gaudi_mergecompile_dependencies) $(cmt_local_gaudi_merge_makefile) dirs gaudi_mergedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_gaudi_merge_makefile); then \
	  $(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: gaudi_mergeclean ;

gaudi_mergeclean :: $(gaudi_mergeclean_dependencies) ##$(cmt_local_gaudi_merge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_gaudi_merge_makefile); then \
	  $(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_gaudi_merge_makefile) gaudi_mergeclean

##	  /bin/rm -f $(cmt_local_gaudi_merge_makefile) $(bin)gaudi_merge_dependencies.make

install :: gaudi_mergeinstall ;

gaudi_mergeinstall :: gaudi_mergecompile $(gaudi_merge_dependencies) $(cmt_local_gaudi_merge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_gaudi_merge_makefile); then \
	  $(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_gaudi_merge_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : gaudi_mergeuninstall

$(foreach d,$(gaudi_merge_dependencies),$(eval $(d)uninstall_dependencies += gaudi_mergeuninstall))

gaudi_mergeuninstall : $(gaudi_mergeuninstall_dependencies) ##$(cmt_local_gaudi_merge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_gaudi_merge_makefile); then \
	  $(MAKE) -f $(cmt_local_gaudi_merge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_gaudi_merge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: gaudi_mergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ gaudi_merge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ gaudi_merge done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_extract_event_has_no_target_tag = 1
cmt_extract_event_has_prototypes = 1

#--------------------------------------

ifdef cmt_extract_event_has_target_tag

cmt_local_tagfile_extract_event = $(bin)$(RootCnv_tag)_extract_event.make
cmt_final_setup_extract_event = $(bin)setup_extract_event.make
cmt_local_extract_event_makefile = $(bin)extract_event.make

extract_event_extratags = -tag_add=target_extract_event

else

cmt_local_tagfile_extract_event = $(bin)$(RootCnv_tag).make
cmt_final_setup_extract_event = $(bin)setup.make
cmt_local_extract_event_makefile = $(bin)extract_event.make

endif

not_extract_eventcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(extract_eventcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
extract_eventdirs :
	@if test ! -d $(bin)extract_event; then $(mkdir) -p $(bin)extract_event; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)extract_event
else
extract_eventdirs : ;
endif

ifdef cmt_extract_event_has_target_tag

ifndef QUICK
$(cmt_local_extract_event_makefile) : $(extract_eventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building extract_event.make"; \
	  $(cmtexe) -tag=$(tags) $(extract_event_extratags) build constituent_config -out=$(cmt_local_extract_event_makefile) extract_event
else
$(cmt_local_extract_event_makefile) : $(extract_eventcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_extract_event) ] || \
	  [ ! -f $(cmt_final_setup_extract_event) ] || \
	  $(not_extract_eventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building extract_event.make"; \
	  $(cmtexe) -tag=$(tags) $(extract_event_extratags) build constituent_config -out=$(cmt_local_extract_event_makefile) extract_event; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_extract_event_makefile) : $(extract_eventcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building extract_event.make"; \
	  $(cmtexe) -f=$(bin)extract_event.in -tag=$(tags) $(extract_event_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_extract_event_makefile) extract_event
else
$(cmt_local_extract_event_makefile) : $(extract_eventcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)extract_event.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_extract_event) ] || \
	  [ ! -f $(cmt_final_setup_extract_event) ] || \
	  $(not_extract_eventcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building extract_event.make"; \
	  $(cmtexe) -f=$(bin)extract_event.in -tag=$(tags) $(extract_event_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_extract_event_makefile) extract_event; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(extract_event_extratags) build constituent_makefile -out=$(cmt_local_extract_event_makefile) extract_event

extract_event :: extract_eventcompile extract_eventinstall ;

ifdef cmt_extract_event_has_prototypes

extract_eventprototype : $(extract_eventprototype_dependencies) $(cmt_local_extract_event_makefile) dirs extract_eventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_extract_event_makefile); then \
	  $(MAKE) -f $(cmt_local_extract_event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_extract_event_makefile) $@
	$(echo) "(constituents.make) $@ done"

extract_eventcompile : extract_eventprototype

endif

extract_eventcompile : $(extract_eventcompile_dependencies) $(cmt_local_extract_event_makefile) dirs extract_eventdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_extract_event_makefile); then \
	  $(MAKE) -f $(cmt_local_extract_event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_extract_event_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: extract_eventclean ;

extract_eventclean :: $(extract_eventclean_dependencies) ##$(cmt_local_extract_event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_extract_event_makefile); then \
	  $(MAKE) -f $(cmt_local_extract_event_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_extract_event_makefile) extract_eventclean

##	  /bin/rm -f $(cmt_local_extract_event_makefile) $(bin)extract_event_dependencies.make

install :: extract_eventinstall ;

extract_eventinstall :: extract_eventcompile $(extract_event_dependencies) $(cmt_local_extract_event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_extract_event_makefile); then \
	  $(MAKE) -f $(cmt_local_extract_event_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_extract_event_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : extract_eventuninstall

$(foreach d,$(extract_event_dependencies),$(eval $(d)uninstall_dependencies += extract_eventuninstall))

extract_eventuninstall : $(extract_eventuninstall_dependencies) ##$(cmt_local_extract_event_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_extract_event_makefile); then \
	  $(MAKE) -f $(cmt_local_extract_event_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_extract_event_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: extract_eventuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ extract_event"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ extract_event done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(RootCnv_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(RootCnv_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(RootCnv_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(RootCnv_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(RootCnv_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(RootCnv_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(RootCnv_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(RootCnv_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(RootCnv_tag).make
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
