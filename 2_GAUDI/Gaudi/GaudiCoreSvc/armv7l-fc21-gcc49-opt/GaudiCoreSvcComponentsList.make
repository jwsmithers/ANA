#-- start of make_header -----------------

#====================================
#  Document GaudiCoreSvcComponentsList
#
#   Generated Mon Feb 16 19:51:47 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiCoreSvcComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiCoreSvcComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiCoreSvcComponentsList

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcComponentsList = $(GaudiCoreSvc_tag)_GaudiCoreSvcComponentsList.make
cmt_local_tagfile_GaudiCoreSvcComponentsList = $(bin)$(GaudiCoreSvc_tag)_GaudiCoreSvcComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_GaudiCoreSvcComponentsList = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_GaudiCoreSvcComponentsList = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiCoreSvcComponentsList)
#-include $(cmt_local_tagfile_GaudiCoreSvcComponentsList)

ifdef cmt_GaudiCoreSvcComponentsList_has_target_tag

cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)setup_GaudiCoreSvcComponentsList.make
cmt_dependencies_in_GaudiCoreSvcComponentsList = $(bin)dependencies_GaudiCoreSvcComponentsList.in
#cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)GaudiCoreSvc_GaudiCoreSvcComponentsListsetup.make
cmt_local_GaudiCoreSvcComponentsList_makefile = $(bin)GaudiCoreSvcComponentsList.make

else

cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiCoreSvcComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiCoreSvcComponentsList = $(bin)GaudiCoreSvcsetup.make
cmt_local_GaudiCoreSvcComponentsList_makefile = $(bin)GaudiCoreSvcComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#GaudiCoreSvcComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiCoreSvcComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiCoreSvcComponentsList/
#GaudiCoreSvcComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiCoreSvc.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiCoreSvc.$(shlibsuffix)

GaudiCoreSvcComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiCoreSvcComponentsListinstall
GaudiCoreSvcComponentsListinstall :: GaudiCoreSvcComponentsList

uninstall :: GaudiCoreSvcComponentsListuninstall
GaudiCoreSvcComponentsListuninstall :: GaudiCoreSvcComponentsListclean

GaudiCoreSvcComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiCoreSvcComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiCoreSvcComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiCoreSvcComponentsListclean ::
#-- end of cleanup_header ---------------
