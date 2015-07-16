#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AthenaAuditors
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/Control/AthenaAuditors/src
patch -b < $patch_dir/FPEAuditor.cxx.patch
