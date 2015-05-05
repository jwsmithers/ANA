#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/RootCollection
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/Database/APR/RootCollection/src
patch -b < $patch_dir/*.patch
