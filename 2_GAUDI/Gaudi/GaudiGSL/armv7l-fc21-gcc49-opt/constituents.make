
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile = $(GaudiGSL_tag).make
cmt_local_tagfile = $(bin)$(GaudiGSL_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiGSL_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiGSL_tag).make
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

cmt_GaudiGSLLib_has_no_target_tag = 1
cmt_GaudiGSLLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSLLib_has_target_tag

cmt_local_tagfile_GaudiGSLLib = $(bin)$(GaudiGSL_tag)_GaudiGSLLib.make
cmt_final_setup_GaudiGSLLib = $(bin)setup_GaudiGSLLib.make
cmt_local_GaudiGSLLib_makefile = $(bin)GaudiGSLLib.make

GaudiGSLLib_extratags = -tag_add=target_GaudiGSLLib

else

cmt_local_tagfile_GaudiGSLLib = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLLib = $(bin)setup.make
cmt_local_GaudiGSLLib_makefile = $(bin)GaudiGSLLib.make

endif

not_GaudiGSLLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLLibdirs :
	@if test ! -d $(bin)GaudiGSLLib; then $(mkdir) -p $(bin)GaudiGSLLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLLib
else
GaudiGSLLibdirs : ;
endif

ifdef cmt_GaudiGSLLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLLib_makefile) : $(GaudiGSLLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLLib_extratags) build constituent_config -out=$(cmt_local_GaudiGSLLib_makefile) GaudiGSLLib
else
$(cmt_local_GaudiGSLLib_makefile) : $(GaudiGSLLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLLib) ] || \
	  $(not_GaudiGSLLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLLib_extratags) build constituent_config -out=$(cmt_local_GaudiGSLLib_makefile) GaudiGSLLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLLib_makefile) : $(GaudiGSLLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLLib.in -tag=$(tags) $(GaudiGSLLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLLib_makefile) GaudiGSLLib
else
$(cmt_local_GaudiGSLLib_makefile) : $(GaudiGSLLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLLib) ] || \
	  $(not_GaudiGSLLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLLib.in -tag=$(tags) $(GaudiGSLLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLLib_makefile) GaudiGSLLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLLib_makefile) GaudiGSLLib

GaudiGSLLib :: GaudiGSLLibcompile GaudiGSLLibinstall ;

ifdef cmt_GaudiGSLLib_has_prototypes

GaudiGSLLibprototype : $(GaudiGSLLibprototype_dependencies) $(cmt_local_GaudiGSLLib_makefile) dirs GaudiGSLLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiGSLLibcompile : GaudiGSLLibprototype

endif

GaudiGSLLibcompile : $(GaudiGSLLibcompile_dependencies) $(cmt_local_GaudiGSLLib_makefile) dirs GaudiGSLLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiGSLLibclean ;

GaudiGSLLibclean :: $(GaudiGSLLibclean_dependencies) ##$(cmt_local_GaudiGSLLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) GaudiGSLLibclean

##	  /bin/rm -f $(cmt_local_GaudiGSLLib_makefile) $(bin)GaudiGSLLib_dependencies.make

install :: GaudiGSLLibinstall ;

GaudiGSLLibinstall :: GaudiGSLLibcompile $(GaudiGSLLib_dependencies) $(cmt_local_GaudiGSLLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLLibuninstall

$(foreach d,$(GaudiGSLLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLLibuninstall))

GaudiGSLLibuninstall : $(GaudiGSLLibuninstall_dependencies) ##$(cmt_local_GaudiGSLLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiGSL_has_no_target_tag = 1
cmt_GaudiGSL_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSL_has_target_tag

cmt_local_tagfile_GaudiGSL = $(bin)$(GaudiGSL_tag)_GaudiGSL.make
cmt_final_setup_GaudiGSL = $(bin)setup_GaudiGSL.make
cmt_local_GaudiGSL_makefile = $(bin)GaudiGSL.make

GaudiGSL_extratags = -tag_add=target_GaudiGSL

else

cmt_local_tagfile_GaudiGSL = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSL = $(bin)setup.make
cmt_local_GaudiGSL_makefile = $(bin)GaudiGSL.make

endif

not_GaudiGSLcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLdirs :
	@if test ! -d $(bin)GaudiGSL; then $(mkdir) -p $(bin)GaudiGSL; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSL
else
GaudiGSLdirs : ;
endif

ifdef cmt_GaudiGSL_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSL_makefile) : $(GaudiGSLcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSL.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSL_extratags) build constituent_config -out=$(cmt_local_GaudiGSL_makefile) GaudiGSL
else
$(cmt_local_GaudiGSL_makefile) : $(GaudiGSLcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSL) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSL) ] || \
	  $(not_GaudiGSLcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSL.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSL_extratags) build constituent_config -out=$(cmt_local_GaudiGSL_makefile) GaudiGSL; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSL_makefile) : $(GaudiGSLcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSL.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSL.in -tag=$(tags) $(GaudiGSL_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSL_makefile) GaudiGSL
else
$(cmt_local_GaudiGSL_makefile) : $(GaudiGSLcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSL.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSL) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSL) ] || \
	  $(not_GaudiGSLcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSL.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSL.in -tag=$(tags) $(GaudiGSL_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSL_makefile) GaudiGSL; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSL_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSL_makefile) GaudiGSL

GaudiGSL :: GaudiGSLcompile GaudiGSLinstall ;

ifdef cmt_GaudiGSL_has_prototypes

GaudiGSLprototype : $(GaudiGSLprototype_dependencies) $(cmt_local_GaudiGSL_makefile) dirs GaudiGSLdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSL_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiGSLcompile : GaudiGSLprototype

endif

GaudiGSLcompile : $(GaudiGSLcompile_dependencies) $(cmt_local_GaudiGSL_makefile) dirs GaudiGSLdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSL_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiGSLclean ;

GaudiGSLclean :: $(GaudiGSLclean_dependencies) ##$(cmt_local_GaudiGSL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSL_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSL_makefile) GaudiGSLclean

##	  /bin/rm -f $(cmt_local_GaudiGSL_makefile) $(bin)GaudiGSL_dependencies.make

install :: GaudiGSLinstall ;

