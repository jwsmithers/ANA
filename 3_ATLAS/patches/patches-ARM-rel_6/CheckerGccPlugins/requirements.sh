#!/bin/bash
cd $TopDir/../patches/patches-ARM-rel_6/CheckerGccPlugins
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/External/CheckerGccPlugins/cmt
patch -b < $patch_dir/*.patch
