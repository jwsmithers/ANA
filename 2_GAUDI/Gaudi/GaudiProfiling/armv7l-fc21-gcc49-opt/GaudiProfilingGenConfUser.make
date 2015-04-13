#-- start of make_header -----------------

#====================================
#  Document GaudiProfilingGenConfUser
#
#   Generated Mon Feb 16 20:05:10 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiProfilingGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiProfilingGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiProfilingGenConfUser

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingGenConfUser = $(GaudiProfiling_tag)_GaudiProfilingGenConfUser.make
cmt_local_tagfile_GaudiProfilingGenConfUser = $(bin)$(GaudiProfiling_tag)_GaudiProfilingGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiProfiling_tag = $(tag)

#cmt_local_tagfile_GaudiProfilingGenConfUser = $(GaudiProfiling_tag).make
cmt_local_tagfile_GaudiProfilingGenConfUser = $(bin)$(GaudiProfiling_tag).make

endif

include $(cmt_local_tagfile_GaudiProfilingGenConfUser)
#-include $(cmt_local_tagfile_GaudiProfilingGenConfUser)

ifdef cmt_GaudiProfilingGenConfUser_has_target_tag

cmt_final_setup_GaudiProfilingGenConfUser = $(bin)setup_GaudiProfilingGenConfUser.make
cmt_dependencies_in_GaudiProfilingGenConfUser = $(bin)dependencies_GaudiProfilingGenConfUser.in
#cmt_final_setup_GaudiProfilingGenConfUser = $(bin)GaudiProfiling_GaudiProfilingGenConfUsersetup.make
cmt_local_GaudiProfilingGenConfUser_makefile = $(bin)GaudiProfilingGenConfUser.make

else

cmt_final_setup_GaudiProfilingGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiProfilingGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiProfilingGenConfUser = $(bin)GaudiProfilingsetup.make
cmt_local_GaudiProfilingGenConfUser_makefile = $(bin)GaudiProfilingGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiProfilingsetup.make

#GaudiProfilingGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiProfilingGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiProfilingGenConfUser/
#GaudiProfilingGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiProfilingGenConfUser_deps)
command     = $(GaudiProfilingGenConfUser_command)
output      = $(GaudiProfilingGenConfUser_output)

.PHONY: GaudiProfilingGenConfUser GaudiProfilingGenConfUserclean

GaudiProfilingGenConfUser :: $(output)

GaudiProfilingGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiProfilingGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiProfilingGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiProfilingGenConfUserclean ::
#-- end of cleanup_header ---------------
