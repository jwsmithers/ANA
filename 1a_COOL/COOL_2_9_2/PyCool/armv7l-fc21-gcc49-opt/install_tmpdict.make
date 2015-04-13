#-- start of make_header -----------------

#====================================
#  Document install_tmpdict
#
#   Generated Tue Mar 31 09:54:57 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_tmpdict_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_tmpdict_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_tmpdict

PyCool_tag = $(tag)

#cmt_local_tagfile_install_tmpdict = $(PyCool_tag)_install_tmpdict.make
cmt_local_tagfile_install_tmpdict = $(bin)$(PyCool_tag)_install_tmpdict.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCool_tag = $(tag)

#cmt_local_tagfile_install_tmpdict = $(PyCool_tag).make
cmt_local_tagfile_install_tmpdict = $(bin)$(PyCool_tag).make

endif

include $(cmt_local_tagfile_install_tmpdict)
#-include $(cmt_local_tagfile_install_tmpdict)

ifdef cmt_install_tmpdict_has_target_tag

cmt_final_setup_install_tmpdict = $(bin)setup_install_tmpdict.make
cmt_dependencies_in_install_tmpdict = $(bin)dependencies_install_tmpdict.in
#cmt_final_setup_install_tmpdict = $(bin)PyCool_install_tmpdictsetup.make
cmt_local_install_tmpdict_makefile = $(bin)install_tmpdict.make

else

cmt_final_setup_install_tmpdict = $(bin)setup.make
cmt_dependencies_in_install_tmpdict = $(bin)dependencies.in
#cmt_final_setup_install_tmpdict = $(bin)PyCoolsetup.make
cmt_local_install_tmpdict_makefile = $(bin)install_tmpdict.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoolsetup.make

#install_tmpdict :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_tmpdict'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_tmpdict/
#install_tmpdict::
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
install_tmpdict_once = 1
endif

ifdef install_tmpdict_once

install_tmpdictactionstamp = $(bin)install_tmpdict.actionstamp
#install_tmpdictactionstamp = install_tmpdict.actionstamp

install_tmpdict :: $(install_tmpdictactionstamp)
	$(echo) "install_tmpdict ok"
#	@echo install_tmpdict ok

#$(install_tmpdictactionstamp) :: $(install_tmpdict_dependencies)
$(install_tmpdictactionstamp) ::
	$(silent) mkdir -p /home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tmp; cp -rf ../armv7l-fc21-gcc49-opt/dict /home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tmp/.
	$(silent) cat /dev/null > $(install_tmpdictactionstamp)
#	@echo ok > $(install_tmpdictactionstamp)

install_tmpdictclean ::
	$(cleanup_silent) /bin/rm -f $(install_tmpdictactionstamp)

else

#install_tmpdict :: $(install_tmpdict_dependencies)
install_tmpdict ::
	$(silent) mkdir -p /home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tmp; cp -rf ../armv7l-fc21-gcc49-opt/dict /home/jwsmith/HDD/COOL/COOL_2_9_2/../armv7l-fc21-gcc49-opt/tmp/.

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: install_tmpdictclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_tmpdict.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_tmpdictclean ::
#-- end of cleanup_header ---------------
