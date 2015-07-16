#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/AtlasTBB
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasTBB/cmt
patch -b < $patch_dir/*.patch
