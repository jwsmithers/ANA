#-- start of make_header -----------------

#====================================
#  Document RootHistCnv_python_init
#
#   Generated Mon Feb 16 19:54:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnv_python_init_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnv_python_init_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnv_python_init

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnv_python_init = $(RootHistCnv_tag)_RootHistCnv_python_init.make
cmt_local_tagfile_RootHistCnv_python_init = $(bin)$(RootHistCnv_tag)_RootHistCnv_python_init.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnv_python_init = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnv_python_init = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnv_python_init)
#-include $(cmt_local_tagfile_RootHistCnv_python_init)

ifdef cmt_RootHistCnv_python_init_has_target_tag

cmt_final_setup_RootHistCnv_python_init = $(bin)setup_RootHistCnv_python_init.make
cmt_dependencies_in_RootHistCnv_python_init = $(bin)dependencies_RootHistCnv_python_init.in
#cmt_final_setup_RootHistCnv_python_init = $(bin)RootHistCnv_RootHistCnv_python_initsetup.make
cmt_local_RootHistCnv_python_init_makefile = $(bin)RootHistCnv_python_init.make

else

cmt_final_setup_RootHistCnv_python_init = $(bin)setup.make
cmt_dependencies_in_RootHistCnv_python_init = $(bin)dependencies.in
#cmt_final_setup_RootHistCnv_python_init = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnv_python_init_makefile = $(bin)RootHistCnv_python_init.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnv_python_init :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnv_python_init'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnv_python_init/
#RootHistCnv_python_init::
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
install_python_dir = $(installarea)/python/RootHistCnv
init_file = $(install_python_dir)/__init__.py


RootHistCnv_python_init :: RootHistCnv_python_initinstall

install :: RootHistCnv_python_initinstall

RootHistCnv_python_initinstall :: $(init_file)

$(init_file) ::
	@if [ -e $(install_python_dir) -a ! -e $(init_file) ]; then \
	  echo "Installing __init__.py file from ${GAUDIPOLICYROOT}" ; \
	  $(install_command) ${GAUDIPOLICYROOT}/cmt/fragments/__init__.py $(install_python_dir) ; \
	fi

RootHistCnv_python_initclean :: RootHistCnv_python_inituninstall

uninstall :: RootHistCnv_python_inituninstall

RootHistCnv_python_inituninstall ::
	@$(uninstall_command) $(init_file)


#-- end of python_init_header ------
#-- start of cleanup_header --------------

clean :: RootHistCnv_python_initclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnv_python_init.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnv_python_initclean ::
#-- end of cleanup_header ---------------
