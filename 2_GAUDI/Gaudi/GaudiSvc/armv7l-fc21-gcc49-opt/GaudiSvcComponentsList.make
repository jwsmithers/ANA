#-- start of make_header -----------------

#====================================
#  Document GaudiSvcComponentsList
#
#   Generated Mon Feb 16 19:56:39 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcComponentsList

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcComponentsList = $(GaudiSvc_tag)_GaudiSvcComponentsList.make
cmt_local_tagfile_GaudiSvcComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcComponentsList = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcComponentsList = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcComponentsList)
#-include $(cmt_local_tagfile_GaudiSvcComponentsList)

ifdef cmt_GaudiSvcComponentsList_has_target_tag

cmt_final_setup_GaudiSvcComponentsList = $(bin)setup_GaudiSvcComponentsList.make
cmt_dependencies_in_GaudiSvcComponentsList = $(bin)dependencies_GaudiSvcComponentsList.in
#cmt_final_setup_GaudiSvcComponentsList = $(bin)GaudiSvc_GaudiSvcComponentsListsetup.make
cmt_local_GaudiSvcComponentsList_makefile = $(bin)GaudiSvcComponentsList.make

else

cmt_final_setup_GaudiSvcComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiSvcComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcComponentsList = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcComponentsList_makefile = $(bin)GaudiSvcComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcComponentsList/
#GaudiSvcComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiSvc.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiSvc.$(shlibsuffix)

GaudiSvcComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiSvcComponentsListinstall
GaudiSvcComponentsListinstall :: GaudiSvcComponentsList

uninstall :: GaudiSvcComponentsListuninstall
GaudiSvcComponentsListuninstall :: GaudiSvcComponentsListclean

GaudiSvcComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiSvcComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcComponentsListclean ::
#-- end of cleanup_header ---------------
