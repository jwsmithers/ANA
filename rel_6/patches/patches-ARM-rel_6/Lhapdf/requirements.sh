#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/Lhapdf
patch_dir=`pwd`
cd $TopDir/AtlasEvent/rel_6/External/Lhapdf/cmt
patch -b < $patch_dir/*.patch
