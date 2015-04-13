
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralBase_tag = $(tag)

#cmt_local_tagfile = $(CoralBase_tag).make
cmt_local_tagfile = $(bin)$(CoralBase_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralBasesetup.make
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
#-- start of constituent_app_lib ------

cmt_lcg_CoralBase_has_no_target_tag = 1
cmt_lcg_CoralBase_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralBase_has_target_tag

cmt_local_tagfile_lcg_CoralBase = $(bin)$(CoralBase_tag)_lcg_CoralBase.make
cmt_final_setup_lcg_CoralBase = $(bin)setup_lcg_CoralBase.make
cmt_local_lcg_CoralBase_makefile = $(bin)lcg_CoralBase.make

lcg_CoralBase_extratags = -tag_add=target_lcg_CoralBase

else

cmt_local_tagfile_lcg_CoralBase = $(bin)$(CoralBase_tag).make
cmt_final_setup_lcg_CoralBase = $(bin)setup.make
cmt_local_lcg_CoralBase_makefile = $(bin)lcg_CoralBase.make

endif

not_lcg_CoralBasecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralBasecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralBasedirs :
	@if test ! -d $(bin)lcg_CoralBase; then $(mkdir) -p $(bin)lcg_CoralBase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralBase
else
lcg_CoralBasedirs : ;
endif

ifdef cmt_lcg_CoralBase_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralBase_makefile) : $(lcg_CoralBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralBase.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralBase_extratags) build constituent_config -out=$(cmt_local_lcg_CoralBase_makefile) lcg_CoralBase
else
$(cmt_local_lcg_CoralBase_makefile) : $(lcg_CoralBasecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralBase) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralBase) ] || \
	  $(not_lcg_CoralBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralBase.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralBase_extratags) build constituent_config -out=$(cmt_local_lcg_CoralBase_makefile) lcg_CoralBase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralBase_makefile) : $(lcg_CoralBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralBase.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralBase.in -tag=$(tags) $(lcg_CoralBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralBase_makefile) lcg_CoralBase
else
$(cmt_local_lcg_CoralBase_makefile) : $(lcg_CoralBasecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralBase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralBase) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralBase) ] || \
	  $(not_lcg_CoralBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralBase.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralBase.in -tag=$(tags) $(lcg_CoralBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralBase_makefile) lcg_CoralBase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralBase_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralBase_makefile) lcg_CoralBase

lcg_CoralBase :: lcg_CoralBasecompile lcg_CoralBaseinstall ;

ifdef cmt_lcg_CoralBase_has_prototypes

lcg_CoralBaseprototype : $(lcg_CoralBaseprototype_dependencies) $(cmt_local_lcg_CoralBase_makefile) dirs lcg_CoralBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralBasecompile : lcg_CoralBaseprototype

endif

lcg_CoralBasecompile : $(lcg_CoralBasecompile_dependencies) $(cmt_local_lcg_CoralBase_makefile) dirs lcg_CoralBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralBaseclean ;

lcg_CoralBaseclean :: $(lcg_CoralBaseclean_dependencies) ##$(cmt_local_lcg_CoralBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) lcg_CoralBaseclean

##	  /bin/rm -f $(cmt_local_lcg_CoralBase_makefile) $(bin)lcg_CoralBase_dependencies.make

install :: lcg_CoralBaseinstall ;

