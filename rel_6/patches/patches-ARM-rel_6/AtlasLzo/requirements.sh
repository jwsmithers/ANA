#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasLzo
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasLzo/cmt
patch -b < $patch_dir/*.patch
