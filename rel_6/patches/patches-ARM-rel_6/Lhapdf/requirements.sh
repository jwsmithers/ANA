#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/Lhapdf
patch_dir=`pwd`
cd $TopDir/AtlasEvent/$VERSION/External/Lhapdf/cmt
patch -b < $patch_dir/*.patch
