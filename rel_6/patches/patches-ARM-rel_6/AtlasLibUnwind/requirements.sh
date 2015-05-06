#!/bin/bash
cd $TopDir/patches/patches-ARM-rel_6/AtlasLibUnwind
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasLibUnwind/cmt
patch -b < $patch_dir/*.patch
