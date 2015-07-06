#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/DataQualityUtils
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/rel_6/DataQuality/DataQualityUtils/cmt
patch -b < $patch_dir/*.patch
