#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/RootUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/RootUtils/cmt
patch -b < $patch_dir/*.patch
