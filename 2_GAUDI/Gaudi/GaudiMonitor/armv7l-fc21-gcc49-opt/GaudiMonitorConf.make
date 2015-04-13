#-- start of make_header -----------------

#====================================
#  Document GaudiMonitorConf
#
#   Generated Mon Feb 16 19:53:00 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMonitorConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMonitorConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMonitorConf

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorConf = $(GaudiMonitor_tag)_GaudiMonitorConf.make
cmt_local_tagfile_GaudiMonitorConf = $(bin)$(GaudiMonitor_tag)_GaudiMonitorConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorConf = $(GaudiMonitor_tag).make
cmt_local_tagfile_GaudiMonitorConf = $(bin)$(GaudiMonitor_tag).make

endif

include $(cmt_local_tagfile_GaudiMonitorConf)
#-include $(cmt_local_tagfile_GaudiMonitorConf)

ifdef cmt_GaudiMonitorConf_has_target_tag

cmt_final_setup_GaudiMonitorConf = $(bin)setup_GaudiMonitorConf.make
cmt_dependencies_in_GaudiMonitorConf = $(bin)dependencies_GaudiMonitorConf.in
#cmt_final_setup_GaudiMonitorConf = $(bin)GaudiMonitor_GaudiMonitorConfsetup.make
cmt_local_GaudiMonitorConf_makefile = $(bin)GaudiMonitorConf.make

else

cmt_final_setup_GaudiMonitorConf = $(bin)setup.make
cmt_dependencies_in_GaudiMonitorConf = $(bin)dependencies.in
#cmt_final_setup_GaudiMonitorConf = $(bin)GaudiMonitorsetup.make
cmt_local_GaudiMonitorConf_makefile = $(bin)GaudiMonitorConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make

#GaudiMonitorConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMonitorConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMonitorConf/
#GaudiMonitorConf::
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

.PHONY: GaudiMonitorConf GaudiMonitorConfclean

confpy  := GaudiMonitorConf.py
conflib := $(bin)$(library_prefix)GaudiMonitor.$(shlibsuffix)
confdb  := GaudiMonitor.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiMonitorConf :: GaudiMonitorConfinstall

install :: GaudiMonitorConfinstall

GaudiMonitorConfinstall : /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiMonitor.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor ; fi ;

GaudiMonitorConfclean :: GaudiMonitorConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor/$(confdb)

uninstall :: GaudiMonitorConfuninstall

GaudiMonitorConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiMonitor_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiMonitor.so
#-- start of cleanup_header --------------

clean :: GaudiMonitorConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMonitorConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMonitorConfclean ::
#-- end of cleanup_header ---------------
