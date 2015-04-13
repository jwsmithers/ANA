#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesConfDbMerge
#
#   Generated Mon Feb 16 20:58:32 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesConfDbMerge

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConfDbMerge = $(GaudiExamples_tag)_GaudiExamplesConfDbMerge.make
cmt_local_tagfile_GaudiExamplesConfDbMerge = $(bin)$(GaudiExamples_tag)_GaudiExamplesConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesConfDbMerge = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesConfDbMerge = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesConfDbMerge)
#-include $(cmt_local_tagfile_GaudiExamplesConfDbMerge)

ifdef cmt_GaudiExamplesConfDbMerge_has_target_tag

cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)setup_GaudiExamplesConfDbMerge.make
cmt_dependencies_in_GaudiExamplesConfDbMerge = $(bin)dependencies_GaudiExamplesConfDbMerge.in
#cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)GaudiExamples_GaudiExamplesConfDbMergesetup.make
cmt_local_GaudiExamplesConfDbMerge_makefile = $(bin)GaudiExamplesConfDbMerge.make

else

cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesConfDbMerge = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesConfDbMerge_makefile = $(bin)GaudiExamplesConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesConfDbMerge/
#GaudiExamplesConfDbMerge::
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

.PHONY: GaudiExamplesConfDbMerge GaudiExamplesConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiExamples/armv7l-fc21-gcc49-opt/genConf/GaudiExamples/GaudiExamples.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiExamplesConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiExamplesConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiExamplesConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiExamples_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiExamples.so
#-- start of cleanup_header --------------

clean :: GaudiExamplesConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesConfDbMergeclean ::
#-- end of cleanup_header ---------------
