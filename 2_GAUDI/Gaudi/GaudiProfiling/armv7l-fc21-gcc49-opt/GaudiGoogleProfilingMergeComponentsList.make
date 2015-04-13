#-- start of make_header -----------------

#====================================
#  Document GaudiGoogleProfilingMergeComponentsList
#
#   Generated Mon Feb 16 20:16:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGoogleProfilingMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGoogleProfilingMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGoogleProfilingMergeComponentsList

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(GaudiProfiling_tag)_GaudiGoogleProfilingMergeComponentsList.make
cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiGoogleProfilingMergeComponentsList)

ifdef cmt_GaudiGoogleProfilingMergeComponentsList_has_target_tag

cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)setup_GaudiGoogleProfilingMergeComponentsList.make
cmt_dependencies_in_GaudiGoogleProfilingMergeComponentsList = $(bin)dependencies_GaudiGoogleProfilingMergeComponentsList.in
#cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)GaudiProfiling_GaudiGoogleProfilingMergeComponentsListsetup.make
cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile = $(bin)GaudiGoogleProfilingMergeComponentsList.make

else

cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiGoogleProfilingMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiGoogleProfilingMergeComponentsList = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiGoogleProfilingMergeComponentsList_makefile = $(bin)GaudiGoogleProfilingMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiGoogleProfilingMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGoogleProfilingMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGoogleProfilingMergeComponentsList/
#GaudiGoogleProfilingMergeComponentsList::
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


.PHONY: GaudiGoogleProfilingMergeComponentsList GaudiGoogleProfilingMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiGoogleProfiling.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiGoogleProfilingMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiGoogleProfilingMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiGoogleProfilingMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiGoogleProfiling_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiGoogleProfiling.so
#-- start of cleanup_header --------------

clean :: GaudiGoogleProfilingMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGoogleProfilingMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGoogleProfilingMergeComponentsListclean ::
#-- end of cleanup_header ---------------
