#-- start of make_header -----------------

#====================================
#  Document RootHistCnvConfDbMerge
#
#   Generated Mon Feb 16 19:54:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnvConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnvConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnvConfDbMerge

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvConfDbMerge = $(RootHistCnv_tag)_RootHistCnvConfDbMerge.make
cmt_local_tagfile_RootHistCnvConfDbMerge = $(bin)$(RootHistCnv_tag)_RootHistCnvConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvConfDbMerge = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnvConfDbMerge = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnvConfDbMerge)
#-include $(cmt_local_tagfile_RootHistCnvConfDbMerge)

ifdef cmt_RootHistCnvConfDbMerge_has_target_tag

cmt_final_setup_RootHistCnvConfDbMerge = $(bin)setup_RootHistCnvConfDbMerge.make
cmt_dependencies_in_RootHistCnvConfDbMerge = $(bin)dependencies_RootHistCnvConfDbMerge.in
#cmt_final_setup_RootHistCnvConfDbMerge = $(bin)RootHistCnv_RootHistCnvConfDbMergesetup.make
cmt_local_RootHistCnvConfDbMerge_makefile = $(bin)RootHistCnvConfDbMerge.make

else

cmt_final_setup_RootHistCnvConfDbMerge = $(bin)setup.make
cmt_dependencies_in_RootHistCnvConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_RootHistCnvConfDbMerge = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnvConfDbMerge_makefile = $(bin)RootHistCnvConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnvConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnvConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnvConfDbMerge/
#RootHistCnvConfDbMerge::
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

.PHONY: RootHistCnvConfDbMerge RootHistCnvConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/RootHistCnv/armv7l-fc21-gcc49-opt/genConf/RootHistCnv/RootHistCnv.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

RootHistCnvConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  RootHistCnvConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

RootHistCnvConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libRootHistCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootHistCnv.so
#-- start of cleanup_header --------------

clean :: RootHistCnvConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnvConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnvConfDbMergeclean ::
#-- end of cleanup_header ---------------
