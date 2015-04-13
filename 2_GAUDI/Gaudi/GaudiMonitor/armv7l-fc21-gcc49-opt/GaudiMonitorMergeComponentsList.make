#-- start of make_header -----------------

#====================================
#  Document GaudiMonitorMergeComponentsList
#
#   Generated Mon Feb 16 19:53:00 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMonitorMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMonitorMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMonitorMergeComponentsList

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(GaudiMonitor_tag)_GaudiMonitorMergeComponentsList.make
cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(bin)$(GaudiMonitor_tag)_GaudiMonitorMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(GaudiMonitor_tag).make
cmt_local_tagfile_GaudiMonitorMergeComponentsList = $(bin)$(GaudiMonitor_tag).make

endif

include $(cmt_local_tagfile_GaudiMonitorMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiMonitorMergeComponentsList)

ifdef cmt_GaudiMonitorMergeComponentsList_has_target_tag

cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)setup_GaudiMonitorMergeComponentsList.make
cmt_dependencies_in_GaudiMonitorMergeComponentsList = $(bin)dependencies_GaudiMonitorMergeComponentsList.in
#cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)GaudiMonitor_GaudiMonitorMergeComponentsListsetup.make
cmt_local_GaudiMonitorMergeComponentsList_makefile = $(bin)GaudiMonitorMergeComponentsList.make

else

cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiMonitorMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiMonitorMergeComponentsList = $(bin)GaudiMonitorsetup.make
cmt_local_GaudiMonitorMergeComponentsList_makefile = $(bin)GaudiMonitorMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make

#GaudiMonitorMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMonitorMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMonitorMergeComponentsList/
#GaudiMonitorMergeComponentsList::
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


.PHONY: GaudiMonitorMergeComponentsList GaudiMonitorMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiMonitor.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiMonitorMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiMonitorMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiMonitorMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiMonitor_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiMonitor.so
#-- start of cleanup_header --------------

clean :: GaudiMonitorMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMonitorMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMonitorMergeComponentsListclean ::
#-- end of cleanup_header ---------------
