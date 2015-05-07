#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/Control/CxxUtils/CxxUtils
patch -b < $patch_dir/*.patch
