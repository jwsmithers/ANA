#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/GaudiExamples
patch_dir=`pwd`
cd $TopDir/GAUDI/$VERSION/GaudiExamples/cmt
mv ../src/MultiInput/DumpAddress.cpp ../src/MultiInput/DumpAddress.cpp~
mv ../src/MultiInput/MIReadAlg.h ../src/MultiInput/MIReadAlg.h~
mv ../src/MultiInput/MIReadAlg.cpp ../src/MultiInput/MIReadAlg.cpp~
