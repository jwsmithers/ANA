#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/RootConversions
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Database/AthenaPOOL/RootConversions/src
patch -b < $patch_dir/TConverterRegistry.patch
