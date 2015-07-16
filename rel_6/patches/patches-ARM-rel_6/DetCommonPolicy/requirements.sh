#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/DetCommonPolicy
patch_dir=`pwd`
cd $TopDir/DetCommon/$VERSION/DetCommonPolicy/cmt
patch -b < $patch_dir/*.patch
