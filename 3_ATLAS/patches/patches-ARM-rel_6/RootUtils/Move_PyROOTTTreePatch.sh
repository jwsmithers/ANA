#!/bin/sh
cd $TopDir/../patches/patches-ARM-rel_6/RootUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-rel_6/Control/RootUtils/src/pyroot
mv PyROOTTTreePatch.cxx PyROOTTTreePatch.cxx~ 
#mv PyROOTTTreePatch.cxx~ PyROOTTTreePatch.cxx