lcg_CoralBaseinstall :: lcg_CoralBasecompile $(lcg_CoralBase_dependencies) $(cmt_local_lcg_CoralBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralBaseuninstall

$(foreach d,$(lcg_CoralBase_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralBaseuninstall))

lcg_CoralBaseuninstall : $(lcg_CoralBaseuninstall_dependencies) ##$(cmt_local_lcg_CoralBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralBase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralBaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralBase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralBase done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_BlobReadWrite_has_no_target_tag = 1
cmt_test_unit_CoralBase_BlobReadWrite_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_BlobReadWrite_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_BlobReadWrite = $(bin)$(CoralBase_tag)_test_unit_CoralBase_BlobReadWrite.make
cmt_final_setup_test_unit_CoralBase_BlobReadWrite = $(bin)setup_test_unit_CoralBase_BlobReadWrite.make
cmt_local_test_unit_CoralBase_BlobReadWrite_makefile = $(bin)test_unit_CoralBase_BlobReadWrite.make

test_unit_CoralBase_BlobReadWrite_extratags = -tag_add=target_test_unit_CoralBase_BlobReadWrite

else

cmt_local_tagfile_test_unit_CoralBase_BlobReadWrite = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_BlobReadWrite = $(bin)setup.make
cmt_local_test_unit_CoralBase_BlobReadWrite_makefile = $(bin)test_unit_CoralBase_BlobReadWrite.make

endif

not_test_unit_CoralBase_BlobReadWritecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_BlobReadWritecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_BlobReadWritedirs :
	@if test ! -d $(bin)test_unit_CoralBase_BlobReadWrite; then $(mkdir) -p $(bin)test_unit_CoralBase_BlobReadWrite; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_BlobReadWrite
else
test_unit_CoralBase_BlobReadWritedirs : ;
endif

ifdef cmt_test_unit_CoralBase_BlobReadWrite_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) : $(test_unit_CoralBase_BlobReadWritecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_BlobReadWrite.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_BlobReadWrite_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWrite
else
$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) : $(test_unit_CoralBase_BlobReadWritecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_BlobReadWrite) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_BlobReadWrite) ] || \
	  $(not_test_unit_CoralBase_BlobReadWritecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_BlobReadWrite.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_BlobReadWrite_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWrite; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) : $(test_unit_CoralBase_BlobReadWritecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_BlobReadWrite.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_BlobReadWrite.in -tag=$(tags) $(test_unit_CoralBase_BlobReadWrite_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWrite
else
$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) : $(test_unit_CoralBase_BlobReadWritecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_BlobReadWrite.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_BlobReadWrite) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_BlobReadWrite) ] || \
	  $(not_test_unit_CoralBase_BlobReadWritecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_BlobReadWrite.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_BlobReadWrite.in -tag=$(tags) $(test_unit_CoralBase_BlobReadWrite_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWrite; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_BlobReadWrite_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWrite

test_unit_CoralBase_BlobReadWrite :: test_unit_CoralBase_BlobReadWritecompile test_unit_CoralBase_BlobReadWriteinstall ;

ifdef cmt_test_unit_CoralBase_BlobReadWrite_has_prototypes

test_unit_CoralBase_BlobReadWriteprototype : $(test_unit_CoralBase_BlobReadWriteprototype_dependencies) $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) dirs test_unit_CoralBase_BlobReadWritedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_BlobReadWritecompile : test_unit_CoralBase_BlobReadWriteprototype

endif

test_unit_CoralBase_BlobReadWritecompile : $(test_unit_CoralBase_BlobReadWritecompile_dependencies) $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) dirs test_unit_CoralBase_BlobReadWritedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_BlobReadWriteclean ;

test_unit_CoralBase_BlobReadWriteclean :: $(test_unit_CoralBase_BlobReadWriteclean_dependencies) ##$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) test_unit_CoralBase_BlobReadWriteclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $(bin)test_unit_CoralBase_BlobReadWrite_dependencies.make

install :: test_unit_CoralBase_BlobReadWriteinstall ;

test_unit_CoralBase_BlobReadWriteinstall :: test_unit_CoralBase_BlobReadWritecompile $(test_unit_CoralBase_BlobReadWrite_dependencies) $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_BlobReadWriteuninstall

$(foreach d,$(test_unit_CoralBase_BlobReadWrite_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_BlobReadWriteuninstall))

test_unit_CoralBase_BlobReadWriteuninstall : $(test_unit_CoralBase_BlobReadWriteuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_BlobReadWrite_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_BlobReadWriteuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_BlobReadWrite"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_BlobReadWrite done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_ClangBug100663_has_no_target_tag = 1
cmt_test_unit_CoralBase_ClangBug100663_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_ClangBug100663_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_ClangBug100663 = $(bin)$(CoralBase_tag)_test_unit_CoralBase_ClangBug100663.make
cmt_final_setup_test_unit_CoralBase_ClangBug100663 = $(bin)setup_test_unit_CoralBase_ClangBug100663.make
cmt_local_test_unit_CoralBase_ClangBug100663_makefile = $(bin)test_unit_CoralBase_ClangBug100663.make

test_unit_CoralBase_ClangBug100663_extratags = -tag_add=target_test_unit_CoralBase_ClangBug100663

else

cmt_local_tagfile_test_unit_CoralBase_ClangBug100663 = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_ClangBug100663 = $(bin)setup.make
cmt_local_test_unit_CoralBase_ClangBug100663_makefile = $(bin)test_unit_CoralBase_ClangBug100663.make

endif

not_test_unit_CoralBase_ClangBug100663compile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_ClangBug100663compile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_ClangBug100663dirs :
	@if test ! -d $(bin)test_unit_CoralBase_ClangBug100663; then $(mkdir) -p $(bin)test_unit_CoralBase_ClangBug100663; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_ClangBug100663
else
test_unit_CoralBase_ClangBug100663dirs : ;
endif

ifdef cmt_test_unit_CoralBase_ClangBug100663_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) : $(test_unit_CoralBase_ClangBug100663compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_ClangBug100663.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ClangBug100663_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663
else
$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) : $(test_unit_CoralBase_ClangBug100663compile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_ClangBug100663) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_ClangBug100663) ] || \
	  $(not_test_unit_CoralBase_ClangBug100663compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_ClangBug100663.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ClangBug100663_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) : $(test_unit_CoralBase_ClangBug100663compile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_ClangBug100663.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_ClangBug100663.in -tag=$(tags) $(test_unit_CoralBase_ClangBug100663_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663
else
$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) : $(test_unit_CoralBase_ClangBug100663compile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_ClangBug100663.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_ClangBug100663) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_ClangBug100663) ] || \
	  $(not_test_unit_CoralBase_ClangBug100663compile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_ClangBug100663.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_ClangBug100663.in -tag=$(tags) $(test_unit_CoralBase_ClangBug100663_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ClangBug100663_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663

test_unit_CoralBase_ClangBug100663 :: test_unit_CoralBase_ClangBug100663compile test_unit_CoralBase_ClangBug100663install ;

ifdef cmt_test_unit_CoralBase_ClangBug100663_has_prototypes

test_unit_CoralBase_ClangBug100663prototype : $(test_unit_CoralBase_ClangBug100663prototype_dependencies) $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) dirs test_unit_CoralBase_ClangBug100663dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_ClangBug100663compile : test_unit_CoralBase_ClangBug100663prototype

endif

test_unit_CoralBase_ClangBug100663compile : $(test_unit_CoralBase_ClangBug100663compile_dependencies) $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) dirs test_unit_CoralBase_ClangBug100663dirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_ClangBug100663clean ;

