#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/AtlasPolicy/cmt/fragments
patch < $patch_dir/get_files_header.patch
#Don't create a backup of this one
