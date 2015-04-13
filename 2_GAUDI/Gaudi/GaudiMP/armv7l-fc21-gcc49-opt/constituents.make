
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile = $(GaudiMP_tag).make
cmt_local_tagfile = $(bin)$(GaudiMP_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiMPsetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiMP_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiMP_tag).make
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

cmt_GaudiMP_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMP_python_has_target_tag

cmt_local_tagfile_GaudiMP_python = $(bin)$(GaudiMP_tag)_GaudiMP_python.make
cmt_final_setup_GaudiMP_python = $(bin)setup_GaudiMP_python.make
cmt_local_GaudiMP_python_makefile = $(bin)GaudiMP_python.make

GaudiMP_python_extratags = -tag_add=target_GaudiMP_python

else

cmt_local_tagfile_GaudiMP_python = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMP_python = $(bin)setup.make
cmt_local_GaudiMP_python_makefile = $(bin)GaudiMP_python.make

endif

not_GaudiMP_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMP_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMP_pythondirs :
	@if test ! -d $(bin)GaudiMP_python; then $(mkdir) -p $(bin)GaudiMP_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMP_python
else
GaudiMP_pythondirs : ;
endif

ifdef cmt_GaudiMP_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMP_python_makefile) : $(GaudiMP_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_extratags) build constituent_config -out=$(cmt_local_GaudiMP_python_makefile) GaudiMP_python
else
$(cmt_local_GaudiMP_python_makefile) : $(GaudiMP_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP_python) ] || \
	  $(not_GaudiMP_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_extratags) build constituent_config -out=$(cmt_local_GaudiMP_python_makefile) GaudiMP_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMP_python_makefile) : $(GaudiMP_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP_python.in -tag=$(tags) $(GaudiMP_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_python_makefile) GaudiMP_python
else
$(cmt_local_GaudiMP_python_makefile) : $(GaudiMP_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMP_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP_python) ] || \
	  $(not_GaudiMP_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP_python.in -tag=$(tags) $(GaudiMP_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_python_makefile) GaudiMP_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiMP_python_makefile) GaudiMP_python

GaudiMP_python :: $(GaudiMP_python_dependencies) $(cmt_local_GaudiMP_python_makefile) dirs GaudiMP_pythondirs
	$(echo) "(constituents.make) Starting GaudiMP_python"
	@if test -f $(cmt_local_GaudiMP_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_makefile) GaudiMP_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_python_makefile) GaudiMP_python
	$(echo) "(constituents.make) GaudiMP_python done"

clean :: GaudiMP_pythonclean ;

GaudiMP_pythonclean :: $(GaudiMP_pythonclean_dependencies) ##$(cmt_local_GaudiMP_python_makefile)
	$(echo) "(constituents.make) Starting GaudiMP_pythonclean"
	@-if test -f $(cmt_local_GaudiMP_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_makefile) GaudiMP_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiMP_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMP_python_makefile) GaudiMP_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiMP_python_makefile) $(bin)GaudiMP_python_dependencies.make

install :: GaudiMP_pythoninstall ;

