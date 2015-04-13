#-- start of make_header -----------------

#====================================
#  Document RootCnvMergeComponentsList
#
#   Generated Mon Feb 16 20:01:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvMergeComponentsList

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvMergeComponentsList = $(RootCnv_tag)_RootCnvMergeComponentsList.make
cmt_local_tagfile_RootCnvMergeComponentsList = $(bin)$(RootCnv_tag)_RootCnvMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvMergeComponentsList = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvMergeComponentsList = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvMergeComponentsList)
#-include $(cmt_local_tagfile_RootCnvMergeComponentsList)

ifdef cmt_RootCnvMergeComponentsList_has_target_tag

cmt_final_setup_RootCnvMergeComponentsList = $(bin)setup_RootCnvMergeComponentsList.make
cmt_dependencies_in_RootCnvMergeComponentsList = $(bin)dependencies_RootCnvMergeComponentsList.in
#cmt_final_setup_RootCnvMergeComponentsList = $(bin)RootCnv_RootCnvMergeComponentsListsetup.make
cmt_local_RootCnvMergeComponentsList_makefile = $(bin)RootCnvMergeComponentsList.make

else

cmt_final_setup_RootCnvMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_RootCnvMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_RootCnvMergeComponentsList = $(bin)RootCnvsetup.make
cmt_local_RootCnvMergeComponentsList_makefile = $(bin)RootCnvMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvMergeComponentsList/
#RootCnvMergeComponentsList::
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


.PHONY: RootCnvMergeComponentsList RootCnvMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/RootCnv.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

RootCnvMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  RootCnvMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

RootCnvMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libRootCnv_so_dependencies = ../armv7l-fc21-gcc49-opt/libRootCnv.so
#-- start of cleanup_header --------------

clean :: RootCnvMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvMergeComponentsListclean ::
#-- end of cleanup_header ---------------
