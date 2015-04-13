#-- start of make_header -----------------

#====================================
#  Document GaudiPartPropConf
#
#   Generated Mon Feb 16 19:54:36 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPartPropConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPartPropConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPartPropConf

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropConf = $(GaudiPartProp_tag)_GaudiPartPropConf.make
cmt_local_tagfile_GaudiPartPropConf = $(bin)$(GaudiPartProp_tag)_GaudiPartPropConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropConf = $(GaudiPartProp_tag).make
cmt_local_tagfile_GaudiPartPropConf = $(bin)$(GaudiPartProp_tag).make

endif

include $(cmt_local_tagfile_GaudiPartPropConf)
#-include $(cmt_local_tagfile_GaudiPartPropConf)

ifdef cmt_GaudiPartPropConf_has_target_tag

cmt_final_setup_GaudiPartPropConf = $(bin)setup_GaudiPartPropConf.make
cmt_dependencies_in_GaudiPartPropConf = $(bin)dependencies_GaudiPartPropConf.in
#cmt_final_setup_GaudiPartPropConf = $(bin)GaudiPartProp_GaudiPartPropConfsetup.make
cmt_local_GaudiPartPropConf_makefile = $(bin)GaudiPartPropConf.make

else

cmt_final_setup_GaudiPartPropConf = $(bin)setup.make
cmt_dependencies_in_GaudiPartPropConf = $(bin)dependencies.in
#cmt_final_setup_GaudiPartPropConf = $(bin)GaudiPartPropsetup.make
cmt_local_GaudiPartPropConf_makefile = $(bin)GaudiPartPropConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPartPropsetup.make

#GaudiPartPropConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPartPropConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPartPropConf/
#GaudiPartPropConf::
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

.PHONY: GaudiPartPropConf GaudiPartPropConfclean

confpy  := GaudiPartPropConf.py
conflib := $(bin)$(library_prefix)GaudiPartProp.$(shlibsuffix)
confdb  := GaudiPartProp.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiPartPropConf :: GaudiPartPropConfinstall

install :: GaudiPartPropConfinstall

GaudiPartPropConfinstall : /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiPartProp.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp ; fi ;

GaudiPartPropConfclean :: GaudiPartPropConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp/$(confdb)

uninstall :: GaudiPartPropConfuninstall

GaudiPartPropConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiPartProp_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiPartProp.so
#-- start of cleanup_header --------------

clean :: GaudiPartPropConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPartPropConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPartPropConfclean ::
#-- end of cleanup_header ---------------
