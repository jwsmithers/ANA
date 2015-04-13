#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasEigen
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/External/AtlasEigen/cmt
patch -b < $patch_dir/*.patch
#Don't create a backup of this one
