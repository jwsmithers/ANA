#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export ROOTDIR=/home/jwsmith/HDD/ANA/ANA
export CMTCONFIG=armv7l-fc21-gcc49-opt
export CMAKECONFIG=armv7l-fc21-gcc49-opt
export LCGCMT_VERS=71

##LCG
export LCG_install=$ROOTDIR/1_LCGSoftware/lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS
##CORAL
export CORALDir=$ROOTDIR/1a_CORAL/CORAL-2-4-2
export CORAL_include=$CORALDir/../$CMTCONFIG/include
##COOL
export COOLDir=$ROOTDIR/1b_COOL/COOL_2_9_2
export COOL_include=$COOLDir/../$CMTCONFIG/include
##Gaudi
export GaudiDir=$ROOTDIR/2_GAUDI/Gaudi
