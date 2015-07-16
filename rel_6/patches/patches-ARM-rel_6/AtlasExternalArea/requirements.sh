#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasExternalArea
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasExternalArea/cmt
patch -b < $patch_dir/*.patch
