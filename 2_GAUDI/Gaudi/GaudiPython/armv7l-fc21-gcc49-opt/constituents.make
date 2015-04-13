
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile = $(GaudiPython_tag).make
cmt_local_tagfile = $(bin)$(GaudiPython_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make
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

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiPython_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiPython_tag).make
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

cmt_GaudiPython_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPython_python_has_target_tag

cmt_local_tagfile_GaudiPython_python = $(bin)$(GaudiPython_tag)_GaudiPython_python.make
cmt_final_setup_GaudiPython_python = $(bin)setup_GaudiPython_python.make
cmt_local_GaudiPython_python_makefile = $(bin)GaudiPython_python.make

GaudiPython_python_extratags = -tag_add=target_GaudiPython_python

else

cmt_local_tagfile_GaudiPython_python = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPython_python = $(bin)setup.make
cmt_local_GaudiPython_python_makefile = $(bin)GaudiPython_python.make

endif

not_GaudiPython_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPython_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPython_pythondirs :
	@if test ! -d $(bin)GaudiPython_python; then $(mkdir) -p $(bin)GaudiPython_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPython_python
else
GaudiPython_pythondirs : ;
endif

ifdef cmt_GaudiPython_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPython_python_makefile) : $(GaudiPython_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_extratags) build constituent_config -out=$(cmt_local_GaudiPython_python_makefile) GaudiPython_python
else
$(cmt_local_GaudiPython_python_makefile) : $(GaudiPython_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython_python) ] || \
	  $(not_GaudiPython_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_extratags) build constituent_config -out=$(cmt_local_GaudiPython_python_makefile) GaudiPython_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPython_python_makefile) : $(GaudiPython_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython_python.in -tag=$(tags) $(GaudiPython_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_python_makefile) GaudiPython_python
else
$(cmt_local_GaudiPython_python_makefile) : $(GaudiPython_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPython_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython_python) ] || \
	  $(not_GaudiPython_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython_python.in -tag=$(tags) $(GaudiPython_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_python_makefile) GaudiPython_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiPython_python_makefile) GaudiPython_python

GaudiPython_python :: $(GaudiPython_python_dependencies) $(cmt_local_GaudiPython_python_makefile) dirs GaudiPython_pythondirs
	$(echo) "(constituents.make) Starting GaudiPython_python"
	@if test -f $(cmt_local_GaudiPython_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_makefile) GaudiPython_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_python_makefile) GaudiPython_python
	$(echo) "(constituents.make) GaudiPython_python done"

clean :: GaudiPython_pythonclean ;

GaudiPython_pythonclean :: $(GaudiPython_pythonclean_dependencies) ##$(cmt_local_GaudiPython_python_makefile)
	$(echo) "(constituents.make) Starting GaudiPython_pythonclean"
	@-if test -f $(cmt_local_GaudiPython_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_makefile) GaudiPython_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiPython_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPython_python_makefile) GaudiPython_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiPython_python_makefile) $(bin)GaudiPython_python_dependencies.make

install :: GaudiPython_pythoninstall ;

