#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/MissingETGoodness
patch_dir=`pwd`
cd $TopDir/AtlasAnalysis/rel_6/Reconstruction/MissingETGoodness/cmt
patch -b < $patch_dir/*.patch
