#-- start of make_header -----------------

#====================================
#  Document GaudiPython_python
#
#   Generated Mon Feb 16 20:23:14 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPython_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPython_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPython_python

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPython_python = $(GaudiPython_tag)_GaudiPython_python.make
cmt_local_tagfile_GaudiPython_python = $(bin)$(GaudiPython_tag)_GaudiPython_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPython_python = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPython_python = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPython_python)
#-include $(cmt_local_tagfile_GaudiPython_python)

ifdef cmt_GaudiPython_python_has_target_tag

cmt_final_setup_GaudiPython_python = $(bin)setup_GaudiPython_python.make
cmt_dependencies_in_GaudiPython_python = $(bin)dependencies_GaudiPython_python.in
#cmt_final_setup_GaudiPython_python = $(bin)GaudiPython_GaudiPython_pythonsetup.make
cmt_local_GaudiPython_python_makefile = $(bin)GaudiPython_python.make

else

cmt_final_setup_GaudiPython_python = $(bin)setup.make
cmt_dependencies_in_GaudiPython_python = $(bin)dependencies.in
#cmt_final_setup_GaudiPython_python = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPython_python_makefile = $(bin)GaudiPython_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPython_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPython_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPython_python/
#GaudiPython_python::
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

GaudiPython_python :: GaudiPython_pythoninstall

install :: GaudiPython_pythoninstall

GaudiPython_pythoninstall :: $(install_python_dir)
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

GaudiPython_pythonclean :: GaudiPython_pythonuninstall

uninstall :: GaudiPython_pythonuninstall

GaudiPython_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GaudiPython_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPython_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPython_pythonclean ::
#-- end of cleanup_header ---------------
