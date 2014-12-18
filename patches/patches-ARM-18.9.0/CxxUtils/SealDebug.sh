#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/CxxUtils/src
patch -b < $patch_dir/SealDebug.patch
