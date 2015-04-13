#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/DQUtils
patch_dir=`pwd`
cd $TopDir/AtlasConditions/AtlasConditions-18.9.0/DataQuality/DQUtils/cmt
patch -b < $patch_dir/*.patch
