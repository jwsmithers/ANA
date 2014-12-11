#!/bin/bash
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export ROOTDIR=/home/jwsmith/HDD
source $ROOTDIR/CMT/v1r26p20140131/mgr/setup.sh
export CMTCONFIG=armv7l-fc21-gcc49-opt
export CMTBIN=Linux-armv7l
export CMTSITE=STANDALONE
export SVNROOT=svn+ssh://jwsmith@svn.cern.ch/reps/atlasoff
export VERSION=19.3.0
export LCGCMT_VERS=LCGCMT_67b
export TopDir=$ROOTDIR/AtlasOfflineBuild-framework/InstallArea
export AntVersion=1.9.4

##COOL
export COOLDir=$ROOTDIR/COOL/COOL_2_9_2
export COOL_include=$ROOTDIR/COOL/$CMTCONFIG/include
##CORAL
export CORALDir=$ROOTDIR/CORAL/CORAL_2_4_2
export CORAL_include=$ROOTDIR/CORAL/$CMTCONFIG/include
##LCG
export LCG_install=$ROOTDIR/lcgcmake-install
##Gaudi
export GaudiDir=$ROOTDIR/Gaudi

#Java
export CPLUS_INCLUDE_PATH=/usr/lib/jvm/$JAVAVERS/include:/usr/lib/jvm/$JAVAVERS/include/linux:$CPLUS_INCLUDE_PATH

