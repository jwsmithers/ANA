#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesMergeComponentsList
#
#   Generated Mon Feb 16 20:58:31 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesMergeComponentsList

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(GaudiExamples_tag)_GaudiExamplesMergeComponentsList.make
cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(bin)$(GaudiExamples_tag)_GaudiExamplesMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesMergeComponentsList = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiExamplesMergeComponentsList)

ifdef cmt_GaudiExamplesMergeComponentsList_has_target_tag

cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)setup_GaudiExamplesMergeComponentsList.make
cmt_dependencies_in_GaudiExamplesMergeComponentsList = $(bin)dependencies_GaudiExamplesMergeComponentsList.in
#cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)GaudiExamples_GaudiExamplesMergeComponentsListsetup.make
cmt_local_GaudiExamplesMergeComponentsList_makefile = $(bin)GaudiExamplesMergeComponentsList.make

else

cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesMergeComponentsList = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesMergeComponentsList_makefile = $(bin)GaudiExamplesMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesMergeComponentsList/
#GaudiExamplesMergeComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# File: cmt/fragments/merge_componentslist_header
# Author: Sebastien Binet (binet@cern.ch)

# Makefile fragment to merge a <library>.components file into a single
# <project>.components file in the (lib) install area
# If no InstallArea is present the fragment is dummy


.PHONY: GaudiExamplesMergeComponentsList GaudiExamplesMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiExamples.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiExamplesMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiExamplesMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiExamplesMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiExamples_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiExamples.so
#-- start of cleanup_header --------------

clean :: GaudiExamplesMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesMergeComponentsListclean ::
#-- end of cleanup_header ---------------
