#!/bin/sh
################################################################################################
#                               Joshua Wyatt Smith                                             #
#                               joshua.wyatt.smith@cern.ch                                     #
################################################################################################
export ROOTDIR=/home/jwsmith/ANA
export CMTCONFIG=aarch64-ubuntu14-gcc49-opt
export CMAKECONFIG=aarch64-ubuntu14-gcc49-opt
export LCGCMT_VERS=75root6

source /home/jwsmith/CMT/*/mgr/setup.sh
#source /home/jwsmith/lcgcmake-install/cmt/v1r20p20090520/aarch64-ubuntu14-gcc49-opt/CMT/v1r20p20090520/mgr/setup.sh
export CMTBIN=Linux-aarch64
export CMTSITE=STANDALONE
CMTEXTRATAGS=no-separate-debug
export SVNROOT=svn+ssh://svn.cern.ch/reps/atlasoff
export VERSION=rel_6
export LCGCMT_VERS=LCGCMT_75root6
export TopDir=$ROOTDIR/$VERSION
##LCG
export LCG_install=/home/jwsmith/lcgcmake-install
##Gaudi
export GaudiDir=$ROOTDIR/GAUDI/GAUDI/rel_6
export SW_Extras=$ROOTDIR/sw_extras

###### Temporary Path amendums #######
#yampl
export CPLUS_INCLUDE_PATH=/home/seuster/external/yampl/aarch64-ubuntu14.04-gcc49-opt/include:$CPLUS_INCLUDE_PATH

#tdaq-common
export CPLUS_INCLUDE_PATH=/home/jwsmith/ANA/rel_6/tdaq-common/tdaq-common-01-32-00/installed/include:$CPLUS_INCLUDE_PATH
#CLHEP
export CPLUS_INCLUDE_PATH=/home/jwsmith/lcgcmake-install/clhep/2.1.4.1/aarch64-ubuntu14-gcc49-opt/include:$CPLUS_INCLUDE_PATH

#tbb
export CPLUS_INCLUDE_PATH=/home/jwsmith/lcgcmake-install/tbb/42_20140122/aarch64-ubuntu14-gcc49-opt/include:$CPLUS_INCLUDE_PATH

#Python
export CPLUS_INCLUDE_PATH=/home/jwsmith/lcgcmake-install/Python/2.7.9/aarch64-ubuntu14-gcc49-opt/include/python2.7:$CPLUS_INCLUDE_PATH

#libunwind&gperf
export CPLUS_INCLUDE_PATH=/home/jwsmith/libunwind-install/include:/home/jwsmith/gperftools-install/include:$CPLUS_INCLUDE_PATH

#dSFMT
export CPLUS_INCLUDE_PATH=/home/seuster/external/dSFMT/dSFMT-2.2/aarch64-ubuntu14.04-gcc49-opt/include:$CPLUS_INCLUDE_PATH
