#!/bin/sh
cd $TopDir/../patches/patches-ARM-20.1.0/PerformanceMonitoring
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/Control/PerformanceMonitoring/PerfMonComps/python
patch -b < $patch_dir/*.patch
