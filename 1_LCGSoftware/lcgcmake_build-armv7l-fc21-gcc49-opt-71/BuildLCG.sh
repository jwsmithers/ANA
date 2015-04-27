#!/bin/sh
LCGbuildDir=`pwd`
cmake -DCMAKE_INSTALL_PREFIX=$LCGbuildDir/../lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS $LCGbuildDir/../Lcgcmake
make -j4 -k
cd ../lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS $LCGbuildDir/cmt/*/$CMTCONFIG/CMT/*/mgr
echo "Installing cmt..."
echo ""
source setup.sh
make
echo "Patching LCG cmt requirements files..."
echo ""
cd $LCGbuildDir/../patches/LCGCMT/LCGCMT_Platforms
source requirements.sh
cd $LCGbuildDir
