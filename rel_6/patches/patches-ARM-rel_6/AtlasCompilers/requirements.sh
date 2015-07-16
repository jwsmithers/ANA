#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasCompilers
patch_dir=`pwd`
cd $TopDir/DetCommon/$VERSION/External/AtlasCompilers/cmt
patch -b < $patch_dir/requirements.patch
