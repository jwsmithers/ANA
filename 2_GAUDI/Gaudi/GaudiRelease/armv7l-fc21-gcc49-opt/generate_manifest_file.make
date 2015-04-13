#-- start of make_header -----------------

#====================================
#  Document generate_manifest_file
#
#   Generated Mon Feb 16 20:58:35 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_generate_manifest_file_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_generate_manifest_file_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_generate_manifest_file

GaudiRelease_tag = $(tag)

#cmt_local_tagfile_generate_manifest_file = $(GaudiRelease_tag)_generate_manifest_file.make
cmt_local_tagfile_generate_manifest_file = $(bin)$(GaudiRelease_tag)_generate_manifest_file.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiRelease_tag = $(tag)

#cmt_local_tagfile_generate_manifest_file = $(GaudiRelease_tag).make
cmt_local_tagfile_generate_manifest_file = $(bin)$(GaudiRelease_tag).make

endif

include $(cmt_local_tagfile_generate_manifest_file)
#-include $(cmt_local_tagfile_generate_manifest_file)

ifdef cmt_generate_manifest_file_has_target_tag

cmt_final_setup_generate_manifest_file = $(bin)setup_generate_manifest_file.make
cmt_dependencies_in_generate_manifest_file = $(bin)dependencies_generate_manifest_file.in
#cmt_final_setup_generate_manifest_file = $(bin)GaudiRelease_generate_manifest_filesetup.make
cmt_local_generate_manifest_file_makefile = $(bin)generate_manifest_file.make

else

cmt_final_setup_generate_manifest_file = $(bin)setup.make
cmt_dependencies_in_generate_manifest_file = $(bin)dependencies.in
#cmt_final_setup_generate_manifest_file = $(bin)GaudiReleasesetup.make
cmt_local_generate_manifest_file_makefile = $(bin)generate_manifest_file.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiReleasesetup.make

#generate_manifest_file :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'generate_manifest_file'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = generate_manifest_file/
#generate_manifest_file::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
# ============= call_command_header:begin =============
deps        = $(generate_manifest_file_deps)
command     = $(generate_manifest_file_command)
output      = $(generate_manifest_file_output)

.PHONY: generate_manifest_file generate_manifest_fileclean

generate_manifest_file :: $(output)

generate_manifest_fileclean ::
	$(cmt_uninstallarea_command) $(output)

$(output):: $(deps)
	$(command)

FORCE:
# ============= call_command_header:end =============
#-- start of cleanup_header --------------

clean :: generate_manifest_fileclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(generate_manifest_file.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

generate_manifest_fileclean ::
#-- end of cleanup_header ---------------
