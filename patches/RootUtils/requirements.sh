#!/bin/bash
cd $TopDir/../patches/RootUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/RootUtils/cmt
patch -b < $patch_dir/*.patch
