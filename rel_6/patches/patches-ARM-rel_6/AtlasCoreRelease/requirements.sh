#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasCoreRelease
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/AtlasCoreRelease/cmt
patch -b < $patch_dir/*.patch
