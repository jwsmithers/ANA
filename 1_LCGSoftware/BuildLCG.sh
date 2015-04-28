#!/bin/sh
LCGbuildDir=`pwd`
mkdir lcgcmake_build-$CMTCONFIG-$LCGCMT_VERS
mkdir lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS
cd lcgcmake_build-$CMTCONFIG-$LCGCMT_VERS
cmake -DCMAKE_INSTALL_PREFIX=$LCGbuildDir/lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS $LCGbuildDir/Lcgcmake-$LCGCMT_VERS
make -j4 -k
cd ../lcgcmake_install-$CMTCONFIG-$LCGCMT_VERS/cmt/*/$CMTCONFIG/CMT/*/mgr
echo "Installing cmt..."
echo ""
source setup.sh
make
echo "Patching LCG cmt requirements files..."
echo ""
cd $LCGbuildDir/patches/LCGCMT/LCGCMT_Platforms
source requirements.sh
cd $LCGbuildDir
