#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasDSFMT
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasDSFMT/cmt
patch -b < $patch_dir/*.patch
