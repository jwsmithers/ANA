#!/bin/sh
cd $TopDir/../patches/patches-ARM-rel_6/AtlasCxxPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/AtlasCxxPolicy/cmt
patch -b < $patch_dir/*.patch
