#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/AtlasPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/AtlasPolicy/cmt/fragments
patch -b < $patch_dir/get_files_header.patch
#Don't create a backup of this one
