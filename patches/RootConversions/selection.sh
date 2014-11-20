#!/bin/bash
cd $TopDir/../patches/RootConversions
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Database/AthenaPOOL/RootConversions/RootConversions
patch -b < $patch_dir/selection.patch
