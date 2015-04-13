#-- start of make_header -----------------

#====================================
#  Library GaudiUtilsLib
#
#   Generated Mon Feb 16 19:56:42 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_GaudiUtilsLib_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_GaudiUtilsLib_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_GaudiUtilsLib

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsLib = $(GaudiUtils_tag)_GaudiUtilsLib.make
cmt_local_tagfile_GaudiUtilsLib = $(bin)$(GaudiUtils_tag)_GaudiUtilsLib.make

else

tags      = $(tag),$(CMTEXTRATAGS)

GaudiUtils_tag = $(tag)

#cmt_local_tagfile_GaudiUtilsLib = $(GaudiUtils_tag).make
cmt_local_tagfile_GaudiUtilsLib = $(bin)$(GaudiUtils_tag).make

endif

include $(cmt_local_tagfile_GaudiUtilsLib)
#-include $(cmt_local_tagfile_GaudiUtilsLib)

ifdef cmt_GaudiUtilsLib_has_target_tag

cmt_final_setup_GaudiUtilsLib = $(bin)setup_GaudiUtilsLib.make
cmt_dependencies_in_GaudiUtilsLib = $(bin)dependencies_GaudiUtilsLib.in
#cmt_final_setup_GaudiUtilsLib = $(bin)GaudiUtils_GaudiUtilsLibsetup.make
cmt_local_GaudiUtilsLib_makefile = $(bin)GaudiUtilsLib.make

else

cmt_final_setup_GaudiUtilsLib = $(bin)setup.make
cmt_dependencies_in_GaudiUtilsLib = $(bin)dependencies.in
#cmt_final_setup_GaudiUtilsLib = $(bin)GaudiUtilssetup.make
cmt_local_GaudiUtilsLib_makefile = $(bin)GaudiUtilsLib.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)GaudiUtilssetup.make

#GaudiUtilsLib :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'GaudiUtilsLib'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = GaudiUtilsLib/
#GaudiUtilsLib::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
#-- start of libary_header ---------------

GaudiUtilsLiblibname   = $(bin)$(library_prefix)GaudiUtilsLib$(library_suffix)
GaudiUtilsLiblib       = $(GaudiUtilsLiblibname).a
GaudiUtilsLibstamp     = $(bin)GaudiUtilsLib.stamp
GaudiUtilsLibshstamp   = $(bin)GaudiUtilsLib.shstamp

GaudiUtilsLib :: dirs  GaudiUtilsLibLIB
	$(echo) "GaudiUtilsLib ok"

cmt_GaudiUtilsLib_has_prototypes = 1

#--------------------------------------

ifdef cmt_GaudiUtilsLib_has_prototypes

GaudiUtilsLibprototype :  ;

endif

