#!/bin/bash
#DetCommon
ln -s $ROOTDIR/COOL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-18.9.0/InstallArea/$CMTCONFIG/lib/
ln -s $ROOTDIR/CORAL/$CMTCONFIG/lib/* $TopDir/DetCommon/DetCommon-18.9.0/InstallArea/$CMTCONFIG/lib/

#AtlasCore
ln -s $LCG_install/pytools/1.8_python2.7/share/sources/pyxml/xml $TopDir/AtlasCore/AtlasCore-18.9.0/TestPolicy/python

ln -s $LCG_install/ROOT/v5-34-21/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/uuid/1.42/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/XercesC/3.1.1p1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/$CMTCONFIG/lib/
ln -s $LCG_install/libunwind/1.1/$CMTCONFIG/lib/* $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/$CMTCONFIG/lib/

ln -s $LCG_install/tcmalloc/1.7p3/$CMTCONFIG/include/google $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/include
ln -s $LCG_install/tcmalloc/1.7p3/$CMTCONFIG/include/gperftools $TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/include
