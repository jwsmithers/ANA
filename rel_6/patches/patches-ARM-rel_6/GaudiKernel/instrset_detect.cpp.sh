#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/GaudiKernel
patch_dir=`pwd`
cd $TopDir/GAUDI/rel_6/GaudiKernel/src/Lib
patch -b < $patch_dir/*.patch
