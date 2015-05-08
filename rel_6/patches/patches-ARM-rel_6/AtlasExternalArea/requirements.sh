#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasExternalArea
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasExternalArea/cmt
patch -b < $patch_dir/*.patch
