#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/Hephaestus 
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/Hephaestus/src
patch -b < $patch_dir/*.patch
