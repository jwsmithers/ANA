#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/GaudiCLHEP
patch_dir=`pwd`
cd $TopDir/GAUDI/$VERSION/LCG_Interfaces/CLHEP/cmt
patch -b < $patch_dir/requirements.patch
