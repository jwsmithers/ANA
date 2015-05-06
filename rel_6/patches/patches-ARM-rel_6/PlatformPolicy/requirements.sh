#!/bin/bash
cd $TopDir/patches/patches-ARM-rel_6/PlatformPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/PlatformPolicy/cmt
patch -b < $patch_dir/*.patch
