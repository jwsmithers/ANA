#-- start of make_header -----------------

#====================================
#  Document GaudiUtilsConf
#
#   Generated Mon Feb 16 20:00:05 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtilsConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtilsConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtilsConf

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsConf = $(GaudiUtils_tag)_GaudiUtilsConf.make
cmt_local_tagfile_GaudiUtilsConf = $(bin)$(GaudiUtils_tag)_GaudiUtilsConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsConf = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtilsConf = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtilsConf)
#-include $(cmt_local_tagfile_GaudiUtilsConf)

ifdef cmt_GaudiUtilsConf_has_target_tag

cmt_final_setup_GaudiUtilsConf = $(bin)setup_GaudiUtilsConf.make
cmt_dependencies_in_GaudiUtilsConf = $(bin)dependencies_GaudiUtilsConf.in
#cmt_final_setup_GaudiUtilsConf = $(bin)GaudiUtils_GaudiUtilsConfsetup.make
cmt_local_GaudiUtilsConf_makefile = $(bin)GaudiUtilsConf.make

else

cmt_final_setup_GaudiUtilsConf = $(bin)setup.make
cmt_dependencies_in_GaudiUtilsConf = $(bin)dependencies.in
#cmt_final_setup_GaudiUtilsConf = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtilsConf_makefile = $(bin)GaudiUtilsConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtilsConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtilsConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtilsConf/
#GaudiUtilsConf::
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

.PHONY: GaudiUtilsConf GaudiUtilsConfclean

confpy  := GaudiUtilsConf.py
conflib := $(bin)$(library_prefix)GaudiUtils.$(shlibsuffix)
confdb  := GaudiUtils.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiUtilsConf :: GaudiUtilsConfinstall

install :: GaudiUtilsConfinstall

GaudiUtilsConfinstall : /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiUtils.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils ; fi ;

GaudiUtilsConfclean :: GaudiUtilsConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils/$(confdb)

uninstall :: GaudiUtilsConfuninstall

GaudiUtilsConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiUtils_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiUtils.so
#-- start of cleanup_header --------------

clean :: GaudiUtilsConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtilsConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsConfclean ::
#-- end of cleanup_header ---------------
