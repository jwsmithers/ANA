#!/bin/bash
cd $LCG_install/../patches/LCGCMT/LCGCMT_$LCGCMT_VERS
patch_dir=`pwd`
cd $LCG_install/LCGCMT/LCGCMT_$LCGCMT_VERS/LCG_Platforms/cmt
patch -b < $patch_dir/*.patch
