#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/GaudiCLHEP
patch_dir=`pwd`
cd $TopDir/GAUDI/rel_6/LCG_Interfaces/CLHEP/cmt
patch -b < $patch_dir/requirements.patch
