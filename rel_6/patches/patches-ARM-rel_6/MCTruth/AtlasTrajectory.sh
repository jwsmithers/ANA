#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/MCTruth
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/rel_6/Simulation/G4Sim/MCTruth/MCTruth
patch -b < $patch_dir/*.patch
