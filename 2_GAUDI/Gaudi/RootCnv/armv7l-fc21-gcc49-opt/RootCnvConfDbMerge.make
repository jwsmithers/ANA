#-- start of make_header -----------------

#====================================
#  Document RootCnvConfDbMerge
#
#   Generated Mon Feb 16 20:01:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvConfDbMerge

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvConfDbMerge = $(RootCnv_tag)_RootCnvConfDbMerge.make
cmt_local_tagfile_RootCnvConfDbMerge = $(bin)$(RootCnv_tag)_RootCnvConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvConfDbMerge = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvConfDbMerge = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvConfDbMerge)
#-include $(cmt_local_tagfile_RootCnvConfDbMerge)

ifdef cmt_RootCnvConfDbMerge_has_target_tag

cmt_final_setup_RootCnvConfDbMerge = $(bin)setup_RootCnvConfDbMerge.make
cmt_dependencies_in_RootCnvConfDbMerge = $(bin)dependencies_RootCnvConfDbMerge.in
#cmt_final_setup_RootCnvConfDbMerge = $(bin)RootCnv_RootCnvConfDbMergesetup.make
cmt_local_RootCnvConfDbMerge_makefile = $(bin)RootCnvConfDbMerge.make

else

cmt_final_setup_RootCnvConfDbMerge = $(bin)setup.make
cmt_dependencies_in_RootCnvConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_RootCnvConfDbMerge = $(bin)RootCnvsetup.make
cmt_local_RootCnvConfDbMerge_makefile = $(bin)RootCnvConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvConfDbMerge/
#RootCnvConfDbMerge::
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

.PHONY: RootCnvConfDbMerge RootCnvConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/RootCnv/armv7l-fc21-gcc49-opt/genConf/RootCnv/RootCnv.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

RootCnvConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  RootCnvConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

RootCnvConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libRootCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootCnv.so
#-- start of cleanup_header --------------

clean :: RootCnvConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvConfDbMergeclean ::
#-- end of cleanup_header ---------------
