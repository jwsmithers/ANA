
#-- start of constituents_header ------

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

tags      = $(tag),$(CMTEXTRATAGS)

CoralServerBase_tag = $(tag)

#cmt_local_tagfile = $(CoralServerBase_tag).make
cmt_local_tagfile = $(bin)$(CoralServerBase_tag).make

#-include $(cmt_local_tagfile)
include $(cmt_local_tagfile)

#cmt_local_setup = $(bin)setup$$$$.make
#cmt_local_setup = $(bin)$(package)setup$$$$.make
#cmt_final_setup = $(bin)CoralServerBasesetup.make
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

cmt_lcg_CoralServerBase_has_no_target_tag = 1
cmt_lcg_CoralServerBase_has_no_prototypes = 1

#--------------------------------------

ifdef cmt_lcg_CoralServerBase_has_target_tag

cmt_local_tagfile_lcg_CoralServerBase = $(bin)$(CoralServerBase_tag)_lcg_CoralServerBase.make
cmt_final_setup_lcg_CoralServerBase = $(bin)setup_lcg_CoralServerBase.make
cmt_local_lcg_CoralServerBase_makefile = $(bin)lcg_CoralServerBase.make

lcg_CoralServerBase_extratags = -tag_add=target_lcg_CoralServerBase

else

cmt_local_tagfile_lcg_CoralServerBase = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_lcg_CoralServerBase = $(bin)setup.make
cmt_local_lcg_CoralServerBase_makefile = $(bin)lcg_CoralServerBase.make

endif

not_lcg_CoralServerBasecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(lcg_CoralServerBasecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
lcg_CoralServerBasedirs :
	@if test ! -d $(bin)lcg_CoralServerBase; then $(mkdir) -p $(bin)lcg_CoralServerBase; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)lcg_CoralServerBase
else
lcg_CoralServerBasedirs : ;
endif

ifdef cmt_lcg_CoralServerBase_has_target_tag

