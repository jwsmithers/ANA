#-- start of make_header -----------------

#====================================
#  Document GaudiPythonGen
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

cmt_GaudiPythonGen_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiPythonGen_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiPythonGen

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonGen = $(GaudiPython_tag)_GaudiPythonGen.make
cmt_local_tagfile_GaudiPythonGen = $(bin)$(GaudiPython_tag)_GaudiPythonGen.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiPython_tag = $(tag)

#cmt_local_tagfile_GaudiPythonGen = $(GaudiPython_tag).make
cmt_local_tagfile_GaudiPythonGen = $(bin)$(GaudiPython_tag).make

endif

include $(cmt_local_tagfile_GaudiPythonGen)
#-include $(cmt_local_tagfile_GaudiPythonGen)

ifdef cmt_GaudiPythonGen_has_target_tag

cmt_final_setup_GaudiPythonGen = $(bin)setup_GaudiPythonGen.make
cmt_dependencies_in_GaudiPythonGen = $(bin)dependencies_GaudiPythonGen.in
#cmt_final_setup_GaudiPythonGen = $(bin)GaudiPython_GaudiPythonGensetup.make
cmt_local_GaudiPythonGen_makefile = $(bin)GaudiPythonGen.make

else

cmt_final_setup_GaudiPythonGen = $(bin)setup.make
cmt_dependencies_in_GaudiPythonGen = $(bin)dependencies.in
#cmt_final_setup_GaudiPythonGen = $(bin)GaudiPythonsetup.make
cmt_local_GaudiPythonGen_makefile = $(bin)GaudiPythonGen.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiPythonsetup.make

#GaudiPythonGen :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiPythonGen'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiPythonGen/
#GaudiPythonGen::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of dependencies ------------------
ifneq ($(MAKECMDGOALS),GaudiPythonGenclean)
ifneq ($(MAKECMDGOALS),uninstall)
ifneq ($(MAKECMDGOALS),GaudiPythonGenprototype)

$(bin)GaudiPythonGen_dependencies.make : $(use_requirements) $(cmt_final_setup_GaudiPythonGen)
	$(echo) "(GaudiPythonGen.make) Rebuilding $@"; \
	  $(build_dependencies) -out=$@ -start_all /home/jwsmith/HDD/Gaudi/GaudiPython/dict/kernel.h -end_all $(includes) $(app_GaudiPythonGen_cppflags) $(lib_GaudiPythonGen_cppflags) -name=GaudiPythonGen $? -f=$(cmt_dependencies_in_GaudiPythonGen) -without_cmt

-include $(bin)GaudiPythonGen_dependencies.make

endif
endif
endif

GaudiPythonGenclean ::
	$(cleanup_silent) \rm -rf $(bin)GaudiPythonGen_deps $(bin)GaudiPythonGen_dependencies.make
#-- end of dependencies -------------------
#-- start of dependency ------------------
ifneq ($(MAKECMDGOALS),GaudiPythonGenclean)
ifneq ($(MAKECMDGOALS),uninstall)

$(bin)GaudiPythonGen_dependencies.make : $(kernel_h_dependencies)

$(bin)GaudiPythonGen_dependencies.make : /home/jwsmith/HDD/Gaudi/GaudiPython/dict/kernel.h

endif
endif
#-- end of dependency -------------------
# File: cmt/fragments/reflex_dictionary_generator
# Author: Pere Mato

# Makefile fragment to generate the Reflex dictionary together with a local rootmap file
# and a merged file in the installation area if InstallArea is present


.PHONY: GaudiPythonGen GaudiPythonGenclean MergeRootMap MergeRootMapclean

ppcmd=-I

dictdir=../$(tag)/dict/GaudiPython
gensrcdict=$(dictdir)/GaudiPythonDict.cpp
ifdef GaudiPython_rootmap
  rootmapname=GaudiPythonDict.rootmap
  rootmapdict=$(dictdir)/$(rootmapname)
  rootmapopts=--rootmap=$(rootmapname) --rootmap-lib=$(library_prefix)GaudiPythonDict
else
  rootmapdict=
endif

GaudiPythonGen ::  $(gensrcdict) $(rootmapdict) MergeRootMap
	@:

.NOTPARALLEL: $(gensrcdict) $(rootmapdict)

$(gensrcdict) $(rootmapdict) :: $(kernel_h_dependencies) $(GaudiPython_reflex_selection_file)
	echo $@ kernel.h
	@-mkdir -p $(dictdir)
	$(genreflex_cmd) /home/jwsmith/HDD/Gaudi/GaudiPython/dict/kernel.h -o $(gensrcdict) $(kernel_reflex_options)  \
			 $(GaudiPython_reflex_options) $(rootmapopts) $(gccxml_cppflags) $(pp_cppflags) $(includes) $(use_pp_cppflags)
	test -e "$(dictdir)/GaudiPythonDict_rdict.pcm" \
	&& $(install_command) $(dictdir)/GaudiPythonDict_rdict.pcm ${CMTINSTALLAREA}/$(tag)/lib \
	|| true

GaudiPythonGenclean ::
	@echo 'Deleting $(gensrcdict) $(rootmapdict)'
	@$(uninstall_command) $(gensrcdict) $(rootmapdict)


#---Dealing with merging the rootmap files 
ifdef  GaudiPython_rootmap

mergedrootmapdir=$(dir $(GaudiPython_rootmap))
mergedrootmap=$(GaudiPython_rootmap)
stamprootmap=$(mergedrootmapdir)/$(rootmapname).stamp

MergeRootMap :: $(stamprootmap) $(mergedrootmap)
	@:

$(stamprootmap) $(mergedrootmap) :: $(rootmapdict)
	@echo "Running merge_rootmap  GaudiPythonGen" 
	@-mkdir -p $(mergedrootmapdir)
	@touch $(mergedrootmap)
	$(merge_rootmap_cmd) --do-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)

GaudiPythonGenclean ::
	@echo "Un-merging rootmap"
	@$(merge_rootmap_cmd) --un-merge --input-file $(rootmapdict) --merged-file $(mergedrootmap)
	@$(uninstall_command) $(stamprootmap)

else

MergeRootMap ::
        @:

endif
GaudiPythonGenclean ::
	@/bin/rm -rf ../$(tag)/dict
#-- start of cleanup_header --------------

clean :: GaudiPythonGenclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiPythonGen.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiPythonGenclean ::
#-- end of cleanup_header ---------------
