#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/AtlasPolicy/cmt
patch -b < $patch_dir/*.patch
#Don't create a backup of this one
