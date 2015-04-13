#-- start of make_header -----------------

#====================================
#  Document GaudiPythonConfDbMerge
#
#   Generated Mon Feb 16 20:24:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonConfDbMerge_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonConfDbMerge_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonConfDbMerge

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonConfDbMerge = $(GaudiPython_tag)_GaudiPythonConfDbMerge.make
cmt_local_tagfile_GaudiPythonConfDbMerge = $(bin)$(GaudiPython_tag)_GaudiPythonConfDbMerge.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonConfDbMerge = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonConfDbMerge = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonConfDbMerge)
#-include $(cmt_local_tagfile_GaudiPythonConfDbMerge)

ifdef cmt_GaudiPythonConfDbMerge_has_target_tag

cmt_final_setup_GaudiPythonConfDbMerge = $(bin)setup_GaudiPythonConfDbMerge.make
cmt_dependencies_in_GaudiPythonConfDbMerge = $(bin)dependencies_GaudiPythonConfDbMerge.in
#cmt_final_setup_GaudiPythonConfDbMerge = $(bin)GaudiPython_GaudiPythonConfDbMergesetup.make
cmt_local_GaudiPythonConfDbMerge_makefile = $(bin)GaudiPythonConfDbMerge.make

else

cmt_final_setup_GaudiPythonConfDbMerge = $(bin)setup.make
cmt_dependencies_in_GaudiPythonConfDbMerge = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonConfDbMerge = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonConfDbMerge_makefile = $(bin)GaudiPythonConfDbMerge.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonConfDbMerge :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonConfDbMerge'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonConfDbMerge/
#GaudiPythonConfDbMerge::
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

.PHONY: GaudiPythonConfDbMerge GaudiPythonConfDbMergeclean

# default is already '#'
#genconfDb_comment_char := "'#'"

instdir      := ${CMTINSTALLAREA}/$(tag)
confDbRef    := /home/jwsmith/HDD/Gaudi/GaudiPython/armv7l-fc21-gcc49-opt/genConf/GaudiPython/GaudiPython.confdb
stampConfDb  := $(confDbRef).stamp
mergedConfDb := $(instdir)/lib/$(project).confdb

GaudiPythonConfDbMerge :: $(stampConfDb) $(mergedConfDb)
	@:

.NOTPARALLEL : $(stampConfDb) $(mergedConfDb)

$(stampConfDb) $(mergedConfDb) :: $(confDbRef)
	@echo "Running merge_genconfDb  GaudiPythonConfDbMerge"
	$(merge_genconfDb_cmd) \
          --do-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)

GaudiPythonConfDbMergeclean ::
	$(cleanup_silent) $(merge_genconfDb_cmd) \
          --un-merge \
          --input-file $(confDbRef) \
          --merged-file $(mergedConfDb)	;
	$(cleanup_silent) $(remove_command) $(stampConfDb)
libGaudiPython_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiPython.so
#-- start of cleanup_header --------------

clean :: GaudiPythonConfDbMergeclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonConfDbMerge.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonConfDbMergeclean ::
#-- end of cleanup_header ---------------