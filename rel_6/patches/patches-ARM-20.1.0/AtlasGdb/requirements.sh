#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasGdb
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/External/AtlasGdb/cmt
patch -b < $patch_dir/*.patch
