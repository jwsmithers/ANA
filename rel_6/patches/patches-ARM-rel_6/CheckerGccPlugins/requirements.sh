#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/CheckerGccPlugins
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/CheckerGccPlugins/cmt
patch -b < $patch_dir/*.patch
