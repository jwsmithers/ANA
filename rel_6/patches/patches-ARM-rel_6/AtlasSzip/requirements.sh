#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasSzip
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasSzip/cmt
patch -b < $patch_dir/*.patch
