#-- start of make_header -----------------

#====================================
#  Document GaudiCoreSvc_python_init
#
#   Generated Mon Feb 16 19:51:49 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvc_python_init_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvc_python_init_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvc_python_init

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvc_python_init = $(GaudiCoreSvc_tag)_GaudiCoreSvc_python_init.make
cmt_local_tagfile_GaudiCoreSvc_python_init = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvc_python_init.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvc_python_init = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvc_python_init = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvc_python_init)
#-include $(cmt_local_tagfile_GaudiCoreSvc_python_init)

ifdef cmt_GaudiCoreSvc_python_init_has_target_tag

cmt_final_setup_GaudiCoreSvc_python_init = $(bin)setup_GaudiCoreSvc_python_init.make
cmt_dependencies_in_GaudiCoreSvc_python_init = $(bin)dependencies_GaudiCoreSvc_python_init.in
#cmt_final_setup_GaudiCoreSvc_python_init = $(bin)GaudiCoreSvc_GaudiCoreSvc_python_initsetup.make
cmt_local_GaudiCoreSvc_python_init_makefile = $(bin)GaudiCoreSvc_python_init.make

else

cmt_final_setup_GaudiCoreSvc_python_init = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvc_python_init = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvc_python_init = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvc_python_init_makefile = $(bin)GaudiCoreSvc_python_init.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvc_python_init :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvc_python_init'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvc_python_init/
#GaudiCoreSvc_python_init::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of python_init_header ------

installarea = ${CMTINSTALLAREA}$(shared_install_subdir)
install_python_dir = $(installarea)/python/GaudiCoreSvc
init_file = $(install_python_dir)/__init__.py


GaudiCoreSvc_python_init :: GaudiCoreSvc_python_initinstall

install :: GaudiCoreSvc_python_initinstall

GaudiCoreSvc_python_initinstall :: $(init_file)

$(init_file) ::
	@if [ -e $(install_python_dir) -a ! -e $(init_file) ]; then \
	  echo "Installing __init__.py file from ${GAUDIPOLICYROOT}" ; \
	  $(install_command) ${GAUDIPOLICYROOT}/cmt/fragments/__init__.py $(install_python_dir) ; \
	fi

GaudiCoreSvc_python_initclean :: GaudiCoreSvc_python_inituninstall

uninstall :: GaudiCoreSvc_python_inituninstall

GaudiCoreSvc_python_inituninstall ::
	@$(uninstall_command) $(init_file)


#-- end of python_init_header ------
#-- start of cleanup_header --------------

clean :: GaudiCoreSvc_python_initclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvc_python_init.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvc_python_initclean ::
#-- end of cleanup_header ---------------
