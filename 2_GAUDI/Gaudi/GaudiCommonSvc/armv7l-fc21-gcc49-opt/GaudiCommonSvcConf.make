#-- start of make_header -----------------

#====================================
#  Document GaudiCommonSvcConf
#
#   Generated Mon Feb 16 20:23:11 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCommonSvcConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCommonSvcConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCommonSvcConf

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcConf = $(GaudiCommonSvc_tag)_GaudiCommonSvcConf.make
cmt_local_tagfile_GaudiCommonSvcConf = $(bin)$(GaudiCommonSvc_tag)_GaudiCommonSvcConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcConf = $(GaudiCommonSvc_tag).make
cmt_local_tagfile_GaudiCommonSvcConf = $(bin)$(GaudiCommonSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCommonSvcConf)
#-include $(cmt_local_tagfile_GaudiCommonSvcConf)

ifdef cmt_GaudiCommonSvcConf_has_target_tag

cmt_final_setup_GaudiCommonSvcConf = $(bin)setup_GaudiCommonSvcConf.make
cmt_dependencies_in_GaudiCommonSvcConf = $(bin)dependencies_GaudiCommonSvcConf.in
#cmt_final_setup_GaudiCommonSvcConf = $(bin)GaudiCommonSvc_GaudiCommonSvcConfsetup.make
cmt_local_GaudiCommonSvcConf_makefile = $(bin)GaudiCommonSvcConf.make

else

cmt_final_setup_GaudiCommonSvcConf = $(bin)setup.make
cmt_dependencies_in_GaudiCommonSvcConf = $(bin)dependencies.in
#cmt_final_setup_GaudiCommonSvcConf = $(bin)GaudiCommonSvcsetup.make
cmt_local_GaudiCommonSvcConf_makefile = $(bin)GaudiCommonSvcConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCommonSvcsetup.make

#GaudiCommonSvcConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCommonSvcConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCommonSvcConf/
#GaudiCommonSvcConf::
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

.PHONY: GaudiCommonSvcConf GaudiCommonSvcConfclean

confpy  := GaudiCommonSvcConf.py
conflib := $(bin)$(library_prefix)GaudiCommonSvc.$(shlibsuffix)
confdb  := GaudiCommonSvc.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiCommonSvcConf :: GaudiCommonSvcConfinstall

install :: GaudiCommonSvcConfinstall

GaudiCommonSvcConfinstall : /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiCommonSvc.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc ; fi ;

GaudiCommonSvcConfclean :: GaudiCommonSvcConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc/$(confdb)

uninstall :: GaudiCommonSvcConfuninstall

GaudiCommonSvcConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiCommonSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiCommonSvc.so
#-- start of cleanup_header --------------

clean :: GaudiCommonSvcConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCommonSvcConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCommonSvcConfclean ::
#-- end of cleanup_header ---------------
