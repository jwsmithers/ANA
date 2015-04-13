#-- start of make_header -----------------

#====================================
#  Document install_scripts
#
#   Generated Mon Feb 16 20:05:10 2015  by jwsmith
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

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_install_scripts = $(GaudiProfiling_tag)_install_scripts.make
cmt_local_tagfile_install_scripts = $(bin)$(GaudiProfiling_tag)_install_scripts.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_install_scripts = $(GaudiProfiling_tag).make
cmt_local_tagfile_install_scripts = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_install_scripts)
#-include $(cmt_local_tagfile_install_scripts)

ifdef cmt_install_scripts_has_target_tag

cmt_final_setup_install_scripts = $(bin)setup_install_scripts.make
cmt_dependencies_in_install_scripts = $(bin)dependencies_install_scripts.in
#cmt_final_setup_install_scripts = $(bin)GaudiProfiling_install_scriptssetup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

else

cmt_final_setup_install_scripts = $(bin)setup.make
cmt_dependencies_in_install_scripts = $(bin)dependencies.in
#cmt_final_setup_install_scripts = $(bin)GaudiProfilingsetup.make
cmt_local_install_scripts_makefile = $(bin)install_scripts.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

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
#-- start of install_scripts_header ------


installarea = ${CMTINSTALLAREA}$(shared_install_subdir)
install_scripts_dir = $(installarea)/.

install_scripts :: install_scriptsinstall

install :: install_scriptsinstall

install_scriptsinstall :: $(install_scripts_dir)
	@if [ ! "$(installarea)" = "" ]; then\
	  echo "installation done"; \
	fi

$(install_scripts_dir) ::
	@if [ "$(installarea)" = "" ]; then \
	  echo "Cannot install header files, no installation source specified"; \
	else \
      src=../scripts ; \
	  dest=$(install_scripts_dir) ; \
	  if [ -d $$src ]; then \
	     echo "Installing files from source $$src to $$dest"; \
	     $(install_command) --exclude="*.py?" $$src $$dest ;\
	     chmod -R +x $$dest/scripts ; \
	  else \
	     echo "no source  $$src"; \
	  fi; \
	fi

install_scriptsclean :: install_scriptsuninstall

uninstall :: install_scriptsuninstall

install_scriptsuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
      dest=$(install_scripts_dir) ; \
	  echo "Uninstalling files from $$dest"; \
	  $(uninstall_command) "$${dest}" ; \
	fi


#-- end of install_more_includes_header ------
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
