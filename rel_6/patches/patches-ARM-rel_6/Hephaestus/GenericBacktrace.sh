#!/bin/bash
cd $TopDir/patches/patches-ARM-rel_6/Hephaestus 
patch_dir=`pwd`
cd $TopDir/AtlasCore/rel_6/Control/Hephaestus/src
patch -b < $patch_dir/*.patch
