#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/AtlasFortranPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/AtlasFortranPolicy/cmt
patch -b < $patch_dir/*.patch
