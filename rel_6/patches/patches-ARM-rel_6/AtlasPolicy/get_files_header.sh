#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/AtlasPolicy/cmt/fragments
patch -b < $patch_dir/get_files_header.patch
#Don't create a backup of this one
