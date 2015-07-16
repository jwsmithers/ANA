#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/GaudiProfiling
patch_dir=`pwd`
cd $TopDir/GAUDI/$VERSION/GaudiProfiling/cmt
patch -b < $patch_dir/requirements.patch
