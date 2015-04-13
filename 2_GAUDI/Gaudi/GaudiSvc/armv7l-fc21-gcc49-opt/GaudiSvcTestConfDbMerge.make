#-- start of make_header -----------------

#====================================
#  Document GaudiSvcTestConfDbMerge
#
#   Generated Mon Feb 16 19:55:56 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcTestConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcTestConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcTestConfDbMerge

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(GaudiSvc_tag)_GaudiSvcTestConfDbMerge.make
cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcTestConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcTestConfDbMerge = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcTestConfDbMerge)
#-include $(cmt_local_tagfile_GaudiSvcTestConfDbMerge)

ifdef cmt_GaudiSvcTestConfDbMerge_has_target_tag

cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)setup_GaudiSvcTestConfDbMerge.make
cmt_dependencies_in_GaudiSvcTestConfDbMerge = $(bin)dependencies_GaudiSvcTestConfDbMerge.in
#cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)GaudiSvc_GaudiSvcTestConfDbMergesetup.make
cmt_local_GaudiSvcTestConfDbMerge_makefile = $(bin)GaudiSvcTestConfDbMerge.make

else

cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiSvcTestConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcTestConfDbMerge = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcTestConfDbMerge_makefile = $(bin)GaudiSvcTestConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcTestConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcTestConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcTestConfDbMerge/
#GaudiSvcTestConfDbMerge::
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

.PHONY: GaudiSvcTestConfDbMerge GaudiSvcTestConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/GaudiSvcTest.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiSvcTestConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiSvcTestConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiSvcTestConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiSvcTest_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiSvcTest.so
#-- start of cleanup_header --------------

clean :: GaudiSvcTestConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcTestConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcTestConfDbMergeclean ::
#-- end of cleanup_header ---------------
