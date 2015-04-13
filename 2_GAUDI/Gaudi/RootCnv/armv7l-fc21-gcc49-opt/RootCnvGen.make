#-- start of make_header -----------------

#====================================
#  Document RootCnvGen
#
#   Generated Mon Feb 16 20:00:08 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_RootCnvGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_RootCnvGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_RootCnvGen

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvGen = $(RootCnv_tag)_RootCnvGen.make
cmt_local_tagfile_RootCnvGen = $(bin)$(RootCnv_tag)_RootCnvGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

RootCnv_tag = $(tag)

#cmt_local_tagfile_RootCnvGen = $(RootCnv_tag).make
cmt_local_tagfile_RootCnvGen = $(bin)$(RootCnv_tag).make

endif

include $(cmt_local_tagfile_RootCnvGen)
#-include $(cmt_local_tagfile_RootCnvGen)

ifdef cmt_RootCnvGen_has_target_tag

cmt_final_setup_RootCnvGen = $(bin)setup_RootCnvGen.make
cmt_dependencies_in_RootCnvGen = $(bin)dependencies_RootCnvGen.in
#cmt_final_setup_RootCnvGen = $(bin)RootCnv_RootCnvGensetup.make
cmt_local_RootCnvGen_makefile = $(bin)RootCnvGen.make

else

cmt_final_setup_RootCnvGen = $(bin)setup.make
cmt_dependencies_in_RootCnvGen = $(bin)dependencies.in
#cmt_final_setup_RootCnvGen = $(bin)RootCnvsetup.make
cmt_local_RootCnvGen_makefile = $(bin)RootCnvGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)RootCnvsetup.make

#RootCnvGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'RootCnvGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = RootCnvGen/
#RootCnvGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),RootCnvGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),RootCnvGenprototype)

$(bin)RootCnvGen_dependencies.make : $(use_requirements) $(cmt_final_setup_RootCnvGen)
	$(echo) "(RootCnvGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/RootCnv/dict/RootCnv_dict.h -end_all $(includes) $(app_RootCnvGen_cppflags) $(lib_RootCnvGen_cppflags) -name=RootCnvGen $? -f=$(cmt_dependencies_in_RootCnvGen) -without_cmt

-include $(bin)RootCnvGen_dependencies.make

endif
endif
endif

RootCnvGenclean ::
	$(cleanup_silent) \rm -rf $(bin)RootCnvGen_deps $(bin)RootCnvGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),RootCnvGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)RootCnvGen_dependencies.make : $(RootCnv_dict_h_dependencies)

$(bin)RootCnvGen_dependencies.make : /home/jwsmith/HDD/Gaudi/RootCnv/dict/RootCnv_dict.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: RootCnvGen RootCnvGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/RootCnv
gensrcdict=$(dictdir)/RootCnvDict.cpp
ifdef RootCnv_rootmap
  rootmapname=RootCnvDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)RootCnvDict
else
  rootmapdict=
endif

RootCnvGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(RootCnv_dict_h_dependencies) $(RootCnv_reflex_selection_file)
	echo $@ RootCnv_dict.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/RootCnv/dict/RootCnv_dict.h -o $(gensrcdict) $(RootCnv_dict_reflex_options)  \
			 $(RootCnv_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/RootCnvDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/RootCnvDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

RootCnvGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  RootCnv_rootmap

mergedrootmapdir=$(dir $(RootCnv_rootmap))
mergedrootmap=$(RootCnv_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  RootCnvGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

RootCnvGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
RootCnvGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: RootCnvGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(RootCnvGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

RootCnvGenclean ::
#-- end of cleanup_header ---------------
