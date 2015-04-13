#!/bin/bash
cd $TopDir/../patches/patches-ARM-18.9.0/CxxUtils
patch_dir=`pwd`
cd $TopDir/AtlasCore/AtlasCore-18.9.0/Control/AthenaServices/src
patch -b < $patch_dir/FPEAudit_linux.patch
