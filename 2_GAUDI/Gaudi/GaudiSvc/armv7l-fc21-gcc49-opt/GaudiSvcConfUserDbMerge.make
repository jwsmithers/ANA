#-- start of make_header -----------------

#====================================
#  Document GaudiSvcConfUserDbMerge
#
#   Generated Mon Feb 16 19:54:56 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcConfUserDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcConfUserDbMerge

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(GaudiSvc_tag)_GaudiSvcConfUserDbMerge.make
cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(bin)$(GaudiSvc_tag)_GaudiSvcConfUserDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcConfUserDbMerge = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcConfUserDbMerge)
#-include $(cmt_local_tagfile_GaudiSvcConfUserDbMerge)

ifdef cmt_GaudiSvcConfUserDbMerge_has_target_tag

cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)setup_GaudiSvcConfUserDbMerge.make
cmt_dependencies_in_GaudiSvcConfUserDbMerge = $(bin)dependencies_GaudiSvcConfUserDbMerge.in
#cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)GaudiSvc_GaudiSvcConfUserDbMergesetup.make
cmt_local_GaudiSvcConfUserDbMerge_makefile = $(bin)GaudiSvcConfUserDbMerge.make

else

cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiSvcConfUserDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcConfUserDbMerge = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcConfUserDbMerge_makefile = $(bin)GaudiSvcConfUserDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcConfUserDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcConfUserDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcConfUserDbMerge/
#GaudiSvcConfUserDbMerge::
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

.PHONY: GaudiSvcConfUserDbMerge GaudiSvcConfUserDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiSvc/armv7l-fc21-gcc49-opt/genConf/GaudiSvc/GaudiSvc_user.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiSvcConfUserDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiSvcConfUserDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiSvcConfUserDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
#-- start of cleanup_header --------------

clean :: GaudiSvcConfUserDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcConfUserDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcConfUserDbMergeclean ::
#-- end of cleanup_header ---------------
