#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/ROOT-v34-21
patch_dir=`pwd`
cd $LCG_install/ROOT/v5-34-21/armv7l-fc21-gcc49-opt/include/Reflex/Builder
patch -b < $patch_dir/*.patch
#Don't create a backup of this one