ifndef QUICK
$(cmt_local_lcg_CoralServerBase_makefile) : $(lcg_CoralServerBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralServerBase.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralServerBase_extratags) build constituent_config -out=$(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBase
else
$(cmt_local_lcg_CoralServerBase_makefile) : $(lcg_CoralServerBasecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralServerBase) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralServerBase) ] || \
	  $(not_lcg_CoralServerBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralServerBase.make"; \
	  $(cmtexe) -tag=$(tags) $(lcg_CoralServerBase_extratags) build constituent_config -out=$(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBase; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_lcg_CoralServerBase_makefile) : $(lcg_CoralServerBasecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building lcg_CoralServerBase.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralServerBase.in -tag=$(tags) $(lcg_CoralServerBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBase
else
$(cmt_local_lcg_CoralServerBase_makefile) : $(lcg_CoralServerBasecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)lcg_CoralServerBase.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_lcg_CoralServerBase) ] || \
	  [ ! -f $(cmt_final_setup_lcg_CoralServerBase) ] || \
	  $(not_lcg_CoralServerBasecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building lcg_CoralServerBase.make"; \
	  $(cmtexe) -f=$(bin)lcg_CoralServerBase.in -tag=$(tags) $(lcg_CoralServerBase_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBase; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(lcg_CoralServerBase_extratags) build constituent_makefile -out=$(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBase

lcg_CoralServerBase :: lcg_CoralServerBasecompile lcg_CoralServerBaseinstall ;

ifdef cmt_lcg_CoralServerBase_has_prototypes

lcg_CoralServerBaseprototype : $(lcg_CoralServerBaseprototype_dependencies) $(cmt_local_lcg_CoralServerBase_makefile) dirs lcg_CoralServerBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralServerBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

lcg_CoralServerBasecompile : lcg_CoralServerBaseprototype

endif

lcg_CoralServerBasecompile : $(lcg_CoralServerBasecompile_dependencies) $(cmt_local_lcg_CoralServerBase_makefile) dirs lcg_CoralServerBasedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralServerBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: lcg_CoralServerBaseclean ;

lcg_CoralServerBaseclean :: $(lcg_CoralServerBaseclean_dependencies) ##$(cmt_local_lcg_CoralServerBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralServerBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) lcg_CoralServerBaseclean

##	  /bin/rm -f $(cmt_local_lcg_CoralServerBase_makefile) $(bin)lcg_CoralServerBase_dependencies.make

install :: lcg_CoralServerBaseinstall ;

lcg_CoralServerBaseinstall :: lcg_CoralServerBasecompile $(lcg_CoralServerBase_dependencies) $(cmt_local_lcg_CoralServerBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_lcg_CoralServerBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : lcg_CoralServerBaseuninstall

$(foreach d,$(lcg_CoralServerBase_dependencies),$(eval $(d)uninstall_dependencies += lcg_CoralServerBaseuninstall))

lcg_CoralServerBaseuninstall : $(lcg_CoralServerBaseuninstall_dependencies) ##$(cmt_local_lcg_CoralServerBase_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_lcg_CoralServerBase_makefile); then \
	  $(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_lcg_CoralServerBase_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: lcg_CoralServerBaseuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ lcg_CoralServerBase"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ lcg_CoralServerBase done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralServerBase_ByteBuffer_has_no_target_tag = 1
cmt_test_unit_CoralServerBase_ByteBuffer_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralServerBase_ByteBuffer_has_target_tag

cmt_local_tagfile_test_unit_CoralServerBase_ByteBuffer = $(bin)$(CoralServerBase_tag)_test_unit_CoralServerBase_ByteBuffer.make
cmt_final_setup_test_unit_CoralServerBase_ByteBuffer = $(bin)setup_test_unit_CoralServerBase_ByteBuffer.make
cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile = $(bin)test_unit_CoralServerBase_ByteBuffer.make

test_unit_CoralServerBase_ByteBuffer_extratags = -tag_add=target_test_unit_CoralServerBase_ByteBuffer

else

cmt_local_tagfile_test_unit_CoralServerBase_ByteBuffer = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_test_unit_CoralServerBase_ByteBuffer = $(bin)setup.make
cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile = $(bin)test_unit_CoralServerBase_ByteBuffer.make

endif

not_test_unit_CoralServerBase_ByteBuffercompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralServerBase_ByteBuffercompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralServerBase_ByteBufferdirs :
	@if test ! -d $(bin)test_unit_CoralServerBase_ByteBuffer; then $(mkdir) -p $(bin)test_unit_CoralServerBase_ByteBuffer; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralServerBase_ByteBuffer
else
test_unit_CoralServerBase_ByteBufferdirs : ;
endif

ifdef cmt_test_unit_CoralServerBase_ByteBuffer_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) : $(test_unit_CoralServerBase_ByteBuffercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_ByteBuffer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_ByteBuffer_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBuffer
else
$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) : $(test_unit_CoralServerBase_ByteBuffercompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_ByteBuffer) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_ByteBuffer) ] || \
	  $(not_test_unit_CoralServerBase_ByteBuffercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_ByteBuffer.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_ByteBuffer_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBuffer; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) : $(test_unit_CoralServerBase_ByteBuffercompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_ByteBuffer.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_ByteBuffer.in -tag=$(tags) $(test_unit_CoralServerBase_ByteBuffer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBuffer
else
$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) : $(test_unit_CoralServerBase_ByteBuffercompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralServerBase_ByteBuffer.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_ByteBuffer) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_ByteBuffer) ] || \
	  $(not_test_unit_CoralServerBase_ByteBuffercompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_ByteBuffer.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_ByteBuffer.in -tag=$(tags) $(test_unit_CoralServerBase_ByteBuffer_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBuffer; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_ByteBuffer_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBuffer

test_unit_CoralServerBase_ByteBuffer :: test_unit_CoralServerBase_ByteBuffercompile test_unit_CoralServerBase_ByteBufferinstall ;

ifdef cmt_test_unit_CoralServerBase_ByteBuffer_has_prototypes

test_unit_CoralServerBase_ByteBufferprototype : $(test_unit_CoralServerBase_ByteBufferprototype_dependencies) $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) dirs test_unit_CoralServerBase_ByteBufferdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralServerBase_ByteBuffercompile : test_unit_CoralServerBase_ByteBufferprototype

endif

test_unit_CoralServerBase_ByteBuffercompile : $(test_unit_CoralServerBase_ByteBuffercompile_dependencies) $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) dirs test_unit_CoralServerBase_ByteBufferdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralServerBase_ByteBufferclean ;

