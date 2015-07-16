#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasLzo
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasLzo/cmt
patch -b < $patch_dir/*.patch