GaudiGSLinstall :: GaudiGSLcompile $(GaudiGSL_dependencies) $(cmt_local_GaudiGSL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSL_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLuninstall

$(foreach d,$(GaudiGSL_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLuninstall))

GaudiGSLuninstall : $(GaudiGSLuninstall_dependencies) ##$(cmt_local_GaudiGSL_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSL_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSL"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSL done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiGSLComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSLComponentsList_has_target_tag

cmt_local_tagfile_GaudiGSLComponentsList = $(bin)$(GaudiGSL_tag)_GaudiGSLComponentsList.make
cmt_final_setup_GaudiGSLComponentsList = $(bin)setup_GaudiGSLComponentsList.make
cmt_local_GaudiGSLComponentsList_makefile = $(bin)GaudiGSLComponentsList.make

GaudiGSLComponentsList_extratags = -tag_add=target_GaudiGSLComponentsList

else

cmt_local_tagfile_GaudiGSLComponentsList = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLComponentsList = $(bin)setup.make
cmt_local_GaudiGSLComponentsList_makefile = $(bin)GaudiGSLComponentsList.make

endif

not_GaudiGSLComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLComponentsListdirs :
	@if test ! -d $(bin)GaudiGSLComponentsList; then $(mkdir) -p $(bin)GaudiGSLComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLComponentsList
else
GaudiGSLComponentsListdirs : ;
endif

ifdef cmt_GaudiGSLComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLComponentsList_makefile) : $(GaudiGSLComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList
else
$(cmt_local_GaudiGSLComponentsList_makefile) : $(GaudiGSLComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLComponentsList) ] || \
	  $(not_GaudiGSLComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLComponentsList_makefile) : $(GaudiGSLComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLComponentsList.in -tag=$(tags) $(GaudiGSLComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList
else
$(cmt_local_GaudiGSLComponentsList_makefile) : $(GaudiGSLComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLComponentsList) ] || \
	  $(not_GaudiGSLComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLComponentsList.in -tag=$(tags) $(GaudiGSLComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList

GaudiGSLComponentsList :: $(GaudiGSLComponentsList_dependencies) $(cmt_local_GaudiGSLComponentsList_makefile) dirs GaudiGSLComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiGSLComponentsList"
	@if test -f $(cmt_local_GaudiGSLComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsList
	$(echo) "(constituents.make) GaudiGSLComponentsList done"

clean :: GaudiGSLComponentsListclean ;

GaudiGSLComponentsListclean :: $(GaudiGSLComponentsListclean_dependencies) ##$(cmt_local_GaudiGSLComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiGSLComponentsListclean"
	@-if test -f $(cmt_local_GaudiGSLComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiGSLComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) GaudiGSLComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiGSLComponentsList_makefile) $(bin)GaudiGSLComponentsList_dependencies.make

install :: GaudiGSLComponentsListinstall ;

GaudiGSLComponentsListinstall :: $(GaudiGSLComponentsList_dependencies) $(cmt_local_GaudiGSLComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLComponentsListuninstall

$(foreach d,$(GaudiGSLComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLComponentsListuninstall))

GaudiGSLComponentsListuninstall : $(GaudiGSLComponentsListuninstall_dependencies) ##$(cmt_local_GaudiGSLComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGSLMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSLMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiGSLMergeComponentsList = $(bin)$(GaudiGSL_tag)_GaudiGSLMergeComponentsList.make
cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)setup_GaudiGSLMergeComponentsList.make
cmt_local_GaudiGSLMergeComponentsList_makefile = $(bin)GaudiGSLMergeComponentsList.make

GaudiGSLMergeComponentsList_extratags = -tag_add=target_GaudiGSLMergeComponentsList

else

cmt_local_tagfile_GaudiGSLMergeComponentsList = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)setup.make
cmt_local_GaudiGSLMergeComponentsList_makefile = $(bin)GaudiGSLMergeComponentsList.make

endif

not_GaudiGSLMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiGSLMergeComponentsList; then $(mkdir) -p $(bin)GaudiGSLMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLMergeComponentsList
else
GaudiGSLMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiGSLMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLMergeComponentsList_makefile) : $(GaudiGSLMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList
else
$(cmt_local_GaudiGSLMergeComponentsList_makefile) : $(GaudiGSLMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMergeComponentsList) ] || \
	  $(not_GaudiGSLMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLMergeComponentsList_makefile) : $(GaudiGSLMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMergeComponentsList.in -tag=$(tags) $(GaudiGSLMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList
else
$(cmt_local_GaudiGSLMergeComponentsList_makefile) : $(GaudiGSLMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMergeComponentsList) ] || \
	  $(not_GaudiGSLMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMergeComponentsList.in -tag=$(tags) $(GaudiGSLMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList

GaudiGSLMergeComponentsList :: $(GaudiGSLMergeComponentsList_dependencies) $(cmt_local_GaudiGSLMergeComponentsList_makefile) dirs GaudiGSLMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiGSLMergeComponentsList"
	@if test -f $(cmt_local_GaudiGSLMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsList
	$(echo) "(constituents.make) GaudiGSLMergeComponentsList done"

clean :: GaudiGSLMergeComponentsListclean ;

GaudiGSLMergeComponentsListclean :: $(GaudiGSLMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiGSLMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiGSLMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiGSLMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiGSLMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) GaudiGSLMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) $(bin)GaudiGSLMergeComponentsList_dependencies.make

install :: GaudiGSLMergeComponentsListinstall ;

GaudiGSLMergeComponentsListinstall :: $(GaudiGSLMergeComponentsList_dependencies) $(cmt_local_GaudiGSLMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLMergeComponentsListuninstall

$(foreach d,$(GaudiGSLMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLMergeComponentsListuninstall))

GaudiGSLMergeComponentsListuninstall : $(GaudiGSLMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiGSLMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGSLConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSLConf_has_target_tag

cmt_local_tagfile_GaudiGSLConf = $(bin)$(GaudiGSL_tag)_GaudiGSLConf.make
cmt_final_setup_GaudiGSLConf = $(bin)setup_GaudiGSLConf.make
cmt_local_GaudiGSLConf_makefile = $(bin)GaudiGSLConf.make

GaudiGSLConf_extratags = -tag_add=target_GaudiGSLConf

else

cmt_local_tagfile_GaudiGSLConf = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLConf = $(bin)setup.make
cmt_local_GaudiGSLConf_makefile = $(bin)GaudiGSLConf.make

endif

not_GaudiGSLConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLConfdirs :
	@if test ! -d $(bin)GaudiGSLConf; then $(mkdir) -p $(bin)GaudiGSLConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLConf
else
GaudiGSLConfdirs : ;
endif

ifdef cmt_GaudiGSLConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLConf_makefile) : $(GaudiGSLConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLConf_extratags) build constituent_config -out=$(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf
else
$(cmt_local_GaudiGSLConf_makefile) : $(GaudiGSLConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLConf) ] || \
	  $(not_GaudiGSLConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLConf_extratags) build constituent_config -out=$(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLConf_makefile) : $(GaudiGSLConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLConf.in -tag=$(tags) $(GaudiGSLConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf
else
$(cmt_local_GaudiGSLConf_makefile) : $(GaudiGSLConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLConf) ] || \
	  $(not_GaudiGSLConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLConf.in -tag=$(tags) $(GaudiGSLConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf

GaudiGSLConf :: $(GaudiGSLConf_dependencies) $(cmt_local_GaudiGSLConf_makefile) dirs GaudiGSLConfdirs
	$(echo) "(constituents.make) Starting GaudiGSLConf"
	@if test -f $(cmt_local_GaudiGSLConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) GaudiGSLConf
	$(echo) "(constituents.make) GaudiGSLConf done"

clean :: GaudiGSLConfclean ;

GaudiGSLConfclean :: $(GaudiGSLConfclean_dependencies) ##$(cmt_local_GaudiGSLConf_makefile)
	$(echo) "(constituents.make) Starting GaudiGSLConfclean"
	@-if test -f $(cmt_local_GaudiGSLConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) GaudiGSLConfclean; \
	fi
	$(echo) "(constituents.make) GaudiGSLConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) GaudiGSLConfclean

##	  /bin/rm -f $(cmt_local_GaudiGSLConf_makefile) $(bin)GaudiGSLConf_dependencies.make

install :: GaudiGSLConfinstall ;

GaudiGSLConfinstall :: $(GaudiGSLConf_dependencies) $(cmt_local_GaudiGSLConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLConfuninstall

$(foreach d,$(GaudiGSLConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLConfuninstall))

GaudiGSLConfuninstall : $(GaudiGSLConfuninstall_dependencies) ##$(cmt_local_GaudiGSLConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGSL_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSL_python_init_has_target_tag

cmt_local_tagfile_GaudiGSL_python_init = $(bin)$(GaudiGSL_tag)_GaudiGSL_python_init.make
cmt_final_setup_GaudiGSL_python_init = $(bin)setup_GaudiGSL_python_init.make
cmt_local_GaudiGSL_python_init_makefile = $(bin)GaudiGSL_python_init.make

GaudiGSL_python_init_extratags = -tag_add=target_GaudiGSL_python_init

else

cmt_local_tagfile_GaudiGSL_python_init = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSL_python_init = $(bin)setup.make
cmt_local_GaudiGSL_python_init_makefile = $(bin)GaudiGSL_python_init.make

endif

not_GaudiGSL_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSL_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSL_python_initdirs :
	@if test ! -d $(bin)GaudiGSL_python_init; then $(mkdir) -p $(bin)GaudiGSL_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSL_python_init
else
GaudiGSL_python_initdirs : ;
endif

ifdef cmt_GaudiGSL_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSL_python_init_makefile) : $(GaudiGSL_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSL_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSL_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init
else
$(cmt_local_GaudiGSL_python_init_makefile) : $(GaudiGSL_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSL_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSL_python_init) ] || \
	  $(not_GaudiGSL_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSL_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSL_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSL_python_init_makefile) : $(GaudiGSL_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSL_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSL_python_init.in -tag=$(tags) $(GaudiGSL_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init
else
$(cmt_local_GaudiGSL_python_init_makefile) : $(GaudiGSL_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSL_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSL_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSL_python_init) ] || \
	  $(not_GaudiGSL_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSL_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSL_python_init.in -tag=$(tags) $(GaudiGSL_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSL_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init

GaudiGSL_python_init :: $(GaudiGSL_python_init_dependencies) $(cmt_local_GaudiGSL_python_init_makefile) dirs GaudiGSL_python_initdirs
	$(echo) "(constituents.make) Starting GaudiGSL_python_init"
	@if test -f $(cmt_local_GaudiGSL_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_init
	$(echo) "(constituents.make) GaudiGSL_python_init done"

clean :: GaudiGSL_python_initclean ;

GaudiGSL_python_initclean :: $(GaudiGSL_python_initclean_dependencies) ##$(cmt_local_GaudiGSL_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiGSL_python_initclean"
	@-if test -f $(cmt_local_GaudiGSL_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiGSL_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) GaudiGSL_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiGSL_python_init_makefile) $(bin)GaudiGSL_python_init_dependencies.make

install :: GaudiGSL_python_initinstall ;

GaudiGSL_python_initinstall :: $(GaudiGSL_python_init_dependencies) $(cmt_local_GaudiGSL_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSL_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSL_python_inituninstall

$(foreach d,$(GaudiGSL_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSL_python_inituninstall))

GaudiGSL_python_inituninstall : $(GaudiGSL_python_inituninstall_dependencies) ##$(cmt_local_GaudiGSL_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSL_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSL_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSL_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSL_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSL_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiGSL_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiGSL_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiGSL_python_modules = $(bin)$(GaudiGSL_tag)_zip_GaudiGSL_python_modules.make
cmt_final_setup_zip_GaudiGSL_python_modules = $(bin)setup_zip_GaudiGSL_python_modules.make
cmt_local_zip_GaudiGSL_python_modules_makefile = $(bin)zip_GaudiGSL_python_modules.make

zip_GaudiGSL_python_modules_extratags = -tag_add=target_zip_GaudiGSL_python_modules

else

cmt_local_tagfile_zip_GaudiGSL_python_modules = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_zip_GaudiGSL_python_modules = $(bin)setup.make
cmt_local_zip_GaudiGSL_python_modules_makefile = $(bin)zip_GaudiGSL_python_modules.make

endif

not_zip_GaudiGSL_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiGSL_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiGSL_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiGSL_python_modules; then $(mkdir) -p $(bin)zip_GaudiGSL_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiGSL_python_modules
else
zip_GaudiGSL_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiGSL_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiGSL_python_modules_makefile) : $(zip_GaudiGSL_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiGSL_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiGSL_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules
else
$(cmt_local_zip_GaudiGSL_python_modules_makefile) : $(zip_GaudiGSL_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiGSL_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiGSL_python_modules) ] || \
	  $(not_zip_GaudiGSL_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiGSL_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiGSL_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiGSL_python_modules_makefile) : $(zip_GaudiGSL_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiGSL_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiGSL_python_modules.in -tag=$(tags) $(zip_GaudiGSL_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules
else
$(cmt_local_zip_GaudiGSL_python_modules_makefile) : $(zip_GaudiGSL_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiGSL_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiGSL_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiGSL_python_modules) ] || \
	  $(not_zip_GaudiGSL_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiGSL_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiGSL_python_modules.in -tag=$(tags) $(zip_GaudiGSL_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiGSL_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules

zip_GaudiGSL_python_modules :: $(zip_GaudiGSL_python_modules_dependencies) $(cmt_local_zip_GaudiGSL_python_modules_makefile) dirs zip_GaudiGSL_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiGSL_python_modules"
	@if test -f $(cmt_local_zip_GaudiGSL_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modules
	$(echo) "(constituents.make) zip_GaudiGSL_python_modules done"

clean :: zip_GaudiGSL_python_modulesclean ;

zip_GaudiGSL_python_modulesclean :: $(zip_GaudiGSL_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiGSL_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiGSL_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiGSL_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiGSL_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) zip_GaudiGSL_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) $(bin)zip_GaudiGSL_python_modules_dependencies.make

install :: zip_GaudiGSL_python_modulesinstall ;

zip_GaudiGSL_python_modulesinstall :: $(zip_GaudiGSL_python_modules_dependencies) $(cmt_local_zip_GaudiGSL_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiGSL_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiGSL_python_modulesuninstall

$(foreach d,$(zip_GaudiGSL_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiGSL_python_modulesuninstall))

zip_GaudiGSL_python_modulesuninstall : $(zip_GaudiGSL_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiGSL_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiGSL_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiGSL_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiGSL_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiGSL_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiGSL_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGSLConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSLConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiGSLConfDbMerge = $(bin)$(GaudiGSL_tag)_GaudiGSLConfDbMerge.make
cmt_final_setup_GaudiGSLConfDbMerge = $(bin)setup_GaudiGSLConfDbMerge.make
cmt_local_GaudiGSLConfDbMerge_makefile = $(bin)GaudiGSLConfDbMerge.make

GaudiGSLConfDbMerge_extratags = -tag_add=target_GaudiGSLConfDbMerge

else

cmt_local_tagfile_GaudiGSLConfDbMerge = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLConfDbMerge = $(bin)setup.make
cmt_local_GaudiGSLConfDbMerge_makefile = $(bin)GaudiGSLConfDbMerge.make

endif

not_GaudiGSLConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLConfDbMergedirs :
	@if test ! -d $(bin)GaudiGSLConfDbMerge; then $(mkdir) -p $(bin)GaudiGSLConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLConfDbMerge
else
GaudiGSLConfDbMergedirs : ;
endif

ifdef cmt_GaudiGSLConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLConfDbMerge_makefile) : $(GaudiGSLConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge
else
$(cmt_local_GaudiGSLConfDbMerge_makefile) : $(GaudiGSLConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLConfDbMerge) ] || \
	  $(not_GaudiGSLConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLConfDbMerge_makefile) : $(GaudiGSLConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLConfDbMerge.in -tag=$(tags) $(GaudiGSLConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge
else
$(cmt_local_GaudiGSLConfDbMerge_makefile) : $(GaudiGSLConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLConfDbMerge) ] || \
	  $(not_GaudiGSLConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLConfDbMerge.in -tag=$(tags) $(GaudiGSLConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge

GaudiGSLConfDbMerge :: $(GaudiGSLConfDbMerge_dependencies) $(cmt_local_GaudiGSLConfDbMerge_makefile) dirs GaudiGSLConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiGSLConfDbMerge"
	@if test -f $(cmt_local_GaudiGSLConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMerge
	$(echo) "(constituents.make) GaudiGSLConfDbMerge done"

clean :: GaudiGSLConfDbMergeclean ;

GaudiGSLConfDbMergeclean :: $(GaudiGSLConfDbMergeclean_dependencies) ##$(cmt_local_GaudiGSLConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiGSLConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiGSLConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiGSLConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) GaudiGSLConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiGSLConfDbMerge_makefile) $(bin)GaudiGSLConfDbMerge_dependencies.make

install :: GaudiGSLConfDbMergeinstall ;

GaudiGSLConfDbMergeinstall :: $(GaudiGSLConfDbMerge_dependencies) $(cmt_local_GaudiGSLConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLConfDbMergeuninstall

$(foreach d,$(GaudiGSLConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLConfDbMergeuninstall))

GaudiGSLConfDbMergeuninstall : $(GaudiGSLConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiGSLConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGSLMathGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGSLMathGen_has_target_tag

cmt_local_tagfile_GaudiGSLMathGen = $(bin)$(GaudiGSL_tag)_GaudiGSLMathGen.make
cmt_final_setup_GaudiGSLMathGen = $(bin)setup_GaudiGSLMathGen.make
cmt_local_GaudiGSLMathGen_makefile = $(bin)GaudiGSLMathGen.make

GaudiGSLMathGen_extratags = -tag_add=target_GaudiGSLMathGen

else

cmt_local_tagfile_GaudiGSLMathGen = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLMathGen = $(bin)setup.make
cmt_local_GaudiGSLMathGen_makefile = $(bin)GaudiGSLMathGen.make

endif

not_GaudiGSLMathGen_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLMathGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLMathGendirs :
	@if test ! -d $(bin)GaudiGSLMathGen; then $(mkdir) -p $(bin)GaudiGSLMathGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLMathGen
else
GaudiGSLMathGendirs : ;
endif

ifdef cmt_GaudiGSLMathGen_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLMathGen_makefile) : $(GaudiGSLMathGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMathGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathGen_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen
else
$(cmt_local_GaudiGSLMathGen_makefile) : $(GaudiGSLMathGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMathGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMathGen) ] || \
	  $(not_GaudiGSLMathGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMathGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathGen_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLMathGen_makefile) : $(GaudiGSLMathGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMathGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMathGen.in -tag=$(tags) $(GaudiGSLMathGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen
else
$(cmt_local_GaudiGSLMathGen_makefile) : $(GaudiGSLMathGen_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLMathGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMathGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMathGen) ] || \
	  $(not_GaudiGSLMathGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMathGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMathGen.in -tag=$(tags) $(GaudiGSLMathGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathGen_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen

GaudiGSLMathGen :: $(GaudiGSLMathGen_dependencies) $(cmt_local_GaudiGSLMathGen_makefile) dirs GaudiGSLMathGendirs
	$(echo) "(constituents.make) Starting GaudiGSLMathGen"
	@if test -f $(cmt_local_GaudiGSLMathGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGen
	$(echo) "(constituents.make) GaudiGSLMathGen done"

clean :: GaudiGSLMathGenclean ;

GaudiGSLMathGenclean :: $(GaudiGSLMathGenclean_dependencies) ##$(cmt_local_GaudiGSLMathGen_makefile)
	$(echo) "(constituents.make) Starting GaudiGSLMathGenclean"
	@-if test -f $(cmt_local_GaudiGSLMathGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGenclean; \
	fi
	$(echo) "(constituents.make) GaudiGSLMathGenclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) GaudiGSLMathGenclean

##	  /bin/rm -f $(cmt_local_GaudiGSLMathGen_makefile) $(bin)GaudiGSLMathGen_dependencies.make

install :: GaudiGSLMathGeninstall ;

GaudiGSLMathGeninstall :: $(GaudiGSLMathGen_dependencies) $(cmt_local_GaudiGSLMathGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLMathGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLMathGenuninstall

$(foreach d,$(GaudiGSLMathGen_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLMathGenuninstall))

GaudiGSLMathGenuninstall : $(GaudiGSLMathGenuninstall_dependencies) ##$(cmt_local_GaudiGSLMathGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLMathGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLMathGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLMathGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLMathGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GaudiGSLMathDict_has_no_target_tag = 1
cmt_GaudiGSLMathDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGSLMathDict_has_target_tag

cmt_local_tagfile_GaudiGSLMathDict = $(bin)$(GaudiGSL_tag)_GaudiGSLMathDict.make
cmt_final_setup_GaudiGSLMathDict = $(bin)setup_GaudiGSLMathDict.make
cmt_local_GaudiGSLMathDict_makefile = $(bin)GaudiGSLMathDict.make

GaudiGSLMathDict_extratags = -tag_add=target_GaudiGSLMathDict

else

cmt_local_tagfile_GaudiGSLMathDict = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GaudiGSLMathDict = $(bin)setup.make
cmt_local_GaudiGSLMathDict_makefile = $(bin)GaudiGSLMathDict.make

endif

not_GaudiGSLMathDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGSLMathDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGSLMathDictdirs :
	@if test ! -d $(bin)GaudiGSLMathDict; then $(mkdir) -p $(bin)GaudiGSLMathDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGSLMathDict
else
GaudiGSLMathDictdirs : ;
endif

ifdef cmt_GaudiGSLMathDict_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGSLMathDict_makefile) : $(GaudiGSLMathDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMathDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathDict_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDict
else
$(cmt_local_GaudiGSLMathDict_makefile) : $(GaudiGSLMathDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMathDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMathDict) ] || \
	  $(not_GaudiGSLMathDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMathDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathDict_extratags) build constituent_config -out=$(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGSLMathDict_makefile) : $(GaudiGSLMathDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGSLMathDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMathDict.in -tag=$(tags) $(GaudiGSLMathDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDict
else
$(cmt_local_GaudiGSLMathDict_makefile) : $(GaudiGSLMathDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGSLMathDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGSLMathDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGSLMathDict) ] || \
	  $(not_GaudiGSLMathDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGSLMathDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiGSLMathDict.in -tag=$(tags) $(GaudiGSLMathDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGSLMathDict_extratags) build constituent_makefile -out=$(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDict

GaudiGSLMathDict :: GaudiGSLMathDictcompile GaudiGSLMathDictinstall ;

ifdef cmt_GaudiGSLMathDict_has_prototypes

GaudiGSLMathDictprototype : $(GaudiGSLMathDictprototype_dependencies) $(cmt_local_GaudiGSLMathDict_makefile) dirs GaudiGSLMathDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLMathDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiGSLMathDictcompile : GaudiGSLMathDictprototype

endif

GaudiGSLMathDictcompile : $(GaudiGSLMathDictcompile_dependencies) $(cmt_local_GaudiGSLMathDict_makefile) dirs GaudiGSLMathDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLMathDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiGSLMathDictclean ;

GaudiGSLMathDictclean :: $(GaudiGSLMathDictclean_dependencies) ##$(cmt_local_GaudiGSLMathDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLMathDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) GaudiGSLMathDictclean

##	  /bin/rm -f $(cmt_local_GaudiGSLMathDict_makefile) $(bin)GaudiGSLMathDict_dependencies.make

install :: GaudiGSLMathDictinstall ;

GaudiGSLMathDictinstall :: GaudiGSLMathDictcompile $(GaudiGSLMathDict_dependencies) $(cmt_local_GaudiGSLMathDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGSLMathDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGSLMathDictuninstall

$(foreach d,$(GaudiGSLMathDict_dependencies),$(eval $(d)uninstall_dependencies += GaudiGSLMathDictuninstall))

GaudiGSLMathDictuninstall : $(GaudiGSLMathDictuninstall_dependencies) ##$(cmt_local_GaudiGSLMathDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGSLMathDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGSLMathDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGSLMathDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGSLMathDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGSLMathDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_ExceptionsTest_has_no_target_tag = 1
cmt_ExceptionsTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_ExceptionsTest_has_target_tag

cmt_local_tagfile_ExceptionsTest = $(bin)$(GaudiGSL_tag)_ExceptionsTest.make
cmt_final_setup_ExceptionsTest = $(bin)setup_ExceptionsTest.make
cmt_local_ExceptionsTest_makefile = $(bin)ExceptionsTest.make

ExceptionsTest_extratags = -tag_add=target_ExceptionsTest

else

cmt_local_tagfile_ExceptionsTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_ExceptionsTest = $(bin)setup.make
cmt_local_ExceptionsTest_makefile = $(bin)ExceptionsTest.make

endif

not_ExceptionsTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(ExceptionsTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
ExceptionsTestdirs :
	@if test ! -d $(bin)ExceptionsTest; then $(mkdir) -p $(bin)ExceptionsTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)ExceptionsTest
else
ExceptionsTestdirs : ;
endif

ifdef cmt_ExceptionsTest_has_target_tag

ifndef QUICK
$(cmt_local_ExceptionsTest_makefile) : $(ExceptionsTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ExceptionsTest.make"; \
	  $(cmtexe) -tag=$(tags) $(ExceptionsTest_extratags) build constituent_config -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest
else
$(cmt_local_ExceptionsTest_makefile) : $(ExceptionsTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ExceptionsTest) ] || \
	  [ ! -f $(cmt_final_setup_ExceptionsTest) ] || \
	  $(not_ExceptionsTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ExceptionsTest.make"; \
	  $(cmtexe) -tag=$(tags) $(ExceptionsTest_extratags) build constituent_config -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_ExceptionsTest_makefile) : $(ExceptionsTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building ExceptionsTest.make"; \
	  $(cmtexe) -f=$(bin)ExceptionsTest.in -tag=$(tags) $(ExceptionsTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest
else
$(cmt_local_ExceptionsTest_makefile) : $(ExceptionsTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)ExceptionsTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_ExceptionsTest) ] || \
	  [ ! -f $(cmt_final_setup_ExceptionsTest) ] || \
	  $(not_ExceptionsTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building ExceptionsTest.make"; \
	  $(cmtexe) -f=$(bin)ExceptionsTest.in -tag=$(tags) $(ExceptionsTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(ExceptionsTest_extratags) build constituent_makefile -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest

ExceptionsTest :: ExceptionsTestcompile ExceptionsTestinstall ;

ifdef cmt_ExceptionsTest_has_prototypes

ExceptionsTestprototype : $(ExceptionsTestprototype_dependencies) $(cmt_local_ExceptionsTest_makefile) dirs ExceptionsTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

ExceptionsTestcompile : ExceptionsTestprototype

endif

ExceptionsTestcompile : $(ExceptionsTestcompile_dependencies) $(cmt_local_ExceptionsTest_makefile) dirs ExceptionsTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: ExceptionsTestclean ;

ExceptionsTestclean :: $(ExceptionsTestclean_dependencies) ##$(cmt_local_ExceptionsTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) ExceptionsTestclean

##	  /bin/rm -f $(cmt_local_ExceptionsTest_makefile) $(bin)ExceptionsTest_dependencies.make

install :: ExceptionsTestinstall ;

ExceptionsTestinstall :: ExceptionsTestcompile $(ExceptionsTest_dependencies) $(cmt_local_ExceptionsTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : ExceptionsTestuninstall

$(foreach d,$(ExceptionsTest_dependencies),$(eval $(d)uninstall_dependencies += ExceptionsTestuninstall))

ExceptionsTestuninstall : $(ExceptionsTestuninstall_dependencies) ##$(cmt_local_ExceptionsTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(MAKE) -f $(cmt_local_ExceptionsTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: ExceptionsTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ ExceptionsTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ ExceptionsTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_ExceptionsTest_is_not_check_group = 1

#--------------------------------------

check :: ExceptionsTestcheck
	$(echo) "(constituents.make) ExceptionsTestcheck ok"
#	@echo "------> ExceptionsTestcheck ok"

#ExceptionsTestcheck : ExceptionsTest $(cmt_local_ExceptionsTest_makefile)
#ExceptionsTestcheck : $(cmt_local_ExceptionsTest_makefile)
ifdef cmt_ExceptionsTest_is_check_group
ExceptionsTestcheck : ExceptionsTest
else
ExceptionsTestcheck :
endif
	@if test ! -f $(cmt_local_ExceptionsTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(ExceptionsTest_extratags) build constituent_makefile -out=$(cmt_local_ExceptionsTest_makefile) ExceptionsTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_ExceptionsTest_makefile) $@

#ExceptionsTestcheck ::
#	@echo "------> starting ExceptionsTestcheck"
#	@$(cmtexe) build constituent_makefile ExceptionsTest; $(MAKE) -f ExceptionsTest.make build_strategy=keep_makefiles ExceptionsTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_DerivativeTest_has_no_target_tag = 1
cmt_DerivativeTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_DerivativeTest_has_target_tag

cmt_local_tagfile_DerivativeTest = $(bin)$(GaudiGSL_tag)_DerivativeTest.make
cmt_final_setup_DerivativeTest = $(bin)setup_DerivativeTest.make
cmt_local_DerivativeTest_makefile = $(bin)DerivativeTest.make

DerivativeTest_extratags = -tag_add=target_DerivativeTest

else

cmt_local_tagfile_DerivativeTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_DerivativeTest = $(bin)setup.make
cmt_local_DerivativeTest_makefile = $(bin)DerivativeTest.make

endif

not_DerivativeTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(DerivativeTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
DerivativeTestdirs :
	@if test ! -d $(bin)DerivativeTest; then $(mkdir) -p $(bin)DerivativeTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)DerivativeTest
else
DerivativeTestdirs : ;
endif

ifdef cmt_DerivativeTest_has_target_tag

ifndef QUICK
$(cmt_local_DerivativeTest_makefile) : $(DerivativeTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building DerivativeTest.make"; \
	  $(cmtexe) -tag=$(tags) $(DerivativeTest_extratags) build constituent_config -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest
else
$(cmt_local_DerivativeTest_makefile) : $(DerivativeTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DerivativeTest) ] || \
	  [ ! -f $(cmt_final_setup_DerivativeTest) ] || \
	  $(not_DerivativeTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DerivativeTest.make"; \
	  $(cmtexe) -tag=$(tags) $(DerivativeTest_extratags) build constituent_config -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_DerivativeTest_makefile) : $(DerivativeTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building DerivativeTest.make"; \
	  $(cmtexe) -f=$(bin)DerivativeTest.in -tag=$(tags) $(DerivativeTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest
else
$(cmt_local_DerivativeTest_makefile) : $(DerivativeTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)DerivativeTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_DerivativeTest) ] || \
	  [ ! -f $(cmt_final_setup_DerivativeTest) ] || \
	  $(not_DerivativeTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building DerivativeTest.make"; \
	  $(cmtexe) -f=$(bin)DerivativeTest.in -tag=$(tags) $(DerivativeTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(DerivativeTest_extratags) build constituent_makefile -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest

DerivativeTest :: DerivativeTestcompile DerivativeTestinstall ;

ifdef cmt_DerivativeTest_has_prototypes

DerivativeTestprototype : $(DerivativeTestprototype_dependencies) $(cmt_local_DerivativeTest_makefile) dirs DerivativeTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DerivativeTest_makefile); then \
	  $(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

DerivativeTestcompile : DerivativeTestprototype

endif

DerivativeTestcompile : $(DerivativeTestcompile_dependencies) $(cmt_local_DerivativeTest_makefile) dirs DerivativeTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DerivativeTest_makefile); then \
	  $(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: DerivativeTestclean ;

DerivativeTestclean :: $(DerivativeTestclean_dependencies) ##$(cmt_local_DerivativeTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_DerivativeTest_makefile); then \
	  $(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_DerivativeTest_makefile) DerivativeTestclean

##	  /bin/rm -f $(cmt_local_DerivativeTest_makefile) $(bin)DerivativeTest_dependencies.make

install :: DerivativeTestinstall ;

DerivativeTestinstall :: DerivativeTestcompile $(DerivativeTest_dependencies) $(cmt_local_DerivativeTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_DerivativeTest_makefile); then \
	  $(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : DerivativeTestuninstall

$(foreach d,$(DerivativeTest_dependencies),$(eval $(d)uninstall_dependencies += DerivativeTestuninstall))

DerivativeTestuninstall : $(DerivativeTestuninstall_dependencies) ##$(cmt_local_DerivativeTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_DerivativeTest_makefile); then \
	  $(MAKE) -f $(cmt_local_DerivativeTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_DerivativeTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: DerivativeTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ DerivativeTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ DerivativeTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_DerivativeTest_is_not_check_group = 1

#--------------------------------------

check :: DerivativeTestcheck
	$(echo) "(constituents.make) DerivativeTestcheck ok"
#	@echo "------> DerivativeTestcheck ok"

#DerivativeTestcheck : DerivativeTest $(cmt_local_DerivativeTest_makefile)
#DerivativeTestcheck : $(cmt_local_DerivativeTest_makefile)
ifdef cmt_DerivativeTest_is_check_group
DerivativeTestcheck : DerivativeTest
else
DerivativeTestcheck :
endif
	@if test ! -f $(cmt_local_DerivativeTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(DerivativeTest_extratags) build constituent_makefile -out=$(cmt_local_DerivativeTest_makefile) DerivativeTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_DerivativeTest_makefile) $@

#DerivativeTestcheck ::
#	@echo "------> starting DerivativeTestcheck"
#	@$(cmtexe) build constituent_makefile DerivativeTest; $(MAKE) -f DerivativeTest.make build_strategy=keep_makefiles DerivativeTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_SimpleFuncTest_has_no_target_tag = 1
cmt_SimpleFuncTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_SimpleFuncTest_has_target_tag

cmt_local_tagfile_SimpleFuncTest = $(bin)$(GaudiGSL_tag)_SimpleFuncTest.make
cmt_final_setup_SimpleFuncTest = $(bin)setup_SimpleFuncTest.make
cmt_local_SimpleFuncTest_makefile = $(bin)SimpleFuncTest.make

SimpleFuncTest_extratags = -tag_add=target_SimpleFuncTest

else

cmt_local_tagfile_SimpleFuncTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_SimpleFuncTest = $(bin)setup.make
cmt_local_SimpleFuncTest_makefile = $(bin)SimpleFuncTest.make

endif

not_SimpleFuncTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(SimpleFuncTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
SimpleFuncTestdirs :
	@if test ! -d $(bin)SimpleFuncTest; then $(mkdir) -p $(bin)SimpleFuncTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)SimpleFuncTest
else
SimpleFuncTestdirs : ;
endif

ifdef cmt_SimpleFuncTest_has_target_tag

ifndef QUICK
$(cmt_local_SimpleFuncTest_makefile) : $(SimpleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimpleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_config -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest
else
$(cmt_local_SimpleFuncTest_makefile) : $(SimpleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimpleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_SimpleFuncTest) ] || \
	  $(not_SimpleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimpleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_config -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_SimpleFuncTest_makefile) : $(SimpleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building SimpleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)SimpleFuncTest.in -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest
else
$(cmt_local_SimpleFuncTest_makefile) : $(SimpleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)SimpleFuncTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_SimpleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_SimpleFuncTest) ] || \
	  $(not_SimpleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building SimpleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)SimpleFuncTest.in -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest

SimpleFuncTest :: SimpleFuncTestcompile SimpleFuncTestinstall ;

ifdef cmt_SimpleFuncTest_has_prototypes

SimpleFuncTestprototype : $(SimpleFuncTestprototype_dependencies) $(cmt_local_SimpleFuncTest_makefile) dirs SimpleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

SimpleFuncTestcompile : SimpleFuncTestprototype

endif

SimpleFuncTestcompile : $(SimpleFuncTestcompile_dependencies) $(cmt_local_SimpleFuncTest_makefile) dirs SimpleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: SimpleFuncTestclean ;

SimpleFuncTestclean :: $(SimpleFuncTestclean_dependencies) ##$(cmt_local_SimpleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) SimpleFuncTestclean

##	  /bin/rm -f $(cmt_local_SimpleFuncTest_makefile) $(bin)SimpleFuncTest_dependencies.make

install :: SimpleFuncTestinstall ;

SimpleFuncTestinstall :: SimpleFuncTestcompile $(SimpleFuncTest_dependencies) $(cmt_local_SimpleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : SimpleFuncTestuninstall

$(foreach d,$(SimpleFuncTest_dependencies),$(eval $(d)uninstall_dependencies += SimpleFuncTestuninstall))

SimpleFuncTestuninstall : $(SimpleFuncTestuninstall_dependencies) ##$(cmt_local_SimpleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: SimpleFuncTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ SimpleFuncTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ SimpleFuncTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_SimpleFuncTest_is_not_check_group = 1

#--------------------------------------

check :: SimpleFuncTestcheck
	$(echo) "(constituents.make) SimpleFuncTestcheck ok"
#	@echo "------> SimpleFuncTestcheck ok"

#SimpleFuncTestcheck : SimpleFuncTest $(cmt_local_SimpleFuncTest_makefile)
#SimpleFuncTestcheck : $(cmt_local_SimpleFuncTest_makefile)
ifdef cmt_SimpleFuncTest_is_check_group
SimpleFuncTestcheck : SimpleFuncTest
else
SimpleFuncTestcheck :
endif
	@if test ! -f $(cmt_local_SimpleFuncTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(SimpleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_SimpleFuncTest_makefile) SimpleFuncTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_SimpleFuncTest_makefile) $@

#SimpleFuncTestcheck ::
#	@echo "------> starting SimpleFuncTestcheck"
#	@$(cmtexe) build constituent_makefile SimpleFuncTest; $(MAKE) -f SimpleFuncTest.make build_strategy=keep_makefiles SimpleFuncTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_IntegralInTest_has_no_target_tag = 1
cmt_IntegralInTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_IntegralInTest_has_target_tag

cmt_local_tagfile_IntegralInTest = $(bin)$(GaudiGSL_tag)_IntegralInTest.make
cmt_final_setup_IntegralInTest = $(bin)setup_IntegralInTest.make
cmt_local_IntegralInTest_makefile = $(bin)IntegralInTest.make

IntegralInTest_extratags = -tag_add=target_IntegralInTest

else

cmt_local_tagfile_IntegralInTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_IntegralInTest = $(bin)setup.make
cmt_local_IntegralInTest_makefile = $(bin)IntegralInTest.make

endif

not_IntegralInTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(IntegralInTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntegralInTestdirs :
	@if test ! -d $(bin)IntegralInTest; then $(mkdir) -p $(bin)IntegralInTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntegralInTest
else
IntegralInTestdirs : ;
endif

ifdef cmt_IntegralInTest_has_target_tag

ifndef QUICK
$(cmt_local_IntegralInTest_makefile) : $(IntegralInTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntegralInTest.make"; \
	  $(cmtexe) -tag=$(tags) $(IntegralInTest_extratags) build constituent_config -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest
else
$(cmt_local_IntegralInTest_makefile) : $(IntegralInTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntegralInTest) ] || \
	  [ ! -f $(cmt_final_setup_IntegralInTest) ] || \
	  $(not_IntegralInTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntegralInTest.make"; \
	  $(cmtexe) -tag=$(tags) $(IntegralInTest_extratags) build constituent_config -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntegralInTest_makefile) : $(IntegralInTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntegralInTest.make"; \
	  $(cmtexe) -f=$(bin)IntegralInTest.in -tag=$(tags) $(IntegralInTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest
else
$(cmt_local_IntegralInTest_makefile) : $(IntegralInTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)IntegralInTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntegralInTest) ] || \
	  [ ! -f $(cmt_final_setup_IntegralInTest) ] || \
	  $(not_IntegralInTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntegralInTest.make"; \
	  $(cmtexe) -f=$(bin)IntegralInTest.in -tag=$(tags) $(IntegralInTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntegralInTest_extratags) build constituent_makefile -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest

IntegralInTest :: IntegralInTestcompile IntegralInTestinstall ;

ifdef cmt_IntegralInTest_has_prototypes

IntegralInTestprototype : $(IntegralInTestprototype_dependencies) $(cmt_local_IntegralInTest_makefile) dirs IntegralInTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntegralInTest_makefile); then \
	  $(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

IntegralInTestcompile : IntegralInTestprototype

endif

IntegralInTestcompile : $(IntegralInTestcompile_dependencies) $(cmt_local_IntegralInTest_makefile) dirs IntegralInTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntegralInTest_makefile); then \
	  $(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: IntegralInTestclean ;

IntegralInTestclean :: $(IntegralInTestclean_dependencies) ##$(cmt_local_IntegralInTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntegralInTest_makefile); then \
	  $(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_IntegralInTest_makefile) IntegralInTestclean

##	  /bin/rm -f $(cmt_local_IntegralInTest_makefile) $(bin)IntegralInTest_dependencies.make

install :: IntegralInTestinstall ;

IntegralInTestinstall :: IntegralInTestcompile $(IntegralInTest_dependencies) $(cmt_local_IntegralInTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntegralInTest_makefile); then \
	  $(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : IntegralInTestuninstall

$(foreach d,$(IntegralInTest_dependencies),$(eval $(d)uninstall_dependencies += IntegralInTestuninstall))

IntegralInTestuninstall : $(IntegralInTestuninstall_dependencies) ##$(cmt_local_IntegralInTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntegralInTest_makefile); then \
	  $(MAKE) -f $(cmt_local_IntegralInTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntegralInTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntegralInTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntegralInTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntegralInTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_IntegralInTest_is_not_check_group = 1

#--------------------------------------

check :: IntegralInTestcheck
	$(echo) "(constituents.make) IntegralInTestcheck ok"
#	@echo "------> IntegralInTestcheck ok"

#IntegralInTestcheck : IntegralInTest $(cmt_local_IntegralInTest_makefile)
#IntegralInTestcheck : $(cmt_local_IntegralInTest_makefile)
ifdef cmt_IntegralInTest_is_check_group
IntegralInTestcheck : IntegralInTest
else
IntegralInTestcheck :
endif
	@if test ! -f $(cmt_local_IntegralInTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(IntegralInTest_extratags) build constituent_makefile -out=$(cmt_local_IntegralInTest_makefile) IntegralInTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_IntegralInTest_makefile) $@

#IntegralInTestcheck ::
#	@echo "------> starting IntegralInTestcheck"
#	@$(cmtexe) build constituent_makefile IntegralInTest; $(MAKE) -f IntegralInTest.make build_strategy=keep_makefiles IntegralInTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_Integral1Test_has_no_target_tag = 1
cmt_Integral1Test_has_prototypes = 1

#--------------------------------------

ifdef cmt_Integral1Test_has_target_tag

cmt_local_tagfile_Integral1Test = $(bin)$(GaudiGSL_tag)_Integral1Test.make
cmt_final_setup_Integral1Test = $(bin)setup_Integral1Test.make
cmt_local_Integral1Test_makefile = $(bin)Integral1Test.make

Integral1Test_extratags = -tag_add=target_Integral1Test

else

cmt_local_tagfile_Integral1Test = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_Integral1Test = $(bin)setup.make
cmt_local_Integral1Test_makefile = $(bin)Integral1Test.make

endif

not_Integral1Testcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(Integral1Testcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
Integral1Testdirs :
	@if test ! -d $(bin)Integral1Test; then $(mkdir) -p $(bin)Integral1Test; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)Integral1Test
else
Integral1Testdirs : ;
endif

ifdef cmt_Integral1Test_has_target_tag

ifndef QUICK
$(cmt_local_Integral1Test_makefile) : $(Integral1Testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Integral1Test.make"; \
	  $(cmtexe) -tag=$(tags) $(Integral1Test_extratags) build constituent_config -out=$(cmt_local_Integral1Test_makefile) Integral1Test
else
$(cmt_local_Integral1Test_makefile) : $(Integral1Testcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Integral1Test) ] || \
	  [ ! -f $(cmt_final_setup_Integral1Test) ] || \
	  $(not_Integral1Testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Integral1Test.make"; \
	  $(cmtexe) -tag=$(tags) $(Integral1Test_extratags) build constituent_config -out=$(cmt_local_Integral1Test_makefile) Integral1Test; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_Integral1Test_makefile) : $(Integral1Testcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building Integral1Test.make"; \
	  $(cmtexe) -f=$(bin)Integral1Test.in -tag=$(tags) $(Integral1Test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Integral1Test_makefile) Integral1Test
else
$(cmt_local_Integral1Test_makefile) : $(Integral1Testcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)Integral1Test.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_Integral1Test) ] || \
	  [ ! -f $(cmt_final_setup_Integral1Test) ] || \
	  $(not_Integral1Testcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building Integral1Test.make"; \
	  $(cmtexe) -f=$(bin)Integral1Test.in -tag=$(tags) $(Integral1Test_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_Integral1Test_makefile) Integral1Test; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(Integral1Test_extratags) build constituent_makefile -out=$(cmt_local_Integral1Test_makefile) Integral1Test

Integral1Test :: Integral1Testcompile Integral1Testinstall ;

ifdef cmt_Integral1Test_has_prototypes

Integral1Testprototype : $(Integral1Testprototype_dependencies) $(cmt_local_Integral1Test_makefile) dirs Integral1Testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Integral1Test_makefile); then \
	  $(MAKE) -f $(cmt_local_Integral1Test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Integral1Test_makefile) $@
	$(echo) "(constituents.make) $@ done"

Integral1Testcompile : Integral1Testprototype

endif

Integral1Testcompile : $(Integral1Testcompile_dependencies) $(cmt_local_Integral1Test_makefile) dirs Integral1Testdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Integral1Test_makefile); then \
	  $(MAKE) -f $(cmt_local_Integral1Test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Integral1Test_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: Integral1Testclean ;

Integral1Testclean :: $(Integral1Testclean_dependencies) ##$(cmt_local_Integral1Test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Integral1Test_makefile); then \
	  $(MAKE) -f $(cmt_local_Integral1Test_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_Integral1Test_makefile) Integral1Testclean

##	  /bin/rm -f $(cmt_local_Integral1Test_makefile) $(bin)Integral1Test_dependencies.make

install :: Integral1Testinstall ;

Integral1Testinstall :: Integral1Testcompile $(Integral1Test_dependencies) $(cmt_local_Integral1Test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_Integral1Test_makefile); then \
	  $(MAKE) -f $(cmt_local_Integral1Test_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_Integral1Test_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : Integral1Testuninstall

$(foreach d,$(Integral1Test_dependencies),$(eval $(d)uninstall_dependencies += Integral1Testuninstall))

Integral1Testuninstall : $(Integral1Testuninstall_dependencies) ##$(cmt_local_Integral1Test_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_Integral1Test_makefile); then \
	  $(MAKE) -f $(cmt_local_Integral1Test_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_Integral1Test_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: Integral1Testuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ Integral1Test"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ Integral1Test done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_Integral1Test_is_not_check_group = 1

#--------------------------------------

check :: Integral1Testcheck
	$(echo) "(constituents.make) Integral1Testcheck ok"
#	@echo "------> Integral1Testcheck ok"

#Integral1Testcheck : Integral1Test $(cmt_local_Integral1Test_makefile)
#Integral1Testcheck : $(cmt_local_Integral1Test_makefile)
ifdef cmt_Integral1Test_is_check_group
Integral1Testcheck : Integral1Test
else
Integral1Testcheck :
endif
	@if test ! -f $(cmt_local_Integral1Test_makefile); then \
	  $(cmtexe) -tag=$(tags) $(Integral1Test_extratags) build constituent_makefile -out=$(cmt_local_Integral1Test_makefile) Integral1Test; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_Integral1Test_makefile) $@

#Integral1Testcheck ::
#	@echo "------> starting Integral1Testcheck"
#	@$(cmtexe) build constituent_makefile Integral1Test; $(MAKE) -f Integral1Test.make build_strategy=keep_makefiles Integral1Testcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_2DoubleFuncTest_has_no_target_tag = 1
cmt_2DoubleFuncTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_2DoubleFuncTest_has_target_tag

cmt_local_tagfile_2DoubleFuncTest = $(bin)$(GaudiGSL_tag)_2DoubleFuncTest.make
cmt_final_setup_2DoubleFuncTest = $(bin)setup_2DoubleFuncTest.make
cmt_local_2DoubleFuncTest_makefile = $(bin)2DoubleFuncTest.make

2DoubleFuncTest_extratags = -tag_add=target_2DoubleFuncTest

else

cmt_local_tagfile_2DoubleFuncTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_2DoubleFuncTest = $(bin)setup.make
cmt_local_2DoubleFuncTest_makefile = $(bin)2DoubleFuncTest.make

endif

not_2DoubleFuncTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(2DoubleFuncTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
2DoubleFuncTestdirs :
	@if test ! -d $(bin)2DoubleFuncTest; then $(mkdir) -p $(bin)2DoubleFuncTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)2DoubleFuncTest
else
2DoubleFuncTestdirs : ;
endif

ifdef cmt_2DoubleFuncTest_has_target_tag

ifndef QUICK
$(cmt_local_2DoubleFuncTest_makefile) : $(2DoubleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building 2DoubleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_config -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest
else
$(cmt_local_2DoubleFuncTest_makefile) : $(2DoubleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_2DoubleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_2DoubleFuncTest) ] || \
	  $(not_2DoubleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building 2DoubleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_config -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_2DoubleFuncTest_makefile) : $(2DoubleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building 2DoubleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)2DoubleFuncTest.in -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest
else
$(cmt_local_2DoubleFuncTest_makefile) : $(2DoubleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)2DoubleFuncTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_2DoubleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_2DoubleFuncTest) ] || \
	  $(not_2DoubleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building 2DoubleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)2DoubleFuncTest.in -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest

2DoubleFuncTest :: 2DoubleFuncTestcompile 2DoubleFuncTestinstall ;

ifdef cmt_2DoubleFuncTest_has_prototypes

2DoubleFuncTestprototype : $(2DoubleFuncTestprototype_dependencies) $(cmt_local_2DoubleFuncTest_makefile) dirs 2DoubleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

2DoubleFuncTestcompile : 2DoubleFuncTestprototype

endif

2DoubleFuncTestcompile : $(2DoubleFuncTestcompile_dependencies) $(cmt_local_2DoubleFuncTest_makefile) dirs 2DoubleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: 2DoubleFuncTestclean ;

2DoubleFuncTestclean :: $(2DoubleFuncTestclean_dependencies) ##$(cmt_local_2DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTestclean

##	  /bin/rm -f $(cmt_local_2DoubleFuncTest_makefile) $(bin)2DoubleFuncTest_dependencies.make

install :: 2DoubleFuncTestinstall ;

2DoubleFuncTestinstall :: 2DoubleFuncTestcompile $(2DoubleFuncTest_dependencies) $(cmt_local_2DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : 2DoubleFuncTestuninstall

$(foreach d,$(2DoubleFuncTest_dependencies),$(eval $(d)uninstall_dependencies += 2DoubleFuncTestuninstall))

2DoubleFuncTestuninstall : $(2DoubleFuncTestuninstall_dependencies) ##$(cmt_local_2DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: 2DoubleFuncTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ 2DoubleFuncTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ 2DoubleFuncTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_2DoubleFuncTest_is_not_check_group = 1

#--------------------------------------

check :: 2DoubleFuncTestcheck
	$(echo) "(constituents.make) 2DoubleFuncTestcheck ok"
#	@echo "------> 2DoubleFuncTestcheck ok"

#2DoubleFuncTestcheck : 2DoubleFuncTest $(cmt_local_2DoubleFuncTest_makefile)
#2DoubleFuncTestcheck : $(cmt_local_2DoubleFuncTest_makefile)
ifdef cmt_2DoubleFuncTest_is_check_group
2DoubleFuncTestcheck : 2DoubleFuncTest
else
2DoubleFuncTestcheck :
endif
	@if test ! -f $(cmt_local_2DoubleFuncTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(2DoubleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_2DoubleFuncTest_makefile) 2DoubleFuncTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_2DoubleFuncTest_makefile) $@

#2DoubleFuncTestcheck ::
#	@echo "------> starting 2DoubleFuncTestcheck"
#	@$(cmtexe) build constituent_makefile 2DoubleFuncTest; $(MAKE) -f 2DoubleFuncTest.make build_strategy=keep_makefiles 2DoubleFuncTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_3DoubleFuncTest_has_no_target_tag = 1
cmt_3DoubleFuncTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_3DoubleFuncTest_has_target_tag

cmt_local_tagfile_3DoubleFuncTest = $(bin)$(GaudiGSL_tag)_3DoubleFuncTest.make
cmt_final_setup_3DoubleFuncTest = $(bin)setup_3DoubleFuncTest.make
cmt_local_3DoubleFuncTest_makefile = $(bin)3DoubleFuncTest.make

3DoubleFuncTest_extratags = -tag_add=target_3DoubleFuncTest

else

cmt_local_tagfile_3DoubleFuncTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_3DoubleFuncTest = $(bin)setup.make
cmt_local_3DoubleFuncTest_makefile = $(bin)3DoubleFuncTest.make

endif

not_3DoubleFuncTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(3DoubleFuncTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
3DoubleFuncTestdirs :
	@if test ! -d $(bin)3DoubleFuncTest; then $(mkdir) -p $(bin)3DoubleFuncTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)3DoubleFuncTest
else
3DoubleFuncTestdirs : ;
endif

ifdef cmt_3DoubleFuncTest_has_target_tag

ifndef QUICK
$(cmt_local_3DoubleFuncTest_makefile) : $(3DoubleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building 3DoubleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_config -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest
else
$(cmt_local_3DoubleFuncTest_makefile) : $(3DoubleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_3DoubleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_3DoubleFuncTest) ] || \
	  $(not_3DoubleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building 3DoubleFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_config -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_3DoubleFuncTest_makefile) : $(3DoubleFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building 3DoubleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)3DoubleFuncTest.in -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest
else
$(cmt_local_3DoubleFuncTest_makefile) : $(3DoubleFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)3DoubleFuncTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_3DoubleFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_3DoubleFuncTest) ] || \
	  $(not_3DoubleFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building 3DoubleFuncTest.make"; \
	  $(cmtexe) -f=$(bin)3DoubleFuncTest.in -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest

3DoubleFuncTest :: 3DoubleFuncTestcompile 3DoubleFuncTestinstall ;

ifdef cmt_3DoubleFuncTest_has_prototypes

3DoubleFuncTestprototype : $(3DoubleFuncTestprototype_dependencies) $(cmt_local_3DoubleFuncTest_makefile) dirs 3DoubleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

3DoubleFuncTestcompile : 3DoubleFuncTestprototype

endif

3DoubleFuncTestcompile : $(3DoubleFuncTestcompile_dependencies) $(cmt_local_3DoubleFuncTest_makefile) dirs 3DoubleFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: 3DoubleFuncTestclean ;

3DoubleFuncTestclean :: $(3DoubleFuncTestclean_dependencies) ##$(cmt_local_3DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTestclean

##	  /bin/rm -f $(cmt_local_3DoubleFuncTest_makefile) $(bin)3DoubleFuncTest_dependencies.make

install :: 3DoubleFuncTestinstall ;

3DoubleFuncTestinstall :: 3DoubleFuncTestcompile $(3DoubleFuncTest_dependencies) $(cmt_local_3DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : 3DoubleFuncTestuninstall

$(foreach d,$(3DoubleFuncTest_dependencies),$(eval $(d)uninstall_dependencies += 3DoubleFuncTestuninstall))

3DoubleFuncTestuninstall : $(3DoubleFuncTestuninstall_dependencies) ##$(cmt_local_3DoubleFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: 3DoubleFuncTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ 3DoubleFuncTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ 3DoubleFuncTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_3DoubleFuncTest_is_not_check_group = 1

#--------------------------------------

check :: 3DoubleFuncTestcheck
	$(echo) "(constituents.make) 3DoubleFuncTestcheck ok"
#	@echo "------> 3DoubleFuncTestcheck ok"

#3DoubleFuncTestcheck : 3DoubleFuncTest $(cmt_local_3DoubleFuncTest_makefile)
#3DoubleFuncTestcheck : $(cmt_local_3DoubleFuncTest_makefile)
ifdef cmt_3DoubleFuncTest_is_check_group
3DoubleFuncTestcheck : 3DoubleFuncTest
else
3DoubleFuncTestcheck :
endif
	@if test ! -f $(cmt_local_3DoubleFuncTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(3DoubleFuncTest_extratags) build constituent_makefile -out=$(cmt_local_3DoubleFuncTest_makefile) 3DoubleFuncTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_3DoubleFuncTest_makefile) $@

#3DoubleFuncTestcheck ::
#	@echo "------> starting 3DoubleFuncTestcheck"
#	@$(cmtexe) build constituent_makefile 3DoubleFuncTest; $(MAKE) -f 3DoubleFuncTest.make build_strategy=keep_makefiles 3DoubleFuncTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_PFuncTest_has_no_target_tag = 1
cmt_PFuncTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_PFuncTest_has_target_tag

cmt_local_tagfile_PFuncTest = $(bin)$(GaudiGSL_tag)_PFuncTest.make
cmt_final_setup_PFuncTest = $(bin)setup_PFuncTest.make
cmt_local_PFuncTest_makefile = $(bin)PFuncTest.make

PFuncTest_extratags = -tag_add=target_PFuncTest

else

cmt_local_tagfile_PFuncTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_PFuncTest = $(bin)setup.make
cmt_local_PFuncTest_makefile = $(bin)PFuncTest.make

endif

not_PFuncTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PFuncTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PFuncTestdirs :
	@if test ! -d $(bin)PFuncTest; then $(mkdir) -p $(bin)PFuncTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PFuncTest
else
PFuncTestdirs : ;
endif

ifdef cmt_PFuncTest_has_target_tag

ifndef QUICK
$(cmt_local_PFuncTest_makefile) : $(PFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(PFuncTest_extratags) build constituent_config -out=$(cmt_local_PFuncTest_makefile) PFuncTest
else
$(cmt_local_PFuncTest_makefile) : $(PFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_PFuncTest) ] || \
	  $(not_PFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PFuncTest.make"; \
	  $(cmtexe) -tag=$(tags) $(PFuncTest_extratags) build constituent_config -out=$(cmt_local_PFuncTest_makefile) PFuncTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PFuncTest_makefile) : $(PFuncTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PFuncTest.make"; \
	  $(cmtexe) -f=$(bin)PFuncTest.in -tag=$(tags) $(PFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PFuncTest_makefile) PFuncTest
else
$(cmt_local_PFuncTest_makefile) : $(PFuncTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PFuncTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PFuncTest) ] || \
	  [ ! -f $(cmt_final_setup_PFuncTest) ] || \
	  $(not_PFuncTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PFuncTest.make"; \
	  $(cmtexe) -f=$(bin)PFuncTest.in -tag=$(tags) $(PFuncTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PFuncTest_makefile) PFuncTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PFuncTest_extratags) build constituent_makefile -out=$(cmt_local_PFuncTest_makefile) PFuncTest

PFuncTest :: PFuncTestcompile PFuncTestinstall ;

ifdef cmt_PFuncTest_has_prototypes

PFuncTestprototype : $(PFuncTestprototype_dependencies) $(cmt_local_PFuncTest_makefile) dirs PFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_PFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

PFuncTestcompile : PFuncTestprototype

endif

PFuncTestcompile : $(PFuncTestcompile_dependencies) $(cmt_local_PFuncTest_makefile) dirs PFuncTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_PFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PFuncTestclean ;

PFuncTestclean :: $(PFuncTestclean_dependencies) ##$(cmt_local_PFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_PFuncTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PFuncTest_makefile) PFuncTestclean

##	  /bin/rm -f $(cmt_local_PFuncTest_makefile) $(bin)PFuncTest_dependencies.make

install :: PFuncTestinstall ;

PFuncTestinstall :: PFuncTestcompile $(PFuncTest_dependencies) $(cmt_local_PFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_PFuncTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PFuncTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PFuncTestuninstall

$(foreach d,$(PFuncTest_dependencies),$(eval $(d)uninstall_dependencies += PFuncTestuninstall))

PFuncTestuninstall : $(PFuncTestuninstall_dependencies) ##$(cmt_local_PFuncTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PFuncTest_makefile); then \
	  $(MAKE) -f $(cmt_local_PFuncTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PFuncTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PFuncTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PFuncTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PFuncTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_PFuncTest_is_not_check_group = 1

#--------------------------------------

check :: PFuncTestcheck
	$(echo) "(constituents.make) PFuncTestcheck ok"
#	@echo "------> PFuncTestcheck ok"

#PFuncTestcheck : PFuncTest $(cmt_local_PFuncTest_makefile)
#PFuncTestcheck : $(cmt_local_PFuncTest_makefile)
ifdef cmt_PFuncTest_is_check_group
PFuncTestcheck : PFuncTest
else
PFuncTestcheck :
endif
	@if test ! -f $(cmt_local_PFuncTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(PFuncTest_extratags) build constituent_makefile -out=$(cmt_local_PFuncTest_makefile) PFuncTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_PFuncTest_makefile) $@

#PFuncTestcheck ::
#	@echo "------> starting PFuncTestcheck"
#	@$(cmtexe) build constituent_makefile PFuncTest; $(MAKE) -f PFuncTest.make build_strategy=keep_makefiles PFuncTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_InterpTest_has_no_target_tag = 1
cmt_InterpTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_InterpTest_has_target_tag

cmt_local_tagfile_InterpTest = $(bin)$(GaudiGSL_tag)_InterpTest.make
cmt_final_setup_InterpTest = $(bin)setup_InterpTest.make
cmt_local_InterpTest_makefile = $(bin)InterpTest.make

InterpTest_extratags = -tag_add=target_InterpTest

else

cmt_local_tagfile_InterpTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_InterpTest = $(bin)setup.make
cmt_local_InterpTest_makefile = $(bin)InterpTest.make

endif

not_InterpTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(InterpTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
InterpTestdirs :
	@if test ! -d $(bin)InterpTest; then $(mkdir) -p $(bin)InterpTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)InterpTest
else
InterpTestdirs : ;
endif

ifdef cmt_InterpTest_has_target_tag

ifndef QUICK
$(cmt_local_InterpTest_makefile) : $(InterpTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building InterpTest.make"; \
	  $(cmtexe) -tag=$(tags) $(InterpTest_extratags) build constituent_config -out=$(cmt_local_InterpTest_makefile) InterpTest
else
$(cmt_local_InterpTest_makefile) : $(InterpTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_InterpTest) ] || \
	  [ ! -f $(cmt_final_setup_InterpTest) ] || \
	  $(not_InterpTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building InterpTest.make"; \
	  $(cmtexe) -tag=$(tags) $(InterpTest_extratags) build constituent_config -out=$(cmt_local_InterpTest_makefile) InterpTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_InterpTest_makefile) : $(InterpTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building InterpTest.make"; \
	  $(cmtexe) -f=$(bin)InterpTest.in -tag=$(tags) $(InterpTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_InterpTest_makefile) InterpTest
else
$(cmt_local_InterpTest_makefile) : $(InterpTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)InterpTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_InterpTest) ] || \
	  [ ! -f $(cmt_final_setup_InterpTest) ] || \
	  $(not_InterpTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building InterpTest.make"; \
	  $(cmtexe) -f=$(bin)InterpTest.in -tag=$(tags) $(InterpTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_InterpTest_makefile) InterpTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(InterpTest_extratags) build constituent_makefile -out=$(cmt_local_InterpTest_makefile) InterpTest

InterpTest :: InterpTestcompile InterpTestinstall ;

ifdef cmt_InterpTest_has_prototypes

InterpTestprototype : $(InterpTestprototype_dependencies) $(cmt_local_InterpTest_makefile) dirs InterpTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_InterpTest_makefile); then \
	  $(MAKE) -f $(cmt_local_InterpTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_InterpTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

InterpTestcompile : InterpTestprototype

endif

InterpTestcompile : $(InterpTestcompile_dependencies) $(cmt_local_InterpTest_makefile) dirs InterpTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_InterpTest_makefile); then \
	  $(MAKE) -f $(cmt_local_InterpTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_InterpTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: InterpTestclean ;

InterpTestclean :: $(InterpTestclean_dependencies) ##$(cmt_local_InterpTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_InterpTest_makefile); then \
	  $(MAKE) -f $(cmt_local_InterpTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_InterpTest_makefile) InterpTestclean

##	  /bin/rm -f $(cmt_local_InterpTest_makefile) $(bin)InterpTest_dependencies.make

install :: InterpTestinstall ;

InterpTestinstall :: InterpTestcompile $(InterpTest_dependencies) $(cmt_local_InterpTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_InterpTest_makefile); then \
	  $(MAKE) -f $(cmt_local_InterpTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_InterpTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : InterpTestuninstall

$(foreach d,$(InterpTest_dependencies),$(eval $(d)uninstall_dependencies += InterpTestuninstall))

InterpTestuninstall : $(InterpTestuninstall_dependencies) ##$(cmt_local_InterpTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_InterpTest_makefile); then \
	  $(MAKE) -f $(cmt_local_InterpTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_InterpTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: InterpTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ InterpTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ InterpTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_InterpTest_is_not_check_group = 1

#--------------------------------------

check :: InterpTestcheck
	$(echo) "(constituents.make) InterpTestcheck ok"
#	@echo "------> InterpTestcheck ok"

#InterpTestcheck : InterpTest $(cmt_local_InterpTest_makefile)
#InterpTestcheck : $(cmt_local_InterpTest_makefile)
ifdef cmt_InterpTest_is_check_group
InterpTestcheck : InterpTest
else
InterpTestcheck :
endif
	@if test ! -f $(cmt_local_InterpTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(InterpTest_extratags) build constituent_makefile -out=$(cmt_local_InterpTest_makefile) InterpTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_InterpTest_makefile) $@

#InterpTestcheck ::
#	@echo "------> starting InterpTestcheck"
#	@$(cmtexe) build constituent_makefile InterpTest; $(MAKE) -f InterpTest.make build_strategy=keep_makefiles InterpTestcheck

#-- end of check_application_header ------
#-- start of constituent_app_lib ------

cmt_GSLAdaptersTest_has_no_target_tag = 1
cmt_GSLAdaptersTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_GSLAdaptersTest_has_target_tag

cmt_local_tagfile_GSLAdaptersTest = $(bin)$(GaudiGSL_tag)_GSLAdaptersTest.make
cmt_final_setup_GSLAdaptersTest = $(bin)setup_GSLAdaptersTest.make
cmt_local_GSLAdaptersTest_makefile = $(bin)GSLAdaptersTest.make

GSLAdaptersTest_extratags = -tag_add=target_GSLAdaptersTest

else

cmt_local_tagfile_GSLAdaptersTest = $(bin)$(GaudiGSL_tag).make
cmt_final_setup_GSLAdaptersTest = $(bin)setup.make
cmt_local_GSLAdaptersTest_makefile = $(bin)GSLAdaptersTest.make

endif

not_GSLAdaptersTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GSLAdaptersTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GSLAdaptersTestdirs :
	@if test ! -d $(bin)GSLAdaptersTest; then $(mkdir) -p $(bin)GSLAdaptersTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GSLAdaptersTest
else
GSLAdaptersTestdirs : ;
endif

ifdef cmt_GSLAdaptersTest_has_target_tag

ifndef QUICK
$(cmt_local_GSLAdaptersTest_makefile) : $(GSLAdaptersTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GSLAdaptersTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_config -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest
else
$(cmt_local_GSLAdaptersTest_makefile) : $(GSLAdaptersTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GSLAdaptersTest) ] || \
	  [ ! -f $(cmt_final_setup_GSLAdaptersTest) ] || \
	  $(not_GSLAdaptersTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GSLAdaptersTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_config -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GSLAdaptersTest_makefile) : $(GSLAdaptersTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GSLAdaptersTest.make"; \
	  $(cmtexe) -f=$(bin)GSLAdaptersTest.in -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest
else
$(cmt_local_GSLAdaptersTest_makefile) : $(GSLAdaptersTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GSLAdaptersTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GSLAdaptersTest) ] || \
	  [ ! -f $(cmt_final_setup_GSLAdaptersTest) ] || \
	  $(not_GSLAdaptersTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GSLAdaptersTest.make"; \
	  $(cmtexe) -f=$(bin)GSLAdaptersTest.in -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_makefile -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest

GSLAdaptersTest :: GSLAdaptersTestcompile GSLAdaptersTestinstall ;

ifdef cmt_GSLAdaptersTest_has_prototypes

GSLAdaptersTestprototype : $(GSLAdaptersTestprototype_dependencies) $(cmt_local_GSLAdaptersTest_makefile) dirs GSLAdaptersTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

GSLAdaptersTestcompile : GSLAdaptersTestprototype

endif

GSLAdaptersTestcompile : $(GSLAdaptersTestcompile_dependencies) $(cmt_local_GSLAdaptersTest_makefile) dirs GSLAdaptersTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GSLAdaptersTestclean ;

GSLAdaptersTestclean :: $(GSLAdaptersTestclean_dependencies) ##$(cmt_local_GSLAdaptersTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTestclean

##	  /bin/rm -f $(cmt_local_GSLAdaptersTest_makefile) $(bin)GSLAdaptersTest_dependencies.make

install :: GSLAdaptersTestinstall ;

GSLAdaptersTestinstall :: GSLAdaptersTestcompile $(GSLAdaptersTest_dependencies) $(cmt_local_GSLAdaptersTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GSLAdaptersTestuninstall

$(foreach d,$(GSLAdaptersTest_dependencies),$(eval $(d)uninstall_dependencies += GSLAdaptersTestuninstall))

GSLAdaptersTestuninstall : $(GSLAdaptersTestuninstall_dependencies) ##$(cmt_local_GSLAdaptersTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GSLAdaptersTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GSLAdaptersTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GSLAdaptersTest done"
endif

#-- end of constituent_app_lib ------
#-- start of check_application_header ------

cmt_GSLAdaptersTest_is_not_check_group = 1

#--------------------------------------

check :: GSLAdaptersTestcheck
	$(echo) "(constituents.make) GSLAdaptersTestcheck ok"
#	@echo "------> GSLAdaptersTestcheck ok"

#GSLAdaptersTestcheck : GSLAdaptersTest $(cmt_local_GSLAdaptersTest_makefile)
#GSLAdaptersTestcheck : $(cmt_local_GSLAdaptersTest_makefile)
ifdef cmt_GSLAdaptersTest_is_check_group
GSLAdaptersTestcheck : GSLAdaptersTest
else
GSLAdaptersTestcheck :
endif
	@if test ! -f $(cmt_local_GSLAdaptersTest_makefile); then \
	  $(cmtexe) -tag=$(tags) $(GSLAdaptersTest_extratags) build constituent_makefile -out=$(cmt_local_GSLAdaptersTest_makefile) GSLAdaptersTest; \
	fi
	$(echo) "(constituents.make) Starting $@"
	@$(MAKE) -f $(cmt_local_GSLAdaptersTest_makefile) $@

#GSLAdaptersTestcheck ::
#	@echo "------> starting GSLAdaptersTestcheck"
#	@$(cmtexe) build constituent_makefile GSLAdaptersTest; $(MAKE) -f GSLAdaptersTest.make build_strategy=keep_makefiles GSLAdaptersTestcheck

#-- end of check_application_header ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiGSL_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiGSL_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiGSL_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiGSL_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiGSL_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiGSL_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiGSL_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiGSL_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiGSL_tag).make
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
