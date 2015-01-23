#!/bin/bash
cd $TopDir/../patches/patches-ARM-20.1.0/GeoModelKernel
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-20.1.0/DetectorDescription/GeoModel/GeoModelKernel/cmt
patch -b < $patch_dir/*.patch
