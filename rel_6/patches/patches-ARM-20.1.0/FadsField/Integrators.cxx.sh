#!/bin/sh
cd $TopDir/../patches/patches-ARM-20.1.0/FadsField
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/AtlasSimulation-20.1.0/Simulation/G4Sim/FADS/FadsField/src
patch -b < $patch_dir/*.patch
