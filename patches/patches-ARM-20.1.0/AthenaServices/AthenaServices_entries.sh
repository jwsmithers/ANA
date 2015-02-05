#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/Control/AthenaServices
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/AthenaServices/src/components
patch -b < $patch_dir/*.patch
