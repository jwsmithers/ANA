#-- start of make_header -----------------

#====================================
#  Document GaudiCommonSvcConfDbMerge
#
#   Generated Mon Feb 16 20:23:12 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCommonSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCommonSvcConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCommonSvcConfDbMerge

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcConfDbMerge = $(GaudiCommonSvc_tag)_GaudiCommonSvcConfDbMerge.make
cmt_local_tagfile_GaudiCommonSvcConfDbMerge = $(bin)$(GaudiCommonSvc_tag)_GaudiCommonSvcConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcConfDbMerge = $(GaudiCommonSvc_tag).make
cmt_local_tagfile_GaudiCommonSvcConfDbMerge = $(bin)$(GaudiCommonSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCommonSvcConfDbMerge)
#-include $(cmt_local_tagfile_GaudiCommonSvcConfDbMerge)

ifdef cmt_GaudiCommonSvcConfDbMerge_has_target_tag

cmt_final_setup_GaudiCommonSvcConfDbMerge = $(bin)setup_GaudiCommonSvcConfDbMerge.make
cmt_dependencies_in_GaudiCommonSvcConfDbMerge = $(bin)dependencies_GaudiCommonSvcConfDbMerge.in
#cmt_final_setup_GaudiCommonSvcConfDbMerge = $(bin)GaudiCommonSvc_GaudiCommonSvcConfDbMergesetup.make
cmt_local_GaudiCommonSvcConfDbMerge_makefile = $(bin)GaudiCommonSvcConfDbMerge.make

else

cmt_final_setup_GaudiCommonSvcConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiCommonSvcConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiCommonSvcConfDbMerge = $(bin)GaudiCommonSvcsetup.make
cmt_local_GaudiCommonSvcConfDbMerge_makefile = $(bin)GaudiCommonSvcConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCommonSvcsetup.make

#GaudiCommonSvcConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCommonSvcConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCommonSvcConfDbMerge/
#GaudiCommonSvcConfDbMerge::
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

.PHONY: GaudiCommonSvcConfDbMerge GaudiCommonSvcConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiCommonSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCommonSvc/GaudiCommonSvc.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiCommonSvcConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiCommonSvcConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiCommonSvcConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiCommonSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiCommonSvc.so
#-- start of cleanup_header --------------

clean :: GaudiCommonSvcConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCommonSvcConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCommonSvcConfDbMergeclean ::
#-- end of cleanup_header ---------------
