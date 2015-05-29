#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/GaudiExamples
patch_dir=`pwd`
cd $TopDir/GAUDI/rel_6/GaudiExamples/cmt
mv ../src/MultiInput/DumpAddress.cpp ../src/MultiInput/DumpAddress.cpp~
mv ../src/MultiInput/MIReadAlg.h ../src/MultiInput/MIReadAlg.h~
mv ../src/MultiInput/MIReadAlg.cpp ../src/MultiInput/MIReadAlg.cpp~
