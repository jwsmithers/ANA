#-- start of make_header -----------------

#====================================
#  Document PartPropSvcComponentsList
#
#   Generated Mon Feb 16 19:52:21 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PartPropSvcComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PartPropSvcComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PartPropSvcComponentsList

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcComponentsList = $(PartPropSvc_tag)_PartPropSvcComponentsList.make
cmt_local_tagfile_PartPropSvcComponentsList = $(bin)$(PartPropSvc_tag)_PartPropSvcComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PartPropSvc_tag = $(tag)

#cmt_local_tagfile_PartPropSvcComponentsList = $(PartPropSvc_tag).make
cmt_local_tagfile_PartPropSvcComponentsList = $(bin)$(PartPropSvc_tag).make

endif

include $(cmt_local_tagfile_PartPropSvcComponentsList)
#-include $(cmt_local_tagfile_PartPropSvcComponentsList)

ifdef cmt_PartPropSvcComponentsList_has_target_tag

cmt_final_setup_PartPropSvcComponentsList = $(bin)setup_PartPropSvcComponentsList.make
cmt_dependencies_in_PartPropSvcComponentsList = $(bin)dependencies_PartPropSvcComponentsList.in
#cmt_final_setup_PartPropSvcComponentsList = $(bin)PartPropSvc_PartPropSvcComponentsListsetup.make
cmt_local_PartPropSvcComponentsList_makefile = $(bin)PartPropSvcComponentsList.make

else

cmt_final_setup_PartPropSvcComponentsList = $(bin)setup.make
cmt_dependencies_in_PartPropSvcComponentsList = $(bin)dependencies.in
#cmt_final_setup_PartPropSvcComponentsList = $(bin)PartPropSvcsetup.make
cmt_local_PartPropSvcComponentsList_makefile = $(bin)PartPropSvcComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PartPropSvcsetup.make

#PartPropSvcComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PartPropSvcComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PartPropSvcComponentsList/
#PartPropSvcComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = PartPropSvc.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libPartPropSvc.$(shlibsuffix)

PartPropSvcComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: PartPropSvcComponentsListinstall
PartPropSvcComponentsListinstall :: PartPropSvcComponentsList

uninstall :: PartPropSvcComponentsListuninstall
PartPropSvcComponentsListuninstall :: PartPropSvcComponentsListclean

PartPropSvcComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: PartPropSvcComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PartPropSvcComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PartPropSvcComponentsListclean ::
#-- end of cleanup_header ---------------
