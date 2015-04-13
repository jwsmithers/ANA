#-- start of make_header -----------------

#====================================
#  Document RootHistCnvConf
#
#   Generated Mon Feb 16 19:54:05 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnvConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnvConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnvConf

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvConf = $(RootHistCnv_tag)_RootHistCnvConf.make
cmt_local_tagfile_RootHistCnvConf = $(bin)$(RootHistCnv_tag)_RootHistCnvConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvConf = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnvConf = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnvConf)
#-include $(cmt_local_tagfile_RootHistCnvConf)

ifdef cmt_RootHistCnvConf_has_target_tag

cmt_final_setup_RootHistCnvConf = $(bin)setup_RootHistCnvConf.make
cmt_dependencies_in_RootHistCnvConf = $(bin)dependencies_RootHistCnvConf.in
#cmt_final_setup_RootHistCnvConf = $(bin)RootHistCnv_RootHistCnvConfsetup.make
cmt_local_RootHistCnvConf_makefile = $(bin)RootHistCnvConf.make

else

cmt_final_setup_RootHistCnvConf = $(bin)setup.make
cmt_dependencies_in_RootHistCnvConf = $(bin)dependencies.in
#cmt_final_setup_RootHistCnvConf = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnvConf_makefile = $(bin)RootHistCnvConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnvConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnvConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnvConf/
#RootHistCnvConf::
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

.PHONY: RootHistCnvConf RootHistCnvConfclean

confpy  := RootHistCnvConf.py
conflib := $(bin)$(library_prefix)RootHistCnv.$(shlibsuffix)
confdb  := RootHistCnv.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

RootHistCnvConf :: RootHistCnvConfinstall

install :: RootHistCnvConfinstall

RootHistCnvConfinstall : /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)RootHistCnv.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv ; fi ;

RootHistCnvConfclean :: RootHistCnvConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv/$(confpy) /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv/$(confdb)

uninstall :: RootHistCnvConfuninstall

RootHistCnvConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libRootHistCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootHistCnv.so
#-- start of cleanup_header --------------

clean :: RootHistCnvConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnvConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnvConfclean ::
#-- end of cleanup_header ---------------
