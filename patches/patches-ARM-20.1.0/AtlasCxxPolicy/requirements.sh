#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasCxxPolicy
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/AtlasCxxPolicy
patch -b < $patch_dir/*.patch
