#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasShowerDeconstruction
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/rel_6/External/AtlasShowerDeconstruction/cmt/
patch -b < $patch_dir/*.patch
