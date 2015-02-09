#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/TrkMaterialsOnTrack
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasConditions-20.1.0/Tracking/TrkEvent/TrkMaterialOnTrack/cmt
patch -b < $patch_dir/*.patch
