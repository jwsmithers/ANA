#-- start of make_header -----------------

#====================================
#  Document PartPropSvcMergeComponentsList
#
#   Generated Mon Feb 16 19:52:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PartPropSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PartPropSvcMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PartPropSvcMergeComponentsList

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcMergeComponentsList = $(PartPropSvc_tag)_PartPropSvcMergeComponentsList.make
cmt_local_tagfile_PartPropSvcMergeComponentsList = $(bin)$(PartPropSvc_tag)_PartPropSvcMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcMergeComponentsList = $(PartPropSvc_tag).make
cmt_local_tagfile_PartPropSvcMergeComponentsList = $(bin)$(PartPropSvc_tag).make

endif

include $(cmt_local_tagfile_PartPropSvcMergeComponentsList)
#-include $(cmt_local_tagfile_PartPropSvcMergeComponentsList)

ifdef cmt_PartPropSvcMergeComponentsList_has_target_tag

cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)setup_PartPropSvcMergeComponentsList.make
cmt_dependencies_in_PartPropSvcMergeComponentsList = $(bin)dependencies_PartPropSvcMergeComponentsList.in
#cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)PartPropSvc_PartPropSvcMergeComponentsListsetup.make
cmt_local_PartPropSvcMergeComponentsList_makefile = $(bin)PartPropSvcMergeComponentsList.make

else

cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_PartPropSvcMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_PartPropSvcMergeComponentsList = $(bin)PartPropSvcsetup.make
cmt_local_PartPropSvcMergeComponentsList_makefile = $(bin)PartPropSvcMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make

#PartPropSvcMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PartPropSvcMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PartPropSvcMergeComponentsList/
#PartPropSvcMergeComponentsList::
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


.PHONY: PartPropSvcMergeComponentsList PartPropSvcMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/PartPropSvc.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

PartPropSvcMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  PartPropSvcMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

PartPropSvcMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libPartPropSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libPartPropSvc.so
#-- start of cleanup_header --------------

clean :: PartPropSvcMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PartPropSvcMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PartPropSvcMergeComponentsListclean ::
#-- end of cleanup_header ---------------
