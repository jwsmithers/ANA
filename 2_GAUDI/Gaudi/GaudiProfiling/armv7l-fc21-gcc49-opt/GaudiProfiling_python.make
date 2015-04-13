#-- start of make_header -----------------

#====================================
#  Document GaudiProfiling_python
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

cmt_GaudiProfiling_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfiling_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfiling_python

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfiling_python = $(GaudiProfiling_tag)_GaudiProfiling_python.make
cmt_local_tagfile_GaudiProfiling_python = $(bin)$(GaudiProfiling_tag)_GaudiProfiling_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfiling_python = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfiling_python = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfiling_python)
#-include $(cmt_local_tagfile_GaudiProfiling_python)

ifdef cmt_GaudiProfiling_python_has_target_tag

cmt_final_setup_GaudiProfiling_python = $(bin)setup_GaudiProfiling_python.make
cmt_dependencies_in_GaudiProfiling_python = $(bin)dependencies_GaudiProfiling_python.in
#cmt_final_setup_GaudiProfiling_python = $(bin)GaudiProfiling_GaudiProfiling_pythonsetup.make
cmt_local_GaudiProfiling_python_makefile = $(bin)GaudiProfiling_python.make

else

cmt_final_setup_GaudiProfiling_python = $(bin)setup.make
cmt_dependencies_in_GaudiProfiling_python = $(bin)dependencies.in
#cmt_final_setup_GaudiProfiling_python = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfiling_python_makefile = $(bin)GaudiProfiling_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfiling_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfiling_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfiling_python/
#GaudiProfiling_python::
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

GaudiProfiling_python :: GaudiProfiling_pythoninstall

install :: GaudiProfiling_pythoninstall

GaudiProfiling_pythoninstall :: $(install_python_dir)
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

GaudiProfiling_pythonclean :: GaudiProfiling_pythonuninstall

uninstall :: GaudiProfiling_pythonuninstall

GaudiProfiling_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GaudiProfiling_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfiling_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfiling_pythonclean ::
#-- end of cleanup_header ---------------
