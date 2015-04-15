#-- start of make_header -----------------

#====================================
#  Document concatenate_headers
#
#   Generated Wed Apr 15 17:01:47 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_concatenate_headers_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_concatenate_headers_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_concatenate_headers

PyCool_tag = $(tag)

#cmt_local_tagfile_concatenate_headers = $(PyCool_tag)_concatenate_headers.make
cmt_local_tagfile_concatenate_headers = $(bin)$(PyCool_tag)_concatenate_headers.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCool_tag = $(tag)

#cmt_local_tagfile_concatenate_headers = $(PyCool_tag).make
cmt_local_tagfile_concatenate_headers = $(bin)$(PyCool_tag).make

endif

include $(cmt_local_tagfile_concatenate_headers)
#-include $(cmt_local_tagfile_concatenate_headers)

ifdef cmt_concatenate_headers_has_target_tag

cmt_final_setup_concatenate_headers = $(bin)setup_concatenate_headers.make
cmt_dependencies_in_concatenate_headers = $(bin)dependencies_concatenate_headers.in
#cmt_final_setup_concatenate_headers = $(bin)PyCool_concatenate_headerssetup.make
cmt_local_concatenate_headers_makefile = $(bin)concatenate_headers.make

else

cmt_final_setup_concatenate_headers = $(bin)setup.make
cmt_dependencies_in_concatenate_headers = $(bin)dependencies.in
#cmt_final_setup_concatenate_headers = $(bin)PyCoolsetup.make
cmt_local_concatenate_headers_makefile = $(bin)concatenate_headers.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoolsetup.make

#concatenate_headers :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'concatenate_headers'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = concatenate_headers/
#concatenate_headers::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of cmt_action_runner_header ---------------

ifdef ONCE
concatenate_headers_once = 1
endif

ifdef concatenate_headers_once

concatenate_headersactionstamp = $(bin)concatenate_headers.actionstamp
#concatenate_headersactionstamp = concatenate_headers.actionstamp

concatenate_headers :: $(concatenate_headersactionstamp)
	$(echo) "concatenate_headers ok"
#	@echo concatenate_headers ok

#$(concatenate_headersactionstamp) :: $(concatenate_headers_dependencies)
$(concatenate_headersactionstamp) ::
	$(silent) if [ ! -e /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h ] || [ /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -ot /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/dict/PyCool_headers.h ] || [ /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -ot /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/RelationalCool/src/PyCool_helpers.h ]; then mkdir -p /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict; cat /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/dict/PyCool_headers.h /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/RelationalCool/src/PyCool_helpers.h > /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h; fi
	$(silent) cat /dev/null > $(concatenate_headersactionstamp)
#	@echo ok > $(concatenate_headersactionstamp)

concatenate_headersclean ::
	$(cleanup_silent) /bin/rm -f $(concatenate_headersactionstamp)

else

#concatenate_headers :: $(concatenate_headers_dependencies)
concatenate_headers ::
	$(silent) if [ ! -e /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h ] || [ /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -ot /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/dict/PyCool_headers.h ] || [ /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -ot /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/RelationalCool/src/PyCool_helpers.h ]; then mkdir -p /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict; cat /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/dict/PyCool_headers.h /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/RelationalCool/src/PyCool_helpers.h > /home/jwsmith/HDD/ANA/ANA/1b_COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h; fi

endif

install ::
uninstall ::

#-- end of cmt_action_runner_header -----------------
#-- start of cleanup_header --------------

clean :: concatenate_headersclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(concatenate_headers.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

concatenate_headersclean ::
#-- end of cleanup_header ---------------
