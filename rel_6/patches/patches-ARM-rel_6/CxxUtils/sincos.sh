#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/Control/CxxUtils/CxxUtils
patch -b < $patch_dir/*.patch
