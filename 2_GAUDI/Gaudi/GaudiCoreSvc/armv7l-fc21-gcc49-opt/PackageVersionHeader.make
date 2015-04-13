#-- start of make_header -----------------

#====================================
#  Document PackageVersionHeader
#
#   Generated Mon Feb 16 19:46:43 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_PackageVersionHeader_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_PackageVersionHeader_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_PackageVersionHeader

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_PackageVersionHeader = $(GaudiCoreSvc_tag)_PackageVersionHeader.make
cmt_local_tagfile_PackageVersionHeader = $(bin)$(GaudiCoreSvc_tag)_PackageVersionHeader.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiCoreSvc_tag = $(tag)

#cmt_local_tagfile_PackageVersionHeader = $(GaudiCoreSvc_tag).make
cmt_local_tagfile_PackageVersionHeader = $(bin)$(GaudiCoreSvc_tag).make

endif

include $(cmt_local_tagfile_PackageVersionHeader)
#-include $(cmt_local_tagfile_PackageVersionHeader)

ifdef cmt_PackageVersionHeader_has_target_tag

cmt_final_setup_PackageVersionHeader = $(bin)setup_PackageVersionHeader.make
cmt_dependencies_in_PackageVersionHeader = $(bin)dependencies_PackageVersionHeader.in
#cmt_final_setup_PackageVersionHeader = $(bin)GaudiCoreSvc_PackageVersionHeadersetup.make
cmt_local_PackageVersionHeader_makefile = $(bin)PackageVersionHeader.make

else

cmt_final_setup_PackageVersionHeader = $(bin)setup.make
cmt_dependencies_in_PackageVersionHeader = $(bin)dependencies.in
#cmt_final_setup_PackageVersionHeader = $(bin)GaudiCoreSvcsetup.make
cmt_local_PackageVersionHeader_makefile = $(bin)PackageVersionHeader.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiCoreSvcsetup.make

#PackageVersionHeader :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'PackageVersionHeader'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = PackageVersionHeader/
#PackageVersionHeader::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(PackageVersionHeader_deps)
command     = $(PackageVersionHeader_command)
output      = $(PackageVersionHeader_output)

.PHONY: PackageVersionHeader PackageVersionHeaderclean

PackageVersionHeader :: $(output)

PackageVersionHeaderclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: PackageVersionHeaderclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(PackageVersionHeader.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

PackageVersionHeaderclean ::
#-- end of cleanup_header ---------------
