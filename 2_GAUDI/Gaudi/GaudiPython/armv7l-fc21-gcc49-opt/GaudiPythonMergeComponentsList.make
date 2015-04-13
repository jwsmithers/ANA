#-- start of make_header -----------------

#====================================
#  Document GaudiPythonMergeComponentsList
#
#   Generated Mon Feb 16 20:24:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonMergeComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonMergeComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonMergeComponentsList

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonMergeComponentsList = $(GaudiPython_tag)_GaudiPythonMergeComponentsList.make
cmt_local_tagfile_GaudiPythonMergeComponentsList = $(bin)$(GaudiPython_tag)_GaudiPythonMergeComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonMergeComponentsList = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonMergeComponentsList = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonMergeComponentsList)
#-include $(cmt_local_tagfile_GaudiPythonMergeComponentsList)

ifdef cmt_GaudiPythonMergeComponentsList_has_target_tag

cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)setup_GaudiPythonMergeComponentsList.make
cmt_dependencies_in_GaudiPythonMergeComponentsList = $(bin)dependencies_GaudiPythonMergeComponentsList.in
#cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)GaudiPython_GaudiPythonMergeComponentsListsetup.make
cmt_local_GaudiPythonMergeComponentsList_makefile = $(bin)GaudiPythonMergeComponentsList.make

else

cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiPythonMergeComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonMergeComponentsList = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonMergeComponentsList_makefile = $(bin)GaudiPythonMergeComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonMergeComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonMergeComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonMergeComponentsList/
#GaudiPythonMergeComponentsList::
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


.PHONY: GaudiPythonMergeComponentsList GaudiPythonMergeComponentsListclean

# default is already '#'
#genmap_comment_char := "'#'"

componentsListRef    := ../$(tag)/GaudiPython.components

ifdef CMTINSTALLAREA
componentsListDir    := ${CMTINSTALLAREA}/$(tag)/lib
mergedComponentsList := $(componentsListDir)/$(project).components
stampComponentsList  := $(componentsListRef).stamp
else
componentsListDir    := ../$(tag)
mergedComponentsList :=
stampComponentsList  :=
endif

GaudiPythonMergeComponentsList :: $(stampComponentsList) $(mergedComponentsList)
	@:

.NOTPARALLEL : $(stampComponentsList) $(mergedComponentsList)

$(stampComponentsList) $(mergedComponentsList) :: $(componentsListRef)
	@echo "Running merge_componentslist  GaudiPythonMergeComponentsList"
	$(merge_componentslist_cmd) --do-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList)

GaudiPythonMergeComponentsListclean ::
	$(cleanup_silent) $(merge_componentslist_cmd) --un-merge \
         --input-file $(componentsListRef) --merged-file $(mergedComponentsList) ;
	$(cleanup_silent) $(remove_command) $(stampComponentsList)
libGaudiPython_so_dependencies = ../armv7l-fc21-gcc49-opt/libGaudiPython.so
#-- start of cleanup_header --------------

clean :: GaudiPythonMergeComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonMergeComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonMergeComponentsListclean ::
#-- end of cleanup_header ---------------
