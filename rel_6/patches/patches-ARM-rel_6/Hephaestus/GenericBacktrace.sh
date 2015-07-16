#!/bin/bash
cd $TopDir/patches/patches-ARM-$VERSION/Hephaestus 
patch_dir=`pwd`
cd $TopDir/AtlasCore/$VERSION/Control/Hephaestus/src
patch -b < $patch_dir/*.patch
