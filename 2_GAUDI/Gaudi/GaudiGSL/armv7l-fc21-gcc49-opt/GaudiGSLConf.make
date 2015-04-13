#-- start of make_header -----------------

#====================================
#  Document GaudiGSLConf
#
#   Generated Mon Feb 16 20:18:42 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLConf

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLConf = $(GaudiGSL_tag)_GaudiGSLConf.make
cmt_local_tagfile_GaudiGSLConf = $(bin)$(GaudiGSL_tag)_GaudiGSLConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLConf = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLConf = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLConf)
#-include $(cmt_local_tagfile_GaudiGSLConf)

ifdef cmt_GaudiGSLConf_has_target_tag

cmt_final_setup_GaudiGSLConf = $(bin)setup_GaudiGSLConf.make
cmt_dependencies_in_GaudiGSLConf = $(bin)dependencies_GaudiGSLConf.in
#cmt_final_setup_GaudiGSLConf = $(bin)GaudiGSL_GaudiGSLConfsetup.make
cmt_local_GaudiGSLConf_makefile = $(bin)GaudiGSLConf.make

else

cmt_final_setup_GaudiGSLConf = $(bin)setup.make
cmt_dependencies_in_GaudiGSLConf = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLConf = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLConf_makefile = $(bin)GaudiGSLConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLConf/
#GaudiGSLConf::
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

.PHONY: GaudiGSLConf GaudiGSLConfclean

confpy  := GaudiGSLConf.py
conflib := $(bin)$(library_prefix)GaudiGSL.$(shlibsuffix)
confdb  := GaudiGSL.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiGSLConf :: GaudiGSLConfinstall

install :: GaudiGSLConfinstall

GaudiGSLConfinstall : /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiGSL.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL ; fi ;

GaudiGSLConfclean :: GaudiGSLConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL/$(confdb)

uninstall :: GaudiGSLConfuninstall

GaudiGSLConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiGSL_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiGSL.so
#-- start of cleanup_header --------------

clean :: GaudiGSLConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLConfclean ::
#-- end of cleanup_header ---------------
