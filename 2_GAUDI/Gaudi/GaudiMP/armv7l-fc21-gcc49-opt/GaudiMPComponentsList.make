#-- start of make_header -----------------

#====================================
#  Document GaudiMPComponentsList
#
#   Generated Mon Feb 16 20:49:52 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPComponentsList

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPComponentsList = $(GaudiMP_tag)_GaudiMPComponentsList.make
cmt_local_tagfile_GaudiMPComponentsList = $(bin)$(GaudiMP_tag)_GaudiMPComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPComponentsList = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPComponentsList = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPComponentsList)
#-include $(cmt_local_tagfile_GaudiMPComponentsList)

ifdef cmt_GaudiMPComponentsList_has_target_tag

cmt_final_setup_GaudiMPComponentsList = $(bin)setup_GaudiMPComponentsList.make
cmt_dependencies_in_GaudiMPComponentsList = $(bin)dependencies_GaudiMPComponentsList.in
#cmt_final_setup_GaudiMPComponentsList = $(bin)GaudiMP_GaudiMPComponentsListsetup.make
cmt_local_GaudiMPComponentsList_makefile = $(bin)GaudiMPComponentsList.make

else

cmt_final_setup_GaudiMPComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiMPComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiMPComponentsList = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPComponentsList_makefile = $(bin)GaudiMPComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPComponentsList/
#GaudiMPComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiMP.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiMP.$(shlibsuffix)

GaudiMPComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiMPComponentsListinstall
GaudiMPComponentsListinstall :: GaudiMPComponentsList

uninstall :: GaudiMPComponentsListuninstall
GaudiMPComponentsListuninstall :: GaudiMPComponentsListclean

GaudiMPComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiMPComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPComponentsListclean ::
#-- end of cleanup_header ---------------
