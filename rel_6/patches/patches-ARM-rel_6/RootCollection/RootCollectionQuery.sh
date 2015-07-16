#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/RootCollection
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/Database/APR/RootCollection/src
patch -b < $patch_dir/*.patch
