#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasCompilers
patch_dir=`pwd`
cd $TopDir/DetCommon/rel_6/External/AtlasCompilers/cmt
patch -b < $patch_dir/requirements.patch
