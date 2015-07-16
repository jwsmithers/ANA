#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/JetSubStructureUtils
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/$VERSION/Reconstruction/Jet/JetSubStructureUtils/Root
patch -b < $patch_dir/*.patch
