#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/Xt
patch_dir=`pwd`
cd $TopDir/AtlasConditions/AtlasConditions-20.1.0/External/Xt/cmt
patch -b < $patch_dir/*.patch
