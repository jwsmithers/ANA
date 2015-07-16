#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasCLHEP
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasCLHEP/cmt
patch -b < $patch_dir/*.patch
