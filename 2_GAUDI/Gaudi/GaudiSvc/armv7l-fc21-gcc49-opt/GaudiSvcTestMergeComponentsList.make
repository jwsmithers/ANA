#-- start of make_header -----------------

#====================================
#  Document GaudiSvcTestMergeComponentsList
#
#   Generated Mon Feb 16 19:55:56 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcTestMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcTestMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcTestMergeComponentsList

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(GaudiSvc_tag)_GaudiSvcTestMergeComponentsList.make
cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcTestMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcTestMergeComponentsList = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcTestMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiSvcTestMergeComponentsList)

ifdef cmt_GaudiSvcTestMergeComponentsList_has_target_tag

cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)setup_GaudiSvcTestMergeComponentsList.make
cmt_dependencies_in_GaudiSvcTestMergeComponentsList = $(bin)dependencies_GaudiSvcTestMergeComponentsList.in
#cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)GaudiSvc_GaudiSvcTestMergeComponentsListsetup.make
cmt_local_GaudiSvcTestMergeComponentsList_makefile = $(bin)GaudiSvcTestMergeComponentsList.make

else

cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiSvcTestMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcTestMergeComponentsList = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcTestMergeComponentsList_makefile = $(bin)GaudiSvcTestMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcTestMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcTestMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcTestMergeComponentsList/
#GaudiSvcTestMergeComponentsList::
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


.PHONY: GaudiSvcTestMergeComponentsList GaudiSvcTestMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiSvcTest.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiSvcTestMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiSvcTestMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiSvcTestMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiSvcTest_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiSvcTest.so
#-- start of cleanup_header --------------

clean :: GaudiSvcTestMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcTestMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcTestMergeComponentsListclean ::
#-- end of cleanup_header ---------------
