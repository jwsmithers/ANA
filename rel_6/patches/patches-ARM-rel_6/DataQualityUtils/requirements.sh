#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/DataQualityUtils
patch_dir=`pwd`
cd $TopDir/AtlasAnalysis/$VERSION/DataQuality/DataQualityUtils/cmt
patch -b < $patch_dir/*.patch
