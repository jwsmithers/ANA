#-- start of make_header -----------------

#====================================
#  Document GaudiMPGenConfUser
#
#   Generated Mon Feb 16 20:49:04 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiMPGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPGenConfUser

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPGenConfUser = $(GaudiMP_tag)_GaudiMPGenConfUser.make
cmt_local_tagfile_GaudiMPGenConfUser = $(bin)$(GaudiMP_tag)_GaudiMPGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPGenConfUser = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPGenConfUser = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPGenConfUser)
#-include $(cmt_local_tagfile_GaudiMPGenConfUser)

ifdef cmt_GaudiMPGenConfUser_has_target_tag

cmt_final_setup_GaudiMPGenConfUser = $(bin)setup_GaudiMPGenConfUser.make
cmt_dependencies_in_GaudiMPGenConfUser = $(bin)dependencies_GaudiMPGenConfUser.in
#cmt_final_setup_GaudiMPGenConfUser = $(bin)GaudiMP_GaudiMPGenConfUsersetup.make
cmt_local_GaudiMPGenConfUser_makefile = $(bin)GaudiMPGenConfUser.make

else

cmt_final_setup_GaudiMPGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiMPGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiMPGenConfUser = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPGenConfUser_makefile = $(bin)GaudiMPGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPGenConfUser/
#GaudiMPGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiMPGenConfUser_deps)
command     = $(GaudiMPGenConfUser_command)
output      = $(GaudiMPGenConfUser_output)

.PHONY: GaudiMPGenConfUser GaudiMPGenConfUserclean

GaudiMPGenConfUser :: $(output)

GaudiMPGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiMPGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPGenConfUserclean ::
#-- end of cleanup_header ---------------
