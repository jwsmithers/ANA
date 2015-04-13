#-- start of make_header -----------------

#====================================
#  Document lcg_PyCoolGen
#
#   Generated Tue Mar 31 09:54:31 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_lcg_PyCoolGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_lcg_PyCoolGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_lcg_PyCoolGen

PyCool_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoolGen = $(PyCool_tag)_lcg_PyCoolGen.make
cmt_local_tagfile_lcg_PyCoolGen = $(bin)$(PyCool_tag)_lcg_PyCoolGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

PyCool_tag = $(tag)

#cmt_local_tagfile_lcg_PyCoolGen = $(PyCool_tag).make
cmt_local_tagfile_lcg_PyCoolGen = $(bin)$(PyCool_tag).make

endif

include $(cmt_local_tagfile_lcg_PyCoolGen)
#-include $(cmt_local_tagfile_lcg_PyCoolGen)

ifdef cmt_lcg_PyCoolGen_has_target_tag

cmt_final_setup_lcg_PyCoolGen = $(bin)setup_lcg_PyCoolGen.make
cmt_dependencies_in_lcg_PyCoolGen = $(bin)dependencies_lcg_PyCoolGen.in
#cmt_final_setup_lcg_PyCoolGen = $(bin)PyCool_lcg_PyCoolGensetup.make
cmt_local_lcg_PyCoolGen_makefile = $(bin)lcg_PyCoolGen.make

else

cmt_final_setup_lcg_PyCoolGen = $(bin)setup.make
cmt_dependencies_in_lcg_PyCoolGen = $(bin)dependencies.in
#cmt_final_setup_lcg_PyCoolGen = $(bin)PyCoolsetup.make
cmt_local_lcg_PyCoolGen_makefile = $(bin)lcg_PyCoolGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)PyCoolsetup.make

#lcg_PyCoolGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'lcg_PyCoolGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = lcg_PyCoolGen/
#lcg_PyCoolGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),lcg_PyCoolGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),lcg_PyCoolGenprototype)

$(bin)lcg_PyCoolGen_dependencies.make : $(use_requirements) $(cmt_final_setup_lcg_PyCoolGen)
	$(echo) "(lcg_PyCoolGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -end_all $(includes) $(app_lcg_PyCoolGen_cppflags) $(lib_lcg_PyCoolGen_cppflags) -name=lcg_PyCoolGen $? -f=$(cmt_dependencies_in_lcg_PyCoolGen) -without_cmt

-include $(bin)lcg_PyCoolGen_dependencies.make

endif
endif
endif

lcg_PyCoolGenclean ::
	$(cleanup_silent) \rm -rf $(bin)lcg_PyCoolGen_deps $(bin)lcg_PyCoolGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),lcg_PyCoolGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)lcg_PyCoolGen_dependencies.make : $(PyCool_headers_and_helpers_h_dependencies)

$(bin)lcg_PyCoolGen_dependencies.make : /home/jwsmith/HDD/COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: lcg_PyCoolGen lcg_PyCoolGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/lcg_PyCool
gensrcdict=$(dictdir)/lcg_PyCoolDict.cpp
ifdef lcg_PyCool_rootmap
  rootmapname=lcg_PyCoolDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)lcg_PyCoolDict
else
  rootmapdict=
endif

lcg_PyCoolGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(PyCool_headers_and_helpers_h_dependencies) $(lcg_PyCool_reflex_selection_file)
	echo $@ PyCool_headers_and_helpers.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/COOL/COOL_2_9_2/PyCool/armv7l-fc21-gcc49-opt/dict/PyCool_headers_and_helpers.h -o $(gensrcdict) $(PyCool_headers_and_helpers_reflex_options)  \
			 $(lcg_PyCool_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/lcg_PyCoolDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/lcg_PyCoolDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

lcg_PyCoolGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  lcg_PyCool_rootmap

mergedrootmapdir=$(dir $(lcg_PyCool_rootmap))
mergedrootmap=$(lcg_PyCool_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  lcg_PyCoolGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

lcg_PyCoolGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
lcg_PyCoolGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: lcg_PyCoolGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(lcg_PyCoolGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

lcg_PyCoolGenclean ::
#-- end of cleanup_header ---------------
