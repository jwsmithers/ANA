#-- start of make_header -----------------

#====================================
#  Document GaudiKernel_python
#
#   Generated Mon Feb 16 19:31:28 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiKernel_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiKernel_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiKernel_python

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernel_python = $(GaudiKernel_tag)_GaudiKernel_python.make
cmt_local_tagfile_GaudiKernel_python = $(bin)$(GaudiKernel_tag)_GaudiKernel_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernel_python = $(GaudiKernel_tag).make
cmt_local_tagfile_GaudiKernel_python = $(bin)$(GaudiKernel_tag).make

endif

include $(cmt_local_tagfile_GaudiKernel_python)
#-include $(cmt_local_tagfile_GaudiKernel_python)

ifdef cmt_GaudiKernel_python_has_target_tag

cmt_final_setup_GaudiKernel_python = $(bin)setup_GaudiKernel_python.make
cmt_dependencies_in_GaudiKernel_python = $(bin)dependencies_GaudiKernel_python.in
#cmt_final_setup_GaudiKernel_python = $(bin)GaudiKernel_GaudiKernel_pythonsetup.make
cmt_local_GaudiKernel_python_makefile = $(bin)GaudiKernel_python.make

else

cmt_final_setup_GaudiKernel_python = $(bin)setup.make
cmt_dependencies_in_GaudiKernel_python = $(bin)dependencies.in
#cmt_final_setup_GaudiKernel_python = $(bin)GaudiKernelsetup.make
cmt_local_GaudiKernel_python_makefile = $(bin)GaudiKernel_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make

#GaudiKernel_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiKernel_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiKernel_python/
#GaudiKernel_python::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of install_python_header ------


installarea = ${CMTINSTALLAREA}$(shared_install_subdir)
install_python_dir = $(installarea)

ifneq ($(strip "$(source)"),"")
src = ../$(source)
dest = $(install_python_dir)/python
else
src = ../python
dest = $(install_python_dir)
endif

ifneq ($(strip "$(offset)"),"")
dest = $(install_python_dir)/python
endif

GaudiKernel_python :: GaudiKernel_pythoninstall

install :: GaudiKernel_pythoninstall

GaudiKernel_pythoninstall :: $(install_python_dir)
	@if [ ! "$(installarea)" = "" ] ; then\
	  echo "installation done"; \
	fi

$(install_python_dir) ::
	@if [ "$(installarea)" = "" ] ; then \
	  echo "Cannot install header files, no installation source specified"; \
	else \
	  if [ -d $(src) ] ; then \
	    echo "Installing files from $(src) to $(dest)" ; \
	    if [ "$(offset)" = "" ] ; then \
	      $(install_command) --exclude="*.py?" $(src) $(dest) ; \
	    else \
	      $(install_command) --exclude="*.py?" $(src) $(dest) --destname $(offset); \
	    fi ; \
	  else \
	    echo "no source  $(src)"; \
	  fi; \
	fi

GaudiKernel_pythonclean :: GaudiKernel_pythonuninstall

uninstall :: GaudiKernel_pythonuninstall

GaudiKernel_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GaudiKernel_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiKernel_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiKernel_pythonclean ::
#-- end of cleanup_header ---------------