test_unit_CoralServerBase_ByteBufferclean :: $(test_unit_CoralServerBase_ByteBufferclean_dependencies) ##$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) test_unit_CoralServerBase_ByteBufferclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $(bin)test_unit_CoralServerBase_ByteBuffer_dependencies.make

install :: test_unit_CoralServerBase_ByteBufferinstall ;

test_unit_CoralServerBase_ByteBufferinstall :: test_unit_CoralServerBase_ByteBuffercompile $(test_unit_CoralServerBase_ByteBuffer_dependencies) $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralServerBase_ByteBufferuninstall

$(foreach d,$(test_unit_CoralServerBase_ByteBuffer_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralServerBase_ByteBufferuninstall))

test_unit_CoralServerBase_ByteBufferuninstall : $(test_unit_CoralServerBase_ByteBufferuninstall_dependencies) ##$(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_ByteBuffer_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralServerBase_ByteBufferuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralServerBase_ByteBuffer"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralServerBase_ByteBuffer done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralServerBase_CALOpcode_has_no_target_tag = 1
cmt_test_unit_CoralServerBase_CALOpcode_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralServerBase_CALOpcode_has_target_tag

cmt_local_tagfile_test_unit_CoralServerBase_CALOpcode = $(bin)$(CoralServerBase_tag)_test_unit_CoralServerBase_CALOpcode.make
cmt_final_setup_test_unit_CoralServerBase_CALOpcode = $(bin)setup_test_unit_CoralServerBase_CALOpcode.make
cmt_local_test_unit_CoralServerBase_CALOpcode_makefile = $(bin)test_unit_CoralServerBase_CALOpcode.make

test_unit_CoralServerBase_CALOpcode_extratags = -tag_add=target_test_unit_CoralServerBase_CALOpcode

else

cmt_local_tagfile_test_unit_CoralServerBase_CALOpcode = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_test_unit_CoralServerBase_CALOpcode = $(bin)setup.make
cmt_local_test_unit_CoralServerBase_CALOpcode_makefile = $(bin)test_unit_CoralServerBase_CALOpcode.make

endif

not_test_unit_CoralServerBase_CALOpcodecompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralServerBase_CALOpcodecompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralServerBase_CALOpcodedirs :
	@if test ! -d $(bin)test_unit_CoralServerBase_CALOpcode; then $(mkdir) -p $(bin)test_unit_CoralServerBase_CALOpcode; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralServerBase_CALOpcode
else
test_unit_CoralServerBase_CALOpcodedirs : ;
endif

