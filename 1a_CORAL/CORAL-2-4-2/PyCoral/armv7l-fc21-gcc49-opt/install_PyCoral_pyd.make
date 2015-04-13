#-- start of make_header -----------------

#====================================
#  Document install_PyCoral_pyd
#
#   Generated Tue Mar 31 10:25:36 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_PyCoral_pyd_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_PyCoral_pyd_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_PyCoral_pyd

PyCoral_tag = $(tag)

#cmt_local_tagfile_install_PyCoral_pyd = $(PyCoral_tag)_install_PyCoral_pyd.make
cmt_local_tagfile_install_PyCoral_pyd = $(bin)$(PyCoral_tag)_install_PyCoral_pyd.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCoral_tag = $(tag)

#cmt_local_tagfile_install_PyCoral_pyd = $(PyCoral_tag).make
cmt_local_tagfile_install_PyCoral_pyd = $(bin)$(PyCoral_tag).make

endif

include $(cmt_local_tagfile_install_PyCoral_pyd)
#-include $(cmt_local_tagfile_install_PyCoral_pyd)

ifdef cmt_install_PyCoral_pyd_has_target_tag

cmt_final_setup_install_PyCoral_pyd = $(bin)setup_install_PyCoral_pyd.make
cmt_dependencies_in_install_PyCoral_pyd = $(bin)dependencies_install_PyCoral_pyd.in
#cmt_final_setup_install_PyCoral_pyd = $(bin)PyCoral_install_PyCoral_pydsetup.make
cmt_local_install_PyCoral_pyd_makefile = $(bin)install_PyCoral_pyd.make

else

cmt_final_setup_install_PyCoral_pyd = $(bin)setup.make
cmt_dependencies_in_install_PyCoral_pyd = $(bin)dependencies.in
#cmt_final_setup_install_PyCoral_pyd = $(bin)PyCoralsetup.make
cmt_local_install_PyCoral_pyd_makefile = $(bin)install_PyCoral_pyd.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoralsetup.make

#install_PyCoral_pyd :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_PyCoral_pyd'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_PyCoral_pyd/
#install_PyCoral_pyd::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of cmt_action_runner_header ---------------

ifdef ONCE
install_PyCoral_pyd_once = 1
endif

ifdef install_PyCoral_pyd_once

install_PyCoral_pydactionstamp = $(bin)install_PyCoral_pyd.actionstamp
#install_PyCoral_pydactionstamp = install_PyCoral_pyd.actionstamp

install_PyCoral_pyd :: $(install_PyCoral_pydactionstamp)
	$(echo) "install_PyCoral_pyd ok"
#	@echo install_PyCoral_pyd ok

#$(install_PyCoral_pydactionstamp) :: $(install_PyCoral_pyd_dependencies)
$(install_PyCoral_pydactionstamp) ::
	$(silent) echo
	$(silent) cat /dev/null > $(install_PyCoral_pydactionstamp)
#	@echo ok > $(install_PyCoral_pydactionstamp)

install_PyCoral_pydclean ::
	$(cleanup_silent) /bin/rm -f $(install_PyCoral_pydactionstamp)

else

#install_PyCoral_pyd :: $(install_PyCoral_pyd_dependencies)
install_PyCoral_pyd ::
	$(silent) echo

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
No__dependencies = ../src/No
pyd__dependencies = ../src/pyd
needed__dependencies = ../src/needed
on__dependencies = ../src/on
this__dependencies = ../src/this
platform__dependencies = ../src/platform
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cmt_action_runner ----------------------
#-- end of cmt_action_runner ------------------------
#-- start of cleanup_header --------------

clean :: install_PyCoral_pydclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_PyCoral_pyd.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_PyCoral_pydclean ::
#-- end of cleanup_header ---------------
