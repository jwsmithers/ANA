#-- start of make_header -----------------

#====================================
#  Document GaudiPartPropComponentsList
#
#   Generated Mon Feb 16 19:54:36 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPartPropComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPartPropComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPartPropComponentsList

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropComponentsList = $(GaudiPartProp_tag)_GaudiPartPropComponentsList.make
cmt_local_tagfile_GaudiPartPropComponentsList = $(bin)$(GaudiPartProp_tag)_GaudiPartPropComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPartProp_tag = $(tag)

#cmt_local_tagfile_GaudiPartPropComponentsList = $(GaudiPartProp_tag).make
cmt_local_tagfile_GaudiPartPropComponentsList = $(bin)$(GaudiPartProp_tag).make

endif

include $(cmt_local_tagfile_GaudiPartPropComponentsList)
#-include $(cmt_local_tagfile_GaudiPartPropComponentsList)

ifdef cmt_GaudiPartPropComponentsList_has_target_tag

cmt_final_setup_GaudiPartPropComponentsList = $(bin)setup_GaudiPartPropComponentsList.make
cmt_dependencies_in_GaudiPartPropComponentsList = $(bin)dependencies_GaudiPartPropComponentsList.in
#cmt_final_setup_GaudiPartPropComponentsList = $(bin)GaudiPartProp_GaudiPartPropComponentsListsetup.make
cmt_local_GaudiPartPropComponentsList_makefile = $(bin)GaudiPartPropComponentsList.make

else

cmt_final_setup_GaudiPartPropComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiPartPropComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiPartPropComponentsList = $(bin)GaudiPartPropsetup.make
cmt_local_GaudiPartPropComponentsList_makefile = $(bin)GaudiPartPropComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPartPropsetup.make

#GaudiPartPropComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPartPropComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPartPropComponentsList/
#GaudiPartPropComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiPartProp.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiPartProp.$(shlibsuffix)

GaudiPartPropComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiPartPropComponentsListinstall
GaudiPartPropComponentsListinstall :: GaudiPartPropComponentsList

uninstall :: GaudiPartPropComponentsListuninstall
GaudiPartPropComponentsListuninstall :: GaudiPartPropComponentsListclean

GaudiPartPropComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiPartPropComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPartPropComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPartPropComponentsListclean ::
#-- end of cleanup_header ---------------
