#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/GaudiKernel
patch_dir=`pwd`
cd $TopDir/GAUDI/$VERSION/GaudiKernel/src/Lib
patch -b < $patch_dir/*.patch
