#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/JetRecTools
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/rel_6/Reconstruction/Jet/JetRecTools/Root
patch -b < $patch_dir/*.patch
