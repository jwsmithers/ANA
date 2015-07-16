#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasFastJet
patch_dir=`pwd`
cd $TopDir/AtlasEvent/$VERSION/External/AtlasFastJet/cmt
patch -b < $patch_dir/*.patch