GaudiPython_pythoninstall :: $(GaudiPython_python_dependencies) $(cmt_local_GaudiPython_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPython_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPython_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPython_pythonuninstall

$(foreach d,$(GaudiPython_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiPython_pythonuninstall))

GaudiPython_pythonuninstall : $(GaudiPython_pythonuninstall_dependencies) ##$(cmt_local_GaudiPython_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPython_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPython_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPython_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPython_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPythonGenConfUser_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonGenConfUser_has_target_tag

cmt_local_tagfile_GaudiPythonGenConfUser = $(bin)$(GaudiPython_tag)_GaudiPythonGenConfUser.make
cmt_final_setup_GaudiPythonGenConfUser = $(bin)setup_GaudiPythonGenConfUser.make
cmt_local_GaudiPythonGenConfUser_makefile = $(bin)GaudiPythonGenConfUser.make

GaudiPythonGenConfUser_extratags = -tag_add=target_GaudiPythonGenConfUser

else

cmt_local_tagfile_GaudiPythonGenConfUser = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonGenConfUser = $(bin)setup.make
cmt_local_GaudiPythonGenConfUser_makefile = $(bin)GaudiPythonGenConfUser.make

endif

not_GaudiPythonGenConfUser_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonGenConfUser_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonGenConfUserdirs :
	@if test ! -d $(bin)GaudiPythonGenConfUser; then $(mkdir) -p $(bin)GaudiPythonGenConfUser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonGenConfUser
else
GaudiPythonGenConfUserdirs : ;
endif

ifdef cmt_GaudiPythonGenConfUser_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonGenConfUser_makefile) : $(GaudiPythonGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser
else
$(cmt_local_GaudiPythonGenConfUser_makefile) : $(GaudiPythonGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonGenConfUser) ] || \
	  $(not_GaudiPythonGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonGenConfUser_makefile) : $(GaudiPythonGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonGenConfUser.in -tag=$(tags) $(GaudiPythonGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser
else
$(cmt_local_GaudiPythonGenConfUser_makefile) : $(GaudiPythonGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonGenConfUser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonGenConfUser) ] || \
	  $(not_GaudiPythonGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonGenConfUser.in -tag=$(tags) $(GaudiPythonGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonGenConfUser_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser

GaudiPythonGenConfUser :: $(GaudiPythonGenConfUser_dependencies) $(cmt_local_GaudiPythonGenConfUser_makefile) dirs GaudiPythonGenConfUserdirs
	$(echo) "(constituents.make) Starting GaudiPythonGenConfUser"
	@if test -f $(cmt_local_GaudiPythonGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUser
	$(echo) "(constituents.make) GaudiPythonGenConfUser done"

clean :: GaudiPythonGenConfUserclean ;

GaudiPythonGenConfUserclean :: $(GaudiPythonGenConfUserclean_dependencies) ##$(cmt_local_GaudiPythonGenConfUser_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonGenConfUserclean"
	@-if test -f $(cmt_local_GaudiPythonGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUserclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonGenConfUserclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) GaudiPythonGenConfUserclean

##	  /bin/rm -f $(cmt_local_GaudiPythonGenConfUser_makefile) $(bin)GaudiPythonGenConfUser_dependencies.make

install :: GaudiPythonGenConfUserinstall ;

GaudiPythonGenConfUserinstall :: $(GaudiPythonGenConfUser_dependencies) $(cmt_local_GaudiPythonGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonGenConfUseruninstall

$(foreach d,$(GaudiPythonGenConfUser_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonGenConfUseruninstall))

GaudiPythonGenConfUseruninstall : $(GaudiPythonGenConfUseruninstall_dependencies) ##$(cmt_local_GaudiPythonGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonGenConfUser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonGenConfUseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonGenConfUser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonGenConfUser done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPythonConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonConfUserDbMerge_has_target_tag

cmt_local_tagfile_GaudiPythonConfUserDbMerge = $(bin)$(GaudiPython_tag)_GaudiPythonConfUserDbMerge.make
cmt_final_setup_GaudiPythonConfUserDbMerge = $(bin)setup_GaudiPythonConfUserDbMerge.make
cmt_local_GaudiPythonConfUserDbMerge_makefile = $(bin)GaudiPythonConfUserDbMerge.make

GaudiPythonConfUserDbMerge_extratags = -tag_add=target_GaudiPythonConfUserDbMerge

else

cmt_local_tagfile_GaudiPythonConfUserDbMerge = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonConfUserDbMerge = $(bin)setup.make
cmt_local_GaudiPythonConfUserDbMerge_makefile = $(bin)GaudiPythonConfUserDbMerge.make

endif

not_GaudiPythonConfUserDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonConfUserDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonConfUserDbMergedirs :
	@if test ! -d $(bin)GaudiPythonConfUserDbMerge; then $(mkdir) -p $(bin)GaudiPythonConfUserDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonConfUserDbMerge
else
GaudiPythonConfUserDbMergedirs : ;
endif

ifdef cmt_GaudiPythonConfUserDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonConfUserDbMerge_makefile) : $(GaudiPythonConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge
else
$(cmt_local_GaudiPythonConfUserDbMerge_makefile) : $(GaudiPythonConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConfUserDbMerge) ] || \
	  $(not_GaudiPythonConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonConfUserDbMerge_makefile) : $(GaudiPythonConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConfUserDbMerge.in -tag=$(tags) $(GaudiPythonConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge
else
$(cmt_local_GaudiPythonConfUserDbMerge_makefile) : $(GaudiPythonConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonConfUserDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConfUserDbMerge) ] || \
	  $(not_GaudiPythonConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConfUserDbMerge.in -tag=$(tags) $(GaudiPythonConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfUserDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge

GaudiPythonConfUserDbMerge :: $(GaudiPythonConfUserDbMerge_dependencies) $(cmt_local_GaudiPythonConfUserDbMerge_makefile) dirs GaudiPythonConfUserDbMergedirs
	$(echo) "(constituents.make) Starting GaudiPythonConfUserDbMerge"
	@if test -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMerge
	$(echo) "(constituents.make) GaudiPythonConfUserDbMerge done"

clean :: GaudiPythonConfUserDbMergeclean ;

GaudiPythonConfUserDbMergeclean :: $(GaudiPythonConfUserDbMergeclean_dependencies) ##$(cmt_local_GaudiPythonConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonConfUserDbMergeclean"
	@-if test -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonConfUserDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) GaudiPythonConfUserDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) $(bin)GaudiPythonConfUserDbMerge_dependencies.make

install :: GaudiPythonConfUserDbMergeinstall ;

GaudiPythonConfUserDbMergeinstall :: $(GaudiPythonConfUserDbMerge_dependencies) $(cmt_local_GaudiPythonConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonConfUserDbMergeuninstall

$(foreach d,$(GaudiPythonConfUserDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonConfUserDbMergeuninstall))

GaudiPythonConfUserDbMergeuninstall : $(GaudiPythonConfUserDbMergeuninstall_dependencies) ##$(cmt_local_GaudiPythonConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConfUserDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonConfUserDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonConfUserDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonConfUserDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPython_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPython_python_init_has_target_tag

cmt_local_tagfile_GaudiPython_python_init = $(bin)$(GaudiPython_tag)_GaudiPython_python_init.make
cmt_final_setup_GaudiPython_python_init = $(bin)setup_GaudiPython_python_init.make
cmt_local_GaudiPython_python_init_makefile = $(bin)GaudiPython_python_init.make

GaudiPython_python_init_extratags = -tag_add=target_GaudiPython_python_init

else

cmt_local_tagfile_GaudiPython_python_init = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPython_python_init = $(bin)setup.make
cmt_local_GaudiPython_python_init_makefile = $(bin)GaudiPython_python_init.make

endif

not_GaudiPython_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPython_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPython_python_initdirs :
	@if test ! -d $(bin)GaudiPython_python_init; then $(mkdir) -p $(bin)GaudiPython_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPython_python_init
else
GaudiPython_python_initdirs : ;
endif

ifdef cmt_GaudiPython_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPython_python_init_makefile) : $(GaudiPython_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init
else
$(cmt_local_GaudiPython_python_init_makefile) : $(GaudiPython_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython_python_init) ] || \
	  $(not_GaudiPython_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPython_python_init_makefile) : $(GaudiPython_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython_python_init.in -tag=$(tags) $(GaudiPython_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init
else
$(cmt_local_GaudiPython_python_init_makefile) : $(GaudiPython_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPython_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython_python_init) ] || \
	  $(not_GaudiPython_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython_python_init.in -tag=$(tags) $(GaudiPython_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPython_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init

GaudiPython_python_init :: $(GaudiPython_python_init_dependencies) $(cmt_local_GaudiPython_python_init_makefile) dirs GaudiPython_python_initdirs
	$(echo) "(constituents.make) Starting GaudiPython_python_init"
	@if test -f $(cmt_local_GaudiPython_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_init
	$(echo) "(constituents.make) GaudiPython_python_init done"

clean :: GaudiPython_python_initclean ;

GaudiPython_python_initclean :: $(GaudiPython_python_initclean_dependencies) ##$(cmt_local_GaudiPython_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiPython_python_initclean"
	@-if test -f $(cmt_local_GaudiPython_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiPython_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) GaudiPython_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiPython_python_init_makefile) $(bin)GaudiPython_python_init_dependencies.make

install :: GaudiPython_python_initinstall ;

GaudiPython_python_initinstall :: $(GaudiPython_python_init_dependencies) $(cmt_local_GaudiPython_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPython_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPython_python_inituninstall

$(foreach d,$(GaudiPython_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiPython_python_inituninstall))

GaudiPython_python_inituninstall : $(GaudiPython_python_inituninstall_dependencies) ##$(cmt_local_GaudiPython_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPython_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPython_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPython_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPython_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiPython_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiPython_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiPython_python_modules = $(bin)$(GaudiPython_tag)_zip_GaudiPython_python_modules.make
cmt_final_setup_zip_GaudiPython_python_modules = $(bin)setup_zip_GaudiPython_python_modules.make
cmt_local_zip_GaudiPython_python_modules_makefile = $(bin)zip_GaudiPython_python_modules.make

zip_GaudiPython_python_modules_extratags = -tag_add=target_zip_GaudiPython_python_modules

else

cmt_local_tagfile_zip_GaudiPython_python_modules = $(bin)$(GaudiPython_tag).make
cmt_final_setup_zip_GaudiPython_python_modules = $(bin)setup.make
cmt_local_zip_GaudiPython_python_modules_makefile = $(bin)zip_GaudiPython_python_modules.make

endif

not_zip_GaudiPython_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiPython_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiPython_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiPython_python_modules; then $(mkdir) -p $(bin)zip_GaudiPython_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiPython_python_modules
else
zip_GaudiPython_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiPython_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiPython_python_modules_makefile) : $(zip_GaudiPython_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiPython_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiPython_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules
else
$(cmt_local_zip_GaudiPython_python_modules_makefile) : $(zip_GaudiPython_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiPython_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiPython_python_modules) ] || \
	  $(not_zip_GaudiPython_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiPython_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiPython_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiPython_python_modules_makefile) : $(zip_GaudiPython_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiPython_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiPython_python_modules.in -tag=$(tags) $(zip_GaudiPython_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules
else
$(cmt_local_zip_GaudiPython_python_modules_makefile) : $(zip_GaudiPython_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiPython_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiPython_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiPython_python_modules) ] || \
	  $(not_zip_GaudiPython_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiPython_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiPython_python_modules.in -tag=$(tags) $(zip_GaudiPython_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiPython_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules

zip_GaudiPython_python_modules :: $(zip_GaudiPython_python_modules_dependencies) $(cmt_local_zip_GaudiPython_python_modules_makefile) dirs zip_GaudiPython_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiPython_python_modules"
	@if test -f $(cmt_local_zip_GaudiPython_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modules
	$(echo) "(constituents.make) zip_GaudiPython_python_modules done"

clean :: zip_GaudiPython_python_modulesclean ;

zip_GaudiPython_python_modulesclean :: $(zip_GaudiPython_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiPython_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiPython_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiPython_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiPython_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) zip_GaudiPython_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiPython_python_modules_makefile) $(bin)zip_GaudiPython_python_modules_dependencies.make

install :: zip_GaudiPython_python_modulesinstall ;

zip_GaudiPython_python_modulesinstall :: $(zip_GaudiPython_python_modules_dependencies) $(cmt_local_zip_GaudiPython_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiPython_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiPython_python_modulesuninstall

$(foreach d,$(zip_GaudiPython_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiPython_python_modulesuninstall))

zip_GaudiPython_python_modulesuninstall : $(zip_GaudiPython_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiPython_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiPython_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiPython_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiPython_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiPython_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiPython_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_scripts_has_target_tag

cmt_local_tagfile_install_scripts = $(bin)$(GaudiPython_tag)_install_scripts.make
cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

install_scripts_extratags = -tag_add=target_install_scripts

else

cmt_local_tagfile_install_scripts = $(bin)$(GaudiPython_tag).make
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

cmt_GaudiPythonLib_has_no_target_tag = 1
cmt_GaudiPythonLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPythonLib_has_target_tag

cmt_local_tagfile_GaudiPythonLib = $(bin)$(GaudiPython_tag)_GaudiPythonLib.make
cmt_final_setup_GaudiPythonLib = $(bin)setup_GaudiPythonLib.make
cmt_local_GaudiPythonLib_makefile = $(bin)GaudiPythonLib.make

GaudiPythonLib_extratags = -tag_add=target_GaudiPythonLib

else

cmt_local_tagfile_GaudiPythonLib = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonLib = $(bin)setup.make
cmt_local_GaudiPythonLib_makefile = $(bin)GaudiPythonLib.make

endif

not_GaudiPythonLibcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonLibcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonLibdirs :
	@if test ! -d $(bin)GaudiPythonLib; then $(mkdir) -p $(bin)GaudiPythonLib; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonLib
else
GaudiPythonLibdirs : ;
endif

ifdef cmt_GaudiPythonLib_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonLib_makefile) : $(GaudiPythonLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonLib_extratags) build constituent_config -out=$(cmt_local_GaudiPythonLib_makefile) GaudiPythonLib
else
$(cmt_local_GaudiPythonLib_makefile) : $(GaudiPythonLibcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonLib) ] || \
	  $(not_GaudiPythonLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonLib.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonLib_extratags) build constituent_config -out=$(cmt_local_GaudiPythonLib_makefile) GaudiPythonLib; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonLib_makefile) : $(GaudiPythonLibcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonLib.in -tag=$(tags) $(GaudiPythonLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonLib_makefile) GaudiPythonLib
else
$(cmt_local_GaudiPythonLib_makefile) : $(GaudiPythonLibcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonLib.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonLib) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonLib) ] || \
	  $(not_GaudiPythonLibcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonLib.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonLib.in -tag=$(tags) $(GaudiPythonLib_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonLib_makefile) GaudiPythonLib; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonLib_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonLib_makefile) GaudiPythonLib

GaudiPythonLib :: GaudiPythonLibcompile GaudiPythonLibinstall ;

ifdef cmt_GaudiPythonLib_has_prototypes

GaudiPythonLibprototype : $(GaudiPythonLibprototype_dependencies) $(cmt_local_GaudiPythonLib_makefile) dirs GaudiPythonLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiPythonLibcompile : GaudiPythonLibprototype

endif

GaudiPythonLibcompile : $(GaudiPythonLibcompile_dependencies) $(cmt_local_GaudiPythonLib_makefile) dirs GaudiPythonLibdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiPythonLibclean ;

GaudiPythonLibclean :: $(GaudiPythonLibclean_dependencies) ##$(cmt_local_GaudiPythonLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) GaudiPythonLibclean

##	  /bin/rm -f $(cmt_local_GaudiPythonLib_makefile) $(bin)GaudiPythonLib_dependencies.make

install :: GaudiPythonLibinstall ;

GaudiPythonLibinstall :: GaudiPythonLibcompile $(GaudiPythonLib_dependencies) $(cmt_local_GaudiPythonLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonLibuninstall

$(foreach d,$(GaudiPythonLib_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonLibuninstall))

GaudiPythonLibuninstall : $(GaudiPythonLibuninstall_dependencies) ##$(cmt_local_GaudiPythonLib_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonLib_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonLib_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonLibuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonLib"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonLib done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiPython_has_no_target_tag = 1
cmt_GaudiPython_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPython_has_target_tag

cmt_local_tagfile_GaudiPython = $(bin)$(GaudiPython_tag)_GaudiPython.make
cmt_final_setup_GaudiPython = $(bin)setup_GaudiPython.make
cmt_local_GaudiPython_makefile = $(bin)GaudiPython.make

GaudiPython_extratags = -tag_add=target_GaudiPython

else

cmt_local_tagfile_GaudiPython = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPython = $(bin)setup.make
cmt_local_GaudiPython_makefile = $(bin)GaudiPython.make

endif

not_GaudiPythoncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythoncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythondirs :
	@if test ! -d $(bin)GaudiPython; then $(mkdir) -p $(bin)GaudiPython; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPython
else
GaudiPythondirs : ;
endif

ifdef cmt_GaudiPython_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPython_makefile) : $(GaudiPythoncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_extratags) build constituent_config -out=$(cmt_local_GaudiPython_makefile) GaudiPython
else
$(cmt_local_GaudiPython_makefile) : $(GaudiPythoncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython) ] || \
	  $(not_GaudiPythoncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPython_extratags) build constituent_config -out=$(cmt_local_GaudiPython_makefile) GaudiPython; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPython_makefile) : $(GaudiPythoncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPython.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython.in -tag=$(tags) $(GaudiPython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_makefile) GaudiPython
else
$(cmt_local_GaudiPython_makefile) : $(GaudiPythoncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPython.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPython) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPython) ] || \
	  $(not_GaudiPythoncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPython.make"; \
	  $(cmtexe) -f=$(bin)GaudiPython.in -tag=$(tags) $(GaudiPython_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPython_makefile) GaudiPython; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPython_extratags) build constituent_makefile -out=$(cmt_local_GaudiPython_makefile) GaudiPython

GaudiPython :: GaudiPythoncompile GaudiPythoninstall ;

ifdef cmt_GaudiPython_has_prototypes

GaudiPythonprototype : $(GaudiPythonprototype_dependencies) $(cmt_local_GaudiPython_makefile) dirs GaudiPythondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPython_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiPythoncompile : GaudiPythonprototype

endif

GaudiPythoncompile : $(GaudiPythoncompile_dependencies) $(cmt_local_GaudiPython_makefile) dirs GaudiPythondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPython_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiPythonclean ;

GaudiPythonclean :: $(GaudiPythonclean_dependencies) ##$(cmt_local_GaudiPython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPython_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiPython_makefile) GaudiPythonclean

##	  /bin/rm -f $(cmt_local_GaudiPython_makefile) $(bin)GaudiPython_dependencies.make

install :: GaudiPythoninstall ;

GaudiPythoninstall :: GaudiPythoncompile $(GaudiPython_dependencies) $(cmt_local_GaudiPython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPython_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonuninstall

$(foreach d,$(GaudiPython_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonuninstall))

GaudiPythonuninstall : $(GaudiPythonuninstall_dependencies) ##$(cmt_local_GaudiPython_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPython_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPython_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPython_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPython"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPython done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiPythonGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonGen_has_target_tag

cmt_local_tagfile_GaudiPythonGen = $(bin)$(GaudiPython_tag)_GaudiPythonGen.make
cmt_final_setup_GaudiPythonGen = $(bin)setup_GaudiPythonGen.make
cmt_local_GaudiPythonGen_makefile = $(bin)GaudiPythonGen.make

GaudiPythonGen_extratags = -tag_add=target_GaudiPythonGen

else

cmt_local_tagfile_GaudiPythonGen = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonGen = $(bin)setup.make
cmt_local_GaudiPythonGen_makefile = $(bin)GaudiPythonGen.make

endif

not_GaudiPythonGen_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonGendirs :
	@if test ! -d $(bin)GaudiPythonGen; then $(mkdir) -p $(bin)GaudiPythonGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonGen
else
GaudiPythonGendirs : ;
endif

ifdef cmt_GaudiPythonGen_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonGen_makefile) : $(GaudiPythonGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonGen_extratags) build constituent_config -out=$(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen
else
$(cmt_local_GaudiPythonGen_makefile) : $(GaudiPythonGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonGen) ] || \
	  $(not_GaudiPythonGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonGen.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonGen_extratags) build constituent_config -out=$(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonGen_makefile) : $(GaudiPythonGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonGen.in -tag=$(tags) $(GaudiPythonGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen
else
$(cmt_local_GaudiPythonGen_makefile) : $(GaudiPythonGen_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonGen) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonGen) ] || \
	  $(not_GaudiPythonGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonGen.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonGen.in -tag=$(tags) $(GaudiPythonGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonGen_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen

GaudiPythonGen :: $(GaudiPythonGen_dependencies) $(cmt_local_GaudiPythonGen_makefile) dirs GaudiPythonGendirs
	$(echo) "(constituents.make) Starting GaudiPythonGen"
	@if test -f $(cmt_local_GaudiPythonGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) GaudiPythonGen
	$(echo) "(constituents.make) GaudiPythonGen done"

clean :: GaudiPythonGenclean ;

GaudiPythonGenclean :: $(GaudiPythonGenclean_dependencies) ##$(cmt_local_GaudiPythonGen_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonGenclean"
	@-if test -f $(cmt_local_GaudiPythonGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) GaudiPythonGenclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonGenclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) GaudiPythonGenclean

##	  /bin/rm -f $(cmt_local_GaudiPythonGen_makefile) $(bin)GaudiPythonGen_dependencies.make

install :: GaudiPythonGeninstall ;

GaudiPythonGeninstall :: $(GaudiPythonGen_dependencies) $(cmt_local_GaudiPythonGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonGenuninstall

$(foreach d,$(GaudiPythonGen_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonGenuninstall))

GaudiPythonGenuninstall : $(GaudiPythonGenuninstall_dependencies) ##$(cmt_local_GaudiPythonGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonGen_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GaudiPythonDict_has_no_target_tag = 1
cmt_GaudiPythonDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiPythonDict_has_target_tag

cmt_local_tagfile_GaudiPythonDict = $(bin)$(GaudiPython_tag)_GaudiPythonDict.make
cmt_final_setup_GaudiPythonDict = $(bin)setup_GaudiPythonDict.make
cmt_local_GaudiPythonDict_makefile = $(bin)GaudiPythonDict.make

GaudiPythonDict_extratags = -tag_add=target_GaudiPythonDict

else

cmt_local_tagfile_GaudiPythonDict = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonDict = $(bin)setup.make
cmt_local_GaudiPythonDict_makefile = $(bin)GaudiPythonDict.make

endif

not_GaudiPythonDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonDictdirs :
	@if test ! -d $(bin)GaudiPythonDict; then $(mkdir) -p $(bin)GaudiPythonDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonDict
else
GaudiPythonDictdirs : ;
endif

ifdef cmt_GaudiPythonDict_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonDict_makefile) : $(GaudiPythonDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonDict_extratags) build constituent_config -out=$(cmt_local_GaudiPythonDict_makefile) GaudiPythonDict
else
$(cmt_local_GaudiPythonDict_makefile) : $(GaudiPythonDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonDict) ] || \
	  $(not_GaudiPythonDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonDict.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonDict_extratags) build constituent_config -out=$(cmt_local_GaudiPythonDict_makefile) GaudiPythonDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonDict_makefile) : $(GaudiPythonDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonDict.in -tag=$(tags) $(GaudiPythonDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonDict_makefile) GaudiPythonDict
else
$(cmt_local_GaudiPythonDict_makefile) : $(GaudiPythonDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonDict) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonDict) ] || \
	  $(not_GaudiPythonDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonDict.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonDict.in -tag=$(tags) $(GaudiPythonDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonDict_makefile) GaudiPythonDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonDict_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonDict_makefile) GaudiPythonDict

GaudiPythonDict :: GaudiPythonDictcompile GaudiPythonDictinstall ;

ifdef cmt_GaudiPythonDict_has_prototypes

GaudiPythonDictprototype : $(GaudiPythonDictprototype_dependencies) $(cmt_local_GaudiPythonDict_makefile) dirs GaudiPythonDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiPythonDictcompile : GaudiPythonDictprototype

endif

GaudiPythonDictcompile : $(GaudiPythonDictcompile_dependencies) $(cmt_local_GaudiPythonDict_makefile) dirs GaudiPythonDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiPythonDictclean ;

GaudiPythonDictclean :: $(GaudiPythonDictclean_dependencies) ##$(cmt_local_GaudiPythonDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) GaudiPythonDictclean

##	  /bin/rm -f $(cmt_local_GaudiPythonDict_makefile) $(bin)GaudiPythonDict_dependencies.make

install :: GaudiPythonDictinstall ;

GaudiPythonDictinstall :: GaudiPythonDictcompile $(GaudiPythonDict_dependencies) $(cmt_local_GaudiPythonDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonDictuninstall

$(foreach d,$(GaudiPythonDict_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonDictuninstall))

GaudiPythonDictuninstall : $(GaudiPythonDictuninstall_dependencies) ##$(cmt_local_GaudiPythonDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonDict_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiPythonComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonComponentsList_has_target_tag

cmt_local_tagfile_GaudiPythonComponentsList = $(bin)$(GaudiPython_tag)_GaudiPythonComponentsList.make
cmt_final_setup_GaudiPythonComponentsList = $(bin)setup_GaudiPythonComponentsList.make
cmt_local_GaudiPythonComponentsList_makefile = $(bin)GaudiPythonComponentsList.make

GaudiPythonComponentsList_extratags = -tag_add=target_GaudiPythonComponentsList

else

cmt_local_tagfile_GaudiPythonComponentsList = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonComponentsList = $(bin)setup.make
cmt_local_GaudiPythonComponentsList_makefile = $(bin)GaudiPythonComponentsList.make

endif

not_GaudiPythonComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonComponentsListdirs :
	@if test ! -d $(bin)GaudiPythonComponentsList; then $(mkdir) -p $(bin)GaudiPythonComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonComponentsList
else
GaudiPythonComponentsListdirs : ;
endif

ifdef cmt_GaudiPythonComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonComponentsList_makefile) : $(GaudiPythonComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList
else
$(cmt_local_GaudiPythonComponentsList_makefile) : $(GaudiPythonComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonComponentsList) ] || \
	  $(not_GaudiPythonComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonComponentsList_makefile) : $(GaudiPythonComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonComponentsList.in -tag=$(tags) $(GaudiPythonComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList
else
$(cmt_local_GaudiPythonComponentsList_makefile) : $(GaudiPythonComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonComponentsList) ] || \
	  $(not_GaudiPythonComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonComponentsList.in -tag=$(tags) $(GaudiPythonComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList

GaudiPythonComponentsList :: $(GaudiPythonComponentsList_dependencies) $(cmt_local_GaudiPythonComponentsList_makefile) dirs GaudiPythonComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiPythonComponentsList"
	@if test -f $(cmt_local_GaudiPythonComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsList
	$(echo) "(constituents.make) GaudiPythonComponentsList done"

clean :: GaudiPythonComponentsListclean ;

GaudiPythonComponentsListclean :: $(GaudiPythonComponentsListclean_dependencies) ##$(cmt_local_GaudiPythonComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonComponentsListclean"
	@-if test -f $(cmt_local_GaudiPythonComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) GaudiPythonComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiPythonComponentsList_makefile) $(bin)GaudiPythonComponentsList_dependencies.make

install :: GaudiPythonComponentsListinstall ;

GaudiPythonComponentsListinstall :: $(GaudiPythonComponentsList_dependencies) $(cmt_local_GaudiPythonComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonComponentsListuninstall

$(foreach d,$(GaudiPythonComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonComponentsListuninstall))

GaudiPythonComponentsListuninstall : $(GaudiPythonComponentsListuninstall_dependencies) ##$(cmt_local_GaudiPythonComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPythonMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiPythonMergeComponentsList = $(bin)$(GaudiPython_tag)_GaudiPythonMergeComponentsList.make
cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)setup_GaudiPythonMergeComponentsList.make
cmt_local_GaudiPythonMergeComponentsList_makefile = $(bin)GaudiPythonMergeComponentsList.make

GaudiPythonMergeComponentsList_extratags = -tag_add=target_GaudiPythonMergeComponentsList

else

cmt_local_tagfile_GaudiPythonMergeComponentsList = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)setup.make
cmt_local_GaudiPythonMergeComponentsList_makefile = $(bin)GaudiPythonMergeComponentsList.make

endif

not_GaudiPythonMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiPythonMergeComponentsList; then $(mkdir) -p $(bin)GaudiPythonMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonMergeComponentsList
else
GaudiPythonMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiPythonMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonMergeComponentsList_makefile) : $(GaudiPythonMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList
else
$(cmt_local_GaudiPythonMergeComponentsList_makefile) : $(GaudiPythonMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonMergeComponentsList) ] || \
	  $(not_GaudiPythonMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonMergeComponentsList_makefile) : $(GaudiPythonMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonMergeComponentsList.in -tag=$(tags) $(GaudiPythonMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList
else
$(cmt_local_GaudiPythonMergeComponentsList_makefile) : $(GaudiPythonMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonMergeComponentsList) ] || \
	  $(not_GaudiPythonMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonMergeComponentsList.in -tag=$(tags) $(GaudiPythonMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList

GaudiPythonMergeComponentsList :: $(GaudiPythonMergeComponentsList_dependencies) $(cmt_local_GaudiPythonMergeComponentsList_makefile) dirs GaudiPythonMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiPythonMergeComponentsList"
	@if test -f $(cmt_local_GaudiPythonMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsList
	$(echo) "(constituents.make) GaudiPythonMergeComponentsList done"

clean :: GaudiPythonMergeComponentsListclean ;

GaudiPythonMergeComponentsListclean :: $(GaudiPythonMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiPythonMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiPythonMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) GaudiPythonMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) $(bin)GaudiPythonMergeComponentsList_dependencies.make

install :: GaudiPythonMergeComponentsListinstall ;

GaudiPythonMergeComponentsListinstall :: $(GaudiPythonMergeComponentsList_dependencies) $(cmt_local_GaudiPythonMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonMergeComponentsListuninstall

$(foreach d,$(GaudiPythonMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonMergeComponentsListuninstall))

GaudiPythonMergeComponentsListuninstall : $(GaudiPythonMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiPythonMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPythonConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonConf_has_target_tag

cmt_local_tagfile_GaudiPythonConf = $(bin)$(GaudiPython_tag)_GaudiPythonConf.make
cmt_final_setup_GaudiPythonConf = $(bin)setup_GaudiPythonConf.make
cmt_local_GaudiPythonConf_makefile = $(bin)GaudiPythonConf.make

GaudiPythonConf_extratags = -tag_add=target_GaudiPythonConf

else

cmt_local_tagfile_GaudiPythonConf = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonConf = $(bin)setup.make
cmt_local_GaudiPythonConf_makefile = $(bin)GaudiPythonConf.make

endif

not_GaudiPythonConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonConfdirs :
	@if test ! -d $(bin)GaudiPythonConf; then $(mkdir) -p $(bin)GaudiPythonConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonConf
else
GaudiPythonConfdirs : ;
endif

ifdef cmt_GaudiPythonConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonConf_makefile) : $(GaudiPythonConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConf_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf
else
$(cmt_local_GaudiPythonConf_makefile) : $(GaudiPythonConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConf) ] || \
	  $(not_GaudiPythonConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConf_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonConf_makefile) : $(GaudiPythonConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConf.in -tag=$(tags) $(GaudiPythonConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf
else
$(cmt_local_GaudiPythonConf_makefile) : $(GaudiPythonConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConf) ] || \
	  $(not_GaudiPythonConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConf.in -tag=$(tags) $(GaudiPythonConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf

GaudiPythonConf :: $(GaudiPythonConf_dependencies) $(cmt_local_GaudiPythonConf_makefile) dirs GaudiPythonConfdirs
	$(echo) "(constituents.make) Starting GaudiPythonConf"
	@if test -f $(cmt_local_GaudiPythonConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) GaudiPythonConf
	$(echo) "(constituents.make) GaudiPythonConf done"

clean :: GaudiPythonConfclean ;

GaudiPythonConfclean :: $(GaudiPythonConfclean_dependencies) ##$(cmt_local_GaudiPythonConf_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonConfclean"
	@-if test -f $(cmt_local_GaudiPythonConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) GaudiPythonConfclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) GaudiPythonConfclean

##	  /bin/rm -f $(cmt_local_GaudiPythonConf_makefile) $(bin)GaudiPythonConf_dependencies.make

install :: GaudiPythonConfinstall ;

GaudiPythonConfinstall :: $(GaudiPythonConf_dependencies) $(cmt_local_GaudiPythonConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonConfuninstall

$(foreach d,$(GaudiPythonConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonConfuninstall))

GaudiPythonConfuninstall : $(GaudiPythonConfuninstall_dependencies) ##$(cmt_local_GaudiPythonConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiPythonConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiPythonConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiPythonConfDbMerge = $(bin)$(GaudiPython_tag)_GaudiPythonConfDbMerge.make
cmt_final_setup_GaudiPythonConfDbMerge = $(bin)setup_GaudiPythonConfDbMerge.make
cmt_local_GaudiPythonConfDbMerge_makefile = $(bin)GaudiPythonConfDbMerge.make

GaudiPythonConfDbMerge_extratags = -tag_add=target_GaudiPythonConfDbMerge

else

cmt_local_tagfile_GaudiPythonConfDbMerge = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GaudiPythonConfDbMerge = $(bin)setup.make
cmt_local_GaudiPythonConfDbMerge_makefile = $(bin)GaudiPythonConfDbMerge.make

endif

not_GaudiPythonConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiPythonConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiPythonConfDbMergedirs :
	@if test ! -d $(bin)GaudiPythonConfDbMerge; then $(mkdir) -p $(bin)GaudiPythonConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiPythonConfDbMerge
else
GaudiPythonConfDbMergedirs : ;
endif

ifdef cmt_GaudiPythonConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiPythonConfDbMerge_makefile) : $(GaudiPythonConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge
else
$(cmt_local_GaudiPythonConfDbMerge_makefile) : $(GaudiPythonConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConfDbMerge) ] || \
	  $(not_GaudiPythonConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiPythonConfDbMerge_makefile) : $(GaudiPythonConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiPythonConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConfDbMerge.in -tag=$(tags) $(GaudiPythonConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge
else
$(cmt_local_GaudiPythonConfDbMerge_makefile) : $(GaudiPythonConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiPythonConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiPythonConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiPythonConfDbMerge) ] || \
	  $(not_GaudiPythonConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiPythonConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiPythonConfDbMerge.in -tag=$(tags) $(GaudiPythonConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiPythonConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge

GaudiPythonConfDbMerge :: $(GaudiPythonConfDbMerge_dependencies) $(cmt_local_GaudiPythonConfDbMerge_makefile) dirs GaudiPythonConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiPythonConfDbMerge"
	@if test -f $(cmt_local_GaudiPythonConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMerge
	$(echo) "(constituents.make) GaudiPythonConfDbMerge done"

clean :: GaudiPythonConfDbMergeclean ;

GaudiPythonConfDbMergeclean :: $(GaudiPythonConfDbMergeclean_dependencies) ##$(cmt_local_GaudiPythonConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiPythonConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiPythonConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiPythonConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) GaudiPythonConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiPythonConfDbMerge_makefile) $(bin)GaudiPythonConfDbMerge_dependencies.make

install :: GaudiPythonConfDbMergeinstall ;

GaudiPythonConfDbMergeinstall :: $(GaudiPythonConfDbMerge_dependencies) $(cmt_local_GaudiPythonConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiPythonConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiPythonConfDbMergeuninstall

$(foreach d,$(GaudiPythonConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiPythonConfDbMergeuninstall))

GaudiPythonConfDbMergeuninstall : $(GaudiPythonConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiPythonConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiPythonConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiPythonConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiPythonConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiPythonConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiPythonConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_GPyTest_has_no_target_tag = 1
cmt_GPyTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_GPyTest_has_target_tag

cmt_local_tagfile_GPyTest = $(bin)$(GaudiPython_tag)_GPyTest.make
cmt_final_setup_GPyTest = $(bin)setup_GPyTest.make
cmt_local_GPyTest_makefile = $(bin)GPyTest.make

GPyTest_extratags = -tag_add=target_GPyTest

else

cmt_local_tagfile_GPyTest = $(bin)$(GaudiPython_tag).make
cmt_final_setup_GPyTest = $(bin)setup.make
cmt_local_GPyTest_makefile = $(bin)GPyTest.make

endif

not_GPyTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GPyTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GPyTestdirs :
	@if test ! -d $(bin)GPyTest; then $(mkdir) -p $(bin)GPyTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GPyTest
else
GPyTestdirs : ;
endif

ifdef cmt_GPyTest_has_target_tag

ifndef QUICK
$(cmt_local_GPyTest_makefile) : $(GPyTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GPyTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GPyTest_extratags) build constituent_config -out=$(cmt_local_GPyTest_makefile) GPyTest
else
$(cmt_local_GPyTest_makefile) : $(GPyTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GPyTest) ] || \
	  [ ! -f $(cmt_final_setup_GPyTest) ] || \
	  $(not_GPyTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GPyTest.make"; \
	  $(cmtexe) -tag=$(tags) $(GPyTest_extratags) build constituent_config -out=$(cmt_local_GPyTest_makefile) GPyTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GPyTest_makefile) : $(GPyTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GPyTest.make"; \
	  $(cmtexe) -f=$(bin)GPyTest.in -tag=$(tags) $(GPyTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GPyTest_makefile) GPyTest
else
$(cmt_local_GPyTest_makefile) : $(GPyTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GPyTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GPyTest) ] || \
	  [ ! -f $(cmt_final_setup_GPyTest) ] || \
	  $(not_GPyTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GPyTest.make"; \
	  $(cmtexe) -f=$(bin)GPyTest.in -tag=$(tags) $(GPyTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GPyTest_makefile) GPyTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GPyTest_extratags) build constituent_makefile -out=$(cmt_local_GPyTest_makefile) GPyTest

GPyTest :: GPyTestcompile GPyTestinstall ;

ifdef cmt_GPyTest_has_prototypes

GPyTestprototype : $(GPyTestprototype_dependencies) $(cmt_local_GPyTest_makefile) dirs GPyTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GPyTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GPyTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GPyTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

GPyTestcompile : GPyTestprototype

endif

GPyTestcompile : $(GPyTestcompile_dependencies) $(cmt_local_GPyTest_makefile) dirs GPyTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GPyTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GPyTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GPyTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GPyTestclean ;

GPyTestclean :: $(GPyTestclean_dependencies) ##$(cmt_local_GPyTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GPyTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GPyTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GPyTest_makefile) GPyTestclean

##	  /bin/rm -f $(cmt_local_GPyTest_makefile) $(bin)GPyTest_dependencies.make

install :: GPyTestinstall ;

GPyTestinstall :: GPyTestcompile $(GPyTest_dependencies) $(cmt_local_GPyTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GPyTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GPyTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GPyTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GPyTestuninstall

$(foreach d,$(GPyTest_dependencies),$(eval $(d)uninstall_dependencies += GPyTestuninstall))

GPyTestuninstall : $(GPyTestuninstall_dependencies) ##$(cmt_local_GPyTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GPyTest_makefile); then \
	  $(MAKE) -f $(cmt_local_GPyTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GPyTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GPyTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GPyTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GPyTest done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_test_GPyTestGen_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_test_GPyTestGen_has_target_tag

cmt_local_tagfile_test_GPyTestGen = $(bin)$(GaudiPython_tag)_test_GPyTestGen.make
cmt_final_setup_test_GPyTestGen = $(bin)setup_test_GPyTestGen.make
cmt_local_test_GPyTestGen_makefile = $(bin)test_GPyTestGen.make

test_GPyTestGen_extratags = -tag_add=target_test_GPyTestGen

else

cmt_local_tagfile_test_GPyTestGen = $(bin)$(GaudiPython_tag).make
cmt_final_setup_test_GPyTestGen = $(bin)setup.make
cmt_local_test_GPyTestGen_makefile = $(bin)test_GPyTestGen.make

endif

not_test_GPyTestGen_dependencies = { n=0; for p in $?; do m=0; for d in $(test_GPyTestGen_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_GPyTestGendirs :
	@if test ! -d $(bin)test_GPyTestGen; then $(mkdir) -p $(bin)test_GPyTestGen; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_GPyTestGen
else
test_GPyTestGendirs : ;
endif

ifdef cmt_test_GPyTestGen_has_target_tag

ifndef QUICK
$(cmt_local_test_GPyTestGen_makefile) : $(test_GPyTestGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GPyTestGen.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GPyTestGen_extratags) build constituent_config -out=$(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen
else
$(cmt_local_test_GPyTestGen_makefile) : $(test_GPyTestGen_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GPyTestGen) ] || \
	  [ ! -f $(cmt_final_setup_test_GPyTestGen) ] || \
	  $(not_test_GPyTestGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GPyTestGen.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GPyTestGen_extratags) build constituent_config -out=$(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_GPyTestGen_makefile) : $(test_GPyTestGen_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GPyTestGen.make"; \
	  $(cmtexe) -f=$(bin)test_GPyTestGen.in -tag=$(tags) $(test_GPyTestGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen
else
$(cmt_local_test_GPyTestGen_makefile) : $(test_GPyTestGen_dependencies) $(cmt_build_library_linksstamp) $(bin)test_GPyTestGen.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GPyTestGen) ] || \
	  [ ! -f $(cmt_final_setup_test_GPyTestGen) ] || \
	  $(not_test_GPyTestGen_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GPyTestGen.make"; \
	  $(cmtexe) -f=$(bin)test_GPyTestGen.in -tag=$(tags) $(test_GPyTestGen_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_GPyTestGen_extratags) build constituent_makefile -out=$(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen

test_GPyTestGen :: $(test_GPyTestGen_dependencies) $(cmt_local_test_GPyTestGen_makefile) dirs test_GPyTestGendirs
	$(echo) "(constituents.make) Starting test_GPyTestGen"
	@if test -f $(cmt_local_test_GPyTestGen_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) test_GPyTestGen
	$(echo) "(constituents.make) test_GPyTestGen done"

clean :: test_GPyTestGenclean ;

test_GPyTestGenclean :: $(test_GPyTestGenclean_dependencies) ##$(cmt_local_test_GPyTestGen_makefile)
	$(echo) "(constituents.make) Starting test_GPyTestGenclean"
	@-if test -f $(cmt_local_test_GPyTestGen_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) test_GPyTestGenclean; \
	fi
	$(echo) "(constituents.make) test_GPyTestGenclean done"
#	@-$(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) test_GPyTestGenclean

##	  /bin/rm -f $(cmt_local_test_GPyTestGen_makefile) $(bin)test_GPyTestGen_dependencies.make

install :: test_GPyTestGeninstall ;

test_GPyTestGeninstall :: $(test_GPyTestGen_dependencies) $(cmt_local_test_GPyTestGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GPyTestGen_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : test_GPyTestGenuninstall

$(foreach d,$(test_GPyTestGen_dependencies),$(eval $(d)uninstall_dependencies += test_GPyTestGenuninstall))

test_GPyTestGenuninstall : $(test_GPyTestGenuninstall_dependencies) ##$(cmt_local_test_GPyTestGen_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GPyTestGen_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestGen_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_GPyTestGenuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_GPyTestGen"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_GPyTestGen done"
endif

#-- end of constituent ------
#-- start of constituent_app_lib ------

cmt_test_GPyTestDict_has_no_target_tag = 1
cmt_test_GPyTestDict_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_GPyTestDict_has_target_tag

cmt_local_tagfile_test_GPyTestDict = $(bin)$(GaudiPython_tag)_test_GPyTestDict.make
cmt_final_setup_test_GPyTestDict = $(bin)setup_test_GPyTestDict.make
cmt_local_test_GPyTestDict_makefile = $(bin)test_GPyTestDict.make

test_GPyTestDict_extratags = -tag_add=target_test_GPyTestDict

else

cmt_local_tagfile_test_GPyTestDict = $(bin)$(GaudiPython_tag).make
cmt_final_setup_test_GPyTestDict = $(bin)setup.make
cmt_local_test_GPyTestDict_makefile = $(bin)test_GPyTestDict.make

endif

not_test_GPyTestDictcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_GPyTestDictcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_GPyTestDictdirs :
	@if test ! -d $(bin)test_GPyTestDict; then $(mkdir) -p $(bin)test_GPyTestDict; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_GPyTestDict
else
test_GPyTestDictdirs : ;
endif

ifdef cmt_test_GPyTestDict_has_target_tag

ifndef QUICK
$(cmt_local_test_GPyTestDict_makefile) : $(test_GPyTestDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GPyTestDict.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GPyTestDict_extratags) build constituent_config -out=$(cmt_local_test_GPyTestDict_makefile) test_GPyTestDict
else
$(cmt_local_test_GPyTestDict_makefile) : $(test_GPyTestDictcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GPyTestDict) ] || \
	  [ ! -f $(cmt_final_setup_test_GPyTestDict) ] || \
	  $(not_test_GPyTestDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GPyTestDict.make"; \
	  $(cmtexe) -tag=$(tags) $(test_GPyTestDict_extratags) build constituent_config -out=$(cmt_local_test_GPyTestDict_makefile) test_GPyTestDict; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_GPyTestDict_makefile) : $(test_GPyTestDictcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_GPyTestDict.make"; \
	  $(cmtexe) -f=$(bin)test_GPyTestDict.in -tag=$(tags) $(test_GPyTestDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GPyTestDict_makefile) test_GPyTestDict
else
$(cmt_local_test_GPyTestDict_makefile) : $(test_GPyTestDictcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_GPyTestDict.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_GPyTestDict) ] || \
	  [ ! -f $(cmt_final_setup_test_GPyTestDict) ] || \
	  $(not_test_GPyTestDictcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_GPyTestDict.make"; \
	  $(cmtexe) -f=$(bin)test_GPyTestDict.in -tag=$(tags) $(test_GPyTestDict_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_GPyTestDict_makefile) test_GPyTestDict; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_GPyTestDict_extratags) build constituent_makefile -out=$(cmt_local_test_GPyTestDict_makefile) test_GPyTestDict

test_GPyTestDict :: test_GPyTestDictcompile test_GPyTestDictinstall ;

ifdef cmt_test_GPyTestDict_has_prototypes

test_GPyTestDictprototype : $(test_GPyTestDictprototype_dependencies) $(cmt_local_test_GPyTestDict_makefile) dirs test_GPyTestDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GPyTestDict_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_GPyTestDictcompile : test_GPyTestDictprototype

endif

test_GPyTestDictcompile : $(test_GPyTestDictcompile_dependencies) $(cmt_local_test_GPyTestDict_makefile) dirs test_GPyTestDictdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GPyTestDict_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_GPyTestDictclean ;

test_GPyTestDictclean :: $(test_GPyTestDictclean_dependencies) ##$(cmt_local_test_GPyTestDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GPyTestDict_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) test_GPyTestDictclean

##	  /bin/rm -f $(cmt_local_test_GPyTestDict_makefile) $(bin)test_GPyTestDict_dependencies.make

install :: test_GPyTestDictinstall ;

test_GPyTestDictinstall :: test_GPyTestDictcompile $(test_GPyTestDict_dependencies) $(cmt_local_test_GPyTestDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_GPyTestDict_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_GPyTestDictuninstall

$(foreach d,$(test_GPyTestDict_dependencies),$(eval $(d)uninstall_dependencies += test_GPyTestDictuninstall))

test_GPyTestDictuninstall : $(test_GPyTestDictuninstall_dependencies) ##$(cmt_local_test_GPyTestDict_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_GPyTestDict_makefile); then \
	  $(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_GPyTestDict_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_GPyTestDictuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_GPyTestDict"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_GPyTestDict done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiPython_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiPython_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiPython_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiPython_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiPython_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiPython_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiPython_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiPython_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiPython_tag).make
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
