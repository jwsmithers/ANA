#-- start of make_header -----------------

#====================================
#  Document GaudiPluginService_python
#
#   Generated Mon Feb 16 19:31:10 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPluginService_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPluginService_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPluginService_python

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_GaudiPluginService_python = $(GaudiPluginService_tag)_GaudiPluginService_python.make
cmt_local_tagfile_GaudiPluginService_python = $(bin)$(GaudiPluginService_tag)_GaudiPluginService_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPluginService_tag = $(tag)

#cmt_local_tagfile_GaudiPluginService_python = $(GaudiPluginService_tag).make
cmt_local_tagfile_GaudiPluginService_python = $(bin)$(GaudiPluginService_tag).make

endif

include $(cmt_local_tagfile_GaudiPluginService_python)
#-include $(cmt_local_tagfile_GaudiPluginService_python)

ifdef cmt_GaudiPluginService_python_has_target_tag

cmt_final_setup_GaudiPluginService_python = $(bin)setup_GaudiPluginService_python.make
cmt_dependencies_in_GaudiPluginService_python = $(bin)dependencies_GaudiPluginService_python.in
#cmt_final_setup_GaudiPluginService_python = $(bin)GaudiPluginService_GaudiPluginService_pythonsetup.make
cmt_local_GaudiPluginService_python_makefile = $(bin)GaudiPluginService_python.make

else

cmt_final_setup_GaudiPluginService_python = $(bin)setup.make
cmt_dependencies_in_GaudiPluginService_python = $(bin)dependencies.in
#cmt_final_setup_GaudiPluginService_python = $(bin)GaudiPluginServicesetup.make
cmt_local_GaudiPluginService_python_makefile = $(bin)GaudiPluginService_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPluginServicesetup.make

#GaudiPluginService_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPluginService_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPluginService_python/
#GaudiPluginService_python::
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

GaudiPluginService_python :: GaudiPluginService_pythoninstall

install :: GaudiPluginService_pythoninstall

GaudiPluginService_pythoninstall :: $(install_python_dir)
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

GaudiPluginService_pythonclean :: GaudiPluginService_pythonuninstall

uninstall :: GaudiPluginService_pythonuninstall

GaudiPluginService_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: GaudiPluginService_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPluginService_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPluginService_pythonclean ::
#-- end of cleanup_header ---------------
