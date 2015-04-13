#-- start of make_header -----------------

#====================================
#  Document PartPropSvcConfDbMerge
#
#   Generated Mon Feb 16 19:52:22 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PartPropSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PartPropSvcConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PartPropSvcConfDbMerge

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcConfDbMerge = $(PartPropSvc_tag)_PartPropSvcConfDbMerge.make
cmt_local_tagfile_PartPropSvcConfDbMerge = $(bin)$(PartPropSvc_tag)_PartPropSvcConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcConfDbMerge = $(PartPropSvc_tag).make
cmt_local_tagfile_PartPropSvcConfDbMerge = $(bin)$(PartPropSvc_tag).make

endif

include $(cmt_local_tagfile_PartPropSvcConfDbMerge)
#-include $(cmt_local_tagfile_PartPropSvcConfDbMerge)

ifdef cmt_PartPropSvcConfDbMerge_has_target_tag

cmt_final_setup_PartPropSvcConfDbMerge = $(bin)setup_PartPropSvcConfDbMerge.make
cmt_dependencies_in_PartPropSvcConfDbMerge = $(bin)dependencies_PartPropSvcConfDbMerge.in
#cmt_final_setup_PartPropSvcConfDbMerge = $(bin)PartPropSvc_PartPropSvcConfDbMergesetup.make
cmt_local_PartPropSvcConfDbMerge_makefile = $(bin)PartPropSvcConfDbMerge.make

else

cmt_final_setup_PartPropSvcConfDbMerge = $(bin)setup.make
cmt_dependencies_in_PartPropSvcConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_PartPropSvcConfDbMerge = $(bin)PartPropSvcsetup.make
cmt_local_PartPropSvcConfDbMerge_makefile = $(bin)PartPropSvcConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make

#PartPropSvcConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PartPropSvcConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PartPropSvcConfDbMerge/
#PartPropSvcConfDbMerge::
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

.PHONY: PartPropSvcConfDbMerge PartPropSvcConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/PartPropSvc/armv7l-fc21-gcc49-opt/genConf/PartPropSvc/PartPropSvc.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

PartPropSvcConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  PartPropSvcConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

PartPropSvcConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libPartPropSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libPartPropSvc.so
#-- start of cleanup_header --------------

clean :: PartPropSvcConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PartPropSvcConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PartPropSvcConfDbMergeclean ::
#-- end of cleanup_header ---------------
