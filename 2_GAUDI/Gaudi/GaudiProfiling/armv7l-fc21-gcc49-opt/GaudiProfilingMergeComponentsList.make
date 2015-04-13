#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingMergeComponentsList
#
#   Generated Mon Feb 16 20:16:26 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingMergeComponentsList

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(GaudiProfiling_tag)_GaudiProfilingMergeComponentsList.make
cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiProfilingMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiProfilingMergeComponentsList)

ifdef cmt_GaudiProfilingMergeComponentsList_has_target_tag

cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)setup_GaudiProfilingMergeComponentsList.make
cmt_dependencies_in_GaudiProfilingMergeComponentsList = $(bin)dependencies_GaudiProfilingMergeComponentsList.in
#cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)GaudiProfiling_GaudiProfilingMergeComponentsListsetup.make
cmt_local_GaudiProfilingMergeComponentsList_makefile = $(bin)GaudiProfilingMergeComponentsList.make

else

cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingMergeComponentsList = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingMergeComponentsList_makefile = $(bin)GaudiProfilingMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingMergeComponentsList/
#GaudiProfilingMergeComponentsList::
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


.PHONY: GaudiProfilingMergeComponentsList GaudiProfilingMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiProfiling.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiProfilingMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiProfilingMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiProfilingMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiProfiling_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiProfiling.so
#-- start of cleanup_header --------------

clean :: GaudiProfilingMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingMergeComponentsListclean ::
#-- end of cleanup_header ---------------
