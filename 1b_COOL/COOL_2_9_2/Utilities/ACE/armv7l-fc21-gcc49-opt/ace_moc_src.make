#-- start of make_header -----------------

#====================================
#  Document ace_moc_src
#
#   Generated Wed Apr 15 17:01:44 2015  by jwsmith
#
#====================================

include ${CMTROOT}/src/Makefile.core

ifdef tag
CMTEXTRATAGS = $(tag)
else
tag       = $(CMTCONFIG)
endif

cmt_ace_moc_src_has_no_target_tag = 1

#--------------------------------------------------------

ifdef cmt_ace_moc_src_has_target_tag

tags      = $(tag),$(CMTEXTRATAGS),target_ace_moc_src

ACE_tag = $(tag)

#cmt_local_tagfile_ace_moc_src = $(ACE_tag)_ace_moc_src.make
cmt_local_tagfile_ace_moc_src = $(bin)$(ACE_tag)_ace_moc_src.make

else

tags      = $(tag),$(CMTEXTRATAGS)

ACE_tag = $(tag)

#cmt_local_tagfile_ace_moc_src = $(ACE_tag).make
cmt_local_tagfile_ace_moc_src = $(bin)$(ACE_tag).make

endif

include $(cmt_local_tagfile_ace_moc_src)
#-include $(cmt_local_tagfile_ace_moc_src)

ifdef cmt_ace_moc_src_has_target_tag

cmt_final_setup_ace_moc_src = $(bin)setup_ace_moc_src.make
cmt_dependencies_in_ace_moc_src = $(bin)dependencies_ace_moc_src.in
#cmt_final_setup_ace_moc_src = $(bin)ACE_ace_moc_srcsetup.make
cmt_local_ace_moc_src_makefile = $(bin)ace_moc_src.make

else

cmt_final_setup_ace_moc_src = $(bin)setup.make
cmt_dependencies_in_ace_moc_src = $(bin)dependencies.in
#cmt_final_setup_ace_moc_src = $(bin)ACEsetup.make
cmt_local_ace_moc_src_makefile = $(bin)ace_moc_src.make

endif

#cmt_final_setup = $(bin)setup.make
#cmt_final_setup = $(bin)ACEsetup.make

#ace_moc_src :: ;

dirs ::
	@if test ! -r requirements ; then echo "No requirements file" ; fi; \
	  if test ! -d $(bin) ; then $(mkdir) -p $(bin) ; fi

javadirs ::
	@if test ! -d $(javabin) ; then $(mkdir) -p $(javabin) ; fi

srcdirs ::
	@if test ! -d $(src) ; then $(mkdir) -p $(src) ; fi

help ::
	$(echo) 'ace_moc_src'

binobj = 
ifdef STRUCTURED_OUTPUT
binobj = ace_moc_src/
#ace_moc_src::
#	@if test ! -d $(bin)$(binobj) ; then $(mkdir) -p $(bin)$(binobj) ; fi
#	$(echo) "STRUCTURED_OUTPUT="$(bin)$(binobj)
endif

${CMTROOT}/src/Makefile.core : ;
ifdef use_requirements
$(use_requirements) : ;
endif

