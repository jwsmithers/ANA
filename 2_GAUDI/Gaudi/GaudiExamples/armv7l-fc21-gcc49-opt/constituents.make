
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile = $(GaudiExamples_tag).make
cmt_local_tagfile = $(bin)$(GaudiExamples_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiExamples_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiExamples_tag).make
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
#-- start of constituent_app_lib ------

cmt_GaudiExamplesLib_has_no_target_tag = 1
cmt_GaudiExamplesLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamplesLib_has_target_tag

cmt_local_tagfile_GaudiExamplesLib = $(bin)$(GaudiExamples_tag)_GaudiExamplesLib.make
cmt_final_setup_GaudiExamplesLib = $(bin)setup_GaudiExamplesLib.make
cmt_local_GaudiExamplesLib_makefile = $(bin)GaudiExamplesLib.make

GaudiExamplesLib_extratags = -tag_add=target_GaudiExamplesLib

else

cmt_local_tagfile_GaudiExamplesLib = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesLib = $(bin)setup.make
cmt_local_GaudiExamplesLib_makefile = $(bin)GaudiExamplesLib.make

endif

not_GaudiExamplesLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesLibdirs :
	@if test ! -d $(bin)GaudiExamplesLib; then $(mkdir) -p $(bin)GaudiExamplesLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesLib
else
GaudiExamplesLibdirs : ;
endif

