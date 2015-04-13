#-- start of make_header -----------------

#====================================
#  Document RootHistCnvMergeComponentsList
#
#   Generated Mon Feb 16 19:54:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnvMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnvMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnvMergeComponentsList

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvMergeComponentsList = $(RootHistCnv_tag)_RootHistCnvMergeComponentsList.make
cmt_local_tagfile_RootHistCnvMergeComponentsList = $(bin)$(RootHistCnv_tag)_RootHistCnvMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvMergeComponentsList = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnvMergeComponentsList = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnvMergeComponentsList)
#-include $(cmt_local_tagfile_RootHistCnvMergeComponentsList)

ifdef cmt_RootHistCnvMergeComponentsList_has_target_tag

cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)setup_RootHistCnvMergeComponentsList.make
cmt_dependencies_in_RootHistCnvMergeComponentsList = $(bin)dependencies_RootHistCnvMergeComponentsList.in
#cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)RootHistCnv_RootHistCnvMergeComponentsListsetup.make
cmt_local_RootHistCnvMergeComponentsList_makefile = $(bin)RootHistCnvMergeComponentsList.make

else

cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_RootHistCnvMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_RootHistCnvMergeComponentsList = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnvMergeComponentsList_makefile = $(bin)RootHistCnvMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnvMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnvMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnvMergeComponentsList/
#RootHistCnvMergeComponentsList::
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


.PHONY: RootHistCnvMergeComponentsList RootHistCnvMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/RootHistCnv.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

RootHistCnvMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  RootHistCnvMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

RootHistCnvMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libRootHistCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootHistCnv.so
#-- start of cleanup_header --------------

clean :: RootHistCnvMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnvMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnvMergeComponentsListclean ::
#-- end of cleanup_header ---------------
