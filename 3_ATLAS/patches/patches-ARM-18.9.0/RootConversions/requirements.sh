#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/RootConversions
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Database/AthenaPOOL/RootConversions/cmt
patch -b < $patch_dir/requirements.patch
