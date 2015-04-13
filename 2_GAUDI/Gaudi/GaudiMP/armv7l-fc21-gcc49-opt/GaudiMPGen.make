#-- start of make_header -----------------

#====================================
#  Document GaudiMPGen
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

cmt_GaudiMPGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiMPGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiMPGen

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPGen = $(GaudiMP_tag)_GaudiMPGen.make
cmt_local_tagfile_GaudiMPGen = $(bin)$(GaudiMP_tag)_GaudiMPGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiMP_tag = $(tag)

#cmt_local_tagfile_GaudiMPGen = $(GaudiMP_tag).make
cmt_local_tagfile_GaudiMPGen = $(bin)$(GaudiMP_tag).make

endif

include $(cmt_local_tagfile_GaudiMPGen)
#-include $(cmt_local_tagfile_GaudiMPGen)

ifdef cmt_GaudiMPGen_has_target_tag

cmt_final_setup_GaudiMPGen = $(bin)setup_GaudiMPGen.make
cmt_dependencies_in_GaudiMPGen = $(bin)dependencies_GaudiMPGen.in
#cmt_final_setup_GaudiMPGen = $(bin)GaudiMP_GaudiMPGensetup.make
cmt_local_GaudiMPGen_makefile = $(bin)GaudiMPGen.make

else

cmt_final_setup_GaudiMPGen = $(bin)setup.make
cmt_dependencies_in_GaudiMPGen = $(bin)dependencies.in
#cmt_final_setup_GaudiMPGen = $(bin)GaudiMPsetup.make
cmt_local_GaudiMPGen_makefile = $(bin)GaudiMPGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiMPsetup.make

#GaudiMPGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiMPGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiMPGen/
#GaudiMPGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GaudiMPGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GaudiMPGenprototype)

$(bin)GaudiMPGen_dependencies.make : $(use_requirements) $(cmt_final_setup_GaudiMPGen)
	$(echo) "(GaudiMPGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/GaudiMP/dict/gaudimp_dict.h -end_all $(includes) $(app_GaudiMPGen_cppflags) $(lib_GaudiMPGen_cppflags) -name=GaudiMPGen $? -f=$(cmt_dependencies_in_GaudiMPGen) -without_cmt

-include $(bin)GaudiMPGen_dependencies.make

endif
endif
endif

GaudiMPGenclean ::
	$(cleanup_silent) \rm -rf $(bin)GaudiMPGen_deps $(bin)GaudiMPGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),GaudiMPGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)GaudiMPGen_dependencies.make : $(gaudimp_dict_h_dependencies)

$(bin)GaudiMPGen_dependencies.make : /home/jwsmith/HDD/Gaudi/GaudiMP/dict/gaudimp_dict.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: GaudiMPGen GaudiMPGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/GaudiMP
gensrcdict=$(dictdir)/GaudiMPDict.cpp
ifdef GaudiMP_rootmap
  rootmapname=GaudiMPDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)GaudiMPDict
else
  rootmapdict=
endif

GaudiMPGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(gaudimp_dict_h_dependencies) $(GaudiMP_reflex_selection_file)
	echo $@ gaudimp_dict.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/GaudiMP/dict/gaudimp_dict.h -o $(gensrcdict) $(gaudimp_dict_reflex_options)  \
			 $(GaudiMP_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/GaudiMPDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/GaudiMPDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

GaudiMPGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  GaudiMP_rootmap

mergedrootmapdir=$(dir $(GaudiMP_rootmap))
mergedrootmap=$(GaudiMP_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  GaudiMPGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

GaudiMPGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
GaudiMPGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: GaudiMPGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiMPGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiMPGenclean ::
#-- end of cleanup_header ---------------
