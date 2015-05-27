#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/JetSubStructureUtils
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/rel_6/Reconstruction/Jet/JetSubStructureUtils/Root
patch -b < $patch_dir/*.patch
