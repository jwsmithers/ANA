
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile = $(GaudiAlg_tag).make
cmt_local_tagfile = $(bin)$(GaudiAlg_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiAlg_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiAlg_tag).make
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

cmt_GaudiAlgLib_has_no_target_tag = 1
cmt_GaudiAlgLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAlgLib_has_target_tag

cmt_local_tagfile_GaudiAlgLib = $(bin)$(GaudiAlg_tag)_GaudiAlgLib.make
cmt_final_setup_GaudiAlgLib = $(bin)setup_GaudiAlgLib.make
cmt_local_GaudiAlgLib_makefile = $(bin)GaudiAlgLib.make

GaudiAlgLib_extratags = -tag_add=target_GaudiAlgLib

else

cmt_local_tagfile_GaudiAlgLib = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlgLib = $(bin)setup.make
cmt_local_GaudiAlgLib_makefile = $(bin)GaudiAlgLib.make

endif

not_GaudiAlgLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgLibdirs :
	@if test ! -d $(bin)GaudiAlgLib; then $(mkdir) -p $(bin)GaudiAlgLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlgLib
else
GaudiAlgLibdirs : ;
endif

ifdef cmt_GaudiAlgLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlgLib_makefile) : $(GaudiAlgLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgLib_extratags) build constituent_config -out=$(cmt_local_GaudiAlgLib_makefile) GaudiAlgLib
else
$(cmt_local_GaudiAlgLib_makefile) : $(GaudiAlgLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgLib) ] || \
	  $(not_GaudiAlgLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgLib_extratags) build constituent_config -out=$(cmt_local_GaudiAlgLib_makefile) GaudiAlgLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlgLib_makefile) : $(GaudiAlgLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgLib.in -tag=$(tags) $(GaudiAlgLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgLib_makefile) GaudiAlgLib
else
$(cmt_local_GaudiAlgLib_makefile) : $(GaudiAlgLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlgLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgLib) ] || \
	  $(not_GaudiAlgLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgLib.in -tag=$(tags) $(GaudiAlgLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgLib_makefile) GaudiAlgLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlgLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlgLib_makefile) GaudiAlgLib

GaudiAlgLib :: GaudiAlgLibcompile GaudiAlgLibinstall ;

ifdef cmt_GaudiAlgLib_has_prototypes

GaudiAlgLibprototype : $(GaudiAlgLibprototype_dependencies) $(cmt_local_GaudiAlgLib_makefile) dirs GaudiAlgLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiAlgLibcompile : GaudiAlgLibprototype

endif

GaudiAlgLibcompile : $(GaudiAlgLibcompile_dependencies) $(cmt_local_GaudiAlgLib_makefile) dirs GaudiAlgLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiAlgLibclean ;

GaudiAlgLibclean :: $(GaudiAlgLibclean_dependencies) ##$(cmt_local_GaudiAlgLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) GaudiAlgLibclean

##	  /bin/rm -f $(cmt_local_GaudiAlgLib_makefile) $(bin)GaudiAlgLib_dependencies.make

install :: GaudiAlgLibinstall ;

