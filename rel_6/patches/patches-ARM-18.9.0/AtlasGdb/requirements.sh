#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/AtlasGdb
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/External/AtlasGdb/cmt
patch -b < $patch_dir/*.patch
