#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AthenaKernel
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/AthenaKernel/cmt
patch -b < $patch_dir/*.patch