GaudiUtilsLibcompile : $(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o ;

#-- end of libary_header ----------------
#-- start of library_no_static ------

#GaudiUtilsLibLIB :: $(GaudiUtilsLiblib) $(GaudiUtilsLibshstamp)
GaudiUtilsLibLIB :: $(GaudiUtilsLibshstamp)
	$(echo) "GaudiUtilsLib : library ok"

$(GaudiUtilsLiblib) :: $(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o
	$(lib_echo) "static library $@"
	$(lib_silent) cd $(bin); \
	  $(ar) $(GaudiUtilsLiblib) $?
	$(lib_silent) $(ranlib) $(GaudiUtilsLiblib)
	$(lib_silent) cat /dev/null >$(GaudiUtilsLibstamp)

#------------------------------------------------------------------
#  Future improvement? to empty the object files after
#  storing in the library
#
##	  for f in $?; do \
##	    rm $${f}; touch $${f}; \
##	  done
#------------------------------------------------------------------

#
# We add one level of dependency upon the true shared library 
# (rather than simply upon the stamp file)
# this is for cases where the shared library has not been built
# while the stamp was created (error??) 
#

$(GaudiUtilsLiblibname).$(shlibsuffix) :: $(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o $(use_requirements) $(GaudiUtilsLibstamps)
	$(lib_echo) "shared library $@"
	$(lib_silent) $(shlibbuilder) $(shlibflags) -o $@ $(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o $(GaudiUtilsLib_shlibflags)
	$(lib_silent) cat /dev/null >$(GaudiUtilsLibstamp) && \
	  cat /dev/null >$(GaudiUtilsLibshstamp)

$(GaudiUtilsLibshstamp) :: $(GaudiUtilsLiblibname).$(shlibsuffix)
	$(lib_silent) if test -f $(GaudiUtilsLiblibname).$(shlibsuffix) ; then \
	  cat /dev/null >$(GaudiUtilsLibstamp) && \
	  cat /dev/null >$(GaudiUtilsLibshstamp) ; fi

GaudiUtilsLibclean ::
	$(cleanup_echo) objects GaudiUtilsLib
	$(cleanup_silent) /bin/rm -f $(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o
	$(cleanup_silent) /bin/rm -f $(patsubst %.o,%.d,$(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o) $(patsubst %.o,%.dep,$(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o) $(patsubst %.o,%.d.stamp,$(bin)HistoXML.o $(bin)HistoStats.o $(bin)HistoTableFormat.o $(bin)HistoDump.o $(bin)Histo2String.o $(bin)Aida2ROOT.o $(bin)HistoParsers.o $(bin)HistoLabels.o $(bin)HistoStrings.o)
	$(cleanup_silent) cd $(bin); /bin/rm -rf GaudiUtilsLib_deps GaudiUtilsLib_dependencies.make

#-----------------------------------------------------------------
#
#  New section for automatic installation
#
#-----------------------------------------------------------------

install_dir = ${CMTINSTALLAREA}/$(tag)/lib
GaudiUtilsLibinstallname = $(library_prefix)GaudiUtilsLib$(library_suffix).$(shlibsuffix)

GaudiUtilsLib :: GaudiUtilsLibinstall ;

install :: GaudiUtilsLibinstall ;

GaudiUtilsLibinstall :: $(install_dir)/$(GaudiUtilsLibinstallname)
ifdef CMTINSTALLAREA
	$(echo) "installation done"
endif

$(install_dir)/$(GaudiUtilsLibinstallname) :: $(bin)$(GaudiUtilsLibinstallname)
ifdef CMTINSTALLAREA
	$(install_silent) $(cmt_install_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiUtilsLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmd "$(cmt_installarea_command)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

##GaudiUtilsLibclean :: GaudiUtilsLibuninstall

uninstall :: GaudiUtilsLibuninstall ;

GaudiUtilsLibuninstall ::
ifdef CMTINSTALLAREA
	$(cleanup_silent) $(cmt_uninstall_action) \
	    -source "`(cd $(bin); pwd)`" \
	    -name "$(GaudiUtilsLibinstallname)" \
	    -out "$(install_dir)" \
	    -cmtpath "$($(package)_cmtpath)"
endif

#-- end of library_no_static ------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoXML.d

$(bin)$(binobj)HistoXML.d :

$(bin)$(binobj)HistoXML.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoXML.o : $(src)Lib/HistoXML.cpp
	$(cpp_echo) $(src)Lib/HistoXML.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoXML_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoXML_cppflags) $(HistoXML_cpp_cppflags) -I../src/Lib $(src)Lib/HistoXML.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoXML_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoXML.cpp

$(bin)$(binobj)HistoXML.o : $(HistoXML_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoXML.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoXML_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoXML_cppflags) $(HistoXML_cpp_cppflags) -I../src/Lib $(src)Lib/HistoXML.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoStats.d

$(bin)$(binobj)HistoStats.d :

$(bin)$(binobj)HistoStats.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoStats.o : $(src)Lib/HistoStats.cpp
	$(cpp_echo) $(src)Lib/HistoStats.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoStats_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoStats_cppflags) $(HistoStats_cpp_cppflags) -I../src/Lib $(src)Lib/HistoStats.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoStats_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoStats.cpp

$(bin)$(binobj)HistoStats.o : $(HistoStats_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoStats.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoStats_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoStats_cppflags) $(HistoStats_cpp_cppflags) -I../src/Lib $(src)Lib/HistoStats.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoTableFormat.d

$(bin)$(binobj)HistoTableFormat.d :

$(bin)$(binobj)HistoTableFormat.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoTableFormat.o : $(src)Lib/HistoTableFormat.cpp
	$(cpp_echo) $(src)Lib/HistoTableFormat.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoTableFormat_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoTableFormat_cppflags) $(HistoTableFormat_cpp_cppflags) -I../src/Lib $(src)Lib/HistoTableFormat.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoTableFormat_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoTableFormat.cpp

$(bin)$(binobj)HistoTableFormat.o : $(HistoTableFormat_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoTableFormat.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoTableFormat_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoTableFormat_cppflags) $(HistoTableFormat_cpp_cppflags) -I../src/Lib $(src)Lib/HistoTableFormat.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoDump.d

$(bin)$(binobj)HistoDump.d :

$(bin)$(binobj)HistoDump.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoDump.o : $(src)Lib/HistoDump.cpp
	$(cpp_echo) $(src)Lib/HistoDump.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoDump_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoDump_cppflags) $(HistoDump_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDump.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoDump_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoDump.cpp

$(bin)$(binobj)HistoDump.o : $(HistoDump_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoDump.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoDump_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoDump_cppflags) $(HistoDump_cpp_cppflags) -I../src/Lib $(src)Lib/HistoDump.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Histo2String.d

$(bin)$(binobj)Histo2String.d :

$(bin)$(binobj)Histo2String.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)Histo2String.o : $(src)Lib/Histo2String.cpp
	$(cpp_echo) $(src)Lib/Histo2String.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(Histo2String_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(Histo2String_cppflags) $(Histo2String_cpp_cppflags) -I../src/Lib $(src)Lib/Histo2String.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(Histo2String_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/Histo2String.cpp

$(bin)$(binobj)Histo2String.o : $(Histo2String_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Histo2String.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(Histo2String_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(Histo2String_cppflags) $(Histo2String_cpp_cppflags) -I../src/Lib $(src)Lib/Histo2String.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)Aida2ROOT.d

$(bin)$(binobj)Aida2ROOT.d :

$(bin)$(binobj)Aida2ROOT.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)Aida2ROOT.o : $(src)Lib/Aida2ROOT.cpp
	$(cpp_echo) $(src)Lib/Aida2ROOT.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(Aida2ROOT_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(Aida2ROOT_cppflags) $(Aida2ROOT_cpp_cppflags) -I../src/Lib $(src)Lib/Aida2ROOT.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(Aida2ROOT_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/Aida2ROOT.cpp

$(bin)$(binobj)Aida2ROOT.o : $(Aida2ROOT_cpp_dependencies)
	$(cpp_echo) $(src)Lib/Aida2ROOT.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(Aida2ROOT_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(Aida2ROOT_cppflags) $(Aida2ROOT_cpp_cppflags) -I../src/Lib $(src)Lib/Aida2ROOT.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoParsers.d

$(bin)$(binobj)HistoParsers.d :

$(bin)$(binobj)HistoParsers.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoParsers.o : $(src)Lib/HistoParsers.cpp
	$(cpp_echo) $(src)Lib/HistoParsers.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoParsers_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoParsers_cppflags) $(HistoParsers_cpp_cppflags) -I../src/Lib $(src)Lib/HistoParsers.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoParsers_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoParsers.cpp

$(bin)$(binobj)HistoParsers.o : $(HistoParsers_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoParsers.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoParsers_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoParsers_cppflags) $(HistoParsers_cpp_cppflags) -I../src/Lib $(src)Lib/HistoParsers.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoLabels.d

$(bin)$(binobj)HistoLabels.d :

$(bin)$(binobj)HistoLabels.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoLabels.o : $(src)Lib/HistoLabels.cpp
	$(cpp_echo) $(src)Lib/HistoLabels.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoLabels_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoLabels_cppflags) $(HistoLabels_cpp_cppflags) -I../src/Lib $(src)Lib/HistoLabels.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoLabels_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoLabels.cpp

$(bin)$(binobj)HistoLabels.o : $(HistoLabels_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoLabels.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoLabels_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoLabels_cppflags) $(HistoLabels_cpp_cppflags) -I../src/Lib $(src)Lib/HistoLabels.cpp

endif

#-- end of cpp_library ------------------
#-- start of cpp_library -----------------

ifneq (-MMD -MP -MF $*.d -MQ $@,)

ifneq ($(MAKECMDGOALS),GaudiUtilsLibclean)
ifneq ($(MAKECMDGOALS),uninstall)
-include $(bin)$(binobj)HistoStrings.d

$(bin)$(binobj)HistoStrings.d :

$(bin)$(binobj)HistoStrings.o : $(cmt_final_setup_GaudiUtilsLib)

$(bin)$(binobj)HistoStrings.o : $(src)Lib/HistoStrings.cpp
	$(cpp_echo) $(src)Lib/HistoStrings.cpp
	$(cpp_silent) $(cppcomp) -MMD -MP -MF $*.d -MQ $@ -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoStrings_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoStrings_cppflags) $(HistoStrings_cpp_cppflags) -I../src/Lib $(src)Lib/HistoStrings.cpp
endif
endif

else
$(bin)GaudiUtilsLib_dependencies.make : $(HistoStrings_cpp_dependencies)

$(bin)GaudiUtilsLib_dependencies.make : $(src)Lib/HistoStrings.cpp

$(bin)$(binobj)HistoStrings.o : $(HistoStrings_cpp_dependencies)
	$(cpp_echo) $(src)Lib/HistoStrings.cpp
	$(cpp_silent) $(cppcomp) -o $@ $(use_pp_cppflags) $(GaudiUtilsLib_pp_cppflags) $(lib_GaudiUtilsLib_pp_cppflags) $(HistoStrings_pp_cppflags) $(use_cppflags) $(GaudiUtilsLib_cppflags) $(lib_GaudiUtilsLib_cppflags) $(HistoStrings_cppflags) $(HistoStrings_cpp_cppflags) -I../src/Lib $(src)Lib/HistoStrings.cpp

endif

#-- end of cpp_library ------------------
#-- start of cleanup_header --------------

clean :: GaudiUtilsLibclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(GaudiUtilsLib.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

GaudiUtilsLibclean ::
#-- end of cleanup_header ---------------
#-- start of cleanup_library -------------
	$(cleanup_echo) library GaudiUtilsLib
	-$(cleanup_silent) cd $(bin) && \rm -f $(library_prefix)GaudiUtilsLib$(library_suffix).a $(library_prefix)GaudiUtilsLib$(library_suffix).$(shlibsuffix) GaudiUtilsLib.stamp GaudiUtilsLib.shstamp
#-- end of cleanup_library ---------------
