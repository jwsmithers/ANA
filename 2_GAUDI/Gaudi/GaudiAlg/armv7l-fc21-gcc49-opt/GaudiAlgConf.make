#-- start of make_header -----------------

#====================================
#  Document GaudiAlgConf
#
#   Generated Mon Feb 16 20:05:06 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlgConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlgConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlgConf

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgConf = $(GaudiAlg_tag)_GaudiAlgConf.make
cmt_local_tagfile_GaudiAlgConf = $(bin)$(GaudiAlg_tag)_GaudiAlgConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgConf = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlgConf = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlgConf)
#-include $(cmt_local_tagfile_GaudiAlgConf)

ifdef cmt_GaudiAlgConf_has_target_tag

cmt_final_setup_GaudiAlgConf = $(bin)setup_GaudiAlgConf.make
cmt_dependencies_in_GaudiAlgConf = $(bin)dependencies_GaudiAlgConf.in
#cmt_final_setup_GaudiAlgConf = $(bin)GaudiAlg_GaudiAlgConfsetup.make
cmt_local_GaudiAlgConf_makefile = $(bin)GaudiAlgConf.make

else

cmt_final_setup_GaudiAlgConf = $(bin)setup.make
cmt_dependencies_in_GaudiAlgConf = $(bin)dependencies.in
#cmt_final_setup_GaudiAlgConf = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlgConf_makefile = $(bin)GaudiAlgConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlgConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlgConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlgConf/
#GaudiAlgConf::
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

.PHONY: GaudiAlgConf GaudiAlgConfclean

confpy  := GaudiAlgConf.py
conflib := $(bin)$(library_prefix)GaudiAlg.$(shlibsuffix)
confdb  := GaudiAlg.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiAlgConf :: GaudiAlgConfinstall

install :: GaudiAlgConfinstall

GaudiAlgConfinstall : /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiAlg.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg ; fi ;

GaudiAlgConfclean :: GaudiAlgConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg/$(confdb)

uninstall :: GaudiAlgConfuninstall

GaudiAlgConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiAlg_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAlg.so
#-- start of cleanup_header --------------

clean :: GaudiAlgConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlgConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgConfclean ::
#-- end of cleanup_header ---------------
