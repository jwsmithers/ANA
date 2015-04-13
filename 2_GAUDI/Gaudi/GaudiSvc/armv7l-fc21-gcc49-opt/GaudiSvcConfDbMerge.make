#-- start of make_header -----------------

#====================================
#  Document GaudiSvcConfDbMerge
#
#   Generated Mon Feb 16 19:56:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcConfDbMerge

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConfDbMerge = $(GaudiSvc_tag)_GaudiSvcConfDbMerge.make
cmt_local_tagfile_GaudiSvcConfDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConfDbMerge = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcConfDbMerge = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcConfDbMerge)
#-include $(cmt_local_tagfile_GaudiSvcConfDbMerge)

ifdef cmt_GaudiSvcConfDbMerge_has_target_tag

cmt_final_setup_GaudiSvcConfDbMerge = $(bin)setup_GaudiSvcConfDbMerge.make
cmt_dependencies_in_GaudiSvcConfDbMerge = $(bin)dependencies_GaudiSvcConfDbMerge.in
#cmt_final_setup_GaudiSvcConfDbMerge = $(bin)GaudiSvc_GaudiSvcConfDbMergesetup.make
cmt_local_GaudiSvcConfDbMerge_makefile = $(bin)GaudiSvcConfDbMerge.make

else

cmt_final_setup_GaudiSvcConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiSvcConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcConfDbMerge = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcConfDbMerge_makefile = $(bin)GaudiSvcConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcConfDbMerge/
#GaudiSvcConfDbMerge::
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

.PHONY: GaudiSvcConfDbMerge GaudiSvcConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/GaudiSvc.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiSvcConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiSvcConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiSvcConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiSvc.so
#-- start of cleanup_header --------------

clean :: GaudiSvcConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcConfDbMergeclean ::
#-- end of cleanup_header ---------------
