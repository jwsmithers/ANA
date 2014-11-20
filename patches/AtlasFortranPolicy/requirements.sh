#!/bin/bash
cd $TopDir/../patches/AtlasFortranPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/AtlasFortranPolicy/cmt
patch -b < $patch_dir/*.patch
