#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/Hephaestus 
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/Hephaestus/src
patch -b < $patch_dir/*.patch
