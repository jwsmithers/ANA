#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasGdb
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasGdb/cmt
patch -b < $patch_dir/requirements.patch