ifdef cmt_test_unit_CoralServerBase_CALOpcode_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) : $(test_unit_CoralServerBase_CALOpcodecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CALOpcode.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALOpcode_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcode
else
$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) : $(test_unit_CoralServerBase_CALOpcodecompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CALOpcode) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CALOpcode) ] || \
	  $(not_test_unit_CoralServerBase_CALOpcodecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CALOpcode.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALOpcode_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcode; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) : $(test_unit_CoralServerBase_CALOpcodecompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CALOpcode.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CALOpcode.in -tag=$(tags) $(test_unit_CoralServerBase_CALOpcode_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcode
else
$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) : $(test_unit_CoralServerBase_CALOpcodecompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralServerBase_CALOpcode.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CALOpcode) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CALOpcode) ] || \
	  $(not_test_unit_CoralServerBase_CALOpcodecompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CALOpcode.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CALOpcode.in -tag=$(tags) $(test_unit_CoralServerBase_CALOpcode_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcode; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALOpcode_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcode

test_unit_CoralServerBase_CALOpcode :: test_unit_CoralServerBase_CALOpcodecompile test_unit_CoralServerBase_CALOpcodeinstall ;

ifdef cmt_test_unit_CoralServerBase_CALOpcode_has_prototypes

test_unit_CoralServerBase_CALOpcodeprototype : $(test_unit_CoralServerBase_CALOpcodeprototype_dependencies) $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) dirs test_unit_CoralServerBase_CALOpcodedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralServerBase_CALOpcodecompile : test_unit_CoralServerBase_CALOpcodeprototype

endif

test_unit_CoralServerBase_CALOpcodecompile : $(test_unit_CoralServerBase_CALOpcodecompile_dependencies) $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) dirs test_unit_CoralServerBase_CALOpcodedirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralServerBase_CALOpcodeclean ;

test_unit_CoralServerBase_CALOpcodeclean :: $(test_unit_CoralServerBase_CALOpcodeclean_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) test_unit_CoralServerBase_CALOpcodeclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $(bin)test_unit_CoralServerBase_CALOpcode_dependencies.make

install :: test_unit_CoralServerBase_CALOpcodeinstall ;

test_unit_CoralServerBase_CALOpcodeinstall :: test_unit_CoralServerBase_CALOpcodecompile $(test_unit_CoralServerBase_CALOpcode_dependencies) $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralServerBase_CALOpcodeuninstall

$(foreach d,$(test_unit_CoralServerBase_CALOpcode_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralServerBase_CALOpcodeuninstall))

test_unit_CoralServerBase_CALOpcodeuninstall : $(test_unit_CoralServerBase_CALOpcodeuninstall_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALOpcode_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralServerBase_CALOpcodeuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralServerBase_CALOpcode"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralServerBase_CALOpcode done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralServerBase_CALPacket_has_no_target_tag = 1
cmt_test_unit_CoralServerBase_CALPacket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralServerBase_CALPacket_has_target_tag

cmt_local_tagfile_test_unit_CoralServerBase_CALPacket = $(bin)$(CoralServerBase_tag)_test_unit_CoralServerBase_CALPacket.make
cmt_final_setup_test_unit_CoralServerBase_CALPacket = $(bin)setup_test_unit_CoralServerBase_CALPacket.make
cmt_local_test_unit_CoralServerBase_CALPacket_makefile = $(bin)test_unit_CoralServerBase_CALPacket.make

test_unit_CoralServerBase_CALPacket_extratags = -tag_add=target_test_unit_CoralServerBase_CALPacket

else

cmt_local_tagfile_test_unit_CoralServerBase_CALPacket = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_test_unit_CoralServerBase_CALPacket = $(bin)setup.make
cmt_local_test_unit_CoralServerBase_CALPacket_makefile = $(bin)test_unit_CoralServerBase_CALPacket.make

endif

not_test_unit_CoralServerBase_CALPacketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralServerBase_CALPacketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralServerBase_CALPacketdirs :
	@if test ! -d $(bin)test_unit_CoralServerBase_CALPacket; then $(mkdir) -p $(bin)test_unit_CoralServerBase_CALPacket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralServerBase_CALPacket
else
test_unit_CoralServerBase_CALPacketdirs : ;
endif

ifdef cmt_test_unit_CoralServerBase_CALPacket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) : $(test_unit_CoralServerBase_CALPacketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CALPacket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALPacket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacket
else
$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) : $(test_unit_CoralServerBase_CALPacketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CALPacket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CALPacket) ] || \
	  $(not_test_unit_CoralServerBase_CALPacketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CALPacket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALPacket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) : $(test_unit_CoralServerBase_CALPacketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CALPacket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CALPacket.in -tag=$(tags) $(test_unit_CoralServerBase_CALPacket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacket
else
$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) : $(test_unit_CoralServerBase_CALPacketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralServerBase_CALPacket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CALPacket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CALPacket) ] || \
	  $(not_test_unit_CoralServerBase_CALPacketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CALPacket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CALPacket.in -tag=$(tags) $(test_unit_CoralServerBase_CALPacket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CALPacket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacket

test_unit_CoralServerBase_CALPacket :: test_unit_CoralServerBase_CALPacketcompile test_unit_CoralServerBase_CALPacketinstall ;

ifdef cmt_test_unit_CoralServerBase_CALPacket_has_prototypes

test_unit_CoralServerBase_CALPacketprototype : $(test_unit_CoralServerBase_CALPacketprototype_dependencies) $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) dirs test_unit_CoralServerBase_CALPacketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralServerBase_CALPacketcompile : test_unit_CoralServerBase_CALPacketprototype

endif

test_unit_CoralServerBase_CALPacketcompile : $(test_unit_CoralServerBase_CALPacketcompile_dependencies) $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) dirs test_unit_CoralServerBase_CALPacketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralServerBase_CALPacketclean ;

