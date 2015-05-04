#!/bin/bash
cd $TopDir/patches/patches-ARM-rel_6/AtlasTBB
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasTBB/cmt
patch -b < $patch_dir/*.patch
