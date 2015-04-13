#-- start of make_header -----------------

#====================================
#  Document ProjectVersionHeader
#
#   Generated Mon Feb 16 20:49:56 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ProjectVersionHeader_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ProjectVersionHeader_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ProjectVersionHeader

Gaudi_tag = $(tag)

#cmt_local_tagfile_ProjectVersionHeader = $(Gaudi_tag)_ProjectVersionHeader.make
cmt_local_tagfile_ProjectVersionHeader = $(bin)$(Gaudi_tag)_ProjectVersionHeader.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Gaudi_tag = $(tag)

#cmt_local_tagfile_ProjectVersionHeader = $(Gaudi_tag).make
cmt_local_tagfile_ProjectVersionHeader = $(bin)$(Gaudi_tag).make

endif

include $(cmt_local_tagfile_ProjectVersionHeader)
#-include $(cmt_local_tagfile_ProjectVersionHeader)

ifdef cmt_ProjectVersionHeader_has_target_tag

cmt_final_setup_ProjectVersionHeader = $(bin)setup_ProjectVersionHeader.make
cmt_dependencies_in_ProjectVersionHeader = $(bin)dependencies_ProjectVersionHeader.in
#cmt_final_setup_ProjectVersionHeader = $(bin)Gaudi_ProjectVersionHeadersetup.make
cmt_local_ProjectVersionHeader_makefile = $(bin)ProjectVersionHeader.make

else

cmt_final_setup_ProjectVersionHeader = $(bin)setup.make
cmt_dependencies_in_ProjectVersionHeader = $(bin)dependencies.in
#cmt_final_setup_ProjectVersionHeader = $(bin)Gaudisetup.make
cmt_local_ProjectVersionHeader_makefile = $(bin)ProjectVersionHeader.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Gaudisetup.make

#ProjectVersionHeader :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ProjectVersionHeader'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ProjectVersionHeader/
#ProjectVersionHeader::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(ProjectVersionHeader_deps)
command     = $(ProjectVersionHeader_command)
output      = $(ProjectVersionHeader_output)

.PHONY: ProjectVersionHeader ProjectVersionHeaderclean

ProjectVersionHeader :: $(output)

ProjectVersionHeaderclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: ProjectVersionHeaderclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ProjectVersionHeader.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ProjectVersionHeaderclean ::
#-- end of cleanup_header ---------------
