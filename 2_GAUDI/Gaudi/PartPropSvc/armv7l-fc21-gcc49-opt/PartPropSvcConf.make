#-- start of make_header -----------------

#====================================
#  Document PartPropSvcConf
#
#   Generated Mon Feb 16 19:52:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PartPropSvcConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PartPropSvcConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PartPropSvcConf

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcConf = $(PartPropSvc_tag)_PartPropSvcConf.make
cmt_local_tagfile_PartPropSvcConf = $(bin)$(PartPropSvc_tag)_PartPropSvcConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcConf = $(PartPropSvc_tag).make
cmt_local_tagfile_PartPropSvcConf = $(bin)$(PartPropSvc_tag).make

endif

include $(cmt_local_tagfile_PartPropSvcConf)
#-include $(cmt_local_tagfile_PartPropSvcConf)

ifdef cmt_PartPropSvcConf_has_target_tag

cmt_final_setup_PartPropSvcConf = $(bin)setup_PartPropSvcConf.make
cmt_dependencies_in_PartPropSvcConf = $(bin)dependencies_PartPropSvcConf.in
#cmt_final_setup_PartPropSvcConf = $(bin)PartPropSvc_PartPropSvcConfsetup.make
cmt_local_PartPropSvcConf_makefile = $(bin)PartPropSvcConf.make

else

cmt_final_setup_PartPropSvcConf = $(bin)setup.make
cmt_dependencies_in_PartPropSvcConf = $(bin)dependencies.in
#cmt_final_setup_PartPropSvcConf = $(bin)PartPropSvcsetup.make
cmt_local_PartPropSvcConf_makefile = $(bin)PartPropSvcConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make

#PartPropSvcConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PartPropSvcConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PartPropSvcConf/
#PartPropSvcConf::
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

.PHONY: PartPropSvcConf PartPropSvcConfclean

confpy  := PartPropSvcConf.py
conflib := $(bin)$(library_prefix)PartPropSvc.$(shlibsuffix)
confdb  := PartPropSvc.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

PartPropSvcConf :: PartPropSvcConfinstall

install :: PartPropSvcConfinstall

PartPropSvcConfinstall : /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)PartPropSvc.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc ; fi ;

PartPropSvcConfclean :: PartPropSvcConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc/$(confpy) /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc/$(confdb)

uninstall :: PartPropSvcConfuninstall

PartPropSvcConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libPartPropSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libPartPropSvc.so
#-- start of cleanup_header --------------

clean :: PartPropSvcConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PartPropSvcConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PartPropSvcConfclean ::
#-- end of cleanup_header ---------------
