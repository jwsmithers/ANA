#-- start of make_header -----------------

#====================================
#  Document GaudiSvcMergeComponentsList
#
#   Generated Mon Feb 16 19:56:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcMergeComponentsList

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcMergeComponentsList = $(GaudiSvc_tag)_GaudiSvcMergeComponentsList.make
cmt_local_tagfile_GaudiSvcMergeComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcMergeComponentsList = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcMergeComponentsList = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiSvcMergeComponentsList)

ifdef cmt_GaudiSvcMergeComponentsList_has_target_tag

cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)setup_GaudiSvcMergeComponentsList.make
cmt_dependencies_in_GaudiSvcMergeComponentsList = $(bin)dependencies_GaudiSvcMergeComponentsList.in
#cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)GaudiSvc_GaudiSvcMergeComponentsListsetup.make
cmt_local_GaudiSvcMergeComponentsList_makefile = $(bin)GaudiSvcMergeComponentsList.make

else

cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiSvcMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcMergeComponentsList = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcMergeComponentsList_makefile = $(bin)GaudiSvcMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcMergeComponentsList/
#GaudiSvcMergeComponentsList::
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


.PHONY: GaudiSvcMergeComponentsList GaudiSvcMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiSvc.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiSvcMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiSvcMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiSvcMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiSvc.so
#-- start of cleanup_header --------------

clean :: GaudiSvcMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcMergeComponentsListclean ::
#-- end of cleanup_header ---------------
