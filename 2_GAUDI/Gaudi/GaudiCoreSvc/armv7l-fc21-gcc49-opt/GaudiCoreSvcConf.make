#-- start of make_header -----------------

#====================================
#  Document GaudiCoreSvcConf
#
#   Generated Mon Feb 16 19:51:47 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvcConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvcConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvcConf

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcConf = $(GaudiCoreSvc_tag)_GaudiCoreSvcConf.make
cmt_local_tagfile_GaudiCoreSvcConf = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcConf = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvcConf = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvcConf)
#-include $(cmt_local_tagfile_GaudiCoreSvcConf)

ifdef cmt_GaudiCoreSvcConf_has_target_tag

cmt_final_setup_GaudiCoreSvcConf = $(bin)setup_GaudiCoreSvcConf.make
cmt_dependencies_in_GaudiCoreSvcConf = $(bin)dependencies_GaudiCoreSvcConf.in
#cmt_final_setup_GaudiCoreSvcConf = $(bin)GaudiCoreSvc_GaudiCoreSvcConfsetup.make
cmt_local_GaudiCoreSvcConf_makefile = $(bin)GaudiCoreSvcConf.make

else

cmt_final_setup_GaudiCoreSvcConf = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvcConf = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvcConf = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvcConf_makefile = $(bin)GaudiCoreSvcConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvcConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvcConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvcConf/
#GaudiCoreSvcConf::
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

.PHONY: GaudiCoreSvcConf GaudiCoreSvcConfclean

confpy  := GaudiCoreSvcConf.py
conflib := $(bin)$(library_prefix)GaudiCoreSvc.$(shlibsuffix)
confdb  := GaudiCoreSvc.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiCoreSvcConf :: GaudiCoreSvcConfinstall

install :: GaudiCoreSvcConfinstall

GaudiCoreSvcConfinstall : /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiCoreSvc.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc ; fi ;

GaudiCoreSvcConfclean :: GaudiCoreSvcConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc/$(confdb)

uninstall :: GaudiCoreSvcConfuninstall

GaudiCoreSvcConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiCoreSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiCoreSvc.so
#-- start of cleanup_header --------------

clean :: GaudiCoreSvcConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvcConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvcConfclean ::
#-- end of cleanup_header ---------------
