#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasCxxPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/AtlasCxxPolicy/cmt
patch -b < $patch_dir/*.patch
