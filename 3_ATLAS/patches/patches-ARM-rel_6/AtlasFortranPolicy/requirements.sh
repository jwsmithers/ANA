#!/bin/sh
cd $TopDir/../patches/patches-ARM-rel_6/AtlasFortranPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/AtlasFortranPolicy/cmt
patch -b < $patch_dir/*.patch
