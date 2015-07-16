#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/AtlasLibUnwind
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasLibUnwind/cmt
patch -b < $patch_dir/*.patch
