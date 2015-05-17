#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasFastJet
patch_dir=`pwd`
cd $TopDir/AtlasEvent/rel_6/External/AtlasFastJet/cmt
patch -b < $patch_dir/*.patch
