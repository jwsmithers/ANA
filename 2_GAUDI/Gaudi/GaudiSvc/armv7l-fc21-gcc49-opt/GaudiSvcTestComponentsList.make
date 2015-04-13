#-- start of make_header -----------------

#====================================
#  Document GaudiSvcTestComponentsList
#
#   Generated Mon Feb 16 19:55:46 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcTestComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcTestComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcTestComponentsList

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestComponentsList = $(GaudiSvc_tag)_GaudiSvcTestComponentsList.make
cmt_local_tagfile_GaudiSvcTestComponentsList = $(bin)$(GaudiSvc_tag)_GaudiSvcTestComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcTestComponentsList = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcTestComponentsList = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcTestComponentsList)
#-include $(cmt_local_tagfile_GaudiSvcTestComponentsList)

ifdef cmt_GaudiSvcTestComponentsList_has_target_tag

cmt_final_setup_GaudiSvcTestComponentsList = $(bin)setup_GaudiSvcTestComponentsList.make
cmt_dependencies_in_GaudiSvcTestComponentsList = $(bin)dependencies_GaudiSvcTestComponentsList.in
#cmt_final_setup_GaudiSvcTestComponentsList = $(bin)GaudiSvc_GaudiSvcTestComponentsListsetup.make
cmt_local_GaudiSvcTestComponentsList_makefile = $(bin)GaudiSvcTestComponentsList.make

else

cmt_final_setup_GaudiSvcTestComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiSvcTestComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcTestComponentsList = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcTestComponentsList_makefile = $(bin)GaudiSvcTestComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcTestComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcTestComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcTestComponentsList/
#GaudiSvcTestComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiSvcTest.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiSvcTest.$(shlibsuffix)

GaudiSvcTestComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiSvcTestComponentsListinstall
GaudiSvcTestComponentsListinstall :: GaudiSvcTestComponentsList

uninstall :: GaudiSvcTestComponentsListuninstall
GaudiSvcTestComponentsListuninstall :: GaudiSvcTestComponentsListclean

GaudiSvcTestComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiSvcTestComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcTestComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcTestComponentsListclean ::
#-- end of cleanup_header ---------------
