#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesConf
#
#   Generated Mon Feb 16 20:58:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesConf

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConf = $(GaudiExamples_tag)_GaudiExamplesConf.make
cmt_local_tagfile_GaudiExamplesConf = $(bin)$(GaudiExamples_tag)_GaudiExamplesConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConf = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesConf = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesConf)
#-include $(cmt_local_tagfile_GaudiExamplesConf)

ifdef cmt_GaudiExamplesConf_has_target_tag

cmt_final_setup_GaudiExamplesConf = $(bin)setup_GaudiExamplesConf.make
cmt_dependencies_in_GaudiExamplesConf = $(bin)dependencies_GaudiExamplesConf.in
#cmt_final_setup_GaudiExamplesConf = $(bin)GaudiExamples_GaudiExamplesConfsetup.make
cmt_local_GaudiExamplesConf_makefile = $(bin)GaudiExamplesConf.make

else

cmt_final_setup_GaudiExamplesConf = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesConf = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesConf = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesConf_makefile = $(bin)GaudiExamplesConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesConf/
#GaudiExamplesConf::
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

.PHONY: GaudiExamplesConf GaudiExamplesConfclean

confpy  := GaudiExamplesConf.py
conflib := $(bin)$(library_prefix)GaudiExamples.$(shlibsuffix)
confdb  := GaudiExamples.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiExamplesConf :: GaudiExamplesConfinstall

install :: GaudiExamplesConfinstall

GaudiExamplesConfinstall : /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiExamples.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples ; fi ;

GaudiExamplesConfclean :: GaudiExamplesConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/$(confdb)

uninstall :: GaudiExamplesConfuninstall

GaudiExamplesConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiExamples_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiExamples.so
#-- start of cleanup_header --------------

clean :: GaudiExamplesConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesConfclean ::
#-- end of cleanup_header ---------------
