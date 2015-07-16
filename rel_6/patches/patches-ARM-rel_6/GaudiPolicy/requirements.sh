#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/GaudiPolicy
patch_dir=`pwd`
cd $TopDir/GAUDI/$VERSION/GaudiPolicy/cmt
patch -b < $patch_dir/requirements.patch
