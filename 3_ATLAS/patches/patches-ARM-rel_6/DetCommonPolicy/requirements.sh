#!/bin/bash
cd $TopDir/../patches/patches-ARM-rel_6/DetCommonPolicy
patch_dir=`pwd`
cd $TopDir/DetCommon/DetCommon-rel_6/DetCommonPolicy/cmt
patch -b < $patch_dir/*.patch
