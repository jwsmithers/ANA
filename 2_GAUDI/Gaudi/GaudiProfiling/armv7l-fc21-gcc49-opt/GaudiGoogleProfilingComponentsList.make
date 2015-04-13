#-- start of make_header -----------------

#====================================
#  Document GaudiGoogleProfilingComponentsList
#
#   Generated Mon Feb 16 20:16:07 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGoogleProfilingComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGoogleProfilingComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGoogleProfilingComponentsList

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(GaudiProfiling_tag)_GaudiGoogleProfilingComponentsList.make
cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiGoogleProfilingComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiGoogleProfilingComponentsList = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiGoogleProfilingComponentsList)
#-include $(cmt_local_tagfile_GaudiGoogleProfilingComponentsList)

ifdef cmt_GaudiGoogleProfilingComponentsList_has_target_tag

cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)setup_GaudiGoogleProfilingComponentsList.make
cmt_dependencies_in_GaudiGoogleProfilingComponentsList = $(bin)dependencies_GaudiGoogleProfilingComponentsList.in
#cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)GaudiProfiling_GaudiGoogleProfilingComponentsListsetup.make
cmt_local_GaudiGoogleProfilingComponentsList_makefile = $(bin)GaudiGoogleProfilingComponentsList.make

else

cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiGoogleProfilingComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiGoogleProfilingComponentsList = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiGoogleProfilingComponentsList_makefile = $(bin)GaudiGoogleProfilingComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiGoogleProfilingComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGoogleProfilingComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGoogleProfilingComponentsList/
#GaudiGoogleProfilingComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiGoogleProfiling.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiGoogleProfiling.$(shlibsuffix)

GaudiGoogleProfilingComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiGoogleProfilingComponentsListinstall
GaudiGoogleProfilingComponentsListinstall :: GaudiGoogleProfilingComponentsList

uninstall :: GaudiGoogleProfilingComponentsListuninstall
GaudiGoogleProfilingComponentsListuninstall :: GaudiGoogleProfilingComponentsListclean

GaudiGoogleProfilingComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiGoogleProfilingComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGoogleProfilingComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGoogleProfilingComponentsListclean ::
#-- end of cleanup_header ---------------
