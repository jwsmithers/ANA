#-- start of make_header -----------------

#====================================
#  Document GaudiAudMergeComponentsList
#
#   Generated Mon Feb 16 20:19:41 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAudMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAudMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAudMergeComponentsList

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudMergeComponentsList = $(GaudiAud_tag)_GaudiAudMergeComponentsList.make
cmt_local_tagfile_GaudiAudMergeComponentsList = $(bin)$(GaudiAud_tag)_GaudiAudMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAud_tag = $(tag)

#cmt_local_tagfile_GaudiAudMergeComponentsList = $(GaudiAud_tag).make
cmt_local_tagfile_GaudiAudMergeComponentsList = $(bin)$(GaudiAud_tag).make

endif

include $(cmt_local_tagfile_GaudiAudMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiAudMergeComponentsList)

ifdef cmt_GaudiAudMergeComponentsList_has_target_tag

cmt_final_setup_GaudiAudMergeComponentsList = $(bin)setup_GaudiAudMergeComponentsList.make
cmt_dependencies_in_GaudiAudMergeComponentsList = $(bin)dependencies_GaudiAudMergeComponentsList.in
#cmt_final_setup_GaudiAudMergeComponentsList = $(bin)GaudiAud_GaudiAudMergeComponentsListsetup.make
cmt_local_GaudiAudMergeComponentsList_makefile = $(bin)GaudiAudMergeComponentsList.make

else

cmt_final_setup_GaudiAudMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiAudMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiAudMergeComponentsList = $(bin)GaudiAudsetup.make
cmt_local_GaudiAudMergeComponentsList_makefile = $(bin)GaudiAudMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAudsetup.make

#GaudiAudMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAudMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAudMergeComponentsList/
#GaudiAudMergeComponentsList::
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


.PHONY: GaudiAudMergeComponentsList GaudiAudMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiAud.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiAudMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiAudMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiAudMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiAud_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiAud.so
#-- start of cleanup_header --------------

clean :: GaudiAudMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAudMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAudMergeComponentsListclean ::
#-- end of cleanup_header ---------------
