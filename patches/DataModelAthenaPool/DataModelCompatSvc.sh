#!/bin/bash
cd $TopDir/../patches/DataModelAthenaPool
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/DataModelAthenaPool/src
patch -b < $patch_dir/*.patch