test_unit_CoralBase_ClangBug100663clean :: $(test_unit_CoralBase_ClangBug100663clean_dependencies) ##$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) test_unit_CoralBase_ClangBug100663clean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $(bin)test_unit_CoralBase_ClangBug100663_dependencies.make

install :: test_unit_CoralBase_ClangBug100663install ;

test_unit_CoralBase_ClangBug100663install :: test_unit_CoralBase_ClangBug100663compile $(test_unit_CoralBase_ClangBug100663_dependencies) $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_ClangBug100663uninstall

$(foreach d,$(test_unit_CoralBase_ClangBug100663_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_ClangBug100663uninstall))

test_unit_CoralBase_ClangBug100663uninstall : $(test_unit_CoralBase_ClangBug100663uninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_ClangBug100663_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ClangBug100663_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_ClangBug100663uninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_ClangBug100663"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_ClangBug100663 done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_CoralBaseTest_has_no_target_tag = 1
cmt_test_unit_CoralBase_CoralBaseTest_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_CoralBaseTest_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_CoralBaseTest = $(bin)$(CoralBase_tag)_test_unit_CoralBase_CoralBaseTest.make
cmt_final_setup_test_unit_CoralBase_CoralBaseTest = $(bin)setup_test_unit_CoralBase_CoralBaseTest.make
cmt_local_test_unit_CoralBase_CoralBaseTest_makefile = $(bin)test_unit_CoralBase_CoralBaseTest.make

test_unit_CoralBase_CoralBaseTest_extratags = -tag_add=target_test_unit_CoralBase_CoralBaseTest

else

cmt_local_tagfile_test_unit_CoralBase_CoralBaseTest = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_CoralBaseTest = $(bin)setup.make
cmt_local_test_unit_CoralBase_CoralBaseTest_makefile = $(bin)test_unit_CoralBase_CoralBaseTest.make

endif

not_test_unit_CoralBase_CoralBaseTestcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_CoralBaseTestcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_CoralBaseTestdirs :
	@if test ! -d $(bin)test_unit_CoralBase_CoralBaseTest; then $(mkdir) -p $(bin)test_unit_CoralBase_CoralBaseTest; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_CoralBaseTest
else
test_unit_CoralBase_CoralBaseTestdirs : ;
endif

ifdef cmt_test_unit_CoralBase_CoralBaseTest_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) : $(test_unit_CoralBase_CoralBaseTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_CoralBaseTest.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CoralBaseTest_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTest
else
$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) : $(test_unit_CoralBase_CoralBaseTestcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_CoralBaseTest) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_CoralBaseTest) ] || \
	  $(not_test_unit_CoralBase_CoralBaseTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_CoralBaseTest.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CoralBaseTest_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTest; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) : $(test_unit_CoralBase_CoralBaseTestcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_CoralBaseTest.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_CoralBaseTest.in -tag=$(tags) $(test_unit_CoralBase_CoralBaseTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTest
else
$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) : $(test_unit_CoralBase_CoralBaseTestcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_CoralBaseTest.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_CoralBaseTest) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_CoralBaseTest) ] || \
	  $(not_test_unit_CoralBase_CoralBaseTestcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_CoralBaseTest.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_CoralBaseTest.in -tag=$(tags) $(test_unit_CoralBase_CoralBaseTest_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTest; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CoralBaseTest_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTest

test_unit_CoralBase_CoralBaseTest :: test_unit_CoralBase_CoralBaseTestcompile test_unit_CoralBase_CoralBaseTestinstall ;

ifdef cmt_test_unit_CoralBase_CoralBaseTest_has_prototypes

test_unit_CoralBase_CoralBaseTestprototype : $(test_unit_CoralBase_CoralBaseTestprototype_dependencies) $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) dirs test_unit_CoralBase_CoralBaseTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_CoralBaseTestcompile : test_unit_CoralBase_CoralBaseTestprototype

endif

test_unit_CoralBase_CoralBaseTestcompile : $(test_unit_CoralBase_CoralBaseTestcompile_dependencies) $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) dirs test_unit_CoralBase_CoralBaseTestdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_CoralBaseTestclean ;

