#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasGdb
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/External/AtlasGdb/cmt
patch -b < $patch_dir/requirements.patch