#-- end of make_header ------------------
foldertableview_h_dependencies = ../ACE/foldertableview.h
foldertabledelegate_h_dependencies = ../ACE/foldertabledelegate.h
miscDialogs_h_dependencies = ../ACE/miscDialogs.h
ui_FilterEntry_BASE_h_dependencies = ../ACE/ui_FilterEntry_BASE.h
ui_FilterBuilder_BASE_h_dependencies = ../ACE/ui_FilterBuilder_BASE.h
foldertablemodel_h_dependencies = ../ACE/foldertablemodel.h
foldertabledockwidget_h_dependencies = ../ACE/foldertabledockwidget.h
ACE_Errors_h_dependencies = ../ACE/ACE_Errors.h
ui_ConnectionDialog_BASE_h_dependencies = ../ACE/ui_ConnectionDialog_BASE.h
foldertreeitem_h_dependencies = ../ACE/foldertreeitem.h
ui_MainWindow_BASE_h_dependencies = ../ACE/ui_MainWindow_BASE.h
foldertableitem_h_dependencies = ../ACE/foldertableitem.h
ui_ContentEditor_BASE_h_dependencies = ../ACE/ui_ContentEditor_BASE.h
accesstocool_h_dependencies = ../ACE/accesstocool.h
ui_FolderOpenDialog_BASE_h_dependencies = ../ACE/ui_FolderOpenDialog_BASE.h
foldertreemodel_h_dependencies = ../ACE/foldertreemodel.h
ui_LineEdit_Dialog_BASE_h_dependencies = ../ACE/ui_LineEdit_Dialog_BASE.h
FilterEntry_h_dependencies = ../ACE/FilterEntry.h
FilterBuilderDockWidget_h_dependencies = ../ACE/FilterBuilderDockWidget.h
FolderOpenDialog_h_dependencies = ../ACE/FolderOpenDialog.h
MainWindow_h_dependencies = ../ACE/MainWindow.h
ConnectionDialog_h_dependencies = ../ACE/ConnectionDialog.h
FilterBuilder_h_dependencies = ../ACE/FilterBuilder.h
ContentEditor_h_dependencies = ../ACE/ContentEditor.h
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertableview))
ace_moc_src: ../ACE/moc_foldertableview.cpp
../ACE/moc_foldertableview.cpp: ../ACE/foldertableview.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertableview.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertabledelegate))
ace_moc_src: ../ACE/moc_foldertabledelegate.cpp
../ACE/moc_foldertabledelegate.cpp: ../ACE/foldertabledelegate.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertabledelegate.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_miscDialogs))
ace_moc_src: ../ACE/moc_miscDialogs.cpp
../ACE/moc_miscDialogs.cpp: ../ACE/miscDialogs.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_miscDialogs.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_FilterEntry_BASE))
ace_moc_src: ../ACE/moc_ui_FilterEntry_BASE.cpp
../ACE/moc_ui_FilterEntry_BASE.cpp: ../ACE/ui_FilterEntry_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_FilterEntry_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_FilterBuilder_BASE))
ace_moc_src: ../ACE/moc_ui_FilterBuilder_BASE.cpp
../ACE/moc_ui_FilterBuilder_BASE.cpp: ../ACE/ui_FilterBuilder_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_FilterBuilder_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertablemodel))
ace_moc_src: ../ACE/moc_foldertablemodel.cpp
../ACE/moc_foldertablemodel.cpp: ../ACE/foldertablemodel.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertablemodel.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertabledockwidget))
ace_moc_src: ../ACE/moc_foldertabledockwidget.cpp
../ACE/moc_foldertabledockwidget.cpp: ../ACE/foldertabledockwidget.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertabledockwidget.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ACE_Errors))
ace_moc_src: ../ACE/moc_ACE_Errors.cpp
../ACE/moc_ACE_Errors.cpp: ../ACE/ACE_Errors.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ACE_Errors.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_ConnectionDialog_BASE))
ace_moc_src: ../ACE/moc_ui_ConnectionDialog_BASE.cpp
../ACE/moc_ui_ConnectionDialog_BASE.cpp: ../ACE/ui_ConnectionDialog_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_ConnectionDialog_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertreeitem))
ace_moc_src: ../ACE/moc_foldertreeitem.cpp
../ACE/moc_foldertreeitem.cpp: ../ACE/foldertreeitem.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertreeitem.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_MainWindow_BASE))
ace_moc_src: ../ACE/moc_ui_MainWindow_BASE.cpp
../ACE/moc_ui_MainWindow_BASE.cpp: ../ACE/ui_MainWindow_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_MainWindow_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertableitem))
ace_moc_src: ../ACE/moc_foldertableitem.cpp
../ACE/moc_foldertableitem.cpp: ../ACE/foldertableitem.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertableitem.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_ContentEditor_BASE))
ace_moc_src: ../ACE/moc_ui_ContentEditor_BASE.cpp
../ACE/moc_ui_ContentEditor_BASE.cpp: ../ACE/ui_ContentEditor_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_ContentEditor_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_accesstocool))
ace_moc_src: ../ACE/moc_accesstocool.cpp
../ACE/moc_accesstocool.cpp: ../ACE/accesstocool.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_accesstocool.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_FolderOpenDialog_BASE))
ace_moc_src: ../ACE/moc_ui_FolderOpenDialog_BASE.cpp
../ACE/moc_ui_FolderOpenDialog_BASE.cpp: ../ACE/ui_FolderOpenDialog_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_FolderOpenDialog_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_foldertreemodel))
ace_moc_src: ../ACE/moc_foldertreemodel.cpp
../ACE/moc_foldertreemodel.cpp: ../ACE/foldertreemodel.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_foldertreemodel.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ui_LineEdit_Dialog_BASE))
ace_moc_src: ../ACE/moc_ui_LineEdit_Dialog_BASE.cpp
../ACE/moc_ui_LineEdit_Dialog_BASE.cpp: ../ACE/ui_LineEdit_Dialog_BASE.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ui_LineEdit_Dialog_BASE.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_FilterEntry))
ace_moc_src: ../ACE/moc_FilterEntry.cpp
../ACE/moc_FilterEntry.cpp: ../ACE/FilterEntry.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_FilterEntry.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_FilterBuilderDockWidget))
ace_moc_src: ../ACE/moc_FilterBuilderDockWidget.cpp
../ACE/moc_FilterBuilderDockWidget.cpp: ../ACE/FilterBuilderDockWidget.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_FilterBuilderDockWidget.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_FolderOpenDialog))
ace_moc_src: ../ACE/moc_FolderOpenDialog.cpp
../ACE/moc_FolderOpenDialog.cpp: ../ACE/FolderOpenDialog.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_FolderOpenDialog.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_MainWindow))
ace_moc_src: ../ACE/moc_MainWindow.cpp
../ACE/moc_MainWindow.cpp: ../ACE/MainWindow.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_MainWindow.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ConnectionDialog))
ace_moc_src: ../ACE/moc_ConnectionDialog.cpp
../ACE/moc_ConnectionDialog.cpp: ../ACE/ConnectionDialog.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ConnectionDialog.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_FilterBuilder))
ace_moc_src: ../ACE/moc_FilterBuilder.cpp
../ACE/moc_FilterBuilder.cpp: ../ACE/FilterBuilder.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_FilterBuilder.cpp
endif
#--- moc fragment end
#--- moc fragment begin
# do not run moc on uic-generated files
ifeq (,$(findstring _begin_ui_,_begin_ContentEditor))
ace_moc_src: ../ACE/moc_ContentEditor.cpp
../ACE/moc_ContentEditor.cpp: ../ACE/ContentEditor.h
	moc $^ -o $@
ace_moc_srcclean::
	$(RM) ../ACE/moc_ContentEditor.cpp
endif
#--- moc fragment end
#-- start of cleanup_header --------------

clean :: ace_moc_srcclean ;
#	@cd .

ifndef PEDANTIC
.DEFAULT::
	$(echo) "(ace_moc_src.make) $@: No rule for such target" >&2
else
.DEFAULT::
	$(error PEDANTIC: $@: No rule for such target)
endif

ace_moc_srcclean ::
#-- end of cleanup_header ---------------
