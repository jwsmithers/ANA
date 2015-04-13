#-- start of make_header -----------------

#====================================
#  Document GaudiAlgMergeComponentsList
#
#   Generated Mon Feb 16 20:05:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlgMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlgMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlgMergeComponentsList

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgMergeComponentsList = $(GaudiAlg_tag)_GaudiAlgMergeComponentsList.make
cmt_local_tagfile_GaudiAlgMergeComponentsList = $(bin)$(GaudiAlg_tag)_GaudiAlgMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgMergeComponentsList = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlgMergeComponentsList = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlgMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiAlgMergeComponentsList)

ifdef cmt_GaudiAlgMergeComponentsList_has_target_tag

cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)setup_GaudiAlgMergeComponentsList.make
cmt_dependencies_in_GaudiAlgMergeComponentsList = $(bin)dependencies_GaudiAlgMergeComponentsList.in
#cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)GaudiAlg_GaudiAlgMergeComponentsListsetup.make
cmt_local_GaudiAlgMergeComponentsList_makefile = $(bin)GaudiAlgMergeComponentsList.make

else

cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiAlgMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiAlgMergeComponentsList = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlgMergeComponentsList_makefile = $(bin)GaudiAlgMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlgMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlgMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlgMergeComponentsList/
#GaudiAlgMergeComponentsList::
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


.PHONY: GaudiAlgMergeComponentsList GaudiAlgMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiAlg.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiAlgMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiAlgMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiAlgMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiAlg_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAlg.so
#-- start of cleanup_header --------------

clean :: GaudiAlgMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlgMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgMergeComponentsListclean ::
#-- end of cleanup_header ---------------
