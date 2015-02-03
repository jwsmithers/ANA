#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasCLHEP_RandomGenerators
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Simulation/Tools/AtlasCLHEP_RandomGenerators/cmt
patch -b < $patch_dir/*.patch
