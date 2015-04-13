#-- start of make_header -----------------

#====================================
#  Document GaudiPythonGenConfUser
#
#   Generated Mon Feb 16 20:23:14 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiPythonGenConfUser_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonGenConfUser_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonGenConfUser

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonGenConfUser = $(GaudiPython_tag)_GaudiPythonGenConfUser.make
cmt_local_tagfile_GaudiPythonGenConfUser = $(bin)$(GaudiPython_tag)_GaudiPythonGenConfUser.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonGenConfUser = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonGenConfUser = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonGenConfUser)
#-include $(cmt_local_tagfile_GaudiPythonGenConfUser)

ifdef cmt_GaudiPythonGenConfUser_has_target_tag

cmt_final_setup_GaudiPythonGenConfUser = $(bin)setup_GaudiPythonGenConfUser.make
cmt_dependencies_in_GaudiPythonGenConfUser = $(bin)dependencies_GaudiPythonGenConfUser.in
#cmt_final_setup_GaudiPythonGenConfUser = $(bin)GaudiPython_GaudiPythonGenConfUsersetup.make
cmt_local_GaudiPythonGenConfUser_makefile = $(bin)GaudiPythonGenConfUser.make

else

cmt_final_setup_GaudiPythonGenConfUser = $(bin)setup.make
cmt_dependencies_in_GaudiPythonGenConfUser = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonGenConfUser = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonGenConfUser_makefile = $(bin)GaudiPythonGenConfUser.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonGenConfUser :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonGenConfUser'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonGenConfUser/
#GaudiPythonGenConfUser::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(GaudiPythonGenConfUser_deps)
command     = $(GaudiPythonGenConfUser_command)
output      = $(GaudiPythonGenConfUser_output)

.PHONY: GaudiPythonGenConfUser GaudiPythonGenConfUserclean

GaudiPythonGenConfUser :: $(output)

GaudiPythonGenConfUserclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: GaudiPythonGenConfUserclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonGenConfUser.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonGenConfUserclean ::
#-- end of cleanup_header ---------------
