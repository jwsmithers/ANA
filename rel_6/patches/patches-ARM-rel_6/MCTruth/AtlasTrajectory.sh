#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/MCTruth
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/$VERSION/Simulation/G4Sim/MCTruth/MCTruth
patch -b < $patch_dir/*.patch
