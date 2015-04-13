#-- start of make_header -----------------

#====================================
#  Document GaudiConfUserDbMerge
#
#   Generated Mon Feb 16 20:49:58 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiConfUserDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiConfUserDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiConfUserDbMerge

Gaudi_tag = $(tag)

#cmt_local_tagfile_GaudiConfUserDbMerge = $(Gaudi_tag)_GaudiConfUserDbMerge.make
cmt_local_tagfile_GaudiConfUserDbMerge = $(bin)$(Gaudi_tag)_GaudiConfUserDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Gaudi_tag = $(tag)

#cmt_local_tagfile_GaudiConfUserDbMerge = $(Gaudi_tag).make
cmt_local_tagfile_GaudiConfUserDbMerge = $(bin)$(Gaudi_tag).make

endif

include $(cmt_local_tagfile_GaudiConfUserDbMerge)
#-include $(cmt_local_tagfile_GaudiConfUserDbMerge)

ifdef cmt_GaudiConfUserDbMerge_has_target_tag

cmt_final_setup_GaudiConfUserDbMerge = $(bin)setup_GaudiConfUserDbMerge.make
cmt_dependencies_in_GaudiConfUserDbMerge = $(bin)dependencies_GaudiConfUserDbMerge.in
#cmt_final_setup_GaudiConfUserDbMerge = $(bin)Gaudi_GaudiConfUserDbMergesetup.make
cmt_local_GaudiConfUserDbMerge_makefile = $(bin)GaudiConfUserDbMerge.make

else

cmt_final_setup_GaudiConfUserDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiConfUserDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiConfUserDbMerge = $(bin)Gaudisetup.make
cmt_local_GaudiConfUserDbMerge_makefile = $(bin)GaudiConfUserDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Gaudisetup.make

#GaudiConfUserDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiConfUserDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiConfUserDbMerge/
#GaudiConfUserDbMerge::
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

.PHONY: GaudiConfUserDbMerge GaudiConfUserDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/Gaudi/armv7l-fc21-gcc49-opt/genConf/Gaudi/Gaudi_user.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiConfUserDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiConfUserDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiConfUserDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
#-- start of cleanup_header --------------

clean :: GaudiConfUserDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiConfUserDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiConfUserDbMergeclean ::
#-- end of cleanup_header ---------------
