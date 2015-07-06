#!/bin/sh
cd $TopDir/patches/patches-ARM-rel_6/TrigEgammaAnalysisTools
patch_dir=`pwd`
cd $TopDir/AtlasSimulation/rel_6/Trigger/TrigAnalysis/TrigEgammaAnalysisTools/Root
patch -b < $patch_dir/TrigEgammaNavZeeTPNtuple.cxx.patch