GaudiAlgLibinstall :: GaudiAlgLibcompile $(GaudiAlgLib_dependencies) $(cmt_local_GaudiAlgLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlgLibuninstall

$(foreach d,$(GaudiAlgLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlgLibuninstall))

GaudiAlgLibuninstall : $(GaudiAlgLibuninstall_dependencies) ##$(cmt_local_GaudiAlgLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlgLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlgLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlgLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiAlg_has_no_target_tag = 1
cmt_GaudiAlg_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiAlg_has_target_tag

cmt_local_tagfile_GaudiAlg = $(bin)$(GaudiAlg_tag)_GaudiAlg.make
cmt_final_setup_GaudiAlg = $(bin)setup_GaudiAlg.make
cmt_local_GaudiAlg_makefile = $(bin)GaudiAlg.make

GaudiAlg_extratags = -tag_add=target_GaudiAlg

else

cmt_local_tagfile_GaudiAlg = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlg = $(bin)setup.make
cmt_local_GaudiAlg_makefile = $(bin)GaudiAlg.make

endif

not_GaudiAlgcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgdirs :
	@if test ! -d $(bin)GaudiAlg; then $(mkdir) -p $(bin)GaudiAlg; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlg
else
GaudiAlgdirs : ;
endif

ifdef cmt_GaudiAlg_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlg_makefile) : $(GaudiAlgcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlg.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlg_extratags) build constituent_config -out=$(cmt_local_GaudiAlg_makefile) GaudiAlg
else
$(cmt_local_GaudiAlg_makefile) : $(GaudiAlgcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlg) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlg) ] || \
	  $(not_GaudiAlgcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlg.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlg_extratags) build constituent_config -out=$(cmt_local_GaudiAlg_makefile) GaudiAlg; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlg_makefile) : $(GaudiAlgcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlg.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlg.in -tag=$(tags) $(GaudiAlg_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlg_makefile) GaudiAlg
else
$(cmt_local_GaudiAlg_makefile) : $(GaudiAlgcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlg.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlg) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlg) ] || \
	  $(not_GaudiAlgcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlg.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlg.in -tag=$(tags) $(GaudiAlg_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlg_makefile) GaudiAlg; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlg_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlg_makefile) GaudiAlg

GaudiAlg :: GaudiAlgcompile GaudiAlginstall ;

ifdef cmt_GaudiAlg_has_prototypes

GaudiAlgprototype : $(GaudiAlgprototype_dependencies) $(cmt_local_GaudiAlg_makefile) dirs GaudiAlgdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiAlgcompile : GaudiAlgprototype

endif

GaudiAlgcompile : $(GaudiAlgcompile_dependencies) $(cmt_local_GaudiAlg_makefile) dirs GaudiAlgdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiAlgclean ;

GaudiAlgclean :: $(GaudiAlgclean_dependencies) ##$(cmt_local_GaudiAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlg_makefile) GaudiAlgclean

##	  /bin/rm -f $(cmt_local_GaudiAlg_makefile) $(bin)GaudiAlg_dependencies.make

install :: GaudiAlginstall ;

