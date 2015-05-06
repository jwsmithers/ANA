#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasSzip
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasSzip/cmt
patch -b < $patch_dir/*.patch
