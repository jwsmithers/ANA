#-- start of make_header -----------------

#====================================
#  Document GaudiGoogleProfilingConfDbMerge
#
#   Generated Mon Feb 16 20:16:09 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGoogleProfilingConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGoogleProfilingConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGoogleProfilingConfDbMerge

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(GaudiProfiling_tag)_GaudiGoogleProfilingConfDbMerge.make
cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge)
#-include $(cmt_local_tagfile_GaudiGoogleProfilingConfDbMerge)

ifdef cmt_GaudiGoogleProfilingConfDbMerge_has_target_tag

cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)setup_GaudiGoogleProfilingConfDbMerge.make
cmt_dependencies_in_GaudiGoogleProfilingConfDbMerge = $(bin)dependencies_GaudiGoogleProfilingConfDbMerge.in
#cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)GaudiProfiling_GaudiGoogleProfilingConfDbMergesetup.make
cmt_local_GaudiGoogleProfilingConfDbMerge_makefile = $(bin)GaudiGoogleProfilingConfDbMerge.make

else

cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiGoogleProfilingConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiGoogleProfilingConfDbMerge = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiGoogleProfilingConfDbMerge_makefile = $(bin)GaudiGoogleProfilingConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiGoogleProfilingConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGoogleProfilingConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGoogleProfilingConfDbMerge/
#GaudiGoogleProfilingConfDbMerge::
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

.PHONY: GaudiGoogleProfilingConfDbMerge GaudiGoogleProfilingConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/GaudiGoogleProfiling.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiGoogleProfilingConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiGoogleProfilingConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiGoogleProfilingConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiGoogleProfiling_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiGoogleProfiling.so
#-- start of cleanup_header --------------

clean :: GaudiGoogleProfilingConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGoogleProfilingConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGoogleProfilingConfDbMergeclean ::
#-- end of cleanup_header ---------------
