#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/CxxUtils/CxxUtils
patch -b < $patch_dir/*.patch
