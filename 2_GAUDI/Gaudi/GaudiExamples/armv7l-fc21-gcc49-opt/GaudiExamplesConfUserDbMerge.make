#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesConfUserDbMerge
#
#   Generated Mon Feb 16 20:50:17 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesConfUserDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesConfUserDbMerge

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(GaudiExamples_tag)_GaudiExamplesConfUserDbMerge.make
cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(bin)$(GaudiExamples_tag)_GaudiExamplesConfUserDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesConfUserDbMerge = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesConfUserDbMerge)
#-include $(cmt_local_tagfile_GaudiExamplesConfUserDbMerge)

ifdef cmt_GaudiExamplesConfUserDbMerge_has_target_tag

cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)setup_GaudiExamplesConfUserDbMerge.make
cmt_dependencies_in_GaudiExamplesConfUserDbMerge = $(bin)dependencies_GaudiExamplesConfUserDbMerge.in
#cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)GaudiExamples_GaudiExamplesConfUserDbMergesetup.make
cmt_local_GaudiExamplesConfUserDbMerge_makefile = $(bin)GaudiExamplesConfUserDbMerge.make

else

cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesConfUserDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesConfUserDbMerge = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesConfUserDbMerge_makefile = $(bin)GaudiExamplesConfUserDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesConfUserDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesConfUserDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesConfUserDbMerge/
#GaudiExamplesConfUserDbMerge::
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

.PHONY: GaudiExamplesConfUserDbMerge GaudiExamplesConfUserDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/GaudiExamples_user.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiExamplesConfUserDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiExamplesConfUserDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiExamplesConfUserDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
#-- start of cleanup_header --------------

clean :: GaudiExamplesConfUserDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesConfUserDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesConfUserDbMergeclean ::
#-- end of cleanup_header ---------------
