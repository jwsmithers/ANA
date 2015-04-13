#-- start of make_header -----------------

#====================================
#  Document GaudiUtilsComponentsList
#
#   Generated Mon Feb 16 20:00:05 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtilsComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtilsComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtilsComponentsList

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsComponentsList = $(GaudiUtils_tag)_GaudiUtilsComponentsList.make
cmt_local_tagfile_GaudiUtilsComponentsList = $(bin)$(GaudiUtils_tag)_GaudiUtilsComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsComponentsList = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtilsComponentsList = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtilsComponentsList)
#-include $(cmt_local_tagfile_GaudiUtilsComponentsList)

ifdef cmt_GaudiUtilsComponentsList_has_target_tag

cmt_final_setup_GaudiUtilsComponentsList = $(bin)setup_GaudiUtilsComponentsList.make
cmt_dependencies_in_GaudiUtilsComponentsList = $(bin)dependencies_GaudiUtilsComponentsList.in
#cmt_final_setup_GaudiUtilsComponentsList = $(bin)GaudiUtils_GaudiUtilsComponentsListsetup.make
cmt_local_GaudiUtilsComponentsList_makefile = $(bin)GaudiUtilsComponentsList.make

else

cmt_final_setup_GaudiUtilsComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiUtilsComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiUtilsComponentsList = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtilsComponentsList_makefile = $(bin)GaudiUtilsComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtilsComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtilsComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtilsComponentsList/
#GaudiUtilsComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiUtils.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiUtils.$(shlibsuffix)

GaudiUtilsComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiUtilsComponentsListinstall
GaudiUtilsComponentsListinstall :: GaudiUtilsComponentsList

uninstall :: GaudiUtilsComponentsListuninstall
GaudiUtilsComponentsListuninstall :: GaudiUtilsComponentsListclean

GaudiUtilsComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiUtilsComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtilsComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsComponentsListclean ::
#-- end of cleanup_header ---------------
