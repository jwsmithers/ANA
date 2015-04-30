#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/CheckerGccPlugins
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/External/CheckerGccPlugins/cmt
patch -b < $patch_dir/*.patch
