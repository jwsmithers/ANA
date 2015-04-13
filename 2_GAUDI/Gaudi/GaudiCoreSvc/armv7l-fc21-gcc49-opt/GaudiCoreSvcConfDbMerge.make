#-- start of make_header -----------------

#====================================
#  Document GaudiCoreSvcConfDbMerge
#
#   Generated Mon Feb 16 19:51:49 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvcConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvcConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvcConfDbMerge

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(GaudiCoreSvc_tag)_GaudiCoreSvcConfDbMerge.make
cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvcConfDbMerge = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvcConfDbMerge)
#-include $(cmt_local_tagfile_GaudiCoreSvcConfDbMerge)

ifdef cmt_GaudiCoreSvcConfDbMerge_has_target_tag

cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)setup_GaudiCoreSvcConfDbMerge.make
cmt_dependencies_in_GaudiCoreSvcConfDbMerge = $(bin)dependencies_GaudiCoreSvcConfDbMerge.in
#cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)GaudiCoreSvc_GaudiCoreSvcConfDbMergesetup.make
cmt_local_GaudiCoreSvcConfDbMerge_makefile = $(bin)GaudiCoreSvcConfDbMerge.make

else

cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvcConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvcConfDbMerge = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvcConfDbMerge_makefile = $(bin)GaudiCoreSvcConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvcConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvcConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvcConfDbMerge/
#GaudiCoreSvcConfDbMerge::
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

.PHONY: GaudiCoreSvcConfDbMerge GaudiCoreSvcConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiCoreSvc/armv7l-fc21-gcc49-opt/genConf/GaudiCoreSvc/GaudiCoreSvc.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiCoreSvcConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiCoreSvcConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiCoreSvcConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiCoreSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiCoreSvc.so
#-- start of cleanup_header --------------

clean :: GaudiCoreSvcConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvcConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvcConfDbMergeclean ::
#-- end of cleanup_header ---------------
