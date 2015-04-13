#-- start of make_header -----------------

#====================================
#  Document GaudiGSLConfDbMerge
#
#   Generated Mon Feb 16 20:18:44 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLConfDbMerge

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLConfDbMerge = $(GaudiGSL_tag)_GaudiGSLConfDbMerge.make
cmt_local_tagfile_GaudiGSLConfDbMerge = $(bin)$(GaudiGSL_tag)_GaudiGSLConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLConfDbMerge = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLConfDbMerge = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLConfDbMerge)
#-include $(cmt_local_tagfile_GaudiGSLConfDbMerge)

ifdef cmt_GaudiGSLConfDbMerge_has_target_tag

cmt_final_setup_GaudiGSLConfDbMerge = $(bin)setup_GaudiGSLConfDbMerge.make
cmt_dependencies_in_GaudiGSLConfDbMerge = $(bin)dependencies_GaudiGSLConfDbMerge.in
#cmt_final_setup_GaudiGSLConfDbMerge = $(bin)GaudiGSL_GaudiGSLConfDbMergesetup.make
cmt_local_GaudiGSLConfDbMerge_makefile = $(bin)GaudiGSLConfDbMerge.make

else

cmt_final_setup_GaudiGSLConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiGSLConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLConfDbMerge = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLConfDbMerge_makefile = $(bin)GaudiGSLConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLConfDbMerge/
#GaudiGSLConfDbMerge::
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

.PHONY: GaudiGSLConfDbMerge GaudiGSLConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiGSL/armv7l-fc21-gcc49-opt/genConf/GaudiGSL/GaudiGSL.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiGSLConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiGSLConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiGSLConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiGSL_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiGSL.so
#-- start of cleanup_header --------------

clean :: GaudiGSLConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLConfDbMergeclean ::
#-- end of cleanup_header ---------------
