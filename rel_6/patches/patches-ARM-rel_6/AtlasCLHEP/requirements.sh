#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/AtlasCLHEP
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/AtlasCLHEP/cmt
patch -b < $patch_dir/*.patch
