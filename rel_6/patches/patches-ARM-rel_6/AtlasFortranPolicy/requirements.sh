#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasFortranPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/AtlasFortranPolicy/cmt
patch -b < $patch_dir/*.patch
