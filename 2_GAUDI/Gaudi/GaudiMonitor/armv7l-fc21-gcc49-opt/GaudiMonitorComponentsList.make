#-- start of make_header -----------------

#====================================
#  Document GaudiMonitorComponentsList
#
#   Generated Mon Feb 16 19:53:00 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMonitorComponentsList_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMonitorComponentsList_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMonitorComponentsList

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorComponentsList = $(GaudiMonitor_tag)_GaudiMonitorComponentsList.make
cmt_local_tagfile_GaudiMonitorComponentsList = $(bin)$(GaudiMonitor_tag)_GaudiMonitorComponentsList.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMonitor_tag = $(tag)

#cmt_local_tagfile_GaudiMonitorComponentsList = $(GaudiMonitor_tag).make
cmt_local_tagfile_GaudiMonitorComponentsList = $(bin)$(GaudiMonitor_tag).make

endif

include $(cmt_local_tagfile_GaudiMonitorComponentsList)
#-include $(cmt_local_tagfile_GaudiMonitorComponentsList)

ifdef cmt_GaudiMonitorComponentsList_has_target_tag

cmt_final_setup_GaudiMonitorComponentsList = $(bin)setup_GaudiMonitorComponentsList.make
cmt_dependencies_in_GaudiMonitorComponentsList = $(bin)dependencies_GaudiMonitorComponentsList.in
#cmt_final_setup_GaudiMonitorComponentsList = $(bin)GaudiMonitor_GaudiMonitorComponentsListsetup.make
cmt_local_GaudiMonitorComponentsList_makefile = $(bin)GaudiMonitorComponentsList.make

else

cmt_final_setup_GaudiMonitorComponentsList = $(bin)setup.make
cmt_dependencies_in_GaudiMonitorComponentsList = $(bin)dependencies.in
#cmt_final_setup_GaudiMonitorComponentsList = $(bin)GaudiMonitorsetup.make
cmt_local_GaudiMonitorComponentsList_makefile = $(bin)GaudiMonitorComponentsList.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMonitorsetup.make

#GaudiMonitorComponentsList :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMonitorComponentsList'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMonitorComponentsList/
#GaudiMonitorComponentsList::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
##
componentslistfile = GaudiMonitor.components
COMPONENTSLIST_DIR = ../$(tag)
fulllibname = libGaudiMonitor.$(shlibsuffix)

GaudiMonitorComponentsList :: ${COMPONENTSLIST_DIR}/$(componentslistfile)
	@:

${COMPONENTSLIST_DIR}/$(componentslistfile) :: $(bin)$(fulllibname)
	@echo 'Generating componentslist file for $(fulllibname)'
	cd ../$(tag);$(listcomponents_cmd) --output ${COMPONENTSLIST_DIR}/$(componentslistfile) $(fulllibname)

install :: GaudiMonitorComponentsListinstall
GaudiMonitorComponentsListinstall :: GaudiMonitorComponentsList

uninstall :: GaudiMonitorComponentsListuninstall
GaudiMonitorComponentsListuninstall :: GaudiMonitorComponentsListclean

GaudiMonitorComponentsListclean ::
	@echo 'Deleting $(componentslistfile)'
	@rm -f ${COMPONENTSLIST_DIR}/$(componentslistfile)

#-- start of cleanup_header --------------

clean :: GaudiMonitorComponentsListclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMonitorComponentsList.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMonitorComponentsListclean ::
#-- end of cleanup_header ---------------