test_unit_CoralServerBase_CALPacketclean :: $(test_unit_CoralServerBase_CALPacketclean_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) test_unit_CoralServerBase_CALPacketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $(bin)test_unit_CoralServerBase_CALPacket_dependencies.make

install :: test_unit_CoralServerBase_CALPacketinstall ;

test_unit_CoralServerBase_CALPacketinstall :: test_unit_CoralServerBase_CALPacketcompile $(test_unit_CoralServerBase_CALPacket_dependencies) $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralServerBase_CALPacketuninstall

$(foreach d,$(test_unit_CoralServerBase_CALPacket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralServerBase_CALPacketuninstall))

test_unit_CoralServerBase_CALPacketuninstall : $(test_unit_CoralServerBase_CALPacketuninstall_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CALPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CALPacket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralServerBase_CALPacketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralServerBase_CALPacket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralServerBase_CALPacket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralServerBase_CoralServerProxyException_has_no_target_tag = 1
cmt_test_unit_CoralServerBase_CoralServerProxyException_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralServerBase_CoralServerProxyException_has_target_tag

cmt_local_tagfile_test_unit_CoralServerBase_CoralServerProxyException = $(bin)$(CoralServerBase_tag)_test_unit_CoralServerBase_CoralServerProxyException.make
cmt_final_setup_test_unit_CoralServerBase_CoralServerProxyException = $(bin)setup_test_unit_CoralServerBase_CoralServerProxyException.make
cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile = $(bin)test_unit_CoralServerBase_CoralServerProxyException.make

test_unit_CoralServerBase_CoralServerProxyException_extratags = -tag_add=target_test_unit_CoralServerBase_CoralServerProxyException

else

cmt_local_tagfile_test_unit_CoralServerBase_CoralServerProxyException = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_test_unit_CoralServerBase_CoralServerProxyException = $(bin)setup.make
cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile = $(bin)test_unit_CoralServerBase_CoralServerProxyException.make

endif

not_test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralServerBase_CoralServerProxyExceptiondirs :
	@if test ! -d $(bin)test_unit_CoralServerBase_CoralServerProxyException; then $(mkdir) -p $(bin)test_unit_CoralServerBase_CoralServerProxyException; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralServerBase_CoralServerProxyException
else
test_unit_CoralServerBase_CoralServerProxyExceptiondirs : ;
endif

ifdef cmt_test_unit_CoralServerBase_CoralServerProxyException_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) : $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CoralServerProxyException.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CoralServerProxyException_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyException
else
$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) : $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CoralServerProxyException) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CoralServerProxyException) ] || \
	  $(not_test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CoralServerProxyException.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CoralServerProxyException_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyException; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) : $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CoralServerProxyException.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CoralServerProxyException.in -tag=$(tags) $(test_unit_CoralServerBase_CoralServerProxyException_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyException
else
$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) : $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralServerBase_CoralServerProxyException.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CoralServerProxyException) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CoralServerProxyException) ] || \
	  $(not_test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CoralServerProxyException.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CoralServerProxyException.in -tag=$(tags) $(test_unit_CoralServerBase_CoralServerProxyException_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyException; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CoralServerProxyException_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyException

test_unit_CoralServerBase_CoralServerProxyException :: test_unit_CoralServerBase_CoralServerProxyExceptioncompile test_unit_CoralServerBase_CoralServerProxyExceptioninstall ;

ifdef cmt_test_unit_CoralServerBase_CoralServerProxyException_has_prototypes

test_unit_CoralServerBase_CoralServerProxyExceptionprototype : $(test_unit_CoralServerBase_CoralServerProxyExceptionprototype_dependencies) $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) dirs test_unit_CoralServerBase_CoralServerProxyExceptiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralServerBase_CoralServerProxyExceptioncompile : test_unit_CoralServerBase_CoralServerProxyExceptionprototype

endif

test_unit_CoralServerBase_CoralServerProxyExceptioncompile : $(test_unit_CoralServerBase_CoralServerProxyExceptioncompile_dependencies) $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) dirs test_unit_CoralServerBase_CoralServerProxyExceptiondirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralServerBase_CoralServerProxyExceptionclean ;

