
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile = $(GaudiKernel_tag).make
cmt_local_tagfile = $(bin)$(GaudiKernel_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make
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

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiKernel_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiKernel_tag).make
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

cmt_GaudiKernel_has_no_target_tag = 1
cmt_GaudiKernel_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiKernel_has_target_tag

cmt_local_tagfile_GaudiKernel = $(bin)$(GaudiKernel_tag)_GaudiKernel.make
cmt_final_setup_GaudiKernel = $(bin)setup_GaudiKernel.make
cmt_local_GaudiKernel_makefile = $(bin)GaudiKernel.make

GaudiKernel_extratags = -tag_add=target_GaudiKernel

else

cmt_local_tagfile_GaudiKernel = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_GaudiKernel = $(bin)setup.make
cmt_local_GaudiKernel_makefile = $(bin)GaudiKernel.make

endif

not_GaudiKernelcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiKernelcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiKerneldirs :
	@if test ! -d $(bin)GaudiKernel; then $(mkdir) -p $(bin)GaudiKernel; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiKernel
else
GaudiKerneldirs : ;
endif

ifdef cmt_GaudiKernel_has_target_tag

ifndef QUICK
$(cmt_local_GaudiKernel_makefile) : $(GaudiKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_makefile) GaudiKernel
else
$(cmt_local_GaudiKernel_makefile) : $(GaudiKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel) ] || \
	  $(not_GaudiKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_makefile) GaudiKernel; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiKernel_makefile) : $(GaudiKernelcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel.in -tag=$(tags) $(GaudiKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_makefile) GaudiKernel
else
$(cmt_local_GaudiKernel_makefile) : $(GaudiKernelcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiKernel.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel) ] || \
	  $(not_GaudiKernelcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel.in -tag=$(tags) $(GaudiKernel_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_makefile) GaudiKernel; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiKernel_extratags) build constituent_makefile -out=$(cmt_local_GaudiKernel_makefile) GaudiKernel

GaudiKernel :: GaudiKernelcompile GaudiKernelinstall ;

ifdef cmt_GaudiKernel_has_prototypes

GaudiKernelprototype : $(GaudiKernelprototype_dependencies) $(cmt_local_GaudiKernel_makefile) dirs GaudiKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiKernelcompile : GaudiKernelprototype

endif

GaudiKernelcompile : $(GaudiKernelcompile_dependencies) $(cmt_local_GaudiKernel_makefile) dirs GaudiKerneldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiKernelclean ;

GaudiKernelclean :: $(GaudiKernelclean_dependencies) ##$(cmt_local_GaudiKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiKernel_makefile) GaudiKernelclean

##	  /bin/rm -f $(cmt_local_GaudiKernel_makefile) $(bin)GaudiKernel_dependencies.make

install :: GaudiKernelinstall ;

GaudiKernelinstall :: GaudiKernelcompile $(GaudiKernel_dependencies) $(cmt_local_GaudiKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiKerneluninstall

$(foreach d,$(GaudiKernel_dependencies),$(eval $(d)uninstall_dependencies += GaudiKerneluninstall))

GaudiKerneluninstall : $(GaudiKerneluninstall_dependencies) ##$(cmt_local_GaudiKernel_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernel_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiKerneluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiKernel"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiKernel done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_scripts_has_target_tag

cmt_local_tagfile_install_scripts = $(bin)$(GaudiKernel_tag)_install_scripts.make
cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

install_scripts_extratags = -tag_add=target_install_scripts

else

cmt_local_tagfile_install_scripts = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_install_scripts = $(bin)setup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

endif

not_install_scripts_dependencies = { n=0; for p in $?; do m=0; for d in $(install_scripts_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
install_scriptsdirs :
	@if test ! -d $(bin)install_scripts; then $(mkdir) -p $(bin)install_scripts; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)install_scripts
else
install_scriptsdirs : ;
endif

ifdef cmt_install_scripts_has_target_tag

ifndef QUICK
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_config -out=$(cmt_local_install_scripts_makefile) install_scripts
else
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_install_scripts) ] || \
	  $(not_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_config -out=$(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) build_library_links
	$(echo) "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -f=$(bin)install_scripts.in -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_scripts_makefile) install_scripts
else
$(cmt_local_install_scripts_makefile) : $(install_scripts_dependencies) $(cmt_build_library_linksstamp) $(bin)install_scripts.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_install_scripts) ] || \
	  [ ! -f $(cmt_final_setup_install_scripts) ] || \
	  $(not_install_scripts_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building install_scripts.make"; \
	  $(cmtexe) -f=$(bin)install_scripts.in -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(install_scripts_extratags) build constituent_makefile -out=$(cmt_local_install_scripts_makefile) install_scripts

install_scripts :: $(install_scripts_dependencies) $(cmt_local_install_scripts_makefile) dirs install_scriptsdirs
	$(echo) "(constituents.make) Starting install_scripts"
	@if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install_scripts; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_scripts_makefile) install_scripts
	$(echo) "(constituents.make) install_scripts done"

clean :: install_scriptsclean ;

install_scriptsclean :: $(install_scriptsclean_dependencies) ##$(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting install_scriptsclean"
	@-if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install_scriptsclean; \
	fi
	$(echo) "(constituents.make) install_scriptsclean done"
#	@-$(MAKE) -f $(cmt_local_install_scripts_makefile) install_scriptsclean

##	  /bin/rm -f $(cmt_local_install_scripts_makefile) $(bin)install_scripts_dependencies.make

install :: install_scriptsinstall ;

