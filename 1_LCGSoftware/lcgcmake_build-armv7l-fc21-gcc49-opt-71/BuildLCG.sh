#!/bin/sh
LCGbuildDir=`pwd`
cmake -DCMAKE_INSTALL_PREFIX=$LCGbuildDir/../lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS $LCGbuildDir/../Lcgcmake
make -j4 -k
