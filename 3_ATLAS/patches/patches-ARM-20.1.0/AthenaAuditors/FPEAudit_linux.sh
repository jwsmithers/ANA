#!/bin/sh
cd $TopDir/../patches/patches-ARM-20.1.0/AthenaAuditors
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/AthenaAuditors/src
patch -b < $patch_dir/*.patch
