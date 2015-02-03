#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/DataModelAthenaPool
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/DataModelAthenaPool/src
patch -b < $patch_dir/*.patch
