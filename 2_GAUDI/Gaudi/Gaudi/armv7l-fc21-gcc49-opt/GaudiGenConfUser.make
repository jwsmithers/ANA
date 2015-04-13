#-- start of make_header -----------------

#====================================
#  Document GaudiGenConfUser
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

cmt_GaudiGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGenConfUser

Gaudi_tag = $(tag)

#cmt_local_tagfile_GaudiGenConfUser = $(Gaudi_tag)_GaudiGenConfUser.make
cmt_local_tagfile_GaudiGenConfUser = $(bin)$(Gaudi_tag)_GaudiGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

Gaudi_tag = $(tag)

#cmt_local_tagfile_GaudiGenConfUser = $(Gaudi_tag).make
cmt_local_tagfile_GaudiGenConfUser = $(bin)$(Gaudi_tag).make

endif

include $(cmt_local_tagfile_GaudiGenConfUser)
#-include $(cmt_local_tagfile_GaudiGenConfUser)

ifdef cmt_GaudiGenConfUser_has_target_tag

cmt_final_setup_GaudiGenConfUser = $(bin)setup_GaudiGenConfUser.make
cmt_dependencies_in_GaudiGenConfUser = $(bin)dependencies_GaudiGenConfUser.in
#cmt_final_setup_GaudiGenConfUser = $(bin)Gaudi_GaudiGenConfUsersetup.make
cmt_local_GaudiGenConfUser_makefile = $(bin)GaudiGenConfUser.make

else

cmt_final_setup_GaudiGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiGenConfUser = $(bin)Gaudisetup.make
cmt_local_GaudiGenConfUser_makefile = $(bin)GaudiGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)Gaudisetup.make

#GaudiGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGenConfUser/
#GaudiGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiGenConfUser_deps)
command     = $(GaudiGenConfUser_command)
output      = $(GaudiGenConfUser_output)

.PHONY: GaudiGenConfUser GaudiGenConfUserclean

GaudiGenConfUser :: $(output)

GaudiGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGenConfUserclean ::
#-- end of cleanup_header ---------------
