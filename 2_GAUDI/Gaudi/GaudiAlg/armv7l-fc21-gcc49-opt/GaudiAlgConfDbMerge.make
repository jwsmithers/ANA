#-- start of make_header -----------------

#====================================
#  Document GaudiAlgConfDbMerge
#
#   Generated Mon Feb 16 20:05:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlgConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlgConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlgConfDbMerge

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgConfDbMerge = $(GaudiAlg_tag)_GaudiAlgConfDbMerge.make
cmt_local_tagfile_GaudiAlgConfDbMerge = $(bin)$(GaudiAlg_tag)_GaudiAlgConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgConfDbMerge = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlgConfDbMerge = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlgConfDbMerge)
#-include $(cmt_local_tagfile_GaudiAlgConfDbMerge)

ifdef cmt_GaudiAlgConfDbMerge_has_target_tag

cmt_final_setup_GaudiAlgConfDbMerge = $(bin)setup_GaudiAlgConfDbMerge.make
cmt_dependencies_in_GaudiAlgConfDbMerge = $(bin)dependencies_GaudiAlgConfDbMerge.in
#cmt_final_setup_GaudiAlgConfDbMerge = $(bin)GaudiAlg_GaudiAlgConfDbMergesetup.make
cmt_local_GaudiAlgConfDbMerge_makefile = $(bin)GaudiAlgConfDbMerge.make

else

cmt_final_setup_GaudiAlgConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiAlgConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiAlgConfDbMerge = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlgConfDbMerge_makefile = $(bin)GaudiAlgConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlgConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlgConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlgConfDbMerge/
#GaudiAlgConfDbMerge::
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

.PHONY: GaudiAlgConfDbMerge GaudiAlgConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiAlg/armv7l-fc21-gcc49-opt/genConf/GaudiAlg/GaudiAlg.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiAlgConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiAlgConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiAlgConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiAlg_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAlg.so
#-- start of cleanup_header --------------

clean :: GaudiAlgConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlgConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgConfDbMergeclean ::
#-- end of cleanup_header ---------------
