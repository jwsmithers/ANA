
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile = $(GaudiUtils_tag).make
cmt_local_tagfile = $(bin)$(GaudiUtils_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiUtils_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiUtils_tag).make
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

cmt_GaudiUtilsLib_has_no_target_tag = 1
cmt_GaudiUtilsLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiUtilsLib_has_target_tag

cmt_local_tagfile_GaudiUtilsLib = $(bin)$(GaudiUtils_tag)_GaudiUtilsLib.make
cmt_final_setup_GaudiUtilsLib = $(bin)setup_GaudiUtilsLib.make
cmt_local_GaudiUtilsLib_makefile = $(bin)GaudiUtilsLib.make

GaudiUtilsLib_extratags = -tag_add=target_GaudiUtilsLib

else

cmt_local_tagfile_GaudiUtilsLib = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtilsLib = $(bin)setup.make
cmt_local_GaudiUtilsLib_makefile = $(bin)GaudiUtilsLib.make

endif

not_GaudiUtilsLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilsLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsLibdirs :
	@if test ! -d $(bin)GaudiUtilsLib; then $(mkdir) -p $(bin)GaudiUtilsLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtilsLib
else
GaudiUtilsLibdirs : ;
endif

ifdef cmt_GaudiUtilsLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtilsLib_makefile) : $(GaudiUtilsLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsLib_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLib
else
$(cmt_local_GaudiUtilsLib_makefile) : $(GaudiUtilsLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsLib) ] || \
	  $(not_GaudiUtilsLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsLib_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtilsLib_makefile) : $(GaudiUtilsLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsLib.in -tag=$(tags) $(GaudiUtilsLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLib
else
$(cmt_local_GaudiUtilsLib_makefile) : $(GaudiUtilsLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtilsLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsLib) ] || \
	  $(not_GaudiUtilsLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsLib.in -tag=$(tags) $(GaudiUtilsLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtilsLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLib

GaudiUtilsLib :: GaudiUtilsLibcompile GaudiUtilsLibinstall ;

ifdef cmt_GaudiUtilsLib_has_prototypes

GaudiUtilsLibprototype : $(GaudiUtilsLibprototype_dependencies) $(cmt_local_GaudiUtilsLib_makefile) dirs GaudiUtilsLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiUtilsLibcompile : GaudiUtilsLibprototype

endif

GaudiUtilsLibcompile : $(GaudiUtilsLibcompile_dependencies) $(cmt_local_GaudiUtilsLib_makefile) dirs GaudiUtilsLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiUtilsLibclean ;

GaudiUtilsLibclean :: $(GaudiUtilsLibclean_dependencies) ##$(cmt_local_GaudiUtilsLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) GaudiUtilsLibclean

##	  /bin/rm -f $(cmt_local_GaudiUtilsLib_makefile) $(bin)GaudiUtilsLib_dependencies.make

install :: GaudiUtilsLibinstall ;

GaudiUtilsLibinstall :: GaudiUtilsLibcompile $(GaudiUtilsLib_dependencies) $(cmt_local_GaudiUtilsLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsLibuninstall

$(foreach d,$(GaudiUtilsLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsLibuninstall))

GaudiUtilsLibuninstall : $(GaudiUtilsLibuninstall_dependencies) ##$(cmt_local_GaudiUtilsLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtilsLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtilsLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiUtils_has_no_target_tag = 1
cmt_GaudiUtils_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiUtils_has_target_tag

cmt_local_tagfile_GaudiUtils = $(bin)$(GaudiUtils_tag)_GaudiUtils.make
cmt_final_setup_GaudiUtils = $(bin)setup_GaudiUtils.make
cmt_local_GaudiUtils_makefile = $(bin)GaudiUtils.make

GaudiUtils_extratags = -tag_add=target_GaudiUtils

else

cmt_local_tagfile_GaudiUtils = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtils = $(bin)setup.make
cmt_local_GaudiUtils_makefile = $(bin)GaudiUtils.make

endif

not_GaudiUtilscompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilscompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsdirs :
	@if test ! -d $(bin)GaudiUtils; then $(mkdir) -p $(bin)GaudiUtils; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtils
else
GaudiUtilsdirs : ;
endif

ifdef cmt_GaudiUtils_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtils_makefile) : $(GaudiUtilscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtils.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtils_extratags) build constituent_config -out=$(cmt_local_GaudiUtils_makefile) GaudiUtils
else
$(cmt_local_GaudiUtils_makefile) : $(GaudiUtilscompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtils) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtils) ] || \
	  $(not_GaudiUtilscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtils.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtils_extratags) build constituent_config -out=$(cmt_local_GaudiUtils_makefile) GaudiUtils; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtils_makefile) : $(GaudiUtilscompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtils.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtils.in -tag=$(tags) $(GaudiUtils_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtils_makefile) GaudiUtils
else
$(cmt_local_GaudiUtils_makefile) : $(GaudiUtilscompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtils.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtils) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtils) ] || \
	  $(not_GaudiUtilscompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtils.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtils.in -tag=$(tags) $(GaudiUtils_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtils_makefile) GaudiUtils; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtils_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtils_makefile) GaudiUtils

