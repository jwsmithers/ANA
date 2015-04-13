#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/DetCommonExternal
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-20.1.0/External/AtlasCompilers/cmt
patch -b < $patch_dir/*.patch
