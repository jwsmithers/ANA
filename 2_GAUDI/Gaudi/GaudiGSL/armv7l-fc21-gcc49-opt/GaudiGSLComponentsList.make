#-- start of make_header -----------------

#====================================
#  Document GaudiGSLComponentsList
#
#   Generated Mon Feb 16 20:18:42 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLComponentsList

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLComponentsList = $(GaudiGSL_tag)_GaudiGSLComponentsList.make
cmt_local_tagfile_GaudiGSLComponentsList = $(bin)$(GaudiGSL_tag)_GaudiGSLComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLComponentsList = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLComponentsList = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLComponentsList)
#-include $(cmt_local_tagfile_GaudiGSLComponentsList)

ifdef cmt_GaudiGSLComponentsList_has_target_tag

cmt_final_setup_GaudiGSLComponentsList = $(bin)setup_GaudiGSLComponentsList.make
cmt_dependencies_in_GaudiGSLComponentsList = $(bin)dependencies_GaudiGSLComponentsList.in
#cmt_final_setup_GaudiGSLComponentsList = $(bin)GaudiGSL_GaudiGSLComponentsListsetup.make
cmt_local_GaudiGSLComponentsList_makefile = $(bin)GaudiGSLComponentsList.make

else

cmt_final_setup_GaudiGSLComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiGSLComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLComponentsList = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLComponentsList_makefile = $(bin)GaudiGSLComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLComponentsList/
#GaudiGSLComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiGSL.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiGSL.$(shlibsuffix)

GaudiGSLComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiGSLComponentsListinstall
GaudiGSLComponentsListinstall :: GaudiGSLComponentsList

uninstall :: GaudiGSLComponentsListuninstall
GaudiGSLComponentsListuninstall :: GaudiGSLComponentsListclean

GaudiGSLComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiGSLComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLComponentsListclean ::
#-- end of cleanup_header ---------------