GaudiUtils :: GaudiUtilscompile GaudiUtilsinstall ;

ifdef cmt_GaudiUtils_has_prototypes

GaudiUtilsprototype : $(GaudiUtilsprototype_dependencies) $(cmt_local_GaudiUtils_makefile) dirs GaudiUtilsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtils_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiUtilscompile : GaudiUtilsprototype

endif

GaudiUtilscompile : $(GaudiUtilscompile_dependencies) $(cmt_local_GaudiUtils_makefile) dirs GaudiUtilsdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtils_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiUtilsclean ;

GaudiUtilsclean :: $(GaudiUtilsclean_dependencies) ##$(cmt_local_GaudiUtils_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtils_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtils_makefile) GaudiUtilsclean

##	  /bin/rm -f $(cmt_local_GaudiUtils_makefile) $(bin)GaudiUtils_dependencies.make

install :: GaudiUtilsinstall ;

GaudiUtilsinstall :: GaudiUtilscompile $(GaudiUtils_dependencies) $(cmt_local_GaudiUtils_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtils_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsuninstall

$(foreach d,$(GaudiUtils_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsuninstall))

GaudiUtilsuninstall : $(GaudiUtilsuninstall_dependencies) ##$(cmt_local_GaudiUtils_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtils_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtils"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtils done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiUtilsComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiUtilsComponentsList_has_target_tag

cmt_local_tagfile_GaudiUtilsComponentsList = $(bin)$(GaudiUtils_tag)_GaudiUtilsComponentsList.make
cmt_final_setup_GaudiUtilsComponentsList = $(bin)setup_GaudiUtilsComponentsList.make
cmt_local_GaudiUtilsComponentsList_makefile = $(bin)GaudiUtilsComponentsList.make

GaudiUtilsComponentsList_extratags = -tag_add=target_GaudiUtilsComponentsList

else

cmt_local_tagfile_GaudiUtilsComponentsList = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtilsComponentsList = $(bin)setup.make
cmt_local_GaudiUtilsComponentsList_makefile = $(bin)GaudiUtilsComponentsList.make

endif

not_GaudiUtilsComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilsComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsComponentsListdirs :
	@if test ! -d $(bin)GaudiUtilsComponentsList; then $(mkdir) -p $(bin)GaudiUtilsComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtilsComponentsList
else
GaudiUtilsComponentsListdirs : ;
endif

ifdef cmt_GaudiUtilsComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtilsComponentsList_makefile) : $(GaudiUtilsComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList
else
$(cmt_local_GaudiUtilsComponentsList_makefile) : $(GaudiUtilsComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsComponentsList) ] || \
	  $(not_GaudiUtilsComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtilsComponentsList_makefile) : $(GaudiUtilsComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsComponentsList.in -tag=$(tags) $(GaudiUtilsComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList
else
$(cmt_local_GaudiUtilsComponentsList_makefile) : $(GaudiUtilsComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtilsComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsComponentsList) ] || \
	  $(not_GaudiUtilsComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsComponentsList.in -tag=$(tags) $(GaudiUtilsComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtilsComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList

GaudiUtilsComponentsList :: $(GaudiUtilsComponentsList_dependencies) $(cmt_local_GaudiUtilsComponentsList_makefile) dirs GaudiUtilsComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiUtilsComponentsList"
	@if test -f $(cmt_local_GaudiUtilsComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsList
	$(echo) "(constituents.make) GaudiUtilsComponentsList done"

clean :: GaudiUtilsComponentsListclean ;

GaudiUtilsComponentsListclean :: $(GaudiUtilsComponentsListclean_dependencies) ##$(cmt_local_GaudiUtilsComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiUtilsComponentsListclean"
	@-if test -f $(cmt_local_GaudiUtilsComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiUtilsComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) GaudiUtilsComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiUtilsComponentsList_makefile) $(bin)GaudiUtilsComponentsList_dependencies.make

install :: GaudiUtilsComponentsListinstall ;

GaudiUtilsComponentsListinstall :: $(GaudiUtilsComponentsList_dependencies) $(cmt_local_GaudiUtilsComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsComponentsListuninstall

$(foreach d,$(GaudiUtilsComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsComponentsListuninstall))

GaudiUtilsComponentsListuninstall : $(GaudiUtilsComponentsListuninstall_dependencies) ##$(cmt_local_GaudiUtilsComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtilsComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtilsComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiUtilsMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiUtilsMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(bin)$(GaudiUtils_tag)_GaudiUtilsMergeComponentsList.make
cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)setup_GaudiUtilsMergeComponentsList.make
cmt_local_GaudiUtilsMergeComponentsList_makefile = $(bin)GaudiUtilsMergeComponentsList.make

GaudiUtilsMergeComponentsList_extratags = -tag_add=target_GaudiUtilsMergeComponentsList

else

cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)setup.make
cmt_local_GaudiUtilsMergeComponentsList_makefile = $(bin)GaudiUtilsMergeComponentsList.make

endif

not_GaudiUtilsMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilsMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiUtilsMergeComponentsList; then $(mkdir) -p $(bin)GaudiUtilsMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtilsMergeComponentsList
else
GaudiUtilsMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiUtilsMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtilsMergeComponentsList_makefile) : $(GaudiUtilsMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList
else
$(cmt_local_GaudiUtilsMergeComponentsList_makefile) : $(GaudiUtilsMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsMergeComponentsList) ] || \
	  $(not_GaudiUtilsMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtilsMergeComponentsList_makefile) : $(GaudiUtilsMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsMergeComponentsList.in -tag=$(tags) $(GaudiUtilsMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList
else
$(cmt_local_GaudiUtilsMergeComponentsList_makefile) : $(GaudiUtilsMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtilsMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsMergeComponentsList) ] || \
	  $(not_GaudiUtilsMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsMergeComponentsList.in -tag=$(tags) $(GaudiUtilsMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtilsMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList

GaudiUtilsMergeComponentsList :: $(GaudiUtilsMergeComponentsList_dependencies) $(cmt_local_GaudiUtilsMergeComponentsList_makefile) dirs GaudiUtilsMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiUtilsMergeComponentsList"
	@if test -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsList
	$(echo) "(constituents.make) GaudiUtilsMergeComponentsList done"

clean :: GaudiUtilsMergeComponentsListclean ;

GaudiUtilsMergeComponentsListclean :: $(GaudiUtilsMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiUtilsMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiUtilsMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiUtilsMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) GaudiUtilsMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) $(bin)GaudiUtilsMergeComponentsList_dependencies.make

install :: GaudiUtilsMergeComponentsListinstall ;

GaudiUtilsMergeComponentsListinstall :: $(GaudiUtilsMergeComponentsList_dependencies) $(cmt_local_GaudiUtilsMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsMergeComponentsListuninstall

$(foreach d,$(GaudiUtilsMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsMergeComponentsListuninstall))

GaudiUtilsMergeComponentsListuninstall : $(GaudiUtilsMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiUtilsMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtilsMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtilsMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiUtilsConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiUtilsConf_has_target_tag

cmt_local_tagfile_GaudiUtilsConf = $(bin)$(GaudiUtils_tag)_GaudiUtilsConf.make
cmt_final_setup_GaudiUtilsConf = $(bin)setup_GaudiUtilsConf.make
cmt_local_GaudiUtilsConf_makefile = $(bin)GaudiUtilsConf.make

GaudiUtilsConf_extratags = -tag_add=target_GaudiUtilsConf

else

cmt_local_tagfile_GaudiUtilsConf = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtilsConf = $(bin)setup.make
cmt_local_GaudiUtilsConf_makefile = $(bin)GaudiUtilsConf.make

endif

not_GaudiUtilsConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilsConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsConfdirs :
	@if test ! -d $(bin)GaudiUtilsConf; then $(mkdir) -p $(bin)GaudiUtilsConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtilsConf
else
GaudiUtilsConfdirs : ;
endif

ifdef cmt_GaudiUtilsConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtilsConf_makefile) : $(GaudiUtilsConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConf_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf
else
$(cmt_local_GaudiUtilsConf_makefile) : $(GaudiUtilsConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsConf) ] || \
	  $(not_GaudiUtilsConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConf_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtilsConf_makefile) : $(GaudiUtilsConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsConf.in -tag=$(tags) $(GaudiUtilsConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf
else
$(cmt_local_GaudiUtilsConf_makefile) : $(GaudiUtilsConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtilsConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsConf) ] || \
	  $(not_GaudiUtilsConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsConf.in -tag=$(tags) $(GaudiUtilsConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf

GaudiUtilsConf :: $(GaudiUtilsConf_dependencies) $(cmt_local_GaudiUtilsConf_makefile) dirs GaudiUtilsConfdirs
	$(echo) "(constituents.make) Starting GaudiUtilsConf"
	@if test -f $(cmt_local_GaudiUtilsConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConf
	$(echo) "(constituents.make) GaudiUtilsConf done"

clean :: GaudiUtilsConfclean ;

GaudiUtilsConfclean :: $(GaudiUtilsConfclean_dependencies) ##$(cmt_local_GaudiUtilsConf_makefile)
	$(echo) "(constituents.make) Starting GaudiUtilsConfclean"
	@-if test -f $(cmt_local_GaudiUtilsConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConfclean; \
	fi
	$(echo) "(constituents.make) GaudiUtilsConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) GaudiUtilsConfclean

##	  /bin/rm -f $(cmt_local_GaudiUtilsConf_makefile) $(bin)GaudiUtilsConf_dependencies.make

install :: GaudiUtilsConfinstall ;

GaudiUtilsConfinstall :: $(GaudiUtilsConf_dependencies) $(cmt_local_GaudiUtilsConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsConfuninstall

$(foreach d,$(GaudiUtilsConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsConfuninstall))

GaudiUtilsConfuninstall : $(GaudiUtilsConfuninstall_dependencies) ##$(cmt_local_GaudiUtilsConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtilsConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtilsConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiUtils_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiUtils_python_init_has_target_tag

cmt_local_tagfile_GaudiUtils_python_init = $(bin)$(GaudiUtils_tag)_GaudiUtils_python_init.make
cmt_final_setup_GaudiUtils_python_init = $(bin)setup_GaudiUtils_python_init.make
cmt_local_GaudiUtils_python_init_makefile = $(bin)GaudiUtils_python_init.make

GaudiUtils_python_init_extratags = -tag_add=target_GaudiUtils_python_init

else

cmt_local_tagfile_GaudiUtils_python_init = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtils_python_init = $(bin)setup.make
cmt_local_GaudiUtils_python_init_makefile = $(bin)GaudiUtils_python_init.make

endif

not_GaudiUtils_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtils_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtils_python_initdirs :
	@if test ! -d $(bin)GaudiUtils_python_init; then $(mkdir) -p $(bin)GaudiUtils_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtils_python_init
else
GaudiUtils_python_initdirs : ;
endif

ifdef cmt_GaudiUtils_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtils_python_init_makefile) : $(GaudiUtils_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtils_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtils_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init
else
$(cmt_local_GaudiUtils_python_init_makefile) : $(GaudiUtils_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtils_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtils_python_init) ] || \
	  $(not_GaudiUtils_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtils_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtils_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtils_python_init_makefile) : $(GaudiUtils_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtils_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtils_python_init.in -tag=$(tags) $(GaudiUtils_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init
else
$(cmt_local_GaudiUtils_python_init_makefile) : $(GaudiUtils_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtils_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtils_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtils_python_init) ] || \
	  $(not_GaudiUtils_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtils_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtils_python_init.in -tag=$(tags) $(GaudiUtils_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtils_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init

GaudiUtils_python_init :: $(GaudiUtils_python_init_dependencies) $(cmt_local_GaudiUtils_python_init_makefile) dirs GaudiUtils_python_initdirs
	$(echo) "(constituents.make) Starting GaudiUtils_python_init"
	@if test -f $(cmt_local_GaudiUtils_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_init
	$(echo) "(constituents.make) GaudiUtils_python_init done"

clean :: GaudiUtils_python_initclean ;

GaudiUtils_python_initclean :: $(GaudiUtils_python_initclean_dependencies) ##$(cmt_local_GaudiUtils_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiUtils_python_initclean"
	@-if test -f $(cmt_local_GaudiUtils_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiUtils_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) GaudiUtils_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiUtils_python_init_makefile) $(bin)GaudiUtils_python_init_dependencies.make

install :: GaudiUtils_python_initinstall ;

GaudiUtils_python_initinstall :: $(GaudiUtils_python_init_dependencies) $(cmt_local_GaudiUtils_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtils_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtils_python_inituninstall

$(foreach d,$(GaudiUtils_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtils_python_inituninstall))

GaudiUtils_python_inituninstall : $(GaudiUtils_python_inituninstall_dependencies) ##$(cmt_local_GaudiUtils_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtils_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtils_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtils_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtils_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtils_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiUtils_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiUtils_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiUtils_python_modules = $(bin)$(GaudiUtils_tag)_zip_GaudiUtils_python_modules.make
cmt_final_setup_zip_GaudiUtils_python_modules = $(bin)setup_zip_GaudiUtils_python_modules.make
cmt_local_zip_GaudiUtils_python_modules_makefile = $(bin)zip_GaudiUtils_python_modules.make

zip_GaudiUtils_python_modules_extratags = -tag_add=target_zip_GaudiUtils_python_modules

else

cmt_local_tagfile_zip_GaudiUtils_python_modules = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_zip_GaudiUtils_python_modules = $(bin)setup.make
cmt_local_zip_GaudiUtils_python_modules_makefile = $(bin)zip_GaudiUtils_python_modules.make

endif

not_zip_GaudiUtils_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiUtils_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiUtils_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiUtils_python_modules; then $(mkdir) -p $(bin)zip_GaudiUtils_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiUtils_python_modules
else
zip_GaudiUtils_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiUtils_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiUtils_python_modules_makefile) : $(zip_GaudiUtils_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiUtils_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiUtils_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules
else
$(cmt_local_zip_GaudiUtils_python_modules_makefile) : $(zip_GaudiUtils_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiUtils_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiUtils_python_modules) ] || \
	  $(not_zip_GaudiUtils_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiUtils_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiUtils_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiUtils_python_modules_makefile) : $(zip_GaudiUtils_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiUtils_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiUtils_python_modules.in -tag=$(tags) $(zip_GaudiUtils_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules
else
$(cmt_local_zip_GaudiUtils_python_modules_makefile) : $(zip_GaudiUtils_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiUtils_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiUtils_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiUtils_python_modules) ] || \
	  $(not_zip_GaudiUtils_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiUtils_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiUtils_python_modules.in -tag=$(tags) $(zip_GaudiUtils_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiUtils_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules

zip_GaudiUtils_python_modules :: $(zip_GaudiUtils_python_modules_dependencies) $(cmt_local_zip_GaudiUtils_python_modules_makefile) dirs zip_GaudiUtils_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiUtils_python_modules"
	@if test -f $(cmt_local_zip_GaudiUtils_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modules
	$(echo) "(constituents.make) zip_GaudiUtils_python_modules done"

clean :: zip_GaudiUtils_python_modulesclean ;

zip_GaudiUtils_python_modulesclean :: $(zip_GaudiUtils_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiUtils_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiUtils_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiUtils_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiUtils_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) zip_GaudiUtils_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) $(bin)zip_GaudiUtils_python_modules_dependencies.make

install :: zip_GaudiUtils_python_modulesinstall ;

zip_GaudiUtils_python_modulesinstall :: $(zip_GaudiUtils_python_modules_dependencies) $(cmt_local_zip_GaudiUtils_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiUtils_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiUtils_python_modulesuninstall

$(foreach d,$(zip_GaudiUtils_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiUtils_python_modulesuninstall))

zip_GaudiUtils_python_modulesuninstall : $(zip_GaudiUtils_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiUtils_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiUtils_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiUtils_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiUtils_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiUtils_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiUtils_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiUtilsConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiUtilsConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiUtilsConfDbMerge = $(bin)$(GaudiUtils_tag)_GaudiUtilsConfDbMerge.make
cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)setup_GaudiUtilsConfDbMerge.make
cmt_local_GaudiUtilsConfDbMerge_makefile = $(bin)GaudiUtilsConfDbMerge.make

GaudiUtilsConfDbMerge_extratags = -tag_add=target_GaudiUtilsConfDbMerge

else

cmt_local_tagfile_GaudiUtilsConfDbMerge = $(bin)$(GaudiUtils_tag).make
cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)setup.make
cmt_local_GaudiUtilsConfDbMerge_makefile = $(bin)GaudiUtilsConfDbMerge.make

endif

not_GaudiUtilsConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiUtilsConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiUtilsConfDbMergedirs :
	@if test ! -d $(bin)GaudiUtilsConfDbMerge; then $(mkdir) -p $(bin)GaudiUtilsConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiUtilsConfDbMerge
else
GaudiUtilsConfDbMergedirs : ;
endif

ifdef cmt_GaudiUtilsConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiUtilsConfDbMerge_makefile) : $(GaudiUtilsConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge
else
$(cmt_local_GaudiUtilsConfDbMerge_makefile) : $(GaudiUtilsConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsConfDbMerge) ] || \
	  $(not_GaudiUtilsConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiUtilsConfDbMerge_makefile) : $(GaudiUtilsConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiUtilsConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsConfDbMerge.in -tag=$(tags) $(GaudiUtilsConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge
else
$(cmt_local_GaudiUtilsConfDbMerge_makefile) : $(GaudiUtilsConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiUtilsConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiUtilsConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiUtilsConfDbMerge) ] || \
	  $(not_GaudiUtilsConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiUtilsConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiUtilsConfDbMerge.in -tag=$(tags) $(GaudiUtilsConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiUtilsConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge

GaudiUtilsConfDbMerge :: $(GaudiUtilsConfDbMerge_dependencies) $(cmt_local_GaudiUtilsConfDbMerge_makefile) dirs GaudiUtilsConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiUtilsConfDbMerge"
	@if test -f $(cmt_local_GaudiUtilsConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMerge
	$(echo) "(constituents.make) GaudiUtilsConfDbMerge done"

clean :: GaudiUtilsConfDbMergeclean ;

GaudiUtilsConfDbMergeclean :: $(GaudiUtilsConfDbMergeclean_dependencies) ##$(cmt_local_GaudiUtilsConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiUtilsConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiUtilsConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiUtilsConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) GaudiUtilsConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) $(bin)GaudiUtilsConfDbMerge_dependencies.make

install :: GaudiUtilsConfDbMergeinstall ;

GaudiUtilsConfDbMergeinstall :: $(GaudiUtilsConfDbMerge_dependencies) $(cmt_local_GaudiUtilsConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiUtilsConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiUtilsConfDbMergeuninstall

$(foreach d,$(GaudiUtilsConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiUtilsConfDbMergeuninstall))

GaudiUtilsConfDbMergeuninstall : $(GaudiUtilsConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiUtilsConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiUtilsConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiUtilsConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiUtilsConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiUtilsConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiUtilsConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiUtils_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiUtils_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiUtils_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiUtils_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiUtils_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiUtils_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiUtils_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiUtils_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiUtils_tag).make
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