install_scriptsinstall :: $(install_scripts_dependencies) $(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_install_scripts_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : install_scriptsuninstall

$(foreach d,$(install_scripts_dependencies),$(eval $(d)uninstall_dependencies += install_scriptsuninstall))

install_scriptsuninstall : $(install_scriptsuninstall_dependencies) ##$(cmt_local_install_scripts_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_install_scripts_makefile); then \
	  $(MAKE) -f $(cmt_local_install_scripts_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_install_scripts_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: install_scriptsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ install_scripts"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ install_scripts done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiKernel_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiKernel_python_has_target_tag

cmt_local_tagfile_GaudiKernel_python = $(bin)$(GaudiKernel_tag)_GaudiKernel_python.make
cmt_final_setup_GaudiKernel_python = $(bin)setup_GaudiKernel_python.make
cmt_local_GaudiKernel_python_makefile = $(bin)GaudiKernel_python.make

GaudiKernel_python_extratags = -tag_add=target_GaudiKernel_python

else

cmt_local_tagfile_GaudiKernel_python = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_GaudiKernel_python = $(bin)setup.make
cmt_local_GaudiKernel_python_makefile = $(bin)GaudiKernel_python.make

endif

not_GaudiKernel_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiKernel_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiKernel_pythondirs :
	@if test ! -d $(bin)GaudiKernel_python; then $(mkdir) -p $(bin)GaudiKernel_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiKernel_python
else
GaudiKernel_pythondirs : ;
endif

ifdef cmt_GaudiKernel_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiKernel_python_makefile) : $(GaudiKernel_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python
else
$(cmt_local_GaudiKernel_python_makefile) : $(GaudiKernel_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel_python) ] || \
	  $(not_GaudiKernel_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiKernel_python_makefile) : $(GaudiKernel_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel_python.in -tag=$(tags) $(GaudiKernel_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python
else
$(cmt_local_GaudiKernel_python_makefile) : $(GaudiKernel_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiKernel_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel_python) ] || \
	  $(not_GaudiKernel_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel_python.in -tag=$(tags) $(GaudiKernel_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python

GaudiKernel_python :: $(GaudiKernel_python_dependencies) $(cmt_local_GaudiKernel_python_makefile) dirs GaudiKernel_pythondirs
	$(echo) "(constituents.make) Starting GaudiKernel_python"
	@if test -f $(cmt_local_GaudiKernel_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) GaudiKernel_python
	$(echo) "(constituents.make) GaudiKernel_python done"

clean :: GaudiKernel_pythonclean ;

GaudiKernel_pythonclean :: $(GaudiKernel_pythonclean_dependencies) ##$(cmt_local_GaudiKernel_python_makefile)
	$(echo) "(constituents.make) Starting GaudiKernel_pythonclean"
	@-if test -f $(cmt_local_GaudiKernel_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) GaudiKernel_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiKernel_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) GaudiKernel_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiKernel_python_makefile) $(bin)GaudiKernel_python_dependencies.make

install :: GaudiKernel_pythoninstall ;

GaudiKernel_pythoninstall :: $(GaudiKernel_python_dependencies) $(cmt_local_GaudiKernel_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernel_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiKernel_pythonuninstall

$(foreach d,$(GaudiKernel_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiKernel_pythonuninstall))

GaudiKernel_pythonuninstall : $(GaudiKernel_pythonuninstall_dependencies) ##$(cmt_local_GaudiKernel_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernel_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiKernel_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiKernel_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiKernel_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiKernel_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiKernel_python_init_has_target_tag

cmt_local_tagfile_GaudiKernel_python_init = $(bin)$(GaudiKernel_tag)_GaudiKernel_python_init.make
cmt_final_setup_GaudiKernel_python_init = $(bin)setup_GaudiKernel_python_init.make
cmt_local_GaudiKernel_python_init_makefile = $(bin)GaudiKernel_python_init.make

GaudiKernel_python_init_extratags = -tag_add=target_GaudiKernel_python_init

else

cmt_local_tagfile_GaudiKernel_python_init = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_GaudiKernel_python_init = $(bin)setup.make
cmt_local_GaudiKernel_python_init_makefile = $(bin)GaudiKernel_python_init.make

endif

not_GaudiKernel_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiKernel_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiKernel_python_initdirs :
	@if test ! -d $(bin)GaudiKernel_python_init; then $(mkdir) -p $(bin)GaudiKernel_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiKernel_python_init
else
GaudiKernel_python_initdirs : ;
endif

ifdef cmt_GaudiKernel_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiKernel_python_init_makefile) : $(GaudiKernel_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init
else
$(cmt_local_GaudiKernel_python_init_makefile) : $(GaudiKernel_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel_python_init) ] || \
	  $(not_GaudiKernel_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiKernel_python_init_makefile) : $(GaudiKernel_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernel_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel_python_init.in -tag=$(tags) $(GaudiKernel_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init
else
$(cmt_local_GaudiKernel_python_init_makefile) : $(GaudiKernel_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiKernel_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernel_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernel_python_init) ] || \
	  $(not_GaudiKernel_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernel_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernel_python_init.in -tag=$(tags) $(GaudiKernel_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiKernel_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init

GaudiKernel_python_init :: $(GaudiKernel_python_init_dependencies) $(cmt_local_GaudiKernel_python_init_makefile) dirs GaudiKernel_python_initdirs
	$(echo) "(constituents.make) Starting GaudiKernel_python_init"
	@if test -f $(cmt_local_GaudiKernel_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_init
	$(echo) "(constituents.make) GaudiKernel_python_init done"

clean :: GaudiKernel_python_initclean ;

GaudiKernel_python_initclean :: $(GaudiKernel_python_initclean_dependencies) ##$(cmt_local_GaudiKernel_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiKernel_python_initclean"
	@-if test -f $(cmt_local_GaudiKernel_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiKernel_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) GaudiKernel_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiKernel_python_init_makefile) $(bin)GaudiKernel_python_init_dependencies.make

install :: GaudiKernel_python_initinstall ;

GaudiKernel_python_initinstall :: $(GaudiKernel_python_init_dependencies) $(cmt_local_GaudiKernel_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernel_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiKernel_python_inituninstall

$(foreach d,$(GaudiKernel_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiKernel_python_inituninstall))

GaudiKernel_python_inituninstall : $(GaudiKernel_python_inituninstall_dependencies) ##$(cmt_local_GaudiKernel_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernel_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernel_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiKernel_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiKernel_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiKernel_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiKernel_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiKernel_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiKernel_python_modules = $(bin)$(GaudiKernel_tag)_zip_GaudiKernel_python_modules.make
cmt_final_setup_zip_GaudiKernel_python_modules = $(bin)setup_zip_GaudiKernel_python_modules.make
cmt_local_zip_GaudiKernel_python_modules_makefile = $(bin)zip_GaudiKernel_python_modules.make

zip_GaudiKernel_python_modules_extratags = -tag_add=target_zip_GaudiKernel_python_modules

else

cmt_local_tagfile_zip_GaudiKernel_python_modules = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_zip_GaudiKernel_python_modules = $(bin)setup.make
cmt_local_zip_GaudiKernel_python_modules_makefile = $(bin)zip_GaudiKernel_python_modules.make

endif

not_zip_GaudiKernel_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiKernel_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiKernel_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiKernel_python_modules; then $(mkdir) -p $(bin)zip_GaudiKernel_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiKernel_python_modules
else
zip_GaudiKernel_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiKernel_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiKernel_python_modules_makefile) : $(zip_GaudiKernel_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiKernel_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiKernel_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules
else
$(cmt_local_zip_GaudiKernel_python_modules_makefile) : $(zip_GaudiKernel_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiKernel_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiKernel_python_modules) ] || \
	  $(not_zip_GaudiKernel_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiKernel_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiKernel_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiKernel_python_modules_makefile) : $(zip_GaudiKernel_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiKernel_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiKernel_python_modules.in -tag=$(tags) $(zip_GaudiKernel_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules
else
$(cmt_local_zip_GaudiKernel_python_modules_makefile) : $(zip_GaudiKernel_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiKernel_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiKernel_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiKernel_python_modules) ] || \
	  $(not_zip_GaudiKernel_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiKernel_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiKernel_python_modules.in -tag=$(tags) $(zip_GaudiKernel_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiKernel_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules

zip_GaudiKernel_python_modules :: $(zip_GaudiKernel_python_modules_dependencies) $(cmt_local_zip_GaudiKernel_python_modules_makefile) dirs zip_GaudiKernel_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiKernel_python_modules"
	@if test -f $(cmt_local_zip_GaudiKernel_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modules
	$(echo) "(constituents.make) zip_GaudiKernel_python_modules done"

clean :: zip_GaudiKernel_python_modulesclean ;

zip_GaudiKernel_python_modulesclean :: $(zip_GaudiKernel_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiKernel_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiKernel_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiKernel_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiKernel_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) zip_GaudiKernel_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) $(bin)zip_GaudiKernel_python_modules_dependencies.make

install :: zip_GaudiKernel_python_modulesinstall ;

zip_GaudiKernel_python_modulesinstall :: $(zip_GaudiKernel_python_modules_dependencies) $(cmt_local_zip_GaudiKernel_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiKernel_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiKernel_python_modulesuninstall

$(foreach d,$(zip_GaudiKernel_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiKernel_python_modulesuninstall))

zip_GaudiKernel_python_modulesuninstall : $(zip_GaudiKernel_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiKernel_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiKernel_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiKernel_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiKernel_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiKernel_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiKernel_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiKernelGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiKernelGen_has_target_tag

cmt_local_tagfile_GaudiKernelGen = $(bin)$(GaudiKernel_tag)_GaudiKernelGen.make
cmt_final_setup_GaudiKernelGen = $(bin)setup_GaudiKernelGen.make
cmt_local_GaudiKernelGen_makefile = $(bin)GaudiKernelGen.make

GaudiKernelGen_extratags = -tag_add=target_GaudiKernelGen

else

cmt_local_tagfile_GaudiKernelGen = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_GaudiKernelGen = $(bin)setup.make
cmt_local_GaudiKernelGen_makefile = $(bin)GaudiKernelGen.make

endif

not_GaudiKernelGen_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiKernelGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiKernelGendirs :
	@if test ! -d $(bin)GaudiKernelGen; then $(mkdir) -p $(bin)GaudiKernelGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiKernelGen
else
GaudiKernelGendirs : ;
endif

ifdef cmt_GaudiKernelGen_has_target_tag

ifndef QUICK
$(cmt_local_GaudiKernelGen_makefile) : $(GaudiKernelGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernelGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernelGen_extratags) build constituent_config -out=$(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen
else
$(cmt_local_GaudiKernelGen_makefile) : $(GaudiKernelGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernelGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernelGen) ] || \
	  $(not_GaudiKernelGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernelGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernelGen_extratags) build constituent_config -out=$(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiKernelGen_makefile) : $(GaudiKernelGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernelGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernelGen.in -tag=$(tags) $(GaudiKernelGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen
else
$(cmt_local_GaudiKernelGen_makefile) : $(GaudiKernelGen_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiKernelGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernelGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernelGen) ] || \
	  $(not_GaudiKernelGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernelGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernelGen.in -tag=$(tags) $(GaudiKernelGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiKernelGen_extratags) build constituent_makefile -out=$(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen

GaudiKernelGen :: $(GaudiKernelGen_dependencies) $(cmt_local_GaudiKernelGen_makefile) dirs GaudiKernelGendirs
	$(echo) "(constituents.make) Starting GaudiKernelGen"
	@if test -f $(cmt_local_GaudiKernelGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) GaudiKernelGen
	$(echo) "(constituents.make) GaudiKernelGen done"

clean :: GaudiKernelGenclean ;

GaudiKernelGenclean :: $(GaudiKernelGenclean_dependencies) ##$(cmt_local_GaudiKernelGen_makefile)
	$(echo) "(constituents.make) Starting GaudiKernelGenclean"
	@-if test -f $(cmt_local_GaudiKernelGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) GaudiKernelGenclean; \
	fi
	$(echo) "(constituents.make) GaudiKernelGenclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) GaudiKernelGenclean

##	  /bin/rm -f $(cmt_local_GaudiKernelGen_makefile) $(bin)GaudiKernelGen_dependencies.make

install :: GaudiKernelGeninstall ;

GaudiKernelGeninstall :: $(GaudiKernelGen_dependencies) $(cmt_local_GaudiKernelGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernelGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiKernelGenuninstall

$(foreach d,$(GaudiKernelGen_dependencies),$(eval $(d)uninstall_dependencies += GaudiKernelGenuninstall))

GaudiKernelGenuninstall : $(GaudiKernelGenuninstall_dependencies) ##$(cmt_local_GaudiKernelGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernelGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiKernelGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiKernelGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiKernelGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GaudiKernelDict_has_no_target_tag = 1
cmt_GaudiKernelDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiKernelDict_has_target_tag

cmt_local_tagfile_GaudiKernelDict = $(bin)$(GaudiKernel_tag)_GaudiKernelDict.make
cmt_final_setup_GaudiKernelDict = $(bin)setup_GaudiKernelDict.make
cmt_local_GaudiKernelDict_makefile = $(bin)GaudiKernelDict.make

GaudiKernelDict_extratags = -tag_add=target_GaudiKernelDict

else

cmt_local_tagfile_GaudiKernelDict = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_GaudiKernelDict = $(bin)setup.make
cmt_local_GaudiKernelDict_makefile = $(bin)GaudiKernelDict.make

endif

not_GaudiKernelDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiKernelDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiKernelDictdirs :
	@if test ! -d $(bin)GaudiKernelDict; then $(mkdir) -p $(bin)GaudiKernelDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiKernelDict
else
GaudiKernelDictdirs : ;
endif

ifdef cmt_GaudiKernelDict_has_target_tag

ifndef QUICK
$(cmt_local_GaudiKernelDict_makefile) : $(GaudiKernelDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernelDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernelDict_extratags) build constituent_config -out=$(cmt_local_GaudiKernelDict_makefile) GaudiKernelDict
else
$(cmt_local_GaudiKernelDict_makefile) : $(GaudiKernelDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernelDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernelDict) ] || \
	  $(not_GaudiKernelDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernelDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiKernelDict_extratags) build constituent_config -out=$(cmt_local_GaudiKernelDict_makefile) GaudiKernelDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiKernelDict_makefile) : $(GaudiKernelDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiKernelDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernelDict.in -tag=$(tags) $(GaudiKernelDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernelDict_makefile) GaudiKernelDict
else
$(cmt_local_GaudiKernelDict_makefile) : $(GaudiKernelDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiKernelDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiKernelDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiKernelDict) ] || \
	  $(not_GaudiKernelDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiKernelDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiKernelDict.in -tag=$(tags) $(GaudiKernelDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiKernelDict_makefile) GaudiKernelDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiKernelDict_extratags) build constituent_makefile -out=$(cmt_local_GaudiKernelDict_makefile) GaudiKernelDict

GaudiKernelDict :: GaudiKernelDictcompile GaudiKernelDictinstall ;

ifdef cmt_GaudiKernelDict_has_prototypes

GaudiKernelDictprototype : $(GaudiKernelDictprototype_dependencies) $(cmt_local_GaudiKernelDict_makefile) dirs GaudiKernelDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernelDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiKernelDictcompile : GaudiKernelDictprototype

endif

GaudiKernelDictcompile : $(GaudiKernelDictcompile_dependencies) $(cmt_local_GaudiKernelDict_makefile) dirs GaudiKernelDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernelDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiKernelDictclean ;

GaudiKernelDictclean :: $(GaudiKernelDictclean_dependencies) ##$(cmt_local_GaudiKernelDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernelDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) GaudiKernelDictclean

##	  /bin/rm -f $(cmt_local_GaudiKernelDict_makefile) $(bin)GaudiKernelDict_dependencies.make

install :: GaudiKernelDictinstall ;

GaudiKernelDictinstall :: GaudiKernelDictcompile $(GaudiKernelDict_dependencies) $(cmt_local_GaudiKernelDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiKernelDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiKernelDictuninstall

$(foreach d,$(GaudiKernelDict_dependencies),$(eval $(d)uninstall_dependencies += GaudiKernelDictuninstall))

GaudiKernelDictuninstall : $(GaudiKernelDictuninstall_dependencies) ##$(cmt_local_GaudiKernelDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiKernelDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiKernelDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiKernelDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiKernelDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiKernelDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_genconf_has_no_target_tag = 1
cmt_genconf_has_prototypes = 1

#--------------------------------------

ifdef cmt_genconf_has_target_tag

cmt_local_tagfile_genconf = $(bin)$(GaudiKernel_tag)_genconf.make
cmt_final_setup_genconf = $(bin)setup_genconf.make
cmt_local_genconf_makefile = $(bin)genconf.make

genconf_extratags = -tag_add=target_genconf

else

cmt_local_tagfile_genconf = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_genconf = $(bin)setup.make
cmt_local_genconf_makefile = $(bin)genconf.make

endif

not_genconfcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(genconfcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
genconfdirs :
	@if test ! -d $(bin)genconf; then $(mkdir) -p $(bin)genconf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)genconf
else
genconfdirs : ;
endif

ifdef cmt_genconf_has_target_tag

ifndef QUICK
$(cmt_local_genconf_makefile) : $(genconfcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building genconf.make"; \
	  $(cmtexe) -tag=$(tags) $(genconf_extratags) build constituent_config -out=$(cmt_local_genconf_makefile) genconf
else
$(cmt_local_genconf_makefile) : $(genconfcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_genconf) ] || \
	  [ ! -f $(cmt_final_setup_genconf) ] || \
	  $(not_genconfcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building genconf.make"; \
	  $(cmtexe) -tag=$(tags) $(genconf_extratags) build constituent_config -out=$(cmt_local_genconf_makefile) genconf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_genconf_makefile) : $(genconfcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building genconf.make"; \
	  $(cmtexe) -f=$(bin)genconf.in -tag=$(tags) $(genconf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_genconf_makefile) genconf
else
$(cmt_local_genconf_makefile) : $(genconfcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)genconf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_genconf) ] || \
	  [ ! -f $(cmt_final_setup_genconf) ] || \
	  $(not_genconfcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building genconf.make"; \
	  $(cmtexe) -f=$(bin)genconf.in -tag=$(tags) $(genconf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_genconf_makefile) genconf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(genconf_extratags) build constituent_makefile -out=$(cmt_local_genconf_makefile) genconf

genconf :: genconfcompile genconfinstall ;

ifdef cmt_genconf_has_prototypes

genconfprototype : $(genconfprototype_dependencies) $(cmt_local_genconf_makefile) dirs genconfdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_genconf_makefile); then \
	  $(MAKE) -f $(cmt_local_genconf_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_genconf_makefile) $@
	$(echo) "(constituents.make) $@ done"

genconfcompile : genconfprototype

endif

genconfcompile : $(genconfcompile_dependencies) $(cmt_local_genconf_makefile) dirs genconfdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_genconf_makefile); then \
	  $(MAKE) -f $(cmt_local_genconf_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_genconf_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: genconfclean ;

genconfclean :: $(genconfclean_dependencies) ##$(cmt_local_genconf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_genconf_makefile); then \
	  $(MAKE) -f $(cmt_local_genconf_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_genconf_makefile) genconfclean

##	  /bin/rm -f $(cmt_local_genconf_makefile) $(bin)genconf_dependencies.make

install :: genconfinstall ;

genconfinstall :: genconfcompile $(genconf_dependencies) $(cmt_local_genconf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_genconf_makefile); then \
	  $(MAKE) -f $(cmt_local_genconf_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_genconf_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : genconfuninstall

$(foreach d,$(genconf_dependencies),$(eval $(d)uninstall_dependencies += genconfuninstall))

genconfuninstall : $(genconfuninstall_dependencies) ##$(cmt_local_genconf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_genconf_makefile); then \
	  $(MAKE) -f $(cmt_local_genconf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_genconf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: genconfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ genconf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ genconf done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_DirSearchPath_test_has_no_target_tag = 1
cmt_DirSearchPath_test_has_prototypes = 1

#--------------------------------------

ifdef cmt_DirSearchPath_test_has_target_tag

cmt_local_tagfile_DirSearchPath_test = $(bin)$(GaudiKernel_tag)_DirSearchPath_test.make
cmt_final_setup_DirSearchPath_test = $(bin)setup_DirSearchPath_test.make
cmt_local_DirSearchPath_test_makefile = $(bin)DirSearchPath_test.make

DirSearchPath_test_extratags = -tag_add=target_DirSearchPath_test

else

cmt_local_tagfile_DirSearchPath_test = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_DirSearchPath_test = $(bin)setup.make
cmt_local_DirSearchPath_test_makefile = $(bin)DirSearchPath_test.make

endif

not_DirSearchPath_testcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(DirSearchPath_testcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
DirSearchPath_testdirs :
	@if test ! -d $(bin)DirSearchPath_test; then $(mkdir) -p $(bin)DirSearchPath_test; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)DirSearchPath_test
else
DirSearchPath_testdirs : ;
endif

ifdef cmt_DirSearchPath_test_has_target_tag

ifndef QUICK
$(cmt_local_DirSearchPath_test_makefile) : $(DirSearchPath_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building DirSearchPath_test.make"; \
	  $(cmtexe) -tag=$(tags) $(DirSearchPath_test_extratags) build constituent_config -out=$(cmt_local_DirSearchPath_test_makefile) DirSearchPath_test
else
$(cmt_local_DirSearchPath_test_makefile) : $(DirSearchPath_testcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DirSearchPath_test) ] || \
	  [ ! -f $(cmt_final_setup_DirSearchPath_test) ] || \
	  $(not_DirSearchPath_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DirSearchPath_test.make"; \
	  $(cmtexe) -tag=$(tags) $(DirSearchPath_test_extratags) build constituent_config -out=$(cmt_local_DirSearchPath_test_makefile) DirSearchPath_test; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_DirSearchPath_test_makefile) : $(DirSearchPath_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building DirSearchPath_test.make"; \
	  $(cmtexe) -f=$(bin)DirSearchPath_test.in -tag=$(tags) $(DirSearchPath_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DirSearchPath_test_makefile) DirSearchPath_test
else
$(cmt_local_DirSearchPath_test_makefile) : $(DirSearchPath_testcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)DirSearchPath_test.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DirSearchPath_test) ] || \
	  [ ! -f $(cmt_final_setup_DirSearchPath_test) ] || \
	  $(not_DirSearchPath_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DirSearchPath_test.make"; \
	  $(cmtexe) -f=$(bin)DirSearchPath_test.in -tag=$(tags) $(DirSearchPath_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DirSearchPath_test_makefile) DirSearchPath_test; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(DirSearchPath_test_extratags) build constituent_makefile -out=$(cmt_local_DirSearchPath_test_makefile) DirSearchPath_test

DirSearchPath_test :: DirSearchPath_testcompile DirSearchPath_testinstall ;

ifdef cmt_DirSearchPath_test_has_prototypes

DirSearchPath_testprototype : $(DirSearchPath_testprototype_dependencies) $(cmt_local_DirSearchPath_test_makefile) dirs DirSearchPath_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DirSearchPath_test_makefile); then \
	  $(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

DirSearchPath_testcompile : DirSearchPath_testprototype

endif

DirSearchPath_testcompile : $(DirSearchPath_testcompile_dependencies) $(cmt_local_DirSearchPath_test_makefile) dirs DirSearchPath_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DirSearchPath_test_makefile); then \
	  $(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: DirSearchPath_testclean ;

DirSearchPath_testclean :: $(DirSearchPath_testclean_dependencies) ##$(cmt_local_DirSearchPath_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_DirSearchPath_test_makefile); then \
	  $(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) DirSearchPath_testclean

##	  /bin/rm -f $(cmt_local_DirSearchPath_test_makefile) $(bin)DirSearchPath_test_dependencies.make

install :: DirSearchPath_testinstall ;

DirSearchPath_testinstall :: DirSearchPath_testcompile $(DirSearchPath_test_dependencies) $(cmt_local_DirSearchPath_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DirSearchPath_test_makefile); then \
	  $(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : DirSearchPath_testuninstall

$(foreach d,$(DirSearchPath_test_dependencies),$(eval $(d)uninstall_dependencies += DirSearchPath_testuninstall))

DirSearchPath_testuninstall : $(DirSearchPath_testuninstall_dependencies) ##$(cmt_local_DirSearchPath_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_DirSearchPath_test_makefile); then \
	  $(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_DirSearchPath_test_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: DirSearchPath_testuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ DirSearchPath_test"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ DirSearchPath_test done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_PathResolver_test_has_no_target_tag = 1
cmt_PathResolver_test_has_prototypes = 1

#--------------------------------------

ifdef cmt_PathResolver_test_has_target_tag

cmt_local_tagfile_PathResolver_test = $(bin)$(GaudiKernel_tag)_PathResolver_test.make
cmt_final_setup_PathResolver_test = $(bin)setup_PathResolver_test.make
cmt_local_PathResolver_test_makefile = $(bin)PathResolver_test.make

PathResolver_test_extratags = -tag_add=target_PathResolver_test

else

cmt_local_tagfile_PathResolver_test = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_PathResolver_test = $(bin)setup.make
cmt_local_PathResolver_test_makefile = $(bin)PathResolver_test.make

endif

not_PathResolver_testcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PathResolver_testcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PathResolver_testdirs :
	@if test ! -d $(bin)PathResolver_test; then $(mkdir) -p $(bin)PathResolver_test; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PathResolver_test
else
PathResolver_testdirs : ;
endif

ifdef cmt_PathResolver_test_has_target_tag

ifndef QUICK
$(cmt_local_PathResolver_test_makefile) : $(PathResolver_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PathResolver_test.make"; \
	  $(cmtexe) -tag=$(tags) $(PathResolver_test_extratags) build constituent_config -out=$(cmt_local_PathResolver_test_makefile) PathResolver_test
else
$(cmt_local_PathResolver_test_makefile) : $(PathResolver_testcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PathResolver_test) ] || \
	  [ ! -f $(cmt_final_setup_PathResolver_test) ] || \
	  $(not_PathResolver_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PathResolver_test.make"; \
	  $(cmtexe) -tag=$(tags) $(PathResolver_test_extratags) build constituent_config -out=$(cmt_local_PathResolver_test_makefile) PathResolver_test; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PathResolver_test_makefile) : $(PathResolver_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PathResolver_test.make"; \
	  $(cmtexe) -f=$(bin)PathResolver_test.in -tag=$(tags) $(PathResolver_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PathResolver_test_makefile) PathResolver_test
else
$(cmt_local_PathResolver_test_makefile) : $(PathResolver_testcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PathResolver_test.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PathResolver_test) ] || \
	  [ ! -f $(cmt_final_setup_PathResolver_test) ] || \
	  $(not_PathResolver_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PathResolver_test.make"; \
	  $(cmtexe) -f=$(bin)PathResolver_test.in -tag=$(tags) $(PathResolver_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PathResolver_test_makefile) PathResolver_test; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PathResolver_test_extratags) build constituent_makefile -out=$(cmt_local_PathResolver_test_makefile) PathResolver_test

PathResolver_test :: PathResolver_testcompile PathResolver_testinstall ;

ifdef cmt_PathResolver_test_has_prototypes

PathResolver_testprototype : $(PathResolver_testprototype_dependencies) $(cmt_local_PathResolver_test_makefile) dirs PathResolver_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PathResolver_test_makefile); then \
	  $(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

PathResolver_testcompile : PathResolver_testprototype

endif

PathResolver_testcompile : $(PathResolver_testcompile_dependencies) $(cmt_local_PathResolver_test_makefile) dirs PathResolver_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PathResolver_test_makefile); then \
	  $(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PathResolver_testclean ;

PathResolver_testclean :: $(PathResolver_testclean_dependencies) ##$(cmt_local_PathResolver_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PathResolver_test_makefile); then \
	  $(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PathResolver_test_makefile) PathResolver_testclean

##	  /bin/rm -f $(cmt_local_PathResolver_test_makefile) $(bin)PathResolver_test_dependencies.make

install :: PathResolver_testinstall ;

PathResolver_testinstall :: PathResolver_testcompile $(PathResolver_test_dependencies) $(cmt_local_PathResolver_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PathResolver_test_makefile); then \
	  $(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PathResolver_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PathResolver_testuninstall

$(foreach d,$(PathResolver_test_dependencies),$(eval $(d)uninstall_dependencies += PathResolver_testuninstall))

PathResolver_testuninstall : $(PathResolver_testuninstall_dependencies) ##$(cmt_local_PathResolver_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PathResolver_test_makefile); then \
	  $(MAKE) -f $(cmt_local_PathResolver_test_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PathResolver_test_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PathResolver_testuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PathResolver_test"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PathResolver_test done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_Memory_test_has_no_target_tag = 1
cmt_Memory_test_has_prototypes = 1

#--------------------------------------

ifdef cmt_Memory_test_has_target_tag

cmt_local_tagfile_Memory_test = $(bin)$(GaudiKernel_tag)_Memory_test.make
cmt_final_setup_Memory_test = $(bin)setup_Memory_test.make
cmt_local_Memory_test_makefile = $(bin)Memory_test.make

Memory_test_extratags = -tag_add=target_Memory_test

else

cmt_local_tagfile_Memory_test = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_Memory_test = $(bin)setup.make
cmt_local_Memory_test_makefile = $(bin)Memory_test.make

endif

not_Memory_testcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Memory_testcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Memory_testdirs :
	@if test ! -d $(bin)Memory_test; then $(mkdir) -p $(bin)Memory_test; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Memory_test
else
Memory_testdirs : ;
endif

ifdef cmt_Memory_test_has_target_tag

ifndef QUICK
$(cmt_local_Memory_test_makefile) : $(Memory_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Memory_test.make"; \
	  $(cmtexe) -tag=$(tags) $(Memory_test_extratags) build constituent_config -out=$(cmt_local_Memory_test_makefile) Memory_test
else
$(cmt_local_Memory_test_makefile) : $(Memory_testcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Memory_test) ] || \
	  [ ! -f $(cmt_final_setup_Memory_test) ] || \
	  $(not_Memory_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Memory_test.make"; \
	  $(cmtexe) -tag=$(tags) $(Memory_test_extratags) build constituent_config -out=$(cmt_local_Memory_test_makefile) Memory_test; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Memory_test_makefile) : $(Memory_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Memory_test.make"; \
	  $(cmtexe) -f=$(bin)Memory_test.in -tag=$(tags) $(Memory_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Memory_test_makefile) Memory_test
else
$(cmt_local_Memory_test_makefile) : $(Memory_testcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Memory_test.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Memory_test) ] || \
	  [ ! -f $(cmt_final_setup_Memory_test) ] || \
	  $(not_Memory_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Memory_test.make"; \
	  $(cmtexe) -f=$(bin)Memory_test.in -tag=$(tags) $(Memory_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Memory_test_makefile) Memory_test; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Memory_test_extratags) build constituent_makefile -out=$(cmt_local_Memory_test_makefile) Memory_test

Memory_test :: Memory_testcompile Memory_testinstall ;

ifdef cmt_Memory_test_has_prototypes

Memory_testprototype : $(Memory_testprototype_dependencies) $(cmt_local_Memory_test_makefile) dirs Memory_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Memory_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Memory_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Memory_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

Memory_testcompile : Memory_testprototype

endif

Memory_testcompile : $(Memory_testcompile_dependencies) $(cmt_local_Memory_test_makefile) dirs Memory_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Memory_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Memory_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Memory_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Memory_testclean ;

Memory_testclean :: $(Memory_testclean_dependencies) ##$(cmt_local_Memory_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Memory_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Memory_test_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Memory_test_makefile) Memory_testclean

##	  /bin/rm -f $(cmt_local_Memory_test_makefile) $(bin)Memory_test_dependencies.make

install :: Memory_testinstall ;

Memory_testinstall :: Memory_testcompile $(Memory_test_dependencies) $(cmt_local_Memory_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Memory_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Memory_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Memory_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Memory_testuninstall

$(foreach d,$(Memory_test_dependencies),$(eval $(d)uninstall_dependencies += Memory_testuninstall))

Memory_testuninstall : $(Memory_testuninstall_dependencies) ##$(cmt_local_Memory_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Memory_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Memory_test_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Memory_test_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Memory_testuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Memory_test"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Memory_test done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_Parsers_test_has_no_target_tag = 1
cmt_Parsers_test_has_prototypes = 1

#--------------------------------------

ifdef cmt_Parsers_test_has_target_tag

cmt_local_tagfile_Parsers_test = $(bin)$(GaudiKernel_tag)_Parsers_test.make
cmt_final_setup_Parsers_test = $(bin)setup_Parsers_test.make
cmt_local_Parsers_test_makefile = $(bin)Parsers_test.make

Parsers_test_extratags = -tag_add=target_Parsers_test

else

cmt_local_tagfile_Parsers_test = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_Parsers_test = $(bin)setup.make
cmt_local_Parsers_test_makefile = $(bin)Parsers_test.make

endif

not_Parsers_testcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Parsers_testcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Parsers_testdirs :
	@if test ! -d $(bin)Parsers_test; then $(mkdir) -p $(bin)Parsers_test; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Parsers_test
else
Parsers_testdirs : ;
endif

ifdef cmt_Parsers_test_has_target_tag

ifndef QUICK
$(cmt_local_Parsers_test_makefile) : $(Parsers_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Parsers_test.make"; \
	  $(cmtexe) -tag=$(tags) $(Parsers_test_extratags) build constituent_config -out=$(cmt_local_Parsers_test_makefile) Parsers_test
else
$(cmt_local_Parsers_test_makefile) : $(Parsers_testcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Parsers_test) ] || \
	  [ ! -f $(cmt_final_setup_Parsers_test) ] || \
	  $(not_Parsers_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Parsers_test.make"; \
	  $(cmtexe) -tag=$(tags) $(Parsers_test_extratags) build constituent_config -out=$(cmt_local_Parsers_test_makefile) Parsers_test; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Parsers_test_makefile) : $(Parsers_testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Parsers_test.make"; \
	  $(cmtexe) -f=$(bin)Parsers_test.in -tag=$(tags) $(Parsers_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Parsers_test_makefile) Parsers_test
else
$(cmt_local_Parsers_test_makefile) : $(Parsers_testcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Parsers_test.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Parsers_test) ] || \
	  [ ! -f $(cmt_final_setup_Parsers_test) ] || \
	  $(not_Parsers_testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Parsers_test.make"; \
	  $(cmtexe) -f=$(bin)Parsers_test.in -tag=$(tags) $(Parsers_test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Parsers_test_makefile) Parsers_test; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Parsers_test_extratags) build constituent_makefile -out=$(cmt_local_Parsers_test_makefile) Parsers_test

Parsers_test :: Parsers_testcompile Parsers_testinstall ;

ifdef cmt_Parsers_test_has_prototypes

Parsers_testprototype : $(Parsers_testprototype_dependencies) $(cmt_local_Parsers_test_makefile) dirs Parsers_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Parsers_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Parsers_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Parsers_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

Parsers_testcompile : Parsers_testprototype

endif

Parsers_testcompile : $(Parsers_testcompile_dependencies) $(cmt_local_Parsers_test_makefile) dirs Parsers_testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Parsers_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Parsers_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Parsers_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Parsers_testclean ;

Parsers_testclean :: $(Parsers_testclean_dependencies) ##$(cmt_local_Parsers_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Parsers_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Parsers_test_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Parsers_test_makefile) Parsers_testclean

##	  /bin/rm -f $(cmt_local_Parsers_test_makefile) $(bin)Parsers_test_dependencies.make

install :: Parsers_testinstall ;

Parsers_testinstall :: Parsers_testcompile $(Parsers_test_dependencies) $(cmt_local_Parsers_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Parsers_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Parsers_test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Parsers_test_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Parsers_testuninstall

$(foreach d,$(Parsers_test_dependencies),$(eval $(d)uninstall_dependencies += Parsers_testuninstall))

Parsers_testuninstall : $(Parsers_testuninstall_dependencies) ##$(cmt_local_Parsers_test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Parsers_test_makefile); then \
	  $(MAKE) -f $(cmt_local_Parsers_test_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Parsers_test_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Parsers_testuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Parsers_test"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Parsers_test done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_SerializeSTL_has_no_target_tag = 1
cmt_test_SerializeSTL_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_SerializeSTL_has_target_tag

cmt_local_tagfile_test_SerializeSTL = $(bin)$(GaudiKernel_tag)_test_SerializeSTL.make
cmt_final_setup_test_SerializeSTL = $(bin)setup_test_SerializeSTL.make
cmt_local_test_SerializeSTL_makefile = $(bin)test_SerializeSTL.make

test_SerializeSTL_extratags = -tag_add=target_test_SerializeSTL

else

cmt_local_tagfile_test_SerializeSTL = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_test_SerializeSTL = $(bin)setup.make
cmt_local_test_SerializeSTL_makefile = $(bin)test_SerializeSTL.make

endif

not_test_SerializeSTLcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_SerializeSTLcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_SerializeSTLdirs :
	@if test ! -d $(bin)test_SerializeSTL; then $(mkdir) -p $(bin)test_SerializeSTL; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_SerializeSTL
else
test_SerializeSTLdirs : ;
endif

ifdef cmt_test_SerializeSTL_has_target_tag

ifndef QUICK
$(cmt_local_test_SerializeSTL_makefile) : $(test_SerializeSTLcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SerializeSTL.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SerializeSTL_extratags) build constituent_config -out=$(cmt_local_test_SerializeSTL_makefile) test_SerializeSTL
else
$(cmt_local_test_SerializeSTL_makefile) : $(test_SerializeSTLcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SerializeSTL) ] || \
	  [ ! -f $(cmt_final_setup_test_SerializeSTL) ] || \
	  $(not_test_SerializeSTLcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SerializeSTL.make"; \
	  $(cmtexe) -tag=$(tags) $(test_SerializeSTL_extratags) build constituent_config -out=$(cmt_local_test_SerializeSTL_makefile) test_SerializeSTL; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_SerializeSTL_makefile) : $(test_SerializeSTLcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_SerializeSTL.make"; \
	  $(cmtexe) -f=$(bin)test_SerializeSTL.in -tag=$(tags) $(test_SerializeSTL_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SerializeSTL_makefile) test_SerializeSTL
else
$(cmt_local_test_SerializeSTL_makefile) : $(test_SerializeSTLcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_SerializeSTL.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_SerializeSTL) ] || \
	  [ ! -f $(cmt_final_setup_test_SerializeSTL) ] || \
	  $(not_test_SerializeSTLcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_SerializeSTL.make"; \
	  $(cmtexe) -f=$(bin)test_SerializeSTL.in -tag=$(tags) $(test_SerializeSTL_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_SerializeSTL_makefile) test_SerializeSTL; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_SerializeSTL_extratags) build constituent_makefile -out=$(cmt_local_test_SerializeSTL_makefile) test_SerializeSTL

test_SerializeSTL :: test_SerializeSTLcompile test_SerializeSTLinstall ;

ifdef cmt_test_SerializeSTL_has_prototypes

test_SerializeSTLprototype : $(test_SerializeSTLprototype_dependencies) $(cmt_local_test_SerializeSTL_makefile) dirs test_SerializeSTLdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SerializeSTL_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_SerializeSTLcompile : test_SerializeSTLprototype

endif

test_SerializeSTLcompile : $(test_SerializeSTLcompile_dependencies) $(cmt_local_test_SerializeSTL_makefile) dirs test_SerializeSTLdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SerializeSTL_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_SerializeSTLclean ;

test_SerializeSTLclean :: $(test_SerializeSTLclean_dependencies) ##$(cmt_local_test_SerializeSTL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SerializeSTL_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) test_SerializeSTLclean

##	  /bin/rm -f $(cmt_local_test_SerializeSTL_makefile) $(bin)test_SerializeSTL_dependencies.make

install :: test_SerializeSTLinstall ;

test_SerializeSTLinstall :: test_SerializeSTLcompile $(test_SerializeSTL_dependencies) $(cmt_local_test_SerializeSTL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_SerializeSTL_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_SerializeSTLuninstall

$(foreach d,$(test_SerializeSTL_dependencies),$(eval $(d)uninstall_dependencies += test_SerializeSTLuninstall))

test_SerializeSTLuninstall : $(test_SerializeSTLuninstall_dependencies) ##$(cmt_local_test_SerializeSTL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_SerializeSTL_makefile); then \
	  $(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_SerializeSTL_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_SerializeSTLuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_SerializeSTL"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_SerializeSTL done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_GaudiTime_has_no_target_tag = 1
cmt_test_GaudiTime_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_GaudiTime_has_target_tag

cmt_local_tagfile_test_GaudiTime = $(bin)$(GaudiKernel_tag)_test_GaudiTime.make
cmt_final_setup_test_GaudiTime = $(bin)setup_test_GaudiTime.make
cmt_local_test_GaudiTime_makefile = $(bin)test_GaudiTime.make

test_GaudiTime_extratags = -tag_add=target_test_GaudiTime

else

cmt_local_tagfile_test_GaudiTime = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_test_GaudiTime = $(bin)setup.make
cmt_local_test_GaudiTime_makefile = $(bin)test_GaudiTime.make

endif

not_test_GaudiTimecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_GaudiTimecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_GaudiTimedirs :
	@if test ! -d $(bin)test_GaudiTime; then $(mkdir) -p $(bin)test_GaudiTime; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_GaudiTime
else
test_GaudiTimedirs : ;
endif

ifdef cmt_test_GaudiTime_has_target_tag

ifndef QUICK
$(cmt_local_test_GaudiTime_makefile) : $(test_GaudiTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GaudiTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GaudiTime_extratags) build constituent_config -out=$(cmt_local_test_GaudiTime_makefile) test_GaudiTime
else
$(cmt_local_test_GaudiTime_makefile) : $(test_GaudiTimecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GaudiTime) ] || \
	  [ ! -f $(cmt_final_setup_test_GaudiTime) ] || \
	  $(not_test_GaudiTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GaudiTime.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GaudiTime_extratags) build constituent_config -out=$(cmt_local_test_GaudiTime_makefile) test_GaudiTime; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_GaudiTime_makefile) : $(test_GaudiTimecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GaudiTime.make"; \
	  $(cmtexe) -f=$(bin)test_GaudiTime.in -tag=$(tags) $(test_GaudiTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GaudiTime_makefile) test_GaudiTime
else
$(cmt_local_test_GaudiTime_makefile) : $(test_GaudiTimecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_GaudiTime.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GaudiTime) ] || \
	  [ ! -f $(cmt_final_setup_test_GaudiTime) ] || \
	  $(not_test_GaudiTimecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GaudiTime.make"; \
	  $(cmtexe) -f=$(bin)test_GaudiTime.in -tag=$(tags) $(test_GaudiTime_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GaudiTime_makefile) test_GaudiTime; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_GaudiTime_extratags) build constituent_makefile -out=$(cmt_local_test_GaudiTime_makefile) test_GaudiTime

test_GaudiTime :: test_GaudiTimecompile test_GaudiTimeinstall ;

ifdef cmt_test_GaudiTime_has_prototypes

test_GaudiTimeprototype : $(test_GaudiTimeprototype_dependencies) $(cmt_local_test_GaudiTime_makefile) dirs test_GaudiTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_GaudiTimecompile : test_GaudiTimeprototype

endif

test_GaudiTimecompile : $(test_GaudiTimecompile_dependencies) $(cmt_local_test_GaudiTime_makefile) dirs test_GaudiTimedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_GaudiTimeclean ;

test_GaudiTimeclean :: $(test_GaudiTimeclean_dependencies) ##$(cmt_local_test_GaudiTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GaudiTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_GaudiTime_makefile) test_GaudiTimeclean

##	  /bin/rm -f $(cmt_local_test_GaudiTime_makefile) $(bin)test_GaudiTime_dependencies.make

install :: test_GaudiTimeinstall ;

test_GaudiTimeinstall :: test_GaudiTimecompile $(test_GaudiTime_dependencies) $(cmt_local_test_GaudiTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTime_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_GaudiTimeuninstall

$(foreach d,$(test_GaudiTime_dependencies),$(eval $(d)uninstall_dependencies += test_GaudiTimeuninstall))

test_GaudiTimeuninstall : $(test_GaudiTimeuninstall_dependencies) ##$(cmt_local_test_GaudiTime_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GaudiTime_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTime_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTime_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_GaudiTimeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_GaudiTime"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_GaudiTime done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_GaudiTiming_has_no_target_tag = 1
cmt_test_GaudiTiming_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_GaudiTiming_has_target_tag

cmt_local_tagfile_test_GaudiTiming = $(bin)$(GaudiKernel_tag)_test_GaudiTiming.make
cmt_final_setup_test_GaudiTiming = $(bin)setup_test_GaudiTiming.make
cmt_local_test_GaudiTiming_makefile = $(bin)test_GaudiTiming.make

test_GaudiTiming_extratags = -tag_add=target_test_GaudiTiming

else

cmt_local_tagfile_test_GaudiTiming = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_test_GaudiTiming = $(bin)setup.make
cmt_local_test_GaudiTiming_makefile = $(bin)test_GaudiTiming.make

endif

not_test_GaudiTimingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_GaudiTimingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_GaudiTimingdirs :
	@if test ! -d $(bin)test_GaudiTiming; then $(mkdir) -p $(bin)test_GaudiTiming; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_GaudiTiming
else
test_GaudiTimingdirs : ;
endif

ifdef cmt_test_GaudiTiming_has_target_tag

ifndef QUICK
$(cmt_local_test_GaudiTiming_makefile) : $(test_GaudiTimingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GaudiTiming.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GaudiTiming_extratags) build constituent_config -out=$(cmt_local_test_GaudiTiming_makefile) test_GaudiTiming
else
$(cmt_local_test_GaudiTiming_makefile) : $(test_GaudiTimingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GaudiTiming) ] || \
	  [ ! -f $(cmt_final_setup_test_GaudiTiming) ] || \
	  $(not_test_GaudiTimingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GaudiTiming.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GaudiTiming_extratags) build constituent_config -out=$(cmt_local_test_GaudiTiming_makefile) test_GaudiTiming; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_GaudiTiming_makefile) : $(test_GaudiTimingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GaudiTiming.make"; \
	  $(cmtexe) -f=$(bin)test_GaudiTiming.in -tag=$(tags) $(test_GaudiTiming_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GaudiTiming_makefile) test_GaudiTiming
else
$(cmt_local_test_GaudiTiming_makefile) : $(test_GaudiTimingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_GaudiTiming.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GaudiTiming) ] || \
	  [ ! -f $(cmt_final_setup_test_GaudiTiming) ] || \
	  $(not_test_GaudiTimingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GaudiTiming.make"; \
	  $(cmtexe) -f=$(bin)test_GaudiTiming.in -tag=$(tags) $(test_GaudiTiming_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GaudiTiming_makefile) test_GaudiTiming; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_GaudiTiming_extratags) build constituent_makefile -out=$(cmt_local_test_GaudiTiming_makefile) test_GaudiTiming

test_GaudiTiming :: test_GaudiTimingcompile test_GaudiTiminginstall ;

ifdef cmt_test_GaudiTiming_has_prototypes

test_GaudiTimingprototype : $(test_GaudiTimingprototype_dependencies) $(cmt_local_test_GaudiTiming_makefile) dirs test_GaudiTimingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTiming_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_GaudiTimingcompile : test_GaudiTimingprototype

endif

test_GaudiTimingcompile : $(test_GaudiTimingcompile_dependencies) $(cmt_local_test_GaudiTiming_makefile) dirs test_GaudiTimingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTiming_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_GaudiTimingclean ;

test_GaudiTimingclean :: $(test_GaudiTimingclean_dependencies) ##$(cmt_local_test_GaudiTiming_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GaudiTiming_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) test_GaudiTimingclean

##	  /bin/rm -f $(cmt_local_test_GaudiTiming_makefile) $(bin)test_GaudiTiming_dependencies.make

install :: test_GaudiTiminginstall ;

test_GaudiTiminginstall :: test_GaudiTimingcompile $(test_GaudiTiming_dependencies) $(cmt_local_test_GaudiTiming_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GaudiTiming_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_GaudiTiminguninstall

$(foreach d,$(test_GaudiTiming_dependencies),$(eval $(d)uninstall_dependencies += test_GaudiTiminguninstall))

test_GaudiTiminguninstall : $(test_GaudiTiminguninstall_dependencies) ##$(cmt_local_test_GaudiTiming_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GaudiTiming_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GaudiTiming_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_GaudiTiminguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_GaudiTiming"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_GaudiTiming done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_headers_build_has_no_target_tag = 1
cmt_test_headers_build_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_headers_build_has_target_tag

cmt_local_tagfile_test_headers_build = $(bin)$(GaudiKernel_tag)_test_headers_build.make
cmt_final_setup_test_headers_build = $(bin)setup_test_headers_build.make
cmt_local_test_headers_build_makefile = $(bin)test_headers_build.make

test_headers_build_extratags = -tag_add=target_test_headers_build

else

cmt_local_tagfile_test_headers_build = $(bin)$(GaudiKernel_tag).make
cmt_final_setup_test_headers_build = $(bin)setup.make
cmt_local_test_headers_build_makefile = $(bin)test_headers_build.make

endif

not_test_headers_buildcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_headers_buildcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_headers_builddirs :
	@if test ! -d $(bin)test_headers_build; then $(mkdir) -p $(bin)test_headers_build; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_headers_build
else
test_headers_builddirs : ;
endif

ifdef cmt_test_headers_build_has_target_tag

ifndef QUICK
$(cmt_local_test_headers_build_makefile) : $(test_headers_buildcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_headers_build.make"; \
	  $(cmtexe) -tag=$(tags) $(test_headers_build_extratags) build constituent_config -out=$(cmt_local_test_headers_build_makefile) test_headers_build
else
$(cmt_local_test_headers_build_makefile) : $(test_headers_buildcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_headers_build) ] || \
	  [ ! -f $(cmt_final_setup_test_headers_build) ] || \
	  $(not_test_headers_buildcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_headers_build.make"; \
	  $(cmtexe) -tag=$(tags) $(test_headers_build_extratags) build constituent_config -out=$(cmt_local_test_headers_build_makefile) test_headers_build; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_headers_build_makefile) : $(test_headers_buildcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_headers_build.make"; \
	  $(cmtexe) -f=$(bin)test_headers_build.in -tag=$(tags) $(test_headers_build_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_headers_build_makefile) test_headers_build
else
$(cmt_local_test_headers_build_makefile) : $(test_headers_buildcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_headers_build.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_headers_build) ] || \
	  [ ! -f $(cmt_final_setup_test_headers_build) ] || \
	  $(not_test_headers_buildcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_headers_build.make"; \
	  $(cmtexe) -f=$(bin)test_headers_build.in -tag=$(tags) $(test_headers_build_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_headers_build_makefile) test_headers_build; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_headers_build_extratags) build constituent_makefile -out=$(cmt_local_test_headers_build_makefile) test_headers_build

test_headers_build :: test_headers_buildcompile test_headers_buildinstall ;

ifdef cmt_test_headers_build_has_prototypes

test_headers_buildprototype : $(test_headers_buildprototype_dependencies) $(cmt_local_test_headers_build_makefile) dirs test_headers_builddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_headers_build_makefile); then \
	  $(MAKE) -f $(cmt_local_test_headers_build_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_headers_build_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_headers_buildcompile : test_headers_buildprototype

endif

test_headers_buildcompile : $(test_headers_buildcompile_dependencies) $(cmt_local_test_headers_build_makefile) dirs test_headers_builddirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_headers_build_makefile); then \
	  $(MAKE) -f $(cmt_local_test_headers_build_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_headers_build_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_headers_buildclean ;

test_headers_buildclean :: $(test_headers_buildclean_dependencies) ##$(cmt_local_test_headers_build_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_headers_build_makefile); then \
	  $(MAKE) -f $(cmt_local_test_headers_build_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_headers_build_makefile) test_headers_buildclean

##	  /bin/rm -f $(cmt_local_test_headers_build_makefile) $(bin)test_headers_build_dependencies.make

install :: test_headers_buildinstall ;

test_headers_buildinstall :: test_headers_buildcompile $(test_headers_build_dependencies) $(cmt_local_test_headers_build_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_headers_build_makefile); then \
	  $(MAKE) -f $(cmt_local_test_headers_build_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_headers_build_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_headers_builduninstall

$(foreach d,$(test_headers_build_dependencies),$(eval $(d)uninstall_dependencies += test_headers_builduninstall))

test_headers_builduninstall : $(test_headers_builduninstall_dependencies) ##$(cmt_local_test_headers_build_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_headers_build_makefile); then \
	  $(MAKE) -f $(cmt_local_test_headers_build_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_headers_build_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_headers_builduninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_headers_build"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_headers_build done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiKernel_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiKernel_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiKernel_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiKernel_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiKernel_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiKernel_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiKernel_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiKernel_tag)_QMTestTestsDatabase.make
cmt_final_setup_QMTestTestsDatabase = $(bin)setup_QMTestTestsDatabase.make
cmt_local_QMTestTestsDatabase_makefile = $(bin)QMTestTestsDatabase.make

QMTestTestsDatabase_extratags = -tag_add=target_QMTestTestsDatabase

else

cmt_local_tagfile_QMTestTestsDatabase = $(bin)$(GaudiKernel_tag).make
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

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiKernel_tag)_QMTestGUI.make
cmt_final_setup_QMTestGUI = $(bin)setup_QMTestGUI.make
cmt_local_QMTestGUI_makefile = $(bin)QMTestGUI.make

QMTestGUI_extratags = -tag_add=target_QMTestGUI

else

cmt_local_tagfile_QMTestGUI = $(bin)$(GaudiKernel_tag).make
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
