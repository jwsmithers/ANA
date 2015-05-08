#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasDSFMT
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasDSFMT/cmt
patch -b < $patch_dir/*.patch
