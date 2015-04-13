#-- start of make_header -----------------

#====================================
#  Document install_scripts
#
#   Generated Tue Mar 31 10:25:39 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_scripts_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_scripts_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_scripts

config_tag = $(tag)

#cmt_local_tagfile_install_scripts = $(config_tag)_install_scripts.make
cmt_local_tagfile_install_scripts = $(bin)$(config_tag)_install_scripts.make

else

tags      = $(tag),$(CMTEXTRATAGS)

config_tag = $(tag)

#cmt_local_tagfile_install_scripts = $(config_tag).make
cmt_local_tagfile_install_scripts = $(bin)$(config_tag).make

endif

include $(cmt_local_tagfile_install_scripts)
#-include $(cmt_local_tagfile_install_scripts)

ifdef cmt_install_scripts_has_target_tag

cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_dependencies_in_install_scripts = $(bin)dependencies_install_scripts.in
#cmt_final_setup_install_scripts = $(bin)config_install_scriptssetup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

else

cmt_final_setup_install_scripts = $(bin)setup.make
cmt_dependencies_in_install_scripts = $(bin)dependencies.in
#cmt_final_setup_install_scripts = $(bin)configsetup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)configsetup.make

#install_scripts :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_scripts'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_scripts/
#install_scripts::
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
install_scripts_once = 1
endif

ifdef install_scripts_once

install_scriptsactionstamp = $(bin)install_scripts.actionstamp
#install_scriptsactionstamp = install_scripts.actionstamp

install_scripts :: $(install_scriptsactionstamp)
	$(echo) "install_scripts ok"
#	@echo install_scripts ok

#$(install_scriptsactionstamp) :: $(install_scripts_dependencies)
$(install_scriptsactionstamp) ::
	$(silent) mkdir -p /home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/bin; cp -r ../scripts/*.* /home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/bin/.
	$(silent) cat /dev/null > $(install_scriptsactionstamp)
#	@echo ok > $(install_scriptsactionstamp)

install_scriptsclean ::
	$(cleanup_silent) /bin/rm -f $(install_scriptsactionstamp)

else

#install_scripts :: $(install_scripts_dependencies)
install_scripts ::
	$(silent) mkdir -p /home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/bin; cp -r ../scripts/*.* /home/jwsmith/HDD/../armv7l-fc21-gcc49-opt/bin/.

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: install_scriptsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_scripts.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_scriptsclean ::
#-- end of cleanup_header ---------------
