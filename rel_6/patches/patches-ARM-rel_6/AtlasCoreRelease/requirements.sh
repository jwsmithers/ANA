#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasCoreRelease
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/AtlasCoreRelease/cmt
patch -b < $patch_dir/*.patch
