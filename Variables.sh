#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export ROOTDIR=/home/jwsmith/ANA
export CMTCONFIG=aarch64-ubuntu14.04-gcc49-opt
export CMAKECONFIG=aarch64-ubuntu14.04-gcc49-opt
export LCGCMT_VERS=74root6
#export CORAL_VERS=CORAL_3_0_3
#export COOL_VERS=COOL_3_0_3


##LCG
export LCG_install=/home/seuster/LCGStack/lcgcmake-install
##CORAL
#export CORALDir=$ROOTDIR/1a_CORAL/$CORAL_VERS
#export CORAL_include=$CORALDir/../$CMTCONFIG/include
##COOL
#export COOLDir=$ROOTDIR/1b_COOL/$COOL_VERS
#export COOL_include=$COOLDir/../$CMTCONFIG/include
##Gaudi
export GaudiDir=$ROOTDIR/2_GAUDI/GAUDI/

export SW_Extras=$ROOTDIR/sw_extras
