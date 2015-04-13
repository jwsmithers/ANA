#-- start of make_header -----------------

#====================================
#  Document GaudiAlgComponentsList
#
#   Generated Mon Feb 16 20:05:06 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiAlgComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiAlgComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiAlgComponentsList

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgComponentsList = $(GaudiAlg_tag)_GaudiAlgComponentsList.make
cmt_local_tagfile_GaudiAlgComponentsList = $(bin)$(GaudiAlg_tag)_GaudiAlgComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiAlg_tag = $(tag)

#cmt_local_tagfile_GaudiAlgComponentsList = $(GaudiAlg_tag).make
cmt_local_tagfile_GaudiAlgComponentsList = $(bin)$(GaudiAlg_tag).make

endif

include $(cmt_local_tagfile_GaudiAlgComponentsList)
#-include $(cmt_local_tagfile_GaudiAlgComponentsList)

ifdef cmt_GaudiAlgComponentsList_has_target_tag

cmt_final_setup_GaudiAlgComponentsList = $(bin)setup_GaudiAlgComponentsList.make
cmt_dependencies_in_GaudiAlgComponentsList = $(bin)dependencies_GaudiAlgComponentsList.in
#cmt_final_setup_GaudiAlgComponentsList = $(bin)GaudiAlg_GaudiAlgComponentsListsetup.make
cmt_local_GaudiAlgComponentsList_makefile = $(bin)GaudiAlgComponentsList.make

else

cmt_final_setup_GaudiAlgComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiAlgComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiAlgComponentsList = $(bin)GaudiAlgsetup.make
cmt_local_GaudiAlgComponentsList_makefile = $(bin)GaudiAlgComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiAlgsetup.make

#GaudiAlgComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiAlgComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiAlgComponentsList/
#GaudiAlgComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiAlg.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiAlg.$(shlibsuffix)

GaudiAlgComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiAlgComponentsListinstall
GaudiAlgComponentsListinstall :: GaudiAlgComponentsList

uninstall :: GaudiAlgComponentsListuninstall
GaudiAlgComponentsListuninstall :: GaudiAlgComponentsListclean

GaudiAlgComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiAlgComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiAlgComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiAlgComponentsListclean ::
#-- end of cleanup_header ---------------