test_unit_CoralServerBase_CoralServerProxyExceptionclean :: $(test_unit_CoralServerBase_CoralServerProxyExceptionclean_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) test_unit_CoralServerBase_CoralServerProxyExceptionclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $(bin)test_unit_CoralServerBase_CoralServerProxyException_dependencies.make

install :: test_unit_CoralServerBase_CoralServerProxyExceptioninstall ;

test_unit_CoralServerBase_CoralServerProxyExceptioninstall :: test_unit_CoralServerBase_CoralServerProxyExceptioncompile $(test_unit_CoralServerBase_CoralServerProxyException_dependencies) $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralServerBase_CoralServerProxyExceptionuninstall

$(foreach d,$(test_unit_CoralServerBase_CoralServerProxyException_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralServerBase_CoralServerProxyExceptionuninstall))

test_unit_CoralServerBase_CoralServerProxyExceptionuninstall : $(test_unit_CoralServerBase_CoralServerProxyExceptionuninstall_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CoralServerProxyException_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralServerBase_CoralServerProxyExceptionuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralServerBase_CoralServerProxyException"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralServerBase_CoralServerProxyException done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent_app_lib ------

cmt_test_unit_CoralServerBase_CTLPacket_has_no_target_tag = 1
cmt_test_unit_CoralServerBase_CTLPacket_has_prototypes = 1

#--------------------------------------

ifdef cmt_test_unit_CoralServerBase_CTLPacket_has_target_tag

cmt_local_tagfile_test_unit_CoralServerBase_CTLPacket = $(bin)$(CoralServerBase_tag)_test_unit_CoralServerBase_CTLPacket.make
cmt_final_setup_test_unit_CoralServerBase_CTLPacket = $(bin)setup_test_unit_CoralServerBase_CTLPacket.make
cmt_local_test_unit_CoralServerBase_CTLPacket_makefile = $(bin)test_unit_CoralServerBase_CTLPacket.make

test_unit_CoralServerBase_CTLPacket_extratags = -tag_add=target_test_unit_CoralServerBase_CTLPacket

else

cmt_local_tagfile_test_unit_CoralServerBase_CTLPacket = $(bin)$(CoralServerBase_tag).make
cmt_final_setup_test_unit_CoralServerBase_CTLPacket = $(bin)setup.make
cmt_local_test_unit_CoralServerBase_CTLPacket_makefile = $(bin)test_unit_CoralServerBase_CTLPacket.make

endif

not_test_unit_CoralServerBase_CTLPacketcompile_dependencies = { n=0; for p in $?; do m=0; for d in $(test_unit_CoralServerBase_CTLPacketcompile_dependencies); do if [ $$p = $$d ]; then m=1; break; fi; done; if [ $$m -eq 0 ]; then n=1; break; fi; done; [ $$n -eq 1 ]; }

ifdef STRUCTURED_OUTPUT
test_unit_CoralServerBase_CTLPacketdirs :
	@if test ! -d $(bin)test_unit_CoralServerBase_CTLPacket; then $(mkdir) -p $(bin)test_unit_CoralServerBase_CTLPacket; fi
	$(echo) "STRUCTURED_OUTPUT="$(bin)test_unit_CoralServerBase_CTLPacket
else
test_unit_CoralServerBase_CTLPacketdirs : ;
endif

ifdef cmt_test_unit_CoralServerBase_CTLPacket_has_target_tag

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) : $(test_unit_CoralServerBase_CTLPacketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CTLPacket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CTLPacket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacket
else
$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) : $(test_unit_CoralServerBase_CTLPacketcompile_dependencies) $(cmt_build_library_linksstamp) $(use_requirements)
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CTLPacket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CTLPacket) ] || \
	  $(not_test_unit_CoralServerBase_CTLPacketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CTLPacket.make"; \
	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CTLPacket_extratags) build constituent_config -out=$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacket; \
	  fi
endif

else

ifndef QUICK
$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) : $(test_unit_CoralServerBase_CTLPacketcompile_dependencies) build_library_links
	$(echo) "(constituents.make) Building test_unit_CoralServerBase_CTLPacket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CTLPacket.in -tag=$(tags) $(test_unit_CoralServerBase_CTLPacket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacket
