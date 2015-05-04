#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/AtlasSealCLHEP
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Database/AtlasSealCLHEP/AtlasSealCLHEP
patch -b < $patch_dir/CLHEP_Random.patch
