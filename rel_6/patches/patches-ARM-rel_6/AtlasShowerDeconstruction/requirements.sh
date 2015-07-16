#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasShowerDeconstruction
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/$VERSION/External/AtlasShowerDeconstruction/cmt/
patch -b < $patch_dir/requirements.patch
source $TopDir/patches/patches-ARM-$VERSION/AtlasShowerDeconstruction/src.sh
