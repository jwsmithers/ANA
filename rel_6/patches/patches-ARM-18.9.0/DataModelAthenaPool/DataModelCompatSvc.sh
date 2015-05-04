#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/DataModelAthenaPool
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/DataModelAthenaPool/src
patch -b < $patch_dir/*.patch
