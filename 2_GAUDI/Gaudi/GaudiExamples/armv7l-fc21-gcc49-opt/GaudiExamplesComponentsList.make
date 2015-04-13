#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesComponentsList
#
#   Generated Mon Feb 16 20:58:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesComponentsList

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesComponentsList = $(GaudiExamples_tag)_GaudiExamplesComponentsList.make
cmt_local_tagfile_GaudiExamplesComponentsList = $(bin)$(GaudiExamples_tag)_GaudiExamplesComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesComponentsList = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesComponentsList = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesComponentsList)
#-include $(cmt_local_tagfile_GaudiExamplesComponentsList)

ifdef cmt_GaudiExamplesComponentsList_has_target_tag

cmt_final_setup_GaudiExamplesComponentsList = $(bin)setup_GaudiExamplesComponentsList.make
cmt_dependencies_in_GaudiExamplesComponentsList = $(bin)dependencies_GaudiExamplesComponentsList.in
#cmt_final_setup_GaudiExamplesComponentsList = $(bin)GaudiExamples_GaudiExamplesComponentsListsetup.make
cmt_local_GaudiExamplesComponentsList_makefile = $(bin)GaudiExamplesComponentsList.make

else

cmt_final_setup_GaudiExamplesComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesComponentsList = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesComponentsList_makefile = $(bin)GaudiExamplesComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesComponentsList/
#GaudiExamplesComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiExamples.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiExamples.$(shlibsuffix)

GaudiExamplesComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiExamplesComponentsListinstall
GaudiExamplesComponentsListinstall :: GaudiExamplesComponentsList

uninstall :: GaudiExamplesComponentsListuninstall
GaudiExamplesComponentsListuninstall :: GaudiExamplesComponentsListclean

GaudiExamplesComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiExamplesComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesComponentsListclean ::
#-- end of cleanup_header ---------------
