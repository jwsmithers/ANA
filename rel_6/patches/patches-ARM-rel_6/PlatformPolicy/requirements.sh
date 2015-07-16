#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/PlatformPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/PlatformPolicy/cmt
patch -b < $patch_dir/*.patch
