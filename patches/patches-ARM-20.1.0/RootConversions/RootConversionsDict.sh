#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/RootConversions
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Database/AthenaPOOL/RootConversions/RootConversions
patch -b < $patch_dir/RootConversionsDict.patch
