#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/JetRecTools
patch_dir=`pwd`
cd $TopDir/AtlasReconstruction/$VERSION/Reconstruction/Jet/JetRecTools/Root
patch -b < $patch_dir/*.patch
