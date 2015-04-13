#-- start of make_header -----------------

#====================================
#  Document GaudiSvcConf
#
#   Generated Mon Feb 16 19:56:39 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcConf

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConf = $(GaudiSvc_tag)_GaudiSvcConf.make
cmt_local_tagfile_GaudiSvcConf = $(bin)$(GaudiSvc_tag)_GaudiSvcConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConf = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcConf = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcConf)
#-include $(cmt_local_tagfile_GaudiSvcConf)

ifdef cmt_GaudiSvcConf_has_target_tag

cmt_final_setup_GaudiSvcConf = $(bin)setup_GaudiSvcConf.make
cmt_dependencies_in_GaudiSvcConf = $(bin)dependencies_GaudiSvcConf.in
#cmt_final_setup_GaudiSvcConf = $(bin)GaudiSvc_GaudiSvcConfsetup.make
cmt_local_GaudiSvcConf_makefile = $(bin)GaudiSvcConf.make

else

cmt_final_setup_GaudiSvcConf = $(bin)setup.make
cmt_dependencies_in_GaudiSvcConf = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcConf = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcConf_makefile = $(bin)GaudiSvcConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcConf/
#GaudiSvcConf::
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

.PHONY: GaudiSvcConf GaudiSvcConfclean

confpy  := GaudiSvcConf.py
conflib := $(bin)$(library_prefix)GaudiSvc.$(shlibsuffix)
confdb  := GaudiSvc.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiSvcConf :: GaudiSvcConfinstall

install :: GaudiSvcConfinstall

GaudiSvcConfinstall : /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiSvc.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc ; fi ;

GaudiSvcConfclean :: GaudiSvcConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/$(confdb)

uninstall :: GaudiSvcConfuninstall

GaudiSvcConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiSvc.so
#-- start of cleanup_header --------------

clean :: GaudiSvcConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcConfclean ::
#-- end of cleanup_header ---------------
