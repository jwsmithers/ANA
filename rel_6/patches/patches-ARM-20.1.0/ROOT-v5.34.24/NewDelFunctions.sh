#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/ROOT-v5.34.24
patch_dir=`pwd`
cd $LCG_install/ROOT/5.34.24/armv7l-fc21-gcc49-opt/include/Reflex/Builder
patch -b < $patch_dir/*.patch
#Don't create a backup of this one
