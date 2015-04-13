#-- start of make_header -----------------

#====================================
#  Document GaudiMonitorConfDbMerge
#
#   Generated Mon Feb 16 19:53:00 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMonitorConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMonitorConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMonitorConfDbMerge

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorConfDbMerge = $(GaudiMonitor_tag)_GaudiMonitorConfDbMerge.make
cmt_local_tagfile_GaudiMonitorConfDbMerge = $(bin)$(GaudiMonitor_tag)_GaudiMonitorConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorConfDbMerge = $(GaudiMonitor_tag).make
cmt_local_tagfile_GaudiMonitorConfDbMerge = $(bin)$(GaudiMonitor_tag).make

endif

include $(cmt_local_tagfile_GaudiMonitorConfDbMerge)
#-include $(cmt_local_tagfile_GaudiMonitorConfDbMerge)

ifdef cmt_GaudiMonitorConfDbMerge_has_target_tag

cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)setup_GaudiMonitorConfDbMerge.make
cmt_dependencies_in_GaudiMonitorConfDbMerge = $(bin)dependencies_GaudiMonitorConfDbMerge.in
#cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)GaudiMonitor_GaudiMonitorConfDbMergesetup.make
cmt_local_GaudiMonitorConfDbMerge_makefile = $(bin)GaudiMonitorConfDbMerge.make

else

cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiMonitorConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiMonitorConfDbMerge = $(bin)GaudiMonitorsetup.make
cmt_local_GaudiMonitorConfDbMerge_makefile = $(bin)GaudiMonitorConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make

#GaudiMonitorConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMonitorConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMonitorConfDbMerge/
#GaudiMonitorConfDbMerge::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/merge_genconfDb_header
# Author: Sebastien Binet (binet@cern.ch)

# Makefile fragment to merge a <library>.confdb file into a single
# <project>.confdb file in the (lib) install area

.PHONY: GaudiMonitorConfDbMerge GaudiMonitorConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiMonitor/armv7l-fc21-gcc49-opt/genConf/GaudiMonitor/GaudiMonitor.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiMonitorConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiMonitorConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiMonitorConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiMonitor_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiMonitor.so
#-- start of cleanup_header --------------

clean :: GaudiMonitorConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMonitorConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMonitorConfDbMergeclean ::
#-- end of cleanup_header ---------------
