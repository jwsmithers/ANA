#-- start of make_header -----------------

#====================================
#  Document GaudiSvcGenConfUser
#
#   Generated Mon Feb 16 19:54:40 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiSvcGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiSvcGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiSvcGenConfUser

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcGenConfUser = $(GaudiSvc_tag)_GaudiSvcGenConfUser.make
cmt_local_tagfile_GaudiSvcGenConfUser = $(bin)$(GaudiSvc_tag)_GaudiSvcGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiSvc_tag = $(tag)

#cmt_local_tagfile_GaudiSvcGenConfUser = $(GaudiSvc_tag).make
cmt_local_tagfile_GaudiSvcGenConfUser = $(bin)$(GaudiSvc_tag).make

endif

include $(cmt_local_tagfile_GaudiSvcGenConfUser)
#-include $(cmt_local_tagfile_GaudiSvcGenConfUser)

ifdef cmt_GaudiSvcGenConfUser_has_target_tag

cmt_final_setup_GaudiSvcGenConfUser = $(bin)setup_GaudiSvcGenConfUser.make
cmt_dependencies_in_GaudiSvcGenConfUser = $(bin)dependencies_GaudiSvcGenConfUser.in
#cmt_final_setup_GaudiSvcGenConfUser = $(bin)GaudiSvc_GaudiSvcGenConfUsersetup.make
cmt_local_GaudiSvcGenConfUser_makefile = $(bin)GaudiSvcGenConfUser.make

else

cmt_final_setup_GaudiSvcGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiSvcGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiSvcGenConfUser = $(bin)GaudiSvcsetup.make
cmt_local_GaudiSvcGenConfUser_makefile = $(bin)GaudiSvcGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiSvcsetup.make

#GaudiSvcGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiSvcGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiSvcGenConfUser/
#GaudiSvcGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiSvcGenConfUser_deps)
command     = $(GaudiSvcGenConfUser_command)
output      = $(GaudiSvcGenConfUser_output)

.PHONY: GaudiSvcGenConfUser GaudiSvcGenConfUserclean

GaudiSvcGenConfUser :: $(output)

GaudiSvcGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiSvcGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiSvcGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiSvcGenConfUserclean ::
#-- end of cleanup_header ---------------
