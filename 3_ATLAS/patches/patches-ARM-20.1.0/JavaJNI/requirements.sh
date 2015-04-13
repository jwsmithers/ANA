#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/JavaJNI
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasConditions-20.1.0/External/JavaJNI/cmt
patch -b < $patch_dir/*.patch
