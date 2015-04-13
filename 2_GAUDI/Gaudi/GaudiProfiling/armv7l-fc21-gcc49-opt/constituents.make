
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile = $(GaudiProfiling_tag).make
cmt_local_tagfile = $(bin)$(GaudiProfiling_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make
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

cmt_GaudiProfiling_has_no_target_tag = 1
cmt_GaudiProfiling_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiProfiling_has_target_tag

cmt_local_tagfile_GaudiProfiling = $(bin)$(GaudiProfiling_tag)_GaudiProfiling.make
cmt_final_setup_GaudiProfiling = $(bin)setup_GaudiProfiling.make
cmt_local_GaudiProfiling_makefile = $(bin)GaudiProfiling.make

GaudiProfiling_extratags = -tag_add=target_GaudiProfiling

else

cmt_local_tagfile_GaudiProfiling = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfiling = $(bin)setup.make
cmt_local_GaudiProfiling_makefile = $(bin)GaudiProfiling.make

endif

not_GaudiProfilingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingdirs :
	@if test ! -d $(bin)GaudiProfiling; then $(mkdir) -p $(bin)GaudiProfiling; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfiling
else
GaudiProfilingdirs : ;
endif

ifdef cmt_GaudiProfiling_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfiling_makefile) : $(GaudiProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_makefile) GaudiProfiling
else
$(cmt_local_GaudiProfiling_makefile) : $(GaudiProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling) ] || \
	  $(not_GaudiProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_makefile) GaudiProfiling; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfiling_makefile) : $(GaudiProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling.in -tag=$(tags) $(GaudiProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_makefile) GaudiProfiling
else
$(cmt_local_GaudiProfiling_makefile) : $(GaudiProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfiling.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling) ] || \
	  $(not_GaudiProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling.in -tag=$(tags) $(GaudiProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_makefile) GaudiProfiling; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfiling_makefile) GaudiProfiling

GaudiProfiling :: GaudiProfilingcompile GaudiProfilinginstall ;

ifdef cmt_GaudiProfiling_has_prototypes

GaudiProfilingprototype : $(GaudiProfilingprototype_dependencies) $(cmt_local_GaudiProfiling_makefile) dirs GaudiProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiProfilingcompile : GaudiProfilingprototype

endif

GaudiProfilingcompile : $(GaudiProfilingcompile_dependencies) $(cmt_local_GaudiProfiling_makefile) dirs GaudiProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiProfilingclean ;

GaudiProfilingclean :: $(GaudiProfilingclean_dependencies) ##$(cmt_local_GaudiProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfiling_makefile) GaudiProfilingclean

##	  /bin/rm -f $(cmt_local_GaudiProfiling_makefile) $(bin)GaudiProfiling_dependencies.make

install :: GaudiProfilinginstall ;

