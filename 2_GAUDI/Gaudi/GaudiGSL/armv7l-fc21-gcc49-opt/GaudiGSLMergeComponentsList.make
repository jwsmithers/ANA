#-- start of make_header -----------------

#====================================
#  Document GaudiGSLMergeComponentsList
#
#   Generated Mon Feb 16 20:18:43 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLMergeComponentsList

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMergeComponentsList = $(GaudiGSL_tag)_GaudiGSLMergeComponentsList.make
cmt_local_tagfile_GaudiGSLMergeComponentsList = $(bin)$(GaudiGSL_tag)_GaudiGSLMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMergeComponentsList = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLMergeComponentsList = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiGSLMergeComponentsList)

ifdef cmt_GaudiGSLMergeComponentsList_has_target_tag

cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)setup_GaudiGSLMergeComponentsList.make
cmt_dependencies_in_GaudiGSLMergeComponentsList = $(bin)dependencies_GaudiGSLMergeComponentsList.in
#cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)GaudiGSL_GaudiGSLMergeComponentsListsetup.make
cmt_local_GaudiGSLMergeComponentsList_makefile = $(bin)GaudiGSLMergeComponentsList.make

else

cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiGSLMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLMergeComponentsList = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLMergeComponentsList_makefile = $(bin)GaudiGSLMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLMergeComponentsList/
#GaudiGSLMergeComponentsList::
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


.PHONY: GaudiGSLMergeComponentsList GaudiGSLMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiGSL.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiGSLMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiGSLMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiGSLMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiGSL_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiGSL.so
#-- start of cleanup_header --------------

clean :: GaudiGSLMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLMergeComponentsListclean ::
#-- end of cleanup_header ---------------