test_unit_CoralBase_CoralBaseTestclean :: $(test_unit_CoralBase_CoralBaseTestclean_dependencies) ##$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) test_unit_CoralBase_CoralBaseTestclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $(bin)test_unit_CoralBase_CoralBaseTest_dependencies.make

install :: test_unit_CoralBase_CoralBaseTestinstall ;

test_unit_CoralBase_CoralBaseTestinstall :: test_unit_CoralBase_CoralBaseTestcompile $(test_unit_CoralBase_CoralBaseTest_dependencies) $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_CoralBaseTestuninstall

$(foreach d,$(test_unit_CoralBase_CoralBaseTest_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_CoralBaseTestuninstall))

test_unit_CoralBase_CoralBaseTestuninstall : $(test_unit_CoralBase_CoralBaseTestuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CoralBaseTest_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_CoralBaseTestuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_CoralBaseTest"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_CoralBaseTest done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_CppUnitExample_has_no_target_tag = 1
cmt_test_unit_CoralBase_CppUnitExample_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_CppUnitExample_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_CppUnitExample = $(bin)$(CoralBase_tag)_test_unit_CoralBase_CppUnitExample.make
cmt_final_setup_test_unit_CoralBase_CppUnitExample = $(bin)setup_test_unit_CoralBase_CppUnitExample.make
cmt_local_test_unit_CoralBase_CppUnitExample_makefile = $(bin)test_unit_CoralBase_CppUnitExample.make

test_unit_CoralBase_CppUnitExample_extratags = -tag_add=target_test_unit_CoralBase_CppUnitExample

else

cmt_local_tagfile_test_unit_CoralBase_CppUnitExample = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_CppUnitExample = $(bin)setup.make
cmt_local_test_unit_CoralBase_CppUnitExample_makefile = $(bin)test_unit_CoralBase_CppUnitExample.make

endif

not_test_unit_CoralBase_CppUnitExamplecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_CppUnitExamplecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_CppUnitExampledirs :
	@if test ! -d $(bin)test_unit_CoralBase_CppUnitExample; then $(mkdir) -p $(bin)test_unit_CoralBase_CppUnitExample; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_CppUnitExample
else
test_unit_CoralBase_CppUnitExampledirs : ;
endif

ifdef cmt_test_unit_CoralBase_CppUnitExample_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) : $(test_unit_CoralBase_CppUnitExamplecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_CppUnitExample.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CppUnitExample_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExample
else
$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) : $(test_unit_CoralBase_CppUnitExamplecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_CppUnitExample) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_CppUnitExample) ] || \
	  $(not_test_unit_CoralBase_CppUnitExamplecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_CppUnitExample.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CppUnitExample_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExample; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) : $(test_unit_CoralBase_CppUnitExamplecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_CppUnitExample.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_CppUnitExample.in -tag=$(tags) $(test_unit_CoralBase_CppUnitExample_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExample
else
$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) : $(test_unit_CoralBase_CppUnitExamplecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_CppUnitExample.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_CppUnitExample) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_CppUnitExample) ] || \
	  $(not_test_unit_CoralBase_CppUnitExamplecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_CppUnitExample.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_CppUnitExample.in -tag=$(tags) $(test_unit_CoralBase_CppUnitExample_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExample; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_CppUnitExample_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExample

test_unit_CoralBase_CppUnitExample :: test_unit_CoralBase_CppUnitExamplecompile test_unit_CoralBase_CppUnitExampleinstall ;

ifdef cmt_test_unit_CoralBase_CppUnitExample_has_prototypes

test_unit_CoralBase_CppUnitExampleprototype : $(test_unit_CoralBase_CppUnitExampleprototype_dependencies) $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) dirs test_unit_CoralBase_CppUnitExampledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_CppUnitExamplecompile : test_unit_CoralBase_CppUnitExampleprototype

endif

test_unit_CoralBase_CppUnitExamplecompile : $(test_unit_CoralBase_CppUnitExamplecompile_dependencies) $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) dirs test_unit_CoralBase_CppUnitExampledirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_CppUnitExampleclean ;

test_unit_CoralBase_CppUnitExampleclean :: $(test_unit_CoralBase_CppUnitExampleclean_dependencies) ##$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) test_unit_CoralBase_CppUnitExampleclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $(bin)test_unit_CoralBase_CppUnitExample_dependencies.make

install :: test_unit_CoralBase_CppUnitExampleinstall ;

test_unit_CoralBase_CppUnitExampleinstall :: test_unit_CoralBase_CppUnitExamplecompile $(test_unit_CoralBase_CppUnitExample_dependencies) $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_CppUnitExampleuninstall

$(foreach d,$(test_unit_CoralBase_CppUnitExample_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_CppUnitExampleuninstall))

