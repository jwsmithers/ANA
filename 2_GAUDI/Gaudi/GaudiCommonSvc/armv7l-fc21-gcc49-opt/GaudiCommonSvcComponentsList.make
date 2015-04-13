#-- start of make_header -----------------

#====================================
#  Document GaudiCommonSvcComponentsList
#
#   Generated Mon Feb 16 20:23:11 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCommonSvcComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCommonSvcComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCommonSvcComponentsList

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcComponentsList = $(GaudiCommonSvc_tag)_GaudiCommonSvcComponentsList.make
cmt_local_tagfile_GaudiCommonSvcComponentsList = $(bin)$(GaudiCommonSvc_tag)_GaudiCommonSvcComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCommonSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCommonSvcComponentsList = $(GaudiCommonSvc_tag).make
cmt_local_tagfile_GaudiCommonSvcComponentsList = $(bin)$(GaudiCommonSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCommonSvcComponentsList)
#-include $(cmt_local_tagfile_GaudiCommonSvcComponentsList)

ifdef cmt_GaudiCommonSvcComponentsList_has_target_tag

cmt_final_setup_GaudiCommonSvcComponentsList = $(bin)setup_GaudiCommonSvcComponentsList.make
cmt_dependencies_in_GaudiCommonSvcComponentsList = $(bin)dependencies_GaudiCommonSvcComponentsList.in
#cmt_final_setup_GaudiCommonSvcComponentsList = $(bin)GaudiCommonSvc_GaudiCommonSvcComponentsListsetup.make
cmt_local_GaudiCommonSvcComponentsList_makefile = $(bin)GaudiCommonSvcComponentsList.make

else

cmt_final_setup_GaudiCommonSvcComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiCommonSvcComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiCommonSvcComponentsList = $(bin)GaudiCommonSvcsetup.make
cmt_local_GaudiCommonSvcComponentsList_makefile = $(bin)GaudiCommonSvcComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCommonSvcsetup.make

#GaudiCommonSvcComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCommonSvcComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCommonSvcComponentsList/
#GaudiCommonSvcComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiCommonSvc.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiCommonSvc.$(shlibsuffix)

GaudiCommonSvcComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiCommonSvcComponentsListinstall
GaudiCommonSvcComponentsListinstall :: GaudiCommonSvcComponentsList

uninstall :: GaudiCommonSvcComponentsListuninstall
GaudiCommonSvcComponentsListuninstall :: GaudiCommonSvcComponentsListclean

GaudiCommonSvcComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiCommonSvcComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCommonSvcComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCommonSvcComponentsListclean ::
#-- end of cleanup_header ---------------
