#-- start of make_header -----------------

#====================================
#  Document GaudiSvc_python
#
#   Generated Mon Feb 16 19:54:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvc_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvc_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvc_python

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvc_python = $(GaudiSvc_tag)_GaudiSvc_python.make
cmt_local_tagfile_GaudiSvc_python = $(bin)$(GaudiSvc_tag)_GaudiSvc_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvc_python = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvc_python = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvc_python)
#-include $(cmt_local_tagfile_GaudiSvc_python)

ifdef cmt_GaudiSvc_python_has_target_tag

cmt_final_setup_GaudiSvc_python = $(bin)setup_GaudiSvc_python.make
cmt_dependencies_in_GaudiSvc_python = $(bin)dependencies_GaudiSvc_python.in
#cmt_final_setup_GaudiSvc_python = $(bin)GaudiSvc_GaudiSvc_pythonsetup.make
cmt_local_GaudiSvc_python_makefile = $(bin)GaudiSvc_python.make

else

cmt_final_setup_GaudiSvc_python = $(bin)setup.make
cmt_dependencies_in_GaudiSvc_python = $(bin)dependencies.in
#cmt_final_setup_GaudiSvc_python = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvc_python_makefile = $(bin)GaudiSvc_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvc_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvc_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvc_python/
#GaudiSvc_python::
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

GaudiSvc_python :: GaudiSvc_pythoninstall

install :: GaudiSvc_pythoninstall

GaudiSvc_pythoninstall :: $(install_python_dir)
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

GaudiSvc_pythonclean :: GaudiSvc_pythonuninstall

uninstall :: GaudiSvc_pythonuninstall

GaudiSvc_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GaudiSvc_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvc_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvc_pythonclean ::
#-- end of cleanup_header ---------------