test_unit_CoralBase_CppUnitExampleuninstall : $(test_unit_CoralBase_CppUnitExampleuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_CppUnitExample_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_CppUnitExample_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_CppUnitExampleuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_CppUnitExample"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_CppUnitExample done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_DataTypeBug_has_no_target_tag = 1
cmt_test_unit_CoralBase_DataTypeBug_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_DataTypeBug_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_DataTypeBug = $(bin)$(CoralBase_tag)_test_unit_CoralBase_DataTypeBug.make
cmt_final_setup_test_unit_CoralBase_DataTypeBug = $(bin)setup_test_unit_CoralBase_DataTypeBug.make
cmt_local_test_unit_CoralBase_DataTypeBug_makefile = $(bin)test_unit_CoralBase_DataTypeBug.make

test_unit_CoralBase_DataTypeBug_extratags = -tag_add=target_test_unit_CoralBase_DataTypeBug

else

cmt_local_tagfile_test_unit_CoralBase_DataTypeBug = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_DataTypeBug = $(bin)setup.make
cmt_local_test_unit_CoralBase_DataTypeBug_makefile = $(bin)test_unit_CoralBase_DataTypeBug.make

endif

not_test_unit_CoralBase_DataTypeBugcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_DataTypeBugcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_DataTypeBugdirs :
	@if test ! -d $(bin)test_unit_CoralBase_DataTypeBug; then $(mkdir) -p $(bin)test_unit_CoralBase_DataTypeBug; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_DataTypeBug
else
test_unit_CoralBase_DataTypeBugdirs : ;
endif

ifdef cmt_test_unit_CoralBase_DataTypeBug_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) : $(test_unit_CoralBase_DataTypeBugcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_DataTypeBug.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_DataTypeBug_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBug
else
$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) : $(test_unit_CoralBase_DataTypeBugcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_DataTypeBug) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_DataTypeBug) ] || \
	  $(not_test_unit_CoralBase_DataTypeBugcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_DataTypeBug.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_DataTypeBug_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBug; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) : $(test_unit_CoralBase_DataTypeBugcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_DataTypeBug.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_DataTypeBug.in -tag=$(tags) $(test_unit_CoralBase_DataTypeBug_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBug
else
$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) : $(test_unit_CoralBase_DataTypeBugcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_DataTypeBug.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_DataTypeBug) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_DataTypeBug) ] || \
	  $(not_test_unit_CoralBase_DataTypeBugcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_DataTypeBug.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_DataTypeBug.in -tag=$(tags) $(test_unit_CoralBase_DataTypeBug_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBug; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_DataTypeBug_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBug

test_unit_CoralBase_DataTypeBug :: test_unit_CoralBase_DataTypeBugcompile test_unit_CoralBase_DataTypeBuginstall ;

ifdef cmt_test_unit_CoralBase_DataTypeBug_has_prototypes

test_unit_CoralBase_DataTypeBugprototype : $(test_unit_CoralBase_DataTypeBugprototype_dependencies) $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) dirs test_unit_CoralBase_DataTypeBugdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_DataTypeBugcompile : test_unit_CoralBase_DataTypeBugprototype

endif

test_unit_CoralBase_DataTypeBugcompile : $(test_unit_CoralBase_DataTypeBugcompile_dependencies) $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) dirs test_unit_CoralBase_DataTypeBugdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_DataTypeBugclean ;

test_unit_CoralBase_DataTypeBugclean :: $(test_unit_CoralBase_DataTypeBugclean_dependencies) ##$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) test_unit_CoralBase_DataTypeBugclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $(bin)test_unit_CoralBase_DataTypeBug_dependencies.make

install :: test_unit_CoralBase_DataTypeBuginstall ;

test_unit_CoralBase_DataTypeBuginstall :: test_unit_CoralBase_DataTypeBugcompile $(test_unit_CoralBase_DataTypeBug_dependencies) $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_DataTypeBuguninstall

$(foreach d,$(test_unit_CoralBase_DataTypeBug_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_DataTypeBuguninstall))

