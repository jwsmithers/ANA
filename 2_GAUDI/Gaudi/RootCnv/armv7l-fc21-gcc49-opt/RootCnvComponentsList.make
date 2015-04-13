#-- start of make_header -----------------

#====================================
#  Document RootCnvComponentsList
#
#   Generated Mon Feb 16 20:01:19 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvComponentsList

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvComponentsList = $(RootCnv_tag)_RootCnvComponentsList.make
cmt_local_tagfile_RootCnvComponentsList = $(bin)$(RootCnv_tag)_RootCnvComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvComponentsList = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvComponentsList = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvComponentsList)
#-include $(cmt_local_tagfile_RootCnvComponentsList)

ifdef cmt_RootCnvComponentsList_has_target_tag

cmt_final_setup_RootCnvComponentsList = $(bin)setup_RootCnvComponentsList.make
cmt_dependencies_in_RootCnvComponentsList = $(bin)dependencies_RootCnvComponentsList.in
#cmt_final_setup_RootCnvComponentsList = $(bin)RootCnv_RootCnvComponentsListsetup.make
cmt_local_RootCnvComponentsList_makefile = $(bin)RootCnvComponentsList.make

else

cmt_final_setup_RootCnvComponentsList = $(bin)setup.make
cmt_dependencies_in_RootCnvComponentsList = $(bin)dependencies.in
#cmt_final_setup_RootCnvComponentsList = $(bin)RootCnvsetup.make
cmt_local_RootCnvComponentsList_makefile = $(bin)RootCnvComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvComponentsList/
#RootCnvComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = RootCnv.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libRootCnv.$(shlibsuffix)

RootCnvComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: RootCnvComponentsListinstall
RootCnvComponentsListinstall :: RootCnvComponentsList

uninstall :: RootCnvComponentsListuninstall
RootCnvComponentsListuninstall :: RootCnvComponentsListclean

RootCnvComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: RootCnvComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvComponentsListclean ::
#-- end of cleanup_header ---------------
