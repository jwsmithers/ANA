#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingComponentsList
#
#   Generated Mon Feb 16 20:16:26 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingComponentsList

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingComponentsList = $(GaudiProfiling_tag)_GaudiProfilingComponentsList.make
cmt_local_tagfile_GaudiProfilingComponentsList = $(bin)$(GaudiProfiling_tag)_GaudiProfilingComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingComponentsList = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingComponentsList = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingComponentsList)
#-include $(cmt_local_tagfile_GaudiProfilingComponentsList)

ifdef cmt_GaudiProfilingComponentsList_has_target_tag

cmt_final_setup_GaudiProfilingComponentsList = $(bin)setup_GaudiProfilingComponentsList.make
cmt_dependencies_in_GaudiProfilingComponentsList = $(bin)dependencies_GaudiProfilingComponentsList.in
#cmt_final_setup_GaudiProfilingComponentsList = $(bin)GaudiProfiling_GaudiProfilingComponentsListsetup.make
cmt_local_GaudiProfilingComponentsList_makefile = $(bin)GaudiProfilingComponentsList.make

else

cmt_final_setup_GaudiProfilingComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingComponentsList = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingComponentsList_makefile = $(bin)GaudiProfilingComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingComponentsList/
#GaudiProfilingComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiProfiling.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiProfiling.$(shlibsuffix)

GaudiProfilingComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiProfilingComponentsListinstall
GaudiProfilingComponentsListinstall :: GaudiProfilingComponentsList

uninstall :: GaudiProfilingComponentsListuninstall
GaudiProfilingComponentsListuninstall :: GaudiProfilingComponentsListclean

GaudiProfilingComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiProfilingComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingComponentsListclean ::
#-- end of cleanup_header ---------------