test_unit_CoralBase_DataTypeBuguninstall : $(test_unit_CoralBase_DataTypeBuguninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_DataTypeBug_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_DataTypeBug_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_DataTypeBuguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_DataTypeBug"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_DataTypeBug done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_Date_has_no_target_tag = 1
cmt_test_unit_CoralBase_Date_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_Date_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_Date = $(bin)$(CoralBase_tag)_test_unit_CoralBase_Date.make
cmt_final_setup_test_unit_CoralBase_Date = $(bin)setup_test_unit_CoralBase_Date.make
cmt_local_test_unit_CoralBase_Date_makefile = $(bin)test_unit_CoralBase_Date.make

test_unit_CoralBase_Date_extratags = -tag_add=target_test_unit_CoralBase_Date

else

cmt_local_tagfile_test_unit_CoralBase_Date = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_Date = $(bin)setup.make
cmt_local_test_unit_CoralBase_Date_makefile = $(bin)test_unit_CoralBase_Date.make

endif

not_test_unit_CoralBase_Datecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_Datecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_Datedirs :
	@if test ! -d $(bin)test_unit_CoralBase_Date; then $(mkdir) -p $(bin)test_unit_CoralBase_Date; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_Date
else
test_unit_CoralBase_Datedirs : ;
endif

ifdef cmt_test_unit_CoralBase_Date_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_Date_makefile) : $(test_unit_CoralBase_Datecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_Date.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_Date_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Date
else
$(cmt_local_test_unit_CoralBase_Date_makefile) : $(test_unit_CoralBase_Datecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_Date) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_Date) ] || \
	  $(not_test_unit_CoralBase_Datecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_Date.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_Date_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Date; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_Date_makefile) : $(test_unit_CoralBase_Datecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_Date.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_Date.in -tag=$(tags) $(test_unit_CoralBase_Date_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Date
else
$(cmt_local_test_unit_CoralBase_Date_makefile) : $(test_unit_CoralBase_Datecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_Date.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_Date) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_Date) ] || \
	  $(not_test_unit_CoralBase_Datecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_Date.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_Date.in -tag=$(tags) $(test_unit_CoralBase_Date_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Date; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_Date_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Date

test_unit_CoralBase_Date :: test_unit_CoralBase_Datecompile test_unit_CoralBase_Dateinstall ;

ifdef cmt_test_unit_CoralBase_Date_has_prototypes

test_unit_CoralBase_Dateprototype : $(test_unit_CoralBase_Dateprototype_dependencies) $(cmt_local_test_unit_CoralBase_Date_makefile) dirs test_unit_CoralBase_Datedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_Date_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_Datecompile : test_unit_CoralBase_Dateprototype

endif

test_unit_CoralBase_Datecompile : $(test_unit_CoralBase_Datecompile_dependencies) $(cmt_local_test_unit_CoralBase_Date_makefile) dirs test_unit_CoralBase_Datedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_Date_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_Dateclean ;

test_unit_CoralBase_Dateclean :: $(test_unit_CoralBase_Dateclean_dependencies) ##$(cmt_local_test_unit_CoralBase_Date_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_Date_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) test_unit_CoralBase_Dateclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_Date_makefile) $(bin)test_unit_CoralBase_Date_dependencies.make

install :: test_unit_CoralBase_Dateinstall ;

test_unit_CoralBase_Dateinstall :: test_unit_CoralBase_Datecompile $(test_unit_CoralBase_Date_dependencies) $(cmt_local_test_unit_CoralBase_Date_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_Date_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_Dateuninstall

$(foreach d,$(test_unit_CoralBase_Date_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_Dateuninstall))

test_unit_CoralBase_Dateuninstall : $(test_unit_CoralBase_Dateuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_Date_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_Date_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_Date_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_Dateuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_Date"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_Date done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_MessageStream_has_no_target_tag = 1
cmt_test_unit_CoralBase_MessageStream_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_MessageStream_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_MessageStream = $(bin)$(CoralBase_tag)_test_unit_CoralBase_MessageStream.make
cmt_final_setup_test_unit_CoralBase_MessageStream = $(bin)setup_test_unit_CoralBase_MessageStream.make
cmt_local_test_unit_CoralBase_MessageStream_makefile = $(bin)test_unit_CoralBase_MessageStream.make

test_unit_CoralBase_MessageStream_extratags = -tag_add=target_test_unit_CoralBase_MessageStream

else

cmt_local_tagfile_test_unit_CoralBase_MessageStream = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_MessageStream = $(bin)setup.make
cmt_local_test_unit_CoralBase_MessageStream_makefile = $(bin)test_unit_CoralBase_MessageStream.make

endif

not_test_unit_CoralBase_MessageStreamcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_MessageStreamcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_MessageStreamdirs :
	@if test ! -d $(bin)test_unit_CoralBase_MessageStream; then $(mkdir) -p $(bin)test_unit_CoralBase_MessageStream; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_MessageStream
else
test_unit_CoralBase_MessageStreamdirs : ;
endif

ifdef cmt_test_unit_CoralBase_MessageStream_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_MessageStream_makefile) : $(test_unit_CoralBase_MessageStreamcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_MessageStream.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_MessageStream_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStream
else
$(cmt_local_test_unit_CoralBase_MessageStream_makefile) : $(test_unit_CoralBase_MessageStreamcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_MessageStream) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_MessageStream) ] || \
	  $(not_test_unit_CoralBase_MessageStreamcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_MessageStream.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_MessageStream_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStream; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_MessageStream_makefile) : $(test_unit_CoralBase_MessageStreamcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_MessageStream.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_MessageStream.in -tag=$(tags) $(test_unit_CoralBase_MessageStream_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStream
else
$(cmt_local_test_unit_CoralBase_MessageStream_makefile) : $(test_unit_CoralBase_MessageStreamcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_MessageStream.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_MessageStream) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_MessageStream) ] || \
	  $(not_test_unit_CoralBase_MessageStreamcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_MessageStream.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_MessageStream.in -tag=$(tags) $(test_unit_CoralBase_MessageStream_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStream; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_MessageStream_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStream

test_unit_CoralBase_MessageStream :: test_unit_CoralBase_MessageStreamcompile test_unit_CoralBase_MessageStreaminstall ;

ifdef cmt_test_unit_CoralBase_MessageStream_has_prototypes

test_unit_CoralBase_MessageStreamprototype : $(test_unit_CoralBase_MessageStreamprototype_dependencies) $(cmt_local_test_unit_CoralBase_MessageStream_makefile) dirs test_unit_CoralBase_MessageStreamdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_MessageStreamcompile : test_unit_CoralBase_MessageStreamprototype

endif

test_unit_CoralBase_MessageStreamcompile : $(test_unit_CoralBase_MessageStreamcompile_dependencies) $(cmt_local_test_unit_CoralBase_MessageStream_makefile) dirs test_unit_CoralBase_MessageStreamdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_MessageStreamclean ;

test_unit_CoralBase_MessageStreamclean :: $(test_unit_CoralBase_MessageStreamclean_dependencies) ##$(cmt_local_test_unit_CoralBase_MessageStream_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) test_unit_CoralBase_MessageStreamclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $(bin)test_unit_CoralBase_MessageStream_dependencies.make

install :: test_unit_CoralBase_MessageStreaminstall ;

test_unit_CoralBase_MessageStreaminstall :: test_unit_CoralBase_MessageStreamcompile $(test_unit_CoralBase_MessageStream_dependencies) $(cmt_local_test_unit_CoralBase_MessageStream_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_MessageStreamuninstall

$(foreach d,$(test_unit_CoralBase_MessageStream_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_MessageStreamuninstall))

test_unit_CoralBase_MessageStreamuninstall : $(test_unit_CoralBase_MessageStreamuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_MessageStream_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_MessageStream_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_MessageStreamuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_MessageStream"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_MessageStream done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_TimeStamp_has_no_target_tag = 1
cmt_test_unit_CoralBase_TimeStamp_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_TimeStamp_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_TimeStamp = $(bin)$(CoralBase_tag)_test_unit_CoralBase_TimeStamp.make
cmt_final_setup_test_unit_CoralBase_TimeStamp = $(bin)setup_test_unit_CoralBase_TimeStamp.make
cmt_local_test_unit_CoralBase_TimeStamp_makefile = $(bin)test_unit_CoralBase_TimeStamp.make

test_unit_CoralBase_TimeStamp_extratags = -tag_add=target_test_unit_CoralBase_TimeStamp

else

cmt_local_tagfile_test_unit_CoralBase_TimeStamp = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_TimeStamp = $(bin)setup.make
cmt_local_test_unit_CoralBase_TimeStamp_makefile = $(bin)test_unit_CoralBase_TimeStamp.make

endif

not_test_unit_CoralBase_TimeStampcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_TimeStampcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_TimeStampdirs :
	@if test ! -d $(bin)test_unit_CoralBase_TimeStamp; then $(mkdir) -p $(bin)test_unit_CoralBase_TimeStamp; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_TimeStamp
else
test_unit_CoralBase_TimeStampdirs : ;
endif

ifdef cmt_test_unit_CoralBase_TimeStamp_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) : $(test_unit_CoralBase_TimeStampcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_TimeStamp.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_TimeStamp_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStamp
else
$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) : $(test_unit_CoralBase_TimeStampcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_TimeStamp) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_TimeStamp) ] || \
	  $(not_test_unit_CoralBase_TimeStampcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_TimeStamp.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_TimeStamp_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStamp; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) : $(test_unit_CoralBase_TimeStampcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_TimeStamp.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_TimeStamp.in -tag=$(tags) $(test_unit_CoralBase_TimeStamp_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStamp
else
$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) : $(test_unit_CoralBase_TimeStampcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_TimeStamp.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_TimeStamp) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_TimeStamp) ] || \
	  $(not_test_unit_CoralBase_TimeStampcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_TimeStamp.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_TimeStamp.in -tag=$(tags) $(test_unit_CoralBase_TimeStamp_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStamp; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_TimeStamp_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStamp

test_unit_CoralBase_TimeStamp :: test_unit_CoralBase_TimeStampcompile test_unit_CoralBase_TimeStampinstall ;

ifdef cmt_test_unit_CoralBase_TimeStamp_has_prototypes

test_unit_CoralBase_TimeStampprototype : $(test_unit_CoralBase_TimeStampprototype_dependencies) $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) dirs test_unit_CoralBase_TimeStampdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_TimeStampcompile : test_unit_CoralBase_TimeStampprototype

endif

test_unit_CoralBase_TimeStampcompile : $(test_unit_CoralBase_TimeStampcompile_dependencies) $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) dirs test_unit_CoralBase_TimeStampdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_TimeStampclean ;

test_unit_CoralBase_TimeStampclean :: $(test_unit_CoralBase_TimeStampclean_dependencies) ##$(cmt_local_test_unit_CoralBase_TimeStamp_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) test_unit_CoralBase_TimeStampclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $(bin)test_unit_CoralBase_TimeStamp_dependencies.make

install :: test_unit_CoralBase_TimeStampinstall ;

test_unit_CoralBase_TimeStampinstall :: test_unit_CoralBase_TimeStampcompile $(test_unit_CoralBase_TimeStamp_dependencies) $(cmt_local_test_unit_CoralBase_TimeStamp_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_TimeStampuninstall

$(foreach d,$(test_unit_CoralBase_TimeStamp_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_TimeStampuninstall))

test_unit_CoralBase_TimeStampuninstall : $(test_unit_CoralBase_TimeStampuninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_TimeStamp_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_TimeStamp_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_TimeStampuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_TimeStamp"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_TimeStamp done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralBase_ThreadProfiling_has_no_target_tag = 1
cmt_test_unit_CoralBase_ThreadProfiling_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralBase_ThreadProfiling_has_target_tag

cmt_local_tagfile_test_unit_CoralBase_ThreadProfiling = $(bin)$(CoralBase_tag)_test_unit_CoralBase_ThreadProfiling.make
cmt_final_setup_test_unit_CoralBase_ThreadProfiling = $(bin)setup_test_unit_CoralBase_ThreadProfiling.make
cmt_local_test_unit_CoralBase_ThreadProfiling_makefile = $(bin)test_unit_CoralBase_ThreadProfiling.make

test_unit_CoralBase_ThreadProfiling_extratags = -tag_add=target_test_unit_CoralBase_ThreadProfiling

else

cmt_local_tagfile_test_unit_CoralBase_ThreadProfiling = $(bin)$(CoralBase_tag).make
cmt_final_setup_test_unit_CoralBase_ThreadProfiling = $(bin)setup.make
cmt_local_test_unit_CoralBase_ThreadProfiling_makefile = $(bin)test_unit_CoralBase_ThreadProfiling.make

endif

not_test_unit_CoralBase_ThreadProfilingcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralBase_ThreadProfilingcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralBase_ThreadProfilingdirs :
	@if test ! -d $(bin)test_unit_CoralBase_ThreadProfiling; then $(mkdir) -p $(bin)test_unit_CoralBase_ThreadProfiling; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralBase_ThreadProfiling
else
test_unit_CoralBase_ThreadProfilingdirs : ;
endif

ifdef cmt_test_unit_CoralBase_ThreadProfiling_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) : $(test_unit_CoralBase_ThreadProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_ThreadProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ThreadProfiling_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfiling
else
$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) : $(test_unit_CoralBase_ThreadProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_ThreadProfiling) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_ThreadProfiling) ] || \
	  $(not_test_unit_CoralBase_ThreadProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_ThreadProfiling.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ThreadProfiling_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfiling; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) : $(test_unit_CoralBase_ThreadProfilingcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralBase_ThreadProfiling.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_ThreadProfiling.in -tag=$(tags) $(test_unit_CoralBase_ThreadProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfiling
else
$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) : $(test_unit_CoralBase_ThreadProfilingcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralBase_ThreadProfiling.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralBase_ThreadProfiling) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralBase_ThreadProfiling) ] || \
	  $(not_test_unit_CoralBase_ThreadProfilingcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralBase_ThreadProfiling.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralBase_ThreadProfiling.in -tag=$(tags) $(test_unit_CoralBase_ThreadProfiling_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfiling; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralBase_ThreadProfiling_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfiling

test_unit_CoralBase_ThreadProfiling :: test_unit_CoralBase_ThreadProfilingcompile test_unit_CoralBase_ThreadProfilinginstall ;

ifdef cmt_test_unit_CoralBase_ThreadProfiling_has_prototypes

test_unit_CoralBase_ThreadProfilingprototype : $(test_unit_CoralBase_ThreadProfilingprototype_dependencies) $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) dirs test_unit_CoralBase_ThreadProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralBase_ThreadProfilingcompile : test_unit_CoralBase_ThreadProfilingprototype

endif

test_unit_CoralBase_ThreadProfilingcompile : $(test_unit_CoralBase_ThreadProfilingcompile_dependencies) $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) dirs test_unit_CoralBase_ThreadProfilingdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralBase_ThreadProfilingclean ;

