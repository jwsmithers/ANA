#-- start of make_header -----------------

#====================================
#  Document GaudiPythonConf
#
#   Generated Mon Feb 16 20:24:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonConf

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonConf = $(GaudiPython_tag)_GaudiPythonConf.make
cmt_local_tagfile_GaudiPythonConf = $(bin)$(GaudiPython_tag)_GaudiPythonConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonConf = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonConf = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonConf)
#-include $(cmt_local_tagfile_GaudiPythonConf)

ifdef cmt_GaudiPythonConf_has_target_tag

cmt_final_setup_GaudiPythonConf = $(bin)setup_GaudiPythonConf.make
cmt_dependencies_in_GaudiPythonConf = $(bin)dependencies_GaudiPythonConf.in
#cmt_final_setup_GaudiPythonConf = $(bin)GaudiPython_GaudiPythonConfsetup.make
cmt_local_GaudiPythonConf_makefile = $(bin)GaudiPythonConf.make

else

cmt_final_setup_GaudiPythonConf = $(bin)setup.make
cmt_dependencies_in_GaudiPythonConf = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonConf = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonConf_makefile = $(bin)GaudiPythonConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonConf/
#GaudiPythonConf::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/genconfig_header
# Author: Wim Lavrijsen (WLavrijsen@lbl.gov)

# Use genconf.exe to create configurables python modules, then have the
# normal python install procedure take over.

.PHONY: GaudiPythonConf GaudiPythonConfclean

confpy  := GaudiPythonConf.py
conflib := $(bin)$(library_prefix)GaudiPython.$(shlibsuffix)
confdb  := GaudiPython.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiPythonConf :: GaudiPythonConfinstall

install :: GaudiPythonConfinstall

GaudiPythonConfinstall : /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiPython.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython ; fi ;

GaudiPythonConfclean :: GaudiPythonConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython/$(confdb)

uninstall :: GaudiPythonConfuninstall

GaudiPythonConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiPython_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiPython.so
#-- start of cleanup_header --------------

clean :: GaudiPythonConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonConfclean ::
#-- end of cleanup_header ---------------