GaudiAlginstall :: GaudiAlgcompile $(GaudiAlg_dependencies) $(cmt_local_GaudiAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlguninstall

$(foreach d,$(GaudiAlg_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlguninstall))

GaudiAlguninstall : $(GaudiAlguninstall_dependencies) ##$(cmt_local_GaudiAlg_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlg_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlg"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlg done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiAlgComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAlgComponentsList_has_target_tag

cmt_local_tagfile_GaudiAlgComponentsList = $(bin)$(GaudiAlg_tag)_GaudiAlgComponentsList.make
cmt_final_setup_GaudiAlgComponentsList = $(bin)setup_GaudiAlgComponentsList.make
cmt_local_GaudiAlgComponentsList_makefile = $(bin)GaudiAlgComponentsList.make

GaudiAlgComponentsList_extratags = -tag_add=target_GaudiAlgComponentsList

else

cmt_local_tagfile_GaudiAlgComponentsList = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlgComponentsList = $(bin)setup.make
cmt_local_GaudiAlgComponentsList_makefile = $(bin)GaudiAlgComponentsList.make

endif

not_GaudiAlgComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgComponentsListdirs :
	@if test ! -d $(bin)GaudiAlgComponentsList; then $(mkdir) -p $(bin)GaudiAlgComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlgComponentsList
else
GaudiAlgComponentsListdirs : ;
endif

ifdef cmt_GaudiAlgComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlgComponentsList_makefile) : $(GaudiAlgComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList
else
$(cmt_local_GaudiAlgComponentsList_makefile) : $(GaudiAlgComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgComponentsList) ] || \
	  $(not_GaudiAlgComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlgComponentsList_makefile) : $(GaudiAlgComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgComponentsList.in -tag=$(tags) $(GaudiAlgComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList
else
$(cmt_local_GaudiAlgComponentsList_makefile) : $(GaudiAlgComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlgComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgComponentsList) ] || \
	  $(not_GaudiAlgComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgComponentsList.in -tag=$(tags) $(GaudiAlgComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlgComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList

GaudiAlgComponentsList :: $(GaudiAlgComponentsList_dependencies) $(cmt_local_GaudiAlgComponentsList_makefile) dirs GaudiAlgComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiAlgComponentsList"
	@if test -f $(cmt_local_GaudiAlgComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsList
	$(echo) "(constituents.make) GaudiAlgComponentsList done"

clean :: GaudiAlgComponentsListclean ;

GaudiAlgComponentsListclean :: $(GaudiAlgComponentsListclean_dependencies) ##$(cmt_local_GaudiAlgComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiAlgComponentsListclean"
	@-if test -f $(cmt_local_GaudiAlgComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiAlgComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) GaudiAlgComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiAlgComponentsList_makefile) $(bin)GaudiAlgComponentsList_dependencies.make

install :: GaudiAlgComponentsListinstall ;

GaudiAlgComponentsListinstall :: $(GaudiAlgComponentsList_dependencies) $(cmt_local_GaudiAlgComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlgComponentsListuninstall

$(foreach d,$(GaudiAlgComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlgComponentsListuninstall))

GaudiAlgComponentsListuninstall : $(GaudiAlgComponentsListuninstall_dependencies) ##$(cmt_local_GaudiAlgComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlgComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlgComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlgComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAlgMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAlgMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiAlgMergeComponentsList = $(bin)$(GaudiAlg_tag)_GaudiAlgMergeComponentsList.make
cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)setup_GaudiAlgMergeComponentsList.make
cmt_local_GaudiAlgMergeComponentsList_makefile = $(bin)GaudiAlgMergeComponentsList.make

GaudiAlgMergeComponentsList_extratags = -tag_add=target_GaudiAlgMergeComponentsList

else

cmt_local_tagfile_GaudiAlgMergeComponentsList = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)setup.make
cmt_local_GaudiAlgMergeComponentsList_makefile = $(bin)GaudiAlgMergeComponentsList.make

endif

not_GaudiAlgMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiAlgMergeComponentsList; then $(mkdir) -p $(bin)GaudiAlgMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlgMergeComponentsList
else
GaudiAlgMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiAlgMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlgMergeComponentsList_makefile) : $(GaudiAlgMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList
else
$(cmt_local_GaudiAlgMergeComponentsList_makefile) : $(GaudiAlgMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgMergeComponentsList) ] || \
	  $(not_GaudiAlgMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlgMergeComponentsList_makefile) : $(GaudiAlgMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgMergeComponentsList.in -tag=$(tags) $(GaudiAlgMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList
else
$(cmt_local_GaudiAlgMergeComponentsList_makefile) : $(GaudiAlgMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlgMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgMergeComponentsList) ] || \
	  $(not_GaudiAlgMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgMergeComponentsList.in -tag=$(tags) $(GaudiAlgMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlgMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList

GaudiAlgMergeComponentsList :: $(GaudiAlgMergeComponentsList_dependencies) $(cmt_local_GaudiAlgMergeComponentsList_makefile) dirs GaudiAlgMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiAlgMergeComponentsList"
	@if test -f $(cmt_local_GaudiAlgMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsList
	$(echo) "(constituents.make) GaudiAlgMergeComponentsList done"

clean :: GaudiAlgMergeComponentsListclean ;

GaudiAlgMergeComponentsListclean :: $(GaudiAlgMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiAlgMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiAlgMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiAlgMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiAlgMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) GaudiAlgMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) $(bin)GaudiAlgMergeComponentsList_dependencies.make

install :: GaudiAlgMergeComponentsListinstall ;

GaudiAlgMergeComponentsListinstall :: $(GaudiAlgMergeComponentsList_dependencies) $(cmt_local_GaudiAlgMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlgMergeComponentsListuninstall

$(foreach d,$(GaudiAlgMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlgMergeComponentsListuninstall))

GaudiAlgMergeComponentsListuninstall : $(GaudiAlgMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiAlgMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlgMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlgMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlgMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAlgConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAlgConf_has_target_tag

cmt_local_tagfile_GaudiAlgConf = $(bin)$(GaudiAlg_tag)_GaudiAlgConf.make
cmt_final_setup_GaudiAlgConf = $(bin)setup_GaudiAlgConf.make
cmt_local_GaudiAlgConf_makefile = $(bin)GaudiAlgConf.make

GaudiAlgConf_extratags = -tag_add=target_GaudiAlgConf

else

cmt_local_tagfile_GaudiAlgConf = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlgConf = $(bin)setup.make
cmt_local_GaudiAlgConf_makefile = $(bin)GaudiAlgConf.make

endif

not_GaudiAlgConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgConfdirs :
	@if test ! -d $(bin)GaudiAlgConf; then $(mkdir) -p $(bin)GaudiAlgConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlgConf
else
GaudiAlgConfdirs : ;
endif

ifdef cmt_GaudiAlgConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlgConf_makefile) : $(GaudiAlgConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgConf_extratags) build constituent_config -out=$(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf
else
$(cmt_local_GaudiAlgConf_makefile) : $(GaudiAlgConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgConf) ] || \
	  $(not_GaudiAlgConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgConf_extratags) build constituent_config -out=$(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlgConf_makefile) : $(GaudiAlgConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgConf.in -tag=$(tags) $(GaudiAlgConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf
else
$(cmt_local_GaudiAlgConf_makefile) : $(GaudiAlgConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlgConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgConf) ] || \
	  $(not_GaudiAlgConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgConf.in -tag=$(tags) $(GaudiAlgConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlgConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf

GaudiAlgConf :: $(GaudiAlgConf_dependencies) $(cmt_local_GaudiAlgConf_makefile) dirs GaudiAlgConfdirs
	$(echo) "(constituents.make) Starting GaudiAlgConf"
	@if test -f $(cmt_local_GaudiAlgConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) GaudiAlgConf
	$(echo) "(constituents.make) GaudiAlgConf done"

clean :: GaudiAlgConfclean ;

GaudiAlgConfclean :: $(GaudiAlgConfclean_dependencies) ##$(cmt_local_GaudiAlgConf_makefile)
	$(echo) "(constituents.make) Starting GaudiAlgConfclean"
	@-if test -f $(cmt_local_GaudiAlgConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) GaudiAlgConfclean; \
	fi
	$(echo) "(constituents.make) GaudiAlgConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) GaudiAlgConfclean

##	  /bin/rm -f $(cmt_local_GaudiAlgConf_makefile) $(bin)GaudiAlgConf_dependencies.make

install :: GaudiAlgConfinstall ;

GaudiAlgConfinstall :: $(GaudiAlgConf_dependencies) $(cmt_local_GaudiAlgConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlgConfuninstall

$(foreach d,$(GaudiAlgConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlgConfuninstall))

GaudiAlgConfuninstall : $(GaudiAlgConfuninstall_dependencies) ##$(cmt_local_GaudiAlgConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlgConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlgConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlgConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAlg_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAlg_python_init_has_target_tag

cmt_local_tagfile_GaudiAlg_python_init = $(bin)$(GaudiAlg_tag)_GaudiAlg_python_init.make
cmt_final_setup_GaudiAlg_python_init = $(bin)setup_GaudiAlg_python_init.make
cmt_local_GaudiAlg_python_init_makefile = $(bin)GaudiAlg_python_init.make

GaudiAlg_python_init_extratags = -tag_add=target_GaudiAlg_python_init

else

cmt_local_tagfile_GaudiAlg_python_init = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlg_python_init = $(bin)setup.make
cmt_local_GaudiAlg_python_init_makefile = $(bin)GaudiAlg_python_init.make

endif

not_GaudiAlg_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlg_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlg_python_initdirs :
	@if test ! -d $(bin)GaudiAlg_python_init; then $(mkdir) -p $(bin)GaudiAlg_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlg_python_init
else
GaudiAlg_python_initdirs : ;
endif

ifdef cmt_GaudiAlg_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlg_python_init_makefile) : $(GaudiAlg_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlg_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlg_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init
else
$(cmt_local_GaudiAlg_python_init_makefile) : $(GaudiAlg_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlg_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlg_python_init) ] || \
	  $(not_GaudiAlg_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlg_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlg_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlg_python_init_makefile) : $(GaudiAlg_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlg_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlg_python_init.in -tag=$(tags) $(GaudiAlg_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init
else
$(cmt_local_GaudiAlg_python_init_makefile) : $(GaudiAlg_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlg_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlg_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlg_python_init) ] || \
	  $(not_GaudiAlg_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlg_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlg_python_init.in -tag=$(tags) $(GaudiAlg_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlg_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init

GaudiAlg_python_init :: $(GaudiAlg_python_init_dependencies) $(cmt_local_GaudiAlg_python_init_makefile) dirs GaudiAlg_python_initdirs
	$(echo) "(constituents.make) Starting GaudiAlg_python_init"
	@if test -f $(cmt_local_GaudiAlg_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_init
	$(echo) "(constituents.make) GaudiAlg_python_init done"

clean :: GaudiAlg_python_initclean ;

GaudiAlg_python_initclean :: $(GaudiAlg_python_initclean_dependencies) ##$(cmt_local_GaudiAlg_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiAlg_python_initclean"
	@-if test -f $(cmt_local_GaudiAlg_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiAlg_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) GaudiAlg_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiAlg_python_init_makefile) $(bin)GaudiAlg_python_init_dependencies.make

install :: GaudiAlg_python_initinstall ;

GaudiAlg_python_initinstall :: $(GaudiAlg_python_init_dependencies) $(cmt_local_GaudiAlg_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlg_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlg_python_inituninstall

$(foreach d,$(GaudiAlg_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlg_python_inituninstall))

GaudiAlg_python_inituninstall : $(GaudiAlg_python_inituninstall_dependencies) ##$(cmt_local_GaudiAlg_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlg_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlg_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlg_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlg_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlg_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiAlg_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiAlg_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiAlg_python_modules = $(bin)$(GaudiAlg_tag)_zip_GaudiAlg_python_modules.make
cmt_final_setup_zip_GaudiAlg_python_modules = $(bin)setup_zip_GaudiAlg_python_modules.make
cmt_local_zip_GaudiAlg_python_modules_makefile = $(bin)zip_GaudiAlg_python_modules.make

zip_GaudiAlg_python_modules_extratags = -tag_add=target_zip_GaudiAlg_python_modules

else

cmt_local_tagfile_zip_GaudiAlg_python_modules = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_zip_GaudiAlg_python_modules = $(bin)setup.make
cmt_local_zip_GaudiAlg_python_modules_makefile = $(bin)zip_GaudiAlg_python_modules.make

endif

not_zip_GaudiAlg_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiAlg_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiAlg_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiAlg_python_modules; then $(mkdir) -p $(bin)zip_GaudiAlg_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiAlg_python_modules
else
zip_GaudiAlg_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiAlg_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiAlg_python_modules_makefile) : $(zip_GaudiAlg_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiAlg_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiAlg_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules
else
$(cmt_local_zip_GaudiAlg_python_modules_makefile) : $(zip_GaudiAlg_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiAlg_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiAlg_python_modules) ] || \
	  $(not_zip_GaudiAlg_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiAlg_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiAlg_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiAlg_python_modules_makefile) : $(zip_GaudiAlg_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiAlg_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiAlg_python_modules.in -tag=$(tags) $(zip_GaudiAlg_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules
else
$(cmt_local_zip_GaudiAlg_python_modules_makefile) : $(zip_GaudiAlg_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiAlg_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiAlg_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiAlg_python_modules) ] || \
	  $(not_zip_GaudiAlg_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiAlg_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiAlg_python_modules.in -tag=$(tags) $(zip_GaudiAlg_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiAlg_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules

zip_GaudiAlg_python_modules :: $(zip_GaudiAlg_python_modules_dependencies) $(cmt_local_zip_GaudiAlg_python_modules_makefile) dirs zip_GaudiAlg_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiAlg_python_modules"
	@if test -f $(cmt_local_zip_GaudiAlg_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modules
	$(echo) "(constituents.make) zip_GaudiAlg_python_modules done"

clean :: zip_GaudiAlg_python_modulesclean ;

zip_GaudiAlg_python_modulesclean :: $(zip_GaudiAlg_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiAlg_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiAlg_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiAlg_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiAlg_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) zip_GaudiAlg_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) $(bin)zip_GaudiAlg_python_modules_dependencies.make

install :: zip_GaudiAlg_python_modulesinstall ;

zip_GaudiAlg_python_modulesinstall :: $(zip_GaudiAlg_python_modules_dependencies) $(cmt_local_zip_GaudiAlg_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiAlg_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiAlg_python_modulesuninstall

$(foreach d,$(zip_GaudiAlg_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiAlg_python_modulesuninstall))

zip_GaudiAlg_python_modulesuninstall : $(zip_GaudiAlg_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiAlg_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiAlg_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiAlg_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiAlg_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiAlg_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiAlg_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiAlgConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiAlgConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiAlgConfDbMerge = $(bin)$(GaudiAlg_tag)_GaudiAlgConfDbMerge.make
cmt_final_setup_GaudiAlgConfDbMerge = $(bin)setup_GaudiAlgConfDbMerge.make
cmt_local_GaudiAlgConfDbMerge_makefile = $(bin)GaudiAlgConfDbMerge.make

GaudiAlgConfDbMerge_extratags = -tag_add=target_GaudiAlgConfDbMerge

else

cmt_local_tagfile_GaudiAlgConfDbMerge = $(bin)$(GaudiAlg_tag).make
cmt_final_setup_GaudiAlgConfDbMerge = $(bin)setup.make
cmt_local_GaudiAlgConfDbMerge_makefile = $(bin)GaudiAlgConfDbMerge.make

endif

not_GaudiAlgConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiAlgConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiAlgConfDbMergedirs :
	@if test ! -d $(bin)GaudiAlgConfDbMerge; then $(mkdir) -p $(bin)GaudiAlgConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiAlgConfDbMerge
else
GaudiAlgConfDbMergedirs : ;
endif

ifdef cmt_GaudiAlgConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiAlgConfDbMerge_makefile) : $(GaudiAlgConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge
else
$(cmt_local_GaudiAlgConfDbMerge_makefile) : $(GaudiAlgConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgConfDbMerge) ] || \
	  $(not_GaudiAlgConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiAlgConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiAlgConfDbMerge_makefile) : $(GaudiAlgConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiAlgConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgConfDbMerge.in -tag=$(tags) $(GaudiAlgConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge
else
$(cmt_local_GaudiAlgConfDbMerge_makefile) : $(GaudiAlgConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiAlgConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiAlgConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiAlgConfDbMerge) ] || \
	  $(not_GaudiAlgConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiAlgConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiAlgConfDbMerge.in -tag=$(tags) $(GaudiAlgConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiAlgConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge

GaudiAlgConfDbMerge :: $(GaudiAlgConfDbMerge_dependencies) $(cmt_local_GaudiAlgConfDbMerge_makefile) dirs GaudiAlgConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiAlgConfDbMerge"
	@if test -f $(cmt_local_GaudiAlgConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMerge
	$(echo) "(constituents.make) GaudiAlgConfDbMerge done"

clean :: GaudiAlgConfDbMergeclean ;

GaudiAlgConfDbMergeclean :: $(GaudiAlgConfDbMergeclean_dependencies) ##$(cmt_local_GaudiAlgConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiAlgConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiAlgConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiAlgConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) GaudiAlgConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiAlgConfDbMerge_makefile) $(bin)GaudiAlgConfDbMerge_dependencies.make

install :: GaudiAlgConfDbMergeinstall ;

GaudiAlgConfDbMergeinstall :: $(GaudiAlgConfDbMerge_dependencies) $(cmt_local_GaudiAlgConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiAlgConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiAlgConfDbMergeuninstall

$(foreach d,$(GaudiAlgConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiAlgConfDbMergeuninstall))

GaudiAlgConfDbMergeuninstall : $(GaudiAlgConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiAlgConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiAlgConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiAlgConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiAlgConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiAlgConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiAlgConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiAlg_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiAlg_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiAlg_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiAlg_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiAlg_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiAlg_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiAlg_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiAlg_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiAlg_tag).make
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
