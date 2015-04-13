#-- start of make_header -----------------

#====================================
#  Document GaudiGSLMathGen
#
#   Generated Mon Feb 16 20:17:30 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiGSLMathGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiGSLMathGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiGSLMathGen

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMathGen = $(GaudiGSL_tag)_GaudiGSLMathGen.make
cmt_local_tagfile_GaudiGSLMathGen = $(bin)$(GaudiGSL_tag)_GaudiGSLMathGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiGSL_tag = $(tag)

#cmt_local_tagfile_GaudiGSLMathGen = $(GaudiGSL_tag).make
cmt_local_tagfile_GaudiGSLMathGen = $(bin)$(GaudiGSL_tag).make

endif

include $(cmt_local_tagfile_GaudiGSLMathGen)
#-include $(cmt_local_tagfile_GaudiGSLMathGen)

ifdef cmt_GaudiGSLMathGen_has_target_tag

cmt_final_setup_GaudiGSLMathGen = $(bin)setup_GaudiGSLMathGen.make
cmt_dependencies_in_GaudiGSLMathGen = $(bin)dependencies_GaudiGSLMathGen.in
#cmt_final_setup_GaudiGSLMathGen = $(bin)GaudiGSL_GaudiGSLMathGensetup.make
cmt_local_GaudiGSLMathGen_makefile = $(bin)GaudiGSLMathGen.make

else

cmt_final_setup_GaudiGSLMathGen = $(bin)setup.make
cmt_dependencies_in_GaudiGSLMathGen = $(bin)dependencies.in
#cmt_final_setup_GaudiGSLMathGen = $(bin)GaudiGSLsetup.make
cmt_local_GaudiGSLMathGen_makefile = $(bin)GaudiGSLMathGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiGSLsetup.make

#GaudiGSLMathGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiGSLMathGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiGSLMathGen/
#GaudiGSLMathGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GaudiGSLMathGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GaudiGSLMathGenprototype)

$(bin)GaudiGSLMathGen_dependencies.make : $(use_requirements) $(cmt_final_setup_GaudiGSLMathGen)
	$(echo) "(GaudiGSLMathGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/GaudiGSL/dict/GaudiGSLMath.h -end_all $(includes) $(app_GaudiGSLMathGen_cppflags) $(lib_GaudiGSLMathGen_cppflags) -name=GaudiGSLMathGen $? -f=$(cmt_dependencies_in_GaudiGSLMathGen) -without_cmt

-include $(bin)GaudiGSLMathGen_dependencies.make

endif
endif
endif

GaudiGSLMathGenclean ::
	$(cleanup_silent) \rm -rf $(bin)GaudiGSLMathGen_deps $(bin)GaudiGSLMathGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),GaudiGSLMathGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)GaudiGSLMathGen_dependencies.make : $(GaudiGSLMath_h_dependencies)

$(bin)GaudiGSLMathGen_dependencies.make : /home/jwsmith/HDD/Gaudi/GaudiGSL/dict/GaudiGSLMath.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: GaudiGSLMathGen GaudiGSLMathGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/GaudiGSLMath
gensrcdict=$(dictdir)/GaudiGSLMathDict.cpp
ifdef GaudiGSLMath_rootmap
  rootmapname=GaudiGSLMathDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)GaudiGSLMathDict
else
  rootmapdict=
endif

GaudiGSLMathGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(GaudiGSLMath_h_dependencies) $(GaudiGSLMath_reflex_selection_file)
	echo $@ GaudiGSLMath.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/GaudiGSL/dict/GaudiGSLMath.h -o $(gensrcdict) $(GaudiGSLMath_reflex_options)  \
			 $(GaudiGSLMath_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/GaudiGSLMathDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/GaudiGSLMathDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

GaudiGSLMathGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  GaudiGSLMath_rootmap

mergedrootmapdir=$(dir $(GaudiGSLMath_rootmap))
mergedrootmap=$(GaudiGSLMath_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  GaudiGSLMathGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

GaudiGSLMathGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
GaudiGSLMathGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: GaudiGSLMathGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiGSLMathGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiGSLMathGenclean ::
#-- end of cleanup_header ---------------
