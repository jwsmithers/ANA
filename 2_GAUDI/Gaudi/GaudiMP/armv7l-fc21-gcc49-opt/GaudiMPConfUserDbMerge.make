#-- start of make_header -----------------

#====================================
#  Document GaudiMPConfUserDbMerge
#
#   Generated Mon Feb 16 20:49:04 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPConfUserDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPConfUserDbMerge

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConfUserDbMerge = $(GaudiMP_tag)_GaudiMPConfUserDbMerge.make
cmt_local_tagfile_GaudiMPConfUserDbMerge = $(bin)$(GaudiMP_tag)_GaudiMPConfUserDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPConfUserDbMerge = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPConfUserDbMerge = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPConfUserDbMerge)
#-include $(cmt_local_tagfile_GaudiMPConfUserDbMerge)

ifdef cmt_GaudiMPConfUserDbMerge_has_target_tag

cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)setup_GaudiMPConfUserDbMerge.make
cmt_dependencies_in_GaudiMPConfUserDbMerge = $(bin)dependencies_GaudiMPConfUserDbMerge.in
#cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)GaudiMP_GaudiMPConfUserDbMergesetup.make
cmt_local_GaudiMPConfUserDbMerge_makefile = $(bin)GaudiMPConfUserDbMerge.make

else

cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiMPConfUserDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiMPConfUserDbMerge = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPConfUserDbMerge_makefile = $(bin)GaudiMPConfUserDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPConfUserDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPConfUserDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPConfUserDbMerge/
#GaudiMPConfUserDbMerge::
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

.PHONY: GaudiMPConfUserDbMerge GaudiMPConfUserDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiMP/armv7l-fc21-gcc49-opt/genConf/GaudiMP/GaudiMP_user.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiMPConfUserDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiMPConfUserDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiMPConfUserDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
#-- start of cleanup_header --------------

clean :: GaudiMPConfUserDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPConfUserDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPConfUserDbMergeclean ::
#-- end of cleanup_header ---------------