else
$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) : $(test_unit_CoralServerBase_CTLPacketcompile_dependencies) $(cmt_build_library_linksstamp) $(bin)test_unit_CoralServerBase_CTLPacket.in
	@if [ ! -f $@ ] || [ ! -f $(cmt_local_tagfile_test_unit_CoralServerBase_CTLPacket) ] || \
	  [ ! -f $(cmt_final_setup_test_unit_CoralServerBase_CTLPacket) ] || \
	  $(not_test_unit_CoralServerBase_CTLPacketcompile_dependencies) ; then \
	  test -z "$(cmtmsg)" || \
	  echo "$(CMTMSGPREFIX)" "(constituents.make) Building test_unit_CoralServerBase_CTLPacket.make"; \
	  $(cmtexe) -f=$(bin)test_unit_CoralServerBase_CTLPacket.in -tag=$(tags) $(test_unit_CoralServerBase_CTLPacket_extratags) build constituent_makefile -without_cmt -out=$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacket; \
	  fi
endif

endif

#	  $(cmtexe) -tag=$(tags) $(test_unit_CoralServerBase_CTLPacket_extratags) build constituent_makefile -out=$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacket

test_unit_CoralServerBase_CTLPacket :: test_unit_CoralServerBase_CTLPacketcompile test_unit_CoralServerBase_CTLPacketinstall ;

ifdef cmt_test_unit_CoralServerBase_CTLPacket_has_prototypes

test_unit_CoralServerBase_CTLPacketprototype : $(test_unit_CoralServerBase_CTLPacketprototype_dependencies) $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) dirs test_unit_CoralServerBase_CTLPacketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

test_unit_CoralServerBase_CTLPacketcompile : test_unit_CoralServerBase_CTLPacketprototype

endif

test_unit_CoralServerBase_CTLPacketcompile : $(test_unit_CoralServerBase_CTLPacketcompile_dependencies) $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) dirs test_unit_CoralServerBase_CTLPacketdirs
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

clean :: test_unit_CoralServerBase_CTLPacketclean ;

