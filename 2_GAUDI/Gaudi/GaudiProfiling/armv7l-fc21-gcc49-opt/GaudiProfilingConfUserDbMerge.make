#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingConfUserDbMerge
#
#   Generated Mon Feb 16 20:05:11 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingConfUserDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingConfUserDbMerge

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(GaudiProfiling_tag)_GaudiProfilingConfUserDbMerge.make
cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(bin)$(GaudiProfiling_tag)_GaudiProfilingConfUserDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingConfUserDbMerge = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingConfUserDbMerge)
#-include $(cmt_local_tagfile_GaudiProfilingConfUserDbMerge)

ifdef cmt_GaudiProfilingConfUserDbMerge_has_target_tag

cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)setup_GaudiProfilingConfUserDbMerge.make
cmt_dependencies_in_GaudiProfilingConfUserDbMerge = $(bin)dependencies_GaudiProfilingConfUserDbMerge.in
#cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)GaudiProfiling_GaudiProfilingConfUserDbMergesetup.make
cmt_local_GaudiProfilingConfUserDbMerge_makefile = $(bin)GaudiProfilingConfUserDbMerge.make

else

cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingConfUserDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingConfUserDbMerge = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingConfUserDbMerge_makefile = $(bin)GaudiProfilingConfUserDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingConfUserDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingConfUserDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingConfUserDbMerge/
#GaudiProfilingConfUserDbMerge::
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

.PHONY: GaudiProfilingConfUserDbMerge GaudiProfilingConfUserDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiProfiling/armv7l-fc21-gcc49-opt/genConf/GaudiProfiling/GaudiProfiling_user.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiProfilingConfUserDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiProfilingConfUserDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiProfilingConfUserDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
#-- start of cleanup_header --------------

clean :: GaudiProfilingConfUserDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingConfUserDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingConfUserDbMergeclean ::
#-- end of cleanup_header ---------------
