#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingConfDbMerge
#
#   Generated Mon Feb 16 20:16:27 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingConfDbMerge

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConfDbMerge = $(GaudiProfiling_tag)_GaudiProfilingConfDbMerge.make
cmt_local_tagfile_GaudiProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConfDbMerge = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingConfDbMerge)
#-include $(cmt_local_tagfile_GaudiProfilingConfDbMerge)

ifdef cmt_GaudiProfilingConfDbMerge_has_target_tag

cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)setup_GaudiProfilingConfDbMerge.make
cmt_dependencies_in_GaudiProfilingConfDbMerge = $(bin)dependencies_GaudiProfilingConfDbMerge.in
#cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)GaudiProfiling_GaudiProfilingConfDbMergesetup.make
cmt_local_GaudiProfilingConfDbMerge_makefile = $(bin)GaudiProfilingConfDbMerge.make

else

cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingConfDbMerge = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingConfDbMerge_makefile = $(bin)GaudiProfilingConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingConfDbMerge/
#GaudiProfilingConfDbMerge::
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

.PHONY: GaudiProfilingConfDbMerge GaudiProfilingConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/GaudiProfiling.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiProfilingConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiProfilingConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiProfilingConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiProfiling_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiProfiling.so
#-- start of cleanup_header --------------

clean :: GaudiProfilingConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingConfDbMergeclean ::
#-- end of cleanup_header ---------------