GaudiMP_pythoninstall :: $(GaudiMP_python_dependencies) $(cmt_local_GaudiMP_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMP_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMP_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMP_pythonuninstall

$(foreach d,$(GaudiMP_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiMP_pythonuninstall))

GaudiMP_pythonuninstall : $(GaudiMP_pythonuninstall_dependencies) ##$(cmt_local_GaudiMP_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMP_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMP_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMP_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMP_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPGenConfUser_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPGenConfUser_has_target_tag

cmt_local_tagfile_GaudiMPGenConfUser = $(bin)$(GaudiMP_tag)_GaudiMPGenConfUser.make
cmt_final_setup_GaudiMPGenConfUser = $(bin)setup_GaudiMPGenConfUser.make
cmt_local_GaudiMPGenConfUser_makefile = $(bin)GaudiMPGenConfUser.make

GaudiMPGenConfUser_extratags = -tag_add=target_GaudiMPGenConfUser

else

cmt_local_tagfile_GaudiMPGenConfUser = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPGenConfUser = $(bin)setup.make
cmt_local_GaudiMPGenConfUser_makefile = $(bin)GaudiMPGenConfUser.make

endif

not_GaudiMPGenConfUser_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPGenConfUser_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPGenConfUserdirs :
	@if test ! -d $(bin)GaudiMPGenConfUser; then $(mkdir) -p $(bin)GaudiMPGenConfUser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPGenConfUser
else
GaudiMPGenConfUserdirs : ;
endif

ifdef cmt_GaudiMPGenConfUser_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPGenConfUser_makefile) : $(GaudiMPGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser
else
$(cmt_local_GaudiMPGenConfUser_makefile) : $(GaudiMPGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPGenConfUser) ] || \
	  $(not_GaudiMPGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPGenConfUser_makefile) : $(GaudiMPGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPGenConfUser.in -tag=$(tags) $(GaudiMPGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser
else
$(cmt_local_GaudiMPGenConfUser_makefile) : $(GaudiMPGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPGenConfUser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPGenConfUser) ] || \
	  $(not_GaudiMPGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPGenConfUser.in -tag=$(tags) $(GaudiMPGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPGenConfUser_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser

GaudiMPGenConfUser :: $(GaudiMPGenConfUser_dependencies) $(cmt_local_GaudiMPGenConfUser_makefile) dirs GaudiMPGenConfUserdirs
	$(echo) "(constituents.make) Starting GaudiMPGenConfUser"
	@if test -f $(cmt_local_GaudiMPGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUser
	$(echo) "(constituents.make) GaudiMPGenConfUser done"

clean :: GaudiMPGenConfUserclean ;

GaudiMPGenConfUserclean :: $(GaudiMPGenConfUserclean_dependencies) ##$(cmt_local_GaudiMPGenConfUser_makefile)
	$(echo) "(constituents.make) Starting GaudiMPGenConfUserclean"
	@-if test -f $(cmt_local_GaudiMPGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUserclean; \
	fi
	$(echo) "(constituents.make) GaudiMPGenConfUserclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) GaudiMPGenConfUserclean

##	  /bin/rm -f $(cmt_local_GaudiMPGenConfUser_makefile) $(bin)GaudiMPGenConfUser_dependencies.make

install :: GaudiMPGenConfUserinstall ;

GaudiMPGenConfUserinstall :: $(GaudiMPGenConfUser_dependencies) $(cmt_local_GaudiMPGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPGenConfUseruninstall

$(foreach d,$(GaudiMPGenConfUser_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPGenConfUseruninstall))

GaudiMPGenConfUseruninstall : $(GaudiMPGenConfUseruninstall_dependencies) ##$(cmt_local_GaudiMPGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPGenConfUser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPGenConfUseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPGenConfUser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPGenConfUser done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPConfUserDbMerge_has_target_tag

cmt_local_tagfile_GaudiMPConfUserDbMerge = $(bin)$(GaudiMP_tag)_GaudiMPConfUserDbMerge.make
cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)setup_GaudiMPConfUserDbMerge.make
cmt_local_GaudiMPConfUserDbMerge_makefile = $(bin)GaudiMPConfUserDbMerge.make

GaudiMPConfUserDbMerge_extratags = -tag_add=target_GaudiMPConfUserDbMerge

else

cmt_local_tagfile_GaudiMPConfUserDbMerge = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)setup.make
cmt_local_GaudiMPConfUserDbMerge_makefile = $(bin)GaudiMPConfUserDbMerge.make

endif

not_GaudiMPConfUserDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPConfUserDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPConfUserDbMergedirs :
	@if test ! -d $(bin)GaudiMPConfUserDbMerge; then $(mkdir) -p $(bin)GaudiMPConfUserDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPConfUserDbMerge
else
GaudiMPConfUserDbMergedirs : ;
endif

ifdef cmt_GaudiMPConfUserDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPConfUserDbMerge_makefile) : $(GaudiMPConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge
else
$(cmt_local_GaudiMPConfUserDbMerge_makefile) : $(GaudiMPConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConfUserDbMerge) ] || \
	  $(not_GaudiMPConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPConfUserDbMerge_makefile) : $(GaudiMPConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConfUserDbMerge.in -tag=$(tags) $(GaudiMPConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge
else
$(cmt_local_GaudiMPConfUserDbMerge_makefile) : $(GaudiMPConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPConfUserDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConfUserDbMerge) ] || \
	  $(not_GaudiMPConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConfUserDbMerge.in -tag=$(tags) $(GaudiMPConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPConfUserDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge

GaudiMPConfUserDbMerge :: $(GaudiMPConfUserDbMerge_dependencies) $(cmt_local_GaudiMPConfUserDbMerge_makefile) dirs GaudiMPConfUserDbMergedirs
	$(echo) "(constituents.make) Starting GaudiMPConfUserDbMerge"
	@if test -f $(cmt_local_GaudiMPConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMerge
	$(echo) "(constituents.make) GaudiMPConfUserDbMerge done"

clean :: GaudiMPConfUserDbMergeclean ;

GaudiMPConfUserDbMergeclean :: $(GaudiMPConfUserDbMergeclean_dependencies) ##$(cmt_local_GaudiMPConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiMPConfUserDbMergeclean"
	@-if test -f $(cmt_local_GaudiMPConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiMPConfUserDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) GaudiMPConfUserDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) $(bin)GaudiMPConfUserDbMerge_dependencies.make

install :: GaudiMPConfUserDbMergeinstall ;

GaudiMPConfUserDbMergeinstall :: $(GaudiMPConfUserDbMerge_dependencies) $(cmt_local_GaudiMPConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPConfUserDbMergeuninstall

$(foreach d,$(GaudiMPConfUserDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPConfUserDbMergeuninstall))

GaudiMPConfUserDbMergeuninstall : $(GaudiMPConfUserDbMergeuninstall_dependencies) ##$(cmt_local_GaudiMPConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConfUserDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPConfUserDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPConfUserDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPConfUserDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMP_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMP_python_init_has_target_tag

cmt_local_tagfile_GaudiMP_python_init = $(bin)$(GaudiMP_tag)_GaudiMP_python_init.make
cmt_final_setup_GaudiMP_python_init = $(bin)setup_GaudiMP_python_init.make
cmt_local_GaudiMP_python_init_makefile = $(bin)GaudiMP_python_init.make

GaudiMP_python_init_extratags = -tag_add=target_GaudiMP_python_init

else

cmt_local_tagfile_GaudiMP_python_init = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMP_python_init = $(bin)setup.make
cmt_local_GaudiMP_python_init_makefile = $(bin)GaudiMP_python_init.make

endif

not_GaudiMP_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMP_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMP_python_initdirs :
	@if test ! -d $(bin)GaudiMP_python_init; then $(mkdir) -p $(bin)GaudiMP_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMP_python_init
else
GaudiMP_python_initdirs : ;
endif

ifdef cmt_GaudiMP_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMP_python_init_makefile) : $(GaudiMP_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init
else
$(cmt_local_GaudiMP_python_init_makefile) : $(GaudiMP_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP_python_init) ] || \
	  $(not_GaudiMP_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMP_python_init_makefile) : $(GaudiMP_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP_python_init.in -tag=$(tags) $(GaudiMP_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init
else
$(cmt_local_GaudiMP_python_init_makefile) : $(GaudiMP_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMP_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP_python_init) ] || \
	  $(not_GaudiMP_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP_python_init.in -tag=$(tags) $(GaudiMP_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMP_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init

GaudiMP_python_init :: $(GaudiMP_python_init_dependencies) $(cmt_local_GaudiMP_python_init_makefile) dirs GaudiMP_python_initdirs
	$(echo) "(constituents.make) Starting GaudiMP_python_init"
	@if test -f $(cmt_local_GaudiMP_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_init
	$(echo) "(constituents.make) GaudiMP_python_init done"

clean :: GaudiMP_python_initclean ;

GaudiMP_python_initclean :: $(GaudiMP_python_initclean_dependencies) ##$(cmt_local_GaudiMP_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiMP_python_initclean"
	@-if test -f $(cmt_local_GaudiMP_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiMP_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) GaudiMP_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiMP_python_init_makefile) $(bin)GaudiMP_python_init_dependencies.make

install :: GaudiMP_python_initinstall ;

GaudiMP_python_initinstall :: $(GaudiMP_python_init_dependencies) $(cmt_local_GaudiMP_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMP_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMP_python_inituninstall

$(foreach d,$(GaudiMP_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiMP_python_inituninstall))

GaudiMP_python_inituninstall : $(GaudiMP_python_inituninstall_dependencies) ##$(cmt_local_GaudiMP_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMP_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMP_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMP_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMP_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiMP_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiMP_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiMP_python_modules = $(bin)$(GaudiMP_tag)_zip_GaudiMP_python_modules.make
cmt_final_setup_zip_GaudiMP_python_modules = $(bin)setup_zip_GaudiMP_python_modules.make
cmt_local_zip_GaudiMP_python_modules_makefile = $(bin)zip_GaudiMP_python_modules.make

zip_GaudiMP_python_modules_extratags = -tag_add=target_zip_GaudiMP_python_modules

else

cmt_local_tagfile_zip_GaudiMP_python_modules = $(bin)$(GaudiMP_tag).make
cmt_final_setup_zip_GaudiMP_python_modules = $(bin)setup.make
cmt_local_zip_GaudiMP_python_modules_makefile = $(bin)zip_GaudiMP_python_modules.make

endif

not_zip_GaudiMP_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiMP_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiMP_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiMP_python_modules; then $(mkdir) -p $(bin)zip_GaudiMP_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiMP_python_modules
else
zip_GaudiMP_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiMP_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiMP_python_modules_makefile) : $(zip_GaudiMP_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiMP_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiMP_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules
else
$(cmt_local_zip_GaudiMP_python_modules_makefile) : $(zip_GaudiMP_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiMP_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiMP_python_modules) ] || \
	  $(not_zip_GaudiMP_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiMP_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiMP_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiMP_python_modules_makefile) : $(zip_GaudiMP_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiMP_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiMP_python_modules.in -tag=$(tags) $(zip_GaudiMP_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules
else
$(cmt_local_zip_GaudiMP_python_modules_makefile) : $(zip_GaudiMP_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiMP_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiMP_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiMP_python_modules) ] || \
	  $(not_zip_GaudiMP_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiMP_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiMP_python_modules.in -tag=$(tags) $(zip_GaudiMP_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiMP_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules

zip_GaudiMP_python_modules :: $(zip_GaudiMP_python_modules_dependencies) $(cmt_local_zip_GaudiMP_python_modules_makefile) dirs zip_GaudiMP_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiMP_python_modules"
	@if test -f $(cmt_local_zip_GaudiMP_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modules
	$(echo) "(constituents.make) zip_GaudiMP_python_modules done"

clean :: zip_GaudiMP_python_modulesclean ;

zip_GaudiMP_python_modulesclean :: $(zip_GaudiMP_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiMP_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiMP_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiMP_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiMP_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) zip_GaudiMP_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiMP_python_modules_makefile) $(bin)zip_GaudiMP_python_modules_dependencies.make

install :: zip_GaudiMP_python_modulesinstall ;

zip_GaudiMP_python_modulesinstall :: $(zip_GaudiMP_python_modules_dependencies) $(cmt_local_zip_GaudiMP_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiMP_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiMP_python_modulesuninstall

$(foreach d,$(zip_GaudiMP_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiMP_python_modulesuninstall))

zip_GaudiMP_python_modulesuninstall : $(zip_GaudiMP_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiMP_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiMP_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiMP_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiMP_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiMP_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiMP_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_scripts_has_target_tag

cmt_local_tagfile_install_scripts = $(bin)$(GaudiMP_tag)_install_scripts.make
cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

install_scripts_extratags = -tag_add=target_install_scripts

else

cmt_local_tagfile_install_scripts = $(bin)$(GaudiMP_tag).make
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
#-- start of constituent_app_lib ------

cmt_GaudiMPLib_has_no_target_tag = 1
cmt_GaudiMPLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMPLib_has_target_tag

cmt_local_tagfile_GaudiMPLib = $(bin)$(GaudiMP_tag)_GaudiMPLib.make
cmt_final_setup_GaudiMPLib = $(bin)setup_GaudiMPLib.make
cmt_local_GaudiMPLib_makefile = $(bin)GaudiMPLib.make

GaudiMPLib_extratags = -tag_add=target_GaudiMPLib

else

cmt_local_tagfile_GaudiMPLib = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPLib = $(bin)setup.make
cmt_local_GaudiMPLib_makefile = $(bin)GaudiMPLib.make

endif

not_GaudiMPLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPLibdirs :
	@if test ! -d $(bin)GaudiMPLib; then $(mkdir) -p $(bin)GaudiMPLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPLib
else
GaudiMPLibdirs : ;
endif

ifdef cmt_GaudiMPLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPLib_makefile) : $(GaudiMPLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPLib_extratags) build constituent_config -out=$(cmt_local_GaudiMPLib_makefile) GaudiMPLib
else
$(cmt_local_GaudiMPLib_makefile) : $(GaudiMPLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPLib) ] || \
	  $(not_GaudiMPLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPLib_extratags) build constituent_config -out=$(cmt_local_GaudiMPLib_makefile) GaudiMPLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPLib_makefile) : $(GaudiMPLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPLib.in -tag=$(tags) $(GaudiMPLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPLib_makefile) GaudiMPLib
else
$(cmt_local_GaudiMPLib_makefile) : $(GaudiMPLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPLib) ] || \
	  $(not_GaudiMPLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPLib.in -tag=$(tags) $(GaudiMPLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPLib_makefile) GaudiMPLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPLib_makefile) GaudiMPLib

GaudiMPLib :: GaudiMPLibcompile GaudiMPLibinstall ;

ifdef cmt_GaudiMPLib_has_prototypes

GaudiMPLibprototype : $(GaudiMPLibprototype_dependencies) $(cmt_local_GaudiMPLib_makefile) dirs GaudiMPLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiMPLibcompile : GaudiMPLibprototype

endif

GaudiMPLibcompile : $(GaudiMPLibcompile_dependencies) $(cmt_local_GaudiMPLib_makefile) dirs GaudiMPLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiMPLibclean ;

GaudiMPLibclean :: $(GaudiMPLibclean_dependencies) ##$(cmt_local_GaudiMPLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPLib_makefile) GaudiMPLibclean

##	  /bin/rm -f $(cmt_local_GaudiMPLib_makefile) $(bin)GaudiMPLib_dependencies.make

install :: GaudiMPLibinstall ;

GaudiMPLibinstall :: GaudiMPLibcompile $(GaudiMPLib_dependencies) $(cmt_local_GaudiMPLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPLibuninstall

$(foreach d,$(GaudiMPLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPLibuninstall))

GaudiMPLibuninstall : $(GaudiMPLibuninstall_dependencies) ##$(cmt_local_GaudiMPLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiMP_has_no_target_tag = 1
cmt_GaudiMP_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMP_has_target_tag

cmt_local_tagfile_GaudiMP = $(bin)$(GaudiMP_tag)_GaudiMP.make
cmt_final_setup_GaudiMP = $(bin)setup_GaudiMP.make
cmt_local_GaudiMP_makefile = $(bin)GaudiMP.make

GaudiMP_extratags = -tag_add=target_GaudiMP

else

cmt_local_tagfile_GaudiMP = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMP = $(bin)setup.make
cmt_local_GaudiMP_makefile = $(bin)GaudiMP.make

endif

not_GaudiMPcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPdirs :
	@if test ! -d $(bin)GaudiMP; then $(mkdir) -p $(bin)GaudiMP; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMP
else
GaudiMPdirs : ;
endif

ifdef cmt_GaudiMP_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMP_makefile) : $(GaudiMPcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_extratags) build constituent_config -out=$(cmt_local_GaudiMP_makefile) GaudiMP
else
$(cmt_local_GaudiMP_makefile) : $(GaudiMPcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP) ] || \
	  $(not_GaudiMPcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMP_extratags) build constituent_config -out=$(cmt_local_GaudiMP_makefile) GaudiMP; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMP_makefile) : $(GaudiMPcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMP.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP.in -tag=$(tags) $(GaudiMP_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_makefile) GaudiMP
else
$(cmt_local_GaudiMP_makefile) : $(GaudiMPcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMP.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMP) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMP) ] || \
	  $(not_GaudiMPcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMP.make"; \
	  $(cmtexe) -f=$(bin)GaudiMP.in -tag=$(tags) $(GaudiMP_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMP_makefile) GaudiMP; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMP_extratags) build constituent_makefile -out=$(cmt_local_GaudiMP_makefile) GaudiMP

GaudiMP :: GaudiMPcompile GaudiMPinstall ;

ifdef cmt_GaudiMP_has_prototypes

GaudiMPprototype : $(GaudiMPprototype_dependencies) $(cmt_local_GaudiMP_makefile) dirs GaudiMPdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMP_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiMPcompile : GaudiMPprototype

endif

GaudiMPcompile : $(GaudiMPcompile_dependencies) $(cmt_local_GaudiMP_makefile) dirs GaudiMPdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMP_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiMPclean ;

GaudiMPclean :: $(GaudiMPclean_dependencies) ##$(cmt_local_GaudiMP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMP_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiMP_makefile) GaudiMPclean

##	  /bin/rm -f $(cmt_local_GaudiMP_makefile) $(bin)GaudiMP_dependencies.make

install :: GaudiMPinstall ;

GaudiMPinstall :: GaudiMPcompile $(GaudiMP_dependencies) $(cmt_local_GaudiMP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMP_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPuninstall

$(foreach d,$(GaudiMP_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPuninstall))

GaudiMPuninstall : $(GaudiMPuninstall_dependencies) ##$(cmt_local_GaudiMP_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMP_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMP_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMP_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMP"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMP done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiMPComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPComponentsList_has_target_tag

cmt_local_tagfile_GaudiMPComponentsList = $(bin)$(GaudiMP_tag)_GaudiMPComponentsList.make
cmt_final_setup_GaudiMPComponentsList = $(bin)setup_GaudiMPComponentsList.make
cmt_local_GaudiMPComponentsList_makefile = $(bin)GaudiMPComponentsList.make

GaudiMPComponentsList_extratags = -tag_add=target_GaudiMPComponentsList

else

cmt_local_tagfile_GaudiMPComponentsList = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPComponentsList = $(bin)setup.make
cmt_local_GaudiMPComponentsList_makefile = $(bin)GaudiMPComponentsList.make

endif

not_GaudiMPComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPComponentsListdirs :
	@if test ! -d $(bin)GaudiMPComponentsList; then $(mkdir) -p $(bin)GaudiMPComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPComponentsList
else
GaudiMPComponentsListdirs : ;
endif

ifdef cmt_GaudiMPComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPComponentsList_makefile) : $(GaudiMPComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList
else
$(cmt_local_GaudiMPComponentsList_makefile) : $(GaudiMPComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPComponentsList) ] || \
	  $(not_GaudiMPComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPComponentsList_makefile) : $(GaudiMPComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPComponentsList.in -tag=$(tags) $(GaudiMPComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList
else
$(cmt_local_GaudiMPComponentsList_makefile) : $(GaudiMPComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPComponentsList) ] || \
	  $(not_GaudiMPComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPComponentsList.in -tag=$(tags) $(GaudiMPComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList

GaudiMPComponentsList :: $(GaudiMPComponentsList_dependencies) $(cmt_local_GaudiMPComponentsList_makefile) dirs GaudiMPComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiMPComponentsList"
	@if test -f $(cmt_local_GaudiMPComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsList
	$(echo) "(constituents.make) GaudiMPComponentsList done"

clean :: GaudiMPComponentsListclean ;

GaudiMPComponentsListclean :: $(GaudiMPComponentsListclean_dependencies) ##$(cmt_local_GaudiMPComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiMPComponentsListclean"
	@-if test -f $(cmt_local_GaudiMPComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiMPComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) GaudiMPComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiMPComponentsList_makefile) $(bin)GaudiMPComponentsList_dependencies.make

install :: GaudiMPComponentsListinstall ;

GaudiMPComponentsListinstall :: $(GaudiMPComponentsList_dependencies) $(cmt_local_GaudiMPComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPComponentsListuninstall

$(foreach d,$(GaudiMPComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPComponentsListuninstall))

GaudiMPComponentsListuninstall : $(GaudiMPComponentsListuninstall_dependencies) ##$(cmt_local_GaudiMPComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiMPMergeComponentsList = $(bin)$(GaudiMP_tag)_GaudiMPMergeComponentsList.make
cmt_final_setup_GaudiMPMergeComponentsList = $(bin)setup_GaudiMPMergeComponentsList.make
cmt_local_GaudiMPMergeComponentsList_makefile = $(bin)GaudiMPMergeComponentsList.make

GaudiMPMergeComponentsList_extratags = -tag_add=target_GaudiMPMergeComponentsList

else

cmt_local_tagfile_GaudiMPMergeComponentsList = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPMergeComponentsList = $(bin)setup.make
cmt_local_GaudiMPMergeComponentsList_makefile = $(bin)GaudiMPMergeComponentsList.make

endif

not_GaudiMPMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiMPMergeComponentsList; then $(mkdir) -p $(bin)GaudiMPMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPMergeComponentsList
else
GaudiMPMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiMPMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPMergeComponentsList_makefile) : $(GaudiMPMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList
else
$(cmt_local_GaudiMPMergeComponentsList_makefile) : $(GaudiMPMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPMergeComponentsList) ] || \
	  $(not_GaudiMPMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPMergeComponentsList_makefile) : $(GaudiMPMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPMergeComponentsList.in -tag=$(tags) $(GaudiMPMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList
else
$(cmt_local_GaudiMPMergeComponentsList_makefile) : $(GaudiMPMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPMergeComponentsList) ] || \
	  $(not_GaudiMPMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPMergeComponentsList.in -tag=$(tags) $(GaudiMPMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList

GaudiMPMergeComponentsList :: $(GaudiMPMergeComponentsList_dependencies) $(cmt_local_GaudiMPMergeComponentsList_makefile) dirs GaudiMPMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiMPMergeComponentsList"
	@if test -f $(cmt_local_GaudiMPMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsList
	$(echo) "(constituents.make) GaudiMPMergeComponentsList done"

clean :: GaudiMPMergeComponentsListclean ;

GaudiMPMergeComponentsListclean :: $(GaudiMPMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiMPMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiMPMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiMPMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiMPMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) GaudiMPMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiMPMergeComponentsList_makefile) $(bin)GaudiMPMergeComponentsList_dependencies.make

install :: GaudiMPMergeComponentsListinstall ;

GaudiMPMergeComponentsListinstall :: $(GaudiMPMergeComponentsList_dependencies) $(cmt_local_GaudiMPMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPMergeComponentsListuninstall

$(foreach d,$(GaudiMPMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPMergeComponentsListuninstall))

GaudiMPMergeComponentsListuninstall : $(GaudiMPMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiMPMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPConf_has_target_tag

cmt_local_tagfile_GaudiMPConf = $(bin)$(GaudiMP_tag)_GaudiMPConf.make
cmt_final_setup_GaudiMPConf = $(bin)setup_GaudiMPConf.make
cmt_local_GaudiMPConf_makefile = $(bin)GaudiMPConf.make

GaudiMPConf_extratags = -tag_add=target_GaudiMPConf

else

cmt_local_tagfile_GaudiMPConf = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPConf = $(bin)setup.make
cmt_local_GaudiMPConf_makefile = $(bin)GaudiMPConf.make

endif

not_GaudiMPConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPConfdirs :
	@if test ! -d $(bin)GaudiMPConf; then $(mkdir) -p $(bin)GaudiMPConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPConf
else
GaudiMPConfdirs : ;
endif

ifdef cmt_GaudiMPConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPConf_makefile) : $(GaudiMPConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConf_extratags) build constituent_config -out=$(cmt_local_GaudiMPConf_makefile) GaudiMPConf
else
$(cmt_local_GaudiMPConf_makefile) : $(GaudiMPConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConf) ] || \
	  $(not_GaudiMPConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConf_extratags) build constituent_config -out=$(cmt_local_GaudiMPConf_makefile) GaudiMPConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPConf_makefile) : $(GaudiMPConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConf.in -tag=$(tags) $(GaudiMPConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConf_makefile) GaudiMPConf
else
$(cmt_local_GaudiMPConf_makefile) : $(GaudiMPConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConf) ] || \
	  $(not_GaudiMPConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConf.in -tag=$(tags) $(GaudiMPConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConf_makefile) GaudiMPConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPConf_makefile) GaudiMPConf

GaudiMPConf :: $(GaudiMPConf_dependencies) $(cmt_local_GaudiMPConf_makefile) dirs GaudiMPConfdirs
	$(echo) "(constituents.make) Starting GaudiMPConf"
	@if test -f $(cmt_local_GaudiMPConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConf_makefile) GaudiMPConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConf_makefile) GaudiMPConf
	$(echo) "(constituents.make) GaudiMPConf done"

clean :: GaudiMPConfclean ;

GaudiMPConfclean :: $(GaudiMPConfclean_dependencies) ##$(cmt_local_GaudiMPConf_makefile)
	$(echo) "(constituents.make) Starting GaudiMPConfclean"
	@-if test -f $(cmt_local_GaudiMPConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConf_makefile) GaudiMPConfclean; \
	fi
	$(echo) "(constituents.make) GaudiMPConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPConf_makefile) GaudiMPConfclean

##	  /bin/rm -f $(cmt_local_GaudiMPConf_makefile) $(bin)GaudiMPConf_dependencies.make

install :: GaudiMPConfinstall ;

GaudiMPConfinstall :: $(GaudiMPConf_dependencies) $(cmt_local_GaudiMPConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPConfuninstall

$(foreach d,$(GaudiMPConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPConfuninstall))

GaudiMPConfuninstall : $(GaudiMPConfuninstall_dependencies) ##$(cmt_local_GaudiMPConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiMPConfDbMerge = $(bin)$(GaudiMP_tag)_GaudiMPConfDbMerge.make
cmt_final_setup_GaudiMPConfDbMerge = $(bin)setup_GaudiMPConfDbMerge.make
cmt_local_GaudiMPConfDbMerge_makefile = $(bin)GaudiMPConfDbMerge.make

GaudiMPConfDbMerge_extratags = -tag_add=target_GaudiMPConfDbMerge

else

cmt_local_tagfile_GaudiMPConfDbMerge = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPConfDbMerge = $(bin)setup.make
cmt_local_GaudiMPConfDbMerge_makefile = $(bin)GaudiMPConfDbMerge.make

endif

not_GaudiMPConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPConfDbMergedirs :
	@if test ! -d $(bin)GaudiMPConfDbMerge; then $(mkdir) -p $(bin)GaudiMPConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPConfDbMerge
else
GaudiMPConfDbMergedirs : ;
endif

ifdef cmt_GaudiMPConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPConfDbMerge_makefile) : $(GaudiMPConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge
else
$(cmt_local_GaudiMPConfDbMerge_makefile) : $(GaudiMPConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConfDbMerge) ] || \
	  $(not_GaudiMPConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPConfDbMerge_makefile) : $(GaudiMPConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConfDbMerge.in -tag=$(tags) $(GaudiMPConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge
else
$(cmt_local_GaudiMPConfDbMerge_makefile) : $(GaudiMPConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPConfDbMerge) ] || \
	  $(not_GaudiMPConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPConfDbMerge.in -tag=$(tags) $(GaudiMPConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge

GaudiMPConfDbMerge :: $(GaudiMPConfDbMerge_dependencies) $(cmt_local_GaudiMPConfDbMerge_makefile) dirs GaudiMPConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiMPConfDbMerge"
	@if test -f $(cmt_local_GaudiMPConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMerge
	$(echo) "(constituents.make) GaudiMPConfDbMerge done"

clean :: GaudiMPConfDbMergeclean ;

GaudiMPConfDbMergeclean :: $(GaudiMPConfDbMergeclean_dependencies) ##$(cmt_local_GaudiMPConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiMPConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiMPConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiMPConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) GaudiMPConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiMPConfDbMerge_makefile) $(bin)GaudiMPConfDbMerge_dependencies.make

install :: GaudiMPConfDbMergeinstall ;

GaudiMPConfDbMergeinstall :: $(GaudiMPConfDbMerge_dependencies) $(cmt_local_GaudiMPConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPConfDbMergeuninstall

$(foreach d,$(GaudiMPConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPConfDbMergeuninstall))

GaudiMPConfDbMergeuninstall : $(GaudiMPConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiMPConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiMPGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiMPGen_has_target_tag

cmt_local_tagfile_GaudiMPGen = $(bin)$(GaudiMP_tag)_GaudiMPGen.make
cmt_final_setup_GaudiMPGen = $(bin)setup_GaudiMPGen.make
cmt_local_GaudiMPGen_makefile = $(bin)GaudiMPGen.make

GaudiMPGen_extratags = -tag_add=target_GaudiMPGen

else

cmt_local_tagfile_GaudiMPGen = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPGen = $(bin)setup.make
cmt_local_GaudiMPGen_makefile = $(bin)GaudiMPGen.make

endif

not_GaudiMPGen_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPGendirs :
	@if test ! -d $(bin)GaudiMPGen; then $(mkdir) -p $(bin)GaudiMPGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPGen
else
GaudiMPGendirs : ;
endif

ifdef cmt_GaudiMPGen_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPGen_makefile) : $(GaudiMPGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPGen_extratags) build constituent_config -out=$(cmt_local_GaudiMPGen_makefile) GaudiMPGen
else
$(cmt_local_GaudiMPGen_makefile) : $(GaudiMPGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPGen) ] || \
	  $(not_GaudiMPGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPGen_extratags) build constituent_config -out=$(cmt_local_GaudiMPGen_makefile) GaudiMPGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPGen_makefile) : $(GaudiMPGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPGen.in -tag=$(tags) $(GaudiMPGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPGen_makefile) GaudiMPGen
else
$(cmt_local_GaudiMPGen_makefile) : $(GaudiMPGen_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPGen) ] || \
	  $(not_GaudiMPGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPGen.in -tag=$(tags) $(GaudiMPGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPGen_makefile) GaudiMPGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPGen_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPGen_makefile) GaudiMPGen

GaudiMPGen :: $(GaudiMPGen_dependencies) $(cmt_local_GaudiMPGen_makefile) dirs GaudiMPGendirs
	$(echo) "(constituents.make) Starting GaudiMPGen"
	@if test -f $(cmt_local_GaudiMPGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGen_makefile) GaudiMPGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPGen_makefile) GaudiMPGen
	$(echo) "(constituents.make) GaudiMPGen done"

clean :: GaudiMPGenclean ;

GaudiMPGenclean :: $(GaudiMPGenclean_dependencies) ##$(cmt_local_GaudiMPGen_makefile)
	$(echo) "(constituents.make) Starting GaudiMPGenclean"
	@-if test -f $(cmt_local_GaudiMPGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGen_makefile) GaudiMPGenclean; \
	fi
	$(echo) "(constituents.make) GaudiMPGenclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPGen_makefile) GaudiMPGenclean

##	  /bin/rm -f $(cmt_local_GaudiMPGen_makefile) $(bin)GaudiMPGen_dependencies.make

install :: GaudiMPGeninstall ;

GaudiMPGeninstall :: $(GaudiMPGen_dependencies) $(cmt_local_GaudiMPGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiMPGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPGenuninstall

$(foreach d,$(GaudiMPGen_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPGenuninstall))

GaudiMPGenuninstall : $(GaudiMPGenuninstall_dependencies) ##$(cmt_local_GaudiMPGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GaudiMPDict_has_no_target_tag = 1
cmt_GaudiMPDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiMPDict_has_target_tag

cmt_local_tagfile_GaudiMPDict = $(bin)$(GaudiMP_tag)_GaudiMPDict.make
cmt_final_setup_GaudiMPDict = $(bin)setup_GaudiMPDict.make
cmt_local_GaudiMPDict_makefile = $(bin)GaudiMPDict.make

GaudiMPDict_extratags = -tag_add=target_GaudiMPDict

else

cmt_local_tagfile_GaudiMPDict = $(bin)$(GaudiMP_tag).make
cmt_final_setup_GaudiMPDict = $(bin)setup.make
cmt_local_GaudiMPDict_makefile = $(bin)GaudiMPDict.make

endif

not_GaudiMPDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiMPDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiMPDictdirs :
	@if test ! -d $(bin)GaudiMPDict; then $(mkdir) -p $(bin)GaudiMPDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiMPDict
else
GaudiMPDictdirs : ;
endif

ifdef cmt_GaudiMPDict_has_target_tag

ifndef QUICK
$(cmt_local_GaudiMPDict_makefile) : $(GaudiMPDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPDict_extratags) build constituent_config -out=$(cmt_local_GaudiMPDict_makefile) GaudiMPDict
else
$(cmt_local_GaudiMPDict_makefile) : $(GaudiMPDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPDict) ] || \
	  $(not_GaudiMPDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiMPDict_extratags) build constituent_config -out=$(cmt_local_GaudiMPDict_makefile) GaudiMPDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiMPDict_makefile) : $(GaudiMPDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiMPDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPDict.in -tag=$(tags) $(GaudiMPDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPDict_makefile) GaudiMPDict
else
$(cmt_local_GaudiMPDict_makefile) : $(GaudiMPDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiMPDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiMPDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiMPDict) ] || \
	  $(not_GaudiMPDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiMPDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiMPDict.in -tag=$(tags) $(GaudiMPDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiMPDict_makefile) GaudiMPDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiMPDict_extratags) build constituent_makefile -out=$(cmt_local_GaudiMPDict_makefile) GaudiMPDict

GaudiMPDict :: GaudiMPDictcompile GaudiMPDictinstall ;

ifdef cmt_GaudiMPDict_has_prototypes

GaudiMPDictprototype : $(GaudiMPDictprototype_dependencies) $(cmt_local_GaudiMPDict_makefile) dirs GaudiMPDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiMPDictcompile : GaudiMPDictprototype

endif

GaudiMPDictcompile : $(GaudiMPDictcompile_dependencies) $(cmt_local_GaudiMPDict_makefile) dirs GaudiMPDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiMPDictclean ;

GaudiMPDictclean :: $(GaudiMPDictclean_dependencies) ##$(cmt_local_GaudiMPDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiMPDict_makefile) GaudiMPDictclean

##	  /bin/rm -f $(cmt_local_GaudiMPDict_makefile) $(bin)GaudiMPDict_dependencies.make

install :: GaudiMPDictinstall ;

GaudiMPDictinstall :: GaudiMPDictcompile $(GaudiMPDict_dependencies) $(cmt_local_GaudiMPDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiMPDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiMPDictuninstall

$(foreach d,$(GaudiMPDict_dependencies),$(eval $(d)uninstall_dependencies += GaudiMPDictuninstall))

GaudiMPDictuninstall : $(GaudiMPDictuninstall_dependencies) ##$(cmt_local_GaudiMPDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiMPDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiMPDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiMPDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiMPDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiMPDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiMPDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiMP_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiMP_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiMP_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiMP_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiMP_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiMP_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiMP_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiMP_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiMP_tag).make
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
