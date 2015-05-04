#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
#source $LCG_install/cmt/*/$CMTCONFIG/CMT/*/mgr//setup.sh
source /home/jwsmith/CMT/*/mgr/setup.sh
export CMTBIN=Linux-aarch64
export CMTSITE=STANDALONE
export SVNROOT=svn+ssh://svn.cern.ch/reps/atlasoff
export VERSION=rel_6
export LCGCMT_VERS=LCGCMT_74root6
export TopDir=$ROOTDIR/3_ATLAS/InstallArea


#CLHEP
export CPLUS_INCLUDE_PATH=/home/seuster/LCGStack/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14.04-gcc49-opt/include:$CPLUS_INCLUDE_PATH

#libunwind&gperf

export CPLUS_INCLUDE_PATH=/home/jwsmith/libunwind-install/include:/home/jwsmith/gperftools-install/include:$CPLUS_INCLUDE_PATH

#export AntVersion=1.9.4

#Java
#export JAVAVERS=java-1.5.0-gcj-4.9-arm64
#export CPLUS_INCLUDE_PATH=/usr/lib/jvm/$JAVAVERS/include:/usr/lib/jvm/$JAVAVERS/include/linux:$CPLUS_INCLUDE_PATH

#Python
#export CPLUS_INCLUDE_PATH=$LCG_install/Python/2.7.6/$CMTCONFIG/include/python2.7:$CPLUS_INCLUDE_PATH
#gcc-xml-plugin
#tbb
#export CPLUS_INCLUDE_PATH=$LCG_install/tbb/42_20140122/$CMTCONFIG/include:$CPLUS_INCLUDE_PATH

#Geant4
#export CPLUS_INCLUDE_PATH=$ROOTDIR/geant4_install/include/Geant4:$CPLUS_INCLUDE_PATH

# Qt4
#export QMAKESPEC=/usr/lib/qt4/mkspecs/linux-arm-gnueabi-g++

