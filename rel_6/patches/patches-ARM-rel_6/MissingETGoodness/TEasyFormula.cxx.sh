#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/MissingETGoodness
patch_dir=`pwd`
cd $TopDir/AtlasAnalysis/$VERSION/Reconstruction/MissingETGoodness/cmt
patch -b < $patch_dir/*.patch
