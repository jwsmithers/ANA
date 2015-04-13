#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/AtlasCompilers
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-18.9.0/External/AtlasCompilers/cmt
patch -b < $patch_dir/*.patch

