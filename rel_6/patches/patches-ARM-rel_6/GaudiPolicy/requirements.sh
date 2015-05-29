#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/GaudiPolicy
patch_dir=`pwd`
cd $TopDir/GAUDI/rel_6/GaudiPolicy/cmt
patch -b < $patch_dir/requirements.patch
