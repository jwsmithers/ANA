#-- start of make_header -----------------

#====================================
#  Document GaudiMPConfDbMerge
#
#   Generated Mon Feb 16 20:49:53 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPConfDbMerge

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConfDbMerge = $(GaudiMP_tag)_GaudiMPConfDbMerge.make
cmt_local_tagfile_GaudiMPConfDbMerge = $(bin)$(GaudiMP_tag)_GaudiMPConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConfDbMerge = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPConfDbMerge = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPConfDbMerge)
#-include $(cmt_local_tagfile_GaudiMPConfDbMerge)

ifdef cmt_GaudiMPConfDbMerge_has_target_tag

cmt_final_setup_GaudiMPConfDbMerge = $(bin)setup_GaudiMPConfDbMerge.make
cmt_dependencies_in_GaudiMPConfDbMerge = $(bin)dependencies_GaudiMPConfDbMerge.in
#cmt_final_setup_GaudiMPConfDbMerge = $(bin)GaudiMP_GaudiMPConfDbMergesetup.make
cmt_local_GaudiMPConfDbMerge_makefile = $(bin)GaudiMPConfDbMerge.make

else

cmt_final_setup_GaudiMPConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiMPConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiMPConfDbMerge = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPConfDbMerge_makefile = $(bin)GaudiMPConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPConfDbMerge/
#GaudiMPConfDbMerge::
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

.PHONY: GaudiMPConfDbMerge GaudiMPConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/GaudiMP.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiMPConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiMPConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiMPConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiMP_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiMP.so
#-- start of cleanup_header --------------

clean :: GaudiMPConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPConfDbMergeclean ::
#-- end of cleanup_header ---------------
