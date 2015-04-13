#-- start of make_header -----------------

#====================================
#  Document GaudiPartPropConfDbMerge
#
#   Generated Mon Feb 16 19:54:37 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPartPropConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPartPropConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPartPropConfDbMerge

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropConfDbMerge = $(GaudiPartProp_tag)_GaudiPartPropConfDbMerge.make
cmt_local_tagfile_GaudiPartPropConfDbMerge = $(bin)$(GaudiPartProp_tag)_GaudiPartPropConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropConfDbMerge = $(GaudiPartProp_tag).make
cmt_local_tagfile_GaudiPartPropConfDbMerge = $(bin)$(GaudiPartProp_tag).make

endif

include $(cmt_local_tagfile_GaudiPartPropConfDbMerge)
#-include $(cmt_local_tagfile_GaudiPartPropConfDbMerge)

ifdef cmt_GaudiPartPropConfDbMerge_has_target_tag

cmt_final_setup_GaudiPartPropConfDbMerge = $(bin)setup_GaudiPartPropConfDbMerge.make
cmt_dependencies_in_GaudiPartPropConfDbMerge = $(bin)dependencies_GaudiPartPropConfDbMerge.in
#cmt_final_setup_GaudiPartPropConfDbMerge = $(bin)GaudiPartProp_GaudiPartPropConfDbMergesetup.make
cmt_local_GaudiPartPropConfDbMerge_makefile = $(bin)GaudiPartPropConfDbMerge.make

else

cmt_final_setup_GaudiPartPropConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiPartPropConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiPartPropConfDbMerge = $(bin)GaudiPartPropsetup.make
cmt_local_GaudiPartPropConfDbMerge_makefile = $(bin)GaudiPartPropConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPartPropsetup.make

#GaudiPartPropConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPartPropConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPartPropConfDbMerge/
#GaudiPartPropConfDbMerge::
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

.PHONY: GaudiPartPropConfDbMerge GaudiPartPropConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiPartProp/armv7l-fc21-gcc49-opt/genConf/GaudiPartProp/GaudiPartProp.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiPartPropConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiPartPropConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiPartPropConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiPartProp_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiPartProp.so
#-- start of cleanup_header --------------

clean :: GaudiPartPropConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPartPropConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPartPropConfDbMergeclean ::
#-- end of cleanup_header ---------------
