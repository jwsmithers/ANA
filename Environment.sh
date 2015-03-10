#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export ROOTDIR=/home/jwsmith/HDD
export CMTCONFIG=armv7l-fc21-gcc49-opt
source $ROOTDIR/lcgcmake-install-gcc49/cmt/v1r26p20140131/$CMTCONFIG/CMT/v1r26p20140131/mgr/setup.sh
export CMTBIN=Linux-armv7l
export CMTSITE=STANDALONE
export SVNROOT=svn+ssh://jwsmith@svn.cern.ch/reps/atlasoff
export VERSION=20.1.0
export LCGCMT_VERS=LCGCMT_71
export TopDir=$ROOTDIR/AtlasOfflineBuild-framework/InstallArea
#export AntVersion=1.9.4

##COOL
export COOLDir=$ROOTDIR/COOL/COOL_2_9_2
export COOL_include=$ROOTDIR/COOL/$CMTCONFIG/include
##CORAL
export CORALDir=$ROOTDIR/CORAL/CORAL-2-4-2
export CORAL_include=$ROOTDIR/CORAL/$CMTCONFIG/include
##LCG
export LCG_install=$ROOTDIR/lcgcmake-install-gcc49
##Gaudi
export GaudiDir=$ROOTDIR/Gaudi

#Java
export CPLUS_INCLUDE_PATH=/usr/lib/jvm/$JAVAVERS/include:/usr/lib/jvm/$JAVAVERS/include/linux:$CPLUS_INCLUDE_PATH
#gcc-xml-plugin
#tbb
export CPLUS_INCLUDE_PATH=$LCG_install/tbb/42_20140122/$CMTCONFIG/include:$CPLUS_INCLUDE_PATH

#Geant4
export CPLUS_INCLUDE_PATH=$ROOTDIR/geant4_install/include/Geant4:$CPLUS_INCLUDE_PATH

