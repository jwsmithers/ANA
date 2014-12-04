#!/bin/bash
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export TCMALLOCDIR=/home/jwsmith/HDD/lcgcmake-install/tcmalloc/1.7p3/$CMTCONFIG/lib
export PATH=$PATH:$TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/share/bin
export PYTHONPATH=$PYTHONPATH:$ROOTDIR/Gaudi/InstallArea/$CMTCONFIG/jobOptions:$TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/jobOptions:$TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/python:$TopDir/AtlasCore/AtlasCore-18.9.0/Control/AthenaCommon/AthenaCommon-02-18-27/python:$ROOTDIR/Gaudi/InstallArea/$CMTCONFIG/python
export JOBOPTSEARCHPATH=$JOBOPTSEARCHPATH:$ROOTDIR/Gaudi/InstallArea/$CMTCONFIG/jobOptions:$TopDir/AtlasCore/AtlasCore-18.9.0/InstallArea/jobOptions
source $ROOTDIR/lcgcmake-install/ROOT/v5-34-21/$CMTCONFIG/bin/thisroot.sh
