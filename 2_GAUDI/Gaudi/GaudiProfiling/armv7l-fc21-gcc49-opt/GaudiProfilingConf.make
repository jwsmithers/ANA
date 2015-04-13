#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingConf
#
#   Generated Mon Feb 16 20:16:26 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingConf

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConf = $(GaudiProfiling_tag)_GaudiProfilingConf.make
cmt_local_tagfile_GaudiProfilingConf = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConf = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingConf = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingConf)
#-include $(cmt_local_tagfile_GaudiProfilingConf)

ifdef cmt_GaudiProfilingConf_has_target_tag

cmt_final_setup_GaudiProfilingConf = $(bin)setup_GaudiProfilingConf.make
cmt_dependencies_in_GaudiProfilingConf = $(bin)dependencies_GaudiProfilingConf.in
#cmt_final_setup_GaudiProfilingConf = $(bin)GaudiProfiling_GaudiProfilingConfsetup.make
cmt_local_GaudiProfilingConf_makefile = $(bin)GaudiProfilingConf.make

else

cmt_final_setup_GaudiProfilingConf = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingConf = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingConf = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingConf_makefile = $(bin)GaudiProfilingConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingConf/
#GaudiProfilingConf::
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

.PHONY: GaudiProfilingConf GaudiProfilingConfclean

confpy  := GaudiProfilingConf.py
conflib := $(bin)$(library_prefix)GaudiProfiling.$(shlibsuffix)
confdb  := GaudiProfiling.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

GaudiProfilingConf :: GaudiProfilingConfinstall

install :: GaudiProfilingConfinstall

GaudiProfilingConfinstall : /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)GaudiProfiling.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling ; fi ;

GaudiProfilingConfclean :: GaudiProfilingConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/$(confpy) /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/$(confdb)

uninstall :: GaudiProfilingConfuninstall

GaudiProfilingConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libGaudiProfiling_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiProfiling.so
#-- start of cleanup_header --------------

clean :: GaudiProfilingConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingConfclean ::
#-- end of cleanup_header ---------------
