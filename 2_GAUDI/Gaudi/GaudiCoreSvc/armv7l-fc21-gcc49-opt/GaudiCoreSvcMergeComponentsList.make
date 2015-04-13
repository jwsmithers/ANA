#-- start of make_header -----------------

#====================================
#  Document GaudiCoreSvcMergeComponentsList
#
#   Generated Mon Feb 16 19:51:49 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvcMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvcMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvcMergeComponentsList

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(GaudiCoreSvc_tag)_GaudiCoreSvcMergeComponentsList.make
cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvcMergeComponentsList = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvcMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiCoreSvcMergeComponentsList)

ifdef cmt_GaudiCoreSvcMergeComponentsList_has_target_tag

cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)setup_GaudiCoreSvcMergeComponentsList.make
cmt_dependencies_in_GaudiCoreSvcMergeComponentsList = $(bin)dependencies_GaudiCoreSvcMergeComponentsList.in
#cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)GaudiCoreSvc_GaudiCoreSvcMergeComponentsListsetup.make
cmt_local_GaudiCoreSvcMergeComponentsList_makefile = $(bin)GaudiCoreSvcMergeComponentsList.make

else

cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvcMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvcMergeComponentsList = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvcMergeComponentsList_makefile = $(bin)GaudiCoreSvcMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvcMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvcMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvcMergeComponentsList/
#GaudiCoreSvcMergeComponentsList::
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


.PHONY: GaudiCoreSvcMergeComponentsList GaudiCoreSvcMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiCoreSvc.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiCoreSvcMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiCoreSvcMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiCoreSvcMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiCoreSvc_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiCoreSvc.so
#-- start of cleanup_header --------------

clean :: GaudiCoreSvcMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvcMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvcMergeComponentsListclean ::
#-- end of cleanup_header ---------------
