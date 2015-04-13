#-- start of make_header -----------------

#====================================
#  Document GaudiPythonComponentsList
#
#   Generated Mon Feb 16 20:24:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonComponentsList

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonComponentsList = $(GaudiPython_tag)_GaudiPythonComponentsList.make
cmt_local_tagfile_GaudiPythonComponentsList = $(bin)$(GaudiPython_tag)_GaudiPythonComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonComponentsList = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonComponentsList = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonComponentsList)
#-include $(cmt_local_tagfile_GaudiPythonComponentsList)

ifdef cmt_GaudiPythonComponentsList_has_target_tag

cmt_final_setup_GaudiPythonComponentsList = $(bin)setup_GaudiPythonComponentsList.make
cmt_dependencies_in_GaudiPythonComponentsList = $(bin)dependencies_GaudiPythonComponentsList.in
#cmt_final_setup_GaudiPythonComponentsList = $(bin)GaudiPython_GaudiPythonComponentsListsetup.make
cmt_local_GaudiPythonComponentsList_makefile = $(bin)GaudiPythonComponentsList.make

else

cmt_final_setup_GaudiPythonComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiPythonComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonComponentsList = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonComponentsList_makefile = $(bin)GaudiPythonComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonComponentsList/
#GaudiPythonComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiPython.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiPython.$(shlibsuffix)

GaudiPythonComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiPythonComponentsListinstall
GaudiPythonComponentsListinstall :: GaudiPythonComponentsList

uninstall :: GaudiPythonComponentsListuninstall
GaudiPythonComponentsListuninstall :: GaudiPythonComponentsListclean

GaudiPythonComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiPythonComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonComponentsListclean ::
#-- end of cleanup_header ---------------
