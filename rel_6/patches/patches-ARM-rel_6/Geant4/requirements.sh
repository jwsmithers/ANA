#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/Geant4
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/rel_6/External/Geant4/cmt
patch -b < $patch_dir/*.patch