test_unit_CoralBase_ThreadProfilingclean :: $(test_unit_CoralBase_ThreadProfilingclean_dependencies) ##$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) test_unit_CoralBase_ThreadProfilingclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $(bin)test_unit_CoralBase_ThreadProfiling_dependencies.make

install :: test_unit_CoralBase_ThreadProfilinginstall ;

test_unit_CoralBase_ThreadProfilinginstall :: test_unit_CoralBase_ThreadProfilingcompile $(test_unit_CoralBase_ThreadProfiling_dependencies) $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralBase_ThreadProfilinguninstall

$(foreach d,$(test_unit_CoralBase_ThreadProfiling_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralBase_ThreadProfilinguninstall))

test_unit_CoralBase_ThreadProfilinguninstall : $(test_unit_CoralBase_ThreadProfilinguninstall_dependencies) ##$(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralBase_ThreadProfiling_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralBase_ThreadProfilinguninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralBase_ThreadProfiling"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralBase_ThreadProfiling done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralBase_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralBase_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralBase_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralBase_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralBase_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralBase_tag).make
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

cmt_lcg_mkdir_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_lcg_mkdir_has_target_tag

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralBase_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralBase_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(CoralBase_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoralBase_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoralBase_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralBase_tag).make
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
