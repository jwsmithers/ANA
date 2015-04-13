#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesGenConfUser
#
#   Generated Mon Feb 16 20:50:01 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiExamplesGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesGenConfUser

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesGenConfUser = $(GaudiExamples_tag)_GaudiExamplesGenConfUser.make
cmt_local_tagfile_GaudiExamplesGenConfUser = $(bin)$(GaudiExamples_tag)_GaudiExamplesGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesGenConfUser = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesGenConfUser = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesGenConfUser)
#-include $(cmt_local_tagfile_GaudiExamplesGenConfUser)

ifdef cmt_GaudiExamplesGenConfUser_has_target_tag

cmt_final_setup_GaudiExamplesGenConfUser = $(bin)setup_GaudiExamplesGenConfUser.make
cmt_dependencies_in_GaudiExamplesGenConfUser = $(bin)dependencies_GaudiExamplesGenConfUser.in
#cmt_final_setup_GaudiExamplesGenConfUser = $(bin)GaudiExamples_GaudiExamplesGenConfUsersetup.make
cmt_local_GaudiExamplesGenConfUser_makefile = $(bin)GaudiExamplesGenConfUser.make

else

cmt_final_setup_GaudiExamplesGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesGenConfUser = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesGenConfUser_makefile = $(bin)GaudiExamplesGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesGenConfUser/
#GaudiExamplesGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiExamplesGenConfUser_deps)
command     = $(GaudiExamplesGenConfUser_command)
output      = $(GaudiExamplesGenConfUser_output)

.PHONY: GaudiExamplesGenConfUser GaudiExamplesGenConfUserclean

GaudiExamplesGenConfUser :: $(output)

GaudiExamplesGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiExamplesGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesGenConfUserclean ::
#-- end of cleanup_header ---------------
