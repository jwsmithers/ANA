#!/bin/sh
cd $TopDir/../patches/patches-ARM-rel_6/AthenaAuditors
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/Control/AthenaAuditors/src
patch -b < $patch_dir/*.patch