ifdef cmt_GaudiExamplesLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesLib_makefile) : $(GaudiExamplesLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesLib_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLib
else
$(cmt_local_GaudiExamplesLib_makefile) : $(GaudiExamplesLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesLib) ] || \
	  $(not_GaudiExamplesLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesLib_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesLib_makefile) : $(GaudiExamplesLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesLib.in -tag=$(tags) $(GaudiExamplesLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLib
else
$(cmt_local_GaudiExamplesLib_makefile) : $(GaudiExamplesLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesLib) ] || \
	  $(not_GaudiExamplesLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesLib.in -tag=$(tags) $(GaudiExamplesLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLib

GaudiExamplesLib :: GaudiExamplesLibcompile GaudiExamplesLibinstall ;

ifdef cmt_GaudiExamplesLib_has_prototypes

GaudiExamplesLibprototype : $(GaudiExamplesLibprototype_dependencies) $(cmt_local_GaudiExamplesLib_makefile) dirs GaudiExamplesLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiExamplesLibcompile : GaudiExamplesLibprototype

endif

GaudiExamplesLibcompile : $(GaudiExamplesLibcompile_dependencies) $(cmt_local_GaudiExamplesLib_makefile) dirs GaudiExamplesLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiExamplesLibclean ;

GaudiExamplesLibclean :: $(GaudiExamplesLibclean_dependencies) ##$(cmt_local_GaudiExamplesLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) GaudiExamplesLibclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesLib_makefile) $(bin)GaudiExamplesLib_dependencies.make

install :: GaudiExamplesLibinstall ;

GaudiExamplesLibinstall :: GaudiExamplesLibcompile $(GaudiExamplesLib_dependencies) $(cmt_local_GaudiExamplesLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesLibuninstall

$(foreach d,$(GaudiExamplesLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesLibuninstall))

GaudiExamplesLibuninstall : $(GaudiExamplesLibuninstall_dependencies) ##$(cmt_local_GaudiExamplesLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiExamples_has_no_target_tag = 1
cmt_GaudiExamples_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamples_has_target_tag

cmt_local_tagfile_GaudiExamples = $(bin)$(GaudiExamples_tag)_GaudiExamples.make
cmt_final_setup_GaudiExamples = $(bin)setup_GaudiExamples.make
cmt_local_GaudiExamples_makefile = $(bin)GaudiExamples.make

GaudiExamples_extratags = -tag_add=target_GaudiExamples

else

cmt_local_tagfile_GaudiExamples = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamples = $(bin)setup.make
cmt_local_GaudiExamples_makefile = $(bin)GaudiExamples.make

endif

not_GaudiExamplescompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplescompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesdirs :
	@if test ! -d $(bin)GaudiExamples; then $(mkdir) -p $(bin)GaudiExamples; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamples
else
GaudiExamplesdirs : ;
endif

ifdef cmt_GaudiExamples_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamples_makefile) : $(GaudiExamplescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_makefile) GaudiExamples
else
$(cmt_local_GaudiExamples_makefile) : $(GaudiExamplescompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples) ] || \
	  $(not_GaudiExamplescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_makefile) GaudiExamples; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamples_makefile) : $(GaudiExamplescompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples.in -tag=$(tags) $(GaudiExamples_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_makefile) GaudiExamples
else
$(cmt_local_GaudiExamples_makefile) : $(GaudiExamplescompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamples.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples) ] || \
	  $(not_GaudiExamplescompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples.in -tag=$(tags) $(GaudiExamples_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_makefile) GaudiExamples; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamples_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamples_makefile) GaudiExamples

GaudiExamples :: GaudiExamplescompile GaudiExamplesinstall ;

ifdef cmt_GaudiExamples_has_prototypes

GaudiExamplesprototype : $(GaudiExamplesprototype_dependencies) $(cmt_local_GaudiExamples_makefile) dirs GaudiExamplesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamples_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiExamplescompile : GaudiExamplesprototype

endif

GaudiExamplescompile : $(GaudiExamplescompile_dependencies) $(cmt_local_GaudiExamples_makefile) dirs GaudiExamplesdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamples_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiExamplesclean ;

GaudiExamplesclean :: $(GaudiExamplesclean_dependencies) ##$(cmt_local_GaudiExamples_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamples_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamples_makefile) GaudiExamplesclean

##	  /bin/rm -f $(cmt_local_GaudiExamples_makefile) $(bin)GaudiExamples_dependencies.make

install :: GaudiExamplesinstall ;

GaudiExamplesinstall :: GaudiExamplescompile $(GaudiExamples_dependencies) $(cmt_local_GaudiExamples_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamples_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesuninstall

$(foreach d,$(GaudiExamples_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesuninstall))

GaudiExamplesuninstall : $(GaudiExamplesuninstall_dependencies) ##$(cmt_local_GaudiExamples_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamples_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamples"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamples done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiExamplesGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesGen_has_target_tag

cmt_local_tagfile_GaudiExamplesGen = $(bin)$(GaudiExamples_tag)_GaudiExamplesGen.make
cmt_final_setup_GaudiExamplesGen = $(bin)setup_GaudiExamplesGen.make
cmt_local_GaudiExamplesGen_makefile = $(bin)GaudiExamplesGen.make

GaudiExamplesGen_extratags = -tag_add=target_GaudiExamplesGen

else

cmt_local_tagfile_GaudiExamplesGen = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesGen = $(bin)setup.make
cmt_local_GaudiExamplesGen_makefile = $(bin)GaudiExamplesGen.make

endif

not_GaudiExamplesGen_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesGendirs :
	@if test ! -d $(bin)GaudiExamplesGen; then $(mkdir) -p $(bin)GaudiExamplesGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesGen
else
GaudiExamplesGendirs : ;
endif

ifdef cmt_GaudiExamplesGen_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesGen_makefile) : $(GaudiExamplesGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGen_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen
else
$(cmt_local_GaudiExamplesGen_makefile) : $(GaudiExamplesGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesGen) ] || \
	  $(not_GaudiExamplesGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGen_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesGen_makefile) : $(GaudiExamplesGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesGen.in -tag=$(tags) $(GaudiExamplesGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen
else
$(cmt_local_GaudiExamplesGen_makefile) : $(GaudiExamplesGen_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesGen) ] || \
	  $(not_GaudiExamplesGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesGen.in -tag=$(tags) $(GaudiExamplesGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGen_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen

GaudiExamplesGen :: $(GaudiExamplesGen_dependencies) $(cmt_local_GaudiExamplesGen_makefile) dirs GaudiExamplesGendirs
	$(echo) "(constituents.make) Starting GaudiExamplesGen"
	@if test -f $(cmt_local_GaudiExamplesGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGen
	$(echo) "(constituents.make) GaudiExamplesGen done"

clean :: GaudiExamplesGenclean ;

GaudiExamplesGenclean :: $(GaudiExamplesGenclean_dependencies) ##$(cmt_local_GaudiExamplesGen_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesGenclean"
	@-if test -f $(cmt_local_GaudiExamplesGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGenclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesGenclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) GaudiExamplesGenclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesGen_makefile) $(bin)GaudiExamplesGen_dependencies.make

install :: GaudiExamplesGeninstall ;

GaudiExamplesGeninstall :: $(GaudiExamplesGen_dependencies) $(cmt_local_GaudiExamplesGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesGenuninstall

$(foreach d,$(GaudiExamplesGen_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesGenuninstall))

GaudiExamplesGenuninstall : $(GaudiExamplesGenuninstall_dependencies) ##$(cmt_local_GaudiExamplesGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GaudiExamplesDict_has_no_target_tag = 1
cmt_GaudiExamplesDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiExamplesDict_has_target_tag

cmt_local_tagfile_GaudiExamplesDict = $(bin)$(GaudiExamples_tag)_GaudiExamplesDict.make
cmt_final_setup_GaudiExamplesDict = $(bin)setup_GaudiExamplesDict.make
cmt_local_GaudiExamplesDict_makefile = $(bin)GaudiExamplesDict.make

GaudiExamplesDict_extratags = -tag_add=target_GaudiExamplesDict

else

cmt_local_tagfile_GaudiExamplesDict = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesDict = $(bin)setup.make
cmt_local_GaudiExamplesDict_makefile = $(bin)GaudiExamplesDict.make

endif

not_GaudiExamplesDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesDictdirs :
	@if test ! -d $(bin)GaudiExamplesDict; then $(mkdir) -p $(bin)GaudiExamplesDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesDict
else
GaudiExamplesDictdirs : ;
endif

ifdef cmt_GaudiExamplesDict_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesDict_makefile) : $(GaudiExamplesDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesDict_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDict
else
$(cmt_local_GaudiExamplesDict_makefile) : $(GaudiExamplesDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesDict) ] || \
	  $(not_GaudiExamplesDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesDict_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesDict_makefile) : $(GaudiExamplesDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesDict.in -tag=$(tags) $(GaudiExamplesDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDict
else
$(cmt_local_GaudiExamplesDict_makefile) : $(GaudiExamplesDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesDict) ] || \
	  $(not_GaudiExamplesDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesDict.in -tag=$(tags) $(GaudiExamplesDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesDict_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDict

GaudiExamplesDict :: GaudiExamplesDictcompile GaudiExamplesDictinstall ;

ifdef cmt_GaudiExamplesDict_has_prototypes

GaudiExamplesDictprototype : $(GaudiExamplesDictprototype_dependencies) $(cmt_local_GaudiExamplesDict_makefile) dirs GaudiExamplesDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiExamplesDictcompile : GaudiExamplesDictprototype

endif

GaudiExamplesDictcompile : $(GaudiExamplesDictcompile_dependencies) $(cmt_local_GaudiExamplesDict_makefile) dirs GaudiExamplesDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiExamplesDictclean ;

GaudiExamplesDictclean :: $(GaudiExamplesDictclean_dependencies) ##$(cmt_local_GaudiExamplesDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) GaudiExamplesDictclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesDict_makefile) $(bin)GaudiExamplesDict_dependencies.make

install :: GaudiExamplesDictinstall ;

GaudiExamplesDictinstall :: GaudiExamplesDictcompile $(GaudiExamplesDict_dependencies) $(cmt_local_GaudiExamplesDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesDictuninstall

$(foreach d,$(GaudiExamplesDict_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesDictuninstall))

GaudiExamplesDictuninstall : $(GaudiExamplesDictuninstall_dependencies) ##$(cmt_local_GaudiExamplesDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiExamples_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamples_python_has_target_tag

cmt_local_tagfile_GaudiExamples_python = $(bin)$(GaudiExamples_tag)_GaudiExamples_python.make
cmt_final_setup_GaudiExamples_python = $(bin)setup_GaudiExamples_python.make
cmt_local_GaudiExamples_python_makefile = $(bin)GaudiExamples_python.make

GaudiExamples_python_extratags = -tag_add=target_GaudiExamples_python

else

cmt_local_tagfile_GaudiExamples_python = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamples_python = $(bin)setup.make
cmt_local_GaudiExamples_python_makefile = $(bin)GaudiExamples_python.make

endif

not_GaudiExamples_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamples_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamples_pythondirs :
	@if test ! -d $(bin)GaudiExamples_python; then $(mkdir) -p $(bin)GaudiExamples_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamples_python
else
GaudiExamples_pythondirs : ;
endif

ifdef cmt_GaudiExamples_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamples_python_makefile) : $(GaudiExamples_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python
else
$(cmt_local_GaudiExamples_python_makefile) : $(GaudiExamples_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples_python) ] || \
	  $(not_GaudiExamples_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamples_python_makefile) : $(GaudiExamples_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples_python.in -tag=$(tags) $(GaudiExamples_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python
else
$(cmt_local_GaudiExamples_python_makefile) : $(GaudiExamples_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamples_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples_python) ] || \
	  $(not_GaudiExamples_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples_python.in -tag=$(tags) $(GaudiExamples_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python

GaudiExamples_python :: $(GaudiExamples_python_dependencies) $(cmt_local_GaudiExamples_python_makefile) dirs GaudiExamples_pythondirs
	$(echo) "(constituents.make) Starting GaudiExamples_python"
	@if test -f $(cmt_local_GaudiExamples_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) GaudiExamples_python
	$(echo) "(constituents.make) GaudiExamples_python done"

clean :: GaudiExamples_pythonclean ;

GaudiExamples_pythonclean :: $(GaudiExamples_pythonclean_dependencies) ##$(cmt_local_GaudiExamples_python_makefile)
	$(echo) "(constituents.make) Starting GaudiExamples_pythonclean"
	@-if test -f $(cmt_local_GaudiExamples_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) GaudiExamples_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiExamples_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) GaudiExamples_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiExamples_python_makefile) $(bin)GaudiExamples_python_dependencies.make

install :: GaudiExamples_pythoninstall ;

GaudiExamples_pythoninstall :: $(GaudiExamples_python_dependencies) $(cmt_local_GaudiExamples_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamples_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamples_pythonuninstall

$(foreach d,$(GaudiExamples_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamples_pythonuninstall))

GaudiExamples_pythonuninstall : $(GaudiExamples_pythonuninstall_dependencies) ##$(cmt_local_GaudiExamples_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamples_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamples_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamples_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamples_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamplesGenConfUser_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesGenConfUser_has_target_tag

cmt_local_tagfile_GaudiExamplesGenConfUser = $(bin)$(GaudiExamples_tag)_GaudiExamplesGenConfUser.make
cmt_final_setup_GaudiExamplesGenConfUser = $(bin)setup_GaudiExamplesGenConfUser.make
cmt_local_GaudiExamplesGenConfUser_makefile = $(bin)GaudiExamplesGenConfUser.make

GaudiExamplesGenConfUser_extratags = -tag_add=target_GaudiExamplesGenConfUser

else

cmt_local_tagfile_GaudiExamplesGenConfUser = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesGenConfUser = $(bin)setup.make
cmt_local_GaudiExamplesGenConfUser_makefile = $(bin)GaudiExamplesGenConfUser.make

endif

not_GaudiExamplesGenConfUser_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesGenConfUser_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesGenConfUserdirs :
	@if test ! -d $(bin)GaudiExamplesGenConfUser; then $(mkdir) -p $(bin)GaudiExamplesGenConfUser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesGenConfUser
else
GaudiExamplesGenConfUserdirs : ;
endif

ifdef cmt_GaudiExamplesGenConfUser_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesGenConfUser_makefile) : $(GaudiExamplesGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser
else
$(cmt_local_GaudiExamplesGenConfUser_makefile) : $(GaudiExamplesGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesGenConfUser) ] || \
	  $(not_GaudiExamplesGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesGenConfUser_makefile) : $(GaudiExamplesGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesGenConfUser.in -tag=$(tags) $(GaudiExamplesGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser
else
$(cmt_local_GaudiExamplesGenConfUser_makefile) : $(GaudiExamplesGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesGenConfUser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesGenConfUser) ] || \
	  $(not_GaudiExamplesGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesGenConfUser.in -tag=$(tags) $(GaudiExamplesGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesGenConfUser_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser

GaudiExamplesGenConfUser :: $(GaudiExamplesGenConfUser_dependencies) $(cmt_local_GaudiExamplesGenConfUser_makefile) dirs GaudiExamplesGenConfUserdirs
	$(echo) "(constituents.make) Starting GaudiExamplesGenConfUser"
	@if test -f $(cmt_local_GaudiExamplesGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUser
	$(echo) "(constituents.make) GaudiExamplesGenConfUser done"

clean :: GaudiExamplesGenConfUserclean ;

GaudiExamplesGenConfUserclean :: $(GaudiExamplesGenConfUserclean_dependencies) ##$(cmt_local_GaudiExamplesGenConfUser_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesGenConfUserclean"
	@-if test -f $(cmt_local_GaudiExamplesGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUserclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesGenConfUserclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) GaudiExamplesGenConfUserclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesGenConfUser_makefile) $(bin)GaudiExamplesGenConfUser_dependencies.make

install :: GaudiExamplesGenConfUserinstall ;

GaudiExamplesGenConfUserinstall :: $(GaudiExamplesGenConfUser_dependencies) $(cmt_local_GaudiExamplesGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesGenConfUseruninstall

$(foreach d,$(GaudiExamplesGenConfUser_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesGenConfUseruninstall))

GaudiExamplesGenConfUseruninstall : $(GaudiExamplesGenConfUseruninstall_dependencies) ##$(cmt_local_GaudiExamplesGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesGenConfUser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesGenConfUseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesGenConfUser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesGenConfUser done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamplesConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesConfUserDbMerge_has_target_tag

cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(bin)$(GaudiExamples_tag)_GaudiExamplesConfUserDbMerge.make
cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)setup_GaudiExamplesConfUserDbMerge.make
cmt_local_GaudiExamplesConfUserDbMerge_makefile = $(bin)GaudiExamplesConfUserDbMerge.make

GaudiExamplesConfUserDbMerge_extratags = -tag_add=target_GaudiExamplesConfUserDbMerge

else

cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)setup.make
cmt_local_GaudiExamplesConfUserDbMerge_makefile = $(bin)GaudiExamplesConfUserDbMerge.make

endif

not_GaudiExamplesConfUserDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesConfUserDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesConfUserDbMergedirs :
	@if test ! -d $(bin)GaudiExamplesConfUserDbMerge; then $(mkdir) -p $(bin)GaudiExamplesConfUserDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesConfUserDbMerge
else
GaudiExamplesConfUserDbMergedirs : ;
endif

ifdef cmt_GaudiExamplesConfUserDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) : $(GaudiExamplesConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge
else
$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) : $(GaudiExamplesConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConfUserDbMerge) ] || \
	  $(not_GaudiExamplesConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) : $(GaudiExamplesConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConfUserDbMerge.in -tag=$(tags) $(GaudiExamplesConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge
else
$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) : $(GaudiExamplesConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesConfUserDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConfUserDbMerge) ] || \
	  $(not_GaudiExamplesConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConfUserDbMerge.in -tag=$(tags) $(GaudiExamplesConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfUserDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge

GaudiExamplesConfUserDbMerge :: $(GaudiExamplesConfUserDbMerge_dependencies) $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) dirs GaudiExamplesConfUserDbMergedirs
	$(echo) "(constituents.make) Starting GaudiExamplesConfUserDbMerge"
	@if test -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMerge
	$(echo) "(constituents.make) GaudiExamplesConfUserDbMerge done"

clean :: GaudiExamplesConfUserDbMergeclean ;

GaudiExamplesConfUserDbMergeclean :: $(GaudiExamplesConfUserDbMergeclean_dependencies) ##$(cmt_local_GaudiExamplesConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesConfUserDbMergeclean"
	@-if test -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesConfUserDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) GaudiExamplesConfUserDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) $(bin)GaudiExamplesConfUserDbMerge_dependencies.make

install :: GaudiExamplesConfUserDbMergeinstall ;

GaudiExamplesConfUserDbMergeinstall :: $(GaudiExamplesConfUserDbMerge_dependencies) $(cmt_local_GaudiExamplesConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesConfUserDbMergeuninstall

$(foreach d,$(GaudiExamplesConfUserDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesConfUserDbMergeuninstall))

GaudiExamplesConfUserDbMergeuninstall : $(GaudiExamplesConfUserDbMergeuninstall_dependencies) ##$(cmt_local_GaudiExamplesConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConfUserDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesConfUserDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesConfUserDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesConfUserDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamples_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamples_python_init_has_target_tag

cmt_local_tagfile_GaudiExamples_python_init = $(bin)$(GaudiExamples_tag)_GaudiExamples_python_init.make
cmt_final_setup_GaudiExamples_python_init = $(bin)setup_GaudiExamples_python_init.make
cmt_local_GaudiExamples_python_init_makefile = $(bin)GaudiExamples_python_init.make

GaudiExamples_python_init_extratags = -tag_add=target_GaudiExamples_python_init

else

cmt_local_tagfile_GaudiExamples_python_init = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamples_python_init = $(bin)setup.make
cmt_local_GaudiExamples_python_init_makefile = $(bin)GaudiExamples_python_init.make

endif

not_GaudiExamples_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamples_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamples_python_initdirs :
	@if test ! -d $(bin)GaudiExamples_python_init; then $(mkdir) -p $(bin)GaudiExamples_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamples_python_init
else
GaudiExamples_python_initdirs : ;
endif

ifdef cmt_GaudiExamples_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamples_python_init_makefile) : $(GaudiExamples_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init
else
$(cmt_local_GaudiExamples_python_init_makefile) : $(GaudiExamples_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples_python_init) ] || \
	  $(not_GaudiExamples_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamples_python_init_makefile) : $(GaudiExamples_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamples_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples_python_init.in -tag=$(tags) $(GaudiExamples_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init
else
$(cmt_local_GaudiExamples_python_init_makefile) : $(GaudiExamples_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamples_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamples_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamples_python_init) ] || \
	  $(not_GaudiExamples_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamples_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamples_python_init.in -tag=$(tags) $(GaudiExamples_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamples_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init

GaudiExamples_python_init :: $(GaudiExamples_python_init_dependencies) $(cmt_local_GaudiExamples_python_init_makefile) dirs GaudiExamples_python_initdirs
	$(echo) "(constituents.make) Starting GaudiExamples_python_init"
	@if test -f $(cmt_local_GaudiExamples_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_init
	$(echo) "(constituents.make) GaudiExamples_python_init done"

clean :: GaudiExamples_python_initclean ;

GaudiExamples_python_initclean :: $(GaudiExamples_python_initclean_dependencies) ##$(cmt_local_GaudiExamples_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiExamples_python_initclean"
	@-if test -f $(cmt_local_GaudiExamples_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiExamples_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) GaudiExamples_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiExamples_python_init_makefile) $(bin)GaudiExamples_python_init_dependencies.make

install :: GaudiExamples_python_initinstall ;

GaudiExamples_python_initinstall :: $(GaudiExamples_python_init_dependencies) $(cmt_local_GaudiExamples_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamples_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamples_python_inituninstall

$(foreach d,$(GaudiExamples_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamples_python_inituninstall))

GaudiExamples_python_inituninstall : $(GaudiExamples_python_inituninstall_dependencies) ##$(cmt_local_GaudiExamples_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamples_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamples_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamples_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamples_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamples_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiExamples_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiExamples_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiExamples_python_modules = $(bin)$(GaudiExamples_tag)_zip_GaudiExamples_python_modules.make
cmt_final_setup_zip_GaudiExamples_python_modules = $(bin)setup_zip_GaudiExamples_python_modules.make
cmt_local_zip_GaudiExamples_python_modules_makefile = $(bin)zip_GaudiExamples_python_modules.make

zip_GaudiExamples_python_modules_extratags = -tag_add=target_zip_GaudiExamples_python_modules

else

cmt_local_tagfile_zip_GaudiExamples_python_modules = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_zip_GaudiExamples_python_modules = $(bin)setup.make
cmt_local_zip_GaudiExamples_python_modules_makefile = $(bin)zip_GaudiExamples_python_modules.make

endif

not_zip_GaudiExamples_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiExamples_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiExamples_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiExamples_python_modules; then $(mkdir) -p $(bin)zip_GaudiExamples_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiExamples_python_modules
else
zip_GaudiExamples_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiExamples_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiExamples_python_modules_makefile) : $(zip_GaudiExamples_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiExamples_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiExamples_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules
else
$(cmt_local_zip_GaudiExamples_python_modules_makefile) : $(zip_GaudiExamples_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiExamples_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiExamples_python_modules) ] || \
	  $(not_zip_GaudiExamples_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiExamples_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiExamples_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiExamples_python_modules_makefile) : $(zip_GaudiExamples_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiExamples_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiExamples_python_modules.in -tag=$(tags) $(zip_GaudiExamples_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules
else
$(cmt_local_zip_GaudiExamples_python_modules_makefile) : $(zip_GaudiExamples_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiExamples_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiExamples_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiExamples_python_modules) ] || \
	  $(not_zip_GaudiExamples_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiExamples_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiExamples_python_modules.in -tag=$(tags) $(zip_GaudiExamples_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiExamples_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules

zip_GaudiExamples_python_modules :: $(zip_GaudiExamples_python_modules_dependencies) $(cmt_local_zip_GaudiExamples_python_modules_makefile) dirs zip_GaudiExamples_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiExamples_python_modules"
	@if test -f $(cmt_local_zip_GaudiExamples_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modules
	$(echo) "(constituents.make) zip_GaudiExamples_python_modules done"

clean :: zip_GaudiExamples_python_modulesclean ;

zip_GaudiExamples_python_modulesclean :: $(zip_GaudiExamples_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiExamples_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiExamples_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiExamples_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiExamples_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) zip_GaudiExamples_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) $(bin)zip_GaudiExamples_python_modules_dependencies.make

install :: zip_GaudiExamples_python_modulesinstall ;

zip_GaudiExamples_python_modulesinstall :: $(zip_GaudiExamples_python_modules_dependencies) $(cmt_local_zip_GaudiExamples_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiExamples_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiExamples_python_modulesuninstall

$(foreach d,$(zip_GaudiExamples_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiExamples_python_modulesuninstall))

zip_GaudiExamples_python_modulesuninstall : $(zip_GaudiExamples_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiExamples_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiExamples_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiExamples_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiExamples_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiExamples_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiExamples_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_Allocator_has_no_target_tag = 1
cmt_Allocator_has_prototypes = 1

#--------------------------------------

ifdef cmt_Allocator_has_target_tag

cmt_local_tagfile_Allocator = $(bin)$(GaudiExamples_tag)_Allocator.make
cmt_final_setup_Allocator = $(bin)setup_Allocator.make
cmt_local_Allocator_makefile = $(bin)Allocator.make

Allocator_extratags = -tag_add=target_Allocator

else

cmt_local_tagfile_Allocator = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_Allocator = $(bin)setup.make
cmt_local_Allocator_makefile = $(bin)Allocator.make

endif

not_Allocatorcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Allocatorcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Allocatordirs :
	@if test ! -d $(bin)Allocator; then $(mkdir) -p $(bin)Allocator; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Allocator
else
Allocatordirs : ;
endif

ifdef cmt_Allocator_has_target_tag

ifndef QUICK
$(cmt_local_Allocator_makefile) : $(Allocatorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Allocator.make"; \
	  $(cmtexe) -tag=$(tags) $(Allocator_extratags) build constituent_config -out=$(cmt_local_Allocator_makefile) Allocator
else
$(cmt_local_Allocator_makefile) : $(Allocatorcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Allocator) ] || \
	  [ ! -f $(cmt_final_setup_Allocator) ] || \
	  $(not_Allocatorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Allocator.make"; \
	  $(cmtexe) -tag=$(tags) $(Allocator_extratags) build constituent_config -out=$(cmt_local_Allocator_makefile) Allocator; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Allocator_makefile) : $(Allocatorcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Allocator.make"; \
	  $(cmtexe) -f=$(bin)Allocator.in -tag=$(tags) $(Allocator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Allocator_makefile) Allocator
else
$(cmt_local_Allocator_makefile) : $(Allocatorcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Allocator.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Allocator) ] || \
	  [ ! -f $(cmt_final_setup_Allocator) ] || \
	  $(not_Allocatorcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Allocator.make"; \
	  $(cmtexe) -f=$(bin)Allocator.in -tag=$(tags) $(Allocator_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Allocator_makefile) Allocator; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Allocator_extratags) build constituent_makefile -out=$(cmt_local_Allocator_makefile) Allocator

Allocator :: Allocatorcompile Allocatorinstall ;

ifdef cmt_Allocator_has_prototypes

Allocatorprototype : $(Allocatorprototype_dependencies) $(cmt_local_Allocator_makefile) dirs Allocatordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Allocator_makefile); then \
	  $(MAKE) -f $(cmt_local_Allocator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Allocator_makefile) $@
	$(echo) "(constituents.make) $@ done"

Allocatorcompile : Allocatorprototype

endif

Allocatorcompile : $(Allocatorcompile_dependencies) $(cmt_local_Allocator_makefile) dirs Allocatordirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Allocator_makefile); then \
	  $(MAKE) -f $(cmt_local_Allocator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Allocator_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Allocatorclean ;

Allocatorclean :: $(Allocatorclean_dependencies) ##$(cmt_local_Allocator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Allocator_makefile); then \
	  $(MAKE) -f $(cmt_local_Allocator_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Allocator_makefile) Allocatorclean

##	  /bin/rm -f $(cmt_local_Allocator_makefile) $(bin)Allocator_dependencies.make

install :: Allocatorinstall ;

Allocatorinstall :: Allocatorcompile $(Allocator_dependencies) $(cmt_local_Allocator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Allocator_makefile); then \
	  $(MAKE) -f $(cmt_local_Allocator_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Allocator_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Allocatoruninstall

$(foreach d,$(Allocator_dependencies),$(eval $(d)uninstall_dependencies += Allocatoruninstall))

Allocatoruninstall : $(Allocatoruninstall_dependencies) ##$(cmt_local_Allocator_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Allocator_makefile); then \
	  $(MAKE) -f $(cmt_local_Allocator_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Allocator_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Allocatoruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Allocator"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Allocator done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiExamplesComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesComponentsList_has_target_tag

cmt_local_tagfile_GaudiExamplesComponentsList = $(bin)$(GaudiExamples_tag)_GaudiExamplesComponentsList.make
cmt_final_setup_GaudiExamplesComponentsList = $(bin)setup_GaudiExamplesComponentsList.make
cmt_local_GaudiExamplesComponentsList_makefile = $(bin)GaudiExamplesComponentsList.make

GaudiExamplesComponentsList_extratags = -tag_add=target_GaudiExamplesComponentsList

else

cmt_local_tagfile_GaudiExamplesComponentsList = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesComponentsList = $(bin)setup.make
cmt_local_GaudiExamplesComponentsList_makefile = $(bin)GaudiExamplesComponentsList.make

endif

not_GaudiExamplesComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesComponentsListdirs :
	@if test ! -d $(bin)GaudiExamplesComponentsList; then $(mkdir) -p $(bin)GaudiExamplesComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesComponentsList
else
GaudiExamplesComponentsListdirs : ;
endif

ifdef cmt_GaudiExamplesComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesComponentsList_makefile) : $(GaudiExamplesComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList
else
$(cmt_local_GaudiExamplesComponentsList_makefile) : $(GaudiExamplesComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesComponentsList) ] || \
	  $(not_GaudiExamplesComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesComponentsList_makefile) : $(GaudiExamplesComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesComponentsList.in -tag=$(tags) $(GaudiExamplesComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList
else
$(cmt_local_GaudiExamplesComponentsList_makefile) : $(GaudiExamplesComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesComponentsList) ] || \
	  $(not_GaudiExamplesComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesComponentsList.in -tag=$(tags) $(GaudiExamplesComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList

GaudiExamplesComponentsList :: $(GaudiExamplesComponentsList_dependencies) $(cmt_local_GaudiExamplesComponentsList_makefile) dirs GaudiExamplesComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiExamplesComponentsList"
	@if test -f $(cmt_local_GaudiExamplesComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsList
	$(echo) "(constituents.make) GaudiExamplesComponentsList done"

clean :: GaudiExamplesComponentsListclean ;

GaudiExamplesComponentsListclean :: $(GaudiExamplesComponentsListclean_dependencies) ##$(cmt_local_GaudiExamplesComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesComponentsListclean"
	@-if test -f $(cmt_local_GaudiExamplesComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) GaudiExamplesComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesComponentsList_makefile) $(bin)GaudiExamplesComponentsList_dependencies.make

install :: GaudiExamplesComponentsListinstall ;

GaudiExamplesComponentsListinstall :: $(GaudiExamplesComponentsList_dependencies) $(cmt_local_GaudiExamplesComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesComponentsListuninstall

$(foreach d,$(GaudiExamplesComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesComponentsListuninstall))

GaudiExamplesComponentsListuninstall : $(GaudiExamplesComponentsListuninstall_dependencies) ##$(cmt_local_GaudiExamplesComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamplesMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(bin)$(GaudiExamples_tag)_GaudiExamplesMergeComponentsList.make
cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)setup_GaudiExamplesMergeComponentsList.make
cmt_local_GaudiExamplesMergeComponentsList_makefile = $(bin)GaudiExamplesMergeComponentsList.make

GaudiExamplesMergeComponentsList_extratags = -tag_add=target_GaudiExamplesMergeComponentsList

else

cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)setup.make
cmt_local_GaudiExamplesMergeComponentsList_makefile = $(bin)GaudiExamplesMergeComponentsList.make

endif

not_GaudiExamplesMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiExamplesMergeComponentsList; then $(mkdir) -p $(bin)GaudiExamplesMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesMergeComponentsList
else
GaudiExamplesMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiExamplesMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesMergeComponentsList_makefile) : $(GaudiExamplesMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList
else
$(cmt_local_GaudiExamplesMergeComponentsList_makefile) : $(GaudiExamplesMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesMergeComponentsList) ] || \
	  $(not_GaudiExamplesMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesMergeComponentsList_makefile) : $(GaudiExamplesMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesMergeComponentsList.in -tag=$(tags) $(GaudiExamplesMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList
else
$(cmt_local_GaudiExamplesMergeComponentsList_makefile) : $(GaudiExamplesMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesMergeComponentsList) ] || \
	  $(not_GaudiExamplesMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesMergeComponentsList.in -tag=$(tags) $(GaudiExamplesMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList

GaudiExamplesMergeComponentsList :: $(GaudiExamplesMergeComponentsList_dependencies) $(cmt_local_GaudiExamplesMergeComponentsList_makefile) dirs GaudiExamplesMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiExamplesMergeComponentsList"
	@if test -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsList
	$(echo) "(constituents.make) GaudiExamplesMergeComponentsList done"

clean :: GaudiExamplesMergeComponentsListclean ;

GaudiExamplesMergeComponentsListclean :: $(GaudiExamplesMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiExamplesMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) GaudiExamplesMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) $(bin)GaudiExamplesMergeComponentsList_dependencies.make

install :: GaudiExamplesMergeComponentsListinstall ;

GaudiExamplesMergeComponentsListinstall :: $(GaudiExamplesMergeComponentsList_dependencies) $(cmt_local_GaudiExamplesMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesMergeComponentsListuninstall

$(foreach d,$(GaudiExamplesMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesMergeComponentsListuninstall))

GaudiExamplesMergeComponentsListuninstall : $(GaudiExamplesMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiExamplesMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamplesConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesConf_has_target_tag

cmt_local_tagfile_GaudiExamplesConf = $(bin)$(GaudiExamples_tag)_GaudiExamplesConf.make
cmt_final_setup_GaudiExamplesConf = $(bin)setup_GaudiExamplesConf.make
cmt_local_GaudiExamplesConf_makefile = $(bin)GaudiExamplesConf.make

GaudiExamplesConf_extratags = -tag_add=target_GaudiExamplesConf

else

cmt_local_tagfile_GaudiExamplesConf = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesConf = $(bin)setup.make
cmt_local_GaudiExamplesConf_makefile = $(bin)GaudiExamplesConf.make

endif

not_GaudiExamplesConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesConfdirs :
	@if test ! -d $(bin)GaudiExamplesConf; then $(mkdir) -p $(bin)GaudiExamplesConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesConf
else
GaudiExamplesConfdirs : ;
endif

ifdef cmt_GaudiExamplesConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesConf_makefile) : $(GaudiExamplesConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConf_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf
else
$(cmt_local_GaudiExamplesConf_makefile) : $(GaudiExamplesConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConf) ] || \
	  $(not_GaudiExamplesConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConf_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesConf_makefile) : $(GaudiExamplesConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConf.in -tag=$(tags) $(GaudiExamplesConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf
else
$(cmt_local_GaudiExamplesConf_makefile) : $(GaudiExamplesConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConf) ] || \
	  $(not_GaudiExamplesConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConf.in -tag=$(tags) $(GaudiExamplesConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf

GaudiExamplesConf :: $(GaudiExamplesConf_dependencies) $(cmt_local_GaudiExamplesConf_makefile) dirs GaudiExamplesConfdirs
	$(echo) "(constituents.make) Starting GaudiExamplesConf"
	@if test -f $(cmt_local_GaudiExamplesConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConf
	$(echo) "(constituents.make) GaudiExamplesConf done"

clean :: GaudiExamplesConfclean ;

GaudiExamplesConfclean :: $(GaudiExamplesConfclean_dependencies) ##$(cmt_local_GaudiExamplesConf_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesConfclean"
	@-if test -f $(cmt_local_GaudiExamplesConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConfclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) GaudiExamplesConfclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesConf_makefile) $(bin)GaudiExamplesConf_dependencies.make

install :: GaudiExamplesConfinstall ;

GaudiExamplesConfinstall :: $(GaudiExamplesConf_dependencies) $(cmt_local_GaudiExamplesConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesConfuninstall

$(foreach d,$(GaudiExamplesConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesConfuninstall))

GaudiExamplesConfuninstall : $(GaudiExamplesConfuninstall_dependencies) ##$(cmt_local_GaudiExamplesConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiExamplesConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiExamplesConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiExamplesConfDbMerge = $(bin)$(GaudiExamples_tag)_GaudiExamplesConfDbMerge.make
cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)setup_GaudiExamplesConfDbMerge.make
cmt_local_GaudiExamplesConfDbMerge_makefile = $(bin)GaudiExamplesConfDbMerge.make

GaudiExamplesConfDbMerge_extratags = -tag_add=target_GaudiExamplesConfDbMerge

else

cmt_local_tagfile_GaudiExamplesConfDbMerge = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)setup.make
cmt_local_GaudiExamplesConfDbMerge_makefile = $(bin)GaudiExamplesConfDbMerge.make

endif

not_GaudiExamplesConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiExamplesConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiExamplesConfDbMergedirs :
	@if test ! -d $(bin)GaudiExamplesConfDbMerge; then $(mkdir) -p $(bin)GaudiExamplesConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiExamplesConfDbMerge
else
GaudiExamplesConfDbMergedirs : ;
endif

ifdef cmt_GaudiExamplesConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiExamplesConfDbMerge_makefile) : $(GaudiExamplesConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge
else
$(cmt_local_GaudiExamplesConfDbMerge_makefile) : $(GaudiExamplesConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConfDbMerge) ] || \
	  $(not_GaudiExamplesConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiExamplesConfDbMerge_makefile) : $(GaudiExamplesConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiExamplesConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConfDbMerge.in -tag=$(tags) $(GaudiExamplesConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge
else
$(cmt_local_GaudiExamplesConfDbMerge_makefile) : $(GaudiExamplesConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiExamplesConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiExamplesConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiExamplesConfDbMerge) ] || \
	  $(not_GaudiExamplesConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiExamplesConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiExamplesConfDbMerge.in -tag=$(tags) $(GaudiExamplesConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiExamplesConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge

GaudiExamplesConfDbMerge :: $(GaudiExamplesConfDbMerge_dependencies) $(cmt_local_GaudiExamplesConfDbMerge_makefile) dirs GaudiExamplesConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiExamplesConfDbMerge"
	@if test -f $(cmt_local_GaudiExamplesConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMerge
	$(echo) "(constituents.make) GaudiExamplesConfDbMerge done"

clean :: GaudiExamplesConfDbMergeclean ;

GaudiExamplesConfDbMergeclean :: $(GaudiExamplesConfDbMergeclean_dependencies) ##$(cmt_local_GaudiExamplesConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiExamplesConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiExamplesConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiExamplesConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) GaudiExamplesConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) $(bin)GaudiExamplesConfDbMerge_dependencies.make

install :: GaudiExamplesConfDbMergeinstall ;

GaudiExamplesConfDbMergeinstall :: $(GaudiExamplesConfDbMerge_dependencies) $(cmt_local_GaudiExamplesConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiExamplesConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiExamplesConfDbMergeuninstall

$(foreach d,$(GaudiExamplesConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiExamplesConfDbMergeuninstall))

GaudiExamplesConfDbMergeuninstall : $(GaudiExamplesConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiExamplesConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiExamplesConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiExamplesConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiExamplesConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiExamplesConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiExamplesConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_PyExample_has_target_tag = 1
cmt_PyExample_has_prototypes = 1

#--------------------------------------

ifdef cmt_PyExample_has_target_tag

cmt_local_tagfile_PyExample = $(bin)$(GaudiExamples_tag)_PyExample.make
cmt_final_setup_PyExample = $(bin)setup_PyExample.make
cmt_local_PyExample_makefile = $(bin)PyExample.make

PyExample_extratags = -tag_add=target_PyExample

else

cmt_local_tagfile_PyExample = $(bin)$(GaudiExamples_tag).make
cmt_final_setup_PyExample = $(bin)setup.make
cmt_local_PyExample_makefile = $(bin)PyExample.make

endif

not_PyExamplecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PyExamplecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PyExampledirs :
	@if test ! -d $(bin)PyExample; then $(mkdir) -p $(bin)PyExample; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PyExample
else
PyExampledirs : ;
endif

ifdef cmt_PyExample_has_target_tag

ifndef QUICK
$(cmt_local_PyExample_makefile) : $(PyExamplecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PyExample.make"; \
	  $(cmtexe) -tag=$(tags) $(PyExample_extratags) build constituent_config -out=$(cmt_local_PyExample_makefile) PyExample
else
$(cmt_local_PyExample_makefile) : $(PyExamplecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PyExample) ] || \
	  [ ! -f $(cmt_final_setup_PyExample) ] || \
	  $(not_PyExamplecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PyExample.make"; \
	  $(cmtexe) -tag=$(tags) $(PyExample_extratags) build constituent_config -out=$(cmt_local_PyExample_makefile) PyExample; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PyExample_makefile) : $(PyExamplecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PyExample.make"; \
	  $(cmtexe) -f=$(bin)PyExample.in -tag=$(tags) $(PyExample_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PyExample_makefile) PyExample
else
$(cmt_local_PyExample_makefile) : $(PyExamplecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PyExample.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PyExample) ] || \
	  [ ! -f $(cmt_final_setup_PyExample) ] || \
	  $(not_PyExamplecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PyExample.make"; \
	  $(cmtexe) -f=$(bin)PyExample.in -tag=$(tags) $(PyExample_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PyExample_makefile) PyExample; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PyExample_extratags) build constituent_makefile -out=$(cmt_local_PyExample_makefile) PyExample

PyExample :: PyExamplecompile PyExampleinstall ;

ifdef cmt_PyExample_has_prototypes

PyExampleprototype : $(PyExampleprototype_dependencies) $(cmt_local_PyExample_makefile) dirs PyExampledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyExample_makefile); then \
	  $(MAKE) -f $(cmt_local_PyExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

PyExamplecompile : PyExampleprototype

endif

PyExamplecompile : $(PyExamplecompile_dependencies) $(cmt_local_PyExample_makefile) dirs PyExampledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyExample_makefile); then \
	  $(MAKE) -f $(cmt_local_PyExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PyExampleclean ;

PyExampleclean :: $(PyExampleclean_dependencies) ##$(cmt_local_PyExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PyExample_makefile); then \
	  $(MAKE) -f $(cmt_local_PyExample_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PyExample_makefile) PyExampleclean

##	  /bin/rm -f $(cmt_local_PyExample_makefile) $(bin)PyExample_dependencies.make

install :: PyExampleinstall ;

PyExampleinstall :: PyExamplecompile $(PyExample_dependencies) $(cmt_local_PyExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyExample_makefile); then \
	  $(MAKE) -f $(cmt_local_PyExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PyExampleuninstall

$(foreach d,$(PyExample_dependencies),$(eval $(d)uninstall_dependencies += PyExampleuninstall))

PyExampleuninstall : $(PyExampleuninstall_dependencies) ##$(cmt_local_PyExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PyExample_makefile); then \
	  $(MAKE) -f $(cmt_local_PyExample_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyExample_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PyExampleuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PyExample"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PyExample done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiExamples_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiExamples_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiExamples_tag).make
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

cmt_CompilePython_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_CompilePython_has_target_tag

cmt_local_tagfile_CompilePython = $(bin)$(GaudiExamples_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiExamples_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiExamples_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiExamples_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiExamples_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiExamples_tag).make
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

cmt_QMTestTestsDatabase_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_QMTestTestsDatabase_has_target_tag

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiExamples_tag)_QMTestTestsDatabase.make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup_QMTestTestsDatabase.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

QMTestTestsDatabase_extratags = -tag_add=target_QMTestTestsDatabase

else

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiExamples_tag).make
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

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiExamples_tag)_QMTestGUI.make
cmt_final_setup_QMTestGUI = $(bin)setup_QMTestGUI.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

QMTestGUI_extratags = -tag_add=target_QMTestGUI

else

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiExamples_tag).make
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
