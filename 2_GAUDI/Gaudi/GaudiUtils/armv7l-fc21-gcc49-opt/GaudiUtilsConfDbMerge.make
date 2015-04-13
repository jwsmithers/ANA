#-- start of make_header -----------------

#====================================
#  Document GaudiUtilsConfDbMerge
#
#   Generated Mon Feb 16 20:00:06 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtilsConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtilsConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtilsConfDbMerge

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsConfDbMerge = $(GaudiUtils_tag)_GaudiUtilsConfDbMerge.make
cmt_local_tagfile_GaudiUtilsConfDbMerge = $(bin)$(GaudiUtils_tag)_GaudiUtilsConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsConfDbMerge = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtilsConfDbMerge = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtilsConfDbMerge)
#-include $(cmt_local_tagfile_GaudiUtilsConfDbMerge)

ifdef cmt_GaudiUtilsConfDbMerge_has_target_tag

cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)setup_GaudiUtilsConfDbMerge.make
cmt_dependencies_in_GaudiUtilsConfDbMerge = $(bin)dependencies_GaudiUtilsConfDbMerge.in
#cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)GaudiUtils_GaudiUtilsConfDbMergesetup.make
cmt_local_GaudiUtilsConfDbMerge_makefile = $(bin)GaudiUtilsConfDbMerge.make

else

cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiUtilsConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiUtilsConfDbMerge = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtilsConfDbMerge_makefile = $(bin)GaudiUtilsConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtilsConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtilsConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtilsConfDbMerge/
#GaudiUtilsConfDbMerge::
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

.PHONY: GaudiUtilsConfDbMerge GaudiUtilsConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiUtils/armv7l-fc21-gcc49-opt/genConf/GaudiUtils/GaudiUtils.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiUtilsConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiUtilsConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiUtilsConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiUtils_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiUtils.so
#-- start of cleanup_header --------------

clean :: GaudiUtilsConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtilsConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsConfDbMergeclean ::
#-- end of cleanup_header ---------------