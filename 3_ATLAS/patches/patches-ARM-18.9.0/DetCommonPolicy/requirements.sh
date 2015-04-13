#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/DetCommonPolicy
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-18.9.0/DetCommonPolicy/cmt
patch -b < $patch_dir/*.patch
