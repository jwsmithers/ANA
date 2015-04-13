#-- start of make_header -----------------

#====================================
#  Document GaudiAudConfDbMerge
#
#   Generated Mon Feb 16 20:19:41 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAudConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAudConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAudConfDbMerge

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudConfDbMerge = $(GaudiAud_tag)_GaudiAudConfDbMerge.make
cmt_local_tagfile_GaudiAudConfDbMerge = $(bin)$(GaudiAud_tag)_GaudiAudConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudConfDbMerge = $(GaudiAud_tag).make
cmt_local_tagfile_GaudiAudConfDbMerge = $(bin)$(GaudiAud_tag).make

endif

include $(cmt_local_tagfile_GaudiAudConfDbMerge)
#-include $(cmt_local_tagfile_GaudiAudConfDbMerge)

ifdef cmt_GaudiAudConfDbMerge_has_target_tag

cmt_final_setup_GaudiAudConfDbMerge = $(bin)setup_GaudiAudConfDbMerge.make
cmt_dependencies_in_GaudiAudConfDbMerge = $(bin)dependencies_GaudiAudConfDbMerge.in
#cmt_final_setup_GaudiAudConfDbMerge = $(bin)GaudiAud_GaudiAudConfDbMergesetup.make
cmt_local_GaudiAudConfDbMerge_makefile = $(bin)GaudiAudConfDbMerge.make

else

cmt_final_setup_GaudiAudConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiAudConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiAudConfDbMerge = $(bin)GaudiAudsetup.make
cmt_local_GaudiAudConfDbMerge_makefile = $(bin)GaudiAudConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAudsetup.make

#GaudiAudConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAudConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAudConfDbMerge/
#GaudiAudConfDbMerge::
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

.PHONY: GaudiAudConfDbMerge GaudiAudConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiAud/armv7l-fc21-gcc49-opt/genConf/GaudiAud/GaudiAud.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiAudConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiAudConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiAudConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiAud_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAud.so
#-- start of cleanup_header --------------

clean :: GaudiAudConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAudConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAudConfDbMergeclean ::
#-- end of cleanup_header ---------------
