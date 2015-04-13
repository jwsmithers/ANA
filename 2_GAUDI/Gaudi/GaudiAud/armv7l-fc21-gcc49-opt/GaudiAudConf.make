#-- start of make_header -----------------

#====================================
#  Document GaudiAudConf
#
#   Generated Mon Feb 16 20:19:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAudConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAudConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAudConf

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudConf = $(GaudiAud_tag)_GaudiAudConf.make
cmt_local_tagfile_GaudiAudConf = $(bin)$(GaudiAud_tag)_GaudiAudConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudConf = $(GaudiAud_tag).make
cmt_local_tagfile_GaudiAudConf = $(bin)$(GaudiAud_tag).make

endif

include $(cmt_local_tagfile_GaudiAudConf)
#-include $(cmt_local_tagfile_GaudiAudConf)

ifdef cmt_GaudiAudConf_has_target_tag

cmt_final_setup_GaudiAudConf = $(bin)setup_GaudiAudConf.make
cmt_dependencies_in_GaudiAudConf = $(bin)dependencies_GaudiAudConf.in
#cmt_final_setup_GaudiAudConf = $(bin)GaudiAud_GaudiAudConfsetup.make
cmt_local_GaudiAudConf_makefile = $(bin)GaudiAudConf.make

else

cmt_final_setup_GaudiAudConf = $(bin)setup.make
cmt_dependencies_in_GaudiAudConf = $(bin)dependencies.in
#cmt_final_setup_GaudiAudConf = $(bin)GaudiAudsetup.make
cmt_local_GaudiAudConf_makefile = $(bin)GaudiAudConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAudsetup.make

#GaudiAudConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAudConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAudConf/
#GaudiAudConf::
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

.PHONY: GaudiAudConf GaudiAudConfclean

confpy  := GaudiAudConf.py
conflib := $(bin)$(library_prefix)GaudiAud.$(shlibsuffix)
confdb  := GaudiAud.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiAudConf :: GaudiAudConfinstall

install :: GaudiAudConfinstall

GaudiAudConfinstall : /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiAud.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud ; fi ;

GaudiAudConfclean :: GaudiAudConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud/$(confdb)

uninstall :: GaudiAudConfuninstall

GaudiAudConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiAud_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAud.so
#-- start of cleanup_header --------------

clean :: GaudiAudConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAudConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAudConfclean ::
#-- end of cleanup_header ---------------
