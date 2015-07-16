#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/Geant4
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/$VERSION/External/Geant4/cmt
patch -b < $patch_dir/*.patch