GaudiProfilinginstall :: GaudiProfilingcompile $(GaudiProfiling_dependencies) $(cmt_local_GaudiProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilinguninstall

$(foreach d,$(GaudiProfiling_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilinguninstall))

GaudiProfilinguninstall : $(GaudiProfilinguninstall_dependencies) ##$(cmt_local_GaudiProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilinguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfiling"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfiling done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiGenProfilingHtml_has_no_target_tag = 1
cmt_GaudiGenProfilingHtml_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGenProfilingHtml_has_target_tag

cmt_local_tagfile_GaudiGenProfilingHtml = $(bin)$(GaudiProfiling_tag)_GaudiGenProfilingHtml.make
cmt_final_setup_GaudiGenProfilingHtml = $(bin)setup_GaudiGenProfilingHtml.make
cmt_local_GaudiGenProfilingHtml_makefile = $(bin)GaudiGenProfilingHtml.make

GaudiGenProfilingHtml_extratags = -tag_add=target_GaudiGenProfilingHtml

else

cmt_local_tagfile_GaudiGenProfilingHtml = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGenProfilingHtml = $(bin)setup.make
cmt_local_GaudiGenProfilingHtml_makefile = $(bin)GaudiGenProfilingHtml.make

endif

not_GaudiGenProfilingHtmlcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGenProfilingHtmlcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGenProfilingHtmldirs :
	@if test ! -d $(bin)GaudiGenProfilingHtml; then $(mkdir) -p $(bin)GaudiGenProfilingHtml; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGenProfilingHtml
else
GaudiGenProfilingHtmldirs : ;
endif

ifdef cmt_GaudiGenProfilingHtml_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGenProfilingHtml_makefile) : $(GaudiGenProfilingHtmlcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGenProfilingHtml.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGenProfilingHtml_extratags) build constituent_config -out=$(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtml
else
$(cmt_local_GaudiGenProfilingHtml_makefile) : $(GaudiGenProfilingHtmlcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGenProfilingHtml) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGenProfilingHtml) ] || \
	  $(not_GaudiGenProfilingHtmlcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGenProfilingHtml.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGenProfilingHtml_extratags) build constituent_config -out=$(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtml; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGenProfilingHtml_makefile) : $(GaudiGenProfilingHtmlcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGenProfilingHtml.make"; \
	  $(cmtexe) -f=$(bin)GaudiGenProfilingHtml.in -tag=$(tags) $(GaudiGenProfilingHtml_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtml
else
$(cmt_local_GaudiGenProfilingHtml_makefile) : $(GaudiGenProfilingHtmlcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGenProfilingHtml.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGenProfilingHtml) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGenProfilingHtml) ] || \
	  $(not_GaudiGenProfilingHtmlcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGenProfilingHtml.make"; \
	  $(cmtexe) -f=$(bin)GaudiGenProfilingHtml.in -tag=$(tags) $(GaudiGenProfilingHtml_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtml; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGenProfilingHtml_extratags) build constituent_makefile -out=$(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtml

GaudiGenProfilingHtml :: GaudiGenProfilingHtmlcompile GaudiGenProfilingHtmlinstall ;

ifdef cmt_GaudiGenProfilingHtml_has_prototypes

GaudiGenProfilingHtmlprototype : $(GaudiGenProfilingHtmlprototype_dependencies) $(cmt_local_GaudiGenProfilingHtml_makefile) dirs GaudiGenProfilingHtmldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGenProfilingHtml_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiGenProfilingHtmlcompile : GaudiGenProfilingHtmlprototype

endif

GaudiGenProfilingHtmlcompile : $(GaudiGenProfilingHtmlcompile_dependencies) $(cmt_local_GaudiGenProfilingHtml_makefile) dirs GaudiGenProfilingHtmldirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGenProfilingHtml_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiGenProfilingHtmlclean ;

GaudiGenProfilingHtmlclean :: $(GaudiGenProfilingHtmlclean_dependencies) ##$(cmt_local_GaudiGenProfilingHtml_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGenProfilingHtml_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) GaudiGenProfilingHtmlclean

##	  /bin/rm -f $(cmt_local_GaudiGenProfilingHtml_makefile) $(bin)GaudiGenProfilingHtml_dependencies.make

install :: GaudiGenProfilingHtmlinstall ;

GaudiGenProfilingHtmlinstall :: GaudiGenProfilingHtmlcompile $(GaudiGenProfilingHtml_dependencies) $(cmt_local_GaudiGenProfilingHtml_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGenProfilingHtml_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGenProfilingHtmluninstall

$(foreach d,$(GaudiGenProfilingHtml_dependencies),$(eval $(d)uninstall_dependencies += GaudiGenProfilingHtmluninstall))

GaudiGenProfilingHtmluninstall : $(GaudiGenProfilingHtmluninstall_dependencies) ##$(cmt_local_GaudiGenProfilingHtml_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGenProfilingHtml_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGenProfilingHtml_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGenProfilingHtmluninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGenProfilingHtml"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGenProfilingHtml done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_GaudiGoogleProfiling_has_no_target_tag = 1
cmt_GaudiGoogleProfiling_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfiling_has_target_tag

cmt_local_tagfile_GaudiGoogleProfiling = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfiling.make
cmt_final_setup_GaudiGoogleProfiling = $(bin)setup_GaudiGoogleProfiling.make
cmt_local_GaudiGoogleProfiling_makefile = $(bin)GaudiGoogleProfiling.make

GaudiGoogleProfiling_extratags = -tag_add=target_GaudiGoogleProfiling

else

cmt_local_tagfile_GaudiGoogleProfiling = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGoogleProfiling = $(bin)setup.make
cmt_local_GaudiGoogleProfiling_makefile = $(bin)GaudiGoogleProfiling.make

endif

not_GaudiGoogleProfilingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGoogleProfilingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGoogleProfilingdirs :
	@if test ! -d $(bin)GaudiGoogleProfiling; then $(mkdir) -p $(bin)GaudiGoogleProfiling; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGoogleProfiling
else
GaudiGoogleProfilingdirs : ;
endif

ifdef cmt_GaudiGoogleProfiling_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGoogleProfiling_makefile) : $(GaudiGoogleProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfiling_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfiling
else
$(cmt_local_GaudiGoogleProfiling_makefile) : $(GaudiGoogleProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfiling) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfiling) ] || \
	  $(not_GaudiGoogleProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfiling_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfiling; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGoogleProfiling_makefile) : $(GaudiGoogleProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfiling.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfiling.in -tag=$(tags) $(GaudiGoogleProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfiling
else
$(cmt_local_GaudiGoogleProfiling_makefile) : $(GaudiGoogleProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGoogleProfiling.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfiling) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfiling) ] || \
	  $(not_GaudiGoogleProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfiling.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfiling.in -tag=$(tags) $(GaudiGoogleProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfiling; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfiling_extratags) build constituent_makefile -out=$(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfiling

GaudiGoogleProfiling :: GaudiGoogleProfilingcompile GaudiGoogleProfilinginstall ;

ifdef cmt_GaudiGoogleProfiling_has_prototypes

GaudiGoogleProfilingprototype : $(GaudiGoogleProfilingprototype_dependencies) $(cmt_local_GaudiGoogleProfiling_makefile) dirs GaudiGoogleProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

GaudiGoogleProfilingcompile : GaudiGoogleProfilingprototype

endif

GaudiGoogleProfilingcompile : $(GaudiGoogleProfilingcompile_dependencies) $(cmt_local_GaudiGoogleProfiling_makefile) dirs GaudiGoogleProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: GaudiGoogleProfilingclean ;

GaudiGoogleProfilingclean :: $(GaudiGoogleProfilingclean_dependencies) ##$(cmt_local_GaudiGoogleProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) GaudiGoogleProfilingclean

##	  /bin/rm -f $(cmt_local_GaudiGoogleProfiling_makefile) $(bin)GaudiGoogleProfiling_dependencies.make

install :: GaudiGoogleProfilinginstall ;

GaudiGoogleProfilinginstall :: GaudiGoogleProfilingcompile $(GaudiGoogleProfiling_dependencies) $(cmt_local_GaudiGoogleProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGoogleProfilinguninstall

$(foreach d,$(GaudiGoogleProfiling_dependencies),$(eval $(d)uninstall_dependencies += GaudiGoogleProfilinguninstall))

GaudiGoogleProfilinguninstall : $(GaudiGoogleProfilinguninstall_dependencies) ##$(cmt_local_GaudiGoogleProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfiling_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGoogleProfilinguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGoogleProfiling"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGoogleProfiling done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_IntelProfiler_has_no_target_tag = 1
cmt_IntelProfiler_has_prototypes = 1

#--------------------------------------

ifdef cmt_IntelProfiler_has_target_tag

cmt_local_tagfile_IntelProfiler = $(bin)$(GaudiProfiling_tag)_IntelProfiler.make
cmt_final_setup_IntelProfiler = $(bin)setup_IntelProfiler.make
cmt_local_IntelProfiler_makefile = $(bin)IntelProfiler.make

IntelProfiler_extratags = -tag_add=target_IntelProfiler

else

cmt_local_tagfile_IntelProfiler = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_IntelProfiler = $(bin)setup.make
cmt_local_IntelProfiler_makefile = $(bin)IntelProfiler.make

endif

not_IntelProfilercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(IntelProfilercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntelProfilerdirs :
	@if test ! -d $(bin)IntelProfiler; then $(mkdir) -p $(bin)IntelProfiler; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntelProfiler
else
IntelProfilerdirs : ;
endif

ifdef cmt_IntelProfiler_has_target_tag

ifndef QUICK
$(cmt_local_IntelProfiler_makefile) : $(IntelProfilercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfiler.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfiler_extratags) build constituent_config -out=$(cmt_local_IntelProfiler_makefile) IntelProfiler
else
$(cmt_local_IntelProfiler_makefile) : $(IntelProfilercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfiler) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfiler) ] || \
	  $(not_IntelProfilercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfiler.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfiler_extratags) build constituent_config -out=$(cmt_local_IntelProfiler_makefile) IntelProfiler; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntelProfiler_makefile) : $(IntelProfilercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfiler.make"; \
	  $(cmtexe) -f=$(bin)IntelProfiler.in -tag=$(tags) $(IntelProfiler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfiler_makefile) IntelProfiler
else
$(cmt_local_IntelProfiler_makefile) : $(IntelProfilercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)IntelProfiler.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfiler) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfiler) ] || \
	  $(not_IntelProfilercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfiler.make"; \
	  $(cmtexe) -f=$(bin)IntelProfiler.in -tag=$(tags) $(IntelProfiler_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfiler_makefile) IntelProfiler; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntelProfiler_extratags) build constituent_makefile -out=$(cmt_local_IntelProfiler_makefile) IntelProfiler

IntelProfiler :: IntelProfilercompile IntelProfilerinstall ;

ifdef cmt_IntelProfiler_has_prototypes

IntelProfilerprototype : $(IntelProfilerprototype_dependencies) $(cmt_local_IntelProfiler_makefile) dirs IntelProfilerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfiler_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@
	$(echo) "(constituents.make) $@ done"

IntelProfilercompile : IntelProfilerprototype

endif

IntelProfilercompile : $(IntelProfilercompile_dependencies) $(cmt_local_IntelProfiler_makefile) dirs IntelProfilerdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfiler_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: IntelProfilerclean ;

IntelProfilerclean :: $(IntelProfilerclean_dependencies) ##$(cmt_local_IntelProfiler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfiler_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_IntelProfiler_makefile) IntelProfilerclean

##	  /bin/rm -f $(cmt_local_IntelProfiler_makefile) $(bin)IntelProfiler_dependencies.make

install :: IntelProfilerinstall ;

IntelProfilerinstall :: IntelProfilercompile $(IntelProfiler_dependencies) $(cmt_local_IntelProfiler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfiler_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfiler_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : IntelProfileruninstall

$(foreach d,$(IntelProfiler_dependencies),$(eval $(d)uninstall_dependencies += IntelProfileruninstall))

IntelProfileruninstall : $(IntelProfileruninstall_dependencies) ##$(cmt_local_IntelProfiler_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfiler_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfiler_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfiler_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntelProfileruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntelProfiler"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntelProfiler done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_GaudiProfilingComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingComponentsList_has_target_tag

cmt_local_tagfile_GaudiProfilingComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiProfilingComponentsList.make
cmt_final_setup_GaudiProfilingComponentsList = $(bin)setup_GaudiProfilingComponentsList.make
cmt_local_GaudiProfilingComponentsList_makefile = $(bin)GaudiProfilingComponentsList.make

GaudiProfilingComponentsList_extratags = -tag_add=target_GaudiProfilingComponentsList

else

cmt_local_tagfile_GaudiProfilingComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingComponentsList = $(bin)setup.make
cmt_local_GaudiProfilingComponentsList_makefile = $(bin)GaudiProfilingComponentsList.make

endif

not_GaudiProfilingComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingComponentsListdirs :
	@if test ! -d $(bin)GaudiProfilingComponentsList; then $(mkdir) -p $(bin)GaudiProfilingComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingComponentsList
else
GaudiProfilingComponentsListdirs : ;
endif

ifdef cmt_GaudiProfilingComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingComponentsList_makefile) : $(GaudiProfilingComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList
else
$(cmt_local_GaudiProfilingComponentsList_makefile) : $(GaudiProfilingComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingComponentsList) ] || \
	  $(not_GaudiProfilingComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingComponentsList_makefile) : $(GaudiProfilingComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingComponentsList.in -tag=$(tags) $(GaudiProfilingComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList
else
$(cmt_local_GaudiProfilingComponentsList_makefile) : $(GaudiProfilingComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingComponentsList) ] || \
	  $(not_GaudiProfilingComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingComponentsList.in -tag=$(tags) $(GaudiProfilingComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList

GaudiProfilingComponentsList :: $(GaudiProfilingComponentsList_dependencies) $(cmt_local_GaudiProfilingComponentsList_makefile) dirs GaudiProfilingComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiProfilingComponentsList"
	@if test -f $(cmt_local_GaudiProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsList
	$(echo) "(constituents.make) GaudiProfilingComponentsList done"

clean :: GaudiProfilingComponentsListclean ;

GaudiProfilingComponentsListclean :: $(GaudiProfilingComponentsListclean_dependencies) ##$(cmt_local_GaudiProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingComponentsListclean"
	@-if test -f $(cmt_local_GaudiProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) GaudiProfilingComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingComponentsList_makefile) $(bin)GaudiProfilingComponentsList_dependencies.make

install :: GaudiProfilingComponentsListinstall ;

GaudiProfilingComponentsListinstall :: $(GaudiProfilingComponentsList_dependencies) $(cmt_local_GaudiProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingComponentsListuninstall

$(foreach d,$(GaudiProfilingComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingComponentsListuninstall))

GaudiProfilingComponentsListuninstall : $(GaudiProfilingComponentsListuninstall_dependencies) ##$(cmt_local_GaudiProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfilingMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiProfilingMergeComponentsList.make
cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)setup_GaudiProfilingMergeComponentsList.make
cmt_local_GaudiProfilingMergeComponentsList_makefile = $(bin)GaudiProfilingMergeComponentsList.make

GaudiProfilingMergeComponentsList_extratags = -tag_add=target_GaudiProfilingMergeComponentsList

else

cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)setup.make
cmt_local_GaudiProfilingMergeComponentsList_makefile = $(bin)GaudiProfilingMergeComponentsList.make

endif

not_GaudiProfilingMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiProfilingMergeComponentsList; then $(mkdir) -p $(bin)GaudiProfilingMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingMergeComponentsList
else
GaudiProfilingMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiProfilingMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingMergeComponentsList_makefile) : $(GaudiProfilingMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList
else
$(cmt_local_GaudiProfilingMergeComponentsList_makefile) : $(GaudiProfilingMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingMergeComponentsList) ] || \
	  $(not_GaudiProfilingMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingMergeComponentsList_makefile) : $(GaudiProfilingMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingMergeComponentsList.in -tag=$(tags) $(GaudiProfilingMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList
else
$(cmt_local_GaudiProfilingMergeComponentsList_makefile) : $(GaudiProfilingMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingMergeComponentsList) ] || \
	  $(not_GaudiProfilingMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingMergeComponentsList.in -tag=$(tags) $(GaudiProfilingMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList

GaudiProfilingMergeComponentsList :: $(GaudiProfilingMergeComponentsList_dependencies) $(cmt_local_GaudiProfilingMergeComponentsList_makefile) dirs GaudiProfilingMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiProfilingMergeComponentsList"
	@if test -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsList
	$(echo) "(constituents.make) GaudiProfilingMergeComponentsList done"

clean :: GaudiProfilingMergeComponentsListclean ;

GaudiProfilingMergeComponentsListclean :: $(GaudiProfilingMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) GaudiProfilingMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) $(bin)GaudiProfilingMergeComponentsList_dependencies.make

install :: GaudiProfilingMergeComponentsListinstall ;

GaudiProfilingMergeComponentsListinstall :: $(GaudiProfilingMergeComponentsList_dependencies) $(cmt_local_GaudiProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingMergeComponentsListuninstall

$(foreach d,$(GaudiProfilingMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingMergeComponentsListuninstall))

GaudiProfilingMergeComponentsListuninstall : $(GaudiProfilingMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfilingConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingConf_has_target_tag

cmt_local_tagfile_GaudiProfilingConf = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConf.make
cmt_final_setup_GaudiProfilingConf = $(bin)setup_GaudiProfilingConf.make
cmt_local_GaudiProfilingConf_makefile = $(bin)GaudiProfilingConf.make

GaudiProfilingConf_extratags = -tag_add=target_GaudiProfilingConf

else

cmt_local_tagfile_GaudiProfilingConf = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingConf = $(bin)setup.make
cmt_local_GaudiProfilingConf_makefile = $(bin)GaudiProfilingConf.make

endif

not_GaudiProfilingConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingConfdirs :
	@if test ! -d $(bin)GaudiProfilingConf; then $(mkdir) -p $(bin)GaudiProfilingConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingConf
else
GaudiProfilingConfdirs : ;
endif

ifdef cmt_GaudiProfilingConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingConf_makefile) : $(GaudiProfilingConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConf_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf
else
$(cmt_local_GaudiProfilingConf_makefile) : $(GaudiProfilingConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConf) ] || \
	  $(not_GaudiProfilingConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConf_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingConf_makefile) : $(GaudiProfilingConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConf.in -tag=$(tags) $(GaudiProfilingConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf
else
$(cmt_local_GaudiProfilingConf_makefile) : $(GaudiProfilingConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConf) ] || \
	  $(not_GaudiProfilingConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConf.in -tag=$(tags) $(GaudiProfilingConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf

GaudiProfilingConf :: $(GaudiProfilingConf_dependencies) $(cmt_local_GaudiProfilingConf_makefile) dirs GaudiProfilingConfdirs
	$(echo) "(constituents.make) Starting GaudiProfilingConf"
	@if test -f $(cmt_local_GaudiProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConf
	$(echo) "(constituents.make) GaudiProfilingConf done"

clean :: GaudiProfilingConfclean ;

GaudiProfilingConfclean :: $(GaudiProfilingConfclean_dependencies) ##$(cmt_local_GaudiProfilingConf_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingConfclean"
	@-if test -f $(cmt_local_GaudiProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConfclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) GaudiProfilingConfclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingConf_makefile) $(bin)GaudiProfilingConf_dependencies.make

install :: GaudiProfilingConfinstall ;

GaudiProfilingConfinstall :: $(GaudiProfilingConf_dependencies) $(cmt_local_GaudiProfilingConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingConfuninstall

$(foreach d,$(GaudiProfilingConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingConfuninstall))

GaudiProfilingConfuninstall : $(GaudiProfilingConfuninstall_dependencies) ##$(cmt_local_GaudiProfilingConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfiling_python_init_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfiling_python_init_has_target_tag

cmt_local_tagfile_GaudiProfiling_python_init = $(bin)$(GaudiProfiling_tag)_GaudiProfiling_python_init.make
cmt_final_setup_GaudiProfiling_python_init = $(bin)setup_GaudiProfiling_python_init.make
cmt_local_GaudiProfiling_python_init_makefile = $(bin)GaudiProfiling_python_init.make

GaudiProfiling_python_init_extratags = -tag_add=target_GaudiProfiling_python_init

else

cmt_local_tagfile_GaudiProfiling_python_init = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfiling_python_init = $(bin)setup.make
cmt_local_GaudiProfiling_python_init_makefile = $(bin)GaudiProfiling_python_init.make

endif

not_GaudiProfiling_python_init_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfiling_python_init_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfiling_python_initdirs :
	@if test ! -d $(bin)GaudiProfiling_python_init; then $(mkdir) -p $(bin)GaudiProfiling_python_init; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfiling_python_init
else
GaudiProfiling_python_initdirs : ;
endif

ifdef cmt_GaudiProfiling_python_init_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfiling_python_init_makefile) : $(GaudiProfiling_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init
else
$(cmt_local_GaudiProfiling_python_init_makefile) : $(GaudiProfiling_python_init_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling_python_init) ] || \
	  $(not_GaudiProfiling_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling_python_init.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_init_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfiling_python_init_makefile) : $(GaudiProfiling_python_init_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling_python_init.in -tag=$(tags) $(GaudiProfiling_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init
else
$(cmt_local_GaudiProfiling_python_init_makefile) : $(GaudiProfiling_python_init_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfiling_python_init.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling_python_init) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling_python_init) ] || \
	  $(not_GaudiProfiling_python_init_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling_python_init.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling_python_init.in -tag=$(tags) $(GaudiProfiling_python_init_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_init_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init

GaudiProfiling_python_init :: $(GaudiProfiling_python_init_dependencies) $(cmt_local_GaudiProfiling_python_init_makefile) dirs GaudiProfiling_python_initdirs
	$(echo) "(constituents.make) Starting GaudiProfiling_python_init"
	@if test -f $(cmt_local_GaudiProfiling_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_init
	$(echo) "(constituents.make) GaudiProfiling_python_init done"

clean :: GaudiProfiling_python_initclean ;

GaudiProfiling_python_initclean :: $(GaudiProfiling_python_initclean_dependencies) ##$(cmt_local_GaudiProfiling_python_init_makefile)
	$(echo) "(constituents.make) Starting GaudiProfiling_python_initclean"
	@-if test -f $(cmt_local_GaudiProfiling_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_initclean; \
	fi
	$(echo) "(constituents.make) GaudiProfiling_python_initclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) GaudiProfiling_python_initclean

##	  /bin/rm -f $(cmt_local_GaudiProfiling_python_init_makefile) $(bin)GaudiProfiling_python_init_dependencies.make

install :: GaudiProfiling_python_initinstall ;

GaudiProfiling_python_initinstall :: $(GaudiProfiling_python_init_dependencies) $(cmt_local_GaudiProfiling_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfiling_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfiling_python_inituninstall

$(foreach d,$(GaudiProfiling_python_init_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfiling_python_inituninstall))

GaudiProfiling_python_inituninstall : $(GaudiProfiling_python_inituninstall_dependencies) ##$(cmt_local_GaudiProfiling_python_init_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfiling_python_init_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_python_init_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfiling_python_inituninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfiling_python_init"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfiling_python_init done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_zip_GaudiProfiling_python_modules_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_zip_GaudiProfiling_python_modules_has_target_tag

cmt_local_tagfile_zip_GaudiProfiling_python_modules = $(bin)$(GaudiProfiling_tag)_zip_GaudiProfiling_python_modules.make
cmt_final_setup_zip_GaudiProfiling_python_modules = $(bin)setup_zip_GaudiProfiling_python_modules.make
cmt_local_zip_GaudiProfiling_python_modules_makefile = $(bin)zip_GaudiProfiling_python_modules.make

zip_GaudiProfiling_python_modules_extratags = -tag_add=target_zip_GaudiProfiling_python_modules

else

cmt_local_tagfile_zip_GaudiProfiling_python_modules = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_zip_GaudiProfiling_python_modules = $(bin)setup.make
cmt_local_zip_GaudiProfiling_python_modules_makefile = $(bin)zip_GaudiProfiling_python_modules.make

endif

not_zip_GaudiProfiling_python_modules_dependencies = { n=0; for p in $?; do m=0; for d in $(zip_GaudiProfiling_python_modules_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
zip_GaudiProfiling_python_modulesdirs :
	@if test ! -d $(bin)zip_GaudiProfiling_python_modules; then $(mkdir) -p $(bin)zip_GaudiProfiling_python_modules; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)zip_GaudiProfiling_python_modules
else
zip_GaudiProfiling_python_modulesdirs : ;
endif

ifdef cmt_zip_GaudiProfiling_python_modules_has_target_tag

ifndef QUICK
$(cmt_local_zip_GaudiProfiling_python_modules_makefile) : $(zip_GaudiProfiling_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiProfiling_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiProfiling_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules
else
$(cmt_local_zip_GaudiProfiling_python_modules_makefile) : $(zip_GaudiProfiling_python_modules_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiProfiling_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiProfiling_python_modules) ] || \
	  $(not_zip_GaudiProfiling_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiProfiling_python_modules.make"; \
	  $(cmtexe) -tag=$(tags) $(zip_GaudiProfiling_python_modules_extratags) build constituent_config -out=$(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_zip_GaudiProfiling_python_modules_makefile) : $(zip_GaudiProfiling_python_modules_dependencies) build_library_links
	$(echo) "(constituents.make) Building zip_GaudiProfiling_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiProfiling_python_modules.in -tag=$(tags) $(zip_GaudiProfiling_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules
else
$(cmt_local_zip_GaudiProfiling_python_modules_makefile) : $(zip_GaudiProfiling_python_modules_dependencies) $(cmt_build_library_linksstamp) $(bin)zip_GaudiProfiling_python_modules.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_zip_GaudiProfiling_python_modules) ] || \
	  [ ! -f $(cmt_final_setup_zip_GaudiProfiling_python_modules) ] || \
	  $(not_zip_GaudiProfiling_python_modules_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building zip_GaudiProfiling_python_modules.make"; \
	  $(cmtexe) -f=$(bin)zip_GaudiProfiling_python_modules.in -tag=$(tags) $(zip_GaudiProfiling_python_modules_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(zip_GaudiProfiling_python_modules_extratags) build constituent_makefile -out=$(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules

zip_GaudiProfiling_python_modules :: $(zip_GaudiProfiling_python_modules_dependencies) $(cmt_local_zip_GaudiProfiling_python_modules_makefile) dirs zip_GaudiProfiling_python_modulesdirs
	$(echo) "(constituents.make) Starting zip_GaudiProfiling_python_modules"
	@if test -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modules
	$(echo) "(constituents.make) zip_GaudiProfiling_python_modules done"

clean :: zip_GaudiProfiling_python_modulesclean ;

zip_GaudiProfiling_python_modulesclean :: $(zip_GaudiProfiling_python_modulesclean_dependencies) ##$(cmt_local_zip_GaudiProfiling_python_modules_makefile)
	$(echo) "(constituents.make) Starting zip_GaudiProfiling_python_modulesclean"
	@-if test -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modulesclean; \
	fi
	$(echo) "(constituents.make) zip_GaudiProfiling_python_modulesclean done"
#	@-$(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) zip_GaudiProfiling_python_modulesclean

##	  /bin/rm -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) $(bin)zip_GaudiProfiling_python_modules_dependencies.make

install :: zip_GaudiProfiling_python_modulesinstall ;

zip_GaudiProfiling_python_modulesinstall :: $(zip_GaudiProfiling_python_modules_dependencies) $(cmt_local_zip_GaudiProfiling_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : zip_GaudiProfiling_python_modulesuninstall

$(foreach d,$(zip_GaudiProfiling_python_modules_dependencies),$(eval $(d)uninstall_dependencies += zip_GaudiProfiling_python_modulesuninstall))

zip_GaudiProfiling_python_modulesuninstall : $(zip_GaudiProfiling_python_modulesuninstall_dependencies) ##$(cmt_local_zip_GaudiProfiling_python_modules_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile); then \
	  $(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_zip_GaudiProfiling_python_modules_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: zip_GaudiProfiling_python_modulesuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ zip_GaudiProfiling_python_modules"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ zip_GaudiProfiling_python_modules done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfilingConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConfDbMerge.make
cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)setup_GaudiProfilingConfDbMerge.make
cmt_local_GaudiProfilingConfDbMerge_makefile = $(bin)GaudiProfilingConfDbMerge.make

GaudiProfilingConfDbMerge_extratags = -tag_add=target_GaudiProfilingConfDbMerge

else

cmt_local_tagfile_GaudiProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)setup.make
cmt_local_GaudiProfilingConfDbMerge_makefile = $(bin)GaudiProfilingConfDbMerge.make

endif

not_GaudiProfilingConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingConfDbMergedirs :
	@if test ! -d $(bin)GaudiProfilingConfDbMerge; then $(mkdir) -p $(bin)GaudiProfilingConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingConfDbMerge
else
GaudiProfilingConfDbMergedirs : ;
endif

ifdef cmt_GaudiProfilingConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingConfDbMerge_makefile) : $(GaudiProfilingConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge
else
$(cmt_local_GaudiProfilingConfDbMerge_makefile) : $(GaudiProfilingConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConfDbMerge) ] || \
	  $(not_GaudiProfilingConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingConfDbMerge_makefile) : $(GaudiProfilingConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConfDbMerge.in -tag=$(tags) $(GaudiProfilingConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge
else
$(cmt_local_GaudiProfilingConfDbMerge_makefile) : $(GaudiProfilingConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConfDbMerge) ] || \
	  $(not_GaudiProfilingConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConfDbMerge.in -tag=$(tags) $(GaudiProfilingConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge

GaudiProfilingConfDbMerge :: $(GaudiProfilingConfDbMerge_dependencies) $(cmt_local_GaudiProfilingConfDbMerge_makefile) dirs GaudiProfilingConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiProfilingConfDbMerge"
	@if test -f $(cmt_local_GaudiProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMerge
	$(echo) "(constituents.make) GaudiProfilingConfDbMerge done"

clean :: GaudiProfilingConfDbMergeclean ;

GaudiProfilingConfDbMergeclean :: $(GaudiProfilingConfDbMergeclean_dependencies) ##$(cmt_local_GaudiProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) GaudiProfilingConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) $(bin)GaudiProfilingConfDbMerge_dependencies.make

install :: GaudiProfilingConfDbMergeinstall ;

GaudiProfilingConfDbMergeinstall :: $(GaudiProfilingConfDbMerge_dependencies) $(cmt_local_GaudiProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingConfDbMergeuninstall

$(foreach d,$(GaudiProfilingConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingConfDbMergeuninstall))

GaudiProfilingConfDbMergeuninstall : $(GaudiProfilingConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGoogleProfilingComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfilingComponentsList_has_target_tag

cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingComponentsList.make
cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)setup_GaudiGoogleProfilingComponentsList.make
cmt_local_GaudiGoogleProfilingComponentsList_makefile = $(bin)GaudiGoogleProfilingComponentsList.make

GaudiGoogleProfilingComponentsList_extratags = -tag_add=target_GaudiGoogleProfilingComponentsList

else

cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)setup.make
cmt_local_GaudiGoogleProfilingComponentsList_makefile = $(bin)GaudiGoogleProfilingComponentsList.make

endif

not_GaudiGoogleProfilingComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGoogleProfilingComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGoogleProfilingComponentsListdirs :
	@if test ! -d $(bin)GaudiGoogleProfilingComponentsList; then $(mkdir) -p $(bin)GaudiGoogleProfilingComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGoogleProfilingComponentsList
else
GaudiGoogleProfilingComponentsListdirs : ;
endif

ifdef cmt_GaudiGoogleProfilingComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) : $(GaudiGoogleProfilingComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList
else
$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) : $(GaudiGoogleProfilingComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingComponentsList) ] || \
	  $(not_GaudiGoogleProfilingComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) : $(GaudiGoogleProfilingComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingComponentsList.in -tag=$(tags) $(GaudiGoogleProfilingComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList
else
$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) : $(GaudiGoogleProfilingComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGoogleProfilingComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingComponentsList) ] || \
	  $(not_GaudiGoogleProfilingComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingComponentsList.in -tag=$(tags) $(GaudiGoogleProfilingComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList

GaudiGoogleProfilingComponentsList :: $(GaudiGoogleProfilingComponentsList_dependencies) $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) dirs GaudiGoogleProfilingComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingComponentsList"
	@if test -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsList
	$(echo) "(constituents.make) GaudiGoogleProfilingComponentsList done"

clean :: GaudiGoogleProfilingComponentsListclean ;

GaudiGoogleProfilingComponentsListclean :: $(GaudiGoogleProfilingComponentsListclean_dependencies) ##$(cmt_local_GaudiGoogleProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingComponentsListclean"
	@-if test -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiGoogleProfilingComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) GaudiGoogleProfilingComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) $(bin)GaudiGoogleProfilingComponentsList_dependencies.make

install :: GaudiGoogleProfilingComponentsListinstall ;

GaudiGoogleProfilingComponentsListinstall :: $(GaudiGoogleProfilingComponentsList_dependencies) $(cmt_local_GaudiGoogleProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGoogleProfilingComponentsListuninstall

$(foreach d,$(GaudiGoogleProfilingComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiGoogleProfilingComponentsListuninstall))

GaudiGoogleProfilingComponentsListuninstall : $(GaudiGoogleProfilingComponentsListuninstall_dependencies) ##$(cmt_local_GaudiGoogleProfilingComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGoogleProfilingComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGoogleProfilingComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGoogleProfilingComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGoogleProfilingMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfilingMergeComponentsList_has_target_tag

cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingMergeComponentsList.make
cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)setup_GaudiGoogleProfilingMergeComponentsList.make
cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile = $(bin)GaudiGoogleProfilingMergeComponentsList.make

GaudiGoogleProfilingMergeComponentsList_extratags = -tag_add=target_GaudiGoogleProfilingMergeComponentsList

else

cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)setup.make
cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile = $(bin)GaudiGoogleProfilingMergeComponentsList.make

endif

not_GaudiGoogleProfilingMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGoogleProfilingMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGoogleProfilingMergeComponentsListdirs :
	@if test ! -d $(bin)GaudiGoogleProfilingMergeComponentsList; then $(mkdir) -p $(bin)GaudiGoogleProfilingMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGoogleProfilingMergeComponentsList
else
GaudiGoogleProfilingMergeComponentsListdirs : ;
endif

ifdef cmt_GaudiGoogleProfilingMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) : $(GaudiGoogleProfilingMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList
else
$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) : $(GaudiGoogleProfilingMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingMergeComponentsList) ] || \
	  $(not_GaudiGoogleProfilingMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) : $(GaudiGoogleProfilingMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingMergeComponentsList.in -tag=$(tags) $(GaudiGoogleProfilingMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList
else
$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) : $(GaudiGoogleProfilingMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGoogleProfilingMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingMergeComponentsList) ] || \
	  $(not_GaudiGoogleProfilingMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingMergeComponentsList.in -tag=$(tags) $(GaudiGoogleProfilingMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList

GaudiGoogleProfilingMergeComponentsList :: $(GaudiGoogleProfilingMergeComponentsList_dependencies) $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) dirs GaudiGoogleProfilingMergeComponentsListdirs
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingMergeComponentsList"
	@if test -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsList
	$(echo) "(constituents.make) GaudiGoogleProfilingMergeComponentsList done"

clean :: GaudiGoogleProfilingMergeComponentsListclean ;

GaudiGoogleProfilingMergeComponentsListclean :: $(GaudiGoogleProfilingMergeComponentsListclean_dependencies) ##$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingMergeComponentsListclean"
	@-if test -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) GaudiGoogleProfilingMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) GaudiGoogleProfilingMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) $(bin)GaudiGoogleProfilingMergeComponentsList_dependencies.make

install :: GaudiGoogleProfilingMergeComponentsListinstall ;

GaudiGoogleProfilingMergeComponentsListinstall :: $(GaudiGoogleProfilingMergeComponentsList_dependencies) $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGoogleProfilingMergeComponentsListuninstall

$(foreach d,$(GaudiGoogleProfilingMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += GaudiGoogleProfilingMergeComponentsListuninstall))

GaudiGoogleProfilingMergeComponentsListuninstall : $(GaudiGoogleProfilingMergeComponentsListuninstall_dependencies) ##$(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGoogleProfilingMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGoogleProfilingMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGoogleProfilingMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGoogleProfilingConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfilingConf_has_target_tag

cmt_local_tagfile_GaudiGoogleProfilingConf = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingConf.make
cmt_final_setup_GaudiGoogleProfilingConf = $(bin)setup_GaudiGoogleProfilingConf.make
cmt_local_GaudiGoogleProfilingConf_makefile = $(bin)GaudiGoogleProfilingConf.make

GaudiGoogleProfilingConf_extratags = -tag_add=target_GaudiGoogleProfilingConf

else

cmt_local_tagfile_GaudiGoogleProfilingConf = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGoogleProfilingConf = $(bin)setup.make
cmt_local_GaudiGoogleProfilingConf_makefile = $(bin)GaudiGoogleProfilingConf.make

endif

not_GaudiGoogleProfilingConf_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGoogleProfilingConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGoogleProfilingConfdirs :
	@if test ! -d $(bin)GaudiGoogleProfilingConf; then $(mkdir) -p $(bin)GaudiGoogleProfilingConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGoogleProfilingConf
else
GaudiGoogleProfilingConfdirs : ;
endif

ifdef cmt_GaudiGoogleProfilingConf_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingConf_makefile) : $(GaudiGoogleProfilingConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConf_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf
else
$(cmt_local_GaudiGoogleProfilingConf_makefile) : $(GaudiGoogleProfilingConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingConf) ] || \
	  $(not_GaudiGoogleProfilingConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingConf.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConf_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingConf_makefile) : $(GaudiGoogleProfilingConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingConf.in -tag=$(tags) $(GaudiGoogleProfilingConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf
else
$(cmt_local_GaudiGoogleProfilingConf_makefile) : $(GaudiGoogleProfilingConf_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGoogleProfilingConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingConf) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingConf) ] || \
	  $(not_GaudiGoogleProfilingConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingConf.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingConf.in -tag=$(tags) $(GaudiGoogleProfilingConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConf_extratags) build constituent_makefile -out=$(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf

GaudiGoogleProfilingConf :: $(GaudiGoogleProfilingConf_dependencies) $(cmt_local_GaudiGoogleProfilingConf_makefile) dirs GaudiGoogleProfilingConfdirs
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingConf"
	@if test -f $(cmt_local_GaudiGoogleProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConf
	$(echo) "(constituents.make) GaudiGoogleProfilingConf done"

clean :: GaudiGoogleProfilingConfclean ;

GaudiGoogleProfilingConfclean :: $(GaudiGoogleProfilingConfclean_dependencies) ##$(cmt_local_GaudiGoogleProfilingConf_makefile)
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingConfclean"
	@-if test -f $(cmt_local_GaudiGoogleProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConfclean; \
	fi
	$(echo) "(constituents.make) GaudiGoogleProfilingConfclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) GaudiGoogleProfilingConfclean

##	  /bin/rm -f $(cmt_local_GaudiGoogleProfilingConf_makefile) $(bin)GaudiGoogleProfilingConf_dependencies.make

install :: GaudiGoogleProfilingConfinstall ;

GaudiGoogleProfilingConfinstall :: $(GaudiGoogleProfilingConf_dependencies) $(cmt_local_GaudiGoogleProfilingConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGoogleProfilingConfuninstall

$(foreach d,$(GaudiGoogleProfilingConf_dependencies),$(eval $(d)uninstall_dependencies += GaudiGoogleProfilingConfuninstall))

GaudiGoogleProfilingConfuninstall : $(GaudiGoogleProfilingConfuninstall_dependencies) ##$(cmt_local_GaudiGoogleProfilingConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfilingConf_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGoogleProfilingConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGoogleProfilingConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGoogleProfilingConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiGoogleProfilingConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiGoogleProfilingConfDbMerge_has_target_tag

cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingConfDbMerge.make
cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)setup_GaudiGoogleProfilingConfDbMerge.make
cmt_local_GaudiGoogleProfilingConfDbMerge_makefile = $(bin)GaudiGoogleProfilingConfDbMerge.make

GaudiGoogleProfilingConfDbMerge_extratags = -tag_add=target_GaudiGoogleProfilingConfDbMerge

else

cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)setup.make
cmt_local_GaudiGoogleProfilingConfDbMerge_makefile = $(bin)GaudiGoogleProfilingConfDbMerge.make

endif

not_GaudiGoogleProfilingConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiGoogleProfilingConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiGoogleProfilingConfDbMergedirs :
	@if test ! -d $(bin)GaudiGoogleProfilingConfDbMerge; then $(mkdir) -p $(bin)GaudiGoogleProfilingConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiGoogleProfilingConfDbMerge
else
GaudiGoogleProfilingConfDbMergedirs : ;
endif

ifdef cmt_GaudiGoogleProfilingConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) : $(GaudiGoogleProfilingConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge
else
$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) : $(GaudiGoogleProfilingConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingConfDbMerge) ] || \
	  $(not_GaudiGoogleProfilingConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConfDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) : $(GaudiGoogleProfilingConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiGoogleProfilingConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingConfDbMerge.in -tag=$(tags) $(GaudiGoogleProfilingConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge
else
$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) : $(GaudiGoogleProfilingConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiGoogleProfilingConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiGoogleProfilingConfDbMerge) ] || \
	  $(not_GaudiGoogleProfilingConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiGoogleProfilingConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiGoogleProfilingConfDbMerge.in -tag=$(tags) $(GaudiGoogleProfilingConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiGoogleProfilingConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge

GaudiGoogleProfilingConfDbMerge :: $(GaudiGoogleProfilingConfDbMerge_dependencies) $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) dirs GaudiGoogleProfilingConfDbMergedirs
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingConfDbMerge"
	@if test -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMerge
	$(echo) "(constituents.make) GaudiGoogleProfilingConfDbMerge done"

clean :: GaudiGoogleProfilingConfDbMergeclean ;

GaudiGoogleProfilingConfDbMergeclean :: $(GaudiGoogleProfilingConfDbMergeclean_dependencies) ##$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiGoogleProfilingConfDbMergeclean"
	@-if test -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiGoogleProfilingConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) GaudiGoogleProfilingConfDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) $(bin)GaudiGoogleProfilingConfDbMerge_dependencies.make

install :: GaudiGoogleProfilingConfDbMergeinstall ;

GaudiGoogleProfilingConfDbMergeinstall :: $(GaudiGoogleProfilingConfDbMerge_dependencies) $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiGoogleProfilingConfDbMergeuninstall

$(foreach d,$(GaudiGoogleProfilingConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiGoogleProfilingConfDbMergeuninstall))

GaudiGoogleProfilingConfDbMergeuninstall : $(GaudiGoogleProfilingConfDbMergeuninstall_dependencies) ##$(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiGoogleProfilingConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiGoogleProfilingConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiGoogleProfilingConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiGoogleProfilingConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_IntelProfilerComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_IntelProfilerComponentsList_has_target_tag

cmt_local_tagfile_IntelProfilerComponentsList = $(bin)$(GaudiProfiling_tag)_IntelProfilerComponentsList.make
cmt_final_setup_IntelProfilerComponentsList = $(bin)setup_IntelProfilerComponentsList.make
cmt_local_IntelProfilerComponentsList_makefile = $(bin)IntelProfilerComponentsList.make

IntelProfilerComponentsList_extratags = -tag_add=target_IntelProfilerComponentsList

else

cmt_local_tagfile_IntelProfilerComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_IntelProfilerComponentsList = $(bin)setup.make
cmt_local_IntelProfilerComponentsList_makefile = $(bin)IntelProfilerComponentsList.make

endif

not_IntelProfilerComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(IntelProfilerComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntelProfilerComponentsListdirs :
	@if test ! -d $(bin)IntelProfilerComponentsList; then $(mkdir) -p $(bin)IntelProfilerComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntelProfilerComponentsList
else
IntelProfilerComponentsListdirs : ;
endif

ifdef cmt_IntelProfilerComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_IntelProfilerComponentsList_makefile) : $(IntelProfilerComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerComponentsList_extratags) build constituent_config -out=$(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList
else
$(cmt_local_IntelProfilerComponentsList_makefile) : $(IntelProfilerComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerComponentsList) ] || \
	  $(not_IntelProfilerComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerComponentsList_extratags) build constituent_config -out=$(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntelProfilerComponentsList_makefile) : $(IntelProfilerComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerComponentsList.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerComponentsList.in -tag=$(tags) $(IntelProfilerComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList
else
$(cmt_local_IntelProfilerComponentsList_makefile) : $(IntelProfilerComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)IntelProfilerComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerComponentsList) ] || \
	  $(not_IntelProfilerComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerComponentsList.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerComponentsList.in -tag=$(tags) $(IntelProfilerComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntelProfilerComponentsList_extratags) build constituent_makefile -out=$(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList

IntelProfilerComponentsList :: $(IntelProfilerComponentsList_dependencies) $(cmt_local_IntelProfilerComponentsList_makefile) dirs IntelProfilerComponentsListdirs
	$(echo) "(constituents.make) Starting IntelProfilerComponentsList"
	@if test -f $(cmt_local_IntelProfilerComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsList
	$(echo) "(constituents.make) IntelProfilerComponentsList done"

clean :: IntelProfilerComponentsListclean ;

IntelProfilerComponentsListclean :: $(IntelProfilerComponentsListclean_dependencies) ##$(cmt_local_IntelProfilerComponentsList_makefile)
	$(echo) "(constituents.make) Starting IntelProfilerComponentsListclean"
	@-if test -f $(cmt_local_IntelProfilerComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsListclean; \
	fi
	$(echo) "(constituents.make) IntelProfilerComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) IntelProfilerComponentsListclean

##	  /bin/rm -f $(cmt_local_IntelProfilerComponentsList_makefile) $(bin)IntelProfilerComponentsList_dependencies.make

install :: IntelProfilerComponentsListinstall ;

IntelProfilerComponentsListinstall :: $(IntelProfilerComponentsList_dependencies) $(cmt_local_IntelProfilerComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfilerComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : IntelProfilerComponentsListuninstall

$(foreach d,$(IntelProfilerComponentsList_dependencies),$(eval $(d)uninstall_dependencies += IntelProfilerComponentsListuninstall))

IntelProfilerComponentsListuninstall : $(IntelProfilerComponentsListuninstall_dependencies) ##$(cmt_local_IntelProfilerComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfilerComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntelProfilerComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntelProfilerComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntelProfilerComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_IntelProfilerMergeComponentsList_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_IntelProfilerMergeComponentsList_has_target_tag

cmt_local_tagfile_IntelProfilerMergeComponentsList = $(bin)$(GaudiProfiling_tag)_IntelProfilerMergeComponentsList.make
cmt_final_setup_IntelProfilerMergeComponentsList = $(bin)setup_IntelProfilerMergeComponentsList.make
cmt_local_IntelProfilerMergeComponentsList_makefile = $(bin)IntelProfilerMergeComponentsList.make

IntelProfilerMergeComponentsList_extratags = -tag_add=target_IntelProfilerMergeComponentsList

else

cmt_local_tagfile_IntelProfilerMergeComponentsList = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_IntelProfilerMergeComponentsList = $(bin)setup.make
cmt_local_IntelProfilerMergeComponentsList_makefile = $(bin)IntelProfilerMergeComponentsList.make

endif

not_IntelProfilerMergeComponentsList_dependencies = { n=0; for p in $?; do m=0; for d in $(IntelProfilerMergeComponentsList_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntelProfilerMergeComponentsListdirs :
	@if test ! -d $(bin)IntelProfilerMergeComponentsList; then $(mkdir) -p $(bin)IntelProfilerMergeComponentsList; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntelProfilerMergeComponentsList
else
IntelProfilerMergeComponentsListdirs : ;
endif

ifdef cmt_IntelProfilerMergeComponentsList_has_target_tag

ifndef QUICK
$(cmt_local_IntelProfilerMergeComponentsList_makefile) : $(IntelProfilerMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList
else
$(cmt_local_IntelProfilerMergeComponentsList_makefile) : $(IntelProfilerMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerMergeComponentsList) ] || \
	  $(not_IntelProfilerMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerMergeComponentsList.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerMergeComponentsList_extratags) build constituent_config -out=$(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntelProfilerMergeComponentsList_makefile) : $(IntelProfilerMergeComponentsList_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerMergeComponentsList.in -tag=$(tags) $(IntelProfilerMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList
else
$(cmt_local_IntelProfilerMergeComponentsList_makefile) : $(IntelProfilerMergeComponentsList_dependencies) $(cmt_build_library_linksstamp) $(bin)IntelProfilerMergeComponentsList.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerMergeComponentsList) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerMergeComponentsList) ] || \
	  $(not_IntelProfilerMergeComponentsList_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerMergeComponentsList.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerMergeComponentsList.in -tag=$(tags) $(IntelProfilerMergeComponentsList_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntelProfilerMergeComponentsList_extratags) build constituent_makefile -out=$(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList

IntelProfilerMergeComponentsList :: $(IntelProfilerMergeComponentsList_dependencies) $(cmt_local_IntelProfilerMergeComponentsList_makefile) dirs IntelProfilerMergeComponentsListdirs
	$(echo) "(constituents.make) Starting IntelProfilerMergeComponentsList"
	@if test -f $(cmt_local_IntelProfilerMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsList
	$(echo) "(constituents.make) IntelProfilerMergeComponentsList done"

clean :: IntelProfilerMergeComponentsListclean ;

IntelProfilerMergeComponentsListclean :: $(IntelProfilerMergeComponentsListclean_dependencies) ##$(cmt_local_IntelProfilerMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting IntelProfilerMergeComponentsListclean"
	@-if test -f $(cmt_local_IntelProfilerMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsListclean; \
	fi
	$(echo) "(constituents.make) IntelProfilerMergeComponentsListclean done"
#	@-$(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) IntelProfilerMergeComponentsListclean

##	  /bin/rm -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) $(bin)IntelProfilerMergeComponentsList_dependencies.make

install :: IntelProfilerMergeComponentsListinstall ;

IntelProfilerMergeComponentsListinstall :: $(IntelProfilerMergeComponentsList_dependencies) $(cmt_local_IntelProfilerMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfilerMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : IntelProfilerMergeComponentsListuninstall

$(foreach d,$(IntelProfilerMergeComponentsList_dependencies),$(eval $(d)uninstall_dependencies += IntelProfilerMergeComponentsListuninstall))

IntelProfilerMergeComponentsListuninstall : $(IntelProfilerMergeComponentsListuninstall_dependencies) ##$(cmt_local_IntelProfilerMergeComponentsList_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfilerMergeComponentsList_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerMergeComponentsList_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntelProfilerMergeComponentsListuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntelProfilerMergeComponentsList"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntelProfilerMergeComponentsList done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_IntelProfilerConf_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_IntelProfilerConf_has_target_tag

cmt_local_tagfile_IntelProfilerConf = $(bin)$(GaudiProfiling_tag)_IntelProfilerConf.make
cmt_final_setup_IntelProfilerConf = $(bin)setup_IntelProfilerConf.make
cmt_local_IntelProfilerConf_makefile = $(bin)IntelProfilerConf.make

IntelProfilerConf_extratags = -tag_add=target_IntelProfilerConf

else

cmt_local_tagfile_IntelProfilerConf = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_IntelProfilerConf = $(bin)setup.make
cmt_local_IntelProfilerConf_makefile = $(bin)IntelProfilerConf.make

endif

not_IntelProfilerConf_dependencies = { n=0; for p in $?; do m=0; for d in $(IntelProfilerConf_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntelProfilerConfdirs :
	@if test ! -d $(bin)IntelProfilerConf; then $(mkdir) -p $(bin)IntelProfilerConf; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntelProfilerConf
else
IntelProfilerConfdirs : ;
endif

ifdef cmt_IntelProfilerConf_has_target_tag

ifndef QUICK
$(cmt_local_IntelProfilerConf_makefile) : $(IntelProfilerConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerConf.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerConf_extratags) build constituent_config -out=$(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf
else
$(cmt_local_IntelProfilerConf_makefile) : $(IntelProfilerConf_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerConf) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerConf) ] || \
	  $(not_IntelProfilerConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerConf.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerConf_extratags) build constituent_config -out=$(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntelProfilerConf_makefile) : $(IntelProfilerConf_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerConf.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerConf.in -tag=$(tags) $(IntelProfilerConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf
else
$(cmt_local_IntelProfilerConf_makefile) : $(IntelProfilerConf_dependencies) $(cmt_build_library_linksstamp) $(bin)IntelProfilerConf.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerConf) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerConf) ] || \
	  $(not_IntelProfilerConf_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerConf.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerConf.in -tag=$(tags) $(IntelProfilerConf_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntelProfilerConf_extratags) build constituent_makefile -out=$(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf

IntelProfilerConf :: $(IntelProfilerConf_dependencies) $(cmt_local_IntelProfilerConf_makefile) dirs IntelProfilerConfdirs
	$(echo) "(constituents.make) Starting IntelProfilerConf"
	@if test -f $(cmt_local_IntelProfilerConf_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) IntelProfilerConf
	$(echo) "(constituents.make) IntelProfilerConf done"

clean :: IntelProfilerConfclean ;

IntelProfilerConfclean :: $(IntelProfilerConfclean_dependencies) ##$(cmt_local_IntelProfilerConf_makefile)
	$(echo) "(constituents.make) Starting IntelProfilerConfclean"
	@-if test -f $(cmt_local_IntelProfilerConf_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) IntelProfilerConfclean; \
	fi
	$(echo) "(constituents.make) IntelProfilerConfclean done"
#	@-$(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) IntelProfilerConfclean

##	  /bin/rm -f $(cmt_local_IntelProfilerConf_makefile) $(bin)IntelProfilerConf_dependencies.make

install :: IntelProfilerConfinstall ;

IntelProfilerConfinstall :: $(IntelProfilerConf_dependencies) $(cmt_local_IntelProfilerConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfilerConf_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : IntelProfilerConfuninstall

$(foreach d,$(IntelProfilerConf_dependencies),$(eval $(d)uninstall_dependencies += IntelProfilerConfuninstall))

IntelProfilerConfuninstall : $(IntelProfilerConfuninstall_dependencies) ##$(cmt_local_IntelProfilerConf_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfilerConf_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerConf_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntelProfilerConfuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntelProfilerConf"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntelProfilerConf done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_IntelProfilerConfDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_IntelProfilerConfDbMerge_has_target_tag

cmt_local_tagfile_IntelProfilerConfDbMerge = $(bin)$(GaudiProfiling_tag)_IntelProfilerConfDbMerge.make
cmt_final_setup_IntelProfilerConfDbMerge = $(bin)setup_IntelProfilerConfDbMerge.make
cmt_local_IntelProfilerConfDbMerge_makefile = $(bin)IntelProfilerConfDbMerge.make

IntelProfilerConfDbMerge_extratags = -tag_add=target_IntelProfilerConfDbMerge

else

cmt_local_tagfile_IntelProfilerConfDbMerge = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_IntelProfilerConfDbMerge = $(bin)setup.make
cmt_local_IntelProfilerConfDbMerge_makefile = $(bin)IntelProfilerConfDbMerge.make

endif

not_IntelProfilerConfDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(IntelProfilerConfDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
IntelProfilerConfDbMergedirs :
	@if test ! -d $(bin)IntelProfilerConfDbMerge; then $(mkdir) -p $(bin)IntelProfilerConfDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)IntelProfilerConfDbMerge
else
IntelProfilerConfDbMergedirs : ;
endif

ifdef cmt_IntelProfilerConfDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_IntelProfilerConfDbMerge_makefile) : $(IntelProfilerConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerConfDbMerge_extratags) build constituent_config -out=$(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge
else
$(cmt_local_IntelProfilerConfDbMerge_makefile) : $(IntelProfilerConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerConfDbMerge) ] || \
	  $(not_IntelProfilerConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerConfDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(IntelProfilerConfDbMerge_extratags) build constituent_config -out=$(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_IntelProfilerConfDbMerge_makefile) : $(IntelProfilerConfDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building IntelProfilerConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerConfDbMerge.in -tag=$(tags) $(IntelProfilerConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge
else
$(cmt_local_IntelProfilerConfDbMerge_makefile) : $(IntelProfilerConfDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)IntelProfilerConfDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_IntelProfilerConfDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_IntelProfilerConfDbMerge) ] || \
	  $(not_IntelProfilerConfDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building IntelProfilerConfDbMerge.make"; \
	  $(cmtexe) -f=$(bin)IntelProfilerConfDbMerge.in -tag=$(tags) $(IntelProfilerConfDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(IntelProfilerConfDbMerge_extratags) build constituent_makefile -out=$(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge

IntelProfilerConfDbMerge :: $(IntelProfilerConfDbMerge_dependencies) $(cmt_local_IntelProfilerConfDbMerge_makefile) dirs IntelProfilerConfDbMergedirs
	$(echo) "(constituents.make) Starting IntelProfilerConfDbMerge"
	@if test -f $(cmt_local_IntelProfilerConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMerge
	$(echo) "(constituents.make) IntelProfilerConfDbMerge done"

clean :: IntelProfilerConfDbMergeclean ;

IntelProfilerConfDbMergeclean :: $(IntelProfilerConfDbMergeclean_dependencies) ##$(cmt_local_IntelProfilerConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting IntelProfilerConfDbMergeclean"
	@-if test -f $(cmt_local_IntelProfilerConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMergeclean; \
	fi
	$(echo) "(constituents.make) IntelProfilerConfDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) IntelProfilerConfDbMergeclean

##	  /bin/rm -f $(cmt_local_IntelProfilerConfDbMerge_makefile) $(bin)IntelProfilerConfDbMerge_dependencies.make

install :: IntelProfilerConfDbMergeinstall ;

IntelProfilerConfDbMergeinstall :: $(IntelProfilerConfDbMerge_dependencies) $(cmt_local_IntelProfilerConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_IntelProfilerConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : IntelProfilerConfDbMergeuninstall

$(foreach d,$(IntelProfilerConfDbMerge_dependencies),$(eval $(d)uninstall_dependencies += IntelProfilerConfDbMergeuninstall))

IntelProfilerConfDbMergeuninstall : $(IntelProfilerConfDbMergeuninstall_dependencies) ##$(cmt_local_IntelProfilerConfDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_IntelProfilerConfDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_IntelProfilerConfDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: IntelProfilerConfDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ IntelProfilerConfDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ IntelProfilerConfDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfiling_python_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfiling_python_has_target_tag

cmt_local_tagfile_GaudiProfiling_python = $(bin)$(GaudiProfiling_tag)_GaudiProfiling_python.make
cmt_final_setup_GaudiProfiling_python = $(bin)setup_GaudiProfiling_python.make
cmt_local_GaudiProfiling_python_makefile = $(bin)GaudiProfiling_python.make

GaudiProfiling_python_extratags = -tag_add=target_GaudiProfiling_python

else

cmt_local_tagfile_GaudiProfiling_python = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfiling_python = $(bin)setup.make
cmt_local_GaudiProfiling_python_makefile = $(bin)GaudiProfiling_python.make

endif

not_GaudiProfiling_python_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfiling_python_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfiling_pythondirs :
	@if test ! -d $(bin)GaudiProfiling_python; then $(mkdir) -p $(bin)GaudiProfiling_python; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfiling_python
else
GaudiProfiling_pythondirs : ;
endif

ifdef cmt_GaudiProfiling_python_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfiling_python_makefile) : $(GaudiProfiling_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python
else
$(cmt_local_GaudiProfiling_python_makefile) : $(GaudiProfiling_python_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling_python) ] || \
	  $(not_GaudiProfiling_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling_python.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_extratags) build constituent_config -out=$(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfiling_python_makefile) : $(GaudiProfiling_python_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfiling_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling_python.in -tag=$(tags) $(GaudiProfiling_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python
else
$(cmt_local_GaudiProfiling_python_makefile) : $(GaudiProfiling_python_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfiling_python.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfiling_python) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfiling_python) ] || \
	  $(not_GaudiProfiling_python_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfiling_python.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfiling_python.in -tag=$(tags) $(GaudiProfiling_python_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfiling_python_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python

GaudiProfiling_python :: $(GaudiProfiling_python_dependencies) $(cmt_local_GaudiProfiling_python_makefile) dirs GaudiProfiling_pythondirs
	$(echo) "(constituents.make) Starting GaudiProfiling_python"
	@if test -f $(cmt_local_GaudiProfiling_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_python
	$(echo) "(constituents.make) GaudiProfiling_python done"

clean :: GaudiProfiling_pythonclean ;

GaudiProfiling_pythonclean :: $(GaudiProfiling_pythonclean_dependencies) ##$(cmt_local_GaudiProfiling_python_makefile)
	$(echo) "(constituents.make) Starting GaudiProfiling_pythonclean"
	@-if test -f $(cmt_local_GaudiProfiling_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_pythonclean; \
	fi
	$(echo) "(constituents.make) GaudiProfiling_pythonclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) GaudiProfiling_pythonclean

##	  /bin/rm -f $(cmt_local_GaudiProfiling_python_makefile) $(bin)GaudiProfiling_python_dependencies.make

install :: GaudiProfiling_pythoninstall ;

GaudiProfiling_pythoninstall :: $(GaudiProfiling_python_dependencies) $(cmt_local_GaudiProfiling_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfiling_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfiling_pythonuninstall

$(foreach d,$(GaudiProfiling_python_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfiling_pythonuninstall))

GaudiProfiling_pythonuninstall : $(GaudiProfiling_pythonuninstall_dependencies) ##$(cmt_local_GaudiProfiling_python_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfiling_python_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfiling_python_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfiling_pythonuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfiling_python"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfiling_python done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfilingGenConfUser_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingGenConfUser_has_target_tag

cmt_local_tagfile_GaudiProfilingGenConfUser = $(bin)$(GaudiProfiling_tag)_GaudiProfilingGenConfUser.make
cmt_final_setup_GaudiProfilingGenConfUser = $(bin)setup_GaudiProfilingGenConfUser.make
cmt_local_GaudiProfilingGenConfUser_makefile = $(bin)GaudiProfilingGenConfUser.make

GaudiProfilingGenConfUser_extratags = -tag_add=target_GaudiProfilingGenConfUser

else

cmt_local_tagfile_GaudiProfilingGenConfUser = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingGenConfUser = $(bin)setup.make
cmt_local_GaudiProfilingGenConfUser_makefile = $(bin)GaudiProfilingGenConfUser.make

endif

not_GaudiProfilingGenConfUser_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingGenConfUser_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingGenConfUserdirs :
	@if test ! -d $(bin)GaudiProfilingGenConfUser; then $(mkdir) -p $(bin)GaudiProfilingGenConfUser; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingGenConfUser
else
GaudiProfilingGenConfUserdirs : ;
endif

ifdef cmt_GaudiProfilingGenConfUser_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingGenConfUser_makefile) : $(GaudiProfilingGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser
else
$(cmt_local_GaudiProfilingGenConfUser_makefile) : $(GaudiProfilingGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingGenConfUser) ] || \
	  $(not_GaudiProfilingGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingGenConfUser.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingGenConfUser_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingGenConfUser_makefile) : $(GaudiProfilingGenConfUser_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingGenConfUser.in -tag=$(tags) $(GaudiProfilingGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser
else
$(cmt_local_GaudiProfilingGenConfUser_makefile) : $(GaudiProfilingGenConfUser_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingGenConfUser.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingGenConfUser) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingGenConfUser) ] || \
	  $(not_GaudiProfilingGenConfUser_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingGenConfUser.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingGenConfUser.in -tag=$(tags) $(GaudiProfilingGenConfUser_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingGenConfUser_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser

GaudiProfilingGenConfUser :: $(GaudiProfilingGenConfUser_dependencies) $(cmt_local_GaudiProfilingGenConfUser_makefile) dirs GaudiProfilingGenConfUserdirs
	$(echo) "(constituents.make) Starting GaudiProfilingGenConfUser"
	@if test -f $(cmt_local_GaudiProfilingGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUser
	$(echo) "(constituents.make) GaudiProfilingGenConfUser done"

clean :: GaudiProfilingGenConfUserclean ;

GaudiProfilingGenConfUserclean :: $(GaudiProfilingGenConfUserclean_dependencies) ##$(cmt_local_GaudiProfilingGenConfUser_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingGenConfUserclean"
	@-if test -f $(cmt_local_GaudiProfilingGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUserclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingGenConfUserclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) GaudiProfilingGenConfUserclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingGenConfUser_makefile) $(bin)GaudiProfilingGenConfUser_dependencies.make

install :: GaudiProfilingGenConfUserinstall ;

GaudiProfilingGenConfUserinstall :: $(GaudiProfilingGenConfUser_dependencies) $(cmt_local_GaudiProfilingGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingGenConfUseruninstall

$(foreach d,$(GaudiProfilingGenConfUser_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingGenConfUseruninstall))

GaudiProfilingGenConfUseruninstall : $(GaudiProfilingGenConfUseruninstall_dependencies) ##$(cmt_local_GaudiProfilingGenConfUser_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingGenConfUser_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingGenConfUser_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingGenConfUseruninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingGenConfUser"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingGenConfUser done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_GaudiProfilingConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_GaudiProfilingConfUserDbMerge_has_target_tag

cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConfUserDbMerge.make
cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)setup_GaudiProfilingConfUserDbMerge.make
cmt_local_GaudiProfilingConfUserDbMerge_makefile = $(bin)GaudiProfilingConfUserDbMerge.make

GaudiProfilingConfUserDbMerge_extratags = -tag_add=target_GaudiProfilingConfUserDbMerge

else

cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)setup.make
cmt_local_GaudiProfilingConfUserDbMerge_makefile = $(bin)GaudiProfilingConfUserDbMerge.make

endif

not_GaudiProfilingConfUserDbMerge_dependencies = { n=0; for p in $?; do m=0; for d in $(GaudiProfilingConfUserDbMerge_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
GaudiProfilingConfUserDbMergedirs :
	@if test ! -d $(bin)GaudiProfilingConfUserDbMerge; then $(mkdir) -p $(bin)GaudiProfilingConfUserDbMerge; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)GaudiProfilingConfUserDbMerge
else
GaudiProfilingConfUserDbMergedirs : ;
endif

ifdef cmt_GaudiProfilingConfUserDbMerge_has_target_tag

ifndef QUICK
$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) : $(GaudiProfilingConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge
else
$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) : $(GaudiProfilingConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConfUserDbMerge) ] || \
	  $(not_GaudiProfilingConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConfUserDbMerge.make"; \
	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfUserDbMerge_extratags) build constituent_config -out=$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) : $(GaudiProfilingConfUserDbMerge_dependencies) build_library_links
	$(echo) "(constituents.make) Building GaudiProfilingConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConfUserDbMerge.in -tag=$(tags) $(GaudiProfilingConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge
else
$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) : $(GaudiProfilingConfUserDbMerge_dependencies) $(cmt_build_library_linksstamp) $(bin)GaudiProfilingConfUserDbMerge.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_GaudiProfilingConfUserDbMerge) ] || \
	  [ ! -f $(cmt_final_setup_GaudiProfilingConfUserDbMerge) ] || \
	  $(not_GaudiProfilingConfUserDbMerge_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building GaudiProfilingConfUserDbMerge.make"; \
	  $(cmtexe) -f=$(bin)GaudiProfilingConfUserDbMerge.in -tag=$(tags) $(GaudiProfilingConfUserDbMerge_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(GaudiProfilingConfUserDbMerge_extratags) build constituent_makefile -out=$(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge

GaudiProfilingConfUserDbMerge :: $(GaudiProfilingConfUserDbMerge_dependencies) $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) dirs GaudiProfilingConfUserDbMergedirs
	$(echo) "(constituents.make) Starting GaudiProfilingConfUserDbMerge"
	@if test -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMerge
	$(echo) "(constituents.make) GaudiProfilingConfUserDbMerge done"

clean :: GaudiProfilingConfUserDbMergeclean ;

GaudiProfilingConfUserDbMergeclean :: $(GaudiProfilingConfUserDbMergeclean_dependencies) ##$(cmt_local_GaudiProfilingConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting GaudiProfilingConfUserDbMergeclean"
	@-if test -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMergeclean; \
	fi
	$(echo) "(constituents.make) GaudiProfilingConfUserDbMergeclean done"
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) GaudiProfilingConfUserDbMergeclean

##	  /bin/rm -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) $(bin)GaudiProfilingConfUserDbMerge_dependencies.make

install :: GaudiProfilingConfUserDbMergeinstall ;

GaudiProfilingConfUserDbMergeinstall :: $(GaudiProfilingConfUserDbMerge_dependencies) $(cmt_local_GaudiProfilingConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) install; \
	  fi
#	@-$(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) install
	$(echo) "(constituents.make) $@ done"

uninstall : GaudiProfilingConfUserDbMergeuninstall

$(foreach d,$(GaudiProfilingConfUserDbMerge_dependencies),$(eval $(d)uninstall_dependencies += GaudiProfilingConfUserDbMergeuninstall))

GaudiProfilingConfUserDbMergeuninstall : $(GaudiProfilingConfUserDbMergeuninstall_dependencies) ##$(cmt_local_GaudiProfilingConfUserDbMerge_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile); then \
	  $(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_GaudiProfilingConfUserDbMerge_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: GaudiProfilingConfUserDbMergeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ GaudiProfilingConfUserDbMerge"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ GaudiProfilingConfUserDbMerge done"
endif

#-- end of constituent ------
#-- start of constituent ------

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_scripts_has_target_tag

cmt_local_tagfile_install_scripts = $(bin)$(GaudiProfiling_tag)_install_scripts.make
cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

install_scripts_extratags = -tag_add=target_install_scripts

else

cmt_local_tagfile_install_scripts = $(bin)$(GaudiProfiling_tag).make
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

cmt_install_more_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_more_includes_has_target_tag

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiProfiling_tag)_install_more_includes.make
cmt_final_setup_install_more_includes = $(bin)setup_install_more_includes.make
cmt_local_install_more_includes_makefile = $(bin)install_more_includes.make

install_more_includes_extratags = -tag_add=target_install_more_includes

else

cmt_local_tagfile_install_more_includes = $(bin)$(GaudiProfiling_tag).make
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

cmt_PyCPUFamily_has_target_tag = 1
cmt_PyCPUFamily_has_prototypes = 1

#--------------------------------------

ifdef cmt_PyCPUFamily_has_target_tag

cmt_local_tagfile_PyCPUFamily = $(bin)$(GaudiProfiling_tag)_PyCPUFamily.make
cmt_final_setup_PyCPUFamily = $(bin)setup_PyCPUFamily.make
cmt_local_PyCPUFamily_makefile = $(bin)PyCPUFamily.make

PyCPUFamily_extratags = -tag_add=target_PyCPUFamily

else

cmt_local_tagfile_PyCPUFamily = $(bin)$(GaudiProfiling_tag).make
cmt_final_setup_PyCPUFamily = $(bin)setup.make
cmt_local_PyCPUFamily_makefile = $(bin)PyCPUFamily.make

endif

not_PyCPUFamilycompile_dependencies = { n=0; for p in $?; do m=0; for d in $(PyCPUFamilycompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
PyCPUFamilydirs :
	@if test ! -d $(bin)PyCPUFamily; then $(mkdir) -p $(bin)PyCPUFamily; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)PyCPUFamily
else
PyCPUFamilydirs : ;
endif

ifdef cmt_PyCPUFamily_has_target_tag

ifndef QUICK
$(cmt_local_PyCPUFamily_makefile) : $(PyCPUFamilycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PyCPUFamily.make"; \
	  $(cmtexe) -tag=$(tags) $(PyCPUFamily_extratags) build constituent_config -out=$(cmt_local_PyCPUFamily_makefile) PyCPUFamily
else
$(cmt_local_PyCPUFamily_makefile) : $(PyCPUFamilycompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PyCPUFamily) ] || \
	  [ ! -f $(cmt_final_setup_PyCPUFamily) ] || \
	  $(not_PyCPUFamilycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PyCPUFamily.make"; \
	  $(cmtexe) -tag=$(tags) $(PyCPUFamily_extratags) build constituent_config -out=$(cmt_local_PyCPUFamily_makefile) PyCPUFamily; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_PyCPUFamily_makefile) : $(PyCPUFamilycompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building PyCPUFamily.make"; \
	  $(cmtexe) -f=$(bin)PyCPUFamily.in -tag=$(tags) $(PyCPUFamily_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PyCPUFamily_makefile) PyCPUFamily
else
$(cmt_local_PyCPUFamily_makefile) : $(PyCPUFamilycompile_dependencies) $(cmt_build_library_linksstamp) $(bin)PyCPUFamily.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_PyCPUFamily) ] || \
	  [ ! -f $(cmt_final_setup_PyCPUFamily) ] || \
	  $(not_PyCPUFamilycompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building PyCPUFamily.make"; \
	  $(cmtexe) -f=$(bin)PyCPUFamily.in -tag=$(tags) $(PyCPUFamily_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_PyCPUFamily_makefile) PyCPUFamily; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(PyCPUFamily_extratags) build constituent_makefile -out=$(cmt_local_PyCPUFamily_makefile) PyCPUFamily

PyCPUFamily :: PyCPUFamilycompile PyCPUFamilyinstall ;

ifdef cmt_PyCPUFamily_has_prototypes

PyCPUFamilyprototype : $(PyCPUFamilyprototype_dependencies) $(cmt_local_PyCPUFamily_makefile) dirs PyCPUFamilydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyCPUFamily_makefile); then \
	  $(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@
	$(echo) "(constituents.make) $@ done"

PyCPUFamilycompile : PyCPUFamilyprototype

endif

PyCPUFamilycompile : $(PyCPUFamilycompile_dependencies) $(cmt_local_PyCPUFamily_makefile) dirs PyCPUFamilydirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyCPUFamily_makefile); then \
	  $(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: PyCPUFamilyclean ;

PyCPUFamilyclean :: $(PyCPUFamilyclean_dependencies) ##$(cmt_local_PyCPUFamily_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PyCPUFamily_makefile); then \
	  $(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_PyCPUFamily_makefile) PyCPUFamilyclean

##	  /bin/rm -f $(cmt_local_PyCPUFamily_makefile) $(bin)PyCPUFamily_dependencies.make

install :: PyCPUFamilyinstall ;

PyCPUFamilyinstall :: PyCPUFamilycompile $(PyCPUFamily_dependencies) $(cmt_local_PyCPUFamily_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_PyCPUFamily_makefile); then \
	  $(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyCPUFamily_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : PyCPUFamilyuninstall

$(foreach d,$(PyCPUFamily_dependencies),$(eval $(d)uninstall_dependencies += PyCPUFamilyuninstall))

PyCPUFamilyuninstall : $(PyCPUFamilyuninstall_dependencies) ##$(cmt_local_PyCPUFamily_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_PyCPUFamily_makefile); then \
	  $(MAKE) -f $(cmt_local_PyCPUFamily_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_PyCPUFamily_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: PyCPUFamilyuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ PyCPUFamily"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ PyCPUFamily done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_make_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_make_has_target_tag

cmt_local_tagfile_make = $(bin)$(GaudiProfiling_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_CompilePython = $(bin)$(GaudiProfiling_tag)_CompilePython.make
cmt_final_setup_CompilePython = $(bin)setup_CompilePython.make
cmt_local_CompilePython_makefile = $(bin)CompilePython.make

CompilePython_extratags = -tag_add=target_CompilePython

else

cmt_local_tagfile_CompilePython = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiProfiling_tag)_qmtest_run.make
cmt_final_setup_qmtest_run = $(bin)setup_qmtest_run.make
cmt_local_qmtest_run_makefile = $(bin)qmtest_run.make

qmtest_run_extratags = -tag_add=target_qmtest_run

else

cmt_local_tagfile_qmtest_run = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiProfiling_tag)_qmtest_summarize.make
cmt_final_setup_qmtest_summarize = $(bin)setup_qmtest_summarize.make
cmt_local_qmtest_summarize_makefile = $(bin)qmtest_summarize.make

qmtest_summarize_extratags = -tag_add=target_qmtest_summarize

else

cmt_local_tagfile_qmtest_summarize = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_TestPackage = $(bin)$(GaudiProfiling_tag)_TestPackage.make
cmt_final_setup_TestPackage = $(bin)setup_TestPackage.make
cmt_local_TestPackage_makefile = $(bin)TestPackage.make

TestPackage_extratags = -tag_add=target_TestPackage

else

cmt_local_tagfile_TestPackage = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_TestProject = $(bin)$(GaudiProfiling_tag)_TestProject.make
cmt_final_setup_TestProject = $(bin)setup_TestProject.make
cmt_local_TestProject_makefile = $(bin)TestProject.make

TestProject_extratags = -tag_add=target_TestProject

else

cmt_local_tagfile_TestProject = $(bin)$(GaudiProfiling_tag).make
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

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiProfiling_tag)_new_rootsys.make
cmt_final_setup_new_rootsys = $(bin)setup_new_rootsys.make
cmt_local_new_rootsys_makefile = $(bin)new_rootsys.make

new_rootsys_extratags = -tag_add=target_new_rootsys

else

cmt_local_tagfile_new_rootsys = $(bin)$(GaudiProfiling_tag).make
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
