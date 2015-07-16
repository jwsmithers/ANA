#!/bin/sh
cd $TopDir/patches/patches-ARM-$VERSION/TrigEgammaAnalysisTools
patch_dir=`pwd`
cd $TopDir/AtlasAnalysis/$VERSION/Trigger/TrigAnalysis/TrigEgammaAnalysisTools/Root
patch -b < $patch_dir/TrigEgammaNavZeeTPNtuple.cxx.patch
