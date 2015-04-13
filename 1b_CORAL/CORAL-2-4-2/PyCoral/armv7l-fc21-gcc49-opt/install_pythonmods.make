#-- start of make_header -----------------

#====================================
#  Document install_pythonmods
#
#   Generated Tue Mar 31 10:25:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_install_pythonmods_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_install_pythonmods_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_install_pythonmods

PyCoral_tag = $(tag)

#cmt_local_tagfile_install_pythonmods = $(PyCoral_tag)_install_pythonmods.make
cmt_local_tagfile_install_pythonmods = $(bin)$(PyCoral_tag)_install_pythonmods.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCoral_tag = $(tag)

#cmt_local_tagfile_install_pythonmods = $(PyCoral_tag).make
cmt_local_tagfile_install_pythonmods = $(bin)$(PyCoral_tag).make

endif

include $(cmt_local_tagfile_install_pythonmods)
#-include $(cmt_local_tagfile_install_pythonmods)

ifdef cmt_install_pythonmods_has_target_tag

cmt_final_setup_install_pythonmods = $(bin)setup_install_pythonmods.make
cmt_dependencies_in_install_pythonmods = $(bin)dependencies_install_pythonmods.in
#cmt_final_setup_install_pythonmods = $(bin)PyCoral_install_pythonmodssetup.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

else

cmt_final_setup_install_pythonmods = $(bin)setup.make
cmt_dependencies_in_install_pythonmods = $(bin)dependencies.in
#cmt_final_setup_install_pythonmods = $(bin)PyCoralsetup.make
cmt_local_install_pythonmods_makefile = $(bin)install_pythonmods.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoralsetup.make

#install_pythonmods :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'install_pythonmods'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = install_pythonmods/
#install_pythonmods::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of install_includes_header ------

#
#  We want to install all header files that follow the standard convention
#
#    ../<package>
#
#  This document generator needs no parameterization, since it simply expects
#  the standard convention.
#

installarea = ${CMTINSTALLAREA}
install_python_dir = $(installarea)/$(tag)/python

install_pythonmods :: install_pythonmodsinstall

install :: install_pythonmodsinstall

install_pythonmodsinstall :: $(install_python_dir)
	@if test ! "$(installarea)" = ""; then\
	  echo "installation done"; \
	fi

$(install_python_dir) ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot install header files, no installation directory specified"; \
	else \
	  if test -d ../python; then \
	    echo "Installing files from standard ../python to $(install_python_dir)"; \
	    if test ! -d $(install_python_dir) ; then mkdir -p $(install_python_dir); fi; \
	    if test ! -L $(install_python_dir); then \
	      (cd ../python; \
	       here=`pwd`; \
               eval cp -rf $${here}/. $(install_python_dir)); \
            fi; \
	  else \
	    echo "No standard python area"; \
	  fi; \
	fi




#-- start of cleanup_header --------------

clean :: install_pythonmodsclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(install_pythonmods.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

install_pythonmodsclean ::
#-- end of cleanup_header ---------------