test_unit_CoralServerBase_CTLPacketclean :: $(test_unit_CoralServerBase_CTLPacketclean_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@; \
	fi
	$(echo) "(constituents.make) $@ done"
#	@-$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) test_unit_CoralServerBase_CTLPacketclean

##	  /bin/rm -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $(bin)test_unit_CoralServerBase_CTLPacket_dependencies.make

install :: test_unit_CoralServerBase_CTLPacketinstall ;

test_unit_CoralServerBase_CTLPacketinstall :: test_unit_CoralServerBase_CTLPacketcompile $(test_unit_CoralServerBase_CTLPacket_dependencies) $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@if test -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) $@
	$(echo) "(constituents.make) $@ done"

uninstall : test_unit_CoralServerBase_CTLPacketuninstall

$(foreach d,$(test_unit_CoralServerBase_CTLPacket_dependencies),$(eval $(d)uninstall_dependencies += test_unit_CoralServerBase_CTLPacketuninstall))

test_unit_CoralServerBase_CTLPacketuninstall : $(test_unit_CoralServerBase_CTLPacketuninstall_dependencies) ##$(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile)
	$(echo) "(constituents.make) Starting $@"
	@-if test -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile); then \
	  $(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) uninstall; \
	  fi
#	@$(MAKE) -f $(cmt_local_test_unit_CoralServerBase_CTLPacket_makefile) uninstall
	$(echo) "(constituents.make) $@ done"

remove_library_links :: test_unit_CoralServerBase_CTLPacketuninstall ;

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(constituents.make) Starting $@ test_unit_CoralServerBase_CTLPacket"
	$(echo) Using default action for $@
	$(echo) "(constituents.make) $@ test_unit_CoralServerBase_CTLPacket done"
endif

#-- end of constituent_app_lib ------
#-- start of constituent ------

cmt_install_includes_has_no_target_tag = 1

#--------------------------------------

ifdef cmt_install_includes_has_target_tag

cmt_local_tagfile_install_includes = $(bin)$(CoralServerBase_tag)_install_includes.make
cmt_final_setup_install_includes = $(bin)setup_install_includes.make
cmt_local_install_includes_makefile = $(bin)install_includes.make

install_includes_extratags = -tag_add=target_install_includes

else

cmt_local_tagfile_install_includes = $(bin)$(CoralServerBase_tag).make
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

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralServerBase_tag)_install_pythonmods.make
cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

install_pythonmods_extratags = -tag_add=target_install_pythonmods

else

cmt_local_tagfile_install_pythonmods = $(bin)$(CoralServerBase_tag).make
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

cmt_local_tagfile_make = $(bin)$(CoralServerBase_tag)_make.make
cmt_final_setup_make = $(bin)setup_make.make
cmt_local_make_makefile = $(bin)make.make

make_extratags = -tag_add=target_make

else

cmt_local_tagfile_make = $(bin)$(CoralServerBase_tag).make
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

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralServerBase_tag)_lcg_mkdir.make
cmt_final_setup_lcg_mkdir = $(bin)setup_lcg_mkdir.make
cmt_local_lcg_mkdir_makefile = $(bin)lcg_mkdir.make

lcg_mkdir_extratags = -tag_add=target_lcg_mkdir

else

cmt_local_tagfile_lcg_mkdir = $(bin)$(CoralServerBase_tag).make
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

cmt_local_tagfile_utilities = $(bin)$(CoralServerBase_tag)_utilities.make
cmt_final_setup_utilities = $(bin)setup_utilities.make
cmt_local_utilities_makefile = $(bin)utilities.make

utilities_extratags = -tag_add=target_utilities

else

cmt_local_tagfile_utilities = $(bin)$(CoralServerBase_tag).make
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

cmt_local_tagfile_examples = $(bin)$(CoralServerBase_tag)_examples.make
cmt_final_setup_examples = $(bin)setup_examples.make
cmt_local_examples_makefile = $(bin)examples.make

examples_extratags = -tag_add=target_examples

else

cmt_local_tagfile_examples = $(bin)$(CoralServerBase_tag).make
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
