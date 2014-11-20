#!/bin/bash
cd $TopDir/../patches/Hephaestus 
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/Hephaestus/src
patch -b < $patch_dir/*.patch
