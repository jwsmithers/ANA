#-- start of make_header -----------------

#====================================
#  Document Gaudi_python
#
#   Generated Mon Feb 16 20:49:56 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_Gaudi_python_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_Gaudi_python_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_Gaudi_python

Gaudi_tag = $(tag)

#cmt_local_tagfile_Gaudi_python = $(Gaudi_tag)_Gaudi_python.make
cmt_local_tagfile_Gaudi_python = $(bin)$(Gaudi_tag)_Gaudi_python.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Gaudi_tag = $(tag)

#cmt_local_tagfile_Gaudi_python = $(Gaudi_tag).make
cmt_local_tagfile_Gaudi_python = $(bin)$(Gaudi_tag).make

endif

include $(cmt_local_tagfile_Gaudi_python)
#-include $(cmt_local_tagfile_Gaudi_python)

ifdef cmt_Gaudi_python_has_target_tag

cmt_final_setup_Gaudi_python = $(bin)setup_Gaudi_python.make
cmt_dependencies_in_Gaudi_python = $(bin)dependencies_Gaudi_python.in
#cmt_final_setup_Gaudi_python = $(bin)Gaudi_Gaudi_pythonsetup.make
cmt_local_Gaudi_python_makefile = $(bin)Gaudi_python.make

else

cmt_final_setup_Gaudi_python = $(bin)setup.make
cmt_dependencies_in_Gaudi_python = $(bin)dependencies.in
#cmt_final_setup_Gaudi_python = $(bin)Gaudisetup.make
cmt_local_Gaudi_python_makefile = $(bin)Gaudi_python.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Gaudisetup.make

#Gaudi_python :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'Gaudi_python'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = Gaudi_python/
#Gaudi_python::
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

Gaudi_python :: Gaudi_pythoninstall

install :: Gaudi_pythoninstall

Gaudi_pythoninstall :: $(install_python_dir)
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

Gaudi_pythonclean :: Gaudi_pythonuninstall

uninstall :: Gaudi_pythonuninstall

Gaudi_pythonuninstall ::
	@if test "$(installarea)" = ""; then \
	  echo "Cannot uninstall header files, no installation source specified"; \
	else \
	  echo "Uninstalling files from $(dest)"; \
	  $(uninstall_command) "$(dest)" ; \
	fi


#-- end of install_python_header ------
#-- start of cleanup_header --------------

clean :: Gaudi_pythonclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(Gaudi_python.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

Gaudi_pythonclean ::
#-- end of cleanup_header ---------------
