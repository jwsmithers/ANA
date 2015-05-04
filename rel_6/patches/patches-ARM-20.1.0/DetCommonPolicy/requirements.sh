#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/DetCommonPolicy
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-20.1.0/DetCommonPolicy/cmt
patch -b < $patch_dir/*.patch
