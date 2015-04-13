#-- start of make_header -----------------

#====================================
#  Document RootCnvConf
#
#   Generated Mon Feb 16 20:01:19 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvConf_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvConf_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvConf

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvConf = $(RootCnv_tag)_RootCnvConf.make
cmt_local_tagfile_RootCnvConf = $(bin)$(RootCnv_tag)_RootCnvConf.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvConf = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvConf = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvConf)
#-include $(cmt_local_tagfile_RootCnvConf)

ifdef cmt_RootCnvConf_has_target_tag

cmt_final_setup_RootCnvConf = $(bin)setup_RootCnvConf.make
cmt_dependencies_in_RootCnvConf = $(bin)dependencies_RootCnvConf.in
#cmt_final_setup_RootCnvConf = $(bin)RootCnv_RootCnvConfsetup.make
cmt_local_RootCnvConf_makefile = $(bin)RootCnvConf.make

else

cmt_final_setup_RootCnvConf = $(bin)setup.make
cmt_dependencies_in_RootCnvConf = $(bin)dependencies.in
#cmt_final_setup_RootCnvConf = $(bin)RootCnvsetup.make
cmt_local_RootCnvConf_makefile = $(bin)RootCnvConf.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvConf :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvConf'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvConf/
#RootCnvConf::
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

.PHONY: RootCnvConf RootCnvConfclean

confpy  := RootCnvConf.py
conflib := $(bin)$(library_prefix)RootCnv.$(shlibsuffix)
confdb  := RootCnv.confdb
instdir := $(CMTINSTALLAREA)$(shared_install_subdir)/python/$(package)
product := $(instdir)/$(confpy)
initpy  := $(instdir)/__init__.py

ifdef GENCONF_ECHO
genconf_silent =
else
genconf_silent = $(silent)
endif

RootCnvConf :: RootCnvConfinstall

install :: RootCnvConfinstall

RootCnvConfinstall : /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv/$(confpy)
	@echo "Installing /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv in /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python" ; \
	 $(install_command) --exclude="*.py?" --exclude="__init__.py" --exclude="*.confdb" /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python ; \

/home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv/$(confpy) : $(conflib) /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv
	$(genconf_silent) $(genconfig_cmd)   -o /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv -p $(package) \
	  --configurable-module=GaudiKernel.Proxy \
	  --configurable-default-name=Configurable.DefaultName \
	  --configurable-algorithm=ConfigurableAlgorithm \
	  --configurable-algtool=ConfigurableAlgTool \
	  --configurable-auditor=ConfigurableAuditor \
          --configurable-service=ConfigurableService \
	  -i ../$(tag)/$(library_prefix)RootCnv.$(shlibsuffix)

/home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv:
	@ if [ ! -d /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv ] ; then mkdir -p /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv ; fi ;

RootCnvConfclean :: RootCnvConfuninstall
	$(cleanup_silent) $(remove_command) /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv/$(confpy) /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv/$(confdb)

uninstall :: RootCnvConfuninstall

RootCnvConfuninstall ::
	@$(uninstall_command) /home/jwsmith/HDD/Gaudi/InstallArea/armv7l-fc21-gcc49-opt/python
libRootCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootCnv.so
#-- start of cleanup_header --------------

clean :: RootCnvConfclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvConf.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvConfclean ::
#-- end of cleanup_header ---------------
