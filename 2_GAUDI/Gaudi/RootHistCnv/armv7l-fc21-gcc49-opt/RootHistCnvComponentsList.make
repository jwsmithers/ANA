#-- start of make_header -----------------

#====================================
#  Document RootHistCnvComponentsList
#
#   Generated Mon Feb 16 19:54:05 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootHistCnvComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootHistCnvComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootHistCnvComponentsList

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvComponentsList = $(RootHistCnv_tag)_RootHistCnvComponentsList.make
cmt_local_tagfile_RootHistCnvComponentsList = $(bin)$(RootHistCnv_tag)_RootHistCnvComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootHistCnv_tag = $(tag)

#cmt_local_tagfile_RootHistCnvComponentsList = $(RootHistCnv_tag).make
cmt_local_tagfile_RootHistCnvComponentsList = $(bin)$(RootHistCnv_tag).make

endif

include $(cmt_local_tagfile_RootHistCnvComponentsList)
#-include $(cmt_local_tagfile_RootHistCnvComponentsList)

ifdef cmt_RootHistCnvComponentsList_has_target_tag

cmt_final_setup_RootHistCnvComponentsList = $(bin)setup_RootHistCnvComponentsList.make
cmt_dependencies_in_RootHistCnvComponentsList = $(bin)dependencies_RootHistCnvComponentsList.in
#cmt_final_setup_RootHistCnvComponentsList = $(bin)RootHistCnv_RootHistCnvComponentsListsetup.make
cmt_local_RootHistCnvComponentsList_makefile = $(bin)RootHistCnvComponentsList.make

else

cmt_final_setup_RootHistCnvComponentsList = $(bin)setup.make
cmt_dependencies_in_RootHistCnvComponentsList = $(bin)dependencies.in
#cmt_final_setup_RootHistCnvComponentsList = $(bin)RootHistCnvsetup.make
cmt_local_RootHistCnvComponentsList_makefile = $(bin)RootHistCnvComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootHistCnvsetup.make

#RootHistCnvComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootHistCnvComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootHistCnvComponentsList/
#RootHistCnvComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = RootHistCnv.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libRootHistCnv.$(shlibsuffix)

RootHistCnvComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: RootHistCnvComponentsListinstall
RootHistCnvComponentsListinstall :: RootHistCnvComponentsList

uninstall :: RootHistCnvComponentsListuninstall
RootHistCnvComponentsListuninstall :: RootHistCnvComponentsListclean

RootHistCnvComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: RootHistCnvComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootHistCnvComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootHistCnvComponentsListclean ::
#-- end of cleanup_header ---------------
