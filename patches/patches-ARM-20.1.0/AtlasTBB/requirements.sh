#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasTBB
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/External/AtlasTBB/cmt
patch -b < $patch_dir/*.patch
