#-- start of make_header -----------------

#====================================
#  Document GaudiExamplesGen
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

cmt_GaudiExamplesGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiExamplesGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiExamplesGen

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesGen = $(GaudiExamples_tag)_GaudiExamplesGen.make
cmt_local_tagfile_GaudiExamplesGen = $(bin)$(GaudiExamples_tag)_GaudiExamplesGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiExamples_tag = $(tag)

#cmt_local_tagfile_GaudiExamplesGen = $(GaudiExamples_tag).make
cmt_local_tagfile_GaudiExamplesGen = $(bin)$(GaudiExamples_tag).make

endif

include $(cmt_local_tagfile_GaudiExamplesGen)
#-include $(cmt_local_tagfile_GaudiExamplesGen)

ifdef cmt_GaudiExamplesGen_has_target_tag

cmt_final_setup_GaudiExamplesGen = $(bin)setup_GaudiExamplesGen.make
cmt_dependencies_in_GaudiExamplesGen = $(bin)dependencies_GaudiExamplesGen.in
#cmt_final_setup_GaudiExamplesGen = $(bin)GaudiExamples_GaudiExamplesGensetup.make
cmt_local_GaudiExamplesGen_makefile = $(bin)GaudiExamplesGen.make

else

cmt_final_setup_GaudiExamplesGen = $(bin)setup.make
cmt_dependencies_in_GaudiExamplesGen = $(bin)dependencies.in
#cmt_final_setup_GaudiExamplesGen = $(bin)GaudiExamplessetup.make
cmt_local_GaudiExamplesGen_makefile = $(bin)GaudiExamplesGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiExamplessetup.make

#GaudiExamplesGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiExamplesGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiExamplesGen/
#GaudiExamplesGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GaudiExamplesGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GaudiExamplesGenprototype)

$(bin)GaudiExamplesGen_dependencies.make : $(use_requirements) $(cmt_final_setup_GaudiExamplesGen)
	$(echo) "(GaudiExamplesGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/GaudiExamples/src/IO/dict.h -end_all $(includes) $(app_GaudiExamplesGen_cppflags) $(lib_GaudiExamplesGen_cppflags) -name=GaudiExamplesGen $? -f=$(cmt_dependencies_in_GaudiExamplesGen) -without_cmt

-include $(bin)GaudiExamplesGen_dependencies.make

endif
endif
endif

GaudiExamplesGenclean ::
	$(cleanup_silent) \rm -rf $(bin)GaudiExamplesGen_deps $(bin)GaudiExamplesGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),GaudiExamplesGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)GaudiExamplesGen_dependencies.make : $(dict_h_dependencies)

$(bin)GaudiExamplesGen_dependencies.make : /home/jwsmith/HDD/Gaudi/GaudiExamples/src/IO/dict.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: GaudiExamplesGen GaudiExamplesGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/GaudiExamples
gensrcdict=$(dictdir)/GaudiExamplesDict.cpp
ifdef GaudiExamples_rootmap
  rootmapname=GaudiExamplesDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)GaudiExamplesDict
else
  rootmapdict=
endif

GaudiExamplesGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(dict_h_dependencies) $(GaudiExamples_reflex_selection_file)
	echo $@ dict.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/GaudiExamples/src/IO/dict.h -o $(gensrcdict) $(dict_reflex_options)  \
			 $(GaudiExamples_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/GaudiExamplesDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/GaudiExamplesDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

GaudiExamplesGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  GaudiExamples_rootmap

mergedrootmapdir=$(dir $(GaudiExamples_rootmap))
mergedrootmap=$(GaudiExamples_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  GaudiExamplesGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

GaudiExamplesGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
GaudiExamplesGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: GaudiExamplesGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiExamplesGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiExamplesGenclean ::
#-- end of cleanup_header ---------------
