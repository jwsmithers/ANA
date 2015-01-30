#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/CollectionUtilities
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Database/APR/CollectionUtilities/cmt
patch -b < $patch_dir/*.patch
