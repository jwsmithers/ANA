#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/GaudiProfiling
patch_dir=`pwd`
cd $TopDir/GAUDI/rel_6/GaudiProfiling/cmt
patch -b < $patch_dir/requirements.patch
