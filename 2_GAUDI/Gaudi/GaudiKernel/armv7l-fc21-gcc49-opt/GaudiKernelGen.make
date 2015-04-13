#-- start of make_header -----------------

#====================================
#  Document GaudiKernelGen
#
#   Generated Mon Feb 16 19:31:57 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiKernelGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiKernelGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiKernelGen

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernelGen = $(GaudiKernel_tag)_GaudiKernelGen.make
cmt_local_tagfile_GaudiKernelGen = $(bin)$(GaudiKernel_tag)_GaudiKernelGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiKernel_tag = $(tag)

#cmt_local_tagfile_GaudiKernelGen = $(GaudiKernel_tag).make
cmt_local_tagfile_GaudiKernelGen = $(bin)$(GaudiKernel_tag).make

endif

include $(cmt_local_tagfile_GaudiKernelGen)
#-include $(cmt_local_tagfile_GaudiKernelGen)

ifdef cmt_GaudiKernelGen_has_target_tag

cmt_final_setup_GaudiKernelGen = $(bin)setup_GaudiKernelGen.make
cmt_dependencies_in_GaudiKernelGen = $(bin)dependencies_GaudiKernelGen.in
#cmt_final_setup_GaudiKernelGen = $(bin)GaudiKernel_GaudiKernelGensetup.make
cmt_local_GaudiKernelGen_makefile = $(bin)GaudiKernelGen.make

else

cmt_final_setup_GaudiKernelGen = $(bin)setup.make
cmt_dependencies_in_GaudiKernelGen = $(bin)dependencies.in
#cmt_final_setup_GaudiKernelGen = $(bin)GaudiKernelsetup.make
cmt_local_GaudiKernelGen_makefile = $(bin)GaudiKernelGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiKernelsetup.make

#GaudiKernelGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiKernelGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiKernelGen/
#GaudiKernelGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GaudiKernelGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GaudiKernelGenprototype)

$(bin)GaudiKernelGen_dependencies.make : $(use_requirements) $(cmt_final_setup_GaudiKernelGen)
	$(echo) "(GaudiKernelGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/GaudiKernel/dict/dictionary.h -end_all $(includes) $(app_GaudiKernelGen_cppflags) $(lib_GaudiKernelGen_cppflags) -name=GaudiKernelGen $? -f=$(cmt_dependencies_in_GaudiKernelGen) -without_cmt

-include $(bin)GaudiKernelGen_dependencies.make

endif
endif
endif

GaudiKernelGenclean ::
	$(cleanup_silent) \rm -rf $(bin)GaudiKernelGen_deps $(bin)GaudiKernelGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),GaudiKernelGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)GaudiKernelGen_dependencies.make : $(dictionary_h_dependencies)

$(bin)GaudiKernelGen_dependencies.make : /home/jwsmith/HDD/Gaudi/GaudiKernel/dict/dictionary.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: GaudiKernelGen GaudiKernelGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/GaudiKernel
gensrcdict=$(dictdir)/GaudiKernelDict.cpp
ifdef GaudiKernel_rootmap
  rootmapname=GaudiKernelDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)GaudiKernelDict
else
  rootmapdict=
endif

GaudiKernelGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(dictionary_h_dependencies) $(GaudiKernel_reflex_selection_file)
	echo $@ dictionary.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/GaudiKernel/dict/dictionary.h -o $(gensrcdict) $(dictionary_reflex_options)  \
			 $(GaudiKernel_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/GaudiKernelDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/GaudiKernelDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

GaudiKernelGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  GaudiKernel_rootmap

mergedrootmapdir=$(dir $(GaudiKernel_rootmap))
mergedrootmap=$(GaudiKernel_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  GaudiKernelGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

GaudiKernelGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
GaudiKernelGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: GaudiKernelGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiKernelGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiKernelGenclean ::
#-- end of cleanup_header ---------------
