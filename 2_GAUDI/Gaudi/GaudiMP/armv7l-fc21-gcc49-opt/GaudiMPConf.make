#-- start of make_header -----------------

#====================================
#  Document GaudiMPConf
#
#   Generated Mon Feb 16 20:49:52 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPConf

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConf = $(GaudiMP_tag)_GaudiMPConf.make
cmt_local_tagfile_GaudiMPConf = $(bin)$(GaudiMP_tag)_GaudiMPConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConf = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPConf = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPConf)
#-include $(cmt_local_tagfile_GaudiMPConf)

ifdef cmt_GaudiMPConf_has_target_tag

cmt_final_setup_GaudiMPConf = $(bin)setup_GaudiMPConf.make
cmt_dependencies_in_GaudiMPConf = $(bin)dependencies_GaudiMPConf.in
#cmt_final_setup_GaudiMPConf = $(bin)GaudiMP_GaudiMPConfsetup.make
cmt_local_GaudiMPConf_makefile = $(bin)GaudiMPConf.make

else

cmt_final_setup_GaudiMPConf = $(bin)setup.make
cmt_dependencies_in_GaudiMPConf = $(bin)dependencies.in
#cmt_final_setup_GaudiMPConf = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPConf_makefile = $(bin)GaudiMPConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPConf/
#GaudiMPConf::
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

.PHONY: GaudiMPConf GaudiMPConfclean

confpy  := GaudiMPConf.py
conflib := $(bin)$(library_prefix)GaudiMP.$(shlibsuffix)
confdb  := GaudiMP.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiMPConf :: GaudiMPConfinstall

install :: GaudiMPConfinstall

GaudiMPConfinstall : /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiMP.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP ; fi ;

GaudiMPConfclean :: GaudiMPConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/$(confdb)

uninstall :: GaudiMPConfuninstall

GaudiMPConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiMP_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiMP.so
#-- start of cleanup_header --------------

clean :: GaudiMPConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPConfclean ::
#-- end of cleanup_header ---------------
