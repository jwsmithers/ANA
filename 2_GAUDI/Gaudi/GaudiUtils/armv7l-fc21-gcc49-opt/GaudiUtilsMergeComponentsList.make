#-- start of make_header -----------------

#====================================
#  Document GaudiUtilsMergeComponentsList
#
#   Generated Mon Feb 16 20:00:05 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtilsMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtilsMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtilsMergeComponentsList

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(GaudiUtils_tag)_GaudiUtilsMergeComponentsList.make
cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(bin)$(GaudiUtils_tag)_GaudiUtilsMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtilsMergeComponentsList = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtilsMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiUtilsMergeComponentsList)

ifdef cmt_GaudiUtilsMergeComponentsList_has_target_tag

cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)setup_GaudiUtilsMergeComponentsList.make
cmt_dependencies_in_GaudiUtilsMergeComponentsList = $(bin)dependencies_GaudiUtilsMergeComponentsList.in
#cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)GaudiUtils_GaudiUtilsMergeComponentsListsetup.make
cmt_local_GaudiUtilsMergeComponentsList_makefile = $(bin)GaudiUtilsMergeComponentsList.make

else

cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiUtilsMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiUtilsMergeComponentsList = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtilsMergeComponentsList_makefile = $(bin)GaudiUtilsMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtilsMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtilsMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtilsMergeComponentsList/
#GaudiUtilsMergeComponentsList::
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


.PHONY: GaudiUtilsMergeComponentsList GaudiUtilsMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiUtils.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiUtilsMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiUtilsMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiUtilsMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiUtils_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiUtils.so
#-- start of cleanup_header --------------

clean :: GaudiUtilsMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtilsMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsMergeComponentsListclean ::
#-- end of cleanup_header ---------------
